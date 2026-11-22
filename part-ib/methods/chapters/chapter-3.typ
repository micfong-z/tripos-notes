#import "../prelude.typ": *
#show: chapter.with(3)

#lecture-separator(lecture: 7, date: "2026-10-23")

= Linear PDE and Separation of Variables

== Reminder of Superposition

We will study pure boundary value problems (BVP), #fade[[linear,]] of the form
$
  cases(
    P phi(vb(x)) = 0 quad & vb(x) in Omega,
    "some boundary conditions" quad & vb(x) in ∂Omega,
  )
$
and initial BVP (IBVP) of the form
$
  cases(
    Q phi(vb(x), t) = 0 quad & (vb(x), t) in Omega times (0, T),
    "some boundary conditions" quad & (vb(x), t) in ∂Omega times (0, T),
    "some initial conditions" quad & (vb(x), t) in Omega times {0},
  )
$
where $P, Q$ are linear partial differential operators and $Omega subset.eq RR^n$ will be open, bounded #fade[[and connected]]. In this course we will look at $n = 1, 2, 3$.

#remarklike[Observation 1][
  For the IBVP, we can break the problem into two simpler problems,
  $
    cases(
      Q phi_1(vb(x), t) = 0 quad & (vb(x), t) in Omega times (0, T),
      "all boundary conditions" = 0 quad & (vb(x), t) in ∂Omega times (0, T),
      "some initial conditions" quad & (vb(x), t) in Omega times {0},
    )\
    "and"\
    cases(
      Q phi_2(vb(x), t) = 0 quad & (vb(x), t) in Omega times (0, T),
      "some boundary conditions" quad & (vb(x), t) in ∂Omega times (0, T),
      "all initial conditions" = 0 quad & (vb(x), t) in Omega times {0},
    )
  $
  Note that, by linearity, $phi = phi_1 + phi_2$ solves the original IBVP.
]

#remarklike[Observation 2][
  For problems in this section, it will turn out that $Omega$, possibly after change of variables, will be a line/rectangle/cuboid. WLOG we can assume that all boundary conditions vanish on all but one endpoint/edge/face.
]

#example[
  Consider
  $
    cases(
      P psi = 0 quad & (x, y) in (0, 1) times (0, 1),
      psi = f_i quad & "on" i"-th side".
    )
  $
  Instead we can consider $psi_i$ for $i = 1, 2, 3, 4$ with
  $
    cases(
      P psi_i = 0 quad & (x, y) in (0, 1) times (0, 1),
      psi_i = f_i quad & "on" i"-th side",
      psi_i = 0 quad & "on all other sides".
    )
  $
  Note that $psi = psi_1 + psi_2 + psi_3 + psi_4$ solves the original problem.
]

== Laplace's Equation

For $phi: RR^n -> RR$, Laplace's equation is
$
  laplacian phi = 0
$
where $laplacian = div grad$. For example, on $RR^3$ with Cartesian coordinates $(x, y, z)$, we have
$
  laplacian = pdv(, x, 2) + pdv(, y, 2) + pdv(, z, 2).
$
Intuitively, $laplacian phi(vb(x))$ measures the extent to which $phi(vb(x))$ differs from its average over an infinitesimal ball centred at $vb(x)$. Hence, if $laplacian phi(vb(x)) = 0$, then $phi(vb(x))$ agrees with its nearby averages. Thus in some sense, if $laplacian phi(vb(x)) = 0$, then there is a state of equilibrium. If $laplacian phi(vb(x)) = 0$, then we say that $phi$ is harmonic.

#example[
  Let $vb(u): RR^3 -> RR^3$ denote velocity of an incompressible fluid #fade[[$div vb(u) = 0$]].

  Suppose that the flow is irrotational #fade[[$curl vb(u) = 0$]]. Since $RR^3$ is simply connected, $exists phi: RR^3 -> RR$ such that $vb(u) = grad phi$. Then, incompressibility implies that
  $
    0 = div vb(u) = div grad phi = laplacian phi.
  $
]

We will study pure BVPs of the form
$
  cases(
    laplacian phi(vb(x)) = 0 quad & vb(x) in Omega,
    B phi(vb(x)) = f(vb(x)) quad & vb(x) in ∂Omega,
  )
$
where $B phi equiv phi$ (Dirichlet boundary condition), or $B phi equiv pdv(phi, vb(n))$ (Neumann boundary condition), where $pdv(, vb(n)) = vb(n) dot grad$ and $vb(n)$ is outwards normal to $Omega$.

For Dirichlet boundary conditions, the solutions are unique. For Neumann boundary conditions, the solutions are unique up to an additive constant.

=== Separation of Variables on a Square

We want to solve
$
  cases(
    phi_(x x) + phi_(y y) = 0 quad & (x, y) in (0, 1) times (0, 1),
    phi(x, y) = 0 quad & x = 0 "or" x = 1 "or" y = 0,
    phi(x, 1) = f(x) quad & x in (0, 1),
  )
