Induction on $n$ proves existence, exactly as in the proposition above. For uniqueness, induct on $n$. The statement is true for $n = 2$. Let $n > 2$ and suppose the statement holds for all natural numbers $2 <= k <= n-1$. Suppose
$ n = p_1 p_2 ... p_k = q_1 q_2 ... q_l $
where all $p_i, q_j$ are primes. Then $p_1$ divides $q_1 ... q_l$, so by Euclid's lemma $p_1$ divides $q_j$ for some $1 <= j <= l$; since $q_j$ is prime, $p_1 = q_j$, and without loss of generality $j = 1$. Cancelling $p_1 = q_1$ from both sides leaves
$ p_2 ... p_k = q_2 ... q_l, $
a natural number less than $n$. By the inductive hypothesis $k - 1 = l - 1$ and, after reordering, $p_i = q_i$ for all $2 <= i <= k$. Hence $k = l$ and $p_i = q_i$ for all $1 <= i <= k$ after reordering.
