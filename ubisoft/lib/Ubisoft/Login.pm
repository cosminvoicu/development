
package Ubisoft::Login;
use Mojo::Base 'Mojolicious::Controller';
use Ubisoft::Schema;
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

sub user_exists {
    my ($username, $password) = @_;
    
    return ($username eq 'foo' && $password eq 'bar');
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
    
    if ($username =~ /^[a-zA-Z][a-zA-Z0-9_]*$/ and $password =~ /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$/)
    {
    
        $db -> insert ('users_tbl' , {id => 14 , user_id => $username , pswd => $password});
     
    
    }
    else
    {
      $self->stash(user_wrong => 'wrong');
    }
   
    
    #$self->redirect_to('restricted_area');
    
    
}


    
}

1;
