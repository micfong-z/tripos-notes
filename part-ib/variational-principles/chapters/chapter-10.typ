#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

#lecture-separator(lecture: 10, date: "2026-05-22")
= Partial Differential Equations from Variational Principles

We will consider functionals of functions $vb(y): RR^m -> RR^n$ where $m > 1$, of the form
$
  F[vb(y)] = integral_V f(vb(y), jacob vb(y), x_1, ..., x_m) dif x_1 ... dif x_m
$
where $V subset.eq RR^m$, and $jacob vb(y) = mat(bar, bar, dots.c, bar; pdv(vb(y), x_1), pdv(vb(y), x_2), ..., pdv(vb(y), x_m); bar, bar, dots.c, bar)$ #fade[[$m times n$ matrix, also known as the Jacobian matrix]].

Varying $vb(y)$ gives
$
  var(F) = F[vb(y) + var(vb(y))] - F[vb(y)]
$
then by integration by parts using divergence theorem, we can reach a generalisation of the Euler-Lagrange equations for $vb(y)$, provided boundary conditions imply that the boundary term vanishes.

== Minimal Surfaces

Consider surfaces spanning a closed curve $C$ in $RR^3$. Consider the surface with minimal area. We will restrict to surfaces that are graphs of functions of $(x, y)$, such that
$ z = h(x, y), quad (x, y) in D $
and $C$ has equation $z = h(x, y)$ for $(x, y) in ∂D$. This means that $h$ is fixed on $∂D$.

#align(center)[
  #dynamic-svg2("/part-ib/variational-principles/media/d1e3.svg", width: 12em)
]

By assumption we can parameterise the surface with $(x, y)$,
$
  vb(x)(x, y) = (x, y, h(x, y)).
$
To find the area of the surface #fade[[see IA Vector Calculus]], we need to find
$
  pdv(vb(x), x) = (1, 0,h_x), quad pdv(vb(x), y) = (0, 1, h_y)
$
using the notation $h_x = pdv(h, x)$ and $h_(x y) = pdv(h, x, y)$, _etc._ The surface element is
$
  dif vb(S) = (plus.minus) pdv(vb(x), x) times pdv(vb(x), y) dif x dif y = vec(-h_x, -h_y, 1) dif x dif y.
$
Hence the scalar area element is
$
  dif A = sqrt(1+h_x^2 + h_y^2) dif x dif y
$
So the surface has area
#set math.equation(numbering: "(1)")
$
  A[h] = integral_D sqrt(1+h_x^2 + h_y^2) dif x dif y
$ <eq-10-1>
#set math.equation(numbering: none)

Therefore we can vary $h$ to $h + var(h)$ to get
$
  var(A) & = integral_D (h_x (var(h))_x + h_y (var(h))_y) / sqrt(1+h_x^2 + h_y^2) dif x dif y \
  & = integral_D (underbracket(((h_x var(x))/(sqrt(1 + h_x^2 + h_y^2) ))_x + ((h_y var(y))/(sqrt(1 + h_x^2 + h_y^2) ))_y, = 0 "with Green's theorem, since" var(h) = 0 "on" ∂D) - [((h_x)/(sqrt(1 + h_x^2 + h_y^2) ))_x + ((h_y)/(sqrt(1 + h_x^2 + h_y^2) ))_y] var(h)) dif x dif y\
  &= integral_D -[((h_x)/(sqrt(1 + h_x^2 + h_y^2) ))_x + ((h_y)/(sqrt(1 + h_x^2 + h_y^2) ))_y] var(h) dif x dif y.
$

Since $A$ extremises iff $var(A) = 0$ for all $var(h)$, we have the Euler-Lagrange equation
$
  ((h_x)/(sqrt(1 + h_x^2 + h_y^2) ))_x + ((h_y)/(sqrt(1 + h_x^2 + h_y^2) ))_y = 0
$
#exercise[
  The equation above simplifies to
  $
    (1+h_y^2) h_(x x) + (1+h_x^2) h_(y y) - 2 h_x h_y h_(x y) = 0
  $
  which is called the *minimal surface equation*.

  This is a second-order nonlinear PDE for $h(x, y)$.

  #remark[
    If $abs(h_x) << 1$ and $abs(h_y) << 1$, then it is approximately linearised to $h_(x x) + h_(y y) = 0$, which is Laplace's equation. #fade[[See IA Vector Calculus.]]
  ]
]

Notice that one solution is $h = A x + B y + C$, _i.e._ a plane. However, this only satisfies the boundary conditions if the boundary curve $C$ is planar.

One can also look for solutions that are surfaces of revolution #fade[[about $z$-axis]], _i.e._ $h(x, y) = z(r)$ where $r = sqrt(x^2 + y^2)$. Then the area functional becomes
$
  r z'' + z' + (z')^3 = 0,