$
We need to use separation of variables for this: look for solution of homogeneous part of the problem in the form $phi = X(x) Y(y)$. Substituting this into $laplacian phi = 0$, we get
$
  (X''(x))/(X(x)) + (Y''(y))/(Y(y)) = 0.
$
Since coordinates $(x, y)$ are independent, there exists $lambda in RR$ such that
$
  X'' + lambda X = 0, quad & Y'' - lambda Y = 0.
$
Since we want $phi = 0$ when $x= 0$ or $x=1$, we have
$
  cases(
    -X''=lambda X quad & 0<x<1,
    X(0) = 0,
    X(1)=0.
  )
$
This is a Sturm-Liouville problem. Non-trivial solutions exist only for $lambda > 0$, and hence we get
$
  X_n (x) = sin (n ppi x), quad lambda_n = (n ppi)^2
$
where $n in ZZ^+$. Then $Y$-equation becomes
$
  cases(
    Y'' - (n ppi)^2 Y = 0 quad & 0<y<1,
    Y(0) = 0,
  )
$
Hence $Y_n (y) = A_n sinh(n ppi y)$ where $A_n$ is a constant. So the homogeneous part of the problem is satisfied by, for each $n in ZZ^+$,
$
  phi_n (x, y) = A_n sin (n ppi x) sinh(n ppi y).
$

By linearity, we have a very general solution
$
  phi(x, y) = sum_(n=1)^oo A_n sin (n ppi x) sinh(n ppi y).
$
We want
$
  f(x) = phi(x, 1) = sum_(n=1)^oo A_n sin(n ppi x) sinh(n ppi).
$
Since ${X_n}$ satisfy the Sturm-Liouville problem, we have the orthogonality relation
$
  iprod(X_n, X_m) = integral_(0)^(1) sin(n ppi x) sin(m ppi x) dif x = (1)/(2) delta_(n m).
$
Taking inner products,
$
  iprod(f, X_m) & = sum_(n=1)^oo A_n iprod(X_n, X_m) sinh(n ppi) \
                & = (1)/(2) A_m sinh(m ppi) \
$
In summary, the solution is
$
  phi(x, y) = sum_(n=1)^oo A_n sin(n ppi x) sinh(n ppi y),
$
where $A_n = (2)/(sinh (n ppi)) integral_(0)^(1) f(x) sin(n ppi x)dif x$

#fade-block[
  We haven't really solved the problem, since we really want our solution to continuously approach the boundary conditions from the interior. However, this is beyond this course.
]

#lecture-separator(lecture: 8, date: "2026-10-26")

=== Laplace's Equation on the Annulus or Disc

We wish to solve $laplacian phi = 0$ on $r_1 < abs(vb(x)) < r_2$ in $RR^2$. Due to symmetry, we will use polar coordinates $(r, theta)$.

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p6.svg", width: 32em)
]

In polar coordinates, Laplace's equation becomes
$
  (1)/(r) pdv(, r)(r pdv(phi, r)) + (1)/(r^2) pdv(phi, theta, 2) = 0.
$
Looking for solutions of the form $phi = R(r) Theta (theta)$, we get
$
  (r)/(R) dv(, r) [r pdv(R, r)] + (1)/(Theta) pdv(Theta, theta, 2) = 0.
