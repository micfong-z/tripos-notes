Sampling $y$ at equally spaced points $x_n$ with spacing $h$ replaces each derivative by a
combination of neighbouring sample values, _e.g._
$ eval((dif^(2) y)/(dif x^(2)))_(x_n) approx (y(x_n + h) - 2 y(x_n) + y(x_n - h))/(h^(2)) approx (y_(n+1) - 2 y_n + y_(n-1))/(h^(2)). $
A 2nd order ODE therefore becomes a discrete equation relating $y_(n+2)$, $y_(n+1)$ and $y_n$, such as
$ a y_(n+2) + b y_(n+1) + c y_n = f_n $
with constants $a$, $b$, $c$. Such equations are solved with the same
complementary-function and particular-integral methods used for ODEs.
