For $vb(X) = vecrow(X_1, ..., X_n)^TT$ the multivariate MGF is
$
  m(theta) = EE[ee^(vb(theta)^TT dot vb(X))] = EE[ee^(sum_(i=1)^n theta_i X_i)] quad quad "where" vb(theta) = vecrow(theta_1, ..., theta_n)^TT.
$
If it is finite for an open set of values of $vb(theta)$, it uniquely determines the distribution of $vb(X)$, and partial derivatives at the origin give moments such as $EE[X_i^r]$ and $EE[X_i^r X_j^s]$. Moreover,
$
  m(theta) = product_(i=1)^n EE[ee^(theta_i X_i)]
$
if and only if $X_1, ..., X_n$ are independent.
