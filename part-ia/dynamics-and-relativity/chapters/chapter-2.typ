#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": qty

= Forces

Once there is more than one particle in the universe, there will be interactions between the particles. In Newtonian physics, these are described by *forces*.

== Newton's Second Law

#law[Newton's 2nd law][
  In an #ponder("dynamics.inertial-frame")[inertial frame],
  $
    bold(dot(p)) = bold(F), #<eq-8>
  $
  where $bold(p)$ is the momentum of the particle and $bold(F)$ is the net force acting on the particle.

  The *momentum* $bold(p)$ is defined to be $bold(p) equiv m bold(dot(x))$, where $m$ is the inertial mass.

  The mass is an additional property of particles. It could change with time, but we generally assume it is constant unless otherwise specified.

  The force $bold(F)$ depends on the interaction, but can only depend on $bold(x)$ and $bold(dot(x))$ at the current time.
] <law-newtons-second-law>

The above implies that

- #ponder("dynamics.newtons-second-law")[Newton's second law] can be written as a second order ODE for $bold(x)(t)$.

- given $bold(x)$ and $bold(dot(x))$ at $t = 0$ for all particles, Newton's equations uniquely determine $bold(x)(t)$ for all future times.

#important[
  Newton mechanics has been superceded by both quantum mechanics (small scale) and relativity (high speed), but remains an excellent approximation much of the universe.
]

#lecture-separator(lecture: 2, date: "2026-01-24")

== Conservative Forces and Gravity

#definition[Conservative Force][
  #ponder("dynamics.conservative-force")[*Conservative *forces] form an important class of forces that can be written as
  $
    bold(F) = - bold(nabla) V(bold(x))
  $
  for some *potential* (also called *potential energy*) $V$.
] <def-conservative-force>

#remark[
  Recall from IA Vector Calculus that $bold(nabla) V = ((∂V)/(∂x), (∂V)/(∂y), (∂V)/(∂z)).$
]

#example[Gravitational Force][
  The gravitational potential energy of a particle of mass $m$ at $bold(x)$ due to a particle of mass $M$ at $bold(x_0)$ is
  $
    V = -(G M m)/(abs(bold(x) - bold(x_0)) )
  $
  where $G approx qty("6.67e-11", "m^3 kg^-1 s^-2")$.

  To take the #ponder("calculus.gradient")[gradient],
  $
    ∂_i (abs(bold(x)- bold(x_0))^2 ) = 2 abs(bold(x) - bold(x_0)) ∂_i abs(bold(x) - bold(x_0))
  $
  and
  $
    ∂_i (abs(bold(x)- bold(x_0))^2 ) & = ∂_i ( (bold(x) - bold(x_0))_j (bold(x) - bold(x_0))_j ) \
                                     & = 2 ( (bold(x) - bold(x_0))_j ∂_i (bold(x) - bold(x_0))_j ) \
                                     & = 2 ( (bold(x) - bold(x_0))_j delta_(i j) ) \
                                     & = 2 ( (bold(x) - bold(x_0))_i ). \
  $
  Hence
  $
    bold(nabla) abs(bold(x) - bold(x_0)) = (bold(x) - bold(x_0)) / abs(bold(x) - bold(x_0)).
  $
  This gives
  $
    bold(F) = - bold(nabla) V = - (G M m)/(abs(bold(x) - bold(x_0))^3) (bold(x) - bold(x_0)).
  $

  If we let $bold(r) = bold(x) - bold(x_0)$, this is the familiar #ponder("dynamics.gravitational-force")[inverse square law]
  $
    bold(F) = - (G M m)/(r^2) hat(bold(r)).
  $
  Sometimes we write $V = m Phi$, where $Phi$ is the gravitational potential
  $
    Phi = - (G M)/(abs(bold(x) - bold(x_0))).
  $

  #separator

  Near the surface of the Earth, take $bold(x_0) = bold(0)$ the centre of the Earth, and $abs(bold(x)) = R + z$, where $R$ is the radius of the Earth and $z << R$ is the height above the surface. Then

  $
    Phi(R+z) & = - (G M)/(R + z) \
             & approx - (G M)/R [1 - (z)/(R) + (z^2)/(R^2) - ...] \
             & approx "constant" + underbracket((G M)/(R^2), g approx qty("9.8", "m s^-2")) z + ...
  $
  Thus, near the surface of the Earth, we approximate the gravitational potential as
  $ Phi(z) approx underbracket("constant", "drops out at gradient") + g z. $ The force is then
  $ bold(F) = - m g hat(bold(z)), $
  which is a constant force near the surface of the Earth.

  This force leads to the simplest example of motion due to a force.

  #separator

  #ponder("dynamics.newtons-second-law")[Newton's 2nd law] gives
  $
    m bold(dot.double(x)) = m bold(g)
  $
  where $bold(g) = (0, 0, -g)$. Consider the $z$-component,
  $
    cancel(m) dot.double(z) = -cancel(m) g
  $
  which gives
  $
    dot(z) & = v_0 - g t \
         z & = z_0 + v_0 t - 1/2 g t^2.
  $
  where $z_0$ and $v_0$ are the initial position and velocity at $t = 0$.
] <ex-gravitational-force>

