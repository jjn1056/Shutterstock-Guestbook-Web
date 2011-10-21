use Test::Most tests => 4;

BEGIN {
  use_ok 'Shutterstock::Guestbook::Web';
  use_ok 'Shutterstock::Guestbook::MessageLog';
  use_ok 'Shutterstock::Guestbook::Page';
  use_ok 'Shutterstock::Guestbook::Store::Memory';
}
