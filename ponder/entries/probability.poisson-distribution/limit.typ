Consider the number of customers arriving at a shop during $[0, 1]$, and discretise the interval into $[(i-1)/N, i/N]$ with $i = 1, ..., N$, each subinterval carrying a small probability $p = lambda/N$ of a customer arriving. Then
$
  PP(k "customers have arrived") & = binom(N, k) p^k (1 - p)^(N - k) \
                                 & = lambda^k /k! dot (N (N-1) ... (N-k+1))/N^k dot (1 - lambda/N)^(N-k) \
                                 & -> (lambda^k ee^(-lambda)) / (k!) quad "as" quad N -> oo.
$
Poisson probabilities therefore arise as limits of binomial probabilities.
