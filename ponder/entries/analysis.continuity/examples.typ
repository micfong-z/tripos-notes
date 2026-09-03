- $f(z) = z$ is continuous: take $delta(epsilon) = epsilon$, so $|z - a| < delta => abs(f(z) - f(a)) = abs(z - a) < epsilon$.

- $f(x) = cases(sin(1/x) quad &"if" x != 0, 0 quad &"if" x = 0,)$ is not continuous at $0$, since $lim_(x->0) sin(1/x)$ does not exist.

- The Dirichlet function $f(x) = bb(1)_QQ (x)$ is discontinuous at every $a in RR$: rationals are approached by irrational sequences with $f(x_n) = 0 != 1 = f(a)$, and irrationals by rational sequences with $f(x_n) = 1 != 0 = f(a)$.

- $f(x) = sin x$ is continuous at every $a in RR$: for $delta(epsilon) = min(epsilon, pi/2)$,

$
  abs(sin x - sin a) <= 2 cos((x+a)/2) sin((x-a)/2) <= abs(sin((x-a)/2)) <= abs(x-a),
$

by taking $(x-a)/2 in [-pi/2, pi/2]$, so $abs(f(x_n) - f(a)) <= abs(x_n - a)$ once $n$ is large enough.
