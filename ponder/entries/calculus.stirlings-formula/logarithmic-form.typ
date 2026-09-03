$log(n!) ~ n log n$ as $n -> oo$.

Writing $l_n = log(n!)$ and comparing $log x$ with $log floor(x)$ and $log floor(x+1)$, integration from $1$ to $n$ gives

$
  n log n - n + 1 <= l_n <= (n+1) log(n+1) - (n+1) + 1,
$

and dividing by $n log n$ shows that $(l_n)/(n log n) -> 1$.
