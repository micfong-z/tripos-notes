#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Symmetries and Noether's Theorem

We wish to connect
$
  "continuous symmetries of the action " <-> " first integrals of the Euler-Lagrange equations"
$

Consider a smooth map $vb(Q): RR^(6N+1) -> RR^(3N)$. Given a curve $vb(q)(t)$, define

#set math.equation(numbering: "(1)")
$
  vb(q)^*(t) = vb(Q)(vb(q)(t), dot(vb(q))(t), t).
$ <eq-9-1>
#set math.equation(numbering: none)

#definition[Symmetry of the Action, Version 1][
  We say $vb(Q)$ is a *symmetry of the action* iff for all curves $vb(q)(t)$ and for all $t_A$, $t_B$, we have
  $
    integral_(t_A)^(t_B) L(vb(q)^*(t), dot(vb(q))^*(t), t) dif t = integral_(t_A)^(t_B) L(vb(q)(t), dot(vb(q))(t), t) dif t
  $
] <def-symmetry-of-action-v1>

Now consider a *one-parameter family* of such maps
$
  vb(Q)(vb(q), dot(vb(q)), t; s): RR^(6N+1) times RR -> RR^(3N)
$
where
$
  vb(Q)(vb(q), dot(vb(q)), t; 0) = vb(q).
$
#fade[[_i.e._ $s=0$ is the identity transform.]]

For small $s$, we can Taylor expand to give
#set math.equation(numbering: "(1)")
$
  vb(q)^* = vb(q) + s eval(pdv(vb(Q), s))_(s=0) + Order(s^2)
$ <eq-9-3>
#set math.equation(numbering: none)

#theorem[Noether's Theorem, Version 1][
  If there exists a one-parameter family of symmetry of symmetries of the action $vb(Q)(vb(q), dot(vb(q)), t; s)$, then any solution of the Euler-Lagrange equations has a conserved quantity (_i.e._ a first integral)
  $
    sum_(i=1)^(3N) pdv(L, dot(q)_i) (eval(pdv(Q_i, s))_(s=0)) = "constant".
  $

] <thm-noether-v1>

#proof[
  For small $s$, substitute @eq-9-3 into @def-symmetry-of-action-v1:
  $
    0 &= integral_(t_A)^(t_B) [L(vb(q)(t) + s eval(pdv(vb(Q), s))_(s=0) + Order(s^2), dot(vb(q))(t) + s dv(, t) eval(pdv(vb(Q), s))_(s=0) + Order(s^2), t) - L(vb(q)(t), dot(vb(q))(t), t)] dif t\
    &= integral_(t_A)^(t_B) [s eval(pdv(Q_i, s))_(s=0) pdv(L, q_i) + s dv(, t) (eval(pdv(Q_i, s))_(s=0) pdv(L, dot(q)_i)) + Order(s^2)] dif t quad ("with summation convention")\
    &= integral_(t_A)^(t_B) [s eval(pdv(Q_i, s))_(s=0) underbracket((pdv(L, q_i) - dv(, t) pdv(L, dot(q)_i)), =0 "by Euler-Lagrange") + s dv(, t) (eval(pdv(Q_i, s))_(s=0) pdv(L, dot(q)_i)) + Order(s^2)] dif t quad ("by integration by parts")\
    &= [s eval(pdv(Q_i, s))_(s=0) pdv(L, dot(q)_i)]_(t_A)^(t_B) + Order(s^2).
  $
  Hence $eval(pdv(Q_i, s))_(s=0) pdv(L, dot(q)_i)$ takes the same value at $t_A$ and $t_B$. Since $t_A$ and $t_B$ are arbitrary, this quantity is constant in time.

]

