Let $X subset.eq CC$ be closed and bounded. If $f: X -> CC$ is continuous, then $f(X)$ is a bounded closed subset of $CC$.

*Boundedness.* If $f(X)$ were unbounded, choose $x_n in X$ with $abs(f(x_n)) > n$. Then $(x_n)$ is bounded since $X$ is, so by Bolzano-Weierstrass a subsequence $(x_(n_k))$ converges to some $x$; closedness of $X$ gives $x in X$. But $abs(f(x_(n_k))) > n_k >= k$, so $(f(x_(n_k)))$ cannot converge as $k -> oo$, contradicting continuity of $f$ at $x$. Hence $f(X)$ is bounded.

*Closedness.* Take $(y_n)$ in $f(X)$ converging to $y in CC$, and pick $x_n in X$ with $f(x_n) = y_n$. The sequence $(x_n)$ lies in the bounded set $X$, so copying the argument above yields a subsequence $x_(n_k) -> x in X$. By continuity of $f$,

$
  y = lim_(k -> oo) y_(n_k) = lim_(k -> oo) f(x_(n_k)) = f(lim_(k->oo) x_(n_k)) = f(x),
$

hence $y = f(x) in f(X)$.
