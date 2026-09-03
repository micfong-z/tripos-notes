#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Legendre Transform

#definition[Legendre Transform][
  The Legendre transform of $f: D(f) subset.eq RR^n -> RR$ is
  $
    f^*(vb(p)) := sup_(vb(x)) [vb(p) dot vb(x) - f(vb(x))]
  $
  with $D(f^*) = {vb(p) in RR^n: "RHS" < oo}$.
]

#proposition[
  $f^*$ is convex.
]

#proof[
  Let $vb(p), vb(q) in D(f^*)$, and $t in (0, 1)$. Then
  $
    sup_(vb(x)) {[(1-t) vb(p) + t vb(q)] dot vb(x) - f(vb(x))} &= sup_vb(x) {(1-t) [vb(p) dot vb(x) - f(vb(x))] + t [vb(q) dot vb(x) - f(vb(x))]} \
    &<= (1-t) sup_vb(x) [vb(p) dot vb(x) - f(vb(x))] + t sup_vb(x) [vb(q) dot vb(x) - f(vb(x))]. \
  $

  Note that RHS is finite, so LHS is also finite. Thus $(1-t) vb(p) + t vb(q) in D(f^*)$.

  Hence $D(f^*)$ is convex and
  $
    f^*((1-t) vb(p) + t vb(q)) <= (1-t) f^*(vb(p)) + t f^*(vb(q)).
  $

]

#proposition[
  If $f$ is convex, then so is $F_(vb(p))(x): f(vb(x)) - vb(p) dot vb(x)$.
]

#proof[
  We have $D(F_vb(p)) = D(f)$. Moreover,
  $
    F_vb(p)((1-t) vb(x) + t vb(y)) & = f((1-t) vb(x) + t vb(y)) - vb(p) dot [(1-t) vb(x) + t vb(y)] \
                                   & <= (1-t) f(vb(x)) + t f(vb(y)) - vb(p) dot [(1-t) vb(x) + t vb(y)] \
                                   & = (1-t) F_vb(p)(vb(x)) + t F_vb(p)(vb(y)).
  $
  Thus $F_vb(p)$ is convex.
]

#corollary[
  If $f$ is convex and differentiable at any stationary point, then $vb(p) dot vb(x) - f(vb(x))$ is a global maximum occuring at $vb(x)(vb(p))$ given by solving
  $
    grad f(vb(x)) = vb(p).
  $
  Then, the Legendre transform of $f$ is given by
  $
    f^*(vb(p)) = vb(p) dot vb(x)(vb(p)) - f(vb(x)(vb(p))).
  $


] <cor-legendre-transform-eq-3-1>

#lecture-separator(lecture: 4, date: "2026-05-06")

#proposition[
  If $f$ is strictly convex then the solution of @cor-legendre-transform-eq-3-1 is unique.
]

#example[
  For $n=1$,

  1. $f(x) = (1)/(2) a x^2$ with $a > 0$ is strictly convex. @cor-legendre-transform-eq-3-1 has a unique solution $x(p) = p/a$, and
    $
      f^*(p) = p x(p) - f(x(p)) = p^2/(2a) quad "with" quad D(f^*) = RR.
    $

  2. $f(v) = -sqrt(1-v^2)$ with $D(f) = (-1, 1)$ is strictly convex. @cor-legendre-transform-eq-3-1 has a unique solution $v(p) = p/sqrt(1+p^2)$, and
    $
      f^*(p) = p v(p) - f(v(p)) = sqrt(1+p^2) quad "with" quad D(f^*) = RR.
    $

  3. $f = c x$ with $c > 0$ is convex but not strictly convex. @cor-legendre-transform-eq-3-1 has no solution for $p < c$, and infinitely many solutions for $p = c$. Thus
    $
      f^*(p) = 0 quad "with" D(f^*) = {c}.
    $
]

#theorem[
  If $f$ is convex and $C^2$ then $f^(* *) = f$.
]

#proof[
  To determine $f^(* *)$, we need to find $f(vb(x))$ obeying $grad f^*(f(vb(x)))=vb(x)$. With $vb(x)(vb(p))$ given by @cor-legendre-transform-eq-3-1, we have
  $
    grad f^*(vb(p)) & = vb(p) dot vb(x)(vb(p)) - f(vb(x)(vb(p))) \
    (∂ f^*)/(∂ p_i) & = x_i + p_j (∂ x_j)/(∂ p_i) - eval((∂f)/(∂ x_j))_(vb(x) = vb(x)(vb(p))) (∂ x_j)/(∂ p_i) \
                    & = x_i + (p_j - eval(nabla_j f)_(vb(x) = vb(x)(vb(p)))) (∂ x_j)/(∂ p_i) \
                    & = x_i.
  $
  Therefore $grad f^*(vb(p)) = vb(x)(vb(p))$. Hence $vb(x)(vb(p)(vb(x))) = vb(x)$ #fade[[$f(vb(x))$ is the inverse of $vb(x)(vb(p))$]]. Thus,
  $
    f^(* *)(vb(x)) & = vb(x) dot vb(p) (vb(x)) - f^* (f(vb(x))) \
                   & = vb(x) dot vb(p) (vb(x)) - [vb(p)(vb(x)) dot vb(x) - f(vb(x(vb(p)(vb(x)))))] \
                   & = f(vb(x)).
  $

]