#example[
  If $L$ doesn't depend on $q_1$ (say). Then consider
  $
    vb(Q) = (q_1 + s, q_2, ..., q_(3N)).
  $
  Hence $q^*_1 = q_1 + s, q^*_i = q_i$ for $i = 2, ..., 3N$, and $dot(q)^*_i = dot(q)_i$ for $i = 2, ..., 3N$. Thus this is a symmetry of the action since $L$ is independent of $q_1$.

  The conserved quantity is
  $
    eval(pdv(Q_i, s))_(s=0) pdv(L, dot(q)_i) = pdv(L, dot(q)_1) = "constant" = p_1.
  $

  This means that the momentum conjugate to $q_1$ is conserved.
]

#lecture-separator(lecture: 9, date: "2026-05-20")

#example[
  Consider Cartesian coordinates $vb(q) = (vb(x)_1, ..., vb(x)_N)$. Assume $L$ depends on $vb(x)_i$ only via $vb(x)_i - vb(x)_j$ #fade[[the lagrangian is only dependent on the separation between particles]].

  Let $vb(Q) = vecrow(vb(x)_1 + s vb(a), ..., vb(x)_N + s vb(a))$ for some constant $vb(a)$, _i.e._ $vb(Q)$ is a spatial translation by $s vb(a)$.

  Therefore, $vb(x)^*_i - vb(x)^*_j = vb(x)_i - vb(x)_j$. In particular,
  $
    L(vb(q)^*, dot(vb(q))^*, t) = L(vb(q), dot(vb(q)), t).
  $
  Hence @def-symmetry-of-action-v1 is satisfied, and $vb(Q)$ is a symmetry of the action. Therefore we have a conserved quantity given by @thm-noether-v1:
  $
    sum_i pdv(L, dot(q)_i) (eval(pdv(Q_i, s))_(s=0)) = vb(a) dot sum_i pdv(L, dot(vb(x))_i) = vb(a) dot sum_i vb(p)_i = vb(a) dot vb(P)
  $
  where $vb(P)$ is the total momentum of the system. Since $vb(a)$ is arbitrary, we conclude that $vb(P)$ is conserved.

  In other words, the invariance of physical laws under spatial translations implies the conservation of momentum.
]

#example[
  Consider Cartesian coordinates $vb(q) = (vb(x)_1, ..., vb(x)_N)$. Consider a rotation $matbold(R)$ maps
  $
    vb(q) |-> vb(q)_matbold(R) = vecrow(matbold(R) vb(x)_1, ..., matbold(R) vb(x)_N).
  $
  Assume that $L$ is invariant under rotations, _i.e._ $L(vb(q)_matbold(R), dot(vb(q))_matbold(R), t) = L(vb(q), dot(vb(q)), t)$ for all $matbold(R) in "SO"(3)$.

  Take $vb(Q) = vb(q)_(matbold(R)(s))$ where $matbold(R)(s)$ is a rotation through angle $s$ about some axes $vu(n)$.

  For infinitesimal $s$, $matbold(R)(s) vb(x) = vb(x) + s vu(n)times vb(x)$. Thus,
  $
    eval(pdv(vb(Q), s))_(s=0) = vecrow(vu(n)times vb(x)_1, ..., vu(n)times vb(x)_N).
  $
  Since $vb(Q)$ is a symmetry of the action, we have a conserved quantity given by @thm-noether-v1:
  $
    sum_(i, a) pdv(L, (dot(x)_i)_a) (vu(n)times vb(x)_i)_a = sum_i vb(p)_i dot (vu(n)times vb(x)_i) = vu(n) dot sum_i vb(x)_i times vb(p)_i = vu(n) dot vb(L)
  $
  where $vb(L)$ is the total angular momentum of the system. Since $vu(n)$ is arbitrary, we conclude that $vb(L)$ is conserved.

  In other words, the invariance of physical laws under rotations implies the conservation of angular momentum.
]

