For $x_1 < x_2 < ... < x_n$, each of the $n!$ orderings of a realisation is equally likely, so
$
  PP(Y_1 <= x_1, ..., Y_n <= x_n) & = n! integral_(-oo)^(x_1) integral_(u_1)^(x_2) ... integral_(u_(n-1))^(x_n) f(u_1) f(u_2) ... f(u_n) dif u_n ... dif u_1,
$
and differentiating,
$
  f_(Y_1, ..., Y_n) (x_1, ..., x_n) = cases(
    n! f(x_1) f(x_2) ... f(x_n) & quad "for" x_1 < x_2 < ... < x_n,
    0 & quad "otherwise".)
$
