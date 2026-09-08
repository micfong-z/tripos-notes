#import "../prelude.typ": *

= Rigid Bodies

This is a class of tractable $N$-body problems, where the distances between the $N$ particles are fixed. In practice, this is due to very strong internal forces.

#definition[Rigid Body][
  A #ponder("dynamics.rigid-body")[*rigid body*] is a collection of particles such that the distance between any two particles is fixed.
] <def-rigid-body>

The only motions a #ponder("dynamics.rigid-body")[rigid body] can undergo are translations of the #ponder("dynamics.centre-of-mass")[centre of mass], and rotations.

== Angular Velocity

In three dimensions, rotations are described by an angular velocity vector $vb(omega)$. We write
$
  vb(omega) = omega vu(n),
$
where $vu(n)$ points along the axis of rotation, and $omega = abs(vb(omega)) = dot(theta)$ is the angular speed of rotation. The direction of $vb(omega)$ is determined by the right hand rule.

This is captured by the equation
$
  vb(dot(x)) = vb(omega) times vb(x).
$

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e24.svg", width: 20em)
]

We have

- $vb(dot(x))$ orthogonal to both $vb(omega)$ and $vb(x)$

- $abs(vb(dot(x))) = omega abs(vb(x)) sin phi = omega d$

Hence indeed $omega = abs(dot(theta))$. Note that $d = abs(vu(n) times vb(x))$.

In addition to the angular velocity, a rotation must specify a point about which the axis of ration passes, since there are infinitely many parallel axis an object can rotate about.

$vb(x)$ in the equation $vb(dot(x)) = vb(omega) times vb(x)$ is the position relative to some (any) point on the axis of rotation.

#remark[
  The equations above instantaeous behavior of a particle, so $vb(omega)$ can depend on $t$.
]

#lecture-separator(lecture: 11, date: "2026-02-17")

== Moment of Inertia

Rotation of a particle involves kinetic energy. For a single particle, we have
$
  T = (1)/(2) m vb(dot(x))^2 & = (1)/(2) m (vb(omega) times vb(x))^2 \
                               & = (1)/(2) m omega^2 d^2 \
$
where $d = abs(vu(n) times vb(x))$ is the perpendicular distance of particle from an axis of rotation.

In a #ponder("dynamics.rigid-body")[rigid body], all particles rotate with the same angular velocity:
$
  vb(dot(x)_i) = vb(omega) times vb(x)_i.
$

This keeps the distances between particles fixed, since
$
  dv(, t) abs(vb(x_i) - vb(x_j))^2 = 2 (vb(dot(x)_i) - vb(dot(x)_j)) dot (vb(x)_i - vb(x)_j) = 2 (vb(omega) times (vb(x)_i - vb(x)_j)) dot (vb(x)_i - vb(x)_j) = 0.
$


The kinetic energy of a #ponder("dynamics.rigid-body")[rigid body] is then
$
  T =(1)/(2) sum_i m_i vb(dot(x)_i)^2 & = (1)/(2) I omega^2,
$ <kinetic-energy-of-rigid-body>

where $ I = sum_i m_i d_i^2 $ is the #ponder("dynamics.moment-of-inertia")[*moment of inertia*] of the #ponder("dynamics.rigid-body")[rigid body] about the axis of rotation.

#remark[
  $I$ depends on the choice of axis of rotation, since $d_i$ does.
]

In @kinetic-energy-of-rigid-body, see that $I$ is effectively a _rotational mass_. The bigger $I$ is, the harder it is to rotate the body.

The *angular momentum* of a #ponder("dynamics.rigid-body")[rigid body] is
$
  vb(L) & = sum_i m_i vb(x_i) times vb(dot(x)_i) \
          & = sum_i m_i vb(x_i) times (vb(omega) times vb(x_i)).
$

In this course, we only consider the component of $vb(L)$ along the axis of rotation, so define
$
  L & = vb(L) dot vu(n) \
    & = omega sum_i m_i [vb(x_i) times (vu(n) times vb(x_i))] dot vu(n) \
    & =omega sum_i m_i (vu(n) times vb(x_i)) dot (vu(n) times vb(x_i)) \
    & = omega sum_i m_i d_i^2 \
    & = omega I.
$

Again, we can observe that $I$ is a _rotational mass_.

Recall that torque causes change in the angular momentum, as $vb(dot(L)) = vb(G)$. If the torque is also along the axis of rotation, then we can write
$
  vb(G) = G vu(n),
