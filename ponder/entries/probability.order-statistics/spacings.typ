Minima of independent exponentials are again exponential: if $X ~ "Exp"(lambda)$ and $Y ~ "Exp"(mu)$ are independent, then for $z > 0$,
$
  PP(Z <= z) = 1 - PP(X > z) PP(Y > z) = 1 - ee^(-(lambda + mu) z),
$
so $Z = min(X, Y) ~ "Exp"(lambda + mu)$; more generally $min(X_1, ..., X_n)^tp ~ "Exp"(sum_(i=1)^n lambda_i)$ for independent $X_i ~ "Exp"(lambda_i)$.

Now let $X_1, ..., X_n$ be i.i.d. $"Exp"(lambda)$ with order statistics $Y_i = X_((i))$ and spacings
$
  Z_1 = Y_1, quad Z_2 = Y_2 - Y_1, quad ... quad Z_n = Y_n - Y_(n-1).
$
The linear change of variables $bold(Z) = matbold(A) bold(Y)$ has Jacobian determinant $1$, so
$
  f_(Z_1, ..., Z_n)(z_1, ..., z_n) & = f_(Y_1, ..., Y_n)(y_1, ..., y_n) abs(det matbold(J)) \
    & = product_(i=1)^n (n - i + 1) lambda ee^(-lambda (n - i + 1) z_i).
$
The joint density factorises, so the spacings are independent with $Z_i ~ "Exp"((n - i + 1) lambda)$.
