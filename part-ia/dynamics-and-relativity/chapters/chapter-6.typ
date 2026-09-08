#import "../prelude.typ": *

= Rotating Reference Frames

Rotating reference frames (RRFs) are important examples of non-inertial frames.

== Newton's Equations in a Rotating Reference Frame

// TODO: SOME OF THE x_i IN THIS CHAPTER ARE WRONGFULLY BOLDED.

An #ponder("dynamics.inertial-frame")[inertial frame] $S$ has Cartesian axes $vb(e_1)$, $vb(e_2)$, $vb(e_3)$, and a rotating frame $S'$ has axes $vb(e'_1)$, $vb(e'_2)$, $vb(e'_3)$.

From the perspective of the #ponder("dynamics.inertial-frame")[inertial frame], the $vb(e'_i)$ axes rotates with angular velocity $vb(omega)$.
$
  vb(dot(e)'_i) = vb(omega) times vb(e'_i).
$

In the two frames, the position of a particle is, repsectively,
$
  vb(x) = x_i vb(e_i) = x'_i vb(e'_i).
$
We wish to find $vb(dot.double(e)'_i)$ in terms of $vb(omega)$ and $vb(e'_i)$. We have
$
  vb(dot(x)) = underbracket(dot(x)_i vb(e_i), (dv(vb(x), t))_S) & = dot(x)'_i vb(e'_i) + x'_i vb(dot(e)'_i) \
  & = dot(x)'_i vb(e'_i) + x'_i vb(omega) times vb(e'_i) \
  & = underbracket(dot(x)'_i vb(e'_i), (dv(vb(x), t))_S') + vb(omega) times vb(x) #<eq-336>\
  (dv(vb(x), t))_S &= (dv(vb(x), t))_S' + vb(omega) times vb(x).
$

where $(dv(vb(x), t))_S$ means the derivatives of components of $vb(x)$ with respect to $t$ in the frame $S$.

The difference between the two time derivatives is just the relative velocity of the two frames.

For #ponder("dynamics.newtons-second-law")[Newton's second law], we need to find the acceleration,
$
  vb(dot.double(x)) & = dot.double(x)_i vb(e_i) \
                      & = dot.double(x)'_i vb(e'_i) + underbracket(
                          dot(x)'_i vb(dot(e)'_i),
                          & = dot(x)'_i vb(omega) times vb(e'_i) \
                          & = vb(omega) times (dv(vb(x), t))_S'
                        )
                        + vb(dot(omega)) times vb(x) + underbracket(
                          vb(omega) times vb(dot(x)),
                          & =vb(omega)times (dv(vb(x), t))_S' + vb(omega) times (vb(omega) times vb(x))
                        ) \
$
_i.e._
$
  (dv(vb(x), t, 2))_S = (dv(vb(x), t, 2))_S' + 2 vb(omega) times (dv(vb(x), t))_S' + vb(dot(omega)) times vb(x) + vb(omega) times (vb(omega) times vb(x)).
$

In the #ponder("dynamics.inertial-frame")[inertial frame], we have
$
  m (dv(vb(x), t, 2))_S = vb(F).
$

Hence,
$
  m (dv(vb(x), t, 2))_S' = vb(F) - underbracket(underbracket(m vb(dot(omega)) times vb(x), "Euler force") + underbracket(2 m vb(omega) times (dv(vb(x), t))_S', "Coriolis force") + underbracket(m vb(omega) times (vb(omega) times vb(x)), "Centrifugal force"), "Fictitious forces"). #<eq-342>
$


A free particle does not move in a straight line in the rotating frame.

#lecture-separator(lecture: 14, date: "2026-02-24")

Consider the rotating frame of the earth. We have
$
  omega_"rot" = 2ppi / (1 "day") & approx qty("7e-5", "s^-1") \
                       R_"Earth" & approx qty("6e3", "km") \
$

We shall neglect the small wobbling of the Earth, so assume $vb(dot(omega)) = vb(0)$, and hence no Euler force.


== #ponder("dynamics.centrifugal-force")[Centrifugal Force]