$
and dotting $vb(dot(L)) = vb(G)$ with $vu(n)$ gives
$
  G = I dot(omega).
$
Hence $G$ acts like a _rotational force_, causing change in the angular velocity.

To calculate the #ponder("dynamics.moment-of-inertia")[moment of inertia], we use the fact that at large $N$, the particles are densely spaced, and the sums can be approximated by integrals.

$
  sum_i m_i f(vb(x)_i) approx integral f(vb(x)) rho(vb(x)) dif^3 vb(x)
$

where $rho(vb(x))$ is the density of mass of the #ponder("dynamics.rigid-body")[rigid body]. We typically consider uniform density, so
$
  rho(x) = rho_0,
$
which is a constant.

For example, we have
$
  M & = sum_i m_i = integral rho(vb(x)) dif^3 vb(x) \
  I & = integral rho(vb(x)) x_perp^2 dif^3 vb(x)
$

where $x_perp$ is the perpendicular distance from $vb(x)$ to the axis of rotation.

#example[Moment of Inertia of Rigid Bodies with Uniform Density][
  1. Consider a rotating hoop of radius $a$. We have

    #align(center)[
      #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e25.svg", width: 8em)
    ]

    $
      M & = 2 ppi a rho \
      I & = 2 ppi a^3 rho
    $
    Hence $I = M a^2$.

  2. Consider a rotating rod of length $ell$ about an axis through an endpoint.

    #align(center)[
      #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e26.svg", width: 8em)
    ]

    Then
    $
      M & = ell rho \
      I & = rho integral_0^ell x^2 dif x \
        & = (1)/(3) ell^3 rho
    $
    Hence $I = (1)/(3) M ell^2$.

  3. Consider a rotating disc of radius $a$ about an axis through its centre.

    #align(center)[
      #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e27.svg", width: 8em)
    ]

    Then
    $
      M & = ppi a^2 rho \
      I & = rho integral_0^a 2 ppi r^3 dif r \
        & = (1)/(2) ppi a^4 rho
    $
    Hence $I = (1)/(2) M a^2$.

  4. Consider a rotating sphere of radius $a$ about an axis through its centre.

    #align(center)[
      #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e28.svg", width: 4em)
    ]

    Then
    $
      M & = (4)/(3) ppi a^3 rho \
      I & = rho integral_0^a 2 ppi r^4 dif r integral_0^pi sin^3 theta dif theta \
        & = (8)/(15) ppi a^5 rho
    $
    Hence $I = (2)/(5) M a^2$.
] <ex-moment-inertia-uniform-density>


== Perpendicular Axis Theorem

We will now consider less symmetric axes.


#theorem[Perpendicular Axis Theorem][
  For a planar body, the #ponder("dynamics.moment-of-inertia")[moment of inertia] about an axis perpendicular to the plane is the sum of the #ponder("dynamics.moment-of-inertia")[moments of inertia] about any two orthogonal axes in the plane.
] <thm-perpendicular-axis-theorem>
#proof[

  Consider any 2D body.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e29.svg", width: 16em)
  ]

  Then
  $
    I_z & = integral rho(x^2 + y^2) dif^2 x \
    I_x & = integral rho y^2 dif^2 x \
    I_y & = integral rho x^2 dif^2 x \
  $
  By inspection, we have $I_z = I_x + I_y$.
]

== Parallel Axis Theorem

#theorem[Parallel Axis Theorem][

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e30.svg", width: 22em)
  ]


  Let the #ponder("dynamics.moment-of-inertia")[moment of intertia] through the parallel axis (not through the #ponder("dynamics.centre-of-mass")[center of mass]) be $I$, and the #ponder("dynamics.moment-of-inertia")[moment of inertia] through the #ponder("dynamics.centre-of-mass")[centre of mass] be $I_"CoM"$. We have
  $
    I = I_"CoM" + M h^2
  $
  where $M$ is the total mass of the body, and $h$ is the distance between the two axes.
] <thm-parallel-axis-theorem>

