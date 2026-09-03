Suppose first that such $A$ and $epsilon$ exist. Then
$
  (f(a+h) - f(a))/h = A + epsilon(h) abs(h)/h -> A
$
as $h -> 0$, because $epsilon(h) -> 0$ while $abs(h)/h$ is bounded. Hence $f$ is differentiable at $a$ with $f'(a) = A$.

Conversely, if $f$ is differentiable at $a$, choose $A = f'(a)$, so that $lim_(h->0) (f(a+h) - f(a) - A h)/(h) = 0$. Define
$
  epsilon (h) = cases(
    (f(a+h) - f(a) - A h)/(abs(h)) quad & "if" h != 0,
    0 quad & "if" h = 0.
  )
$
Then $epsilon(h) -> 0$ as $h -> 0$ and the required equality holds.

This characterization is what makes the chain rule transparent: composing two affine approximations with error terms $epsilon_f (h) abs(h)$ and $epsilon_g (k) abs(k)$ produces again an affine approximation with a vanishing relative error.
