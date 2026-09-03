#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": qty

= Special Relativity

== Basic Postulates of Relativity

Maxwell's equations (1862) predicted the existence of electromagnetic waves. These travel in the vaccum at the speed of light,
$
  c = qty("299792458", "m/s").
$
The quantity is exact due to the definition of the metre.

However, a theory with a preferred velocity cannot be #ponder("dynamics.galilean-relativity-principle")[Galilean invariant], since Galilean theories can only have relative velocities. #fade[[This could be fine, such as the case of the sound in air which travels at a definitive speed, but this is relative to the air, which is at rest. In the case of light, there is no medium, so there is no reference frame in which the light is at rest.]] It was assumed that light must also be travelling in some fixed medium, called the luminiferous æther.

Michelson and Morley (1881) performed an experiment that effectively showed that if one run towards a wave of light, the speed of the light does not change. This was a strong indication that there is no such thing as the æther, and that the speed of light is invariant in all #ponder("dynamics.inertial-frame")[inertial frames].

Einstein (1905) postulated that there was no æther, and

1. The laws of physics are the same in all #ponder("dynamics.inertial-frame")[inertial frames]. #fade[[This is #ponder("dynamics.galilean-relativity-principle")[Galileo's principle of relativity].]]

2. The speed of light in vacuum is the same in all #ponder("dynamics.inertial-frame")[inertial frames].

== Lorentz Transformations

From the postulates, we must change the rules for transforming between frames.

We shall start with one spatial dimension $x$.

A frame $S$ has coordinates $(x, t)$. A frame $S'$ has coordinates $(x', t')$, and moves at a constant speed $v$ relative to $S$.

According to Galileo,
$
  x' = x - v t, quad t' = t.
$

Instead, let's allow for a general transformation,
$
  x' = f(x, t), quad t' = g(x, t).
$


By postulate (1), #ponder("dynamics.inertial-frame")[law of inertia] is still true, so a particle experiencing no forces moves at a constant velocity in all frames. _i.e._ for such a particle,
$
   x & = A + B t quad    &  "in" S \
  x' & = A' + B' t' quad & "in" S'
$

We shall choose our frames to have a common origin _i.e._ $x=t=0 <=> x' = t' = 0$. #fade[[We can always shift $x$ and $x'$ to achieve this.]]

Hence, the transformation must map all lines in the $(x, t)$ plane to lines in the $(x', t')$ plane. These are precisely #ponder("linear-algebra.linear-map")[linear transformations]. Hence, we can write
$
  x' = a x + b t, quad t' = c x + d t.
$
Note that $a, b, c, d$ does not depend on $x$ or $t$, but can depend on $v$.

#lecture-separator(lecture: 16, date: "2026-02-28")


Consider the frame $S'$ to be moving at speed $v$ relative to $S$ in $S$. Then, the point $x = v t$ should map to $x'=0$. Hence,
$
  x' = gamma_v (x - v t).
$

We will follow a few steps to determine more results about the transformation.

#remarklike[Step 1][
  $gamma_v = gamma_(-v)$.
]
Consider $tilde(S)$ and $tilde(S')$ where the $x$-axis is inverted in direction, _i.e._
$
  tilde(x) = -x, quad tilde(x') = -x'.
$

Since $S'$ moves at speed $v$ relative to $S$, $tilde(S')$ moves at speed $-v$ relative to $tilde(S)$. Hence, the transformation from $tilde(S)$ to $tilde(S')$ is given by
$
  tilde(x') & = gamma_(-v) (tilde(x) + v t) = -gamma_(-v) (x - v t) \
         x' & = -tilde(x') = gamma_(-v) (x - v t).
$
and so $gamma_v = gamma_(-v)$.

Another argument for $gamma_v = gamma_(-v)$ is that in 3D there is no preferred direction, so $gamma_v$ can only depend on $abs(bold(v))$.

#remarklike[Step 2][
  We can assume that if we boost by $v$ and then by $-v$, we should get back to the original frame, _i.e._
  $
    S attach(->, b: v) S' attach(->, b: -v) S'' = S.
  $
  _i.e._ the boost by $-v$ is the inverse transformation of the boost by $v$.
]

We have
$
  x'' & = gamma_(-v) (x' + v t') \
      & = gamma_(-v) (gamma_v (x - v t) + t') \
      & = gamma^2 (x - v t) + gamma t'        & quad "by" gamma_v = gamma_(-v) \
      & = x                                   &           quad "by assumption" \
$
So
$
  t' = gamma t + (1 - gamma^2)/(gamma v) x.
$

#remarklike[Step 3][
  With postulate (2), the light ray $x = c t$ must map to $x' = c t'$.
]

We have
$
  x' = c t' & = c(gamma t + (1 - gamma^2)/(gamma v) x) \
            & =c (gamma + (1-gamma^2)/(gamma) (c)/(v)) t
$
and
$
  x' = gamma(x - v t) = gamma (c - v) t
$


Hence, solving for $gamma$ gives

#boxed(
  $
    gamma = 1/sqrt(1 - v^2/c^2).
  $,
)
See that the transformation only makes sense for $v < c$. So we have derived


#boxed(
  $
    x' & = gamma (x - v t) \
    t' & = gamma (t - (v)/(c^2) x).
  $,
)

This is the #ponder("relativity.lorentz-group")[Lorentz transformation], or the #ponder("relativity.lorentz-group")[Lorentz boost]. These are #ponder("linear-algebra.linear-map")[linear transformations], so we can invert them to get
$
  x & = gamma (x' + v t') #<eq-395> \
  t & = gamma (t' + (v)/(c^2) x') #<eq-396>
$
_i.e._ $v -> -v$.


For velocities $v << c$, $gamma approx 1$ and $(gamma)/(c) -> 0$, so these become the #ponder("dynamics.galilean-transformation")[Galilean transformations] _i.e._ the non-relativistic limit.

We will now explore some possibly counter-intuitive consequences of the above.

== Addition of Velocities

A particle moving with speed $u'$ in a frame $S'$ which in turn moves at a speed $v$ in frame $S$. Consider the speed $u$ the particle moves at in frame $S$.

By @eq-395 and @eq-396, we have
$
  u & = (x)/(t) = (x' + v t')/(t' + (v)/(c^2) x') \
    & = ((x')/(t') + v) / (1 + (v)/(c^2) (x')/(t')) \
$

Therefore, we have the relativistic formula for addition of velocities:

#boxed[
  $
    u = (u' + v)/(1 + (v u')/(c^2)).
  $
]

