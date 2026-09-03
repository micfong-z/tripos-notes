If $X ~ N(mu, sigma^2)$, then $Z = (X - mu) \/ sigma ~ N(0, 1)$. Writing $Phi(x) = PP(Z <= x)$ for the distribution function of the standard normal, its density is $phi(x) = Phi'(x) = 1/sqrt(2 ppi) ee^(-(x^2)/2)$, and since $(Phi(x) + Phi(-x))' = 0$ while $Phi(0) = 1\/2$,
$
  PP(X <= x) + PP(X <= -x) = Phi(x) + Phi(-x) = 1.
$
Existing tables of $Phi$ therefore give $PP(X <= x)$ for any normal random variable; for instance
$
  PP(-2 sigma < X - mu < 2 sigma) = PP(-2 < Z < 2) = Phi(2) - Phi(-2) = 2 Phi(2) - 1 > 0.95.
$
