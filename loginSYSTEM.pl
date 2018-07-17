use strict;
use warnings;
print "Introdu nume utilizator: "; my $u =<STDIN>; 
print "Introdu parola: "; my $p =<STDIN>;

my $filename = '/Users/voicucosmin/Desktop/perl/logins.txt';
open(my $linie,'<',$filename)
   or die "Fisierul nu a putut fi deschis '$filename' $!";
while(my $linia1=<$linie>)
{
chomp $linia1;
$linia1 =~ tr/[/ /;
$linia1 =~ tr/]/ /;
   
my ($user,$parola) = split(' ',$linia1);

if($u =~ $user and $p =~ $parola)
{
    print "Poti utiliza functionalitatea 2\n";
    last;
}
else
{
    print "Ai intordus un nume de utlizator sau parola gresita\n";
}
}
    

# ^[a-zA-Z][a-zA-Z0-9_]*$                     #username
# (?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$  #parola

