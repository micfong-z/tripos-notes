A monotone $f$ on $[a, b]$ is bounded by $max{abs(f(a)), abs(f(b))}$, and for any partition

$
  U(f, cal(P)) - L(f, cal(P)) = sum_(j=1)^n (sup_(I_j) f - inf_(I_j) f) abs(I_j), quad I_j = [x_(j-1), x_j].
$

The extrema of a monotone function on $I_j$ are attained at the endpoints: assuming WLOG that $f$ is increasing, $sup_(I_j) = f(x_j)$ and $inf_(I_j) = f(x_(j-1))$, so

$
  U(f, cal(P)) - L(f, cal(P)) = sum_(j=1)^n (f(x_j) - f(x_(j-1))) abs(I_j).
$

For the uniform partition $cal(P)_n = {a, a + (b-a)/(n), a + 2(b-a)/(n), ..., b}$ every subinterval has length $(b-a)/(n)$ and the sum telescopes:

$
  U(f, cal(P)_n) - L(f, cal(P)_n) = (b-a)/(n) (f(b) - f(a)) -> 0 quad "as" n -> oo,
$

so the sequential integrability criterion applies.
