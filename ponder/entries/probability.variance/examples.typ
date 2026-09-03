For $"Bin"(n, p)$: $EE[X] = n p$, and
$
  EE[X(X-1)] & = sum_(k=2)^n k(k-1) (n!)/(k! (n-k)!) p^k (1-p)^(n-k) \
             & = n(n-1) p^2 underbracket(sum_(k=0)^(n-2) (n-2)!/(k! (n-2-k)!) p^k (1-p)^(n-2-k), 1) \
             & = n(n-1) p^2,
$
so
$
  "Var"(X) = n(n-1) p^2 + n p - n^2 p^2 = n p (1-p).
$

For $"Poi"(lambda)$: $EE[X] = lambda$, and
$
  EE[X(X-1)] & = sum_(k=2)^(oo) k(k-1) ee^(-lambda) lambda^k / k! \
             & = lambda^2 underbracket(sum_(k=0)^(oo) ee^(-lambda) lambda^k / k!, 1) \
             & = lambda^2,
$
so $"Var"(X) = lambda^2 + lambda - lambda^2 = lambda$.
