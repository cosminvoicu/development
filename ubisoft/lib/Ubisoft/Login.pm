
package Ubisoft::Login;
use Mojo::Base 'Mojolicious::Controller';
use DBIx::Simple;
use Mojo::Pg;
use Ubisoft::Schema;


my $user_wrong;
my $schema = Ubisoft::Schema -> getConnection();
my $usersResultSet = $schema -> resultset('Users');
my $accountResultSet = $schema -> resultset('Accounts');


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
    my $check = $usersResultSet -> search({username => $username, password => $password}) -> count;
    
    if($check == 1 )
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
        $self->render('login/login_form',
                        error => 'User or password wrong',
                        status => 403);
    }

}
sub sign_up {
    
    my $self = shift;
    my $username = $self->param('username');
    my $password = $self->param('password');
    chomp $username;
    chomp $password;
   
    if ($username =~ /^[a-zA-Z][a-zA-Z0-9_]*$/ and $password =~ /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$/)
    {
    
        $usersResultSet -> create({ username => $username , password => $password});
     
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
        my $username  = $self -> session('username');
        my $username_account = $self -> param('username_account');
        my $account_type = $self -> param('account_type');
        my $description = $self -> param ('description');
        
        
        $accountResultSet -> create( { account_type => $account_type,description => $description ,username => $username_account , user_id => $username });
        
        my @accounts = find_accounts($username);
        
        return $self -> render('admin/overview', accounts => \@accounts );
        
    }
    
    sub find_accounts {
        my $username = shift;
        return $accountResultSet -> search( { user_id => $username }) ->all;
        
        
        
     }
    
    sub print_accounts {
        
        my $self = shift;
        
        my $username = $self -> session('username');
        
        my @accounts = find_accounts($username);
        
        return $self -> render('admin/overview', accounts => \@accounts );
        
    }
    
    sub delete_account{
        
        my $self = shift;
        
        my $id = $self -> param('id');
        $accountResultSet-> find($id) -> delete;
        
        my $username = $self -> session('username');
        
        my @accounts = find_accounts($username);
        
        return $self -> render('admin/overview', accounts => \@accounts );
    }
    
    
}

1;
