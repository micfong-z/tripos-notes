Let $s_k = sum_(n=1)^k (-1)^(n+1) a_n$ be the partial sums. Grouping consecutive terms,
$
  s_(2k) = (a_1 - a_2) + (a_3 - a_4) + ... + (a_(2k-1) - a_(2k)), quad
  s_(2k+1) = a_1 + (-a_2 + a_3) + ... + (-a_(2k) + a_(2k+1)),
$
so $(s_(2k))$ is increasing and $(s_(2k+1))$ is decreasing. Since $s_(2k+1) - s_(2k) = a_(2k+1) >= 0$,
$
  a_1 - a_2 = s_2 <= s_(2k) <= s_(2k+1) <= s_1 = a_1,
$
so both subsequences are bounded and converge by the monotone convergence theorem. Their limits agree because $tilde(s) - s = lim_(k->oo) (s_(2k+1) - s_(2k)) = lim_(k->oo) a_(2k+1) = 0$. A sequence whose odd and even subsequences both converge to the same limit converges to that limit, hence $s_k -> s$.
