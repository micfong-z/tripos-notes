If $f(x, y, z)$ is constant, then
$
  0 = dif f
    = (pdv(f, x))_(y, z) dif x
      + (pdv(f, y))_(x, z) dif y
      + (pdv(f, z))_(x, y) dif z.
$
The variables $x, y, z$ cannot be varied independently on the surface. Holding $y$ fixed,
$
  0
    = (pdv(f, x))_(y, z)
      + (pdv(f, z))_(x, y) (pdv(z, x))_y,
$
so
$ (pdv(z, x))_y = - (pdv(f, x))_(y, z) / (pdv(f, z))_(x, y). $
The same argument yields $(pdv(x, y))_z$ and $(pdv(y, z))_x$, and the product of the three ratios is $-1$.
