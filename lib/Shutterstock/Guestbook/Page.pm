package Shutterstock::Guestbook::Page;

use Moo;
use HTML::Zoom;

has message_log => (
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
  my @transforms = map {
    my ($name, $comment, $time) = ($_->name, $_->comment, $_->time);
    sub {
      $_->replace_content('.name' => $name)
        ->replace_content('.comment' => $comment)
        ->replace_content('.time' => $time);
    }
  } (my $self = shift)->message_log->entry_list;

  $self
    ->zoom
    ->repeat_content('#comments' => \@transforms)
    ->to_fh;
}

1;
