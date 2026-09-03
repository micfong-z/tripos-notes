Since $matbold(A)$ is real symmetric there is a real orthogonal $matbold(P)$ whose columns are orthonormal eigenvectors $bold(u_1), ..., bold(u_n)$, with

$ matbold(P)^tp matbold(A) matbold(P) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n). $

Setting $bold(x') = matbold(P)^tp bold(x)$ diagonalises the form:

$ cal(F)(bold(x)) = bold(x')^tp matbold(D) bold(x') = sum_(i = 1)^n lambda_i (x'_i)^2. $

Here $bold(x')$ is the representation of $bold(x)$ in the eigenbasis, with coordinates $x'_i = bold(u_i) dot bold(x)$; the new axes along the directions of the $bold(u_i)$ are called the *principal axes* of the quadratic form. Because $matbold(P)$ is orthogonal, lengths are preserved: $abs(bold(x))^2 = x_i x_i = x'_i x'_i$.