$
Since $r$ and $theta$ are independent, there exists $lambda in RR$ such that
$
  Theta'' + lambda Theta & = 0, \
                r(r R')' & = lambda R. \
$
The first equation gives, for $lambda != 0$,
$
  Theta(theta) = A cos (sqrt(lambda) theta) + B sin (sqrt(lambda) theta).
$
Since we require $phi(r, theta) = phi(r, theta + 2 ppi)$, we must have $lambda = n^2$ for $n in ZZ_(>=0)$. Then, the second equation becomes
$
  r (r R')' & = n^2 R \
$

For $n != 0$ look for $R = r^alpha$, in which case we get
$
  alpha^2 = n^2,
$
so $alpha = plus.minus n$ if $n != 0$. If $n = 0$, we instead have
$
  R = A + B log r.
$

By linearity, we have a family of solutions
$
  phi(r, theta) = A + B log r + sum_(n=1)^oo (A_n r^n + B_n r^(-n)) dot (C_n cos(n theta) + D_n sin(n theta)).
$

Note that if domain contains $r = 0$, then $B = B_n = 0$.

#example[
  To solve
  $
    cases(
      laplacian phi = 0 quad & r_1 < r < r_2,
      phi = 0 quad & r = r_1,
      phi = f(theta) quad & r = r_2,
    )
  $
  repeat previous analysis but enforce $R(r_1) = 0$. We get
  $
    R_0 (r) & = log((r)/(r_1)) \
        R_n & = ((r)/(r_1))^n - ((r_1)/(r))^n quad & n in ZZ^+.
  $
  Thus, we will get solutions of the form
  $
    phi(r, theta) = C_0 log((r)/(r_1)) + sum_(n=1)^oo [((r)/(r_1))^n - ((r_1)/(r))^n] dot (C_n cos(n theta) + D_n sin(n theta)).
  $
  #fade[[We have absorbed constants into $C_n, D_n$.]]

  Note that at $r= r_2$, we also need
  $
    f(theta) = C_0 log((r_2)/(r_1)) + sum_(n=1)^oo [((r_2)/(r_1))^n - ((r_1)/(r_2))^n] dot (C_n cos(n theta) + D_n sin(n theta)).
  $
  Define
  $
    (1)/(2) a_0 & = C_0 log((r_2)/(r_1)) \
            a_n & = [((r_2)/(r_1))^n - ((r_1)/(r_2))^n] C_n \
            b_n & = [((r_2)/(r_1))^n - ((r_1)/(r_2))^n] D_n,
  $

  we have
  $
    f(theta) = (1)/(2) a_0 + sum_(n=1)^oo (a_n cos(n theta) + b_n sin(n theta)).
  $
  This is just the Fourier series of $f(theta)$, so we can write down the required coefficients $a_n, b_n$ and hence $C_n, D_n$, where
  $
    a_n & = (1)/(ppi) integral_(0)^(2ppi) f(theta) cos(n theta) dif theta, \
    b_n & = (1)/(ppi) integral_(0)^(2ppi) f(theta) sin(n theta) dif theta.
  $
]
If we wanted to solve the more general problem
$
  cases(
    laplacian phi = 0 quad & r_1 < r < r_2,
    phi = f_1(theta) quad & r = r_1,
    phi = f_2(theta) quad & r = r_2,
  )
$
then we can use superposition to write $phi = phi_1 + phi_2$.

=== Laplace's Equation on a Shell or Ball (Axisymmetric Case)

We wish to solve $laplacian phi = 0$ on $r_1 < abs(vb(x)) < r_2$ in $RR^3$. Due to symmetry, we will use spherical coordinates $(r, theta, phi.alt)$, where $r in [0, oo)$, $theta in [0, ppi]$, $phi.alt in [0, 2ppi)$.

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p7.svg", width: 32em)
]

Assume that the problem is symmetric about the $z$-axis, so that $phi$ is independent of $phi.alt$ and we can write $phi = phi(r, theta)$. We have
$
  (1)/(r^2) pdv(, r)(r^2 pdv(phi, r)) + (1)/(r^2 sin theta) pdv(, theta)(sin theta pdv(phi, theta)) + cancel((1)/(r^2 sin^2 theta) pdv(phi, phi.alt, 2)) = 0.
$
We will try $phi = R(r) Theta (theta)$. We have
$
  (1)/(R) dv(, r)(r^2 pdv(R, r)) + (1)/(Theta sin theta) pdv(, theta)(sin theta pdv(Theta, theta)) = 0.
$

Hence $exists lambda in RR$ such that
$
             (r^2 R')' & = lambda R \
  -(sin theta Theta')' & = lambda Theta sin theta .
$

In the $Theta$ equation, use $x = cos theta$ and write
$
  tilde(Theta) (x) = Theta(theta).
$
Note that
$
  dv(Theta, theta) = dv(x, theta) dv(tilde(Theta), x) = - sin theta dv(tilde(Theta), x)
$
Hence we get
$
  -(-sin theta dv(, x)) [sin theta (-sin theta dv(tilde(Theta), x))] = lambda tilde(Theta) sin theta
$
If $theta != 0, ppi$, _i.e._ $x in (-1, 1)$, we can divide by $sin theta$ to get
$
  -dv(, x)[(1-x^2) dv(tilde(Theta), x)] = lambda tilde(Theta).
$
This is the Legendre equation. We get for $n in ZZ_(>=0)$, the Legendre polynomials
$
  tilde(Theta)_n (x) = P_n (x), quad lambda_n = n(n+1).
$
In the original coordinates, we have
$
  Theta(theta) = P_n (cos theta).
$
The $R$-equation becomes
$
  (r^2 R')' = n(n+1) R.
$
Try $R = r^alpha$, we get $alpha(alpha + 1) = n (n+1)$. Therefore, we have $alpha = n$ or $alpha = -n-1$. Using linearity, we get a family of solutions
$
  phi(r, theta) = sum_(n=0)^oo [alpha_n r^n + (beta_n)/(r^(n+1))]P_n (cos theta).
$
If the domain contains $r = 0$, then we must have $beta_n = 0$.

#example[
  Consider the problem
  $
    cases(
      laplacian phi = 0 quad & r < 1,
      phi = f(theta) quad & r = 1.
    )
  $
  So we have $beta_n = 0$. The boundary condition becomes
  $
    f(theta) = sum_(n=0)^oo alpha_n P_n (cos theta).
  $ <eq-star>
  Recall that the Legendre polynomials are orthogonal with respect to the inner product
  $
    iprod(P_n, P_m) = integral_(-1)^(1) P_n (x) P_m (x) dif x = (2)/(2n+1) delta_(n m).
  $
  Substituting $x = cos theta$, we have
  $
    (2 delta_(n m))/(2n + 1) =integral_(0)^(ppi) P_n (cos theta) P_m (cos theta) sin theta dif theta
  $
  Multiplying @eq-star by $P_m (cos theta) sin theta$ and integrating over $theta in [0, ppi]$, we get
  $
    integral_(0)^(ppi) f(theta) P_m (cos theta) sin theta dif theta &= sum_(n=0)^oo alpha_n underbracket(integral_(0)^(ppi) P_n (cos theta) P_m (cos theta) sin theta dif theta, (2 delta_(n m))/(2n + 1)) \
  $
  Hence,
  $
    alpha_n = (2n + 1)/(2) integral_(0)^(ppi) f(theta) P_n (cos theta) sin theta dif theta.
  $
]

#lecture-separator(lecture: 9, date: "2026-10-28")

== The Wave Equation

Consider a string under constant tension $tau$, clamped at $x=0$ and $x=L$. #fade[[So the undisturbed string is a horizontal line.]] We allow the string to undergo small, transverse oscillations, so the motion is assumed vertical at each point, and the displacement, $y = y(x, t)$ obeys $abs(pdv(y, x)) << 1$.

#fade-block[
  Note that since $y(0, t) = 0$, we can write
  $
    y(x, t) = integral_(0)^(x) pdv(y, x)(s, t) dif s.
  $
  Hence
  $
    abs(y) << L.
  $
]
#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p8.svg", width: 25em)
]
Resolving horizontally, since there is no horizontal motion, we have
$
  tau cos theta_B - tau cos theta_A = 0.
