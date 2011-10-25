package Shutterstock::Guestbook::Store;

use Moo::Role;

requires 'create_and_add_entry', 'map_entries';

1;
