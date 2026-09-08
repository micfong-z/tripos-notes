For the homogeneous system $vb(dot(Y)) = matbold(M) vb(Y)$ there is a fixed point at $vb(Y) = vb(0)$, and for $n = 2$ with distinct non-zero eigenvalues the general solution is
$
  vb(Y)(t) = A vb(v)_1 ee^(lambda_1 t) + B vb(v)_2 ee^(lambda_2 t).
$
The local portrait near the fixed point is determined by $lambda_1$ and $lambda_2$:

1. Real eigenvalues of opposite signs: $vb(v_1), vb(v_2)$ can be chosen real, and the fixed point is a saddle node.

2. Real eigenvalues of the same sign, say $abs(lambda_1) > abs(lambda_2)$: both positive gives an unstable node; both negative gives a stable node.

3. Complex conjugate eigenvalues $lambda_2 = overline(lambda_1)$ with $vb(v_2) = overline(vb(v_1))$: writing $C = c_1 + ii c_2$,
   $
     vb(Y)(t) &= C vb(v_1) ee^(re(lambda_1) t) ee^(ii im(lambda_1) t) + overline(C) overline(vb(v_1)) ee^(re(lambda_1) t) ee^(-ii im(lambda_1) t)
   $
   so the trajectories spiral with radial factor $ee^(re(lambda_1) t)$. Then $re(lambda_1) > 0$ gives an unstable spiral, $re(lambda_1) < 0$ a stable spiral, and $re(lambda_1) = 0$ a centre with closed elliptical trajectories.