$
This is consistent if we work up to $O(y_x^2)$. Using $tan theta_A = (pdv(y, x))_A$, $cos = (1)/(sqrt(sec^2))$, we have
$
  cos theta_B - cos theta_A & = (1)/(sqrt(1+(pdv(y, x))_B^2)) - (1)/(sqrt(1+(pdv(y, x))_A^2)) \
                            & = pdv(, x) [(1)/(sqrt(1+y_x^2))]_(x=xi) (x_B - x_A) #eq-note[$xi in (x_A, x_B)$ by MVT] \
                            & = O(delta x dot y_x^2). \
$
So it is indeed consistent. The mass of the string should be proportional to its length,
$
  integral_(A)^(B) dif s = integral_(x_A)^(x_B) sqrt(1+y_x^2) dif x = delta x (1 + O(y^2_x)).
$
Hence it is reasonable to assume the mass is $mu delta x$, where $mu > 0$ is the string density.

Resolving vertically, Newton's second law gives
$
  mu delta x eval(pdv(y, t, 2))_(x = (1)/(2) (x_A + x_B)) = tau sin theta_B - tau sin theta_A.
$
Using $sin = cos dot tan$, we get
$
  sin theta_B - sin theta_A & = (pdv(y, x))_B/(sqrt(1+(pdv(y, x))_B^2)) - (pdv(y, x))_A/(sqrt(1+(pdv(y, x))_A^2)) \
                            & = pdv(, x) [y_x/(sqrt(1+y_x^2))]_(x=xi) (x_B - x_A) #eq-note[$xi in (x_A, x_B)$ by MVT] \
                            & = [y_(x x) + O(y_x^2)] delta x. \
$
Therefore,
$
  mu delta x pdv(y, t, 2) & = tau delta x [y_(x x)(xi, t) + O(y_x^2)] \
  (mu)/(tau) pdv(y, t, 2) & = y_(x x)(xi, t) + O(y_x^2).
$
Take $delta x -> 0$, so $xi -> x$. We have
$
  (1)/(c^2) pdv(y, t, 2) = pdv(y, x, 2), quad c^2 = (tau)/(mu) = ("wave speed")^2
$

We have boundary conditions $y(0, t) = y(L, t) = 0$. Newton's second law requires initial conditions $y(x, 0)$ #fade[[initial profile]] and $y_t (x, 0)$ #fade[[initial velocity]].

=== Waves on a String

The IBVP is
$
  cases(
    y_(t t) - c^2 y_(x x) & = 0 quad & 0<x<L\, t>0,
    y(0, t) = y(L, t) & = 0 quad & t>0,
    y(x, 0) & = f(x),
    y_t (x, 0) & = g(x) quad & 0<x<L.
  )
$

We will try to solve the homogeneous part via separation of variables. Let $y = X(x) T(t)$, we find that there exists $lambda in RR$ such that
$
  cases(
    X'' + lambda X & = 0,
    X(0) = X(L) & = 0
  )
  quad "and" quad
  dot.double(T) + lambda c^2 T & = 0.
$

The first problem is a Sturm-Liouville problem. We get
$
  X_n (x) = sin((n ppi x)/(L)), lambda_n = ((n ppi)/(L))^2 quad n in ZZ^+.
$
Then, the $T$-equation becomes
$
  dot.double(T) + ((n ppi c)/(L))^2 T = 0.
$
Therefore we get
$
  T_n (t) = A_n cos((n ppi c)/(L) t) + B_n sin((n ppi c)/(L) t).
$
Hence,
$
  y(x, t) = sum_(n=1)^oo sin((n ppi x)/(L))[A_n cos((n ppi c)/(L) t) + B_n sin((n ppi c)/(L) t)].
