
my $line1 = <STDIN>;
(my $a,my $b,my $c) = split(' ',$line1);
my $n = <STDIN>;
my @a1 = ( );
my @a2 = ( );

for(my $i=1;$i<=$n;$i++)
{
my $line = <STDIN>;
(my $costul,my $port)=split(' ',$line);
$a1[$i]=$costul;
$a2[$i]=$port;
}
my $u=0;
my $p=0;
my $up=0;
my $eq=0;
my $suma=0;
my $check;
foreach my $i (1 .. $n)
{
$check=0;
if($a2[$i] eq 'USB')
{
if($u < $a)
{
$u++;
$eq++;
$suma+=$a1[$i];
$check=1;

}
}
if($a2[$i] eq 'PS/2')
{
if($p < $b)
{
$p++;
$eq++;
$suma+=$a1[$i];
$check=1;
}
}
if($a==$u && $check==0 && $a2[$i] eq 'USB')
{
if($up<$c)
{
$up++;
$eq++;
$suma+=$a1[$i];
$check=1;
}
}
if($b==$p && $check==0 && $a2[$i] eq 'PS/2')
{
if($up<$c)
{ 
$up++;
$eq++;
$suma+=$a1[$i];
$check=1;
}
}
}
print "$eq $suma ";
print "\n";


