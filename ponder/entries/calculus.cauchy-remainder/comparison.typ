Take $f(x) = x^q$ with $q in QQ$, smooth on $(0, oo)$, and expand about $1$: the Taylor polynomial is
$
  T_(n-1, f, 1)(x) = sum_(k=0)^(n-1) binom(q, k) x^k,
$
and $R_(n, f, 1)(x) = (1+x)^q - sum_(k=0)^(n-1) binom(q, k) x^k$ on $(-1, 1)$.

The Lagrange form gives $exists theta$ with $R_(n, f, 1)(x) = binom(q, n) (1 + theta x)^(q-n) x^n$. For $n >= q$ and $x in (0, 1)$ this is bounded by $abs(binom(q, n)) x^n -> 0$, but the argument fails on $(-1, 0)$.

The Cauchy form instead writes
$
  R_(n, f, 1)(x)
    = q binom(q-1, n-1) ((1-theta)/(1+theta x))^(n-1) (1 + theta x)^(q-1) x^n.
$
Since $1 + theta x = (1-theta) + theta (1 + x) >= 1 - theta$, the quotient $((1-theta)/(1+theta x))^(n-1)$ is at most $1$, and $(1 + theta x)^(q-1)$ stays bounded independently of $n$. Hence $abs(R_(n, f, 1)(x)) <= C abs(binom(q - 1, n-1) x^(n-1)) -> 0$ as $n -> oo$ for every $x in (-1, 1)$: exponentially small, on the whole interval.