$
which is an ODE but still nonlinear. Instead, we can plug into @eq-10-1 #fade[[in which case $dif x dif y = r dif r dif phi$]], then
$
  A[z] = 2 ppi integral r sqrt(1 + (z')^2) dif r.
$
Now extremising $A$ gives the Euler-Lagrange equation, and there is a first integral. #fade[[See Example Sheet 1, Question 10.]]

== Vibrating String

Consider a string with fixed endpoints at $x=0$ and $x=a$, and displacement $y$.

#align(center)[
  #dynamic-svg2("/part-ib/variational-principles/media/d1e4.svg", width: 13em)
]

A string with tension $T$ and mass density (mass per unit length) $rho$ has
$
  "KE" =(1)/(2) rho integral_0^a (dot(y)(t, x))^2 dif x, quad "PE" = (1)/(2) T integral_0^a (y'(t, x))^2 dif x
$
where $y'(t, x) = pdv(y, x)$ and $dot(y)(t, x) = pdv(y, t)$. The action is
$
  I[y] = (1)/(2) integral_(t_0)^(t_1) integral_0^a (rho (dot(y))^2 - T (y')^2) dif x dif t.
$



Using @principle-of-least-action, we consider varying $y$ to $y + var(y)$, and we have
$
  var(I) & = integral_(t_0)^(t_1) integral_0^a (rho dot(y) var(dot(y)) - T y' (var(y))') dif x dif t \
  &= integral_(t_0)^(t_1) integral_0^a (underbracket(pdv(, t) (rho dot(y) var(y)) - pdv(, x) (T y' (var(y))), =0 "if" var(y) = 0 "on boundary") + (-rho dot.double(y) + T y'') var(y)) dif x dif t. quad
  & "similar to previous examples, IBP"
$
So $var(I)$ for arbitrary $var(y)$ iff
$
  dot.double(y) - v^2 y'' = 0 quad "where" v^2 = T / rho
$
This is the *wave equation* in 1D.

#fade[[This can be solved exactly, and the general solution is $y(t, x) = f(x - v t) + g(x + v t)$. This can be derived by a change of variables from $(t, x)$ to $psi = x - v t$ and $eta = x + v t$. See more information in IA Differential Equations and IB Methods.]]

== Action for Maxwell's Equations

Consider electromagnetic fields $vb(E)(t, vb(x))$ and $vb(B)(t, vb(x))$. Two of Maxwell's equations are

#set math.equation(numbering: "(1)")

$
  div vb(B) & = 0,
$ <eq-10-3a>
$
  curl vb(E) + pdv(vb(B), t) & = 0.
$ <eq-10-3b>

#set math.equation(numbering: none)

By IA Vector Calculus, @eq-10-3a is equivalent to the existence of a vector potential $vb(A)(t, vb(x))$ such that $vb(B) = curl vb(A)$. Substituting this into @eq-10-3b gives
$
  curl (vb(E) + pdv(vb(A), t)) = 0.
$
Therefore, there exists a scalar potential $phi(t, vb(x))$ such that
$
  vb(E) + pdv(vb(A), t) = -grad phi.
$

The action is a functional of $vb(A), phi$:
$
  I[vb(A), phi] = integral_(t_0)^(t_1) integral_(RR^3) ((1)/(2) epsilon_0 vb(E)^2 - (1)/(2 mu_0) vb(B)^2 + vb(A) dot vb(j) - phi rho) dif^3 vb(x) dif t
$
where $vb(j)(t, vb(x))$ is the current density and $rho(t, vb(x))$ is the charge density. Varying $vb(A)$ and $phi$,
$
  var(I) &= integral_(t_0)^(t_1) integral_(RR^3) (epsilon_0 vb(E) dot (-grad var(phi) - pdv(var(vb(A)), t)) - (1)/(mu_0) underbracket(vb(B) dot (curl delta vb(A)), epsilon_(i j k) B_j ∂_j var(A_k)) + delta vb(A) dot vb(j) - var(phi) rho) dif^3 vb(x) dif t\
  &= integral_(t_0)^(t_1) integral_(RR^3) (( epsilon_0 [- div (vb(E) var(phi)) + div vb(E) var(phi) - ∂_t (vb(E) dot var(vb(A))) + (∂_t vb(E)) dot var(vb(A))])\
    &quad quad quad quad -(1)/(mu_0) [∂_j (epsilon_(i j k) B_i var(A_k)) - (epsilon_(i j k) ∂_j B_i) var(A_k)] + var(vb(A)) dot vb(j) - var(phi) rho) dif^3 vb(x) dif t\
  &= "boundary terms" + integral_(t_0)^(t_1) integral_(RR^3) ((epsilon_0 div vb(E) - rho) var(phi) + (-(curl vb(B))/(mu_0) + epsilon_0 ∂_t vb(E) + vb(j)) dot var(vb(A))) dif^3 vb(x) dif t.
$

Assuming the boundary terms vanish, $delta I = 0$ for arbitrary $var(vb(A))$ and $var(phi)$ iff

#set math.equation(numbering: "(1)")
$
  div vb(E) = rho / epsilon_0, quad curl vb(B) = mu_0 epsilon_0 pdv(vb(E), t) + mu_0 vb(j)
$
#set math.equation(numbering: none)
which are the other two Maxwell's equations. Therefore, Maxwell's equations can be derived from the action principle.

#lecture-separator(lecture: 11, date: "2026-05-25")
