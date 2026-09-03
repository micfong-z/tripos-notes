Parts (4) and (5) reduce to showing that integrability of $f$ implies integrability of $abs(f)$ and of $f^2$, using the estimates $sup_I abs(f) - inf_I abs(f) <= sup_I f - inf_I f$ and $sup_I f^2 - inf_I f^2 <= 2 sup abs(f) (sup_I f - inf_I f)$.

For part (4): for any partition $cal(P)$ of $[a, b]$,

$
  U(abs(f), cal(P)) - L(abs(f), cal(P)) <= U(f, cal(P)) - L(f, cal(P)),
$

so if $f$ is integrable then so is $abs(f)$. Since for all $x in [a, b]$,

$
  - abs(f(x)) < f(x) < abs(f(x)),
$

part (1) gives

$
  - integral_a^b abs(f) <= integral_a^b f <= integral_a^b abs(f),
$

that is, $abs(integral_a^b f) <= integral_a^b abs(f)$ — the triangle inequality for integrals.

For part (5): write

$
  f g = (1)/(4) [(f+g)^2 - (f-g)^2],
$

so it suffices to show that $f$ integrable implies $f^2$ integrable. For any partition $cal(P)$,

$
  U(f^2, cal(P)) - L(f^2, cal(P)) <= 2 sup_I abs(f) dot [U(f, cal(P)) - L(f, cal(P))],
$

hence $f^2$ is integrable whenever $f$ is.
