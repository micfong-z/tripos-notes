If $X ~ N(mu, sigma^2)$ with $-oo < mu < oo$ and $sigma > 0$, then $EE[X] = mu$ and $"Var"(X) = sigma^2$.

For the mean, write the integral as an odd part plus a constant part:
$
  EE[X] & = integral_(-oo)^(oo) (x - mu) 1/sqrt(2 ppi sigma^2) exp(- (x - mu)^(2)/(2 sigma^2)) dif x \
        & quad + mu integral_(-oo)^(oo) f(x) dif x.
$
The first integrand is odd, so its integral vanishes, and the second integral equals $1$; hence $EE[X] = mu$. For the variance, substituting $u = (x - mu) \/ sigma$ gives
$
  "Var"(X) = integral_(-oo)^(oo) sigma^2 u^2 1/sqrt(2 ppi) exp(- u^(2)\/2) dif u = sigma^2.
$
