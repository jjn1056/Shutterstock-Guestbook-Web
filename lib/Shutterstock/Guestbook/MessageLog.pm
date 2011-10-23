package Shutterstock::Guestbook::MessageLog;

use Moo;
use Class::Load 'load_class';

sub DEFAULT_STORE_CLASS { 'Shutterstock::Guestbook::Store::Memory' }

has store_class => (
  is => 'ro',
  default => sub { DEFAULT_STORE_CLASS },
  coerce => sub { load_class $_[0]; $_[0] },
);

has _store => (
  is => 'ro',
  lazy => 1,
  builder => '_build_store',
  handles => [ qw(create_and_add_entry map_entries) ],
);

sub _build_store { shift->store_class->new }

1;
