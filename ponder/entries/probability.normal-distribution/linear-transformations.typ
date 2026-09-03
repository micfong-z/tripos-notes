If $X ~ N(mu, sigma^2)$ and $a, b in RR$ with $a != 0$, then
$
  a X + b ~ N(a mu + b, (a sigma)^2).
$
Indeed, for $g(x) = a x + b$ we have $g^(-1)(x) = (x - b) \/ a$ and $(g^(-1))'(x) = 1 \/ a$, so the change-of-variables formula gives
$
  f_Y (y) = f_X ((y - b)/a) dot 1/(abs(a)) = 1/sqrt(2 ppi a^2 sigma^2) exp(- (y - (a mu + b))^(2)/(2 a^2 sigma^2)).
$
