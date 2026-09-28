#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Functionals and Euler-Lagrange Equations

#notation[
  For $Omega subset.eq RR^n$, we write $C^k (Omega) = Set(y\: Omega -> RR; y "is" k "times continuously differentiable")$.

  Similarly, we write $C^oo (Omega) = Set(y\: Omega -> RR; y "is smooth")$.
]

#definition[Functionals][
  Let $cal(C)$ be some set of functions, _e.g._ $C^oo (Omega)$.

  A *functional* is a map $F: cal(C) -> RR$ with $y |-> F[y]$, where $y in cal(C)$. _i.e._ $F$ maps a function to a number.

  #fade[[We usually use square brackets to denote the argument of a functional, to distinguish it from the argument of a function.]]

  More generally, a functional can map several functions to a number, _i.e._
  $
    F: cal(C_1) times ... times cal(C_m) -> RR, quad (y_1, ..., y_m) |-> F[y_1, ..., y_m].
  $

]

An important case is when $Omega = [alpha, beta] subset.eq RR$ and $cal(C) = C^oo (Omega)$, and $F[y]$ is given by an integral of the form
$
  F[y] = integral_alpha^beta f(y(x), y'(x), x) dif x,
$
for some smooth $f$. #fade[[We can also generalise this by letting $f$ depend on higher derivatives of $y$.]]

We wish to find the function $y in cal(C)$ that extremises $F[y]$. Consider varying $y$ to $y + var(y) in cal(C)$. Then
$
  var(F[y]) := F[y + var(y)] - F[y] &= integral_alpha^beta (f(y + var(y), y' + var(y)', x) - f(y, y', x)) dif x\
  &= integral_alpha^beta (pdv(f, y) var(y) + pdv(f, y') var(y)') dif x + ("higher order terms")\
  &= integral_alpha^beta (var(y)(x) (pdv(f, y) - dv(, x) pdv(f, y'))) dif x + [pdv(f, y') var(y)]_alpha^beta + ...\
$
Assume that the definition of $cal(C)$ includes suitable boundary conditions that ensures $[pdv(f, y') var(y)]_alpha^beta = 0$. For example, we can

- assume $y(alpha) =a$, $y(beta) = b$ for all $y in cal(C)$, so that $var(y)(alpha) = var(y)(beta) = 0$; or

- assume $pdv(f, y') = 0$ at the boundaries for all $y in cal(C)$. #fade[[_e.g._ $f = sqrt(1+(y')^2)$ and $y'(alpha) = y'(beta) = 0$ for all $y in cal(C)$.]]

Then we can write
$
  var(F[y]) = integral_alpha^beta var(y)(x) pdv(F[y], y(x), d: delta) dif x + ...\
$
where $pdv(F[y], y(x), d: delta) := pdv(f, y) - dv(, x) pdv(f, y')$ is the *functional derivative* of $F$ w.r.t. $y$ at $x$. This is a function of $x$.

Hence $var(F[y])$ vanishes to first order for arbitrary $var(y)$ iff $y(x)$ satisfies the *Euler-Lagrange equation*.

#definition[Functional Derivatives and Euler-Lagrange Equations][
  The *functional derivative* of a functional $F[y]$ w.r.t. $y$ at $x$ is
  $
    pdv(F[y], y(x), d: delta) := pdv(f, y) - dv(, x) pdv(f, y').
  $
  The *Euler-Lagrange equation* for the functional $F[y] = integral_alpha^beta f(y(x), y'(x), x) dif x$ is
  $
    pdv(F[y], y(x), d: delta) = pdv(f, y) - dv(, x) pdv(f, y') = 0.
  $
  This is a second order ODE for $y(x)$, and the solution $y(x)$ extremises $F[y]$.
]

We can generalise this to $vb(y)(x) = (y_1 (x), ..., y_n (x))$ where $x in [alpha, beta]$, _i.e._ $vb(y): [alpha, beta] -> RR^n$.  Then
$
  F[vb(y)] & = integral_alpha^beta f(vb(y)(x), vb(y)'(x), x) dif x, \
  var(F[vb(y)]) & = integral_alpha^beta sum_(i=1)^n var(y_i)(x) (pdv(f, y_i) - dv(, x) pdv(f, y'_i)) dif x + [sum_(i=1)^n pdv(f, y'_i) var(y_i)]_alpha^beta + ...\
$
So assuming suitable boundary conditions such that $[sum_(i=1)^n pdv(f, y'_i) var(y_i)]_alpha^beta = 0$, then $y(x)$ extremises $F$ iff
$
  pdv(f, y_i) - dv(, x) pdv(f, y'_i) = 0 quad forall i = 1, ..., n. quad ("Euler-Lagrange equations")
$
_i.e._ we have $n$ second order ODEs for $y_1 (x), ..., y_n (x)$.

== Geodesics of the Euclidean Plane <sec-5-1>

#example[
  Consider the problem of finding the shortest curve between two points $A, B$ in the Euclidean space. Let the curve be $C$, with its length given by
  $
    L = integral_C dif l quad "where" quad dif l = sqrt((dif x)^2 + (dif y)^2).
  $
  We can parameterise the curve $C$ in one of two ways:

  1. Use $x$ as the parameter, so that $y = y(x)$ and $x_a <= x <= x_b$. Then the class of curves satisfy $y(x_a) = y_a$, $y(x_b) = y_b$. Then
    $
      L[y] = integral_(x_a)^(x_b) sqrt(1 + (y')^2) dif x.
    $
    Extremising the functional with $f = sqrt(1 + (y')^2)$, note that $pdv(f, y) = 0$ and $pdv(f, y') = y'/(sqrt(1 + (y')^2))$. Hence the Euler-Lagrange equation gives
    $
      dv(, x) (y'/(sqrt(1 + (y')^2))) = 0 quad => quad y'/(sqrt(1 + (y')^2)) = c_1 quad => quad y' = c_1/sqrt(1 - c_1^2) = c_2.
    $
    Therefore $y = m x + c$, which is a straight line, where $m, c$ can be found by the boundary conditions.

    However, in this parameterisation, we are excluding curves where $y$ is not a function of $x$, such as one-to-many mappings. Hence we need to consider the other parameterisation.

  2. Consider an arbitrary parameter $t in [0, 1]$, where $t = 0$ at $A$ and $t = 1$ at $B$. Then $x = x(t)$, $y = y(t)$, and the class of curves satisfy $x(0) = x_a$, $y(0) = y_a$, $x(1) = x_b$, $y(1) = y_b$. Then
    $
      L[vb(x)] = integral_0^1 sqrt(vb(dot(x))(t)^2) dif t.
    $

    We are now looking at a generalised functional with two functions $vb(x)(t) = (x(t), y(t))$, and $f = sqrt(dot(x)^2 + dot(y)^2)$.

    The Euler-Lagrange equation for $x$ gives
    $
      underbracket(pdv(f, x), =0) - dv(, t) pdv(f, dot(x)) = 0 quad => quad pdv(f, dot(x)) = dot(x)/(sqrt(dot(x)^2 + dot(y)^2)) = c.
    $
    Similarly, the Euler-Lagrange equation for $y$ gives
    $
      underbracket(pdv(f, y), =0) - dv(, t) pdv(f, dot(y)) = 0 quad => quad pdv(f, dot(y)) = dot(y)/(sqrt(dot(x)^2 + dot(y)^2)) = s.
    $
    Notice that $c^2 + s^2 = 1$, so we can write $c = cos theta$, $s = sin theta$ for some $theta in [0, 2 ppi)$. Hence it seems reasonable to switch to using arc length $l$ as the parameter:

    $
      dv(l, t) = sqrt(dot(x)^2 + dot(y)^2).
    $
    Therefore,
    $
      dv(x, l) = dv(x, t) slash.big dv(l, t) = cos theta, quad dv(y, l) = dv(y, t) slash.big dv(l, t) = sin theta.
    $
    Thus,
    $
      x = x_a + l cos theta, quad y = y_a + l sin theta,
    $
    which is a straight line, and $theta$ can be found by the boundary conditions.

    #fade[[We couldn't use $l$ as our parameter initially because then the upper limit of integration changes with the curve, and it violates our assumption in the derivation of the Euler-Lagrange equation that the limits of integration are independent of the curve.

      However, we can use $l$ as a parameter after we have derived the Euler-Lagrange equations, since the equations are independent of the parameterisation.]]

]
