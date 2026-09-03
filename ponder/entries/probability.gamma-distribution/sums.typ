If $X ~ Gamma(n, lambda)$ and $Y ~ Gamma(m, lambda)$ are independent, then for $theta < lambda$,
$
  EE[ee^(theta (X + Y))] = EE[ee^(theta X)] EE[ee^(theta Y)] = ((lambda)/(lambda - theta))^(n + m),
$
so $X + Y ~ Gamma(n + m, lambda)$ by uniqueness of the moment generating function. In particular, if $X_1, ..., X_n$ are i.i.d. $"Exp"(lambda)$ random variables, then $X_1 + ... + X_n ~ Gamma(n, lambda)$.
