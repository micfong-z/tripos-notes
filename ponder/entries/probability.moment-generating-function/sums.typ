If $X_1, X_2, ..., X_n$ are independent random variables, then
$
  EE[ee^(theta (X_1 + X_2 + ... + X_n))] = product_(i=1)^n EE[ee^(theta X_i)],
$
so the MGF of a sum of independent random variables is the product of their MGFs.

For example, if $X ~ Gamma(n, lambda)$ and $Y ~ Gamma(m, lambda)$ are independent, then for $theta < lambda$,
$
  EE[ee^(theta (X + Y))] = ((lambda)/(lambda - theta))^n ((lambda)/(lambda - theta))^m = ((lambda)/(lambda - theta))^(n + m),
$
so $X + Y ~ Gamma(n + m, lambda)$; in particular, the sum of $n$ i.i.d. $"Exp"(lambda)$ random variables has the $"Gamma"(n, lambda)$ distribution.
