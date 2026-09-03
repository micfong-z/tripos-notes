For $h != 0$,
$
  (dif F)/(dif x) = lim_(h -> 0) (1 / h) integral_x^(x + h) f(t) dif t.
$
The integral over this interval is $f(x) h + O(h^2)$ by the mean-value theorem and Taylor's theorem. The limit is therefore $lim_(h -> 0) (f(x) + O(h)) = f(x)$.
