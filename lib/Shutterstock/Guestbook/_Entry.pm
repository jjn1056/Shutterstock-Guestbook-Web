package Shutterstock::Guestbook::_Entry;

use Moo;

has name => (
  is => 'ro',
  required => 1,
);

has comment => (
  is => 'ro',
  required => 1,
);

has time => (
  is => 'ro',
  default => sub { scalar localtime },
);

1;