== Conservation of Energy

#proposition[Conserved Energy of Conservative Forces][
  #ponder("dynamics.conservative-force")[Conservative forces] have a #ponder("dynamics.conservation-of-energy")[*conserved energy*]
  $
    E = (1)/(2) m abs(bold(dot(x)))^2 + V(bold(x)).
  $

] <prop-conserved-energy>

We can check that this is conserved:
$
  (dif E)/(dif t) & = m dot(x)_i dot.double(x)_i + (∂ V)/(∂ x_i) dot(x)_i \
                  & = dot(x)_i (m dot.double(x)_i + (∂ V)/(∂ x_i) ) \
                  & = 0. quad "by Newton" m bold(dot.double(x)) = - bold(nabla) V \
$

#example[
  Suppose we throw an object into space and want it to never fall back down. The minimal velocity this object must have is called the #ponder("dynamics.escape-velocity")[*escape velocity*].

  As the object is thrown,
  $ E = (1)/(2) m v^2 - (G M m)/(r). $

  To not fall back, the object must be able to reach $abs(x) -> oo$ without the velocity going to zero. Hence
  $
    (1)/(2) m v^2 - (G M m)/(R) & = E_"initial" \
                                & = E_oo \
                                & = (1)/(2) m v_0^2 - 0 > 0. \
  $
  Therefore we require
  $
    v^2 > (2 G M)/(R).
  $
  Hence the #ponder("dynamics.escape-velocity")[escape velocity] is
  $
    v_"escape" = sqrt((2 G M)/(R)) approx qty("10", "km/s") "for the Earth".
  $

  The mass $m$ is cancelled out, since the gravitational mass (that appears in the #ponder("dynamics.gravitational-force")[inverse square law]) is the same as the inertial mass (that appears in #ponder("dynamics.newtons-second-law")[Newton's 2nd law]).
] <ex-escape-velocity>

It is useful to write $E = T + V$, where $T = (1)/(2) m abs(bold(dot(x)))^2$ is the *kinetic energy* and $V$ is the *potential energy*.

#proposition[
  #ponder("dynamics.conservative-force")[Conservative forces] have the property that the work done by the force as a particle moves along a trajectory $C$, where the work done is defined as
  $
    W = integral_C bold(F) dot dif bold(x),
  $
  only depends on the endpoints of the trajectory, not on the path itself.
] <prop-work-endpoints>

#proof[
  Let the trajectory $C$ go from $bold(x)_1$ at $t_1$ to $bold(x)_2$ at $t_2$. Then
  $
    W & = integral_C bold(F) dot dif bold(x) \
      & = integral_(t_1)^(t_2) underbracket(bold(F) dot (dif x)/(dif t), "power") dif t \
      & = m integral_(t_1)^(t_2) bold(dot.double(x)) dot bold(dot(x))dif t quad         &       ("Newton's 2nd law") \
      & = (1)/(2) m integral_(t_1)^(t_2) (dif)/(dif t) (abs(bold(dot(x)))^2) dif t \
      & = T(t_2) - T(t_1) \
      & = V(t_1) - V(t_2) quad                                                          & ("Conservation of energy") \
      & = V(bold(x)(t_1)) - V(bold(x)(t_2)) \
      & = V(bold(x)_1) - V(bold(x)_2). \
  $
]

#lecture-separator(lecture: 3, date: "2026-01-27")

