*Property (5).* Suppose $bold(C_i)(matbold(M)) + lambda bold(C_j)(matbold(M)) = 0$ for some $i != j$ and scalar $lambda$. Define $matbold(N)$ by
$
  N_(i s) = cases(
    M_(i s) & "if" s != i,
    M_(i s) + lambda M_(j s) & "if" s = i
  ).
$
By multilinearity in the columns, $det(matbold(N)) = det(matbold(M)) + underbracket(lambda det("matrix with column" i = "column" j), = 0) = det(matbold(M))$. But the $i$th column of $matbold(N)$ is all zeros, so $det(matbold(N)) = 0 = det(matbold(M))$.

#separator

*Property (7).* A single term satisfies
$
  M_(rho(1) 1) M_(rho(2) 2) ... M_(rho(n) n) = M_(rho(sigma(1)) sigma(1)) M_(rho(sigma(2)) sigma(2)) ... M_(rho(sigma(n)) sigma(n))
$
for every permutation $sigma$. Taking $rho = sigma^(-1)$, and using $epsilon(rho) = epsilon(sigma)$,
$
  det matbold(M) &= sum_(sigma in S_n) epsilon(sigma) M_(1 sigma(1)), ..., M_(n sigma(n)) \
                 &= det(matbold(M)^tp).
$

#separator

*Property (8).* Swapping columns an even or odd number of times introduces a factor of $plus.minus 1$, so
$
  det(matbold(M) matbold(N)) &= sum_sigma epsilon(sigma) sum_(k_1 dots.c k_n = 1)^n M_(sigma(1) k_1) N_(k_1 1) ... M_(sigma(n) k_n) N_(k_n n) \
                             &= sum_(k_1 dots.c k_n = 1)^n N_(k_1 1) ... N_(k_n n) underbracket([sum_sigma epsilon(sigma) M_(sigma(1) k_1) ... M_(sigma(n) k_n)], S).
$
If two indices satisfy $k_p = k_q$ for some $p != q$, then $S = 0$ by property (4). Otherwise there is a permutation $rho$ with $k_i = rho(i)$ for all $i$, and then $S = epsilon(rho) det(matbold(M))$. Therefore
$
  det(matbold(M) matbold(N)) &= sum_rho N_(rho(1) 1) ... N_(rho(n) n) epsilon(rho) det(matbold(M)) \
                             &= det(matbold(M)) det(matbold(N)).
$
In particular, if $matbold(M)$ is invertible, then $det(matbold(M^(-1))) = (det(matbold(M)))^(-1)$.

#separator

*Property (9).* If $matbold(M)$ is orthogonal, then $matbold(M)^tp matbold(M) = matbold(I)$, and thus $det(matbold(M)^tp) det(matbold(M)) = det(matbold(I)) = 1$, giving $det(matbold(M)) = plus.minus 1$.

*Property (10).* If $matbold(M)$ is unitary, then $matbold(M)^dagger matbold(M) = matbold(I)$, and thus $det(matbold(M)^dagger) det(matbold(M)) = det(matbold(I)) = 1$, giving $abs(det(matbold(M))) = 1$.
