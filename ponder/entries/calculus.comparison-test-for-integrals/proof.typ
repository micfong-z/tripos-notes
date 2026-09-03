Let $F(R) = integral_a^R f(x) dif x$; this is increasing since $f >= 0$, and bounded since

$
  0 <= F(R) <= integral_a^R g(x) dif x <= integral_a^oo g(x) dif x < oo.
$

Since $F$ is monotone and bounded, $L = sup_(R >= a) F(R)$ exists. By the definition of supremum, for every $epsilon > 0$ there is $R_0 in [a, oo)$ such that for $R >= R_0$,

$
  L - epsilon <= F(R_0) <= F(R) <= L,
$

hence, taking limits as $R -> oo$, $lim_(R->oo) F(R) = L$: the improper integral of $f$ converges to $L$.

For (2), since $f >= 0$, $lim_(R->oo) underbracket(integral_a^R f(x) dif x, F(R)) = +oo$ necessarily. Hence for every $L > 0$ there is $R$ such that $forall r >= R$, $F(r) > L$. But

$
  integral_a^r g(x) dif x >= F(R) > L,
$

so $integral_a^oo g(x) dif x$ diverges to $+oo$.