#prooflike[Proof (Direct)][
  Using results from IA Vector Calculus, we have
  $
    W & = integral_C bold(F) dif bold(x) \
      & = - integral_C bold(nabla) V dif bold(x) \
      & = - integral_(bold(x)_1)^(bold(x)_2) d V \
      & = V(bold(x)_1) - V(bold(x)_2). \
  $
]

== Electromagnetic Forces

Forces that depend on the velocity typically don't have a #ponder("dynamics.conservation-of-energy")[conserved energy], such as #ponder("dynamics.friction")[friction]. However, the *Lorentz force* is an exception.

Electromagnetic fields $bold(E)$ and $bold(B)$ exert the following force on a particle with charge $q$

$
  bold(F) = q [bold(E)(bold(x)) + bold(dot(x)) times bold(B)(bold(x)) ].
$

In this section, we shall restrict to static electromagnetic fields, i.e., $bold(E)$ and $bold(B)$ do not depend on time. Then
$
  bold(E) = - bold(nabla) Phi,
$
where $Phi(bold(x))$ is the electric potential.

We claim that the #ponder("dynamics.conservation-of-energy")[conserved energy] is
$
  E = (1)/(2) m abs(bold(dot(x)))^2 + q Phi(bold(x)).
$

To check this,
$
  (dif bold(E))/(dif t) & = m bold(dot.double(x)) dot bold(dot(x)) + q bold(nabla) Phi dot bold(dot(x)) \
                        & = (bold(F) + q bold(nabla) Phi) dot bold(dot(x)) \
                        & = q (bold(dot(x)) times bold(B)) dot bold(dot(x)) quad                        & ("by Lorentz") \
                        & = 0. \
$

The velocity-dependent force is #ponder("linear-algebra.orthogonality")[orthogonal] to the trajectory of the particle, so it does no work.

Electric forces are similar to gravitational ones. The potential $Phi$ at $bold(x)$ due to another particle of charge $Q$ at $bold(x_0)$ is
$
  Phi = (Q)/(4 ppi epsilon_0 ) (1)/(abs(bold(x) - bold(x_0))),
$
where $epsilon_0$ is the permittivity of free space, approximately $qty("8.85e-12", "m^-3 kg^-1 s^2 C^2")$.

Like gravity, this leads to an inverse square law for the electric force, called *Coulomb's law*. However, charges can be positive or negative, but mass is always positive. Hence, gravity dominates for large objects while electric foces tend to cancel out overall.

For magnetic forces, a charged particle in a magnetic field $bold(B)$ obeys

$
  m bold(dot.double(x)) = q bold(dot(x)) times bold(B).
$

This is a vector differential equation. The most direct way to solve it is to write out components.

Suppose $bold(B)$ is constant and WLOG along the $z$-axis, i.e., $bold(B) = (0, 0, B) = B bold(hat(z))$. The equations become
$
  cases(
    "(1)"quad & m dot.double(x) = q B dot(y),
    "(2)" & m dot.double(y) = - q B dot(x),
    "(3)" & m dot.double(z) = 0 & => z = z_0 +v_z t.
  )
$

#prooflike[Solution 1][
  Using $(dif )/(dif t) "(1)"$ and $"(2)"$,
  $
    m dot.triple(x) = q B dot.double(y) = - (q^2 dot(x) B^2)/m
  $

  which is a 2nd order equation for $bold(dot(x))$. This gives
  $
    dot(x) = tilde(A) sin(omega t + phi)
  $
  where
  $
    omega = (q B)/(m)
  $
  which is called the *cyclotron frequency*.

  This gives
  $
    x = x_0 + A cos(omega t + phi).
  $

  Substituting back into $"(1)"$ gives
  $
    q B dot(y) & = - m A omega^2 cos(omega t + phi) \
             y & = y_0 - A sin(omega t + phi)
  $
  where $A$ and $phi$ are arbitrary.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e4.svg", width: 11em)
  ]

  The period $T$ is the time to complete one cycle,
  $
    T = (2 ppi)/(omega).
  $
]

