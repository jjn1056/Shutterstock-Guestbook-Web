package Shutterstock::Guestbook::MessageLog;

use Moo;
use Shutterstock::Guestbook::_Entry;

has entries => (
  is => 'rw',
  default => sub { +[] },
);

sub create_entry {
  my ($self, $name, $comment) = @_;
  Shutterstock::Guestbook::_Entry->
    new(name => $name, comment => $comment);
}

sub add_entry {
  my ($self, $comment) = @_;
  my @comments = ($comment, $self->entry_list);
  $self->entries(\@comments);
}

sub create_and_add_entry {
  my $comment = (my $self = shift)
    ->create_entry(@_);
  $self->add_entry($comment);
}

sub entry_list { @{shift->entries} }

1;
