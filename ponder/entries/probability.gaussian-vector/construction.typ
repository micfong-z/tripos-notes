If $Z_1, ..., Z_n$ are i.i.d. $N(0, 1)$ and $vb(Z) = vecrow(Z_1, ..., Z_n)^TT$, then $vb(Z)$ is a Gaussian vector: for every $vb(u)$,
$
  EE[ee^(lambda vb(u)^TT vb(Z))] = product_(i=1)^n EE[ee^(lambda u_i Z_i)] = exp((lambda^2)/(2) abs(vb(u))^2),
$
so $vb(u)^TT vb(Z) ~ N(0, abs(vb(u))^2)$; we write $vb(Z) ~ N(vb(0), matbold(I)_n)$.

Conversely, given any non-negative definite matrix $matbold(V)$ with spectral decomposition $matbold(V) = matbold(U)^TT matbold(D) matbold(U)$ and eigenvalues $lambda_1, ..., lambda_n >= 0$, the square root
$
  matbold(sigma) = matbold(U)^TT sqrt(matbold(D)) matbold(U), quad quad matbold(sigma)^2 = matbold(V),
$
lets us construct, for any mean $vb(mu)$,
$
  vb(X) = vb(mu) + matbold(sigma) vb(Z).
$
As a linear transformation of a Gaussian vector this is again a Gaussian vector, with
$
  EE[vb(X)] = vb(mu) quad quad "and" quad quad "Var"(vb(X)) = matbold(sigma) EE[vb(Z) vb(Z)^TT] matbold(sigma)^TT = matbold(sigma)^2 = matbold(V),
$
so $N(vb(mu), matbold(V))$ exists for every non-negative definite covariance matrix.
