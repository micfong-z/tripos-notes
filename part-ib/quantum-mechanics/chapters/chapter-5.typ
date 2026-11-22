#import "../prelude.typ": *
#show: chapter.with(5)

= 3D Solutions of the Schrödinger Equation

We have the TISE of the form
$
  -(hbar)/(2m) laplacian chi(vb(x)) + U(vb(x)) chi(vb(x)) = E chi(vb(x))
$
where $laplacian$ is the Laplacian operator.

In Cartesian coordinates $(x_1, x_2, x_3)$, we have
$
  laplacian equiv pdv(, x_1, 2) + pdv(, x_2, 2) + pdv(, x_3, 2).
$
In spherical coordinates $(r, theta, phi)$, we have
$
  x_1 = r cos phi sin theta, quad x_2 = r sin phi sin theta, quad x_3 = r cos theta
$
with $0 <= r < oo$, $0 <= theta <= pi$, $0 <= phi < 2 pi$. Then
$
  laplacian = (1)/(r) pdv(, r, 2) r + (1)/(r^2 sin theta)[sin theta pdv(, theta)(sin theta pdv(, theta)) + pdv(, phi, 2)].
$
Integration is given by
$
  integral_(RR^3) dif V & = integral_(-oo)^(oo) integral_(-oo)^(oo) integral_(-oo)^(oo) dif x_1 dif x_2 dif x_3 \
  integral_(RR^3) dif V &= integral_(0)^(2ppi) dif phi integral_(0)^(pi) sin theta dif theta integral_(0)^(oo) r^2 dif r.
$
In this course we will deal with spherically symmetric potentials of the form $U(vb(x)) = U(r)$. In general, even if $U$ is a function of $r$ only, the eigenfunctions of $hat(H)$ will still depend on the angles $theta$ and $phi$.

#remark[
  In IA Dynamics and Relativity, we have
  $
    vb(L) = vb(x) times vb(p)
  $

  and if $U = U(r)$, then $dv(vb(L), t) = vb(0)$. Then we can take a plane such that $vb(L) dot vb(x) = 0$, and reduce the problem to two dimensions. Hence we can solve it in the radial dimension, with $vb(L)$ determining angular points.
]

== Angular Momentum Operator

#definition[Angular Momentum Operator][
  The angular momentum operator is defined as
  $
    hat(vb(L)) = vb(x) times hat(vb(p)) = - i hbar vb(x) times grad.
  $
]
In 3D, we have
$
  hat(vb(x)) psi = vec(x_1, x_2, x_3) psi, quad hat(vb(p)) psi = - i hbar vec(pdv(psi, x_1), pdv(psi, x_2), pdv(psi, x_3)).
$
In Cartesian coordinates, we have
$
  hat(L)_i = -ii hbar epsilon_(i j k) x_j pdv(, x_k) = epsilon_(i j k) hat(x)_j hat(p)_k,
$
where $epsilon_(i j k)$ is the Levi-Civita symbol.


#proposition[
  + $hat(L)_i$ are Hermitian operators.

  + $[hat(L)_i, hat(L)_j] != 0$ if $i != j$. Hence different components of $vb(L)$ cannot be measured simultaneously. In fact,
    $
      [hat(L)_i, hat(L)_j] = i hbar epsilon_(i j k) hat(L)_k.
    $

]

#proof[

  2. Take $chi(x_1, x_2, x_3)$. Then

    $
      [hat(L)_1, hat(L)_2] chi &= -hbar^2[(x_2 pdv(, x_3) - x_3 pdv(, x_2))(x_3 pdv(, x_1) - x_1 pdv(, x_3)) - (x_3 pdv(, x_1) - x_1 pdv(, x_3))(x_2 pdv(, x_3) - x_3 pdv(, x_2)) ] chi\
      &= -hbar (x_2 pdv(, x_1) - x_1 pdv(, x_2)) chi \
      &= ii hbar hat(L)_3 chi, \
    $
    and similarly for $[hat(L)_2, hat(L)_3]$ and $[hat(L)_3, hat(L)_1]$.

]

#definition[
  The total angular momentum operator is defined as
  $
    hat(L)^2 = hat(L)_1^2 + hat(L)_2^2 + hat(L)_3^2.
  $
]

We can show that
$
  [hat(L)^2, hat(L)_i] = 0.
$
In particular, $[hat(L)^2, hat(L)_3] = 0$ implies that $hat(L)^2$ and $hat(L)_3$ are simultaneously diagonalisable. Hence we can find a joint ste of eigenstates of $hat(L)^2$ and $hat(L)_3$, To find such a set, we first write $hat(vb(L))$ in spherical coordinates,
$
  hat(L)_3 & = - ii hbar pdv(, phi), \
  hat(L)^2 & = -(hbar^2)/(sin^2 theta) [sin theta pdv(, theta)(sin theta pdv(, theta)) + pdv(, phi, 2)].
$

We will find joint eigenfunctions $Y(theta, phi)$ of $hat(L)^2$ and $hat(L)_3$.
