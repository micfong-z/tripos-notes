Use the same split $f = S_N + T_N$ as for continuity. Then

$
  abs(integral_a^x f(t) dif t - sum_(n <= N) (c_n (x-a)^(n+1))/(n+1)) = abs(integral_a^x T_N (t) dif t) <= r dot sup_(abs(t-a) < r) abs(T_N (t)),
$

and the uniform tail bound on $D_r (a)$ makes the last expression $< r epsilon$ once $N$ is large. Letting $N -> oo$,

$
  integral_a^x f(t) dif t = sum_(n=0)^oo (c_n)/(n+1) (x-a)^(n+1),
$

so a power series may be integrated term by term within its radius of convergence.
