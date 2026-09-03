Let $h$ be the least positive linear combination of $a$ and $b$, that is, the smallest positive integer of the form $h = a x + b y$ for some $x, y in ZZ$. We verify the two conditions in the definition of the highest common factor and conclude $h = gcd(a, b)$.

To show (2), observe that given $d$ with $d divides a$ and $d divides b$, we have $d divides a x + b y$ for all $x, y in ZZ$; in particular $d divides h$.

To show (1), suppose that $h divides.not a$. Then we can write $a = q h + r$ for some $q, r in ZZ$ with $0 < r < h$. Hence
$ r = a - q h = a - q (x a + y b) $
is also a positive linear combination of $a$ and $b$, contradicting the minimality of $h$. Thus $h divides a$, and similarly $h divides b$.

This argument proves that $gcd(a, b)$ exists and is a linear combination of $a$ and $b$, but it gives no method to compute it.
