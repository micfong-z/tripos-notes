Suppose $a > 1$. By the definition of limit there is an $N$ with $root(n, a_n) > 1$ for all $n >= N$, so $a_n > 1$ for all $n >= N$, and $sum a_n$ diverges by the $n$th term test.

Suppose $a < 1$. Pick $r$ with $a < r < 1$. By the definition of limit, $root(n, a_n) < r$, i.e. $a_n <= r^n$, for all $n >= N$. Since $sum r^n$ is a convergent geometric series, the comparison test gives convergence of $sum a_n$.
