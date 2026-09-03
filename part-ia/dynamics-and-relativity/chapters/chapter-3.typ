#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": qty

#lecture-separator(lecture: 6, date: "2026-02-03")

= Central Forces

An important class of potentials only depend on the distance to the origin, such that

$
  V(bold(x)) = V(abs(bold(x)) ) = V(r).
$

The force points towards (or away from) the origin, so
$
  bold(F) = -bold(nabla) V = -(dif V)/(dif r) bold(nabla) r.
$

Recall that
$
  bold(nabla) r = bold(x)/r = hat(bold(x)).
$

Thus,
$
  bold(F) = - (dif V)/(dif r) hat(bold(x)) #<eq-124>
$

We will study the motion of a particle under a central force, particularly in polar coordinates.

== Conservation of Angular Momentum

The most important fact about central potentials is that angular momentum is conserved. We have
$
  bold(L) = m bold(x) times bold(dot(x)) = bold(x) times bold(p),
$
where $bold(L)$ is the angular momentum, and $bold(p) = m bold(dot(x))$ is the linear momentum. Note that $bold(L)$ is #ponder("linear-algebra.orthogonality")[orthogonal] to both position and velocity/momentum.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e12.svg", width: 18em)
]

$bold(L)$ is defined relative to an origin, here we are setting the origin at $bold(x)=bold(0)$, which will be generalised later.

For a general force $bold(F)$,
$
  (dif bold(L))/(dif t) = m (dif )/(dif t) (bold(x) times bold(dot(x))) = m(bold(dot(x)) times bold(dot(x)) + bold(x) times bold(dot.double(x))) = bold(x) times bold(F) equiv bold(G),
$
where $bold(G)$ is the torque. _i.e._
$
  bold(dot(L)) = bold(G).
$
This is analogous to #ponder("dynamics.newtons-second-law")[Newton's law] @eq-8, but for rotational motion. #fade[[$bold(G)$ can be thought of as the _rotational force_, and $bold(L)$ as the _rotational momentum_.]]

For a central force, $bold(F) parallel bold(hat(x)) => bold(x) times bold(F) = bold(G) = bold(0)$. Thus, angular momentum is conserved:
$
  bold(dot(L)) = bold(0).
$

Since $bold(L)$ doesn't change, and obeys
$
  cases(
    bold(L) dot bold(x) = 0,
    bold(L) dot bold(dot(x)) = 0,
  )
$
where the position and velocity are constrained to a plane perpendicular to $bold(L)$. Hence, we have reduced the problem from 3D to 2D.

== Polar Coordinates in the Plane

Within polar coordinates, we have
$
  cases(
    x & = r cos theta,
    y & = r sin theta
  )
$

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e13.svg", width: 14em)
]

In cartesian coordinates, #fade[[see IA Vector Calculus for more details]]
$
  bold(hat(r)) = vec(cos theta, sin theta), quad bold(hat(theta)) = vec(-sin theta, cos theta).
$
Note that
$
  bold(hat(r))^2 = bold(hat(theta))^2 = 1, quad bold(hat(r)) dot bold(hat(theta)) = 0.
$

#important[
  These vectors depend on positions. We have
  $
    (dif bold(hat(r)))/(dif theta) = bold(hat(theta)), quad (dif bold(hat(theta)))/(dif theta) = - bold(hat(r)).
  $

  Hence, we must keep track of these changes when we write equations in polar coordinates.
]

Consider #ponder("dynamics.newtons-second-law")[Newton's equation] #fade[[_i.e._ $bold(F) = m bold(dot.double(x))$]] in polar coordinates,
$
  bold(x) & = r bold(hat(r)) \
  bold(dot(x)) & = dot(r) bold(hat(r)) + r bold(dot(hat(r))) \
  & = dot(r) bold(hat(r)) + r dot(theta) (dif bold(hat(r)))/(dif theta) \
  & = dot(r) bold(hat(r)) + r dot(theta) bold(hat(theta)) \
  bold(dot.double(x)) &= dot.double(r) bold(hat(r)) + 2dot(r) dot(theta) bold(hat(theta)) + r dot.double(theta) bold(hat(theta)) - r dot(theta)^2 bold(hat(r)) \
  & = (dot.double(r) - r dot(theta)^2) bold(hat(r)) + (r dot.double(theta) + 2 dot(r) dot(theta)) bold(hat(theta)) #<eq-139>
$

