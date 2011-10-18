use Test::Most;
use Plack::Test::Agent;
use Shutterstock::Guestbook::Web;

ok my $app = Shutterstock::Guestbook::Web->to_psgi_app;
ok my $ua = Plack::Test::Agent->new( app => $app );

ok $ua->get('/')->is_success;
ok $ua->get('/notnot')->is_error;
ok ((my $res = $ua->post('/', [name=>'John', comment=>'awesome site']))->is_redirect);
is $res->header('location'), '/';

done_testing;
