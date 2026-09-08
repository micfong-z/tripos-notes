Writing $delta vb(x) = vecrow(delta x, delta y)$, the second-order term of the multivariate Taylor expansion of $f(x, y)$ about $vb(x_0)$ is a quadratic form in the Hessian matrix:
$
  (1/2) mat(delta x, delta y) matbold(H) vec(delta x, delta y) = (1/2) [(delta x)^2 pdv(f, x, 2) + 2 (delta x)(delta y) pdv(f, x, y) + (delta y)^2 pdv(f, y, 2)].
$
In coordinate-independent form,
$
  f(vb(x_0) + delta vb(x)) = f(vb(x_0)) + delta vb(x) dot eval(grad f)_(vb(x_0)) + (1/2) (delta vb(x))^TT eval(matbold(H))_(vb(x_0)) (delta vb(x)) + ...
$
so near a stationary point $vb(x_0)$, where $eval(grad f)_(vb(x_0)) = vb(0)$, the shape of $f$ is governed by the Hessian alone.
