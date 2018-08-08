
use DBIx::Simple;
use Mojo::Pg;
use Data::Dumper;
my $user_wrong;

#database connection variables
my $database="test";
my $user_db="postgres";
my $password_db="test";
my $host='127.0.0.1';
#connect to database
my $db = DBIx::Simple->connect('dbi:Pg:dbname="test"',$user_db,$password_db)
or die DBIx::Simple->error;


my $result = $db -> select ('account' , [ 'account_id' , 'account_name' ]);
$result = $result -> text;

print $result;

