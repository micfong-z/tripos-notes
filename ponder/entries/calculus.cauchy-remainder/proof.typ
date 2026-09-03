Again take $a = 0$. Let
$
  g(t) = f(h) - sum_(k=0)^(n-1) (f^((k))(t))/(k!) (h-t)^k,
$
so that $g(0) = f(h) - T_(n-1, f, 0)(h) = R_(n, f, 0)(h)$. The function $g$ is continuous on $[0, h]$ and differentiable on $(0, h)$ with
$
  g'(t) = -(f^((n))(t))/((n - 1)!)(h-t)^(n-1).
$
For $p in {1, dots, n}$ set $phi_p (t) = g(t) - (h-t)^p/(h^p) g(0)$; then $phi_p (h) = phi_p (0) = 0$, so Rolle's theorem provides $theta in (0, 1)$ with $phi'_p (theta h) = 0$, that is
$
  g'(theta h) + (p(1-theta)^(p-1))/(h) g(0) = 0.
$
Substituting $g'$ and rearranging,
$
  f(h) - T_(n-1, f, 0)(h) = h^n/(p (n-1)!) (1-theta)^(n-p) f^((n))(theta h).
$
Choosing $p = 1$ gives the Cauchy remainder, while $p = n$ recovers the Lagrange form.
