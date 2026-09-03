For a function $f(x_1, x_2, ..., x_N)$, the signature is given by the signs of
$
  mat(delim: "|", f_(x_1 x_1)), quad mat(delim: "|", f_(x_1 x_1), f_(x_1 x_2); f_(x_2 x_1), f_(x_2 x_2)), quad ..., quad mat(delim: "|", f_(x_1 x_1), ..., f_(x_1 x_N); dots.v, dots.down, dots.v; f_(x_N x_1), ..., f_(x_N, x_N)),
$
the determinants of the leading principal minors of the Hessian matrix. Denoting these determinants $abs(matbold(H_1)), abs(matbold(H_2)), ..., abs(matbold(H_N)) = abs(matbold(H))$, the last of them is the full determinant $abs(matbold(H))$.

For example, at the stationary point $(5, 25)$ of $f(x, y) = 4 x^3 - 12x y + y^2 + 10 y + 6$,
$ abs(matbold(H_1)) = 120 > 0, quad abs(matbold(H)) = 96 > 0, $
giving the signature $+, +$, while at $(1, 1)$,
$ abs(matbold(H_1)) = 24 > 0, quad abs(matbold(H)) = 96 < 0, $
giving the signature $+, -$.
