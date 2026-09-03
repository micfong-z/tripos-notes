For $X ~ "Bin"(n, p)$,
$
  p(z) = EE[z^X] = sum_(r=0)^n binom(n, r) p^r (1-p)^(n-r) z^r = (1-p + p z)^n.
$

For $X ~ "Geo"(p)$,
$
  EE[z^X] = sum_(r=1)^oo z^r (1-p)^(r-1) p = (p z)/(1 - z(1-p)).
$

For $X ~ "Poi"(lambda)$,
$
  EE[z^X] = sum_(r=0)^oo z^r ee^(-lambda) lambda^r / r! = ee^(-lambda) sum_(r=0)^oo (lambda z)^r / r! = ee^(-lambda) ee^(lambda z) = ee^(lambda(z-1)).
$