#remark[
  Convexity of $f$ is necessary as $f^(* *)$ is the Legendre transform of $f^*$. Hence, convex $C^2$ functions can be weakened significantly.
]

#example[
  With $f(x) = c x$ above, we have
  $
    f^(* *)(x) = sup_(p in {c}) (x p - f^* (p)) = c x = f(x).
  $
]

== Legendre Transform in Thermodynamics

#set math.equation(numbering: "(1)")

Consider a system made of many molecules, say $10^23$. In *thermal equilibrium*, the macroscopic properties #fade[[involving only length scales $>>$ separation of molecules]] are described by just a few quantities: total energy $E$, volume $V$, temperature $T$, pressure $P$, _etc._


An *isolated system* is one that is not interacting with any other system, _e.g._ a gas in a vacuum flas.

In equilibrium, macroscopic physics of such a system is fully specified by $E, V$, but there exists an enormous number of configurations $Omega(E, V)$ of microscopic configurations that looks identical macroscopically (_e.g._ on the order of $10^10^23$.).

The *entropy* of the system is defined as
$
  S(E, V) = k_B log Omega(E, V)
$
where $k_B$ is the Boltzmann constant. The entropy is a measure of the number of microstates corresponding to a given macrostate.

If $E$ increases at a given $V$, then $S$ increases, since there are more ways to partition $E$ among the molecules. Therefore, $S$ is strictly increasing as a function of $E$. Hence, we can invert $S(E, V)$ to get $E(S, V)$.

The *temperature* of a system is defined as
$ T(S, V) = ((∂ E)/(∂ S))_V > 0. $ <eq-3-4a>
The *pressure* of a system is defined as
$ P(S, V) = -((∂ E)/(∂ V))_S. $ <eq-3-4b>

Hence, the fundamental thermodynamic relation is
$
  dif E = T dif S - P dif V.
$ <eq-3-5>

#set math.equation(numbering: none)

Suppose we do not know @eq-3-4a. Consider the Legendre transform of $E(S, V)$ with respect to $S$ with parameter $T$. Call this $-F$. Then
$
  -F(T, V) := sup_S {T S - E(S, V)}.
$

One can show that the stability of equilibrium state implies that $E$ is convex w.r.t. $S$. Hence by @cor-legendre-transform-eq-3-1, the supremum is attained at the unique solution of
$
  T = ((∂ E)/(∂ S))_V.
$

Moreover,
$
  F(T, V) = E - T S
$
is called the *Helmholtz free energy* of the system. @eq-3-5 gives
$
  dif F = -S dif T - P dif V.
$
Therefore,
$
  S = -((∂ F)/(∂ T))_V, quad P = -((∂ F)/(∂ V))_T.
$

#fade[[$F$ is useful when considering a non-isolated system in thermal equilibrium with an environment at a fixed temperature $T$, _e.g._ gas in an uninsulated box.]]

Similarly, if we do not know @eq-3-4b, we can consider the Legendre transform of $E(S, V)$ with respect to $V$ with parameter $-P$. Call this $-H(S, P)$. Then
$
  -H(S, P) = sup_V (-P V - E(S, V)).
$
One can use stability to argue that $E$ is convex w.r.t. $V$. Hence by @cor-legendre-transform-eq-3-1, the supremum is attained at the unique solution of
$ P = -((∂ E)/(∂ V))_S. $
Moreover,
$ H(S, P) = E + P V $
is called the *enthalpy* of the system. @eq-3-5 gives
$ dif H = T dif S + V dif P. $ Therefore,
$ T = ((∂ H)/(∂ S))_P, quad V = ((∂ H)/(∂ P))_S. $
Finally, take the Legendre transform of $E(S, V)$ with respect to both $S$ and $V$ with parameters $T$ and $-P$. Call this $-G(T, P)$. Then
$
  -G(T, P) = sup_(S, V) {T S - P V - E(S, V)}.
$
By stability, $E$ is convex w.r.t. both $S$ and $V$. Hence by @cor-legendre-transform-eq-3-1, the supremum is attained at the unique solution of
$ T = ((∂ E)/(∂ S))_V, quad P = -((∂ E)/(∂ V))_S. $
Moreover,
$ G(T, P) = E - T S + P V $
is called the *Gibbs free energy* of the system. @eq-3-5 gives
$ dif G = -S dif T + V dif P. $ Therefore,
$ S = -((∂ G)/(∂ T))_P, quad V = ((∂ G)/(∂ P))_T. $

$E, F, G, H$ are called the *thermodynamic potentials* of the system.
