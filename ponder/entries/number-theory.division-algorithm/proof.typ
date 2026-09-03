Induction on $n$. The statement is true for $n = 1$. For the inductive step, let $n >= 2$ and suppose the statement holds for all natural numbers $1 <= m <= n-1$, so $n - 1 = q k + r$ for some $q, r in ZZ$ with $0 <= r <= k-1$. If $r < k-1$, then
$ n = (n - 1) + 1 = q k + (r + 1) $
with $0 <= r + 1 <= k-1$. Otherwise $r = k-1$, and then
$ n = (n - 1) + 1 = (q + 1) k + 0. $
Either way $n$ has the desired form.

The values obtained are unique: if $n = q k + r = q' k + r'$, then $(q - q') k = r' - r$. Since $0 <= r, r' <= k-1$, we have $-(k-1) <= r' - r <= k-1$, and the only multiple of $k$ in this range is $0$. Hence $r' = r$ and therefore $q' = q$.
