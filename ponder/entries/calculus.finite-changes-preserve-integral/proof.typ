Let $M = sup_[a, b] f$ and fix $epsilon > 0$. Choose a partition $cal(P)$ of $[a, b]$ with

$
  U(g, cal(P)) - L(g, cal(P)) < epsilon.
$

The idea is to isolate the problematic points with intervals of tiny total weight. Pick intervals $J_j = [z_k - r_k, z_k + r_k]$ with

$
  sum_(n=1)^N abs(J_k) = 2 sum_(n=1)^N r_k < epsilon,
$

and set $cal(P)' = cal(P) union {z_1 plus.minus r_1, z_2 plus.minus r_2, ..., z_N plus.minus r_N}$ and $J = union.big_(n=1)^N J_n$. Refining only improves $g$, so $U(g, cal(P)') - L(g, cal(P)') < epsilon$.

Splitting the sum over subintervals inside and outside $J$: if $I_j subset.eq.not J$ then $f = g$ there, so

$
  sum_(j = 1, I_j subset.eq.not J)^n abs(I_j) (sup_(J_j) f - inf_(J_j) f) <= U(g, cal(P)') - L(g, cal(P)') < epsilon;
$

if $I_j subset.eq J$ then merely $f$ is bounded, and

$
  sum_(j=1, I_j subset.eq J)^n abs(I_j) (sup_(I_j) f - inf_(I_j) f) <= 2 M sum_(j=1, I_j subset.eq J)^n abs(I_j) <= 2 M sum_(n=1)^N abs(J_n) < 2 M epsilon.
$

Thus $U(f, cal(P)') - L(f, cal(P)') < (2 M + 1) epsilon$, proving integrability of $f$. For the values,

$
  integral_a^b f - integral_a^b g <= underbracket(U(f, cal(P)') - U(g, cal(P)'), < epsilon) + underbracket((g, cal(P)') - L(g, cal(P)'), < epsilon),
$

so $integral_a^b f - integral_a^b g < 2 epsilon$; the reverse inequality is identical, and since $epsilon$ is arbitrary the integrals agree.
