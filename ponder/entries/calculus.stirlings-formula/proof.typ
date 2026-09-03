For twice differentiable $f: RR -> RR$ and $a < b$, integration by parts twice gives

$
  integral_a^b f(x) dif x = (f(a) + f(b))/2 (b - a) - 1/2 integral_a^b (x - a)(b - x) f''(x) dif x.
$

Taking $f(x) = log x$, $a = k$, $b = k + 1$ and summing over $k$,

$
  integral_1^n log x dif x = (log(n-1)! + log(n!))/2 + sum_(k=1)^(n-1) a_k,
$

where

$
  a_k = 1/2 integral_0^1 (x(1-x))/((x+k)^2) dif x <= 1/(12 k^2).
$

So the series $sum_(k=1)^oo a_k$ converges, and

$
  n! = A dot n^n dot ee^(-n) dot sqrt(n)
$

for the constant $A = exp(1 - sum_(k=1)^oo a_k)$.

It remains to show that $A = sqrt(2 ppi)$. The Wallis integrals

$
  I_n = integral_0^(ppi/2) (cos theta)^n dif theta
$

satisfy $I_n = ((n-1)/n) I_(n-2)$ by integration by parts, so

$
  I_(2n) = ppi/2 dot 2^(-2n) binom(2n, n), quad I_(2n+1) = 1/(2n+1) (2^(-2n) binom(2n, n))^(-1).
$

Since $(I_n)/(I_(n-2)) -> 1$ and $I_n$ is decreasing in $n$, sandwiching gives $(I_(2n))/(I_(2n+1)) -> 1$, hence

$
  (2^(-2n) binom(2n, n))^2 ~ 1/(ppi n) quad "as" quad n -> oo.
$

On the other hand, Stirling's asymptotic form with the constant $A$ gives $2^(-2n) binom(2n, n) ~ sqrt(2)/(A sqrt(n))$. Comparing the two forces $A = sqrt(2 ppi)$.