#example[Circular motion at constant angular speed][
  We have
  $
    dot(r) = 0, quad dot.double(r) = 0, quad dot(theta) = omega, quad dot.double(theta) = 0.
  $
  Thus,
  $
    bold(dot.double(x)) = - r omega^2 bold(hat(r)).
  $

  Note that #ponder("dynamics.circular-motion")[circular motion] requires a centripetal force towards the origin.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e14.svg", width: 12em)
  ]
] <ex-circular-motion>

Matching components of @eq-124 with @eq-139 substituted in @eq-8, we have
$
  bold(hat(theta)): quad & r dot.double(theta) + 2 dot(r) dot(theta) = 0, #<eq-142> \
      bold(hat(r)): quad & m (dot.double(r) - r dot(theta)^2) = - (dif V)/(dif r). 
$
These are the #ponder("dynamics.newtons-second-law")[Newton's equations] for a central force in polar coordinates.

Hence, @eq-142 gives
$
  (1)/(r) (dif )/(dif t) (r^2 dot(theta)) = 0.
$
Thus $l equiv r^2 dot(theta)$ is constant.

In fact, this is the magnitude of the angular momentum per unit mass:
$
       bold(L) & =m bold(x) times bold(dot(x)) \
               & = m r bold(hat(r)) times (dot(r) bold(hat(r)) + r dot(theta) bold(hat(theta))) \
               & = m r^2 dot(theta) (bold(hat(r)) times bold(hat(theta))) \
  abs(bold(L)) & = m r^2 dot(theta) = m l.
$
Sometimes, $l$ is called the "angular momentum", even though it is angular momentum per unit mass. Using the definition of $l$ in the equation for $hat(r)$, we have
$
  m (dot.double(r) - r (l^2)/(r^4)) = - (dif V)/(dif r). \
$
We can rewrite this as
$
  m dot.double(r) = - (dif V_"eff")/(dif r)
$
where $V_"eff"$ is the effective potential defined by
$
  V_"eff" (r) = V(r) + (m l^2)/(2 r^2).
$
Hence we have reduced the motion to an effective one-dimensional problem in the radial direction. This is possible because of the conservation of angular momentum.

#remark[
  The effective potential is what a radial observer would see. There seems to be an extra repulsive potential at small $r$ due to the angular momentum, which is called the centrifugal barrier.
]

== The Effective Potential

Consider $V(r) = -(k)/(r)$, _i.e._ an attractive $(1)/(r)$ potential. The effective potential is
$
  V_"eff" (r) = - (k)/(r) + (m l^2)/(2 r^2).
$

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e15.svg", width: 22em)
]

We have a centrifugal barrier at small $r$ due to the angular momentum term. The angular momentum prevents the particle from getting too close to the origin.

We can also see the effective potential from the #ponder("dynamics.conservation-of-energy")[conserved energy],
$
  E = & (1)/(2) m bold(dot(x))^2 + V(r) \
      & = (1)/(2) m (dot(r)^2 + r^2 dot(theta)^2) + V(r) \
      & = (1)/(2) m dot(r)^2 + (m l^2)/(2 r^2) + V(r) \
      & = (1)/(2) m dot(r)^2 + V_"eff" (r).
$
The centrifugal barrier is the angular kinetic energy.

Different cases arise depending on the energy $E$.

#lecture-separator(lecture: 7, date: "2026-02-05")

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e16.svg", width: 22em)
]

Now, suppose instead that $V = -(k)/(r^n)$ where $n > 2$. Then


#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e17.svg", width: 22em)
]

Note that in $V = -(k)/(r^n)$ there are no stable bound orbits, and the particle can fall to the origin.

#remark[
  #ponder("dynamics.gravitational-force")[Gravity] in $d$ space dimensions has
  $
    V prop (1)/(r^(d-2)).
  $
  Moreover, circular orbits are stable only for $d < 4$. Hence, our universe has a special number of dimensions for stable planetary orbits.
]

== The Orbit Equation

We shall now see how to solve the equations of motion for a central potential. Consider $ u = (1)/(r). $ We want to derive the orbit equation for $u(theta)$. Recall the case that

$
  m dot.double(r) & = - (dif V_"eff")/(dif r) \
      V_"eff" (r) & = V(r) + (m l^2)/(2 r^2) \
             V(r) & = -(k)/(r).
$


