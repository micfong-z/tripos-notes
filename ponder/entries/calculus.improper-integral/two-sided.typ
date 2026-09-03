The two-sided improper integral is defined by splitting at an interior point, not by a symmetric limit:

$
  integral_(-oo)^oo f(x) dif x = lim_(R->oo) integral_(-R)^a f(x) dif x + lim_(r->oo) integral_a^r f(x) dif x,
$

which is in general different from $lim_(R->oo) [integral_(-R)^R f(x) dif x]$.

The same caution applies at an interior singularity:

$
  integral_B^b f(x) dif x & = integral_B^a f(x) dif x + integral_a^b f(x) dif x \
                          & = lim_(delta->0) integral_B^(a-delta) f(x) dif x + lim_(sigma->0) integral_(a+sigma)^b f(x) dif x,
$

and this is not equal to $lim_(delta->0) [integral_B^(a-delta) f(x) dif x + integral_(a+delta)^b f(x) dif x]$, as seen by taking $f(x) = (1)/(x)$.
