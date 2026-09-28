#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Constraints and Lagrange Multipliers

Consider a smooth surface $S$ in $RR^3$. Given $f: RR^3 -> RR$, we want to find the maximum or minimum value of $f$ on $S$. #fade[[_e.g._ $S$ can be a hill on Earth, $f$ can be the air temperature, and we aim to find the highest or lowest temperature on the hill.]]

To solve this, let $(u, v)$ be parameters on $S$, _i.e._, $vb(x) in S$ can be written as $vb(x)(u, v)$. We need to extremise $f(vb(x)(u, v))$. Hence we need
$
  0 & = pdv(, u) f(vb(x)(u, v)) = (grad f) dot pdv(vb(x), u), \
  0 & = pdv(, v) f(vb(x)(u, v)) = (grad f) dot pdv(vb(x), v).
$

But ${pdv(vb(x), u), pdv(vb(x), v)}$ are linearly independent vectors tangent to $S$. Hence $grad f$ is normal to $S$ at the extremum. Therefore, $vb(x)_0 in S$ is a stationary point of $f$ on $S$ iff $grad f(vb(x)_0)$ is normal to $S$ at $vb(x)_0$.

However, we don't always have an explicit parameterisation $vb(x)(u, v)$ of $S$. Instead, $S$ may be determined implicitly by a constraint $g(vb(x)) = 0$ for some  $g: RR^3 -> RR$. Hence we have the problem
$
  & "extremise"  && f \
  & "subject to" && g = 0.
$

Recall from IA Vector Calculus that $grad g$ is normal to the surface $g(vb(x)) = 0$. It follows that
$
  grad f(vb(x)_0) = lambda grad g(vb(x)_0) quad "for some" lambda in RR.
$
So, to find the stationary point $vb(x)_0$ and $lambda$, this equation has to be solved together with the constraint $g(vb(x)_0) = 0$.

== Lagrange Multipliers

Both equations can be obtained by finding unconstrained stationary points of $phi: RR^4 -> RR$ defined by
$
  phi(vb(x), lambda) := f(vb(x)) - lambda g(vb(x)).
$
#fade[[Note that extremising $phi$ w.r.t. $vb(x)$ gives the first equation, and extremising w.r.t. $lambda$ gives the constraint. In IB Optimisation, $phi$ is denoted as $cal(L)$.]]

$lambda$ is called a *Lagrange multiplier*.

#example[
  Consider an open cuboid box (with no top face) with base dimensions $x$ and $y$, and height $z$. We want determine $(x, y, z)$ that minimizes surface area $A$ for a fixed volume $V = (L^3)/(2)$. This can be written as
  $
    & "minimise"   && A = x y + 2x z + 2y z \
    & "subject to" && x y z = L^3/2.
  $
  *Direct method.* Solve the constraint for $z$ and substitute into $A$ to get
  $
    A = x y + L^3 (1/x + 1/y).
  $
  $A$ is stationary iff $pdv(A, x) = 0$ and $pdv(A, y) = 0$, which gives $y = x$ and $x^3 = L^3$. Hence the stationary point is $(x, y, z) = (L, L, L/2)$.

  To determine that this is a minimum, we can compute the Hessian of $A$ w.r.t. $(x, y)$ and check that it is positive definite at the stationary point.

  *Lagrange multipliers.* Consider $phi(x, y, z, lambda) = A(x, y, z) - lambda(x y z - L^3/2)$. Extremising,
  $
    0 & = pdv(phi, z) = 2(x+y) - lambda x y                                              & => & lambda = (2(x+y))/(x y), \
    0 & = pdv(phi, x) = y + 2 z - lambda y z = 2 z +y - (2(x+y)z)/(x) = (y)/(x) (x - 2z) & => & x = 2z, \
    0 & = pdv(phi, y) = x + 2 z - lambda x z = 2 z +x - (2(x+y)z)/(y) = (x)/(y) (y - 2z) & => & y = 2z, \
    0 & = pdv(phi, lambda) = x y z - L^3/2=4 z^3 - L^3/2                                 & => & z = L/2, x=y=L.
  $
]
The disadvantage of the Lagrange multiplier method is that we have no simple method of checking the nature of this stationary point. #fade[[This is because the Hessian of $phi$ w.r.t. $(x, y, z, lambda)$ is always a saddle point, since $pdv(phi, lambda, 2) = 0$.]]

