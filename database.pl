use DBI;
use DBD::Pg;
use feature 'say';
#database connection variables
$database="test";
$user="postgres";
$password="test";
$host='127.0.0.1';

#other variables
my $wrong_pass =0;
my $parola_gresita=0;
sub new_user
{
    
while($wrong_pass==0)
{
    print "Desired username: "; my $n_username = <STDIN>; #username from keyboard
    print "Password: "; my $n_password =<STDIN>; # password from keyboard
    my $id = 0;
    # Connect to database
    my $dbh = DBI->connect("dbi:Pg:dbname=$database", $user, $password);
    #check the max of id in order to not have unique constrains errors.
    #run sql statement
    my $sth = $dbh -> prepare('select max(id) from users_tbl')
    or die "Couldn't prepare statement: $DBI::errstr; stopped";
    
    $sth->execute() or die "Couldn't execute statement: $DBI::errstr; stop
    +ped";
    my $max_id = $sth->fetchrow_array();
        $max_id =~ s/^\s+|\s+$//g;
        #  max id + 1
        $id=$max_id + 1;
    
    #check if te username and the password are eligible to be inserted(the rules was defined by us)
     if($n_username =~ /^[a-zA-Z][a-zA-Z0-9_]*$/ and $n_password =~ /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$/ )
    {
        #insert into database.
        $dbh -> do('INSERT INTO USERS_TBL (id,user_id,pswd) values (?,?,?)',undef, $id,$n_username,$n_password);
        $wrong_pass=1;
    }
    else
    {
        print "Warning: Username or password do not correspound with the standards. Please try again.\n";
    }

}
}
sub login
{
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
            $parola_gresita=0;
            new_user();
        }
        else
        {
           $parola_gresita=1;
        }
    #print "ID: $row[0]\nUSERNAME: $row[1]\nPASSWORD: $row[2]\n";
        @row=$sth -> fetchrow_array();
        }while(@row);
    if($parola_gresita==1)
    {
        print "Wrong username or password.\n";
    }
# Disconnect from the database
$dbh->disconnect();
}
login();

 