#proof[
  To prove this, we will express all positions relative to the #ponder("dynamics.centre-of-mass")[centre of mass]. Choose an origin on the parallel axis, and let $vb(x_i)$ be the position of particle $i$ relative to this origin. Then
  $
    vb(x_i) = vb(R) + vb(y_i)
  $

  where $vb(R)$ is the position of the #ponder("dynamics.centre-of-mass")[centre of mass], and $vb(y_i)$ is the position of particle $i$ relative to the #ponder("dynamics.centre-of-mass")[centre of mass]. Note
  $
    sum_i m_i vb(y_i) = vb(0).
  $

  #lecture-separator(lecture: 12, date: "2026-02-19")

  We have
  $
    I & = sum_i m_i underbracket((vu(n) times vb(x_i))^2, d_i^2) \
    & = sum_i m_i [vu(n) times [vb(R) + vb(y_i)]]^2 \
    &= sum_i m_i [(vu(n)times vb(R))^2 + 2 (vu(n) times vb(R)) dot (hat(n) times vb(y_i)) + (vu(n)times vb(y_i))^2] \
  $


  Since $sum_i m_i vb(y_i) = vb(0)$, the middle term vanishes, and we have
  $
    I & = M h^2 + I_"CoM", \
  $
  by noting that $h = abs(vu(n) times vb(R))$ and $I_"CoM" = sum_i m_i (vu(n)times vb(y_i))^2$.
]

#remark[
  This theorem implies that $I_"CoM"$ is lower than $I$ about any parallel axis.
]


#example[
  Consider a rotating disc about an axis through its edge.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e31.svg", width: 8em)
  ]

  We have
  $
    I = I_"CoM" + M a^2 = (1)/(2) M a^2 + M a^2 = (3)/(2) M a^2.
  $

]

== Motion of Rigid Bodies

We will now consider the cases where #ponder("dynamics.centre-of-mass")[CoM] moves as the body rotates. We have

$
  vb(x_(i)) = vb(R)(t) + vb(y_(i))
$

where the $vb(y_(i))$ term will capture the rotation about the #ponder("dynamics.centre-of-mass")[CoM] if
$
  vb(dot(y)_i) = vb(omega) times vb(y_(i)).
$

The velocity of the body is
$
  vb(dot(x)) = vb(dot(R)) + vb(dot(y)_i).
$

For the kinetic energy, we have shown in @eq-232 that
$
  T & = (1)/(2) M vb(dot(R))^2 + (1)/(2) sum_i m_i vb(dot(y)_i)^2 \
  & = underbracket((1)/(2) M vb(dot(R))^2, "translational"\ "kinetic"\ "energy") + underbracket((1)/(2) I_"CoM" omega^2, "rotational"\ "kinetic"\ "energy"). \
$

Then the full energy of the body is $E = T+ V$, where we have previously shown that
$
  V = sum_i V_i (vb(x_i)) + underbracket(sum_(i < j) V_(i j) (abs(vb(x_i) - vb(x_j))), "constant for rigid body"\ "so drops out from"\ "Newton's equation").
$

Consider a nice case, where
$
  V_i (x_i) = m_i g z_i,
$
then,
$
  V = sum_i V_i = g sum_i m_i z_i = g M R_z
$
where $R_z$ is the $z$-component of the #ponder("dynamics.centre-of-mass")[centre of mass]. Hence a #ponder("dynamics.rigid-body")[rigid body] is just like a point particle with mass $M$, located at the #ponder("dynamics.centre-of-mass")[centre of mass].

#remark[
  In some cases, it may be easiest to consider axes that do no pass through the #ponder("dynamics.centre-of-mass")[CoM].
]

