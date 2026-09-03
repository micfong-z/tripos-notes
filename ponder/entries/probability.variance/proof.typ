For the computational formula,
$
  "Var"(X) & = EE[X^2 - 2X EE[X] + (EE[X])^2] \
           & = EE[X^2] - 2 EE[X] EE[X] + (EE[X])^2 \
           & = EE[X^2] - (EE[X])^2.
$

For the minimum property, define $f(c) = EE[(X-c)^2] = EE[X^2] - 2c EE[X] + c^2$. Then
$
  f'(c) = -2 EE[X] + 2c,
$
which vanishes exactly at $c = EE[X]$, and $f''(c) = 2 > 0$, so $f$ is convex and the minimum is attained there:
$
  "Var"(X) = f(EE[X]) = min_(c in RR) EE[(X - c)^2].
$
