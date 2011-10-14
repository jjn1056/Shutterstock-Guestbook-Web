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
    my $entry = $_;
    sub {
      $_->replace_content('.name' => $entry->name)
        ->replace_content('.comment' => $entry->comment)
        ->replace_content('.time' => $entry->time);
    }
  } (my $self = shift)->message_log->entry_list;

  $self
    ->zoom
    ->repeat_content('#comments' => \@transforms)
    ->to_fh;
}

1;
