use feature 'say';
use feature 'switch';
print "Hello world\n";

my ($first_variable,$first_integer) = ('Test' , 12);

say ($first_variable,$first_integer);
print "\n";

my $text_nou = <<'END';

Acesta este un text pe care doresc sa vil afisez si voua
Imi place tare mult Perl este foarte apropiat
de limbajul natural.
END

say &text_nou;