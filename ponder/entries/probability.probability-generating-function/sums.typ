If $X_1, ..., X_n$ are independent random variables with PGFs $q_i (z) = EE[z^(X_i)]$, the PGF of $S_n = X_1 + ... + X_n$ is the product:
$
  p(z) = EE[z^(X_1 + ... + X_n)] = EE[z^(X_1) z^(X_2) ... z^(X_n)] = EE[z^(X_1)] EE[z^(X_2)] ... EE[z^(X_n)] = product_(i=1)^n q_i(z).
$
For example, if $X ~ "Bin"(n, p)$ and $Y ~ "Bin"(m, p)$ are independent, then
$
  EE[z^(X+Y)] = EE[z^X] EE[z^Y] = (1-p + p z)^n (1-p + p z)^m = (1-p + p z)^(n+m),
$
so $X + Y ~ "Bin"(n+m, p)$; and if $X ~ "Poi"(lambda)$ and $Y ~ "Poi"(mu)$ are independent, then $EE[z^(X+Y)] = ee^(lambda(z-1)) ee^(mu(z-1)) = ee^((lambda + mu)(z-1))$, so $X + Y ~ "Poi"(lambda + mu)$.
