use strict;
use warnings;
my $u_p_corect = 1;
my $pas2 =0;
my $parola_gresita=0;

sub login
{
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
            $pas2=1;
            last;
        }
        
    }
    if($pas2==0)
    {
        print "Ai intordus un nume de utlizator sau parola gresita\n";
    }
    
}
sub new_user
{
    if($pas2==1)
    {
        while($u_p_corect == 1)
        {
            print "Introdu un nou nume de utilizator: "; my $new_u = <STDIN>;
            print "Introdu o noua parola: "; my $new_p = <STDIN>;
            chomp $new_u;
            chomp $new_p;
            if($new_u =~ /^[a-zA-Z][a-zA-Z0-9_]*$/ and $new_p =~ /(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$/ )
            {
                my $fisier = '/Users/voicucosmin/Desktop/perl/logins.txt';
                open(my $scrie_linie,'>>',$fisier) or die "Fisierul nu a putut fi deschis '$fisier' $!";
                print $scrie_linie "[$new_u][$new_p]\n";
                close $scrie_linie;
                print "gata\n";
                $u_p_corect=0;
            }
            else
            {
                print "Parola nu corespunde incearca din nou \n";
            }
        }
    }
}



login();
new_user();
print "LOGOUT Y/N: "; my $logout = <STDIN>;

if($logout =~ /Y/)
{
    print "Do you want to log in with another user Y/N: "; my $logare = <STDIN>;
        if($logare =~ /Y/)
        {
            login();
        }
    else
    {
        last
    }
}
else
{
    print "You are login with user: .. and password .. \n";
}

# ^[a-zA-Z][a-zA-Z0-9_]*$                     #username
# (?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{6,}$  #parola