$
The initial conditions then becomes
$
  f(x) & = sum_(n=1)^oo A_n sin((n ppi x)/(L)), \
  g(x) & = sum_(n=1)^oo B_n ((n ppi c)/(L)) sin((n ppi x)/(L)).
$

Using orthogonality $iprod(X_n, X_m) = (L)/(2) delta_(n m)$, we get
$
  A_n & = (2)/(L) integral_(0)^(L) f(x) sin((n ppi x)/(L)) dif x, \
  B_n & = (2)/(n ppi c) integral_(0)^(L) g(x) underbracket(sin((n ppi x)/(L)), X_n (x)) dif x.
$

=== Waves on a Drum

In higher dimensions, the wave equation becomes
$
  (1)/(c^2) pdv(phi, t, 2) = laplacian phi, quad phi = phi(vb(x), t), quad (vb(x), t) in Omega times (0, oo).
$
Hence, the IBVP is
$
  cases(
    phi_(t t) - c^2 laplacian phi = 0 quad & (vb(x), t) in Omega times (0, oo),
    phi = 0 quad & (vb(x), t) in ∂Omega times (0, oo),
    phi(vb(x), 0) = f(vb(x)) quad & vb(x) in Omega,
    phi_t (vb(x), 0) = g(vb(x)) quad & vb(x) in Omega,
  )
$
We take
$
  Omega = Set((r, theta); r in [0, 1), theta in [0, 2ppi))
$
with $(r, theta)$ in polar coordinates. For simplicity, we assume $f = f(r)$, $g = g(r)$. So we expect $phi = phi(r, t)$.

We can solve the homogeneous part of the problem with $phi = R(r) T(t)$, and get
$
  (1)/(c^2) pdv(phi, t, 2) & = (1)/(r) pdv(, r) (r pdv(phi, r)) \
     dot.double(T)/(c^2 T) & = [r R']'/(r R) \
$
So $exists lambda in RR$ such that
$
         -dv(, r) [r dv(R, r)] & = lambda r R \
  dot.double(T) + c^2 lambda T & = 0, \
                          R(1) & = 0. \
$
The first equation is a Sturm-Liouville problem relating to Bessel's equation of order $m = 0$. So
$
  R_k (r) = J_0 (j_(0 k) r), quad lambda_k = j_(0 k)^2, quad k in ZZ^+.
$
The $T$-equation becomes
$
  dot.double(T) + (c j_(0 k))^2 T & = 0, \
                          T_k (t) & = A_k cos(j_(0 k) c t) + B_k sin(j_(0 k) c t)
$
So we get
$
  phi(r, t) = sum_(k=1)^oo J_0(j_(0 k) r) [A_k cos(j_(0 k) c t) + B_k sin(j_(0 k) c t)].
$
#fade-block[
  Recall that
  $
    iprod(R_k, R_l)_w = (J'_0(j_(0 k))^2)/(2) delta_(k l) quad "where" w = r.
  $
]
Therefore,
$
  f(r) & = sum_(k=1)^oo A_k J_0 (j_(0 k) r) \
  g(r) & = sum_(k=1)^oo c j_(0 k) B_k underbracket(J_0 (j_(0 k) r), R_k (r)).
$
Hence
$
  A_k = (2)/(J'_0(j_(0 k))^2) integral_(0)^(1) f(r) J_0 (j_(0 k) r) r dif r, \
  B_k = (2)/(c j_(0 k) J'_0(j_(0 k))^2) integral_(0)^(1) g(r) J_0 (j_(0 k) r) r dif r.
$

#lecture-separator(lecture: 10, date: "2026-10-30")

=== Energy Conservation and Uniqueness

For waves on a string define energy by
$
  E(t) & = (1)/(2) mu integral_(0)^(L) y_t^2 dif x + (1)/(2) tau integral_(0)^(L) y_x^2 dif x & = "KE" + "PE".
$
Note that the first term is like $(1)/(2) m v^2$, and the latter term is the potential energy because energy stored in a small section of string is proportional to its extension, $dif s - dif x$, _i.e._
$
  dif s - dif x & = (sqrt(1+y_x^2)-1) dif x \
                & approx (1)/(2) y_x^2 dif x.
$
For convenience of notation, we will scale $E |-> (E)/(mu)$, so
$
  E(t) = (1)/(2) integral_(0)^(L) (y_t^2 + c^2 y_x^2) dif x. #eq-note[note that $(tau)/(mu) = c^2$]
$
For higher dimensional problems, we define
$
  E(t) = (1)/(2) integral_Omega (phi_t^2 + c^2 |grad phi|^2) dif V.
$
Similar to 1D, the latter term represents the potential energy, since it is proportional to extension #fade[[of _e.g._ drum skin]]. In the case of 2D,

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p9.svg", width: 20em)
]

$
  "Surface" = Set((x, y, phi(x, y)); (x, y) in Omega)
