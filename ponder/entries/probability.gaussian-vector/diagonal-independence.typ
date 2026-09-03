If $X_1, ..., X_n$ are independent then $"Cov"(X_i, X_j) = 0$ for $i != j$, so the covariance matrix of a Gaussian vector is diagonal in that case. For Gaussian vectors the converse holds: if $matbold(V)$ is diagonal and strictly positive definite with diagonal $lambda_1, ..., lambda_n > 0$, the joint density factorises as
$
  f_bold(X) (bold(x)) = product_(i=1)^n 1/sqrt(2 ppi lambda_i) exp(- ((x_i - mu_i)^2)/(2 lambda_i)),
$
so by the factorisation criterion the coordinates are independent with $X_i ~ N(mu_i, lambda_i)$; alternatively the MGF
$
  m(theta) = exp(sum_(i=1)^n theta_i mu_i + sum_(i=1)^n (theta_i^2 lambda_i)/2) = product_(i=1)^n exp(theta_i mu_i + (theta_i^2 lambda_i)/2)
$
factorises into functions of the individual $theta_i$, and uniqueness of the MGF again gives independence.

Hence, for a Gaussian vector, $X_1, ..., X_n$ are independent precisely when $"Cov"(X_i, X_j) = 0$ for all $i != j$.
