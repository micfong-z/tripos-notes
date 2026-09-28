#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Principle of Least Action (Hamilton's Principle)

Consider a system of $N$ particles in 3D. The positions $vb(x)_1, ..., vb(x)_N$ of the particles correspond to a single point $vecrow(vb(x)_1, ..., vb(x)_N)$ in a $3N$-dimensional *configuration space*. It is sometimes useful to use non-Cartesian coordinates, such that
$
  vb(q) = (vb(q)_1, ..., vb(q)_N) "for this space".
$
There is a simple way to determine the equations of motion if we know kinetic energy $T$ and the potential energy $V$ in terms of $vb(q)(t)$ and $dot(vb(q))(t)$, as follows.

#definition[Lagrangian][
  The *Lagrangian* of a system is defined as
  $
    L(vb(q), dot(vb(q)), t) := T(vb(q), dot(vb(q)), t) - V(vb(q), dot(vb(q)), t).
  $
] <def-lagrangian>

#definition[Action][
  The *action* of a path $vb(q)(t)$ in configuration space between $vb(q)_A = vb(q)(t_A)$ and $vb(q)_B = vb(q)(t_B)$ is defined as
  $
    I[vb(q)] := integral_(t_A)^(t_B) L(vb(q)(t), dot(vb(q))(t), t) dif t.
  $
  #fade[[The dimensions of $I$ is $dimrm(M) dimrm(L)^2 dimrm(T)^(-1)$, same as for $hbar$ in quantum mechanics.]]
] <def-action>

#law[Principle of Least Action (Hamilton's Principle)][
  The actual path from $vb(q)_A$ to $vb(q)_B$ of the system extremises the action $I[vb(q)]$.
] <principle-of-least-action>

Since $vb(q)_A$ and $vb(q)_B$ are fixed, the boundary term in $delta I$ vanishes, and hence the actual path must satisfy the Euler-Lagrange equations
$
  pdv(L, q_i) - dv(, t) pdv(L, dot(q)_i) = 0, quad i = 1, ..., 3N.
$

#example[
  Take $N=1$ and $vb(q) = vb(x)$ #fade[[in Cartesian coordinates]]. Then $T = (1)/(2) m (dot(vb(x)))^2$ and assume $V = V(vb(x), t)$. So
  $
    L & = (1)/(2) m (dot(vb(x)))^2 - V(vb(x), t) \
  $
  By the Euler-Lagrange equation, we have
  $
    - pdv(V, x_i) - dv(, t) (m dot(x)_i) = 0 quad <=> quad m dot.double(vb(x)) = - grad V.
  $
  This is Newton's second law for a conservative force $vb(F) = - grad V$.
]

#proposition[
  If $L$ has no explicit $t$-dependence, then there exists a first integral
  $
    L - sum_(i=1)^(3N) pdv(L, dot(q)_i) dot(q)_i = - E = "constant"
  $
  for any solution of the Euler-Lagrange equations.
] <prop-L-without-t-first-integral>

#proof[
  $
    dv(L, t) & = dv(, t) L(vb(q)(t), dot(vb(q))(t), t) \
    & = pdv(L, t) + sum_(i=1)^(3N) (pdv(L, q_i) dot(q)_i + pdv(L, dot(q)_i) dot.double(q)_i) \
    & = pdv(L, t) + sum_(i=1)^(3N) dot(q)_i underbracket((pdv(L, q_i) - dv(, t) pdv(L, dot(q)_i)), = 0 "by Euler-Lagrange") + dv(, t) sum_(i=1)^(3N) dot(q)_i pdv(L, dot(q)_i) \
  $
  Hence
  $
    dv(, t) (L - sum_(i=1)^(3N) pdv(L, dot(q)_i) dot(q)_i) = pdv(L, t) = 0 "by assumption".
  $
]
#example[
  If $V = V(vb(x))$ as above,
  $
    -E = (1)/(2) m (dot(vb(x)))^2 - V(vb(x)) - m (dot(vb(x)))^2 = - (1)/(2) m (dot(vb(x)))^2 - V(vb(x)) = -(T+V).
  $
  Hence $E$ is the *total energy* of the system, which is conserved.
]

#lecture-separator(lecture: 8, date: "2026-05-18")

== Central force field

Consider a particle in 2D, using polar coordinates $vb(q) = (r, phi)$ where $vb(x) = vec(r cos(phi), r sin(phi))$. So the kinetic energy is
$
  T = (1)/(2) m (dot(r)^2 +r^2 dot(phi)^2).
$
Assuming $V = V(r)$, then
$
  L = (1)/(2) m (dot(r)^2 +r^2 dot(phi)^2) - V(r).
$
The Euler-Lagrange equation for $phi(t)$ gives
$
  pdv(L, phi) - dv(, t) pdv(L, dot(phi)) = 0 - dv(, t) (m r^2 dot(phi)) & = 0 \
                                                         m r^2 dot(phi) & = "constant" =: m h.
$
where $h$ is the *angular momentum per unit mass*.

Moreover, since $L$ has no explicit $t$-dependence, we have a first integral
$
  E & = dot(r) pdv(L, dot(r)) + dot(phi) pdv(L, dot(phi)) - L \
    & = (1)/(2) m (dot(r)^2 + r^2 dot(phi)^2) + V(r).
$
Hence the total energy $E$ is conserved. #fade[[Hence we can use this instead of working out the Euler-Lagrange equation for $r(t)$.]]

We can eliminate $dot(phi)$ to get
$
  1/2 m dot(r)^2 + V_"eff" (r) = E
