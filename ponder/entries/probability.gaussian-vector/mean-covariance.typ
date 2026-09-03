For a Gaussian vector $bold(X)$ define
$
  bold(mu) = EE[bold(X)] = vec(EE[X_1], ..., EE[X_n]) quad quad "and" quad quad matbold(V) = "Var"(bold(X)) = EE[(bold(X) - bold(mu)) (bold(X) - bold(mu))^tp].
$
The entries of $matbold(V)$ are $"Var"(bold(X))_(i j) = "Cov"(X_i, X_j)$, so $matbold(V)$ is a symmetric matrix, and it is non-negative definite since
$
  bold(u)^tp matbold(V) bold(u) = "Var"(bold(u)^tp bold(X)) >= 0 quad quad "for every" bold(u).
$
Moreover $bold(lambda)^tp bold(X) ~ N(bold(lambda)^tp bold(mu), bold(lambda)^tp matbold(V) bold(lambda))$ for every $bold(lambda)$, so
$
  m(bold(lambda)) = EE[ee^(bold(lambda)^tp bold(X))] = exp(bold(lambda)^tp bold(mu) + 1/2 bold(lambda)^tp matbold(V) bold(lambda)).
$
Since the MGF uniquely characterises the distribution when finite on an open set, a Gaussian vector is completely determined by $bold(mu)$ and $matbold(V)$.
