Suppose $vb(v_1), ..., vb(v_r)$ were linearly dependent, so $sum_(j = 1)^r alpha_j vb(v_j) = vb(0)$ for scalars $alpha_j$ not all zero. Take the minimal $p$ for which there are $alpha_1, ..., alpha_p != 0$ with $sum_(j = 1)^p alpha_j vb(v_j) = vb(0)$. Applying $matbold(A) - lambda_1 matbold(I)$,

$ (matbold(A) - lambda_1 matbold(I)) sum_(j = 1)^p alpha_j vb(v_j) = sum_(j > 1) alpha_j (lambda_j - lambda_1) vb(v_j) = vb(0), $

a linear combination of eigenvectors with $p - 1$ non-zero coefficients, contradicting the minimality of $p$.
