package Shutterstock::Guestbook::Web;

use Web::Simple;
use HTML::Zoom;
use HTTP::Throwable::Factory 'http_exception';
use Shutterstock::Guestbook::Log;

sub default_config { template => 'share/html/page.html' }

has log => (
  is => 'ro',
  default => sub { Shutterstock::Guestbook::Log->new },
);

has zoom => (
  is => 'ro',
  default => sub { HTML::Zoom->from_file(shift->config->{template}) },
);

sub dispatch_request {
  sub (GET) {
    my $fh = shift->build_page_fh;
    [200, ['Content-type'=>'text/html'], $fh];
  },
  sub (POST + %name=&comment=) {
    shift->log->create_and_add_entry(@_);
    http_exception(Found => { location => '/' });
  },
}

sub build_page_fh {
  my $self = shift;
  my @transforms = map {
    my $log = $_;
    sub {
      $_->replace_content('.name' => $log->name)
        ->replace_content('.comment' => $log->comment)
        ->replace_content('.time' => $log->time);
    }
  } $self->log->entry_list;

  $self
    ->zoom
    ->repeat_content('#comments' => \@transforms)
    ->to_fh;
}

__PACKAGE__->run_if_script;
