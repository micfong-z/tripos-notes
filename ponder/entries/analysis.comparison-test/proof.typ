Let $s_k$ and $r_k$ be the partial sums of $sum a_n$ and $sum b_n$. Because $a_n, b_n >= 0$, both sequences of partial sums are increasing. Since $s_k -> s$, we have $s_k <= s$ for all $k$, so
$
  sum_(n=1)^k b_n <= sum_(n=1)^k a_n <= s:
$
$(r_k)$ is increasing and bounded above by $s$, hence converges by the monotone convergence theorem. Only the tail matters, so the hypothesis may hold merely for all sufficiently large $n$.
