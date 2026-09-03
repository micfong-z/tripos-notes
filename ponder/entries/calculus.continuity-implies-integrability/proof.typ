By the Extreme Value Theorem, $f$ continuous on $[a, b]$ with $abs(a), abs(b) < oo$ is bounded.

The proof proceeds by contrapositive: if $f$ is not integrable, then $f$ is not continuous. If $f$ is not integrable, there is $epsilon > 0$ such that for every partition $cal(P)$ of $[a, b]$,

$
  epsilon < U(f, cal(P)) - L(f, cal(P)) & = sum_(j=1)^n abs(I_j) (sup_(I_j) f - inf_(I_j) f) \
                                        & <= sum_(k=1)^n abs(I_k) max_(1 <= j <= n) (sup_(I_j) f - inf_(I_j) f) \
                                        & = (b-a) max_(1 <= j <= n) (sup_(I_j) f - inf_(I_j) f),
$

hence some $j$ has $sup_(I_j) f - inf_(I_j) f > epsilon/(b-a)$. By the Extreme Value Theorem there are $y, z in [x_(j-1), x_j]$ with $f(y) - f(z) > (epsilon)/(b - a)$.

This applies in particular to the uniform partitions $cal(P)_n$: for each $n$ pick $y_n, z_n$ with $abs(y_n - z_n) <= (b-a)/(n)$ and $abs(f(y_n) - f(z_n)) > epsilon/(b-a)$. The sequences $(y_n)$ and $(z_n)$ are bounded, so by the Bolzano-Weierstrass Theorem they have convergent subsequences $(y_(n_k)), (z_(n_k))$. Their limits satisfy $y = z$, since

$
  abs(z_n_k - y_n_k) < (b-a)/(n_k) -> 0 quad "as" k -> oo,
$

yet $abs(f(y_(n_k)) - f(z_(n_k))) > (epsilon)/(b-a)$ along the same indices, so $f(y_(n_k))$ and $f(z_(n_k))$ do not converge to the same limit. Thus $f$ is not sequentially continuous, hence not continuous.
