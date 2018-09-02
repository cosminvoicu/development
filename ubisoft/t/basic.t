use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('Ubisoft');
$t->get_ok('/')->status_is(200)->content_like(qr/Mojolicious/i);

$t -> post_ok('/login' => form => {
username => 'User' , password => 'User1234'

}) -> status_is(302);

done_testing();
