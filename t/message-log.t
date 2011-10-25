use Test::Most;
use Shutterstock::Guestbook::MessageLog;

ok my $ml = Shutterstock::Guestbook::MessageLog->new,
  'Made a message log';

done_testing;