$
where $V_"eff" (r) = V(r) + (m h^2)/(2 r^2) + V(r)$ is the *effective potential*.

== The Hamiltonian and Hamilton's equations

Assume that $L(vb(q), dot(vb(q)), t)$ is convex as a function of $dot(vb(q))$. Hence the Legendre transform of $L$ w.r.t. $dot(vb(q))$ exists, and can be used to define the *Hamiltonian*.

#definition[Hamiltonian][
  The *Hamiltonian* of a system is defined as
  $
    H(vb(q), vb(p), t) := sup_(dot(vb(q))) [vb(p) dot dot(vb(q)) - L(vb(q), dot(vb(q)), t)].\
  $
  which is the Legendre transform of $L$ w.r.t. $dot(vb(q))$.
] <def-hamiltonian>

Since $L$ is convex is $dot(vb(q))$, the supremum is attained at $dot(vb(q)) = dot(vb(q))(vb(q), vb(p), t)$ such that

#set math.equation(numbering: "(1)")
$
  H(vb(q), vb(p), t) &= vb(p) dot dot(vb(q))(vb(q), vb(p), t) - L(vb(q), dot(vb(q))(vb(q), vb(p), t), t)\
  pdv(, dot(q)_i) [vb(p) dot dot(vb(q)) - L(vb(q), dot(vb(q)), t)] & = 0 quad forall i = 1, ..., 3N \
  p_i & = pdv(L, dot(q)_i).
$<eq-8-3>
#set math.equation(numbering: none)

#example[
  Consider $N=1$ with $vb(q) = vb(x)$ #fade[[in Cartesian coordinates]] and $L = (1)/(2) m (dot(vb(x)))^2 - V(vb(x), t)$. Then @eq-8-3 gives
  $
    p_i = pdv(L, dot(x)_i) = m dot(x)_i.
  $
  Hence, $vb(p)$ is the *momentum* of the particle. Therefore,
  $
    H = vb(p) dot vb(p)/m - (vb(p)^(2)/(2 m) - V) = vb(p)^(2)/(2 m) + V(vb(x), t).
  $
  which is the *total energy* of the particle.
]

#example[
  Consider $N = 1$ in 2D with a central force. Then $L = (1)/(2) m (dot(r)^2 + r^2 dot(phi)^2) - V(r)$, and $vb(q) = (r, phi)$. From @eq-8-3, we have
  $
    p_r = pdv(L, dot(r)) = m dot(r), quad p_phi = pdv(L, dot(phi)) = m r^2 dot(phi).
  $
  Thus
  $
    dot(r) = p_r / m, quad dot(phi) = p_phi / (m r^2).
  $
  Hence the Hamiltonian is
  $
    H & = p_r dot(r) + p_phi dot(phi) - L \
      & = p_r^2 / (2 m) + p_phi^2 / (2 m r^2) + V(r).
  $
  This coincides with the total energy of the particle again.
]

#remark[
  In general, $p_i$ is called the *conjugate momentum* to $q_i$. $H$ is the total energy $sum_i dot(q)_i pdv(L, dot(q)_i) - L$ with $dot(vb(q))$ eliminated in favour of $vb(q), vb(p), t$ using @eq-8-3. Therefore, $H$ is conserved if $L$ has no explicit $t$-dependence.
]

We can write equations of motion in terms of $H$:
$
  (pdv(H, p_i))_vb(q) & = dot(q)_i + sum_j p_j pdv(dot(q)_j, p_i)- sum_j pdv(L, dot(q)_j) pdv(dot(q)_j, p_i) \
  & = dot(q)_i quad &"by" #ref(<eq-8-3>) \
  (pdv(H, q_i))_vb(p) & = sum_j p_j pdv(dot(q)_j, q_i) - pdv(L, q_i) - sum_j pdv(L, dot(q)_j) pdv(dot(q)_j, q_i) \
  & = - pdv(L, q_i) quad &"by" #ref(<eq-8-3>) \
  &= - dv(, t) pdv(L, dot(q)_i) quad &"by Euler-Lagrange" \
  &= - dot(p)_i quad &"by" #ref(<eq-8-3>)
$

Hence the Euler-Lagrange equations imply the *Hamilton's equations*

#theorem[Hamilton's Equations][
  The equations of motion of a system can be written as
  $
    dot(q)_i = (pdv(H, p_i))_vb(q), quad dot(p)_i = - (pdv(H, q_i))_vb(p), quad i = 1, ..., 3N.
  $
] <thm-hamiltons-equations>

#remark[
  The Euler-Lagrange equations are 2nd order ODEs in $3N$-dimensional configuration space with coordinates $vb(q)$, while Hamilton's equations are 1st order ODEs in $6N$-dimensional phase space with coordinates $(vb(q), vb(p))$.
]

One can also derive Hamilton's equations as the Euler-Lagrange equations of the action,
$
  I[vb(q), vb(p)] = integral_(t_A)^(t_B) (vb(p) dot dot(vb(q)) - H(vb(q), vb(p), t)) dif t
$
for fixed $vb(q)(t_A)$ and $vb(q)(t_B)$.

#remark[
  Note that
  $
    dv(H, t) & = dv(, t) (H(vb(q)(t), vb(p)(t), t)) = sum_i (pdv(H, q_i) dot(q)_i + pdv(H, p_i) dot(p)_i)+pdv(H, t) \
             & = pdv(H, t) quad "by" #ref(<thm-hamiltons-equations>).
  $
  Hence if $H$ has no explicit $t$-dependence, then $H$ is constant for any solution of Hamilton's equations.
]
