
my $linie= <STDIN>;
my $lungime = length($linie);
my @values = split(//, $linie);
my $B=0;
my $a=0;
my $b=0;
my $u=0;
my $l=0;
my $r=0;
my $s=0;
foreach my $i (0 .. $lungime-1)
{
    if($values[$i] eq 'B')
    {
        $B++;
    }
    if($values[$i] eq 'a')
    {
        $a++;
    }
    if($values[$i] eq 'b')
    {
        $b++;
    }
    if($values[$i] eq 'u')
    {
        $u++;
    }
    if($values[$i] eq 'l')
    {
        $l++;
    }
    if($values[$i] eq 'r')
    {
        $r++;
    }
    if($values[$i] eq 's')
    {
        $s++;
    }

}
while($B>0)
{
    if($b>=$B&&$l>=$B&&$r>=$B&&$s>=$B&&$a>=(2*$B)&&$u>=(2*$B))
    {
        last;
    }
    $B--;
}
print $B,"\n";
