#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= Convex Functions

#definition[Convex Sets][
  A set $S subset.eq RR^n$ is *convex* if $forall vb(x), vb(y) in S$,
  $
    t vb(x) + (1 - t) vb(y) in S quad forall t in [0, 1].
  $
  #fade[[_i.e._ the line segment connecting $vb(x)$ and $vb(y)$ lies entirely in $S$.]]
]

#definition[Convex Functions and Concave Functions][
  Let $f: dom f -> RR$ be a function with domain $dom f subset.eq RR^n$. The *graph* of $f$ is the surface $z = f(vb(x))$ in $RR^(n+1)$ with coordinates $(vb(x), z)$.

  A *chord* of $f$ is a line segment joining 2 points of the graph. Then $f$ is *convex* iff

  #set math.equation(numbering: "(1)")

  1. $dom f$ is convex,

  2. the graph of $f$ lies on or below all chords of $f$, _i.e._
    $
      underbracket(f((1-t)vb(x) + t vb(y)), "(1) ensures this"\ "is well-defined") <= (1-t) f(vb(x)) + t f(vb(y)) quad forall vb(x), vb(y) in dom f, forall t in [0, 1].
    $ <convexity-inequality>

  $f$ is *strictly convex* if the inequality is strict for $vb(x) != vb(y)$ and $t in (0, 1)$, so that @convexity-inequality becomes
  $
    f((1-t)vb(x) + t vb(y)) < (1-t) f(vb(x)) + t f(vb(y)) quad forall vb(x), vb(y) in dom f, forall t in (0, 1).
  $ <strict-convexity-inequality>

  $f$ is (strictly) *concave* iff $-f$ is (strictly) convex.

  #set math.equation(numbering: none)
] <def-convexity-eq-2-1>

For the definitions above, refer to IB Optimisation for further details.

#example[
  1. $f(x) = x^2$ is strictly convex, since the graph of $f$ is a parabola and any chord lies above it.

    #proof[
      For $x != y$,
      $
        [(1-t)x + t y)]^2 - (1-t) x^2 - t y^2 = -t(1-t)(x-y)^2 < 0.
      $

    ]

  2. $f(x) = ee^x$ if strictly convex, and $f(x)=ee^(-x)$ is also strictly convex.

  3. $f(x) = abs(x)$ is convex but not strictly convex.
]

#lecture-separator(lecture: 2, date: "2026-05-04")

== First Order Condition for Convexity

#theorem[First Order Condition for Convexity][
  If $f$ is differentiable, then the definition of convexity in @def-convexity-eq-2-1 is equivalent to
  $
    f(vb(y)) >= f(vb(x)) + (vb(y)-vb(x)) dot grad f(vb(x)) quad forall vb(x), vb(y) in dom f.
  $
] <first-order-condition-eq-2-3>

Intuitively, the first-order condition says that the tangent plane to the graph of $f$ at any point lies on or below the graph.

#proof[
  We will show that @def-convexity-eq-2-1 implies @first-order-condition-eq-2-3, and then that @first-order-condition-eq-2-3 implies @def-convexity-eq-2-1.

  #fade[[$=>$]] Let
  $
     h(t) & = (1-t) f(vb(x)) + t f(vb(y)) - f((1-t)vb(x) + t vb(y)) \
    h'(0) & = f(vb(y)) - f(vb(x)) - (vb(y)-vb(x)) dot grad f(vb(x)).
  $
  Note that the RHS is the difference between the RHS and LHS of @first-order-condition-eq-2-3. So we just need to show that $h'(0) >= 0$.
  $
    h'(0) & = lim_(t->0^+) (h(t) - h(0)) / t \
          & = lim_(t->0^+) h(t)/(t).
  $
  Note that @def-convexity-eq-2-1 implies $h(t) >= 0$ for all $t in [0, 1]$, so $h'(0) >= 0$.

  #fade[[$arrow.l.double$]] @first-order-condition-eq-2-3 implies that for all $vb(x), vb(y), vb(z) in dom f$,
  $
    cases(
      f(vb(x)) & >= f(vb(x)) + (vb(x)-vb(z)) dot grad f(vb(z)),
      f(vb(y)) & >= f(vb(x)) + (vb(y)-vb(z)) dot grad f(vb(z))
    )
  $
  Therefore
  $
    (1-t) f(vb(x)) + t f(vb(y)) & >= f(vb(z)) + ((1-t) vb(x) + t vb(y) - vb(z)) dot grad f(vb(z)).
  $
  Choosing $vb(z) = (1-t) vb(x) + t vb(y)$ gives @def-convexity-eq-2-1.
]

#corollary[
  If $f$ is convex and differentiable, then any stationary point of $f$ is a global minimum.
]

#proof[
  If $vb(a)$ is a stationary point, then $grad f(vb(a)) = 0$. So @first-order-condition-eq-2-3 becomes
  $
    f(vb(y)) >= f(vb(a)) quad forall vb(y) in dom f,
  $
  and hence $vb(a)$ is a global minimum.
]

