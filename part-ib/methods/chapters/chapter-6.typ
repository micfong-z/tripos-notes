#import "../prelude.typ": *
#show: chapter.with(6)

#lecture-separator(lecture: 19, date: "2026-11-20")

= PDEs on Unbounded Domains

== Well-Posedness

Hadamard declared in 1902 that a PDE is well-posed if the solution

+ exists;

+ is unique;

+ depend continuously on given data (boundary conditions, initial conditions).

The meaning of (1) (2) are obvious, but (3) is more subtle. In an abstract sense, the solution, _e.g._ to an IBVP, defines a map
$
  S_t : underbracket(X, "I.C. and B.C."\ "live in here") -> underbracket(Y, "solution at time" t\ "lives in here").
$

To talk about continuity, we need a norm, metric or a topology on $X, Y$ to measure _closeness_.

#example[IVP][
  Consider for $t >= 0$,
  $
    dv(x, t) = -x, quad x(0) = x_0 in RR.
  $
  Then we get solution
  $
    X_0 (t) = x_0 ee^(-t).
  $
  If instead $x(0) = x_1 in RR$, we get solution
  $
    X_1 (t) = x_1 ee^(-t).
  $
  Observe that
  $
    norm(X_1-X_0)_oo = sup_(t>=0) abs(x_1 ee^(-t) - x_0 ee^(-t)) = abs(x_1 - x_0).
  $
  So if $x_0, x_1$ are _close_ #fade[[w.r.t. the standard Euclidean metric on $RR$]], then $X_0, X_1$ are _close_ #fade[[w.r.t. $norm(dot)_oo$ norm]].
]

#example[IBVP, Backward Heat Equation][
  We have IBVP (Dirichlet boundary conditions) on $Omega = (0, ppi)$
  $
    cases(
      phi_t + phi_(x x) = 0 quad & (x, t) in Omega times (0, oo),
      phi = f quad & (x, t) in Omega times {0},
      phi = 0 quad & (x, t) in ∂Omega times (0, oo)
    )
  $
  If $f(x) = 0$, we get $phi(x, t) = 0$. If instead we take
  $
    f = f_n (x) = (1)/(n) sin(n x),
  $
  then we get solutions
  $
    phi_n (x, t) = (1)/(n) ee^(n^2 t) sin(n x).
  $
  Now,
  $
    norm(f - f_n)_oo & = sup_(x in Omega) abs(0 - (1)/(n) sin(n x)) \
                     & = (1)/(n) \
                     & -> 0 "as" n -> oo.
  $
  However, for all $T > 0$,
  $
    norm(phi(dot, T) - phi_n (dot, T))_oo & = sup_(x in Omega) abs(-(1)/(n) ee^(n^2 T) sin(n x)) \
                                          & = (1)/(n) ee^(n^2 T) \
                                          & -> oo "as" n -> oo.
  $
  So our abstract map
  $
    S_T [f - f_n] arrow.not 0
  $
  even though $f - f_n -> 0$. Hence $S_T$ not continuous #fade[[w.r.t. $norm(dot)_oo$]], so the problem is ill-posed, even locally on time.

  #question[
    Is this a mathematical demonstration of the arrow of time, based on well-posedness?
  ]
]
To avoid technicalities, we will take well-posedness to mean that

+ (1), (2) holds, and

+ small perturbations in the initial and boundary conditions leads to small perturbations in the solutions.


== Method of Characteristics

We want to solve PDE on $RR^2$ of the form
$
  a(x, y) pdv(u, x) + b(x, y) pdv(u, y) = c(x, y, u)
$ <eq-quasilinear-pde>
where $(x, y) in RR^2$, which is called quasilinear.

Note that LHS is a directional derivative $vb(v) dot grad u$, where $vb(v) = vec(a, b)$. Assume that initial data has been given on some curve $C$, _i.e._ $eval(u)_C = f$ where $f$ is known. To solve, we can write down definition of integral curves of $vb(v)$ #fade[[$dot(vb(x)) = vb(v)(vb(x))$]], $dv(x, t) = a(x, y)$, $dv(y, t) = b(x, y)$, called *characteristic equations*, whose solutions are called *characteristic curves*.

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p20.svg", width: 22.2em)
]

Assume that we have solved to get
$
  x = x(t), quad y = y(t)
$
such that $(x(0), y(0)) in C$. Define $z(t)$ to be $u$ evaluated on a characteristic curve, _i.e._
$
  z(t) = u (x(t), y(t)).
$
By chain rule, @eq-quasilinear-pde becomes
$
  dv(z, t) & = dv(x, t) pdv(u, x) + dv(y, t) pdv(u, y) \
           & = underbracket(a pdv(u, x) + b pdv(u, y) = c(x, y, z), "all evaluated at" x=x(t)\, y=y(t)). \
$
So we get
$
  dv(z, t) = c(x, y, z).
$
Assume that we can solve the equation. Note that
$
  z(0) = u(x(0), y(0)) = eval(u)_((x(0), y(0)) in C) = eval(f)_C.
$

To find $u$ at $(x, y)$, find characteristic curve that goes through the point $(x, y)$, trace it back to $C$ #fade[[find $t$]], then see how far along $C$ we are #fade[[find $s$]]. Then invert
$
  (x, y) <-> (s, t).
$

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p21.svg", width: 24em)
]

#example[
  Consider
  $
    pdv(u, x) + pdv(u, y) = u, quad u(x, 0) = f(x).
  $
  So $C = Set((s, 0); s in RR)$ gives characteristic equations
  $
    dv(x, t) = 1, dv(y, t) = 1 => cases(
      x = x_0 + t,
      y = x_0 + t.
    )
  $
  We want $(x_0, y_0) in C$, _i.e._ $(x_0, y_0) = (s, 0)$ such that
  $
    x & = s + t \
    y & = t.
  $
  If $z(t) = u(x(y), y(y))$, we know that #fade[[with $c(x, y, u) = u$]]
  $
    dv(z, t) = z,
  $
  and hence $z(t) = z_0 ee^t$. Note that
  $
    z_0 = z(0) = u(x_0, y_0) = u(s, 0) = f(s).
  $
  Then $z(t, s) = f(s) ee^(t) = u(x(t, s), y(t, s))$. Invert to get
  $
    t &= y,\
    s &= x - y.
  $
  So we get the solution
  $
    u(x) = f(x-y) ee^(y).
  $
]

We don't want characteristic curves to be tangent to $C$, so require $eval(vb(n) dot vb(v))_C != 0$, where $vb(n)$ is normal to $C$.