It is easy to check that if $abs(u')$ and $abs(v)$ are both less than $c$, then so is $u$. Hence, we cannot make an object move faster than light by adding velocities.

#example[
  1. Let $u' = v = (c)/(2)$. Then
    $
      u = c dot ((1)/(2) + (1)/(2))/(1 + (1)/(4)) = (4)/(5) c < c.
    $

  2. Let $u' = v = c$. Then
    $
      u = c dot (1 + 1)/(1 + 1) = c.
    $
]

== Spacetime Diagrams and Simultaneity

Consider the following type of diagram

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e51.svg", width: 20em)
]

We may put the axes for a frame $S'$ on the spacetime diagram of $S$:

- $t'$ axis is at $x' = 0$, which gives $c t = (c)/(v) x$.

- $x'$ axis is at $t' = 0$, which gives $c t = (v)/(c) x$.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e52.svg", width: 12em)
]

where the axes are symmetrical about the light ray $x = c t$.

#lecture-separator(lecture: 17, date: "2026-03-03")

We can draw lines at constant $t$ and $t'$ to get

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e53.svg", width: 24em)
]

So $P_1$ and $P_2$ are simultaneous in $S$ but not in $S'$. This is the relativity of simultaneity.

There is a direct consequence of the speed of light being the same, which is demonstrated by a famous illustration due to Einstein. Consider a train.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e54.svg", width: 18em)
]

A light is emitted from the centre of the train. The light reaches the front and back of the train at the same time in the frame of the train. However, for an observer on the platform, the light reaches the back of the train before it reaches the front. Hence, events that are simultaneous in one frame may not be simultaneous in another frame.

#fade[[In Galilean physics, the platform observer would see light going at $c+v$ in one direction and $c-v$ in the other, reaching both ends at the same time.]]

One may concern that if different frames see things at different times, we might be able to reverse cause and effect. We will see that this is not the case.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e55.svg", width: 20em)
]

The future light cone of $P$ consists of all points that can be influenced by $P$, and the past light cone of $P$ consists of all points that can influence $P$.

Note that the lines of simultaneity of $S'$ can be at most at $45°$ as $v->c$. Hence, we can make $R$ simultaneous with $P$, but cannot make $Q$ simultaneous with $P$.

Therefore, in all frames, the future light cone of $P$ is to the future of $P$, and nothing moves faster than light, so causality is ensured. _i.e._ all frames agree on what events can influence.

== Time Dilation

A clock at rest in frame $S'$ ticks at intervals $T'$. _i.e._ the ticks occur at
$
  (0, 0), (c T', 0), (2c T', 0), ...
$

In frame $S$, using @eq-395 and @eq-396, where
$
  t = gamma(t' + (v)/(c^2) x')
$
with $x'=0$, we have the ticks occurring at
$
  t=0, gamma T', 2gamma T', ...
$
So $T = gamma T'$. Recall that $gamma > 1$, so $T > T'$. _i.e._ a moving clock runs more slowly. #fade[[$T$ is the time interval between ticks on the moving clock as measured in $S$, and $T'$ is the time interval between ticks on the clock as measured in its rest frame $S'$.]]

== Twin Paradox #fade[[Not a Paradox]]

Consider twin $A$ that stays on Earth, and $B$ that goes to Neptune and back at almost light speed. We would investigate which one is younger.

Each twin sees the other one moving while themselves staying at rest, so each one thinks the other one is younger. This seems paradoxical.

The key asymmetry is that twin $B$ needs to turn around to come back.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e56.svg", width: 9em)
]

From the perspective of $A$, time $2T$ passes, while $2T' = (2T)/(gamma)$ has passed on $B$'s clock, so $B$ is younger.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e57.svg", width: 17em)
]

From the perspective of $B$, while travelling out and back, indeed $A$'s clock runs more slowly, and $2hat(T) = 2T'/gamma$ passes in total.

However, the jump in the lines of simultaneity at the turnaround means that $B$ sees $A$'s clock jump forward by a large amount, so $A$ is older.

#remark[
  See Example Sheet for a full treatment on this issue.
]

== Length Contraction