$
so we have
$
  dif S - dif x dif y & = sqrt(1+abs(grad phi)^2) dif x dif y - dif x dif y \
                      & = [sqrt(1+abs(grad phi)^2) - 1] dif x dif y \
                      & approx (1)/(2) abs(grad phi)^2 dif x dif y.
$

We have the IBVP
$
  cases(
    phi_(t t) - c^2 laplacian phi = 0 quad & (vb(x), t) in Omega times (0, oo),
    phi = 0 quad & (vb(x), t) in ∂Omega times (0, oo),
    phi(vb(x), 0) = f(vb(x)) quad & vb(x) in Omega,
    phi_t (vb(x), 0) = g(vb(x)) quad & vb(x) in Omega,
  )
$ <eq-drum-surface>
We wish to consider the evolvement of $E(t)$ over time, according to the IBVP.
$
  dv(E, t) & = integral_Omega (phi_t phi_(t t) + c^2 grad phi dot grad phi_t) dif V #eq-note[$abs(grad phi)^2 = grad phi dot grad phi$]\
  & = c^2 integral_Omega (phi_t laplacian phi + grad phi dot grad phi_t) dif V #eq-note[$phi_(t t) = c^2 laplacian phi$]\
  &= c^2 integral_Omega div (phi_t grad phi) dif V #eq-note[$laplacian = div grad$] \
  &= c^2 integral_(∂Omega) phi_t pdv(phi, vb(n)) dif S. #eq-note[divergence theorem] \
$
Since $phi(vb(x), t) = 0$ for $vb(x) in ∂Omega$, we also have $phi_t (vb(x), t) = 0$ when $vb(x) in ∂Omega$. Hence
$
  dv(E, t) = 0 => E(t) = E(0).
$
Using initial conditions,
$
  E(t) = E(0) = (1)/(2) integral_Omega (abs(g)^2 + c^2 abs(grad f)^2) dif V.
$

Therefore, energy is conserved.

#proposition[
  The solution to @eq-drum-surface is unique.
]

#proof[
  Let $phi_1, phi_2$ be solutions of @eq-drum-surface. Let $psi = phi_1 - phi_2$. Then $psi$ satisfies the same IBVP but with $f = g = 0$. Hence by conservation of energy,
  $
    0 = E(0) & = E(t) \
             & = (1)/(2) integral_Omega (psi_t^2 + c^2 abs(grad psi)^2) dif V \
  $
  Hence $psi_t = 0$ and $grad psi = 0$, _i.e._ $psi = "constant"$ in $Omega$.
  Boundary conditions give $psi = 0$ on $∂Omega$, so $psi = 0$ in $Omega$. Therefore, $phi_1 = phi_2$ in $Omega$.
]

=== Wave Reflection and Transmission

Consider an infinitely long string in tension $tau$ with density $mu_plus.minus$ on $plus.minus x > 0$. Set $c^2_plus.minus = (tau)/(mu_plus.minus )$, then the displacement satisfies
$
  (1)/(c^2_-) pdv(y, t, 2) & = pdv(y, x, 2) quad & x < 0, \
  (1)/(c^2_+) pdv(y, t, 2) & = pdv(y, x, 2) quad &  x > 0
$
_i.e._
$
  c = c(x) = cases(
    c_- quad & x < 0,
    c_+ quad & x > 0.
  )
$
Consider an incoming wave of form #fade[[$omega$ is a constant frequency]]
$
  y(x, t) = cos (omega (t - (x)/(c_-))) equiv Re [ee^(ii omega (t - (x)/(c_-)))]
$
#fade-block[
  This indeed solves the wave equation for $x < 0$, since
  $
    ee^(ii omega (t - (x)/(c_-))) & = ee^(-(ii omega)/(c_-) (x - c_- t)). \
  $
]
We expect some reflection or transmission due to environment at $x = 0$. So we expect some solution of form
$
  y(x, t) = cases(
    ee^(ii omega (t - (x)/(c_-))) + R ee^(ii omega (t + (x)/(c_-))) quad & x < 0,
    T ee^(ii omega (t - (x)/(c_+))) quad & x > 0.
  )
$ <eq-wave-reflect>
Consider the behaviour at $x = 0$.

+ We assume that the string does not break, so
  $
    y(0^+, t) = y(0^-, t).
  $

+ The point $x = 0$ on the string has no mass, so for $F = m a$ to hold, we need $F = 0$.

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p10.svg", width: 16em)
  ]

  Hence we have
  $
                            tau sin theta_+ & = tau sin theta_- \
    (pdv(y, x))_+/sqrt(1 + (pdv(y, x))_+^2) & = (pdv(y, x))_-/sqrt(1 + (pdv(y, x))_-^2) \
                          pdv(y, x)(0^+, t) & = pdv(y, x)(0^-, t) #eq-note[up to order $O(y_x^2)$].
  $

So (1) and (2) say that $y$ and $pdv(y, x)$ should be continuous at $x=0$. Using in @eq-wave-reflect, we get
$
  cancel(ee^(ii omega t))+ R cancel(ee^(ii omega t)) & = T cancel(ee^(ii omega t)), \
  (-(ii omega)/(c_-)) [cancel(ee^(ii omega t)) - R cancel(ee^(ii omega t))] & = (-(ii omega)/(c_+)) T cancel(ee^(ii omega t)).
