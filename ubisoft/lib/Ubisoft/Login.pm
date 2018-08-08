
package Ubisoft::Login;
use Mojo::Base 'Mojolicious::Controller';
use DBIx::Simple;
use Mojo::Pg;

my $user_wrong;

#database connection variables
my $database="test";
my $user_db="postgres";
my $password_db="test";
my $host='127.0.0.1';
#connect to database
my $db = DBIx::Simple->connect('dbi:Pg:dbname="test"',$user_db,$password_db)
or die DBIx::Simple->error;


sub is_logged_in {
    
    my $self = shift;
    
    return 1 if($self->session('logged_in'));
    
    $self->render(
    text => "Access Forbiden", status => 403
    );
    
sub on_logout
    {
        my $self = shift;
        
        $self -> session(expires => 1);
        
        return $self -> render('home/welcome');
        
    
    }

sub user_exists {
    my ($username, $password) = @_;
    chomp $username;
    chomp $password;
    my $check = $db -> query("SELECT 1 FROM USERS_TBL WHERE user_id like ('$username%') and pswd like ('$password%')");
    $check = $check->text;
    
    if($check == 1)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}


# Called upon form submit
sub on_user_login {
    my $self = shift;
    
    # Grab the request parameters
    my $username = $self->param('username');
    my $password = $self->param('password');
    
    if(user_exists($username,$password))
    {
        $self->session(logged_in => 1);
        $self->session(username => $username);
        
        $self -> redirect_to('restricted_area');
    }
    else
    {
        $self->render(text => 'Wrong username/password' , status => 403);
    }

}
sub sign_up {
    
    my $self = shift;
    my $username = $self->param('username');
    my $password = $self->param('password');
    chomp $username;
    chomp $password;
    my $max_id = $db -> query('SELECT MAX(ID) FROM USERS_TBL');
    $max_id = ($max_id -> text) + 1;
    if ($username =~ /^[a-zA-Z][a-zA-Z0-9_]*$/ and $password =~ /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$/)
    {
    
        $db -> insert ('users_tbl' , {id => $max_id , user_id => $username , pswd => $password});
     
    }
    else
    {
      $self->stash(user_wrong => 'wrong');
    }
   
    
    #$self->redirect_to('restricted_area');
    
    
}

    sub add_account {
        
        my $self = shift;
        
        #get the username and the account from the template
        my $username  = $self -> param('username');
        my $account = $self -> param('account');
        
        #calculate the max of ID and add 1 to it.
        my $max_id = $db -> query('SELECT MAX(ID) FROM ACCOUNT');
        $max_id = ($max_id -> text) + 1;
        
        #insert into database
        
        
        $db -> insert('account', { id => $max_id , account_id => $username , account_name => $account} );
        
        #select the accounts added and put it into stash
        my $result = $db -> select ('account' , [ 'account_id' , 'account_name' ]);
        
        $result = $result -> text;
        
        $self -> stash('accounts' => $result);
        
        
    }
    
}

1;
