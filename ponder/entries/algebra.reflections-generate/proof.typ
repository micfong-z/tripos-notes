Use induction on $n$. For $n = 1$, $O(1) = {plus.minus 1}$ and the matrix $mat(-1)$ is a reflection. For the inductive step, set $vb(v) = vb(e_n) - matbold(A) vb(e_n)$. Then $matbold(S)_vb(v) matbold(A)$ fixes $vb(e_n)$ and preserves the hyperplane $P_(vb(e_n)) = RR^(n-1) times {0}$.

By induction, its restriction to this hyperplane is a product of at most $n-1$ reflections. Both sides also fix $vb(e_n)$, so the equality holds on $RR^n$. Multiplying by $matbold(S)_vb(v)$ gives a product of at most $n$ reflections for $matbold(A)$.
