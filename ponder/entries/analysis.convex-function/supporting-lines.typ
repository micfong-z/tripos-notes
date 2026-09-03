A convex function $f$ is the supremum of all the lines below it: for every $m in RR$ there exist $a, b in RR$ with
$
  f(x) & >= a x + b quad "for all" x in RR, \
  f(m) & = a m + b.
$
To see this, take $x < m < y$ and $t in (0, 1)$ with $m = t x + (1-t) y$, so that $t(m-x) = (1-t)(y-m)$. Convexity gives
$
  (f(m) - f(x)) / (m-x) <= (f(y) - f(m)) / (y-m).
$
Hence the slopes $a = sup_(x < m) (f(m) - f(x)) / (m-x)$ satisfy $(f(m) - f(x))/(m-x) <= a <= (f(y) - f(m))/(y-m)$ for all $x < m < y$, so $f(z) >= a (z - m) + f(m)$ for every $z$, and $b = f(m) - a m$ completes the supporting line.
