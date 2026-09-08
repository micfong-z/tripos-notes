For a Gaussian vector $vb(X)$ define
$
  vb(mu) = EE[vb(X)] = vec(EE[X_1], ..., EE[X_n]) quad quad "and" quad quad matbold(V) = "Var"(vb(X)) = EE[(vb(X) - vb(mu)) (vb(X) - vb(mu))^TT].
$
The entries of $matbold(V)$ are $"Var"(vb(X))_(i j) = "Cov"(X_i, X_j)$, so $matbold(V)$ is a symmetric matrix, and it is non-negative definite since
$
  vb(u)^TT matbold(V) vb(u) = "Var"(vb(u)^TT vb(X)) >= 0 quad quad "for every" vb(u).
$
Moreover $vb(lambda)^TT vb(X) ~ N(vb(lambda)^TT vb(mu), vb(lambda)^TT matbold(V) vb(lambda))$ for every $vb(lambda)$, so
$
  m(vb(lambda)) = EE[ee^(vb(lambda)^TT vb(X))] = exp(vb(lambda)^TT vb(mu) + 1/2 vb(lambda)^TT matbold(V) vb(lambda)).
$
Since the MGF uniquely characterises the distribution when finite on an open set, a Gaussian vector is completely determined by $vb(mu)$ and $matbold(V)$.
