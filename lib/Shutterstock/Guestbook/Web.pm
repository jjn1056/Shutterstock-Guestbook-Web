package Shutterstock::Guestbook::Web;

use Web::Simple;
use Shutterstock::Guestbook::Page;
use Shutterstock::Guestbook::MessageLog;
use Shutterstock::Guestbook::Store::Memory;
use HTTP::Throwable::Factory 'http_exception';

sub default_config {
  template => 'share/html/page.html',
  content_file => 'README.mkdn',
}

has message_log => (
  is => 'ro',
  default => sub {
    Shutterstock::Guestbook::MessageLog->new(
      store => Shutterstock::Guestbook::Store::Memory->new,
    )
  },
);

has page => (
  is => 'ro',
  lazy => 1,
  builder => '_build_page',
);

sub _build_page {
  Shutterstock::Guestbook::Page->new(
    template => $_[0]->config->{template},
    content_file => $_[0]->config->{content_file},
    message_log => $_[0]->message_log,
  );
}

sub dispatch_request {
  sub(/) {
    sub(GET) {
      my $fh = shift->page->render_to_fh;
      [200, ['Content-type'=>'text/html'], $fh];
    },
    sub (POST + %name=&comment=) {
      shift->message_log->create_and_add_entry(@_);
      http_exception(Found => { location => '/' });
    }
  }
}

__PACKAGE__->run_if_script;

