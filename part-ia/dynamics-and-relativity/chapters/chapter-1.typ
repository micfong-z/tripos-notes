#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2026-01-22")

= The Structure of the Newtonian Universe

To set up the arena we are going we work in, we require

- a three dimensional *space* that can be endowed with a _Cartesian reference frame_ #fade[[_i.e._ an origin and some axes]], such that points in space are labelled as
  $
    bold(x) = (x_1, x_2, x_3).
  $

- a *time* parameter that can be labelled, in an arbitrary reference frame, by a real number $t$.

- a *point particle* which is an idealised object that is completely determined by its position at a given time as $bold(x)(t)$.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e1.svg", width: 14em)
  ]

  Examples include electron, tennis ball, planet depending on the context.

- the *velocity* which is the vector
  $
    bold(v)(t) = (dif bold(x))/(dif t) = bold(dot(x)).
  $

  From results in IA Vector Calculus, the velocity vector is tangent to the trajectory of the particle.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e2.svg", width: 14em)
  ]

  Recall that in Cartesian coordinates,
  $
    (dif bold(x))/(dif t) = ((dif x_1)/(dif t), (dif x_2)/(dif t), (dif x_3)/(dif t)).
  $
  #fade[[We will discuss other coordinate systems later in the course.]]

- the *acceleration* which is the vector
  $
    bold(a) = bold(dot.double(x)) = bold(dot(v)) = (dif^2 bold(x))/(dif t^2).
  $

The above structure is not enough to write down Newton's equations.

Consider a "free" particle that does not experience any forces. #fade[[_e.g._ the particle is alone in deep space far away from any other matter]] The position of this particle is $bold(x)(t)$, we need to consider which reference frame we are using.


#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e3.svg", width: 36em)
]

The particle may be at rest in a frame $S$, but moving in a complicated way with respect to another frame $S'$.

#law[Law of inertia][
  There exists *#ponder("dynamics.inertial-frame")[inertial frames]*, in which a free particle has a constant velocity.
] <law-inertia>

In an #ponder("dynamics.inertial-frame")[inertial frame], we may write for a free particle,
$
  bold(dot(v)) = bold(dot.double(x)) = bold(0).
$

The #ponder("dynamics.inertial-frame")[law of inertia] is an improved version of Newton's 1st law.

This is a true statement about the world, but not an obvious one. #fade[[In antiquity, it was believe that the natural state of an object is to be at rest, and a force is required to keep it moving.]]

#law[Galilean relativity principle][
  A frame related to an #ponder("dynamics.inertial-frame")[inertial frame] by a #ponder("dynamics.galilean-transformation")[*Galilean transformation*] is also an #ponder("dynamics.inertial-frame")[inertial frame], and all laws of physics are the same in both frames.
] <law-galilean-relativity>

#definition[Galilean transformation][
  A #ponder("dynamics.galilean-transformation")[*Galilean transformation*] between two reference frames $S$ and $S'$ is given by
  $
    bold(x)' = matbold(R) bold(x) + bold(k) + bold(w) t
  $
  where #ponder("algebra.orthogonal-group")[$matbold(R) in O(3)$] is a rotation and/or a reflection, $bold(k) in RR^3$ is a constant translation, and $bold(w) in RR^3$ is a constant velocity, called a boost.
] <def-galilean-transformation>

It is easy to see that $bold(dot.double(x)) = bold(0) <=> bold(dot.double(x')) = bold(0)$ under a #ponder("dynamics.galilean-transformation")[Galilean transformation].

#example[
  Consider a frame relative to a boat moving at constant velocity. A mass dropped from the mast of the boat lands at the same place on this boat as if the boat were not moving.
]

#ponder("dynamics.galilean-relativity-principle")[Galilean invariance] restricts the type of forces that are possible (see Example Sheet 1).

#ponder("dynamics.galilean-relativity-principle")[Galilean relativity] implies that the laws of physics make reference to no special point, direction, time or velocity. All these things can only be defined relatively. #fade[[_e.g._ one cannot be "at rest", but only at rest with respect to something.]]

Acceleration is not relative. If one is accelerating in an #ponder("dynamics.inertial-frame")[inertial frame], then they will be accelerating in all other #ponder("dynamics.inertial-frame")[inertial frames], with the same magnitude.

#remark[
  The #ponder("dynamics.galilean-transformation")[Galilean transformations] form the *Galilean group*, often supplemented with time translations:
  $
    t' = t + t_0.
  $
  Laws of physics are also invariant under time translations, _i.e._ all #ponder("dynamics.inertial-frame")[inertial frames] have the same time, called *absolute time*.
]
