Since $matbold(A)$ is real symmetric there is a real orthogonal $matbold(P)$ whose columns are orthonormal eigenvectors $vb(u_1), ..., vb(u_n)$, with

$ matbold(P)^TT matbold(A) matbold(P) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n). $

Setting $vb(x') = matbold(P)^TT vb(x)$ diagonalises the form:

$ cal(F)(vb(x)) = vb(x')^TT matbold(D) vb(x') = sum_(i = 1)^n lambda_i (x'_i)^2. $

Here $vb(x')$ is the representation of $vb(x)$ in the eigenbasis, with coordinates $x'_i = vb(u_i) dot vb(x)$; the new axes along the directions of the $vb(u_i)$ are called the *principal axes* of the quadratic form. Because $matbold(P)$ is orthogonal, lengths are preserved: $abs(vb(x))^2 = x_i x_i = x'_i x'_i$.
