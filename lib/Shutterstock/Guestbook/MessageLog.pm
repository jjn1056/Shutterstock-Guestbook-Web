package Shutterstock::Guestbook::MessageLog;

use Moo;

has store => (
  is => 'ro',
  handles => [ qw(create_and_add_entry map_entries) ],
);



1;


