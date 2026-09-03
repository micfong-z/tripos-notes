Let $s_k = sum_(n<=k) a_n -> s$. For $epsilon > 0$ there is an $N$ with $abs(s_k - s) < epsilon$ and $sum_(k>=N) abs(a_k) < epsilon$ for all $k >= N$.

Since $sigma$ is a bijection, there is an $M >= N$ such that $a_1, ..., a_N$ all occur among $a'_1, ..., a'_M$. Hence for $m >= M$, the rearranged partial sum contains every term of $s_N$, and whatever remains comes from the small tail:
$
  abs(sum_(n=1)^m a'_n - s) <= abs(s_N - s) + sum_(k>=N) abs(a_k) < 2 epsilon.
$
So the rearranged series converges to $s$ as well.