#prooflike[Solution 2][
  Alternatively, let $xi = x + ii y$. Then we can write $"(1)" + ii "(2)"$ as
  $
    m dot.double(xi) = - ii q B dot(xi).
  $
  Solving gives
  $
    xi = C_1 ee^(- ii omega t) + C_2
  $
  where $C_1$ and $C_2$ are complex constants.

  Set $C_1 = A ee^(- ii phi)$ and $C_2 = x_0 + ii y_0$. Then taking real and imaginary parts recovers
  $
    cases(
      x & = x_0 + A cos(omega t + phi),
      y & = y_0 + A sin(omega t + phi).
    )
  $

  #remark[
    There is something "complex" underlying cyclotron motion, _c.f._ quantum hall effect.
  ]

]

== Motion in One Dimension

Problems can often be reduced to one-dimensional motion, such as
$
  m dot.double(x) = F_x.
$
If $F_x$ is independent of velocity, then it can always be written in terms of a potential, by setting
$
  V(x) = -integral_(x_0)^(x) dif x' F_x (x')
$
where $x_0$ is an arbitrary reference point. This gives
$
  F_x (x) = - (dif V)/(dif x).
$

The following energy is then conserved:
$
  E = (1)/(2) m dot(x)^2 + V(x).
$
Keeping $E$ constant gives a 1st order ODE for $x(t)$, which is easy to integrate:
$
  dot(x) & = plus.minus sqrt((2)/(m) (E-V(x))) \
   t-t_0 & = plus.minus integral_(x_0)^(x) (dif x')/(sqrt((2)/(m) (E-V(x')))).
$
This equation tells us how long it takes to move from $x_0$ to $x$, if it has energy $E$.

More often than not the integral is not analytically solvable, but it is still useful for qualitative analysis of motion.

#lecture-separator(lecture: 4, date: "2026-01-29")

From $E = (1)/(2) m dot(x)^2 + V(x)$, we get $E > V(x)$. This restricts the range of $x$ where the particle can be.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e6.svg", width: 32em)
]

The points where $E = V(x) => dot(x) = 0$ are called turning points. Typically, particles bounces off the potential at turning points and turn around.

- Within region $A$, the particle bounces back and forth between turning points (bounded motion).

- Within region $B$, the particle bounces off the turning point and escapes to $x->-oo$ (unbounded motion).

- A special case occurs when $E = V(x)$ and $V'(x) = 0$. These are #ponder("ode.equilibrium-point")[equilibrium points], where the particle can remain at rest if placed there.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e7.svg", width: 12em)
  ]

  We have $m dot.double(x) = -V'(x) = 0$ and $E = (1)/(2) m dot(x)^2 + V(x)$, giving $dot(x) = dot.double(x) = 0$.

We shall show that motion close to #ponder("ode.equilibrium-point")[equilibrium points] are especially simple.

Let $x_0$ be the #ponder("ode.equilibrium-point")[equilibrium point], the #ponder("calculus.taylor-series")[Taylor expansion] about $x_0$ gives
$
  V(x) & approx V(x_0) + (x-x_0) V'(x) + (1)/(2) (x-x_0)^2 V''(x_0) + ... \
       & approx V(x_0) + (1)/(2) (x-x_0)^2 V''(x_0) quad                  & "since" V'(x_0) = 0. \
$

- If $V''(x_0) > 0$, this is the potential for a simple harmonic oscillator,
  $
    m dot.double(x) = -V'(x) approx -(x-x_0) V''(x_0).
  $
  Solving this gives
  $
    x = x_0 + A cos(omega t + phi)
  $
  where $A$ is the amplitude and $phi$ is the phase. The angular frequency is
  $
    omega = sqrt((V''(x_0))/(m)) .
  $

  If $A$ is small enough, we can neglect higher order terms in the #ponder("calculus.taylor-series")[Taylor expansion], and the oscillating solution is valid. The point $x_0$ is called a #ponder("ode.equilibrium-stability")[*stable equilibrium*].

- If $V''(x_0) < 0$, then we get an #ponder("ode.equilibrium-stability")[*unstable equilibrium*] point. The solution is
  $
    x = x_0 = tilde(A) ee^(gamma t) + tilde(B) ee^(-gamma t)
  $
  where
  $
    gamma = sqrt((-V''(x_0))/(m)) .
  $

  If $tilde(A) != 0$, the exponential growth means the particle moves far away from the #ponder("ode.equilibrium-point")[equilibrium point], so the approximation breaks down.

  The case $tilde(A) = 0$ corresponds to rolling the particle up the potential with just enough energy to reach the top as $t->oo$.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e8.svg", width: 11em)
  ]

  If $V''(x_0) = 0$, we need to include higher order terms in the #ponder("calculus.taylor-series")[Taylor expansion].

