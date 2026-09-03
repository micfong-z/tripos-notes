Let $A = {r >= 0: exists x in CC "with" abs(x-a) = r "such that" sum c_n (x-a)^n "converges"}$, which contains $0$. If $A$ is unbounded, set $R = oo$: absolute convergence then holds on all of $CC$ by the comparison below. Otherwise set $R = sup A$. For $abs(x-a) > R$ the series diverges by definition of $A$.

If $abs(y-a) < R$, choose $r in A$ with $abs(y-a) < r <= R$, and $x$ with $abs(x-a) = r$. Convergence of $sum c_n (x-a)^n$ makes its terms bounded, say $abs(c_n (x-a)^n) <= M$, so

$
  abs(c_n (y-a)^n) <= M abs((y-a)/(x-a))^n quad "with" abs((y-a)/(x-a)) < 1.
$

Comparison with a geometric series shows that $sum c_n (y-a)^n$ converges absolutely. In particular every power series converges absolutely inside its radius of convergence and diverges outside it.
