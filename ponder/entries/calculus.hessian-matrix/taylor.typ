Writing $delta bold(x) = (delta x, delta y)$, the second-order term of the multivariate Taylor expansion of $f(x, y)$ about $bold(x_0)$ is a quadratic form in the Hessian matrix:
$
  (1/2) mat(delta x, delta y) matbold(H) vec(delta x, delta y) = (1/2) [(delta x)^2 (∂^2 f)/(∂ x^2) + 2 (delta x)(delta y) (∂^2 f)/(∂ x ∂ y) + (delta y)^2 (∂^2 f)/(∂ y^2)].
$
In coordinate-independent form,
$
  f(bold(x_0) + delta bold(x)) = f(bold(x_0)) + delta bold(x) dot eval(bold(nabla) f)_(bold(x_0)) + (1/2) (delta bold(x))^tp eval(matbold(H))_(bold(x_0)) (delta bold(x)) + ...
$
so near a stationary point $bold(x_0)$, where $eval(bold(nabla) f)_(bold(x_0)) = bold(0)$, the shape of $f$ is governed by the Hessian alone.
