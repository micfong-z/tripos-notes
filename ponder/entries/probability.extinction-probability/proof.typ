Let $t$ be the smallest non-negative solution of $G(x) = x$. Induction on $n$ shows $q_n <= t$: the case $q_0 = PP(X_0 = 0) = 0$ is clear, and $G$ increasing on $[0, 1]$ gives
$
  q_(n+1) = G(q_n) <= G(t) = t.
$
Hence $q <= t$ as $n -> oo$, while $t <= q$ because $q$ itself solves the fixed point equation; so $q = t$.

For the criterion that $q < 1$ exactly when $EE[X_1] > 1$, first suppose $g_0 + g_1 = 1$. Then $EE[X_1] = g_1$ and $G(z) = g_0 + g_1 z = 1 - EE[X_1] + EE[X_1] z$, so
$
  G(z) = z => (1- EE[X_1]) dot z = 1 - EE[X_1],
$
and since $EE[X_1] = g_1 < 1$, necessarily $z = 1$.

Now assume $g_1 < 1$ and $g_0 + g_1 < 1$. Define $H(z) = G(z) - z = sum_(r=0)^oo g_r z^r - z$, so $H(1) = 0$ and
$
  H''(z) = sum_(r=0)^oo r(r-q) g_r z^(r-2) > 0 quad "in" (0, 1),
$
because some $g_r > 0$ with $r >= 2$. Hence $H'$ is strictly increasing on $(0, 1)$, so by Rolle's theorem $H$ has at most one root other than $1$.

If there is no other root then $q = 1$, and since $H(0) = G(0) = g_0 >= 0$ and $H(1) = 0$ we have $H >= 0$ on $[0, 1]$, whence
$
  H'(1^-) = lim_(z-> 1^-) (H(z) - H(1)) / (z-1) <= 0,
$
that is $EE[X_1] - 1 <= 0$.

If instead $H(r) = 0$ for some $r < 1$, that root must be the extinction probability $q$. Rolle's theorem gives $z in (r, 1)$ with $H'(z) = 0$, and strict increase yields
$
  H'(1^-) = EE[X_1] - 1 > H'(z) = 0,
$
so $EE[X_1] > 1$.
