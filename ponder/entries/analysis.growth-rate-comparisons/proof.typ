Fix $r > 0$.

+ For $x > 1$ and any $n$, the series for $ee^x$ gives $ee^x > x^n \/ n!$. Choosing $n$ with $n - r >= 1$,

$
  0 <= x^r / ee^x <= n! / x^(n-r) <= n! / x -> 0 quad "as" x -> oo.
$

+ Pick $epsilon in (0, r)$. Since $t^(-1) <= t^(epsilon - 1)$ for all $t >= 1$,

$
  0 <= x^(-r) log x = x^(-r) integral_1^x dif t \/ t <= x^(-r) integral_1^x t^(epsilon - 1) dif t = x^(epsilon - r) / epsilon -> 0 quad "as" x -> oo.
$

+ Substituting $x = ee^(-t)$ turns the limit into

$
  lim_(x -> 0^+) x^r log x = -lim_(t -> oo) t ee^(-r t),
$

which vanishes by the first statement: a power of $t$ times an exponential in $t$ tends to $0$.
