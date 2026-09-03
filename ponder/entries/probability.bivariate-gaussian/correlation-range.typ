By the Cauchy-Schwarz inequality, $rho = "Corr"(X_1, X_2) in [-1, 1]$. The covariance matrix of $(X_1, X_2)$ is
$
  matbold(V) = mat(sigma_1^2, rho sigma_1 sigma_2; rho sigma_1 sigma_2, sigma_2^2),
$
and for $sigma_1, sigma_2 > 0$ and $rho in [-1, 1]$ this matrix is non-negative definite: for any $bold(u) = (u_1, u_2)^tp$,
$
  bold(u)^tp matbold(V) bold(u) & = (1 - rho)(sigma_1^2 u_1^2 + sigma_2^2 u_2^2) + rho (sigma_1 u_1 + sigma_2 u_2)^2 \
    & = (1 + rho)(sigma_1^2 u_1^2 + sigma_2^2 u_2^2) - rho (sigma_1 u_1 - sigma_2 u_2)^2,
$
where the first identity shows non-negativity for $rho in [0, 1]$ and the second for $rho in [-1, 0]$.
