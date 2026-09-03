#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": qty

= Rotating Reference Frames

Rotating reference frames (RRFs) are important examples of non-inertial frames.

== Newton's Equations in a Rotating Reference Frame

// TODO: SOME OF THE x_i IN THIS CHAPTER ARE WRONGFULLY BOLDED.

An #ponder("dynamics.inertial-frame")[inertial frame] $S$ has Cartesian axes $bold(e_1)$, $bold(e_2)$, $bold(e_3)$, and a rotating frame $S'$ has axes $bold(e'_1)$, $bold(e'_2)$, $bold(e'_3)$.

From the perspective of the #ponder("dynamics.inertial-frame")[inertial frame], the $bold(e'_i)$ axes rotates with angular velocity $bold(omega)$.
$
  bold(dot(e)'_i) = bold(omega) times bold(e'_i).
$

In the two frames, the position of a particle is, repsectively,
$
  bold(x) = x_i bold(e_i) = x'_i bold(e'_i).
$
We wish to find $bold(dot.double(e)'_i)$ in terms of $bold(omega)$ and $bold(e'_i)$. We have
$
  bold(dot(x)) = underbracket(dot(x)_i bold(e_i), ((dif bold(x))/(dif t))_S) & = dot(x)'_i bold(e'_i) + x'_i bold(dot(e)'_i) \
  & = dot(x)'_i bold(e'_i) + x'_i bold(omega) times bold(e'_i) \
  & = underbracket(dot(x)'_i bold(e'_i), ((dif bold(x))/(dif t))_S') + bold(omega) times bold(x) #<eq-336>\
  ((dif bold(x))/(dif t))_S &= ((dif bold(x))/(dif t))_S' + bold(omega) times bold(x).
$

where $((dif bold(x))/(dif t))_S$ means the derivatives of components of $bold(x)$ with respect to $t$ in the frame $S$.

The difference between the two time derivatives is just the relative velocity of the two frames.

For #ponder("dynamics.newtons-second-law")[Newton's second law], we need to find the acceleration,
$
  bold(dot.double(x)) & = dot.double(x)_i bold(e_i) \
                      & = dot.double(x)'_i bold(e'_i) + underbracket(
                          dot(x)'_i bold(dot(e)'_i),
                          & = dot(x)'_i bold(omega) times bold(e'_i) \
                          & = bold(omega) times ((dif bold(x))/(dif t))_S'
                        )
                        + bold(dot(omega)) times bold(x) + underbracket(
                          bold(omega) times bold(dot(x)),
                          & =bold(omega)times ((dif bold(x))/(dif t))_S' + bold(omega) times (bold(omega) times bold(x))
                        ) \
$
_i.e._
$
  ((dif^2 bold(x))/(dif t^2))_S = ((dif^2 bold(x))/(dif t^2))_S' + 2 bold(omega) times ((dif bold(x))/(dif t))_S' + bold(dot(omega)) times bold(x) + bold(omega) times (bold(omega) times bold(x)).
$

In the #ponder("dynamics.inertial-frame")[inertial frame], we have
$
  m ((dif^2 bold(x))/(dif t^2))_S = bold(F).
$

Hence,
$
  m ((dif^2 bold(x))/(dif t^2))_S' = bold(F) - underbracket(underbracket(m bold(dot(omega)) times bold(x), "Euler force") - underbracket(2 m bold(omega) times ((dif bold(x))/(dif t))_S', "Coriolis force") - underbracket(m bold(omega) times (bold(omega) times bold(x)), "Centrifugal force"), "Fictitious forces"). #<eq-342>
$


A free particle does not move in a straight line in the rotating frame.

#lecture-separator(lecture: 14, date: "2026-02-24")

Consider the rotating frame of the earth. We have
$
  omega_"rot" = 2ppi / (1 "day") & approx qty("7e-5", "s") \
                       R_"Earth" & approx qty("6e3", "km") \
$

We shall neglect the small wobbling of the Earth, so assume $bold(dot(omega)) = bold(0)$, and hence no Euler force.


== #ponder("dynamics.centrifugal-force")[Centrifugal Force]


We have
$
  bold(F_"cent") = -m bold(omega) times (bold(omega) times bold(x)).
$

It points away from the axis of rotation, as shown in the following diagram.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e40.svg", width: 9em)
]

For the size of the force,
$
  abs(bold(F_"cent")) = m omega^2 r cos theta.
