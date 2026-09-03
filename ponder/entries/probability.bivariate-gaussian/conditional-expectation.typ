For a bivariate Gaussian vector,
$
  EE[X_2 mid(|) X_1] = mu_2 + (rho sigma_2 \/ sigma_1)(X_1 - mu_1).
$
To see this, write $X_2 = Y + a X_1$ with $Y = X_2 - a X_1$ and $a = "Cov"(X_1, X_2) \/ "Var"(X_1)$, so that
$
  "Cov"(X_1, Y) = "Cov"(X_1, X_2 - a X_1) = "Cov"(X_1, X_2) - a "Var"(X_1) = 0.
$
Since $vec(X_1, Y) = mat(1, 0; -a, 1) vec(X_1, X_2)$ is a Gaussian vector, its uncorrelated coordinates $X_1$ and $Y$ are independent, whence $EE[Y mid(|) X_1] = EE[Y]$ while $EE[a X_1 mid(|) X_1] = a X_1$. Therefore
$
  EE[X_2 mid(|) X_1] & = EE[Y mid(|) X_1] + EE[a X_1 mid(|) X_1] \
    & = EE[Y] + a X_1 = mu_2 - a mu_1 + a X_1 = mu_2 + (rho sigma_2 \/ sigma_1)(X_1 - mu_1).
$
