#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/unify:0.7.1": qty

= Systems of Particles

There are many particles in the universe. We shall focus on $N$ of them.

Label the particles by $i = 1, ..., N$. Each particle has a momentum
$
  bold(p_i) = m_i bold(dot(x)_i)
$
and obeys #ponder("dynamics.newtons-second-law")[Newton's law] individually,
$
  bold(dot(p)_i) = bold(F)_i.
$

The force $bold(F_i)$ on the $i$-th particle can be external or due to the other particles:
$
  bold(F_i) = bold(F_i^"ext") + sum_(j != i) bold(F_(i j)),
$
where $bold(F_(i j))$ is the force on the $i$-th particle due to the $j$-th particle. The forces between particles are found to obey

$
  bold(F_(i j)) = - bold(F_(j i))
$
due to #ponder("dynamics.newtons-third-law")[Newton's third law].

#law[Newton's Third Law][
  Every action has an equal and opposite reaction.
] <law-newtons-third-law>

#lecture-separator(lecture: 9, date: "2026-02-12")

== Centre of Mass

Consider a system of $N$ particles.

#definition[Centre of Mass][
  The total mass of a system is $M = sum_(i=1)^N m_i$.

  The #ponder("dynamics.centre-of-mass")[centre of mass] of a system is defined as $ bold(R) = 1/M sum_(i=1)^N m_i bold(x)_i. $
] <def-centre-of-mass>

The total momentum of a system can therefore be expressed as
$
  bold(P) & = sum_(i=1)^N bold(p_i) \
          & = sum_(i=1)^N m_i bold(dot(x)_i) \
          & = M bold(dot(R)).
$
Therefore, the #ponder("dynamics.centre-of-mass")[centre of mass] moves as if it is a single particle of mass $M$.

=== Conservation of Momentum

We have
$
  bold(dot(P)) & = sum_i bold(dot(p)_i) \
               & = sum_i (bold(F_i^"ext") + sum_(j != i) bold(F_(i j))) \
               & = sum_i bold(F_i^"ext") + sum_(i < j) underbracket((bold(F_(i j)) + bold(F_(j i))), =0 "by N3") \
               & = sum_i bold(F_i^"ext").
$

We have hence shown that
$
  M bold(dot.double(R)) = bold(F) = sum_i bold(F_i^"ext").
$

Hence, the #ponder("dynamics.centre-of-mass")[centre of mass] accelerates like a point particle, subject to an external force $bold(F)$.

#remark[
  This is the reason why we can treat the Earth as a point particle, since its internal forces cancel out.
]

In particular, $bold(F) = 0$ implies that $bold(dot(P)) = 0$, so the total momentum of a system is conserved in the absence of external forces.

=== Conservation of Angular Momentum

A similar result holds for total angular momentum. Consider, about a fixed point $bold(a)$,
$
  bold(L) & = sum_i (bold(x_i) - bold(a))times bold(p_i) \
  bold(dot(L)) & = sum_i (bold(x_i) - bold(a)) times bold(dot(p)_i) \
  & = sum_i (bold(x_i)-bold(a)) times (bold(F_i^"ext") + sum_(j != i) bold(F_(i j))) \
  & = underbracket(sum_i (bold(x_i)-bold(a)) times bold(F_i^"ext"), bold(G)) + sum_(i < j) ((bold(x_i)-bold(a)) times bold(F_(i j)) + (bold(x_j)-bold(a)) times bold(F_(j i))) \
  &= bold(G) + sum_(i < j) (bold(x_i) - bold(x_j)) times bold(F_(i j)) \
$

where $bold(G)$ is the total external torque on the system about $bold(a)$. Note that the final term does not vanish in general. However, if the force comes from a potential that depends on the distance from $bold(x_i)$ to $bold(x_j)$ then
$ bold(F_(i j)) &= - bold(nabla)_(bold(x_i)) V(abs(bold(x_i) - bold(x_j)))
&= -V'(abs(bold(x_i) - bold(x_j))) (bold(x_i) - bold(x_j))/abs(bold(x_i) - bold(x_j)), $ so $ (bold(x_i) - bold(x_j)) times bold(F_(i j)) = 0. $

In this case, we have $bold(dot(L)) = bold(G)$, so the total angular momentum is conserved in the absence of external torques.

It is more subtle to prove for other forces such as the Lorentz force, but it can be shown that the total angular momentum is still conserved for all known forces. So,
$
  bold(dot(L)) = bold(G).
$

We often take $bold(a) = bold(R)$, the #ponder("dynamics.centre-of-mass")[centre of mass]. However in general, in a general $bold(R)(t)$, we need to generalise the above definition (refer to Example Sheet 3).

=== Conservation of Energy

We can write
$
  bold(x_i) = bold(R) + bold(y_i)
$
where $bold(y_(i))$ is the position of the $i$-th particle relative to the #ponder("dynamics.centre-of-mass")[centre of mass]. We have
$
  M bold(R) = sum_i m_i bold(x_i) => sum_i m_i bold(y_i) =bold(0).
$
Note that this is true for all time, so
$
  sum_i m_i bold(dot(y)_i) = bold(0).
$
The kinetic energy is
$
  T & = sum_i (1)/(2) m_i bold(dot(x)_i) dot bold(dot(x)_i) \
  & = sum_i (1)/(2) m_i (bold(dot(R))^2 + bold(dot(y)_i)^2 + 2 bold(dot(R)) dot bold(dot(y)_i)) \
  & = underbracket((1)/(2) M bold(dot(R))^2, "CoM Kinetic Energy") + underbracket(sum_i (1)/(2) m_i bold(dot(y)_i)^2, "internal kinetic energy"). #<eq-232> \
