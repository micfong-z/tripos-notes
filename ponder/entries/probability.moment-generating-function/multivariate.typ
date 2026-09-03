For $bold(X) = (X_1, ..., X_n)^tp$ the multivariate MGF is
$
  m(theta) = EE[ee^(bold(theta)^tp dot bold(X))] = EE[ee^(sum_(i=1)^n theta_i X_i)] quad quad "where" bold(theta) = (theta_1, ..., theta_n)^tp.
$
If it is finite for an open set of values of $bold(theta)$, it uniquely determines the distribution of $bold(X)$, and partial derivatives at the origin give moments such as $EE[X_i^r]$ and $EE[X_i^r X_j^s]$. Moreover,
$
  m(theta) = product_(i=1)^n EE[ee^(theta_i X_i)]
$
if and only if $X_1, ..., X_n$ are independent.
