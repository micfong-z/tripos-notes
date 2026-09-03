Let $T ~ "Exp"(lambda)$ and discretise time by $T_n = floor(n T)$ with $n in NN$. Then, for every $k in NN$,
$
  PP(T_n >= k) = PP(n T >= k) = PP(T >= k \/ n) = (ee^(-lambda \/ n))^k,
$
so $T_n$ is a geometric random variable with parameter $p = 1 - ee^(-lambda \/ n) approx lambda \/ n$ as $n -> oo$. Hence $T_n \/ n$ converges in distribution to $T$: the exponential distribution is the continuous analogue of the geometric distribution.
