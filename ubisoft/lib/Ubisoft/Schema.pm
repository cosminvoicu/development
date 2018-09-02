package Ubisoft::Schema;

use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_namespaces();

sub getConnection{
    
    my $self = shift;
    
    my $connection = $self -> connection('dbi:Pg:dbname=test;host=127.0.0.1', 'postgres', 'test', {AutoCommit => 1});
    $connection -> deploy();
    return $connection;
}

1;
