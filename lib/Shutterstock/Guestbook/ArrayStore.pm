package Shutterstock::Guestbook::ArrayStore;

use Moo;
use Class::Load 'load_class';

has _entry_class => (
  is => 'ro',
  default => sub {'Shutterstock::Guestbook::_Entry'},
  coerce => sub {load_class $_[0]; $_[0]},
);

has _entries => (
  is => 'rw',
  default => sub { +[] },
);

sub create_entry {
  my ($self, $name, $comment) = @_;
  $self->_entry_class
    ->new(name => $name, comment => $comment);
}

sub add_entry {
  my @comments = ((my $self = shift)
    ->entry_list, @_);
  $self->_entries(\@comments);
}

sub create_and_add_entry {
  my $comment = (my $self = shift)
    ->create_entry(@_);
  $self->add_entry($comment);
}

sub entry_list { @{shift->_entries} }

1;
