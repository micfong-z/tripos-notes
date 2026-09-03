By the Extreme Value Theorem, $exists M_n = sup_(x in [0, n]) abs(f^((n)) (a+x)) < oo$, so

$
  abs(R_(n, f, a)(h)) <= (h^n)/(n!) M_n,
$

hence $R_(n, f, a)(h) -> 0$ as $h->0$ for fixed $n$. If moreover $sup_(n>=0) M_n = M < oo$, then $abs(R_(n, f, a)(h)) <= (M h^n)/(n!) -> 0$ as $n->oo$ for all $abs(h) < 1$, which would mean $f$ is analytic at $a$.

The theorem generalises to $f: X subset.eq CC -> CC$ where $X$ contains the line segment $[a, a+h]$. In $CC$, differentiability implies smoothness and then analyticity, with estimates on $M_n$ that give convergence of $R_(n, f, a)(h)$ to $0$ as $n->oo$.

The integral form also recovers the other remainder forms via the Cauchy Mean Value Theorem for integrals:

+ Lagrange form — taking $g(t) = (1-t)^(n-1)$, there is $theta in (0, 1)$ with

$
  R_(n, f, a)(h) = h^(n)/(n-1)! f^((n)) (a + theta h) integral_0^1 (1-t)^(n-1) dif t = (h^n)/(n!) f^((n)) (a + theta h);
$

+ Cauchy form — taking $g = 1$, there is $theta in (0, 1)$ with

$
  R_(n, f, a)(h) = h^(n)/(n-1)! (1-theta)^(n-1) f^((n)) (a+theta h) integral_0^1 dif t = (h^n)/(n!) (1-theta)^(n-1) f^((n)) (a + theta h).
$
