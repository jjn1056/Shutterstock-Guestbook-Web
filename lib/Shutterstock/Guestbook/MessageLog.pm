package Shutterstock::Guestbook::MessageLog;

use Moo;
use Class::Load 'load_class';

has store_class => (
  is => 'ro',
  isa => sub { $_[0]->does('Shutterstock::Guestbook::canStore') },
  default => sub { 'Shutterstock::Guestbook::Store::Memory' },
  coerce => sub { load_class $_[0]; $_[0] },
);

has _store => (
  is => 'ro',
  init_arg => undef,
  lazy => 1,
  builder => '_build_store',
);

sub _build_store { shift->store_class->new }
sub create_and_add_entry { shift->_store->create_and_add_entry(@_) }
sub map_entries { shift->_store->map_entries(@_) }

1;
