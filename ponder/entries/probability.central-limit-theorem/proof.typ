Standardise first: $Y_i = (X_i - mu)/sigma$ has $EE[Y_i] = 0$ and $"Var"(Y_i) = 1$, and $(S_n - n mu)/(sigma sqrt(n)) = (Y_1 + ... + Y_n)/(sqrt(n))$, so it is enough to treat i.i.d. summands of mean $0$ and variance $1$.

Assume $EE[ee^(delta X_1)] + EE[-ee^(delta X_1)] < oo$ for some $delta > 0$ and write $m(theta) = EE[ee^(theta X_1)]$. By the #ponder("probability.mgf-continuity-property")[continuity property for MGFs] it suffices to show
$
  EE[ee^(theta S_n \/ sqrt(n))] -> EE[ee^(theta Z)] = exp(theta^2/2) quad "for every" theta in RR.
$
Independence factorises the transform, $EE[ee^(theta S_n \/ sqrt(n))] = (m(theta \/ sqrt(n)))^n$, and
$
  m(theta \/ sqrt(n)) = 1 + theta^2/(2 n) + EE[sum_(k >= 3) (theta X_1)^k/((sqrt(n))^k k!)].
$
The tail satisfies $abs(EE[sum_(k >= 3) (theta X_1)^k/(k!)]) = o(abs(theta)^2)$ as $theta -> 0$: for $abs(theta) < delta \/ 2$ it is bounded using $abs(theta X_1)^3 <= C abs(theta)^3 ee^(delta abs(X_1) \/ 2)$ by a constant multiple of $abs(theta)^3 EE[ee^(delta abs(X_1))] < oo$. Hence
$
  m(theta \/ sqrt(n)) = 1 + theta^2/(2 n) + o(theta^2 \/ n)
  quad "and" quad
  (m(theta \/ sqrt(n)))^n -> exp(theta^2/2),
$
which is convergence in #ponder("probability.convergence-in-distribution")[distribution] to $Z ~ N(0, 1)$.
