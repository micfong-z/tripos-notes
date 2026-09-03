Let $T$ be a positive random variable which is not identically zero or $oo$. Then $T$ has the exponential distribution if and only if $T$ has the memoryless property.

Necessity is the computation in the proposition above. For sufficiency, suppose $T$ has the memoryless property and set
$
  g(t) = PP(T >= t).
$
Then $g(t + s) = g(t) g(s)$, so $g(m t) = (g(t))^m$ for every $m in NN$; taking $t = 1$, $g(m) = (g(1))^m$. Writing $lambda = -log PP(T >= 1)$ gives $g(m) = ee^(-lambda m)$ for all $m in NN$, and from $(g(m \/ n))^n = g(m)$ we get $g(m \/ n) = ee^(-(lambda m)\/n)$. Hence $g(r) = ee^(-lambda r)$ for all rational $r in QQ_+$.

To extend to $RR_+$, let $t > 0$ and choose rationals $s < t < r$ with $r - s <= epsilon$. Since $g$ is decreasing,
$
  ee^(-lambda r) = g(r) <= g(t) <= g(s) = ee^(-lambda s),
$
and letting $epsilon -> 0$ yields $g(t) = ee^(-lambda t)$: the survival function of $"Exp"(lambda)$.
