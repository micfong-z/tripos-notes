For $h != 0$,
$
  dv(F, x) = lim_(h -> 0) (1 / h) integral_x^(x + h) f(t) dif t.
$
The integral over this interval is $f(x) h + Order(h^2)$ by the mean-value theorem and Taylor's theorem. The limit is therefore $lim_(h -> 0) (f(x) + Order(h)) = f(x)$.
