#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= First Integrals and Fermat's Principle

Consider the functional
$
  F[y] = integral_alpha^beta f(y(x), y'(x), x) dif x.
$
If $pdv(f, y) = 0$, then the Euler-Lagrange equation can be integrated to give the *first integral*
$
  pdv(f, y') = "constant".
$
This is a first order ODE, which is easier to solve than the second order Euler-Lagrange equation.

#lecture-separator(lecture: "6", date: "2026-05-13")

#claim[
  If $f$ has no explicit $x$-dependence, _i.e._ $pdv(f, x) = 0$, then
  $
    f-y' pdv(f, y') = "constant"
  $
  for any solution of the Euler-Lagrange equation. Hence this is another first integral.
]

#proof[
  Consider
  $
    dv(f, x) & = dv(, x)(f (y(x), y'(x), x)) \
             & = pdv(f, x) + pdv(f, y) y' + pdv(f, y') y'' \
             & = pdv(f, x) + y' [pdv(f, y) - dv(, x)pdv(f, y')] + dv(, x) (y' pdv(f, y')) \
  $
  If the Euler-Lagrange equation is satisfied, then $pdv(f, y) - dv(, x)pdv(f, y') = 0$. Hence,
  $
    dv(, x) (f-y' pdv(f, y')) = pdv(f, x).
  $
  So if $pdv(f, x) = 0$, then $f-y' pdv(f, y')$ is constant.

]

#example[The Brachistochrone Curve][
  A bead slides on a frictionless curve in a vertical plane under the influence of gravity. Consider the shape of the wire that minimises the time for the bead to fall from rest at $A$ to a lower, horizontally displaced point $B$. We will choose axes so that $A$ is at the origin. An example of such wire is shown in the figure below.
  #align(center)[
    #dynamic-svg2("/part-ib/variational-principles/media/d1e1.svg", width: 12em)
  ]
  By conservation of energy,
  $
    (1)/(2) m v^2 + m g y = 0.
  $
  Thus $v = sqrt(-2 g y)$. The time is hence
  $
    T & = integral_A^B (1)/(v) dif l \
      & = (1)/(sqrt(2g) ) integral_A^B (1)/(sqrt(-y) ) sqrt((dif x)^2 + (dif y)^2) \.
  $
  Assuming that $x$ is a good parameterisation of the curve, we have
  $
    T & prop integral_0^x_B (sqrt(1+(y')^2) )/(sqrt(-y) ) dif x.
  $
  Therefore we have $f = sqrt((1+(y')^2)/(-y))$. There is no explicit $x$-dependence, so there exists a first integral
  $
    "constant" = f - y' pdv(f, y') = (1)/(sqrt((-y)(1+(y')^2)))
  $
  Hence
  $
    (-y)(1+(y')^2) = 2 c
  $
  where $c$ is some positive constant. This can be solved by substituting
  $
    y = -c(1-cos theta) quad "where" quad theta >= 0
  $
  to obtain
  $
    dv(x, theta) = plus.minus c (1-cos theta)
  $
  Choosing the positive sign (so $x$ increases with $theta$), we have
  $
    x = c (theta - sin theta)
  $
  which can be solved with initial conditions, $x=0$ at $y=theta=0$, and $x = x_B$ at $y = y_B$.

  These equations describe an inverted *cycloid*. #fade[[A cyclic is the path traced out by a fixed point on the rim of a disc that rolls along a straight line.]] A good illustration can be found #link("https://commons.wikimedia.org/wiki/File:Brachistochrone_curve.gif")[online].
]

== Fermat's Principle

Consider light propagating in a (not necessarily uniform) medium.

Let $c(vb(x))$ be the speed of light in the medium, and $c$ be the speed of light in vacuum.

#definition[Refractive Index][
  The *refractive index* of the medium with speed of light $c(vb(x))$ is
  $
    n(vb(x)) := c/c(vb(x)).
  $
]

The time $T[C]$ taken for light to travel from point $A$ to point $B$ along a path $C$ is
$
  T[C] = integral_C (1)/(c(vb(x))) dif l = (1)/(c) integral_C n(vb(x)) dif l = (1)/(c) P[C].
$

where $P[C]$ is the *optical path length* of the path $C$.

#rule[Fermat's Principle][
  Light travels from $A$ to $B$ along the path $C$ that (locally) minimises $T[C]$, or equivalently, $P[C]$.
]

#example[
  Consider the path of a light ray in the $(x, z)$ plane in a medium with refractive index
  $
    n(z) = sqrt(a - b z), quad "where" a, b > 0.
  $
  Assume the path can be parameterised by $x$, so that $z = z(x)$ and $alpha <= x <= beta$. Then
  $
    P[z] = integral_alpha^beta n(z) underbracket(sqrt(1+(z')^2) dif x, dif l) = integral_alpha^beta f(z, z') dif x.
  $
  Note that $pdv(f, x) = 0$. So the first integral gives some constant $k$ such that
  $
    k & = f - z' pdv(f, z') = n(z)/(sqrt(1+(z')^2) ) = sqrt((a-b z)/(1+ (z')^2)) .
  $
  Therefore, we can rearrange to get
  $
    (z')^2 = (b)/(k^2) (z_0 - z) quad "where" quad z_0 := (a-k^2)/(b).
  $
  Thus
  $
                          z' & = plus.minus sqrt((b)/(k^2) (z_0-z)) \
            z'/sqrt(z_0 - z) & = plus.minus sqrt(b)/k \
    dv(, x) (-2sqrt(z_0-z) ) & = plus.minus sqrt(b)/k \
                           z & = z_0 - (b)/(4k^2)(x-x_0)^2 \
  $
  where $x_0$ is a constant of integration. This is a parabola.
]
