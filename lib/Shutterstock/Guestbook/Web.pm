package Shutterstock::Guestbook::Web;

use Web::Simple;
use HTML::Zoom;

sub default_config { template => 'share/html/page.html' }

has log => (
  is => 'rw',
  default => sub { +[] },
);

has zoom => (
  is => 'ro',
  default => sub { HTML::Zoom->from_file(shift->config->{template}) },
);

sub dispatch_request {
  sub (GET) {
    my $page = shift->build_page;
    [200, ['Content-type'=>'text/html'], $page];
  },
  sub (POST + %name=&comment=) {
    shift->add_to_log(@_);
    [302, [Location=>'/'],
    ['The resource is in a different location']];
  },
}

sub build_page {
  my $self = shift;
  my @transforms = map {
    my $log = $_;
    sub {
      $_->replace_content('.name' => $log->{name})
        ->replace_content('.comment' => $log->{comment})
        ->replace_content('.time' => $log->{time});
    }
  } @{$self->log};

  $self
    ->zoom
    ->repeat_content('#comments' => \@transforms)
    ->to_fh;
}

sub add_to_log {
  my ($self, $name, $comment) = @_;
  $self->log([
    { name => $name, comment => $comment, time => scalar(localtime) },
    @{$self->log},
  ]);
}

__PACKAGE__->run_if_script;
