use utf8;
package Ubisoft::Schema;

use strict;
use warnings;

use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_namespaces;


sub getConnection {
    my $self = shift;
    return $self->connection('dbi:SQLite:ubisoft.db');
}
1;
