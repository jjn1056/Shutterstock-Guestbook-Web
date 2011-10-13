package Shutterstock::Guestbook::Page;

use Moo;
use HTML::Zoom;

has log => (
  is => 'ro',
  required => 1,
);

has template => (
  is => 'ro',
  required => 1,
); 

has zoom => (
  is => 'ro',
  default => sub { HTML::Zoom->from_file(shift->template) },
);

sub render_to_fh {
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

1;
