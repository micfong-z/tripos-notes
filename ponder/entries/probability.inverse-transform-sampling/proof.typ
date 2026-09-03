Let $G(u) = inf{x in RR: u <= F(x)}$. Then $G(u) <= x$ iff $u <= F(x)$.

If $u <= F(x)$, then $x$ lies in the set whose infimum is $G(u)$, so $G(u) <= x$. Conversely, there are $x_n >= G(u)$ decreasing to $G(u)$ with $u <= F(x_n)$; by the right continuity of $F$, $lim_(n->oo) F(x_n) = F(G(u))$, so $u <= F(G(u))$. Since $F$ is increasing, $G(u) <= x$ gives $u <= F(G(u)) <= F(x)$.

Therefore, for $X = G(U)$,
$
  PP(X <= x) = PP(G(U) <= x) = PP(U <= F(x)) = F(x),
$
so $X$ has distribution function $F$. When $F$ is injective this is immediate from $PP(F^(-1)(U) <= x) = PP(U <= F(x))$.
