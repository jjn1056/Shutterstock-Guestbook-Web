package Shutterstock::Guestbook::Page;

use Moo;
use HTML::Zoom;
use Text::Markdown 'markdown';
use IO::All;

has message_log => (
  is => 'ro',
  required => 1,
);

has template => (
  is => 'ro',
  required => 1,
); 

has content_file => (
  is => 'ro',
  required => 1,
);

has content_html => (
  is => 'ro',
  default => sub { markdown io(shift->content_file)->all } 
);

has zoom => (
  is => 'ro',
  default => sub {
    HTML::Zoom
      ->from_file($_[0]->template)
      ->replace_content('#main-content' => \$_[0]->content_html)
  },
);

sub render_to_fh {
  my @transforms = map {
    my ($name, $comment, $time) = ($_->name, $_->comment, $_->time);
    sub {
      $_->replace_content('.name' => $name)
        ->replace_content('.comment' => $comment)
        ->replace_content('.time' => $time);
    }
  } ((my $self = shift)->message_log->entry_list);

  $self
    ->zoom
    ->repeat_content('#comments' => \@transforms)
    ->to_fh;
}

1;
