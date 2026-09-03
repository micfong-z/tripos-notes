If $matbold(V)$ is positive definite, then $bold(X) ~ N(bold(mu), matbold(V))$ has density
$
  f_bold(X)(bold(x)) = 1/sqrt((2 ppi)^n det matbold(V)) exp(- ((bold(x) - bold(mu))^tp matbold(V)^(-1) (bold(x) - bold(mu)))/(2)).
$
This follows from the change-of-variables formula applied to $bold(X) = bold(mu) + matbold(sigma) bold(Z)$ with $bold(Z) ~ N(bold(0), matbold(I)_n)$ of density $(2 ppi)^(-n\/2) exp(-abs(bold(z))^(2)\/2)$.

If instead $exists i$ with $lambda_i = 0$, no density on $RR^n$ exists: after an orthogonal change of basis one may assume
$
  matbold(V) = mat(matbold(U), matbold(0); matbold(0), matbold(0)) quad "where" matbold(U) "is positive definite of size" m times m,
$
and then
$
  bold(X) = vec(bold(Y), bold(nu)) quad quad "with" quad bold(Y) ~ N(bold(lambda), matbold(U)), bold(nu) "constant",
$
so the distribution is supported on an affine subspace of dimension $m < n$.