#corollary[Generalised Noether's Theorem, Version 1][

  We can generalise the definition of 1-parameter family of symmetries of action to allow for a boundary term:
  #set math.equation(numbering: "(1)")
  $
    integral_(t_A)^(t_B) L(vb(q)^*(t), dot(vb(q))^*(t), t) dif t = integral_(t_A)^(t_B) L(vb(q)(t), dot(vb(q))(t), t) dif t + [s K(vb(q)(t), dot(vb(q))(t), t)]_(t_A)^(t_B)
  $ <eq-9-4>
  #set math.equation(numbering: none)
  for small $s$ and some function $K$.

  The conserved quantity is then given by
  $
    sum_i pdv(L, dot(q)_i) (eval(pdv(Q_i, s))_(s=0)) - K.
  $

] <cor-noether-v1>

#example[
  Consider
  $
    L = sum_(i=1)^N (1)/(2) m_i (dot(x)_i)^2 -V(vb(x)_1, ..., vb(x)_N)
  $
  where $V$ depends only on separations $vb(x)_i - vb(x)_j$.

  Consider a Galilean boost where $vb(x)^* = vb(x) - vb(v) t$. Let $vb(v) = vu(n) s$. Then
  $
    vb(Q) = vecrow(vb(x)_1 - vu(n) s t, ..., vb(x)_N - vu(n) s t), quad vb(x)^*_i = vb(x)_i - vu(n) s t, quad dot(vb(x))^*_i = dot(vb(x))_i - vu(n) s.
  $

  Hence the Lagrangian is
  $
    L(vb(q)^*, dot(vb(q))^*, t)&= sum_i (1)/(2) m_i (dot(vb(x))_i - vu(n) s)^2 - V(vb(x)_1^*, ..., vb(x)_N^*)\
    & = sum_i (1)/(2) m_i (dot(vb(x))_i)^2 - V(vb(x)_1, ..., vb(x)_N) + s vu(n) dot sum_i m_i dot(vb(x))_i + Order(s^2)\
    &= L(vb(x), dot(vb(x)), t) - dv(, t) (s vu(n) dot sum_i m_i vb(x)_i)
  $
  Hence @eq-9-4 is satisfied with $K = - vu(n) dot sum_i m_i vb(x)_i = vu(n) dot (M vb(R))$, where $M$ is the total mass and $vb(R)$ is the centre of mass. Therefore, the conserved quantity is
  $
    sum_i pdv(L, dot(vb(x))_i) (eval(pdv(Q_i, s))_(s=0)) - K & = sum_i vb(p)_i dot (-vu(n) t) + M vu(n) dot vb(R) \
                                                             & = vu(n) dot (M vb(R) - vb(P) t)
  $
  Since $vu(n)$ is arbitrary, we conclude that $M vb(R) - vb(P) t$ is conserved.
]

We shall now consider a different type of symmetry of the action, which concerns transformation of the time coordinate: $t^* = T(t)$ for some invertible $T$. Let
$
  vb(q)^*(t^*) = vb(q)(t) = vb(q)(T^(-1)(t^*)).
$
#definition[Symmetry of the Action, Version 2][
  We say $T$ is a *symmetry of the action* iff for all curves $vb(q)(t)$ and for all $t_A$, $t_B$, we have
  $
    integral_(t_A^*)^(t_B^*) L(vb(q)^*(t^*), dv(vb(q)^*, t^*)(t^*), t^*) dif t^* = integral_(t_A)^(t_B) L(vb(q)(t), dot(vb(q))(t), t) dif t
  $
] <def-symmetry-of-action-v2>

Consider a 1-parameter family $T(t; s)$ with $T(t;0)=t$. Then
$
  t^* = t + s eval(pdv(T, s))_(s=0) + Order(s^2).
$

#theorem[Noether's Theorem, Version 2][
  If there exists a one-parameter family of symmetry of symmetries of the action $T(t; s)$, then any solution of the Euler-Lagrange equations has a conserved quantity (_i.e._ a first integral)
  $
    (L - sum_(i) dot(q)_i pdv(L, dot(q)_i)) eval(pdv(T, s))_(s=0) = "constant".
  $

] <thm-noether-v2>