A rod has length $L'$ at rest in frame $S'$, where the length is defined as the distance between endpoints at a fixed time.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e58.svg", width: 10em)
]

Now consider frame $S$.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e59.svg", width: 10em)
]

#lecture-separator(lecture: 18, date: "2026-03-05")

We would like to calculate $L = P_1 P_3$ given $L'$.

We have
$
        P_1 & = (0, 0) quad "in both frames" \
        P_2 & = (c t', x') = (0, L') \
            & =(c t, x) = (gamma (v)/(c) L', gamma L'). \
  P_3 "has" & x = gamma L' - v (gamma v L)/(c^2) \
$
_i.e._ for $P_3$ we have $eval(x)_P_3 = eval(x)_P_2 - v eval(t)_P_2$.

Hence,
$
  L = gamma L' (1 - (v^2)/(c^2)) = L'/gamma.
$

Therefore, moving objects appear shorter. This is called *Lorentz contraction*.

#example[
  Consider a ladder of length $2L$ and a barn of length $L$.

  Due to lorentz contraction, if the ladder moves fast enough, an external observer would see the ladder fit in the barn. However, the observer on the ladder would see the barn even shorter, so the ladder cannot fit in the barn.

  #align(center)[
    #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e60.svg", width: 20em)
  ]
]

== The Invariant Interval

Consider two events $P_1$ and $P_2$ with coordinates $(c t_1, x_1)$ and $(c t_2, x_2)$ in frame $S$. Let
$
  Delta t & = t_2 - t_1 \
  Delta x & = x_2 - x_1 \
$
each represent the separation in time and space between the two events.

The *invariant interval* is defined as
$
  (Delta s)^2 equiv c^2 (Delta t)^2 - (Delta x)^2.
$

We can check that it is indeed invariant:
$
  c^2 (Delta t')^2 - (Delta x')^2 & = c^2 gamma^2 ( Delta t - (v)/(c^2) Delta x)^2 - gamma^2 (Delta x - v Delta t)^2 \
  &= (Delta t)^2 (gamma^2 c^2 - gamma^2 v^2) + (Delta x)^2 (gamma^2 (c^2 v^2)/(c^4) - gamma^2) \
  &= c^2 (Delta t)^2 - (Delta x)^2. \
$

Hence, observers may disagree about time passed and the distance between events, but they all agree on the invariant interval. We can write
$
  (Delta s)^2 = mat(c Delta t, Delta x) underbracket(mat(1, 0; 0, -1), "Minkowski metric") vec(c Delta t, Delta x).
$
With this matrix form, the Lorentz transformation can be written as
$
  vec(c t', x') = mat(gamma, -(gamma v)/c; -(gamma v)/c, gamma) vec(c t, x).
$

The invariance of $(Delta s)^2$ is equivalent to
$
  underbracket(mat(gamma, -(gamma v)/c; -(gamma v)/c, gamma), "transposed") mat(1, 0; 0, -1) mat(gamma, -(gamma v)/c; -(gamma v)/c, gamma) = mat(1, 0; 0, -1).
$
_i.e._ #ponder("relativity.lorentz-group")[Lorentz transformations] preserve the #ponder("relativity.minkowski-space")[Minkowski metric].

#remark[
  Compare this to how #ponder("geometry.rotation")[rotations] preserve the Euclidean metric, $bold(R)^tp mat(1, 0; 0, 1) bold(R) = mat(1, 0; 0, 1)$.
]

The #ponder("relativity.minkowski-space")[Minkowski metric] is not #ponder("linear-algebra.matrix-definiteness")[positive definite]. So, we have points with
$
  (Delta s)^2 & > 0 quad "timelike separated" \
  (Delta s)^2 & < 0 quad "spacelike separated" \
  (Delta s)^2 & = 0 quad "lightlike separated"
$
Note that, two points with $(Delta s)^2 = 0$ are connected by a light ray. The #ponder("relativity.minkowski-space")[Minkowski metric] mesures distances in spacetime.

== Rapidity

To make the analogy with rotations more clear, we will define *rapidity* $phi$ as
$
  gamma =: cosh phi.
$
Then,
$
  sinh phi = sqrt(cosh^2 phi - 1) = sqrt(gamma^2 - 1) = (gamma v)/c.
$
So the #ponder("relativity.lorentz-group")[Lorentz transformation] can be written as
$
  mat(gamma, -(gamma v)/(c); -(gamma v)/(c), gamma) = mat(cosh phi, -sinh phi; -sinh phi, cosh phi) =: matbold(Lambda)[phi].
$
Hence, two sequential #ponder("relativity.lorentz-group")[Lorentz boosts] satisfy
$
  matbold(Lambda)[phi_1] matbold(Lambda)[phi_2] = matbold(Lambda)[phi_1 + phi_2].
$
_i.e._ rapidities add like angles in #ponder("geometry.rotation")[rotations].

In contrast, in terms of velocities,
$
  matbold(Lambda)(v_1) matbold(Lambda)(v_2) = matbold(Lambda)((v_1 + v_2)/(1 + (v_1 v_2)/(c^2))),
$
which is consistent with the relativistic addition of velocities.

== #ponder("relativity.lorentz-group")[Lorentz Transformations] in 4 Dimensions

The 4D #ponder("relativity.minkowski-space")[Minkowski metric] is
$
  matbold(eta) = mat(1, 0, 0, 0; 0, -1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1).
