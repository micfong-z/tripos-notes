Split $f = S_N + T_N$ with $S_N (x) = sum_(n <= N) c_n (x-a)^n$ a polynomial of degree $N$ and $T_N (x) = sum_(n >= N+1) c_n (x-a)^n$. On $D_r (a)$,

$
  abs(T_N (x)) <= sum_(n >= N+1) abs(c_n) r^n quad forall x in D_r (a),
$

and since $r < R$ the definition of the radius of convergence makes the right side $< epsilon$ for all large $N$, uniformly in $x$. Hence

$
  abs(f(x) - f(x_0)) <= abs(S_N (x) - S_N (x_0)) + 2 epsilon quad forall x in D_r (a),
$

and $S_N$, being a polynomial, is continuous: choose $delta$ with $abs(S_N (x) - S_N (x_0)) < epsilon$ whenever $abs(x - x_0) < delta$.
