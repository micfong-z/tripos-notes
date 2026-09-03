If $Z_1, ..., Z_n$ are i.i.d. $N(0, 1)$ and $bold(Z) = (Z_1, ..., Z_n)^tp$, then $bold(Z)$ is a Gaussian vector: for every $bold(u)$,
$
  EE[ee^(lambda bold(u)^tp bold(Z))] = product_(i=1)^n EE[ee^(lambda u_i Z_i)] = exp((lambda^2)/(2) abs(bold(u))^2),
$
so $bold(u)^tp bold(Z) ~ N(0, abs(bold(u))^2)$; we write $bold(Z) ~ N(bold(0), matbold(I)_n)$.

Conversely, given any non-negative definite matrix $matbold(V)$ with spectral decomposition $matbold(V) = matbold(U)^tp matbold(D) matbold(U)$ and eigenvalues $lambda_1, ..., lambda_n >= 0$, the square root
$
  matbold(sigma) = matbold(U)^tp sqrt(matbold(D)) matbold(U), quad quad matbold(sigma)^2 = matbold(V),
$
lets us construct, for any mean $bold(mu)$,
$
  bold(X) = bold(mu) + matbold(sigma) bold(Z).
$
As a linear transformation of a Gaussian vector this is again a Gaussian vector, with
$
  EE[bold(X)] = bold(mu) quad quad "and" quad quad "Var"(bold(X)) = matbold(sigma) EE[bold(Z) bold(Z)^tp] matbold(sigma)^tp = matbold(sigma)^2 = matbold(V),
$
so $N(bold(mu), matbold(V))$ exists for every non-negative definite covariance matrix.
