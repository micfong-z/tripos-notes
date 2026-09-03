1. *Size $2 times 2$.* For $matbold(A) = mat(A_(11), A_(12); A_(21), A_(22))$ one computes $chi_(matbold(A))(t) = t^2 - (A_(11) + A_(22)) t + (A_(11) A_(22) - A_(12) A_(21))$, and direct substitution of $matbold(A)$ verifies $chi_(matbold(A))(matbold(A)) = matbold(0)$.

2. *Diagonalisable matrices.* With $matbold(P)^(-1) matbold(A) matbold(P) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n)$, powers of $matbold(D)$ act entrywise, so

$ chi_(matbold(A))(matbold(D)) = mat(chi_(matbold(A))(lambda_1), 0, ..., 0; 0, chi_(matbold(A))(lambda_2), ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., chi_(matbold(A))(lambda_n)) = matbold(0). $

Since $matbold(A^r) = matbold(P) matbold(D)^r matbold(P)^(-1)$, we get $chi_(matbold(A))(matbold(A)) = matbold(P) chi_(matbold(A))(matbold(D)) matbold(P)^(-1) = matbold(0)$.

3. *General case.* Let $matbold(M) := matbold(A) - t matbold(I)$, so $chi_(matbold(A))(t) = det matbold(M)$. The adjugate satisfies $tilde(matbold(M)) matbold(M) = det(matbold(M)) matbold(I)$, and writing $tilde(matbold(M)) = sum_(r = 0)^(n - 1) matbold(B_r) t^r$ and comparing coefficients of $t$ gives $n + 1$ identities such as $c_0 matbold(I) = matbold(B_0) matbold(A)$ and $c_n matbold(I) = - matbold(B_(n-1))$. Evaluating each at $matbold(A)$ and adding yields $sum_(r = 0)^n c_r matbold(A)^r = matbold(0)$.
