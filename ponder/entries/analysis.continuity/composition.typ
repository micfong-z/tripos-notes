Let $U, V subset.eq CC$, $f: U -> V$, $g: V -> CC$. If $f$ is continuous at $a in U$ and $g$ is continuous at $f(a) in V$, then $g compose f: U -> CC$ is continuous at $a$.

Given $epsilon > 0$, continuity of $g$ at $f(a)$ supplies $sigma = sigma(epsilon)$ with $abs(y - f(a)) < sigma => abs(g(y) - g(f(a))) < epsilon$ for $y in V$; continuity of $f$ at $a$ then supplies $delta = delta(epsilon)$ with $abs(z - a) < delta => abs(f(z) - f(a)) < sigma$. Chaining the two implications,

$
  abs(z-a) < delta => abs(f(z) - f(a)) < sigma => abs(g(f(z)) - g(f(a))) < epsilon,
$

so composition preserves continuity.