We have
$
  vb(F)_"cent" = -m vb(omega) times (vb(omega) times vb(x)).
$

It points away from the axis of rotation, as shown in the following diagram.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e40.svg", width: 9em)
]

For the size of the force,
$
  abs(vb(F)_"cent") = m omega^2 r cos theta.
$
The #ponder("dynamics.centrifugal-force")[centrifugal force] is #ponder("dynamics.conservative-force")[conservative], with
$
  vb(F)_"cent" & = - grad V_"cent" \
        V_"cent" & = - (m)/(2) abs(vb(omega) times vb(x))^2 = -(m)/(2) omega^2 r^2 cos^2 theta.
$
Hence, potential energy is lowered by moving away from the axis of rotation.

#example[Hanging String][
  Consider a hanging string on the Earth.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e41.svg", width: 12em)
  ]

  Rather than hanging vertically downwards, the pendulum hangs at an angle $phi$ to the vertical. We wish to find $phi$.

  The forces acting on the particle satisfy
  $
    m vb(g) = - m g vu(r).
  $
  #fade[[The string is short compared to $R_"Earth"$, so it does not matter whether we use $vu(r)$ at the top or the bottom of the string.]]
  $
    vb(F)_"cent" & = - m vb(omega) times (vb(omega) times vb(x)) \
                   & = m omega^2 r cos theta (cos theta vu(r) - sin theta vu(theta)). \
  $
  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e42.svg", width: 7em)
  ]

  To hold the string together, there must be a force exerted by the molecules on the string that balances the other forces, which is the tension.
  $
    vb(T) = T cos phi vu(r) + T sin phi vu(theta).
  $

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e43.svg", width: 8em)
  ]

  The net force on the particle is zero, so
  $
    m vb(g) + vb(F)_"cent" + vb(T) = vb(0).
  $
  We have 2 equations (for $vu(r)$ and $vu(theta)$) and 2 unknowns ($T$ and $phi$), so we can solve for $phi$:
  $
    tan phi & = (omega^2 R cos theta sin theta)/(g - omega^2 R cos^2 theta). \
  $
  At the equator ($theta = 0$), the gravity is a bit weaker, but $phi = 0$.

  When $theta = 45°$, $phi approx 1.7 times 10^(-3)$, so the effect is very small.
] <ex-hanging-string>

== #ponder("dynamics.coriolis-force")[Coriolis Force]

In @eq-342, we have
$
  vb(F)_"cor" = - 2 m vb(omega) times vb(v)
$
where $vb(v)$ is the velocity of the particle in the rotating frame.

Note that this is similar to Lorentz force with $vb(B) -> vb(omega)$, so moving particles will turn in circles.

#example[
  #ponder("dynamics.coriolis-force")[Coriolis force] is responsible for the formation of hurricanes.

  When a low pressure region forms, air particles move in, and the #ponder("dynamics.coriolis-force")[Coriolis force] bends them:

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e44.svg", width: 10em)
  ]

  Each molecule of air in bent clockwise in the northern hemisphere #fade[[by the right hand rule with $-vb(omega)$ going into the plane]], which leads to an anticlockwise swirling motion.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e45.svg", width: 6em)
  ]

  In the southern hemisphere, the #ponder("dynamics.coriolis-force")[Coriolis force] bends particles anticlockwise, leading to a clockwise swirling motion.


  Motion along the Earth's surface is not in general perpendicular to the axis of rotation $vb(omega)$. Hence, the effect of #ponder("dynamics.coriolis-force")[Coriolis force] is typically weaker near the equator. There are empirical observations that hurricanes do not form within near the equator.

  #fade[[$vb(omega)times vb(v)$ can be substantial near the equator if $vb(v)$ moves along the equator, but it pushes particles vertically, and it need to compete with gravity, which is much stronger.]]
] <ex-coriolis-hurricanes>

