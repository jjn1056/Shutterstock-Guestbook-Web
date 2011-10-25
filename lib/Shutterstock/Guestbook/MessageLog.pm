package Shutterstock::Guestbook::MessageLog;

use Moo;
use Class::Load 'load_class';
use Role::Tiny ();

sub DEFAULT_STORE_CLASS { 'Shutterstock::Guestbook::Store::Memory' }

has store_class => (
  is => 'ro',
  isa => sub {
    Role::Tiny::does_role($_[0], 'Shutterstock::Guestbook::Store')
    || die "$_[0] does not have the ::Store role";
  },
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


