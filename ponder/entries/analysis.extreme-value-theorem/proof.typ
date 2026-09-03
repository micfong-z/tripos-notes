Let $M = sup f(X)$. For every $n in NN$, $M - 1/n$ is not an upper bound for $f(X)$, so there is $y_n in f(X)$ with

$
  M - 1/n < y_n <= M.
$

Writing $y_n = f(x_n)$ with $x_n in X$ gives a sequence on $X$ with $M - 1/n < f(x_n) <= M$. Since $f$ is continuous,

$
  M <= lim_(n->oo) f(x_n) <= M quad => quad lim_(n->oo) f(x_n) = M.
$

By closedness of $X$, the image $f(X)$ is closed as well, so $M in f(X)$: there is $a in X$ with $f(a) = M$, that is, $a = sup f(X)$ attained. The infimum case is proved similarly, giving $b in X$ with $f(b) = inf f(X)$.