#example[
  Consider dropping a ball from a tower on the euqator. We will consider where the ball lands.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e46.svg", width: 12em)
  ]

  Initially,
  $
    ell = omega(R + h)^2.
  $
  As the ball falls, the distance to the axis decreases, so the angular velocity must increase to conserve angular momentum.

  At the foot of the tower, $ell = omega' R^2$, which must give $omega' > omega$, and hence the ball rotates faster than the Earth, so it lands slightly east of the foot of the tower.

  In the rotating frame,
  $
    vb(dot.double(x)) = vb(g) - 2 vb(omega) times vb(dot(x)). #<eq-357>
  $
  #fade[[We can neglect the #ponder("dynamics.centrifugal-force")[centrifugal force] since it does not affect the horizontal motion.]]

  Integrating once gives
  $
    vb(dot(x)) = vb(g) t - 2 vb(omega)times (vb(x) - vb(x_0)) #<eq-358>
  $
  where $vb(x_0)$ is the initial position of the ball. Subsituting @eq-358 into @eq-357 gives
  $
    vb(dot.double(x)) = vb(g) - 2 vb(omega) times vb(g) t + underbracket(4 vb(omega) times (vb(omega) times (vb(x) - vb(x_0))), "same order as centrifugal force").
  $
  The last term acts in the vertical direction and is small, so we can neglect it. Hence, integrating twice gives
  $
    vb(x) = vb(x_0) + (1)/(2) vb(g) t^2 - (1)/(3) vb(omega) times vb(g) t^3. #<eq-360>
  $

  Consider the following right-handed set of #ponder("linear-algebra.basis")[basis]:

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e47.svg", width: 12em)
  ]

  $
    vb(omega) & = omega vb(e_1) \
        vb(g) & = - g vb(e_3). \
      vb(x_0) & = (R + h) vb(e_3).
  $
  Then, substituting back into @eq-360 gives
  $
    vb(x) = vec(0, -(1)/(3) omega g t^3, R + h - (1)/(2) g t^2).
  $
  Clearly, $x_2$ is negative at positive $t$, so the ball lands slightly east of the foot of the tower.
] <ex-falling-ball-tower>

#lecture-separator(lecture: 15, date: "2026-02-26")

== Foucault's Pendulum

Foucault's pendulum demonstrates the rotation of the Earth.

As the Earth rotates under the pendulum, from the point of view of someone on the Earth, it will look like the pendulum rotates.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e48.svg", width: 8em)
]

At a general latitude,

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e49.svg", width: 18em)
]

In the #ponder("linear-algebra.basis")[basis] on the Earth's surface, we have
$
      vb(x) & = vecrow(x, y, z) \
      vb(g) & = vecrow(0, 0, -g) \
  vb(omega) & = vecrow(omega cos theta, 0, omega sin theta) \
$

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e50.svg", width: 14em)
]

The tension in the string is
$
  vb(T) = T (-(x)/(ell), -(y)/(ell), (ell - z)/(ell)).
$
Since the string doesn't break, we have
$
  x^2 + y^2 + (ell - z)^2 = ell^2.
$

Now, for the equations of motion,
$
  m vb(dot.double(x)) = vb(T) + m vb(g) - 2 m vb(omega) times vb(dot(x)).
$

Note that we have all the quantities defined, with 4 equations (3 #ponder("ode.ordinary-differential-equation")[ODEs] and 1 constraint) and 4 unknowns ($x$, $y$, $z$, and $T$), so we can solve for the motion of the pendulum. Our strategy is as follows

- Solve constraint for $z$ in terms of $x$ and $y$,

- Substitute into the #ponder("ode.ordinary-differential-equation")[ODEs],

- Eliminate $T$ to get 2 #ponder("ode.ordinary-differential-equation")[ODEs] for $x$ and $y$,

- Solve the #ponder("ode.ordinary-differential-equation")[ODEs].

The exact solution is tedious, but the upshot is that the pendulum follows an ellipse in the $x, y$ plane that slowly rotates, _i.e._

$
  x + ii y = ee^(- ii omega t sin theta) [alpha cos (sqrt(g/ell) t) + phi sin (sqrt(g/ell) t)].
$

The period of rotation is
$
  (24)/(sin theta) "hours" approx 32 "hours in Paris".
$

