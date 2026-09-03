Any $2 times 2$ complex matrix $matbold(A)$ is similar to one of:

1. $mat(lambda_1, 0; 0, lambda_2)$ with $lambda_1 != lambda_2$;
2. $mat(lambda, 0; 0, lambda)$;
3. $mat(lambda, 1; 0, lambda)$.

In case 1 the eigenvectors $bold(v_1), bold(v_2)$ form a basis and $matbold(B)$ is diagonal. In case 2 the same holds with a repeated eigenvalue of full geometric multiplicity. In case 3, where $M_(lambda) = 2$ but $m_(lambda) = 1$, take an eigenvector $bold(v)$ and extend it to a basis ${bold(v), bold(w)}$; then $matbold(A) bold(w) = alpha bold(v) + lambda bold(w)$ with $alpha != 0$, and replacing $bold(w)$ by $bold(u) = alpha bold(v)$ makes the matrix of the map exactly $mat(lambda, 1; 0, lambda)$.