$
we write this with indices as
$
  eta_(mu nu) quad "where" quad mu, nu = 0, 1, 2, 3.
$

An event in spacetime is given by a *4-vector*
$
  bold(X) = (c t, x, y, z)
$
we write this with indices as
$
  X^mu quad "where" quad mu = 0, 1, 2, 3
$
#remark[
  It will be important to distinguish between lower and upper indices in Part IB.
]

The invariant distance between $bold(0)$ and an event $bold(X)$ is given by the #ponder("linear-algebra.inner-product")[inner product]
$
  bold(X) dot bold(X) equiv bold(X)^tp matbold(eta) bold(X) = X^mu eta_(mu nu) X^nu
  = c^2 t^2 - x^2 - y^2 - z^2. #<eq-431>
$

#lecture-separator(lecture: 19, date: "2026-03-07")

The #ponder("linear-algebra.inner-product")[inner product] of $bold(X)$  is not #ponder("linear-algebra.matrix-definiteness")[positive definite]. We call each of the cases
$
  bold(X) dot bold(X) & > 0 quad "timelike" \
  bold(X) dot bold(X) & < 0 quad "spacelike" \
  bold(X) dot bold(X) & = 0 quad "lightlike or null"
$
The 4D #ponder("relativity.lorentz-group")[Lorentz transformations] are $4times 4$ matrices $matbold(Lambda)$ such that
$
  bold(X') = matbold(Lambda) bold(X).
$
#fade[[In indices, this is $X'^mu = tensor(Lambda, +mu, -nu) X^nu.$]]

The defining feature of #ponder("relativity.lorentz-group")[Lorentz transformations] is that they have the #ponder("linear-algebra.inner-product")[inner product] invariant,
$
  bold(X') dot bold(X') = bold(X) dot bold(X) quad <=> quad matbold(Lambda)^tp matbold(eta) matbold(Lambda) = matbold(eta).
$

Consider the number of $matbold(Lambda)$. There are 16 entries, and since both sides of the above are symmetric, we have 10 constraints. Hence, we expect to find 6 families of #ponder("relativity.lorentz-group")[Lorentz transformations].

- 3 of them are #ponder("geometry.rotation")[rotations] of the form
  $
    matbold(Lambda) = mat(1, 0, 0, 0; 0, R_11, R_12, R_13; 0, R_21, R_22, R_23; 0, R_31, R_32, R_33)
  $
  which satisfy $matbold(R)^tp matbold(R) = matbold(I)$.

  These give 3 independent #ponder("geometry.rotation")[rotations] about different axes. Composition of them also includes #ponder("geometry.reflection")[reflections].

- 3 of them are #ponder("relativity.lorentz-group")[Lorentz boosts] along the 3 possible axes of the form
  $
    matbold(Lambda) = mat(gamma, -(gamma v)/c, 0, 0; -(gamma v)/c, gamma, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)
  $
  and similarly for boosts along $y$ and $z$ axes.

These matrices $matbold(Lambda)$ form the *#ponder("relativity.lorentz-group")[Lorentz group]*: $"O"(1, 3)$.

Because the #ponder("linear-algebra.inner-product")[inner product] is preserved by these transformations, it automatically follows that the speed of light is the same in all frames, because null 4-vectors are null in all frames.

#ponder("algebra.subgroup")[Subgroups] with $det matbold(Lambda) = + 1$ are called the *proper Lorentz group*, denoted by $"SO"(1, 3)$.

A further #ponder("algebra.subgroup")[subgroup] are those that do reserve the time direction, called the *proper orthochronous Lorentz group*, denoted by $"SO"^(+)(1, 3)$. For example,
$
  matbold(Lambda) = mat(-1, 0, 0, 0; 0, -1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1)
$
is in $"SO"(1, 3)$ but not in $"SO"^(+)(1, 3)$.

== Proper Time

We want to define a velocity that is a 4-vector. We need to find a time $tau$ that is invariant under #ponder("relativity.lorentz-group")[Lorentz transformations], and define the 4-velocity as
$
  bold(U) := (dif bold(X))/(dif tau).
$
Given two points along a worldline, the invariant interval $(Delta s)^2$ is the same in all inertial frames. Hence, the *proper time* between these points is defined as

#boxed[
  $
    Delta tau := (Delta s)/c.
  $
]

Note that worldlines are always timelike, so $Delta tau$ is real.

All frames agree on $Delta tau$, and they can parameterise the worldline by
$
  bold(x)(tau) quad "and" quad t(tau).
$
#fade[[This is a Lorentzian version of the arc length.]]

Along a small segment of the worldline,
$
  dif tau = sqrt((dif t)^2 - (dif bold(x)^2)/(c^2)) = dif t sqrt(1 - (1)/(c^2) ((dif bold(x))/(dif t))^2)
$

We can define the 3-velocity as
$
  bold(u) := (dif bold(x))/(dif t)
$
hence
$
  dif tau = dif t sqrt(1-bold(u)^2/c^2) = (1)/(gamma) dif t.
$
where here $gamma$ is a function of the instantaneous 3-velocity $bold(u)$. Hence by above,

#boxed[
  $
    (dif t)/(dif tau) = gamma.
  $
]

A clock following the worldline has
$
  dif bold(x)' = bold(0) => dif tau = dif t'.
$

_i.e._ the proper time is the time measured by an observer following the worldline.

