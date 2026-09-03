Write ${1, ..., overline(j), ..., n}$ for the set of indices ${1, 2, ..., n} \\ {j}$. Splitting the defining sum of the determinant according to the value of $i_j$:
$
  det matbold(M) &= sum_(i_1 ... i_n = 1)^n epsilon_(i_1 ... i_n) M_(i_1 1) ... M_(i_n n) \
                 &= sum_(i_j = 1)^n M_(i_j j) sum_(i_1 ... overline(i_j) ... i_n = 1)^n epsilon_(i_1 ... i_n) M_(i_1 1) ... overline(M_(i_j j)) ... M_(i_n n).
$

Consider $sigma in S_n$, the permutation that moves $i_j$ to the $j$th position and leaves everything else in its natural order. Assuming $i_j > j$, we have to perform $abs(j - i_j)$ transpositions, so $epsilon(sigma) = (-1)^(j - i_j)$. For the corresponding permutation $rho in S_(n-1)$ of the remaining indices, $rho sigma$ reorders $(1, ..., n)$ to $(i_1, ..., i_n)$, so
$
  epsilon_(i_1 ... i_n) = epsilon(rho) epsilon(sigma) = (-1)^(j - i_j) epsilon_(i_1 ... overline(i_j) ... i_n).
$
Hence
$
  det matbold(M) &= sum_(i_j = 1)^n M_(i_j j) (-1)^(j - i_j) M^(i_j j) \
                 &= sum_(i_j=1)^n M_(i_j j) Delta_(i_j j) \
                 &= sum_(i=1)^n M_(i j) Delta_(i j).
$
