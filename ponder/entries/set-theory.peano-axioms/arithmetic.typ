Addition is defined recursively by $n + 1 = S(n)$ and $n + S(m) = S(n + m)$, and multiplication by $n times 1 = n$ and $n times S(m) = n times m + n$. Induction shows that these operations satisfy the usual rules of arithmetic: $+$ and $times$ are commutative and associative, and $times$ distributes over $+$.

Individual facts are proved the same way. The computation
$
  1 + 2 &= 1 + S(1) \
        &= S(1 + 1) \
        &= S(S(1)) \
        &= S(1) + 1 \
        &= 2 + 1
$
shows $1 + 2 = 2 + 1$ directly. For general $n + m = m + n$, one inducts on $m$ with base case $m = 1$, where the claim becomes $n + 1 = 1 + n$.
