package Ubisoft::Schema::Result::Users;
use base qw/DBIx::Class::Core/;

__PACKAGE__ -> table('users');

__PACKAGE__ -> add_columns(

id => {
    data_type => 'integer',
    is_auto_increment => 1,
},

username => {
    data_type => 'text',
},

password => {
    data_type => 'text'
},

);

__PACKAGE__ -> set_primary_key('id');

1;