#example[
  Consider a rigid rod pendulum of mass $M$.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e32.svg", width: 12em)
  ]

  We will carry out calculation in two ways:

  1. the end point (pivot) is fixed, so there is only rotational motion about this point, giving

    $
      T = (1)/(2) I dot(theta)^2
    $

    in which case $omega = dot(theta)$ and $I = (1)/(3) M L^2$.

  2. the #ponder("dynamics.centre-of-mass")[CoM] is moving with $V_"CoM" = (L)/(2) dot(theta)$. Hence

    $
      T = (1)/(2) M V_"CoM"^2 + (1)/(2) I_"CoM" dot(theta)^2.
    $

    To check that the angular velocity about #ponder("dynamics.centre-of-mass")[CoM] is the same as that about the pivot, we have

    #align(center)[
      #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e33.svg", width: 6em)
    ]


    Hence,
    $
      T = (1)/(2) M (L/2)^2 dot(theta)^2 + (1)/(2) [I - M (L/2)^2] dot(theta)^2 = (1)/(2) I dot(theta)^2.
    $

  To understand the motion, consider the energy
  $
    E = (1)/(2) I dot(theta)^2 - M g (L/2) cos theta.
  $

  Imposing $dot(E) = 0$ gives
  $
    (1)/(2) I dot 2 dot(theta) dot.double(theta) + M g (L/2) sin theta dot dot(theta) & = 0 \
                                                                    I dot.double(theta) & = - M g (L/2) sin theta \.
  $

]
#example[Rolling Ball][
  No-slip rolling occurs when the #ponder("dynamics.friction")[friction] between the ball and the ground is so strong that the relative velocity between the point of contact and the ground is zero. Compare:

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e34.svg", width: 22em)
  ]

  The kinetic energy is given by, with $omega = dot(theta)$ and noting that $dot(theta) = (v)/(a)$,
  $
    T & = (1)/(2) M v^2 + (1)/(2) I omega^2 \
      & = (1)/(2) underbracket((M + (I)/(a^2)), "effective mass") v^2 \
  $

  #important[
    Because there is no relative velocity between the point of contact and the ground, no work is done by the #ponder("dynamics.friction")[friction] force, so the #ponder("dynamics.conservation-of-energy")[energy is conserved].

    The only role of rolling is to impose the no-slip condition.
  ]

  In the case where the ball rolls down a slope,

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e35.svg", width: 12em)
  ]

  The #ponder("dynamics.conservation-of-energy")[conserved energy] is
  $
    E = 1/2 (M + (I)/(a^2)) dot(x)^2 - M g x sin alpha.
  $
  By imposing $dot(E) = 0$, we have
  $
    (M + (I)/(a^2)) dot.double(x) = M g sin alpha.
  $

  #lecture-separator(lecture: 13, date: "2026-02-21")

  Now consider a ball rolling on a horizontal surface, where we will demonstrate the #ponder("dynamics.conservation-of-energy")[conservation of energy]. We have
  $
    E = (1)/(2) M dot(x)^2 + (1)/(2) I dot(theta)^2
  $

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e36.svg", width: 12em)
  ]

  Then
  $
    dv(E, t) & = M dot(x) dot.double(x) + I dot(theta) dot.double(theta) \
                    & = dot(x) (-f) + dot(theta) (a f) \
                    & = f (-dot(x) + a dot(theta)) \
                    & = 0 \
  $
  where $f$ is the #ponder("dynamics.friction")[friction] force, and we have used the no-slip condition $dot(x) = a dot(theta)$.
] <ex-rolling-ball>

== Normal Forces

Objects on a table does not fall through the table, because the table exerts a *normal force* on the object that pushes it away. #fade[[Microscopic origin of normal forces is electrostatic repulsion and the Pauli exclusion principle.]]

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e37.svg", width: 18em)
]

At an angle,

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e38.svg", width: 18em)
]


Normal force does not prevent the object from sliding. Sliding is prevented by the dry #ponder("dynamics.friction")[friction] force $f_F$. Once the object starts moving, we typically have
$
  f_F = mu F_N
$
where $mu$ is the #ponder("dynamics.friction")[coefficient of friction].

#remark[
  $f_F$ is independent of speed, but always opposes the direction of motion.
]

Normal forces also product elastic bounces:

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e39.svg", width: 16em)
]

Normal force on impact is in the direction normal to the surface at point of impact.

#definition[Elastic Collision][
  An #ponder("dynamics.elastic-collision")[*elastic collision*] is a collision where #ponder("dynamics.conservation-of-energy")[energy is conserved].
] <def-elastic-collision>

Note that by conservation of total momentum,
$
  p_y = q_y + Q_y #<eq-324>
$
where $Q_y$ is the momentum of the Earth or the wall after the collision.

By conservavtion of energy,
$
  (p_y^2)/(2 m) = (q_y^2)/(2m) + (Q_y^2)/(2 M) #<eq-325>
$ 
where $m$ is the mass of the ball, and $M$ is the mass of the Earth or the wall. Clearly $M >> m$.

Substituting @eq-324 into @eq-325 gives
$
  (1)/(2m) (q_y^2 + 2 q_y Q_y + Q_y^2) & = (q_y^2)/(2m) + (Q_y^2)/(2 M) \
          (1)/(2m) (2 q_y Q_y + Q_y^2) & = (Q_y^2)/(2 M) \
$
If $M >> m$, then $Q_y^2/(2 M) approx 0$, and we have
$
  (Q_y)/(2m) (2 q_y + Q_y) & approx 0 \
                       Q_y & approx -2 q_y \
                       p_y & approx - q_y.
$
Hence we can conclude that
$
  beta = alpha.
$

The change $Delta p$ in momentum over a short time is called an *impulse* $J$.