$
Setting $lambda = (c_+)/(c_-) = sqrt(mu_-/mu_+)$, we find
$
  underbracket(R(lambda) = (lambda - 1)/(lambda + 1), "reflection coefficient"), quad underbracket(T(lambda) = (2 lambda)/(1 + lambda), "transmission coefficient").
$

Consider the following cases:

+ If $mu_+ = mu_-$, _i.e._ $lambda = 1$. Then $R = 0$, $T = 1$.

+ If $mu_+ >> mu_-$, _i.e._ $lambda -> 0$. Then $R = -1$, $T = 0$. Since $-1 = ee^(ii ppi)$, the reflected wave is exactly $ppi$ out of phase with the incoming wave.

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p11.svg", width: 23em)
  ]

+ If $mu_+ << mu_-$, _i.e._ $lambda -> oo$, then $R = 1$ and $T = 2$. We can show that
  $
    lim_(lambda -> oo) pdv(y, x) = 0 quad "on" x > 0.
  $

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p12.svg", width: 23em)
  ]

  The lighter string is _dragged_ by the end of the heavier string.

#fade-block[
  We have deduced $T, R$ from $c(x)$, but Gelfand, Levitan and Marchenko showed that we can also deduce $c(x)$ from $R$ only. This is analogous to the fact that when we observe the world, we use the reflected light to our retinas only to deduce the properties of the objects in interest.
]

#lecture-separator(lecture: 11, date: "2026-11-02")

== The Heat Equation

Consider PDE
$
  pdv(phi, t) = kappa laplacian phi quad ("constant" kappa > 0)
$
where $phi$ is the temperature of some material, and $kappa$ is the thermal diffusivity. If $pdv(phi, t)=0$, we call $phi$ the steady-state solution. Consider IBVP
$
  cases(
    phi_(t) - kappa laplacian phi & = 0 quad & (vb(x), t) in (Omega times (0, oo)),
    phi & = 0 quad & (vb(x), t) in (∂ Omega times (0, oo)),
    phi(vb(x), 0) & = f(vb(x)) quad & vb(x) in Omega
  )
$ <eq-heat-ibvp>
We try to solve the homogeneous part of @eq-heat-ibvp by writing $phi = psi(vb(x)) T(t)$. We get $exists mu in RR$ such that
$
  dot(T) + kappa mu T = 0, \
  cases(
    -laplacian psi = mu psi quad & vb(x) in Omega,
    psi = 0 quad & vb(x) in ∂Omega
  )
$
The $T$-equation is easy to solve as
$
  T(t) = A exp(-kappa mu t).
$

Hence we are left with the eigenvalue problem for the (negative) Laplacian.

=== Heat on a Square Sheet

Take $Omega = (0, L) times (0, L)$. Write
$
  psi = X(x) Y(y).
$
Then the equation $-laplacian psi = mu psi$ becomes
$
  (X'')/(X) + (Y'')/(Y) + mu =0.
$
Hence $exists lambda in RR$ such that
$
  cases(
    X'' + lambda X = 0,
    X(0) = X(L) = 0
  )
  quad,quad
  cases(
    Y'' + (mu - lambda) Y = 0,
    Y(0) = Y(L) = 0
  )
$
We get solutions
$
  X_n (x) = sin((n ppi x)/(L)), quad lambda_n = ((n ppi)/(L))^2, quad n in ZZ^+,
$
Plugging $lambda = lambda_n$ into the $Y$-equation, we get
$
  Y_m (y) = sin ((m ppi y)/(L)), quad mu_(m n) - lambda_n = ((m ppi)/(L))^2, quad m in ZZ^+.
$
By superposition, we get very general solutions to the homogeneous part of @eq-heat-ibvp,
$
  phi(x, y, t) = sum_(n, m = 1)^oo A_(m n) ee^(- kappa mu_(m n) t) underbracket(sin((n ppi x)/(L)), X_n (x)) underbracket(sin((m ppi y)/(L)), Y_m (y)).
$
The initial conditions at $t = 0$ reads
$
  f(x, y) = sum_(n, m = 1)^oo A_(m n) sin((n ppi x)/(L)) sin((m ppi y)/(L)).
$

Using orthogonality, we get
$
  integral_(0)^(L) sin((p ppi x)/(L)) sin((q ppi x)/(L)) dif x = (L)/(2) delta_(p q),
$
and hence
$
  A_(m n) = ((2)/(L))^2 integral_(0)^(L) integral_(0)^(L) f(x, y) sin((n ppi x)/(L)) sin((m ppi y)/(L)) dif x dif y.
$

=== Heat on a Cylinder (Axisymmetric Case)

In cylindrical polars,
$
  Omega = Set((rho, phi.alt, z); rho in [0, 1), phi.alt in [0, 2ppi), z in (0, L)).
