#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Constrained Variation of Functionals

To extremise a functional $F[y]$ subject to a functional constraint $P[y] = c$, we can use the method of Lagrange multipliers. We can use a Lagrange multiplier:
$
  Phi_lambda [y] = F[y] - lambda (P[y] - c).
$
#fade[[This is just an infinite-dimensional version of the method of Lagrange multipliers.]]

Extremising
$
    "w.r.t." y(x): & quad & pdv(F, y(x), d: delta) - lambda pdv(P, y(x), d: delta) = 0, \
  "w.r.t." lambda: & quad &                                               P[y] - c = 0.
$

#example[
  Determine $y(x)$ that minimises $integral_0^1 (1)/(2) (y')^2 dif x$ subject to the constraint $integral_0^1 y dif x = 1$, in the class of smooth functions on $[0, 1]$ with $y(0) = y(1) = 0$. We have
  $
    Phi_lambda [y] & = integral_0^1 (1)/(2) (y')^2 dif x - lambda (integral_0^1 y dif x - 1) \
                   & = integral_0^1 ((1)/(2) (y')^2 - lambda y) dif x + lambda.
  $
  Note that we recover the Euler-Lagrange equation with $f = (1)/(2) (y')^2 - lambda y$:
  $
    0 & = pdv(f, y) - dv(, x) pdv(f, y') = -lambda - y'' \
    y & = -(1)/(2) lambda x^2 + A x + B.
  $
  With boundary conditions $y(0) = y(1) = 0$, we have $B = 0$ and $A = (1)/(2) lambda$. The constraint gives
  $
    1 = integral_0^1 y dif x = integral_0^1 (-(1)/(2) lambda x^2 + (1)/(2) lambda x) dif x = (1)/(12) lambda.
  $
  Therefore $lambda = 12$. Our solution can be written as
  $
    y = 6 x (1-x).
  $
]

#example[Dido's problem, Example Sheet 1][
  An example of such problem is to find the maximum area of a plane region bounded by a straight line (wall) and a curve (fence) of fixed length $L$:
  #align(center)[
    #dynamic-svg2("/part-ib/variational-principles/media/d1e2.svg", width: 14em)
  ]
]

#example[Isoperimetric problem, Example Sheet 2][
  Another example is to find the closed curve of given length $L$ that encloses the maximum area. This is known as the *isoperimetric problem*.
]

== Sturm-Liouville Problem <sec-sturm-liouville>