== 4-Velocity

Because $tau$ is invariant and
$
  bold(X)(tau) = vec(c t(tau), bold(x)(tau))
$
transforms by Lorentz: $bold(X') = matbold(Lambda) bold(X)$, then

#boxed[
  $
    bold(U) := (dif bold(X))/(dif tau) = vec(c (dif t)/(dif tau), (dif bold(x))/(dif tau)) = (dif t)/(dif tau) vec(c, (dif bold(x))/(dif t)) = gamma vec(c, bold(u)).
  $
]

This also transforms as

#boxed[
  $ bold(U)' = matbold(Lambda) bold(U). #<eq-450> $
]

The definition of a 4-vector implies that it transforms this way.

In particular, because of @eq-450,
$
  bold(U') dot bold(U') = bold(U) dot bold(U).
$
In fact,
$
  bold(U) dot bold(U) = gamma^2 c^2 - gamma^2 bold(u)^2 = (c^2-bold(u)^2)gamma^2 = c^2.
$

The relativistic 4-vector incorporates the familiar 3-velocity $bold(u)$ into a nice Lorentzian object.

#lecture-separator(lecture: 20, date: "2026-03-10")

== 4-Momentum

The *4-momentum* is defined as

#boxed[
  $
    bold(P) := m bold(U) = vec(m gamma c, m gamma bold(u)).
  $
]

where $m$ is the property of the particle called *rest mass*.

The *relativistic energy* $E$ and the *relativistic 3-momentum* $bold(p)$ are defined by

#boxed[
  $
    E := m gamma c^2, quad bold(p) := m gamma bold(u). #<eq-454>
  $
]

So the 4-momentum can be written as

$
  bold(P) = vec(E/c, bold(p)).
$

Note that
$
  bold(P') = matbold(Lambda) bold(P).
$

_i.e._ the 4-momentum combines energy and momentum, analogously to how $bold(X)$ combines time and space.

In the absense of forces, $bold(P)$ is conserved,
$
  (dif bold(P))/(dif tau) = bold(0). #<eq-457>
$

@eq-457 is a Lorentz-invariant generalisation of Newton's First Law. It also combines conservation of energy and momentum.

From $bold(U) dot bold(U) = c^2$, we get

#boxed[
  $
       & bold(P) dot bold(P) = m^2 c^2 \
    => & (E^2)/(c^2) - bold(p)^2 = m^2c^2 \
    => & E^2 = bold(p)^2 c^2 + m^2 c^4. #<eq-460>
  $
]

In the non-relativistic limit, $abs(bold(u))/(c) << 1$, we get
$
  bold(p) & approx m bold(u) \
  E & =m gamma c^2 \
  & = (m c^2)/(sqrt(1-(u^2)/(c^2)) ) \
  & = m c^2 (1 + (1)/(2) (u^2)/(c^2) + ... ) \
  & approx underbracket(m c^2, "rest mass"\ "energy") + underbracket((1)/(2) m u^2, "non-relativistic"\ "kinetic energy").
$

The rest mass energy term is a new consequence fo relativity, where we can predict that mass leads to an energy.

Now consider the high velocity limit
$
  bold(p) = underbracket(gamma m, "relativistic"\ "mass") bold(u)
$
where as $u -> c$, $gamma -> oo$. So $gamma m -> oo$.

_i.e._ more and more forces are needed to accelerate the particle. In particular, any finite force cannot accelerate a particle to the speed of light.

Hence, a particle with $m != 0$ (called a massive particle) has $u < c$.

== Massless Particle

In Galilean physics, the notion of a massless particle does not make sense. Our relativistic expression
$
  bold(P) dot bold(P) = m^2 c^2
$
suggests that massless particles should have
$
  bold(P) dot bold(P) = 0. #<eq-468>
$
This imply that the 4-momentum of a massless particle lies along a light ray.

4-velocity does not exist for a massless particle, and the 4-momentum is the more fundamental concept.

Using @eq-431 and @eq-468, we have
$
  bold(P) = (E)/(c) vec(1, bold(hat(n)))
$
where $bold(hat(n))$ satisfies $bold(hat(n))^2 = 1$. We can interpret this as
$
  bold(hat(n)) := bold(u)/c
$
where $bold(u)$ is the 3-velocity, so that $bold(u)^2= c^2$, hence massless particles moves at the speed of light.

_i.e._
$
  m != 0 quad & => quad abs(bold(u)) < c \
   m = 0 quad & => quad abs(bold(u)) = c.
$
along a light ray $dif tau = 0$, since any points on the trajectory are lightline separated.

Hence no time passes for a massless particle.

There are only two known massless particles: photons and gravitons. We only conider photons (the particles of light) in this course.

From quantum mechanics, we have for a photon,
$
  E = planck omega = planck (2 ppi c)/(lambda)
$
where $omega$ is the angular frequency of the photon, and $lambda$ is the wavelength of the photon.

Length contraction means that different observers see different wavelengths of light, and hence sees different energies. (See Example Sheet.)

== Particle Physics

Particle accelerators like CERN work by colliding particles at relativistic speeds. The proper framework for this is quantum field theory, but nonetheless we can learn some things from
$
  bold(P) = "constant".
$

_i.e._ the 4-momentum $bold(P)$ must be the same before and after the collision.

Basic processes include particle delay and particle collisions.

=== Particle Decay