$
Assume that  the initial data has form $f = f(rho, z)$, _i.e._ independent of $phi.alt$. Then we expect $phi = phi(rho, z, t)$. Try $psi = Rho (rho) Z(z)$. So
$
  (1)/(rho) pdv(, rho) (rho pdv(psi, rho)) + pdv(psi, z, 2) + mu psi = 0.
$
Hence we get
$
  (rho Rho')'/(rho Rho) + Z''/Z + mu = 0.
$
So $exists lambda in RR$ such that
$
  - (rho Rho')'/(rho Rho) = lambda, quad Z''/Z + mu = lambda.
$
_i.e._
$
  cases(
    -dv(, rho) (rho dv(Rho, rho)) = lambda rho Rho,
    Rho(1) = 0,
  )
  quad,quad
  cases(
    Z'' + (mu - lambda) Z = 0,
    Z(0) = Z(L) = 0
  )
$

Note that $Rho$-equation is the Sturm-Liouville problem associated with Bessel's equation of order $m = 0$. So we get
$
  Rho_k (rho) = J_0 (j_(0 k) rho), quad lambda_k = j_(0 k)^2, quad k in ZZ^+.
$
Plugging $lambda = lambda_k$ into the $Z$-equation, we get
$
  Z_n (z) = sin((n ppi z)/(L)), quad mu_(k n) - lambda_k = ((n ppi)/(L))^2, quad n in ZZ^+.
$
Thus, the following solves the homogeneous part of @eq-heat-ibvp,
$
  phi(rho, z, t) = sum_(k, n = 1)^oo A_(k n) ee^(- kappa mu_(k n) t) underbracket(J_0 (j_(0 k) rho), Rho_k (rho)) underbracket(sin((n ppi z)/(L)), Z_n (z)).
$
Initial conditions at $t = 0$ reads
$
  f(rho, z) = sum_(k, n = 1)^oo A_(k n) J_0 (j_(0 k) rho) sin((n ppi z)/(L)).
$
#fade-block[
  From Example Sheet 1,
  $
    integral_(0)^(1) J_0 (j_(0k) rho) J_0 (j_(0l) rho) rho dif rho = (1)/(2) J'_0(j_(0 k))^2 delta_(k l).
  $
]
By orthogonality, we get
$
  A_(k n) = (2)/(J'_0(j_(0 k))^2) (2)/(L) integral_(0)^(1) integral_(0)^(L) f(rho, z) J_0 (j_(0 k) rho) sin((n ppi z)/(L)) rho dif z dif rho.
$

Note that the leading term ($k = n = 1$) gives dominant behaviour for large $t$, since the exponential decay has exponent $- kappa mu_(k n) t = - kappa (j_(0 k)^2 + ((n ppi)/(L))^2) t$, which decreases very fast for large $k, n$.

=== Energy Loss and Uniqueness

For $phi = phi(vb(x), t)$ satisfying the IBVP @eq-heat-ibvp, define _energy_
$
  Q(t) = (1)/(2) integral_Omega phi(vb(x), t)^2 dif V.
$
Consider the evolvement of $Q(t)$ over time. We have
$
  dv(Q, t) & = integral_Omega phi phi_t dif V \
  & = integral_Omega kappa phi laplacian phi dif V #eq-note[by $phi_t = kappa laplacian phi$] \
  & = kappa integral_Omega [div (phi grad phi) - abs(grad phi)^2] dif V \
  &= kappa integral_(∂Omega) underbracket(phi, = 0) pdv(phi, vb(n)) dif S - kappa integral_Omega abs(grad phi)^2 dif V \
  &= - kappa integral_Omega abs(grad phi)^2 dif V <= 0. \
$
So $(dif Q)/(dif t) &<= 0$. Integrating over $[0, t]$, we get
$
                                Q(t) & <= Q(0) \
  (1)/(2) integral_Omega phi^2 dif V & <= (1)/(2) integral_Omega f^2 dif V.
$
We can now establish uniqueness of solutions to @eq-heat-ibvp. Suppose $phi_1, phi_2$ satisfy @eq-heat-ibvp. Then $phi = phi_1 - phi_2$ satisfies the same IBVP but with $f = 0$. Hence
$
  (1)/(2) integral_Omega phi^2 dif V <= (1)/(2) integral_Omega 0 dif V = 0.
$
So $phi = 0$ in $Omega times (0, oo)$, _i.e._ $phi_1 = phi_2$ in $Omega times (0, oo)$.

#fade-block[
  Note that in the above we require finite energy for the argument to work. Consider
  $
    phi(x, t) = sum_(n=0)^oo x^(2 n)/((2n)!) f^((n))(t)
  $
  where
  $
    f(t) = cases(
      0 quad & t = 0,
      exp(-1/t^2) quad & t > 0.
    )
  $
  Then $f^((n))(0) = 0$ for $n in ZZ_(>=0)$. Therefore, we can show that
  $
        phi_t & = phi_(x x) #eq-note[($kappa = 1$)] \
    phi(x, 0) & = 0
  $
  This has a non-trivial solution, but $phi$ has _infinite_ energy.
]



