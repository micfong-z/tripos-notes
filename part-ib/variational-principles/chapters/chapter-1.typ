#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

// Hiloledsosalt & Tromba notes

#lecture-separator(lecture: 1, date: "2026-05-01")

The motivational problem is: how do we find the shortest point between two points,

1. in Euclidean space?
2. on surface of sphere?
3. on a general curved surface?

For (1), assuming $RR^2$, we can write path as $y = y(x)$ where $a <= x <= b$. Then the length is
$
  L[y] = integral_a^b sqrt(1+(y'(x))^2) dif x.
$
We can carry out similar calculations for (2) and (3). Note that $L$ is a *functional*, which is a map from a function $y$ to $RR$.

We will develop the tools to determine minima and maxima of functionals.

= Calculus on $RR^n$

Consider $f: RR^n -> RR$, we write $(x_1, ..., x_n) in RR^n$ as $vb(x)$. Assuming that $f$ is sufficiently differentiable (at least $C^2$: twice continuously differentiable), then a point $vb(a) in RR^n$ is a *stationary point* of $f$ iff $(grad f) (vb(a)) = vb(0)$.

The Taylor expansion of $f$ around such $vb(a)$ is
$
  f(vb(x)) = f(vb(a)) + 1/2 (vb(x) - vb(a))^T hess f(vb(a)) (vb(x) - vb(a)) + ...
$
where the Hessian matrix $hess f$ is the matrix of second derivatives of $f$:
$
  H_(i j) = (hess f)_(i j) = (∂^2 f) / (∂ x_i ∂ x_j).
$
WLOG assume that $vb(a) = vb(0)$. Then
$
  f(vb(x)) - f(vb(0)) = (1)/(2) x_i H_(i j) x_j + O(|vb(x)|^3).
$

Since $H$ is symmetric, we can diagonalise it by an orthogonal transformation.

Let $x_i = R_(i j) x'_j$, where $matbold(R)$ is a rotation matrix. Then $matbold(H)' = matbold(R)^tp matbold(H) matbold(R)$. Choosing $matbold(R)$ such that $matbold(H)'$ is diagonal,
$
  matbold(H)'_(i j) =dmat(lambda_1, lambda_2, dots.down, lambda_n) quad "where" lambda_i "are eigenvalues of" matbold(H).
$
By IA Vectors and Matrices, since $matbold(H)$ is symmetric, $lambda_i in RR$. Then
$
  f(vb(x)) - f(vb(0)) = (1)/(2) lambda_i x'^2_i + O(|vb(x)|^3).
$

- If $lambda_i > 0$ for all $i$, then $f(bold(x)) > f(bold(0))$ for small enough $vb(x)$, so $vb(0)$ is a *local minimum*.

- If $lambda_i < 0$ for all $i$, then $vb(0)$ is a *local maximum*.

- If $lambda_i$ have different signs, then $vb(0)$ is a *saddle point*.

The remaining case (*degenerate case*) is when some $lambda_i$ are zero. In this case, the second order term in the expansion does not give us any information, so the nature depends on $O(|vb(x)|^3)$ terms.

In the $n=2$ case, we have $det matbold(H) = lambda_1 lambda_2$ and $tr matbold(H) = lambda_1 + lambda_2$. So

- $det matbold(H) > 0, tr matbold(H) > 0$ implies $lambda_1, lambda_2 > 0$ and hence local minimum.

- $det matbold(H) > 0, tr matbold(H) < 0$ implies $lambda_1, lambda_2 < 0$ and hence local maximum.

- $det matbold(H) < 0$ implies $lambda_1, lambda_2$ have different signs and hence saddle point.

- $det matbold(H) = 0$ is the degenerate case.

#remark[
  If a local minimum is not a global minimum, then either

  - there exists a stationary point that is the global minimum, or

  - the global minimum occurs on the boundary of the domain of $f$, or

  - $f$ has no global minimum.
]

#example[
  Consider $f: RR^2 -> RR$ where $f(x, y) = x^3 + y^3 - 3 x y$. Then $grad f = (3 x^2 - 3 y, 3 y^2 - 3 x)$.

  So the stationary points are $(0, 0), (1, 1)$. The Hessian matrix is
  $
    matbold(H) = mat(6 x, -3; -3, 6 y) => det matbold(H) = 9 (4x y - 1), tr matbold(H) = 6 (x + y).
  $

  At $(1, 1)$, $det matbold(H) > 0, tr matbold(H) > 0$, so it is a local minimum. At this point, $f(1, 1) = -1$.

  At $(0, 0)$, $det matbold(H) < 0$, so it is a saddle point. The eigenvalues and eigenvectors are

  - $lambda_1 = -3, vb(e_1) = (1, 1)$
  - $lambda_2 = 3, vb(e_2) = (1, -1)$

  Therefore $(0, 0)$ is a local maximum along $y=x$ and a local minimum along $y=-x$.

  Note that for $f$, $exists.not$ global minimum or maximum, since it is not bounded as $x^2 + y^2 -> oo$.
]
