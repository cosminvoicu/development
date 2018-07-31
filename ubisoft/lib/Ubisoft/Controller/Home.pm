package Ubisoft::Controller::Home;
use Mojo::Base 'Mojolicious::Controller';

sub welcome {
    my $self = shift;
    
    $self -> render('home/welcome');
    
}
