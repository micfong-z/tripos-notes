The scaling property: if $g(x)$ is a solution of the homogeneous equidimensional ODE with $f(x) = 0$, then so is $y = g(alpha x)$ for any constant $alpha$.

Proof. By the chain rule, $dv(g(alpha x), x) = alpha g'(alpha x)$ and $x^2 dv(y, x, 2) = (alpha x)^2 g''(alpha x)$, so

$
  a x^2 dv(y, x, 2) + b x dv(y, x) + c y &= a u^2 g''(u) + b u g'(u) + c g(u) \
  &= 0
$

with $u = alpha x$, since $g$ solves the homogeneous equation.

Solving. Since $x dv(, x) (x^k) = k x^k$, the function $x^k$ is an eigenfunction of $x dv(, x)$ with eigenvalue $k$. Trying $y = x^k$ in the homogeneous equation gives

$
  a k (k-1) + b k + c = 0 quad <=> quad a k^2 + (b - a) k + c = 0.
$

For distinct roots $k_1 != k_2$ the complementary functions are

$
  y_c (x) = C_1 x^(k_1) + C_2 x^(k_2).
$

Equivalently, substituting $z = ln x$ turns the ODE into one with constant coefficients,

$
  a dv(y, z, 2) + (b - a) dv(y, z) + c y = f(e^z),
$

whose characteristic equation $a lambda^2 + (b - a) lambda + c = 0$ is the same as above. For the degenerate case $k_1 = k_2 = k_1$,

$
  y_c(x) = A x^(k_1) + B (ln x) x^(k_1).
$
