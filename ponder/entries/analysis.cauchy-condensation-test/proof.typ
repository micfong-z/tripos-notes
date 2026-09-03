The substitution $u = 2^t$ gives $integral_1^x f(t) dif t = log 2 integral_0^(log_2 x) f(2^t) 2^t dif t$, so by the integral test $sum a_n$ converges exactly when $lim_(y->oo) integral_0^y f(2^t) 2^t dif t$ exists.

Let $g(t) = 2^t f(2^t)$. Since $f$ is decreasing, for $t in [k, k+1]$,
$
  2^k f(2^(k+1)) <= g(t) <= 2^(k+1) f(2^k),
$
and integrating over $[k, k+1]$ and summing,
$
  (1)/(2) sum_(n=1)^(k+1) 2^(n+1) a_(2^(n+1)) <= integral_1^(k+1) g(t) dif t <= 2 sum_(n=1)^(k+1) 2^n a_(2^n).
$
Hence the integrals converge exactly when $sum 2^n a_(2^n)$ converges, and the result follows.
