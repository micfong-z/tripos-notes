Suppose first that $g$ is strictly increasing. Then
$
  PP(g(X) <= x) = PP(X <= g^(-1)(x)) = F(g^(-1)(x)),
$
and differentiating gives the density $f(g^(-1)(x)) (g^(-1))'(x)$, which is non-negative because $(g^(-1))' >= 0$.

If $g$ is strictly decreasing, then
$
  PP(g(X) <= x) = PP(X >= g^(-1)(x)) = 1 - PP(X < g^(-1)(x)),
$
and differentiating gives the density $-f(g^(-1)(x)) (g^(-1))'(x)$, non-negative because $(g^(-1))' <= 0$. Both cases combine into $f(g^(-1)(x)) dot abs((g^(-1))'(x))$.
