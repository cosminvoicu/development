package Ubisoft::Schema::Result::Users;
use base qw/DBIx::Class::Core/;

# Associated table in database
__PACKAGE__->table('users');

# Column definition
__PACKAGE__->add_columns(

     id => {
         data_type => 'integer',
         is_auto_increment => 1,
     },

     username => {
         data_type => 'text',
     },

     password => {
         data_type => 'text',
     },

     
 );

 # Tell DBIC that 'id' is the primary key
 __PACKAGE__->set_primary_key('id');
#__PACKAGE__->add_unique_constraint('uniq_username' => ['username']);
