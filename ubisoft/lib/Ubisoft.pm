package Ubisoft;
use Mojo::Base 'Mojolicious';
use  Ubisoft::Schema;

# This method will run once at server start
sub startup {
    my $self = shift;
    

  # Load configuration from hash returned by "my_app.conf"
    my $config = $self->plugin('Config');
    
  # key used for new sesions and validation
    $self -> secrets(['This secret is used for new sessionsLeYTmFPhw3q',
    'This secret is used _only_ for validation QrPTZhWJmqCjyGZmguK']);
    
  #the cookie name
    $self->app->sessions->cookie_name('ubisoft');
    
  #expiration reduced to the 10 min
    $self->app->sessions->default_expiration('600');

  # Router
  my $r = $self->routes;

  # Normal route to controller
    $r->get('/')->to('home#welcome');
    $r->get('/login')->name('login_form')->to(template => 'login/login_form');
    $r->post('/login')->name('do_login')->to('Login#on_user_login');
    $r->get('/sign_up')->to(template => 'login/sign_up');
    $r->post('/sign_up')->name('do_sign_up')->to('Login#sign_up');
    $r->post('/login')->to('Login#on_user_login');
    my $authorized = $r->under('/admin')->to('Login#is_logged_in');
    $authorized->get('/')->name('restricted_area')->to(template => 'admin/overview');
    
    # Logout route
        $r->route('/logout')->name('do_logout')->to(cb => sub {
        my $self = shift;
        
        # Expire the session (deleted upon next request)
        $self->session(expires => 1);
        
        # Go back to home
        $self->redirect_to('home');
    });
}

1;