== Dimensional Analysis

#ponder("dynamics.dimensional-analysis")[Dimensional analysis] is a way to obtain information about solutions to equations without solving them. At a mathematical level, #ponder("dynamics.dimensional-analysis")[dimensional analysis] is the ability to rescale variables to remove certain constants from equations.

#example[
  We will derive this equation for a pendulum later:
  $
    (dif^(2) theta)/(dif t^(2)) = - (g)/(l) sin theta.
  $

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e9.svg", width: 4em)
  ]

  Suppose we release the pendulum from rest at some angle $theta_0$. We want to find the period $T$ of oscillation where
  $
    theta(t+T) = theta(t).
  $
  We can remove $g, l$ from the equation by rescaling
  $
    t = sqrt((l)/(g)) tau.
  $
  We are effectively writing $theta(t(tau)) = F(tau)$ and by chain rule,
  $
    (dif^2 F)/(dif tau^2) = -sin F.
  $
  This equation does not depend on $g, l$, and so the solution is some function $F(tau)$. Therefore, the period $Delta tau$ of $F(tau)$ may depend on the initial angle $theta_0$ but can't depend on $g, l$. Hence,
  $
    F(tau + Delta tau) = F(tau)
  $
  giving
  $
    theta(t) & = F(sqrt((g)/(l)) t ) = F(sqrt((g)/(l)) t + Delta tau) ) \
             & = F(sqrt((g)/(l)) (t + sqrt((l)/(g)) Delta tau ) ) \
             & = theta(t + sqrt((l)/(g)) Delta tau). \
  $
  Hence,
  $
    T = sqrt((l)/(g)) Delta tau.
  $
  Therefore, without solving the equation, we have found that the period of a pendulum is proportional to $sqrt(l)$.
] <ex-pendulum-rescaling>

However, in general, a necessary rescaling may not be obvious. Thus, associating dimensions to all constants and variables is a form of bookkeeping that accounts for how these quantities appear in Newton's equations.

The basic dimensions are

- length $L$,
- time $T$,
- mass $M$.

Then we have
$
         [dot(x)] & = L T^(-1) \
  [dot.double(x)] & = L T^(-2) \
              [F] & = M L T^(-2) \
              [E] & = M L^2 T^(-2), "etc."
$
There can be other dimensions (such as charge), depending on the problem.

The fundamental principles of #ponder("dynamics.dimensional-analysis")[dimensional analysis] are

- $["LHS"]=["RHS"]$,

- all arguments of nontrivial functions (_i.e._ involving sums of different powers) must be dimensionless.

#example[Pendulum, Revisited][
  We first list all the dimensions of the relevant quantities:
  $
          [g] & = L T^(-2) \
          [l] & = L \
          [m] & = M \
    [theta_0] & = 1 quad ("dimensionless") \
          [T] & = T. \
  $
  Then we let
  $
    T = f(theta_0) g^A l^B m^C\
    T = L^(A) T^(-2A) L^B M^C\
  $
  This gives
  $
    C = 0, A = (1)/(2), B = (1)/(2).
  $
  Therefore, the period is
  $
    T = f(theta_0) sqrt((l)/(g)) .
  $

  #remark[
    If $A, B, C$ are not all fixed, we have a dimensionless ratio.
  ]
] <ex-pendulum-dimensions>

#lecture-separator(lecture: 5, date: "2026-01-31")

== Friction

When objects move through a medium (_e.g._ air or water), microscopic forces between the object and the medium cause momentum to be carried off into the medium and lost.

#definition[Friction][
  #ponder("dynamics.friction")[*Friction*] is a macroscopic force that keeps track of the momentum lost due to the complicated microsopic effects.
] <def-friction>

There are two important properties:

1. #ponder("dynamics.friction")[Friction] does not conserve energy, since momentum is lost to the medium, in the form of heat.

2. #ponder("dynamics.friction")[Friction] is irreversible. Energy is lost by the object, and energy is lost by the object but not regained. #fade[[If one every doubts about the sign of a #ponder("dynamics.friction")[friction] force, it should slow the object down.]] Moreover, #ponder("dynamics.friction")[friction] forces must change signs under $bold(v) -> -bold(v)$, hence #ponder("dynamics.friction")[friction] forces must depend on velocity.

