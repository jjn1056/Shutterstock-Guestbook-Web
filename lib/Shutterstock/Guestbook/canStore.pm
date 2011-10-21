package Shutterstock::Guestbook::canStore;

use Moo::Role;

requires 'create_and_add_entry', 'entry_list', 'map_entries';

1;