Let
#set math.equation(numbering: "(1)")
$
  cal(C) & = Set(y\: [alpha, beta]-> RR; y "is" C^2 "and" y(alpha) = y(beta) = 0) \
    F[y] & = integral_alpha^beta (rho(x) (y'(x))^2 + sigma(x) (y(x))^2) dif x \
    G[y] & = integral_alpha^beta (w(x) (y(x))^2) dif x.
$ <eq-7-1>
#set math.equation(numbering: none)
where $rho, w > 0$ on $(alpha, beta)$.

The problem is:
$
  & "minimise"   && F[y] \
  & "subject to" && G[y] = 1, quad y in cal(C).
$

#lecture-separator(lecture: 7, date: "2026-05-15")

#notation[
  Recall that
  $
    dv(F[y], y(x), d: delta) = pdv(F, y(x)) - dv(, x) pdv(F, y'(x)).
  $
]

First we extremise
$
  Phi_lambda [y] = F[y] - lambda (G[y] - 1).
$

The boundary conditions in $cal(C)$ ensures that the boundary term in $delta Phi_lambda$ vanishes. Hence we have the Euler-Lagrange equation
$
  dv(F[y], y(x), d: delta) - lambda dv(G[y], y(x), d: delta) = 0
$
where
$
  dv(F[y], y(x), d: delta) = 2 sigma y - dv(, x) (2 rho y') =: 2 cal(L) y
$
where $cal(L)$ is a linear differential operator $cal(L) := - dv(, x)(rho dv(, x)) + sigma$. Moreover,
$
  dv(G[y], y(x), d: delta) = 2 w y.
$
Therefore, the Euler-Lagrange equation can be written as
#set math.equation(numbering: "(1)")
$
  cal(L) y = lambda w y.
$ <eq-7-3>
#set math.equation(numbering: none)

Note that @eq-7-3 with boundary conditions $y(alpha) = y(beta) = 0$ is an eigenvalue problem: only for discrete $lambda$ does there exist a non-trivial solution $y(x)$ #fade[[this is called an eigenfunction]]. This is a Sturm-Liouville problem. #fade[[See IB Methods for more information.]]

$w(x)$ is called the *weight function*.

Note that this problem is linear, so if $y(x)$ is a solution, then $C y(x)$ is also a solution for any constant $C$. The constraint $G[y] = 1$ fixes the normalisation of $y$. #fade[[This is analogous to finding a unit eigenvector.]]

Then
$
  F[y] & = integral_alpha^beta y cal(L) y dif x - underbracket([rho y y']_alpha^beta, = 0) quad "by integration by parts" \
       & = lambda integral_alpha^beta w y^2 dif x \
       & = lambda G[y] = lambda.
$
Hence the solution of our problem is the lowest eigenvalue $lambda$.

#exercise[
  Check that this also works if we change the boundary conditions to $y'(alpha) = y'(beta) = 0$ or $y(alpha) = y'(beta) = 0$ or $y'(alpha) = y(beta) = 0$.
]

Similarly to @ex-4-2, we can consider extremising
$
  Lambda[y] := F[y]/G[y],
$
$
  0 = dv(Lambda[y], y(x), d: delta) = (1)/(G) (dv(F[y], y(x), d: delta) - (F)/(G) dv(G[y], y(x), d: delta)) = (2)/(G)(cal(L) y - Lambda w y).
$

Hence, the minimum value of $Lambda[y]$ is the lowest eigenvalue of the Sturm-Liouville problem.

== Geodesics on a surface and function constraints

Consider a surface $S$ in Euclidean space with equation $g(vb(x)) = 0$. Let $A, B in S$. We wish to find the shortest curve on $S$ that connects $A$ and $B$.

Let $vb(x)(t)$ with $t in [0, 1]$ be a curve on $S$ with $vb(x)(0) = vb(x)_A$ and $vb(x)(1) = vb(x)_B$. We wish to extremise the length functional
$
  L[vb(x)] = integral_0^1 sqrt(dot(vb(x))^2) dif t
$
subject to the constraint given by the surface equation
$
  g(vb(x)(t)) = 0.
$
To do this we use a Lagrange multiplier function $lambda(t)$. Let
$
  Phi[vb(x), lambda] = L[vb(x)] - integral_0^1 lambda(t) g(vb(x)(t)) dif t.
$

Extremising $Phi$,
$
  "w.r.t." lambda & quad & 0 &= dv(Phi, lambda(t), d: delta) = - g(vb(x)(t)) &quad &(*)\
  "w.r.t." x_i (t) & quad & 0 &= dv(Phi, x_i (t), d: delta) = -lambda grad_i g(vb(x)(t)) - dv(, t) (dot(x)_i / sqrt(dot(vb(x))^2)) &quad &(dagger)
$
We can eliminate $lambda$ from $(*)$ and $(dagger)$ by
$
  dv(, t) (*) quad => quad 0 = dot(x)_i ∂_i g quad => quad (dot(x)_i ∂_i g)/(sqrt(dot(vb(x))^2)) = 0.
$
Taking derivatives w.r.t. $t$ again gives
$
  & => dv(, t) (dot(x)_i/(sqrt(dot(vb(x))^2))) ∂_i g + (dot(x)_i dot(x)_j)/(sqrt(dot(vb(x))^2)) ∂_i ∂_j g = 0 \
  & = -lambda (grad g)^2 quad "by" (dagger) \
$
Therefore,
$
  lambda(t) = - (dot(x)_i dot(x)_j)/(sqrt(dot(vb(x))^2) (grad g)^2) ∂_i ∂_j g.
$
Thus,
$
  ((dagger))/(sqrt(vb(dot(x))^2)) "gives" (1)/(sqrt(dot(vb(x))^2) ) dv(, t) (dot(x)_i / sqrt(dot(vb(x))^2)) + (dot(x)_i dot(x)_j)/(sqrt(dot(vb(x))^2) (grad g)^2) ∂_j ∂_k g grad_i g = 0.
$
This is the equation for geodesics on a surface. We need to solve this along with $(*)$. This equation looks nicer if we convert it to use arc length as a parameter (discussed in @sec-5-1), where
$
  dv(, l) = (1)/(sqrt(dot(vb(x))^2) ) dv(, t).
$
So our equation becomes
$
  dv(x_i, l, 2) + (1)/(grad g)^2 dv(x_j, l) dv(x_k, l) ∂_j ∂_k g grad_i g = 0.
$

#example[
  Take $g = z$. Then we are considering the plane $z = 0$. Then $grad g = (0, 0, 1)$ and $∂_j ∂_k g = 0$. Hence our equation reduces to
  $
    dv(x_i, l, 2) = 0.
  $
  Hence we recover a straight line in the plane as expected.
]