#proof[
  We have
  $
    dv(t^*, t) = 1 + s dv(, t) eval(pdv(T, s))_(s=0) + Order(s^2).
  $
  Let $I, I^*$ be the LHS and RHS of @def-symmetry-of-action-v2 respectively. Then changing variable of integration from $t^*$ to $t$ in $I^*$ gives
  $
    I^* & = integral_(t_A)^(t_B) L(vb(q)(t), dv(t, t^*), dv(, t) vb(q)(t), T(t)) dv(t^*, t) dif t \
  $
  By binomial theorem we have
  $
    dv(t, t^*) = (dv(t^*, t))^(-1) = 1 - s dv(, t) eval(pdv(T, s))_(s=0) + Order(s^2).
  $
  Therefore,
  $
    I^* &= integral_(t_A)^(t_B) L(vb(q)(t), dot(vb(q))(t) - s dv(, t) eval(pdv(T, s))_(s=0) dot(vb(q))(t) + Order(s^2), t + s eval(pdv(T, s))_(s=0) + Order(s^2)) (1 + s dv(, t) eval(pdv(T, s))_(s=0) + Order(s^2)) dif t\
    &= integral_(t_A)^(t_B) [L(vb(q)(t), dot(vb(q))(t), t) - s dv(, t) eval(pdv(T, s))_(s=0) dot(q)_i pdv(L, dot(q)_i) + s eval(pdv(T, s))_(s=0) dv(L, t) + s L dv(, t) eval(pdv(T, s))_(s=0) + Order(s^2)] dif t\
    &= I + integral_(t_A)^(t_B) [underbracket(dv(, t) eval(pdv(T, s))_(s=0) (-s dot(q)_i pdv(L, dot(q)_i) + s L), "integrate by parts") + s eval(pdv(T, s))_(s=0) pdv(L, t)] dif t\
    &= I + [s eval(pdv(T, s))_(s=0) (L - sum_i dot(q)_i pdv(L, dot(q)_i))]_(t_A)^(t_B) + integral_(t_A)^(t_B) s eval(pdv(T, s))_(s=0) underbracket([- dv(, t) (L - dot(q)_i pdv(L, dot(q)_i)) + pdv(L, t)], = 0 "by E-L") dif t\
  $
  So $I^* = I$ implies $[s eval(pdv(T, s))_(s=0) (L - sum_i dot(q)_i pdv(L, dot(q)_i))]_(t_A)^(t_B) = 0$ for all $t_A, t_B$. Hence $eval(pdv(T, s))_(s=0) (L - sum_i dot(q)_i pdv(L, dot(q)_i))$ is constant in time.


]

#example[
  Assume that $L$ has no explicit $t$-dependence, so $L = L(vb(q), dot(vb(q)))$. Set $T(t; s) = t + s$, giving $t^* = t + s$.

  Let $vb(q)^*(t^*) = vb(q)(t) = vb(q)(t^* - s)$. Therefore $dv(vb(q)^*, t) = dot(vb(q))(t^* - s)$. Therefore,
  $
    integral_(t_A^*)^(t_B^*) L(vb(q)^*(t^*), dv(vb(q)^*, t^*)(t^*)) dif t^* &= integral_(t_A + s)^(t_B + s) L(vb(q)(t^*-s), dot(vb(q))(t^*-s)) dif t^*\
    &= integral_(t_A)^(t_B) L(vb(q)(t), dot(vb(q))(t)) dif t.
  $
  Therefore $T$ is indeed a symmetry of the action. By @thm-noether-v2, we have a conserved quantity
  $
    (L - sum_i dot(q)_i pdv(L, dot(q)_i)) eval(pdv(T, s))_(s=0) = L - sum_i dot(q)_i pdv(L, dot(q)_i) = "constant" =: -E.
  $
  Note that we recover @prop-L-without-t-first-integral. In other words, the invariance of physical laws under time translations implies the conservation of energy.
]
