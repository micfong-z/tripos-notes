First, a finite form of Jensen's inequality: for a convex function $f$ and $x_1, ..., x_n in RR$,
$
  (1)/(n) sum_(k=1)^n f(x_k) >= f((1)/(n) sum_(k=1)^n x_k).
$
This follows by taking a random variable $X$ with $PP(X = x_i) = 1/n$ for all $i$, so that $EE[f(X)] = (1)/(n) sum_(k=1)^n f(x_k)$ and $f(EE[X]) = f((1)/(n) sum_(k=1)^n x_k)$.

Now let $f(x) = -log x$ for $x > 0$, which is convex. Applying the claim,
$
  (1)/(n) sum_(k=1)^n -log x_k >= -log((1)/(n) sum_(k=1)^n x_k),
$
and rearranging with $log$ monotone gives
$
  log((product_(k=1)^n x_k)^(1/n)) <= log((1)/(n) sum_(k=1)^n x_k).
$
