package Ubisoft::Schema::Result::Accounts;
use base qw/DBIx::Class::Core/;

__PACKAGE__ -> table('accounts');

__PACKAGE__ -> add_columns(

account_id => {
    data_type => 'integer',
is_auto_increment => 1,
},

account_type => {
    data_type => 'text',
},

description => {
    data_type => 'text',
},

username => {
    data_type => 'text',
},
user_id => {
    data_type => 'text',
},

);

__PACKAGE__ -> set_primary_key ('account_id');
#__PACKAGE__ -> belongs_to ( users => 'Ubisoft::Schema::Result::Users','id');

1;