Under the change of variables $r(t) -> u(theta)$,
$
  (dif r)/(dif t) &= (dif r)/(dif theta) (dif theta)/(dif t) = - (1)/(u^2) (dif u)/(dif theta) (l)/(r^2) = - l (dif u)/(dif theta)\
  (dif^(2) r)/(dif t^(2)) &= (dif )/(dif t) (-l (dif u)/(dif theta) ) = -l (dif^2 u)/(dif theta^2) (dif theta)/(dif t) = - l^2 u^2 (dif^2 u)/(dif theta^2).
$

Then
$
                 m dot.double(r) - (m l^2)/(r^3) & = F(r) = - (dif V)/(dif r) \
  -l^2 m u^2 (dif^2 u)/(dif theta^2) - m l^2 u^3 & = F(1/u) \
                     (dif^2 u)/(dif theta^2) + u & = - (1)/(m l^2 u^2) F(1/u).
$
A special case arises when $V = -(k m)/(r)$, _i.e._ the Kepler problem.
$
  (dif^2 u)/(dif theta^2) + u = (k)/(l^2).
$
This equation is a harmonic oscillator with a displaced centre. The solution is
$
  u = A cos(theta - theta_0) + (k)/(l^2).
$
Note that $u$ is largest at $theta = theta_0$, and $r$ is smallest there, which is the periapsis.

We can choose axes on the plane so that $theta_0 = 0$. Then
$
  r = (r_0)/(e cos theta + 1)
$
where $r_0 = (l^2)/(k)$ and $e$ is a constant of integration. The shape of the orbit depends on $e$. Note that this is the equation for a #ponder("geometry.conic")[conic section] in polar coordinates, and $e$ is the #ponder("geometry.eccentricity")[eccentricity].

$
  ("bounded orbit", (r)/(r_0) in [(1)/(1+e), (1)/(1-e)]) quad E < 0 & quad &     e = 0 & : "circular orbit" \
                                                                    &      & 0 < e < 1 & : "elliptical orbit" \
                                                                E=0 & quad &     e = 1 & : "parabolic orbit" \
                                                                E>0 & quad &     e > 1 & : "hyperbolic orbit"
$

#proof[
  #fade[[Ellipse.]]

  With $0 < e < 1$, we can rearrange to get
  $
        r_0 - r e cos theta & = r \
    (r_0 - r e cos theta)^2 & = r^2 \
              (r_0 - e x)^2 & = x^2 + y^2.
  $
  Hence we can regroup to get
  $
    (x - x_c)^(2)/(a^2) + (y^2)/(b^2) = 1
  $

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e18.svg", width: 16em)
  ]

  where $a, b, x_c$ are given in terms of $e$ and $r_0$. For example,
  $ x_c = -(e r_0)/(1-e^2) = - e a. $

  Planets in the solar system have small $e$, so that they are close to circular. _e.g._

  - the largest $e$ is for Mercury, which has $e approx 0.2$.

  - Halley's comet has $e approx 0.97$.


]

#proof[
  #fade[[Parabola.]]

  With $e = 1$, we get
  $
    r_0^2 - 2r_0 x + x^2 = x^2 + y^2\
    r_0^2 - 2r_0 x = y^2. \
  $
  This is the equation for a parabola.
]

#proof[
  #fade[[Hyperbola.]]

  Note that $r->oo$ at $cos theta = - (1)/(e)$. Hence, the asymptotes satisfy $theta > pi / 2$. Hence,

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e19.svg", width: 10em)
  ]
]

We can evaluate the energy on the solution,
$
  E & = (1)/(2) m dot(r)^2 + (m l^2)/(2 r^2) - (k m)/(r) \
    & = (m k^2)/(2 l^2) (e^2 - 1) quad "by algebra". \
$
Hence the energy is negative for bounded orbits, zero for parabolic orbits, and positive for hyperbolic orbits. In particular, for a #ponder("dynamics.circular-motion")[circular orbit],
$
  E = - (m k^2)/(2 l^2)
$
which is the minimum of $V(r)$.

== Kepler's Laws

A consequence of the above are #ponder("dynamics.keplers-laws")[Kepler's laws] of planetary motion.

#proposition[Kepler's Laws][

  / K1: Planets move in ellipses with the Sun at one focus.

  / K2: The line between the planet and the Sun sweeps out equal areas in equal times, and $ dot(A) = (l)/(2). $

  / K3: The period of of the orbit is proportional to $"radius"^((3)/(2))$.

] <prop-keplers-laws>