Nevertheless, the Lagrange multiplier method is useful when the constraint is too complicated to solve explicitly. It is often still simpler even when the constraint can be solved explicitly.

#example[
  Consider the minimum of the quadratic form on $RR^n$ given by
  $
    f(vb(x)) = x_i A_(i j) x_j
  $
  on the surface $abs(vb(x))^2 = 1$.

  Using Lagrange multipliers,
  $
    phi(vb(x), lambda) = x_i A_(i j) x_j - lambda (abs(vb(x))^2 - 1).
  $
  Extremising,
  $
    0 & = pdv(phi, x_i)    & = & 2 A_(i j) x_j - 2 lambda x_i, \
    0 & = pdv(phi, lambda) & = & abs(vb(x))^2 - 1.
  $
  Note that the first equation is equivalent to $matbold(A) vb(x) = lambda vb(x)$, _i.e._, $vb(x)$ is an eigenvector of $matbold(A)$ with eigenvalue $lambda$. Hence the stationary points of $f$ on the surface are the normalised eigenvectors of $matbold(A)$, and the value of $lambda$ are the eigenvalues of $matbold(A)$.

  At a stationary point,
  $
    f(vb(x)) = x_i A_(i j) x_j = lambda x_i x_i = lambda.
  $
  Hence the eigenvalues of $matbold(A)$ are the stationary values of $f$ on the surface. In this case, the minimum of $f$ is the lowest eigenvalue of $matbold(A)$.

  There are several alternative methods:

  - use a rotation to diagonalise $matbold(A)$;

  - consider $Lambda(vb(x)) := f(vb(x))/(g(vb(x)))$ where $g(vb(x)) = abs(vb(x))^2$. Then $Lambda(vb(x)) = hat(x)_i A_(i j) hat(x)_j = f(vu(x))$. So the minimum of $f$ w.r.t. $vu(x)$ is equivalent to the minimum of $Lambda$ w.r.t. $vb(x)$. Extremising $Lambda$ gives

    $
      0 = pdv(Lambda, x_i) & = (1)/(g) (nabla_i f - (f)/(g) nabla_i g) \
                           & = (2)/(g) (A_(i j) x_j - (f)/(g) x_i) \
                           & = (2)/(g) (A_(i j) x_j - Lambda x_i).
    $
    We recover the same eigenvalue problem as before, with $Lambda = lambda$. Hence the minimum of $f$ w.r.t. $vu(x)$ is the lowest eigenvalue of $matbold(A)$.
] <ex-4-2>

#example[
  Consider the probability distribution ${p_1, ..., p_n}$ satisfying $p_i >= 0$ and $sum_i p_i = 1$ that maximises the *information entropy*
  $
    S = -sum_i p_i log_2 p_i.
  $
  Using Lagrange multipliers,
  $
    phi(p_1, ..., p_n, lambda) = -sum_i p_i log_2 p_i - lambda (sum_i p_i - 1).
  $
  #fade[[Recall that $log_2 p = (ln p)/(ln 2)$.]] Extremising,
  $
    0 & = pdv(phi, p_i) & = & -log_2 p_i - (1)/(ln 2) - lambda. \
  $
  Since we can express $p_i$ in terms of $lambda$, we know that $p_i$ are all equal. Using the constraint, we get $p_i = 1/n$ for all $i$. Hence the maximum of $S$ occurs when the distribution is uniform.

  Hence the maximum of $S$ is
  $
    S_max = -sum_i (1/n) log_2 (1/n) = log_2 n.
  $
]

#lecture-separator(lecture: 5, date: "2026-05-11")

We can generalise this method to $m$ constraints $g_k (vb(x)) = 0$ for $k = 1, ..., m$. Then we just need to extremise
$
  phi(vb(x), lambda_1, ..., lambda_m) = f(vb(x)) - sum_(k=1)^(m) lambda_k g_k(vb(x)).
$
w.r.t. $vb(x)$ and $lambda_1, ..., lambda_m$.