#proposition[Alternative First Order Condition for Convexity][
  @first-order-condition-eq-2-3 is equivalent to
  $
    (vb(y) - vb(x)) dot (grad f(vb(y)) - grad f(vb(x))) >= 0 quad forall vb(x), vb(y) in dom f.
  $
] <monotonicity-condition-eq-2-4>

#remark[
  For $n=1$, @monotonicity-condition-eq-2-4 reduces to $[f'(y) - f'(x)] (y-x) >= 0$, which is equivalent to $f'$ being increasing.
]

#proof[
  #fade[[$=>$]] @first-order-condition-eq-2-3 implies that
  $
    cases(
      f(vb(y)) & >= f(vb(x)) + (vb(y)-vb(x)) dot grad f(vb(x)),
      f(vb(x)) & >= f(vb(y)) + (vb(x)-vb(y)) dot grad f(vb(y)).
    )
  $
  Adding these two inequalities gives @monotonicity-condition-eq-2-4.

  #fade[[$arrow.l.double$]] Let $vb(z) = (1-t) vb(x) + t vb(y)$. Consider
  $
    f(vb(y))-f(vb(x)) = [f(vb(z))]^(t=1)_(t=0) &= integral_0^1 dv(f(vb(z)), t) dif t = integral_0^1 (vb(y)-vb(x)) dot grad f(vb(z)) dif t\
    f(vb(y)) - f(vb(x)) - (vb(y)-vb(x)) dot grad f(vb(x)) & = integral_0^1 (vb(y)-vb(x)) dot [grad f(vb(z)) - grad f(vb(x))] dif t.
  $
  Replacing $vb(y)$ by $vb(z)$ in @monotonicity-condition-eq-2-4 gives
  $
     (vb(z) - vb(x)) dot (grad f(vb(z)) - grad f(vb(x))) & >= 0 quad forall vb(x), vb(z) in dom f \
    t(vb(y) - vb(x)) dot (grad f(vb(z)) - grad f(vb(x))) & >= 0 quad forall vb(x), vb(z) in dom f, forall t in [0, 1].
  $
  Therefore the integrand is non-negative, so the integral is non-negative, and hence @first-order-condition-eq-2-3 holds.
]

== Second Order Condition for Convexity

#theorem[Second Order Condition for Convexity][
  If $f$ is $C^2$, then @def-convexity-eq-2-1 is equivalent to the condition that $hess f succ.eq 0$. #fade[[Recall that $hess f succ.eq 0$ means that $hess f$ is positive semidefinite, _i.e._ all eigenvalues of $hess f$ are non-negative.]]
] <second-order-condition>

#proof[
  #fade[[$=>$]] Since @def-convexity-eq-2-1 implies @monotonicity-condition-eq-2-4, we can write $vb(y) = vb(x) + vb(h)$ in @monotonicity-condition-eq-2-4,
  $
    vb(h) dot [grad f(vb(x) + vb(h)) - grad f(vb(x))] >= 0 quad forall vb(x), vb(h) in dom f.
  $
  Taylor's expansion gives
  $
    grad_i f(vb(x) + vb(h)) = grad_i f(vb(x)) + h_j (hess f)_(i j)(vb(x)) + Order(h^2).
  $
  Hence
  $
    h_i h_j (hess f)_(i j)(vb(x)) + Order(h^3) >= 0 quad forall vb(x), vb(h) in dom f.
  $
  If $hess f$ had negative eigenvalue $lambda$ with eigenvector $vb(e)$, set $vb(h) = h vb(e)$. Then the above inequality becomes
  $
    lambda h^2 vb(e)^2 + Order(h^3) >= 0 quad forall h in RR.
  $
  This cannot hold for small enough $h$ since $lambda < 0$ $smash$, so $hess f succ.eq 0$.

  #fade[[$arrow.l.double$]] We will show this for a special case only, where $n = 1$. Then $hess f (x) = f''(x)$, so $f''(x) >= 0$ for all $x$. Then,
  $
    0 & <= sgn(y-x) integral_x^y f''(z) dif z \
      & = sgn(y-x) [f'(y) - f'(x)]. \
  $
  Multiplying by $abs(y - x)$ gives @monotonicity-condition-eq-2-4, which implies @def-convexity-eq-2-1.
]

#example[
  Let $f(x, y) = (1)/(x y)$ with $dom f = {(x, y) in RR^2: x > 0, y > 0}$. Then
  $
    hess f = (1)/(x y) mat(
      (2)/(x^2), (1)/(x y);
      (1)/(x y), (2)/(y^2)
    ), quad det hess f = (3)/(x^4 y^4) > 0, quad tr hess f = (2)/(x^3 y) + (2)/(x y^3) > 0.
  $
  Hence the eigenvalues of $hess f$ are positive in $dom f$, so $f$ is (strictly) convex.

  #fade[[Note that it seems like we can pick the more obvious choice of domain $dom f = {(x, y): x y > 0}$ and still arrive at the same conclusion, but $dom f$ is not a convex set in that case.]]
]
