Any $2 times 2$ complex matrix $matbold(A)$ is similar to one of:

1. $mat(lambda_1, 0; 0, lambda_2)$ with $lambda_1 != lambda_2$;
2. $mat(lambda, 0; 0, lambda)$;
3. $mat(lambda, 1; 0, lambda)$.

In case 1 the eigenvectors $vb(v_1), vb(v_2)$ form a basis and $matbold(B)$ is diagonal. In case 2 the same holds with a repeated eigenvalue of full geometric multiplicity. In case 3, where $M_(lambda) = 2$ but $m_(lambda) = 1$, take an eigenvector $vb(v)$ and extend it to a basis ${vb(v), vb(w)}$; then $matbold(A) vb(w) = alpha vb(v) + lambda vb(w)$ with $alpha != 0$, and replacing $vb(w)$ by $vb(u) = alpha vb(v)$ makes the matrix of the map exactly $mat(lambda, 1; 0, lambda)$.
