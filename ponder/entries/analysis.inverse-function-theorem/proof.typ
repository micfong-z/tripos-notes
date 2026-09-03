A continuous, strictly monotone function $f: [a, b] -> RR$ maps $[a, b]$ bijectively onto $[c, d] = [min{f(a), f(b)}, max{f(a), f(b)}]$, and the inverse $f^(-1): [c, d] -> [a, b]$ is again continuous and strictly monotone.

*Bijectivity.* Monotonicity forces the extreme values of $f$ on $[a, b]$ to occur at the endpoints, so $f$ maps into $[c, d]$; the Intermediate Value Theorem makes it surjective onto $[c, d]$, and strict monotonicity makes it injective.

*Monotonicity of the inverse.* WLOG let $f$ be strictly increasing. If $f^(-1)$ were not, there would be $y_1 < y_2$ in $[c, d]$ with $f^(-1)(y_1) >= f^(-1)(y_2)$; applying the increasing function $f$ gives $y_1 >= y_2$, a contradiction. Hence $f^(-1)$ is strictly increasing.

*Continuity of the inverse.* Fix $y_0 in [c, d]$ and $x_0 = f^(-1)(y_0)$.

- If $x_0 in (a, b)$, choose $eta in (0, epsilon]$ with $[x_0 - eta, x_0 + eta] subset.eq [a, b]$. Strict increase gives $f(x_0 - eta) < y_0 < f(x_0 + eta)$, and $delta = min{f(x_0 + eta) - y_0, y_0 - f(x_0 - eta)} > 0$ satisfies

  $
    abs(y - y_0) < delta & => f(x_0 - eta) < y < f(x_0 + eta) \
                         & => x_0 - eta < f^(-1)(y) < x_0 + eta \
                         & => abs(f^(-1)(y) - x_0) < eta <= epsilon.
  $

- If $x_0 = a$, take $eta = min{epsilon, b-a}$ and $delta = f(a + eta) - f(a) > 0$; then $abs(y - y_0) < delta$ with $y in [c, d]$ forces $a <= f^(-1)(y) <= a + eta$, so $abs(f^(-1)(y) - a) <= eta <= epsilon$.

- The case $x_0 = b$ is similar.
