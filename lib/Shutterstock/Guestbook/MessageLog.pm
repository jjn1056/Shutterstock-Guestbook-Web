package Shutterstock::Guestbook::MessageLog;

use Moo;
use Class::Load 'load_class';

has store_class => (
  is => 'ro',
  default => sub {'Shutterstock::Guestbook::ArrayStore'},
  coerce => sub {load_class $_[0]; $_[0]},
);

has store => (
  is => 'ro',
  lazy => 1,
  builder => '_build_store',
);

sub _build_store {
  shift->store_class->new;
}

sub create_entry { shift->store->create_entry(@_) }
sub add_entry { shift->store->add_entry(@_) }
sub create_and_add_entry { shift->store->create_and_add_entry(@_) }
sub entry_list { shift->store->entry_list }

1;
