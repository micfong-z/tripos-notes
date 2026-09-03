Suppose $(p_r)$ and $(q_r)$ are two probability distributions with the same PGF, so for all $abs(z) <= 1$,
$
  sum_(r=0)^oo p_r z^r = sum_(r=0)^oo q_r z^r.
$
The coefficients agree by induction. Letting $z -> 0$ gives $p_0 = q_0$. Assuming $p_r = q_r$ for all $r <= n$, subtracting the common part leaves
$
  sum_(r=n+1)^oo p_r z^r = sum_(r=n+1)^oo q_r z^r,
$
and dividing by $z^(n+1)$ and letting $z -> 0$ gives $p_(n+1) = q_(n+1)$.