Heavy particles are often unstable and decay into lighter particles, _i.e._ the Higgs boson decays in $~ 10^(-22)$ seconds.

Such particles are detected by their decay products, for example,
$
  h -> gamma gamma
$
where $h$ is the Higgs boson and $gamma$ is a photon.

From Large Hadron Collider,
$
  m_h c^2 approx qty("125", "GeV").
$
which is about $~10^5$ times heavier than an electron.

By conservation of 4-momentum,
$
  bold(P_h) = bold(P_gamma) + bold(P_gamma').
$

Before solving this, we need to choose a frame to work in. The two canonical options are

1. the "lab" frame, in which the particles are moving.

2. the "centre of mass" (or "centre of momentum") frame, in which the total 3-momentum is zero.

(2) is often more convenient. For decays, (2) is the rest frame of the unstable particle.

#lecture-separator(lecture: 21, date: "2026-03-12")

In the CoM frame, we have
$
  bold(P_h) = vec(m_h c, bold(0)), quad bold(P_gamma) = (E_gamma)/(c) vec(1, bold(hat(n))), quad bold(P_gamma') = (E_gamma')/(c) vec(1, bold(hat(n)')).
$
By conservation of 4-momentum, we have
$
  m_h c = (E_gamma)/(c) + (E_gamma')/(c), quad (E_gamma)/(c) bold(hat(n)) + (E_gamma')/(c) bold(hat(n)') = bold(0).
$
Hence,
$
  cases(
    E_gamma = E_gamma',
    bold(hat(n)) = -bold(hat(n)').
  )
$
_i.e._ the two photons emerge with opposite 3-momenta and equal energies. Also,
$
  E_gamma = E_gamma' = (1)/(2) m_h c^2.
$
Hence, each photon carries half of the rest mass energy of the Higgs boson. _i.e._ rest mass energy has been converted into kinetic energy.

In the lab frame,

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e61.svg", width: 20em)
]

consider the angle $theta$. The idea is to use conservation $bold(P_h) = bold(P_gamma) + bold(P_gamma')$ and invariants #fade[[quantities that do not change under #ponder("relativity.lorentz-group")[Lorentz tranformations], such as the #ponder("linear-algebra.inner-product")[inner product] of 4-vectors]]. Since $bold(P) dot bold(P) = 0$ for photons, we have
$
  bold(P_h) - bold(P_gamma) = bold(P_gamma') => bold(P_gamma') dot bold(P_gamma') &= (bold(P_h) - bold(P_gamma)) dot (bold(P_h) - bold(P_gamma))\
  bold(0) &= bold(P_h^2) - 2 bold(P_h) dot bold(P_gamma) + bold(P_gamma^2)\
  & = m_h^2 c^2 - 2 bold(P_h) dot bold(P_gamma)\
  2 bold(P_h) dot bold(P_gamma) & = m_h^2 c^2.
$

Now, since $bold(P_h) = vec(m_h c, bold(0))$ and $bold(P_gamma) = (E_gamma)/(c) vec(1, bold(hat(n)))$, we have
$
  m_h^2 c^2 = 2 ((E_h E_gamma)/(c^2) - (E_gamma)/(c) abs(bold(p_h)) cos theta)
$

Using this alongside @eq-460, we can solve for $theta$ given $E_h$ and $E_gamma$.

=== Particle Collisions

Consider the process of two particles of mass $m$ colliding, in the centre of mass frame, scattering at an angle $theta$,

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e62.svg", width: 16em)
]

By conservation of 4-momentum, we have
$
  bold(P_1) + bold(P_2) = bold(P_3) + bold(P_4). #<eq-487>
$

In the CoM frame, we have
$
  bold(p_1) + bold(p_2) = bold(0) = bold(p_3) + bold(p_4).
$
Hence $abs(bold(p_1)) = abs(bold(p_2))$ and $abs(bold(p_3)) = abs(bold(p_4))$. Therefore,
$
  E_1 = E_2, quad E_3 = E_4.
$
Considering the time component of @eq-487, we have
$
          & E_1 = E_2 = E_3 = E_4 \
  => quad & abs(bold(p_1)) = abs(bold(p_2)) = abs(bold(p_3)) = abs(bold(p_4))
$
_i.e._ any angle $theta$ is allowed, but momenta and energy afterwards equal the initial momenta and energy. All momenta are in the same plane, so we can pick, for example,
$
  bold(p_1) & = abs(bold(p_1)) vec(1, 0, 0) = - bold(p_2) \
  bold(p_3) & = abs(bold(p_3)) vec(cos theta, sin theta, 0) = - bold(p_4).
$

In the lab frame,

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e63.svg", width: 12em)
]

where $P_2$ is at rest, hit by $P_1$. Our objective is to find the angle $phi$.

The important step is to use invariants. We firstly have
$
  bold(P_1) + bold(P_2) = bold(P_3) + bold(P_4).
$
Since we are looking for information related to $bold(P_3)$, the best way to eliminate $bold(P_4)$ is to take the inner product with itself, so that
$
  (bold(P_1) + bold(P_2) - bold(P_3))^2 = bold(P_4)^2 = m^2 c^2\
  m^2c^2 = underbracket(bold(P_1)^2 + bold(P_2)^2 + bold(P_3)^2, 3 m^2 c^2) + 2 bold(P_1) dot bold(P_2) - 2 bold(P_1) dot bold(P_3) - 2 bold(P_2) dot bold(P_3).
$
Since $bold(P_2)$ is at rest,
$
  bold(P_2) = vec(m c, bold(0)), quad bold(P_1) = vec((E_1)/(c), bold(p_1)), quad bold(P_3) = vec((E_3)/(c), bold(p_3)).
$
Hence,
$
  2 m^2c^2 + 2 m(E_(1)-E_3) - (2 E_1 E_3)/(c^2) = -2 abs(bold(p_1)) abs(bold(p_3)) cos phi.
$
We have obtained $cos theta$ in terms of $E_1, E_3$ and $bold(p_1), bold(p_3)$. Using @eq-460 eliminates the $bold(p_i)$ terms.

See Example Sheet 4 for Compton scattering, which describes a massless particle scattering off a massive one.

#lecture-separator(lecture: 22, date: "2026-03-14")

=== Particle Creation

If two particles collide with enough energy, some of that energy can be used to create a third particle. This is usually how we discover new particles.

In the CoM frame,

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e64.svg", width: 26em)
]

Let $P_1$ and $P_2$ be of mass $m$, and the created particle be of mass $M$. We have
$
  bold(P_1) + bold(P_2) = bold(P'_1) + bold(P'_2) + bold(P_M). #<eq-499>
$
Since we are in the CoM frame,
$
  bold(p_1) = -bold(p_2) => E_1 = E_2.
$

Squaring @eq-499 gives
$
  (bold(P_1) + bold(P_2))^2 &= (4 E_1^2)/(c^2) quad "by" bold(P_1) = vec((E_1)/(c), bold(p_1)), bold(P_2) = vec((E_2)/(c), bold(p_2)) #<eq-501>\
  (bold(P'_1) + bold(P'_2)+bold(P_M))^2 &= bold(P'_1)^2 + bold(P'_2)^2 + bold(P_M)^2 + 2 bold(P'_1) dot bold(P'_2) + 2 bold(P'_1) dot bold(P_M) + 2 bold(P'_2) dot bold(P_M). #<eq-502>
$

Note that
$
  bold(P'_1)^2 + bold(P'_2)^2 + bold(P_M)^2 = 2 m^2 c^2 + M^2 c^2.
$

#lemma[
  With variables as defined above,
  $
    bold(P_1) dot bold(P_2) >= m_1 m_2 c^2.
  $
] <lemma-four-momentum-inner-product>
#proof[
  $bold(P_1) dot bold(P_2)$ is invariant, so we can work in any frame. In the rest frame of $bold(P_2)$,
  $
    bold(P_1) = vec((E_1)/(c), bold(p_1)), quad bold(P_2) = vec(m_2 c, bold(0)).
  $
  Hence
  $
    bold(P_1) dot bold(P_2) = m_2 E_1.
  $
  Since $E_1 = sqrt(p_1^2 c^2 + m_1^2 c^4) >= m_1c^2$, we get
  $
    bold(P_1) dot bold(P_2) >= m_1 m_2 c^2.
  $
  Note that we chose the $+$ sign for the square root. The other sign leads to wrong non-relativistic limit, _i.e._ the kinetic energy would be negative. Recall that proper orthochronous Lorentz transformation will preserve positivity of $E_1$.
]
Now, applying the lemma to @eq-502, we have
$
  (bold(P'_1) + bold(P'_2)+bold(P_M))^2 >= 2m^2c^2 + M^2c^2 + 2(m^2c^2 + 2m M c^2) = 4 (m + (1)/(2) M)^2 c^2.
$
Using @eq-501, we have
$
  (4 E_1^2)/(c^2) & >= 4 (m + (1)/(2) M)^2 c^2 \
  E_1 & >= (m + (1)/(2) M) c^2 \
  underbracket(E_1-m c^2, approx "kinetic energy"\ "of each incoming"\ "particle") & >= (1)/(2) underbracket(M c^2, "rest mass"\ "energy of"\ "created particle").
$
_i.e._ the total kinetic energy of the incoming particles
$
  2(E_1 - m c^2)
$
must be greater than the rest mass energy of the created particle, $M c^2$.

== Accelerated Motion in Special Relativity

We may define the acceleration 4-vector, for a massive particle,
$
  bold(A) := (dif bold(U))/(dif tau).
$
Since $bold(U) dot bold(U) = c^2$, we have
$
  bold(U) dot bold(A) = 0. #<eq-511>
$
Since $bold(U) = gamma vec(c, bold(u))$, using chain rule $(dif)/(dif tau) = (dif t)/(dif tau) (dif)/(dif t) = gamma (dif)/(dif t)$, we have
$
  bold(A) = gamma vec(dot(gamma) c, dot(gamma) bold(u) + gamma bold(a)) quad "where" quad dot(gamma) = (dif gamma)/(dif t), quad bold(a) = (dif bold(u))/(dif t).
$

We would like to consider motion for a constant acceleration, but we need to define a frame in which the acceleration is constant.

We will take an #ponder("dynamics.inertial-frame")[inertial frame] $S'$ that, at some moment in time, is instantaneously travelling at the same speed as the particle, _i.e._ $bold(u') = bold(0)$. Hence $gamma = 1$ and $dot(gamma) = 0$ in that frame.

#fade[[More precisely,
  $
    dot(gamma) = (+bold(u) dot bold(dot(u)))/(c^2(1-bold(u)^2/c^2)^(3/2)) = 0
  $
  given that $bold(u) = bold(0)$ in that frame.]]

