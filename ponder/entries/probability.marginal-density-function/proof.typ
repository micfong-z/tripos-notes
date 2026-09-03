Suppose $bold(X) = (X_1, ..., X_n)^tp$ has density $f$. Then
$
  PP(X_1 <= x) & = PP(X_1 <= x, X_2 in RR, ..., X_n in RR) \
               & = integral_(-oo)^x (integral_(-oo)^(oo) ... integral_(-oo)^(oo) f(x_1, ..., x_n) dif x_n ... dif x_2) dif x_1,
$
so the distribution function of $X_1$ is an integral with integrand $f_(X_1)$, which is therefore the density of $X_1$.
