For the stationary points of $f(x, y) = 4 x^3 - 12x y + y^2 + 10 y + 6$, the Hessian matrix is $matbold(H) = mat(24 x, -12; -12, 2)$.

At $(1, 1)$ the leading principal minors give $abs(matbold(H_1)) = 24 > 0$ and $abs(matbold(H)) = 96 < 0$: the signature $+, -$ matches neither admissible pattern, and since $abs(matbold(H)) != 0$ all eigenvalues are non-zero, so the Hessian is indefinite and $(1, 1)$ is a saddle point.

At $(5, 25)$ the minors give $abs(matbold(H_1)) = 120 > 0$ and $abs(matbold(H)) = 96 > 0$. The signature $+, +$ matches the positive definite pattern, and hence $(5, 25)$ is a local minimum.