To make calculation easier, we will consider motion in one spatial dimension, so that in $S'$ we have
$
  bold(A') = vec(0, a').
$

We say the acceleration is constant if $a'$ is constant. #fade[[Later we will see that this follows from a constant force.]]

We can get $bold(A)$ from $bold(A')$ by using inverse #ponder("relativity.lorentz-group")[Lorentz transformation] @eq-395 and @eq-396, by speed $u$,
$
  bold(A) = vec((gamma u a')/c, gamma a').
$
Matching with the general expression for $bold(A)$,
$
              cancel(gamma) dot(gamma) c & = (cancel(gamma) u a')/c \
  cancel(gamma) (dot(gamma) u + gamma a) & = cancel(gamma) a'
$
We can hence solve for $dot(gamma)$ and hence $a$, giving
$
  a := dot(u) = (1 - (u^2)/(c^2))^(3/2) a'.
$

#lecture-separator(lecture: 23, date: "2026-03-17")

Then
$
  integral (dif u)/(a' (1-(u^2)/(c^2)))^((3)/(2)) & = integral dif t \
                                                u & = (a' c t)/(sqrt(c^2 + a'^2 t^2) ).
$

For early times $a't << c$, we get $u approx a' t$.

For late times $a't >> c$, we get $u -> c$.

Since $u = dot(x)$, we can integrate again to get
$
  x = (c)/(a') sqrt(c^2 + a'^2 t^2) + "constant".
$

This is the equation of an hyperbola. An accelerated particle follows a hyperbola in spacetime.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e65.svg", width: 24em)
]

The Rindler horizon separates the accessible and inaccessible regoins of sapce time. #fade[[Black holes work in a similar way: one need to accelerate not to fall in.]]

Let the force 4-vector $bold(F)$ obey
$
  bold(F) := (dif bold(P))/(dif tau) = m bold(A). #<eq-525>
$

Let us parameterise $bold(F)$ as
$
  bold(F) := vec(F^0, gamma bold(f)).
$

Recall that $bold(P) = vec(E/c, bold(p))$. For the spatial component of @eq-525,

$
  (dif bold(p))/(dif t) = 1/gamma (dif bold(p))/(dif tau) = bold(f).
$
Hence $bold(f)$ is the force appearing in #ponder("dynamics.newtons-second-law")[Newton's law], but note that $bold(p) = gamma m bold(u)$ is the relativistic 3-momentum. This connects to previous discussion that particles get heavier as they speed up.

Also, if $bold(f)$ is constant #fade[[_i.e._ a constant force]], then $bold(a')$ is constant in $bold(A)$, _i.e._ indeed a constant $bold(f)$ produces a constant acceleration in the instantaenous rest frame.

Consider the time component of @eq-525,
$
  F^0 = 1/c (dif E)/(dif tau) = (gamma)/(c) (dif E)/(dif t).
$
So $F^0$ is proportional to change of energy with time.

To recover a familiar equation, using @eq-454,
$
  0 = (dif)/(dif tau) (bold(P) dot bold(P)) & = 2 bold(P) dot (dif bold(P))/(dif tau) \
                                            & = 2 ((E)/(c^2) (dif E)/(dif tau) - bold(p) dot (dif bold(p))/(dif tau) ) \
                                            & = 2 gamma^2 m ((dif E)/(dif t) - bold(u) dot (dif bold(p))/(dif t))
$
Hence,
$
  (dif E)/(dif t) = bold(u) dot (dif bold(p))/(dif t) = bold(u) dot bold(f).
$
which essentially says that the change in energy is the rate of work done.

== Example Lorentz Force #fade[[Non-Examinable]]

Lorentz force can be written in the form
$
  (dif bold(P))/(dif tau) = (q)/(c) matbold(G) dot bold(U) #<eq-533>
$
where $matbold(G)$ is the electromagnetic 4-tensor,
$
  matbold(G) = mat(0, -E_x, -E_y, -E_z; E_x, 0, - c B_(z), c B_(y); E_y, c B_z, 0, - c B_x; E_z, -c B_y, c B_x, 0).
$

The time component of @eq-533 is
$
  gamma (dif E)/(dif t) & = (q)/(c) bold(E) dot gamma bold(u) \
        (dif E)/(dif t) & = (q)/(c) bold(E) dot bold(u)
$
_i.e._ the electric field does work, but magnetic field does not.

The spatial component of @eq-533 is
$
  gamma (dif bold(P))/(dif t) & = (q)/(c) (tensor(matbold(G), +i, +0) bold(u)_0 - tensor(matbold(G), +i, +j) bold(u)_j) \
                              & = (q)/(c) (bold(E)^i gamma c + epsilon^(i j k) bold(B)^k c gamma bold(u)_j).
$
Therefore
$
  (dif bold(p))/(dif t) = (q)/(c) (bold(E) + bold(u) times bold(B)).
$
_i.e._ the Lorentz force is relativistically invariant, but we need to account for the mixing of $bold(E)$ and $bold(B)$ under Lorentz transformations, where
$
  bold(u') = matbold(Lambda) bold(u) quad "and" quad matbold(G') = matbold(Lambda) matbold(G) matbold(Lambda)^(-1).
$


