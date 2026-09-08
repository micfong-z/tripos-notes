If $matbold(V)$ is positive definite, then $vb(X) ~ N(vb(mu), matbold(V))$ has density
$
  f_vb(X)(vb(x)) = 1/sqrt((2 ppi)^n det matbold(V)) exp(- ((vb(x) - vb(mu))^TT matbold(V)^(-1) (vb(x) - vb(mu)))/(2)).
$
This follows from the change-of-variables formula applied to $vb(X) = vb(mu) + matbold(sigma) vb(Z)$ with $vb(Z) ~ N(vb(0), matbold(I)_n)$ of density $(2 ppi)^(-n\/2) exp(-abs(vb(z))^(2)\/2)$.

If instead $exists i$ with $lambda_i = 0$, no density on $RR^n$ exists: after an orthogonal change of basis one may assume
$
  matbold(V) = mat(matbold(U), matbold(0); matbold(0), matbold(0)) quad "where" matbold(U) "is positive definite of size" m times m,
$
and then
$
  vb(X) = vec(vb(Y), vb(nu)) quad quad "with" quad vb(Y) ~ N(vb(lambda), matbold(U)), vb(nu) "constant",
$
so the distribution is supported on an affine subspace of dimension $m < n$.
