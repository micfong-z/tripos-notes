Examples grounded in the definition:

- $a_n = 1 - (1)/(n)$ converges to $1$: given $epsilon > 0$, the Axiom of Archimedes supplies $N > (1)/(epsilon)$, and then $abs(a_n - 1) = (1)/(n) <= (1)/(N) < epsilon$ for all $n >= N$.

- The sequence defined by $a_n = (1)/(n)$ for even $n$ and $a_n = 0$ for odd $n$ converges to $0$ by the same choice of $N$, treating the two parities separately.

- $a_n = 1 - (1)/(2^n)$ converges to $1$, since $(1)/(2^n) <= (1)/(n) <= (1)/(N) < epsilon$.

- The alternating sequence $a_n = (-1)^n$ diverges: with $epsilon = 1$, no tail can stay within $epsilon$ of any proposed limit, since $abs(1 - l) + abs(-1 - l) >= 2$. Divergence does not require the terms to tend to infinity.
