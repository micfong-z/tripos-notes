Let $s_k = sum_(n<=k) a_n$ and $r_k = sum_(n<=k) abs(a_n)$. Since $r_k$ converges, it is Cauchy: for $k, l >= N(epsilon)$,
$
  abs(s_k - s_l) = abs(sum_(n=l+1)^k a_n) <= sum_(n=l+1)^k abs(a_n) = abs(r_k - r_l) < epsilon.
$
Thus $(s_k)$ is Cauchy, and by completeness of $RR$ and $CC$ it converges.