$

To have a #ponder("dynamics.conservation-of-energy")[conserved total energy], all forces must be #ponder("dynamics.conservative-force")[conservative]:
$
  bold(F_i^"ext") & = - bold(nabla)_i V_i (bold(x_i)) \
    bold(F_(i j)) & = - bold(nabla)_i V_(i j) (abs(bold(x_i) - bold(x_j))).
$

To obey #ponder("dynamics.newtons-third-law")[N3], we must have $V_(i j) = V_(j i)$. Hence one can show that
$
  E = T + sum_i V_i (bold(x_i)) + sum_(i<j) V_(i j) (abs(bold(x_i)-bold(x_j)) )
$
is a #ponder("dynamics.conservation-of-energy")[conserved quantity], _i.e._ $dot(E) = 0$. To check this,
$
  dot(E) &= sum_i m_i bold(dot(x)_i) dot bold(dot.double(x)_i) + sum_i bold(nabla)_i V_i dot bold(dot(x)_i) + sum_(i < j)[bold(nabla)_i V_(i j) dot bold(dot(x)_i) + bold(nabla)_j V_(i j) dot bold(dot(x)_j)] \
  & = sum_i m_i bold(dot(x)_i) dot bold(dot.double(x)_i) - sum_i bold(F_i^"ext") dot bold(dot(x)_i) - sum_(i < j) [bold(F_(i j)) dot bold(dot(x)_i) + bold(F_(j i)) dot bold(dot(x)_j)] \
  & = sum_i bold(dot(x)_i) dot (m_i bold(dot.double(x)_i) - bold(F_i^"ext") - sum_(j != i) bold(F_(i j))) \
  & = 0.
$

#lecture-separator(lecture: 10, date: "2026-02-14")

== The Two Body Problem

An important special case is the two body problem, where there are two particles with no external forces (_e.g._ the Earth and the Moon). We can reduce this to a single particle problem by working in terms of relative separation. Let $bold(r) = bold(x_1) - bold(x_2)$ be the relative separation.

The #ponder("dynamics.centre-of-mass")[centre of mass] is given by
$
  M bold(R) = m_1 bold(x_1) + m_2 bold(x_2).
$
So we have
$
  bold(x_1) & = bold(R) + (m_2)/(M) bold(r) \
  bold(x_2) & = bold(R) - (m_1)/(M) bold(r)
$

By @eq-232, the kinetic energy is
$
  T & = (1)/(2) M bold(dot(R))^2 + (1)/(2) m_1 (m_2^2)/(M^2) bold(dot(r))^2 + (1)/(2) m_2 (m_1^2)/(M^2) bold(dot(r))^2 \
    & = (1)/(2) M bold(dot(R))^2 + (1)/(2) mu bold(dot(r))^2 \
$
where
$
  mu = (m_1 m_2)/(m_1 + m_2)
$
is called the *reduced mass*.

Note that
$
  mu bold(dot.double(r)) & = mu (bold(dot.double(x)_1) - bold(dot.double(x)_2)) \
                         & = mu (bold(F_(12))/m_1 - bold(F_(21))/m_2) \
                         & = mu ((1)/(m_1) + (1)/(m_2)) bold(F_(12)) quad "since" bold(F_(12)) = bold(F_(21)) \
                         & = bold(F_(12)) \
$

Therefore, relative separation also behaves like a single particle problem, and we can use methods already developed.

If one mass is much larger than the other, say $m_1 >> m_2$, then $mu approx (m_1 m_2)/(m_1 + m_2) approx m_2.$ _i.e._ in this limit, heavy object is essentially still and the lighter object moves around it.

In general, for $N > 2$, we cannot solve the problem analytically. However, if $N >> 1$, we can use statistical physics to make progress (see Part II).

== Rocket Equation and Variable Mass

The relation $bold(dot(P)) = bold(F^"ext")$ is useful when the internal forces are complicated. For example, consider a rocket that ejects fuel with speed $u$ relative to the rocket.

#align(center)[
  #dynamic-svg("/part-ia/dynamics-and-relativity/media/d1e23.svg", width: 24em)
]

We shall work in the $z$-axis, since the rocket moves in a straight line.

The process of ejection can be complicated, but the total momentum must obey
$
  dot(P) = (P(t + delta t) - P(t))/(delta t) = F^"ext".
$

Let $v(t)$ be the speed of the rocket at time $t$. We have
$
  P(t) & = m(t) v(t) \
  P(t + delta t) & = underbracket(m(t+delta t) v(t+ delta t), "rocket") + underbracket((m(t) - m(t + delta t)) (v(t) - u), "fuel") \
  &= m(t) v(t) + [m'(t) v(t) + m(t) v'(t)] delta t - m'(t) (v(t) - u) delta t \
$
Hence
$
     & P(t + delta t) - P(t) = (m dot(v) + u dot(m)) delta t \
  => & m dot(v) + u dot(m) = F^"ext".
$
This is called the Tsiolkovsky rocket equation. We can also write this as
$
m dot(v) = F^"ext" - u dot(m).
$
where $-u dot(m)$ is the thrust force, coming from #ponder("dynamics.newtons-third-law")[N3].
