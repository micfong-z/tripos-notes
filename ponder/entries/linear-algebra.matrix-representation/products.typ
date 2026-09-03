If $T: V -> W$ is represented by the matrix $matbold(M)$ and $S: U -> V$ is represented by $matbold(N)$, then the composition $T compose S: U -> W$ is represented by the matrix product $matbold(L) = matbold(M) matbold(N)$ with coefficients
$ L_(i k) = sum_j M_(i j) N_(j k) = bold(R_i)(matbold(M)) dot bold(C_k)(matbold(N)), $
the dot product of row $i$ of $matbold(M)$ with column $k$ of $matbold(N)$. The number of columns of $matbold(M)$ must equal the number of rows of $matbold(N)$ for the product to be defined, and $matbold(L)$ has the same number of rows as $matbold(M)$ and the same number of columns as $matbold(N)$. For all matrices for which the products are defined, and scalars $lambda, mu$:
- $(lambda matbold(M) + mu matbold(N)) matbold(L) = lambda (matbold(M) matbold(L)) + mu (matbold(N) matbold(L))$
- $matbold(L)(lambda matbold(M) + mu matbold(N)) = lambda (matbold(L) matbold(M)) + mu (matbold(L) matbold(N))$
- $matbold(M)(matbold(N) matbold(L)) = (matbold(M) matbold(N)) matbold(L)$