There are two common cases of #ponder("dynamics.friction")[friction] forces:

1. *Linear drag.* $bold(F) = -k_1 bold(v)$.

  Linear drag depends on viscous effects #fade[[see IB Fluid Dynamics]], such as a spoon in honey. In this case, objects move the medium with them.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e10.svg", width: 24em)
  ]

  #example[
    Stokes' law for a spherical object of radius $L$ stats that
    $
      k_1 = 6 ppi eta L,
    $
    where $eta$ is the viscosity of the medium.
  ] <ex-stokes-law>


2. *Quadratic drag.* $bold(F) = -k_2 |bold(v)| bold(v)$.

  Quadratic drag is the more intuitive case.

  As an object bumps into molecules, the rate of collisions is proportional to the speed $|bold(v)|$, and each collision imparts a momentum change proportional to $|bold(v)|$. Hence the force is proportional to $|bold(v)|^2$.

  The number of collisions depends on the density of the medium $rho$ and the cross-sectional area $A$ of the object, so $k_2 prop rho A$. We can also see this by #ponder("dynamics.dimensional-analysis")[dimensional analysis]:

  $
          [F] & = M L T^2 \
    [k_2 v^2] & = [k_2] (L T^(-1))^2 = [k_2] L^2 T^(-2) \
        [k_2] & = M L^(-1) = [rho A]. \
  $


$k_1$ and $k_2$ are called coefficients of friction. Both linear and quadratic drag are typically present. For a spherical object, which term dominates depends on the Reynolds number $R$ #fade[[see IB Fluid Dynamics]], where

$
  F_"quad"/F_"lin" approx (rho A v^2)/(eta L v) = (rho v L)/(eta) equiv R.
$

=== Terminal Velocity

Consider a particle falling with quadratic #ponder("dynamics.friction")[friction] under gravity. Consider the $z$-component of the motion. We have
$
  m (dif v)/(dif t)= - m g + k v^2.
$

The velocity starts at $0$, then increases. Initially, $"RHS"$ is dominated by $-m g$. Eventually, the two forces balance, giving a *terminal velocity*.

$
  v_"term" = -sqrt((m g)/(k))
$
so heavier objects have higher terminal velocities.

We can also consider the timescale when the object reaches its terminal velocity. With #ponder("dynamics.dimensional-analysis")[dimensional analysis], we write
$
  t & prop m^A g^B k^C \
  T & = M^A (L T^(-2))^B (M L^(-1))^C \
$
So we have
$
  A = -C, quad B = -(1)/(2), quad B = C quad => quad C = -(1)/(2), A = -(1)/(2).
$
Therefore,
$
  t & prop sqrt((m)/(k g)) .
$

Note that, solving the equations gives the following graph.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e11.svg", width: 20em)
]

We can also have motion in different directions to gravity, so that
$
  m bold(dot(v)) = m bold(g) - k abs(bold(v)) bold(v).
$

=== Damping

#ponder("dynamics.friction")[Friction] damps small oscillations about an #ponder("ode.equilibrium-point")[equilibrium point]. For small oscillations, the linear drag dominates. Thus, in a 1D system:
$
  dot.double(x) = -omega_0^2 x -2 alpha dot(x)
$
where $omega_0$ is the natural frequency of oscillations without #ponder("dynamics.friction")[friction], and $alpha$ is the damping coefficient.
Solving this gives
$
  x = ee^(-alpha t) [A_+ ee^(ii Omega t) + A_- ee^(-ii Omega t)]
$
where $Omega = sqrt(omega_0^2 - alpha^2)$ and taking the real part gives the damped oscillations.

The three cases are

- $omega_0^2 > alpha^2$, underdamped, decaying oscillations.

- $omega_0^2 < alpha^2$, overdamped, exponential decay.

- $omega_0^2 = alpha^2$, critical damping: $x = (A + B t) ee^(-alpha t)$.

#remark[
  Note that $x, dot.double(x)$ are invarant under time reversal $t -> -t$, but $dot(x) -> - dot(x)$. As far as we know, the fundamental laws of nature are invariant under CPT. #ponder("dynamics.friction")[Friction] forces are always off under T and cannot be fundamental forces.
]