$
The #ponder("dynamics.centrifugal-force")[centrifugal force] is #ponder("dynamics.conservative-force")[conservative], with
$
  bold(F_"cent") & = - bold(nabla) V_"cent" \
        V_"cent" & = - (m)/(2) abs(bold(omega) times bold(x))^2 = -(m)/(2) omega^2 r^2 cos^2 theta.
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
    bold(g) = - m g bold(hat(r)).
  $
  #fade[[The string is short compared to $R_"Earth"$, so it does not matter whether we use $bold(hat(r))$ at the top or the bottom of the string.]]
  $
    bold(F_"cent") & = - m bold(omega) times (bold(omega) times bold(x)) \
                   & = m omega^2 r cos theta (cos theta bold(hat(r)) - sin theta bold(hat(theta))). \
  $
  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e42.svg", width: 7em)
  ]

  To hold the string together, there must be a force exerted by the molecules on the string that balances the other forces, which is the tension.
  $
    bold(T) = T cos phi bold(hat(r)) + T sin phi bold(hat(theta)).
  $

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e43.svg", width: 8em)
  ]

  The net force on the particle is zero, so
  $
    bold(g) + bold(F_"cent") + bold(T) = bold(0).
  $
  We have 2 equations (for $bold(hat(r))$ and $bold(hat(theta))$) and 2 unknowns ($T$ and $phi$), so we can solve for $phi$:
  $
    tan phi & = (omega^2 R cos theta sin theta)/(g - omega^2 R cos^2 theta). \
  $
  At the equator ($theta = 0$), the gravity is a bit weaker, but $phi = 0$.

  When $theta = 45°$, $phi approx 10^(-4)$, so the effect is very small.
] <ex-hanging-string>

== #ponder("dynamics.coriolis-force")[Coriolis Force]

In @eq-342, we have
$
  bold(F_"cor") = - 2 m bold(omega) times bold(v)
$
where $bold(v)$ is the velocity of the particle in the rotating frame.

Note that this is similar to Lorentz force with $bold(B) -> bold(omega)$, so moving particles will turn in circles.

#example[
  #ponder("dynamics.coriolis-force")[Coriolis force] is responsible for the formation of hurricanes.

  When a low pressure region forms, air particles move in, and the #ponder("dynamics.coriolis-force")[Coriolis force] bends them:

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e44.svg", width: 10em)
  ]

  Each molecule of air in bent clockwise in the northern hemisphere #fade[[by the right hand rule with $-bold(omega)$ going into the plane]], which leads to an anticlockwise swirling motion.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e45.svg", width: 6em)
  ]

  In the southern hemisphere, the #ponder("dynamics.coriolis-force")[Coriolis force] bends particles anticlockwise, leading to a clockwise swirling motion.


  Motion along the Earth's surface is not in general perpendicular to the axis of rotation $bold(omega)$. Hence, the effect of #ponder("dynamics.coriolis-force")[Coriolis force] is typically weaker near the equator. There are empirical observations that hurricanes do not form within near the equator.

  #fade[[$bold(omega)times bold(v)$ can be substantial near the equator if $bold(v)$ moves along the equator, but it pushes particles vertically, and it need to compete with gravity, which is much stronger.]]
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
    bold(dot.double(x)) = bold(g) - 2 bold(omega) times bold(dot(x)). #<eq-357>
  $
  #fade[[We can neglect the #ponder("dynamics.centrifugal-force")[centrifugal force] since it does not affect the horizontal motion.]]

  Integrating once gives
  $
    bold(dot(x)) = bold(g) t - 2 bold(omega)times (bold(x) - bold(x_0)) #<eq-358>
  $
  where $bold(x_0)$ is the initial position of the ball. Subsituting @eq-358 into @eq-357 gives
  $
    bold(dot.double(x)) = bold(g) - 2 bold(omega) times bold(g) t + underbracket(4 bold(omega) times (bold(omega) times (bold(x) - bold(x_0))), "same order as centrifugal force").
  $
  The last term acts in the vertical direction and is small, so we can neglect it. Hence, integrating twice gives
  $
    bold(x) = bold(x_0) + (1)/(2) bold(g) t^2 - (1)/(3) bold(omega) times bold(g) t^3. #<eq-360>
  $

  Consider the following right-handed set of #ponder("linear-algebra.basis")[basis]:

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e47.svg", width: 12em)
  ]

  $
    bold(omega) & = omega bold(e_1) \
        bold(g) & = - g bold(e_3). \
      bold(x_0) & = (R + h) bold(e_3).
  $
  Then, substituting back into @eq-360 gives
  $
    bold(x) = vec(0, -(1)/(3) omega g t^3, R + h - (1)/(2) g t^2).
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
      bold(x) & = (x, y, z) \
      bold(g) & = (0, 0, -g) \
  bold(omega) & = (omega cos theta, 0, omega sin theta) \
$

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e50.svg", width: 14em)
]

The tension in the string is
$
  bold(T) = T (-(x)/(ell), -(y)/(ell), (ell - z)/(ell)).
$
Since the string doesn't break, we have
$
  x^2 + y^2 + (ell - z)^2 = ell^2.
$

Now, for the equations of motion,
$
  m bold(dot.double(x)) = bold(T) + m bold(g) - 2 m bold(omega) times bold(dot(x)).
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

