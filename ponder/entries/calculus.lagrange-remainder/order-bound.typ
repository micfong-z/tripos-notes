If $f in C^n ((c, d))$ with $[a, a+h] subset.eq (c, d)$, then $f^((n))$ is continuous and hence bounded on the compact interval: for
$
  M_n = sup_(x in [a, a+h]) abs(f^((n))(x)),
$
the Lagrange form gives
$
  abs(R_(n, f, a)(h)) <= M_n h^n/(n!),
$
so $R_(n, f, a)(h)$ is $O(h^n)$ as $h -> 0$. This does not say that $R_(n, f, a)(h) -> 0$ as $n -> oo$: even when $f in C^(oo)$, nothing controls how $M_n$ grows with $n$. Nothing is special about $h > 0$: applying the theorem to $g(x) = f(-x)$ covers increments with $h < 0$.
