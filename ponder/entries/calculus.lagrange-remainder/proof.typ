By translation invariance it suffices to take $a = 0$; otherwise apply the argument to $g(x) = f(x + a)$.

Let $B$ be chosen so that $phi(h) = 0$, where
$
  phi(t) = f(t) - T_(n-1, f, 0)(t) - t^n/(n!) B.
$
Then $phi(0) = 0$ and $phi^(k)(0) = 0$ for all $k < n$. Applying Rolle's theorem to $phi$ between $0$ and $h$ gives $theta_1 in (0, 1)$ with $phi'(theta_1 h) = 0$; applying it again to $phi'$ between $0$ and $theta_1 h$ gives $theta_2$; after $n$ steps there is $theta = theta_n dots.h theta_1 in (0, 1)$ with
$
  phi^((n))(theta h) = f^((n))(theta h) - B = 0.
$
Hence $B = f^((n))(theta h)$, so
$
  R_(n, f, 0)(h) = f(h) - T_(n-1, f, 0)(h) = h^n/(n!) f^((n))(theta h).
$
A second proof, applying Rolle's theorem to a family of auxiliary functions $phi_p (t) = g(t) - (h-t)^p/(h^p) g(0)$, yields the Cauchy form of the remainder as well.
