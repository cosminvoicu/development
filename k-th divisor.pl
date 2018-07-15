
use feature 'say';
$line =<STDIN>;
chomp $line;
($n,$k)=split / +/, $line;
my $contor = 0;
@array =(1,2,3);
foreach my $i (1..$n)
{
if($n%$i == 0)
{
$contor++;
$array[$contor]=$i;
}
}
if($contor<=$k)
{
print "-1\n";
}
else
{
$contor-=1;
print "$array[$contor]\n";
}