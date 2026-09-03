Comparing each term $a_n = f(n)$ with the area under the graph over an interval of length one gives
$
  s_k - a_1 = sum_(n=2)^k a_n <= integral_1^k f(t) dif t, quad
  s_(k-1) = sum_(n=1)^(k-1) a_n >= integral_1^k f(t) dif t.
$

If $sum a_n$ converges with sum $s$, then $integral_1^k f(t) dif t <= s_(k-1) <= s$, so $(integral_1^k f(t) dif t)_k$ is increasing and bounded above, hence converges.

Conversely, if the integrals converge then they are bounded, so $(s_k)$ is increasing and bounded: a monotone bounded sequence converges.

For the error term, $b_k = sum_(n=1)^k a_n - integral_1^k f(x) dif x$ satisfies $b_k - b_(k-1) = f(k) - integral_(k-1)^k f(t) dif t <= 0$ and $b_k >= f(k) >= 0$, so $(b_k)$ decreases to some limit $l >= 0$; since $0 <= f(k) <= b_k <= a_1 = f(1)$, also $l <= f(1)$.