#proof[

  / K2: We have
    #align(center)[
      #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e20.svg", width: 16em)
    ]

    where
    $
      delta A = (1)/(2)r^2 delta theta => dot(A) = (1)/(2)r^2 dot(theta) = (l)/(2).
    $

    It follows from the conservation of angular momentum, for any central force.

  #lecture-separator(lecture: 8, date: "2026-02-10")

  / K3: It is natural to consider #ponder("dynamics.dimensional-analysis")[dimensional analysis]. The only parameter in #ponder("dynamics.newtons-second-law")[Newton's equation] is $k=G M$. Hence the period satisfies

    $
        T & = c R^A k^B \
      [T] & = [R]^A [k]^B \
        T & = L^A (L^3 T^(-2))^B = L^(A+3B) T^(-2B).
    $
    Hence $A + 3B = 0$ and $-2B = 1$, so $A = 3/2$ and $B = -1/2$. Thus,
    $
      T = c R^((3)/(2))/(k^(1/2)).
    $
    Note that there is no unique radius associated to an ellipse, but taking any will do.

    #separator

    More precisely, starting with $dot(A) = (l)/(2)$, we have the full period
    $
      T & = integral_0^T dif t \
        & = integral_0^A 2/l dif A \
        & = (2)/(l) A \
        & = (2)/(l) ppi a b \
        & = (2 ppi)/(l) (r_0^2)/((1-e^2)^((3)/(2))) \
        & = (2 ppi)/(sqrt(G M) ) ((r_0)/(1-e^2))^((3)/(2)) quad "by" l^2=k r_0 \
        & = (2 ppi)/(sqrt(G M) ) R_"avg"^(3 slash 2) \
    $
    where $R_"avg" = (r_0)/(1-e^2)$ is the average radius of the ellipse.

]

== Repulsive Potentials and Scattering

Given a central potential $V(r)$ such that $V->0$ as $r->oo$, one can perform scattering experiments by sending in a particle from large $r$ and see how it moves out again.

#definition[Impact Parameter][
  The #ponder("dynamics.impact-parameter")[*impact parameter*] $b$ is the distance of closest approach if there were no forces.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e21.svg", width: 21em)
  ]
] <def-impact-parameter>

#proposition[

  The #ponder("dynamics.impact-parameter")[impact parameter] is related to the angular momentum (per unit mass) $l = (abs(bold(L)) )/(m)$ as
  $
    l = b v.
  $
] <prop-impact-parameter>

#proof[
  A non-interacting particle has a conserved angular momentum. The velocity does not change. At the closest point,
  $
    l = abs(bold(x) times bold(dot(x))) = b v.
  $

  This must also be the angular momentum at the start. But the initial $l$ is the same for the interacting and non-interacting particles and is also conserved in the interacting case.

]

Rutherford scattering (1911) showed that certain scattering experiments of atoms could be explained if all the positive charge in an atom was confined to a tiny nucleus.

Scattering by a repulsive interaction for two positively charged parciules satisfies
$
  V = (kappa)/(r) quad "with" kappa = (q Q)/(4 ppi epsilon_0).
$

We may reuse results from Kepler problem by setting $-k m -> kappa$.

In particular, the orbits are
$
  r = (r_0)/(tilde(e) cos theta - 1)
$
with $r_0 = (l^2 m)/(kappa)$.

We want to find the angle $phi$ through which the particle is scattered.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e22.svg", width: 22em)
]

Note that incoming and outgoing #ponder("dynamics.impact-parameter")[impact parameters] are equal by conservation of $l$ and $E$. #fade[[And hence $v$ at infinity.]]

Clearly

- $ppi = phi + 2 alpha$
- $tilde(e) cos alpha = 1$ #fade[[The particle goes to infinity at $theta = alpha$.]]

Then we can get $phi$ in terms of #ponder("dynamics.impact-parameter")[impact parameter] and initial velocity,
$
  E & = (1)/(2) m v^2 quad                                 &                     "conserved, using intial energy" \
    & = (kappa^2)/(2 l^2 m) (tilde(e)^2 - 1) quad          &                 "same formula as for conic sections" \
    & = (kappa^2)/(2 m b^2 v^2) tan^2 alpha quad           & l = b v "and" (tilde(e)^2-1) = (1)/(cos^2 alpha) - 1 \
    & = (kappa^2)/(2 m b^2 v^2) (1)/(tan^2 (phi)/(2)) quad &  tan alpha = tan (ppi-phi)/(2) = (1)/(tan (phi)/(2)) \
$
Hence, matching the first and last expressions, we have
$
  phi = 2 arctan (kappa)/(m b v^2).
$

Note that a small $b$ leads to large angle scattering, and it allows scattering to probe very small distances.
