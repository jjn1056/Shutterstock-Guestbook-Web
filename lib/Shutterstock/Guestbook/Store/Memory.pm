package Shutterstock::Guestbook::Store::Memory;

use Moo;
use Class::Load 'load_class';

with 'Shutterstock::Guestbook::Store';

sub DEFAULT_ENTRY_CLASS { 'Shutterstock::Guestbook::Store::_Entry' }

has _entry_class => (
  is => 'ro',
  default => sub { DEFAULT_ENTRY_CLASS },
  coerce => sub { load_class $_[0]; $_[0] },
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

sub map_entries {
  my ($self, $code) = @_;
  map {
    $code->($_->as_entry_hash);
  } $self->entry_list;
}


1;
