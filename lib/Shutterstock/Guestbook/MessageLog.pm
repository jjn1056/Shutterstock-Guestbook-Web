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
  init_arg => undef,
  lazy => 1,
  builder => '_build_store',
);

sub _build_store { shift->store_class->new }
sub create_and_add_entry { shift->store->create_and_add_entry(@_) }

sub map_entries {
  my ($self, $code) = @_;
  map {
    $code->($_->name, $_->comment, $_->time);
  } $self->store->entry_list;
}

1;
