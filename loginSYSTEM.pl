use strict;
use warnings;
print "Introdu nume utilizator: "; my $u =<STDIN>; print "\n";
print "Introdu parola: "; my $p =<STDIN>; print "\n";

my $filename = '/Users/voicucosmin/Desktop/perl/logins.txt';
open(my $linie,'<',$filename)
   or die "Fisierul nu a putut fi deschis '$filename' $!";
my $linia1 = <$linie>;
my $linie2 = <$linie>;
$linia1 =~ tr/[/ /;
$linia1 =~ tr/]/ /;
my ($user,$parola) = split(' ',$linia1);

if($u =~ $user and $p =~ $parola)
{
    print "Poti utiliza functionalitatea 2\n";
}
else
{
    print "Ai intordus un nume de utlizator sau parola gresita\n";
}

    


