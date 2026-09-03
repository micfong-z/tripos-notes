Let $F(x) = integral_a^x f(t) dif t$; by the Fundamental Theorem of Calculus, Part 1, $F: [a, b] -> RR$ is well-defined and differentiable with $F' = f$. Set $h = F compose g: [alpha, beta] -> RR$. By the chain rule, $h$ is differentiable:

$
  h'(t) = F'(g(t)) g'(t) = f(g(t))g'(t).
$

Hence, applying the FTC to $h$,

$
  integral_a^b f(x) dif x & = F(b)-F(a) = F(g(beta)) - F(g(alpha)) = h(beta) - h(alpha) \
                          & = integral_alpha^beta h'(t) dif t \
                          & = integral_alpha^beta f(g(t)) g'(t) dif t.
$
