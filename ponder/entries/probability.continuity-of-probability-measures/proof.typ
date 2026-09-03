For an increasing sequence, define $B_1 = A_1$ and $B_n = A_n \\ A_(n-1)$ for $n >= 2$. Then $(B_n)$ is a disjoint collection with $union.big_(k=1)^n B_k = A_n$, so countable additivity gives $PP(A_n) = sum_(k=1)^n PP(B_k)$. This converges to $sum_(k=1)^oo PP(B_k) = PP(union.big_(k=1)^oo B_k) = PP(union.big_(n in NN) A_n)$.

For a decreasing sequence, the complements $(A_n^(cp))$ form an increasing sequence in $cal(F)$ with union $(inter.big_(n in NN) A_n)^(cp)$. Applying the increasing case and using $PP(A^cp) = 1 - PP(A)$,
$
  lim_(n->oo) PP(A_n) = 1 - PP((inter.big_(n in NN) A_n)^(cp)) = PP(inter.big_(n in NN) A_n).
$
