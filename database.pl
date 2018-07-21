use DBI;
use DBD::Pg;
use feature 'say';
$database="test";
$user="postgres";
$password="test";
$host='127.0.0.1';
# Connect to database
my $dbh = DBI->connect("dbi:Pg:dbname=$database", $user, $password);

#run sql statement
my $sth = $dbh -> prepare('SELECT * FROM USERS_TBL')
or die "Couldn't prepare statement: $DBI::errstr; stopped";

$sth->execute() or die "Couldn't execute statement: $DBI::errstr; stop
+ped";
print "Introdu nume utilizator: "; my $u =<STDIN>;
print "Introdu parola: "; my $p =<STDIN>;
my @row = $sth->fetchrow_array();
do
{
    $row[1] =~ s/^\s+|\s+$//g;
    $row[2] =~ s/^\s+|\s+$//g;
    
    if($u =~ $row[1] and $p =~ $row[2])
    {
        print "User si parola corecta\n";
        
    }
    #print "ID: $row[0]\nUSERNAME: $row[1]\nPASSWORD: $row[2]\n";
    @row=$sth -> fetchrow_array();
}while(@row);

# Disconnect from the database
$dbh->disconnect();

 


