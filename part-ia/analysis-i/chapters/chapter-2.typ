#import "../prelude.typ": *

= Continuity of Functions

== Limits of Functions

Take a function $f: X-> CC$ with $X subset.eq CC$. Consider the meaning of $f(z)->y$ as $z->a$, even if $a in.not X$.

A classic example is $(sin x)/(x)$ at $a = 0$, which is not in the domain of the function. The reason we may think of $lim_(x->0) (sin x)/(x)$ is that there are points in the domain that are very close to $0$. In other words, $0$ is an #ponder("analysis.accumulation-point")[accumulation point] for $RR \\ {0}$, since for any threshold $delta > 0$, there are points in $RR \\ {0}$ within $delta$ of $0$.

#definition[Accumulation Point][
  Let $X subset.eq CC$, and $a in CC$. We say that $a$ is an *#ponder("analysis.accumulation-point")[accumulation point]* for $X$ if
  $
    forall delta > 0, exists z in X \\ {a} : |z - a| < delta.
  $
  If $a in X$ and is not an #ponder("analysis.accumulation-point")[accumulation point] for $X$, we say that $a$ is an *isolated point* of $X$.
] <accumulation-point>

#example[
  - For $X = {0} union [1, 2]$, $0$ is an isolated point of $X$, while any point in $[1, 2]$ is an #ponder("analysis.accumulation-point")[accumulation point] of $X$.

  #lecture-separator(lecture: 7, date: "2026-02-05")

  - The points on the circle $S = {z in CC: |z| = 1}$ are #ponder("analysis.accumulation-point")[accumulation points] for $D = {z in CC: |z| < 1}$.

  - All the points in $D = {z in CC:|z|<1}$ are #ponder("analysis.accumulation-point")[accumulation points] for $D$.

  - For the set ${|z|<=1}$, then all the points are #ponder("analysis.accumulation-point")[accumulation points].
]

#lemma[
  Let $X subset.eq C$, $a in CC$. Then $a$ is a #ponder("analysis.accumulation-point")[accumulation point] iff there exists $(x_n)$ in $X \\ {a}$ such that $x_n -> a$ as $n -> oo$.
]

Hence, for $f(z)->y$ as $z->a$ to be meaningful, we need $a in X$, or if $a in.not X$, it should be an #ponder("analysis.accumulation-point")[accumulation point] for $X$. The rationale for our definition are

- for any threshold $epsilon > 0$ (no matter how small it is), there exist points in $im f$  which are $epsilon$-close to $y$, _i.e._
  $
    {z in X: abs(f(z)-y)< epsilon} != emptyset.
  $

- furthermore, it must contain all points in $X$ that are sufficiently close to $a$, _i.e._
  $
    exists delta > 0: forall z in X, |z - a| < delta => abs(f(z) - y) < epsilon.
  $


#definition[Limit of a Function][
  Let $f: X subset.eq CC -> CC$. Take $a in CC$ such that $a$ is an #ponder("analysis.accumulation-point")[accumulation point] for $X$. We say that $f(z) -> y$ as $z -> a$ if
  $
    forall epsilon > 0, exists delta > 0, forall z in X: 0 < |z - a| < delta => abs(f(z) - y) < epsilon.
  $

  $y$ is called the *#ponder("analysis.limit-of-function")[limit]* of $f$ as $z -> a$, and we write $lim_(z->a) f(z) = y$.

  // TODO: DO WE NEED THIS DIRECTION TO BE TENDING TO THAT OF $l$ EVEN FOR DIVERGENCE?
  In particular, for $a in CC$ where $a$ is an accumulation point for $X$, we say that $f$ diverges (to $oo$) as $z->a$ if $f(z)/(|f(z)|) -> l$ for some $l in CC$, and
  $
    forall L > 0, exists delta > 0, forall z in X: 0 < |z - a| < delta => |f(z)| > L.
  $
] <limit-of-function>

#remark[
  If $a$ is an isolated point of $X$, then we can always find $epsilon$ sufficiently small that
  $
    abs(z-a) < epsilon, z in X <=> z = a
  $
  So the definition of limit can be made for isolated points, but it is not very interesting.
]

#example[
  $(sin x)/(x)$ has fomain $RR\\{0}$. Consider its #ponder("analysis.limit-of-function")[limit] as $x->0$.

  #claim[
    $
      lim_(x->0) (sin x)/(x) = 1.
    $
  ]

  #proof[
    Recall that there is a geometric argument using trignometric circle that shows $cos x < (sin x)/(x) < 1$ for all $x in (0, (pi)/(2))$. Hence
    $
      abs((sin x)/(x) - 1) < 1 - cos x = 2 sin^2((x)/(2)) < (x^2)/(2).
    $
    Hence $forall epsilon > 0$, choosing $delta(epsilon) = sqrt(2 epsilon)$ gives
    $
      abs(x-0) < delta => abs((sin x)/(x) - 1) < epsilon.
    $
  ]
]

We can also give a #ponder("analysis.sequential-characterisation-of-limits")[sequential characterisation of limits], which is often easier to work with.

#lemma[Sequential Characterisation of Limits][
  Let $f: X subset.eq CC -> CC$. Let $a in CC$ where $a$ is an accumulation point of $X$. Then
  $
        f(z) -> y "as" z->a quad & <=> quad f(z_n) -> y "for every" (z_n) "on" X. \
    f(z) "diverges as" z->a quad & <=> quad f(z_n) "diverges for every" (z_n) "on" X.
  $
  with $(z_n) -> a$ and $z_n$ is not the constant sequence.
] <sequential-characterisation-of-limits>

#lemma[
  Suppose $f: X subset.eq CC -> CC$, and it has a limit at $a$. Then #ponder("analysis.limit-of-function")[the limit is unique].
]
#proof[
  Suppose $f(z) -> y$ as $z->a$, and $f(z) -> x$ as $z->a$ are both true.

  We have
  $
    abs(x-y) = abs(x - f(z) + f(z) - y) <= abs(x - f(z)) + abs(f(z) - y).
  $
  Note that LHS does not depend on $z$, but RHS does. So taking limit as $z->a$ gives
  $
    abs(x-y) <= lim_(z->a) abs(x - f(z)) + lim_(z->a) abs(f(z) - y) = 0.
  $
  Hence $x = y$.
]

#lemma[
  Let $f: X subset.eq CC -> CC$. Let $a in CC$ where $a$ is an accumulation point of $X$. Suppose $lim_(z->a) f(z) = y$, $lim_(z-a) g(z) = x$. Then,
  $
    lim_(z->a) (f(z) + g(z)) = y + x, quad lim_(z->a) (f(z)g(z)) = y x, quad lim_(z->a) (f(z)/g(z)) = y/x "if" forall z in X, space g(z) !=0 "and" x!=0.
  $
]

== Continuity of Functions

From the previous section, we can compute $lim_(z->a) f(z)$ if $a$ is a #ponder("analysis.accumulation-point")[accumulation point] for $X$.

#definition[Continuity of a Function][
  Let $f: X subset.eq CC -> CC$. We say that $f$ is *#ponder("analysis.continuity")[continuous]* at every point in $X$.

  Take $a in X$. We say that $f$ is #ponder("analysis.continuity")[continuous] at $a$ if
  $
    forall epsilon > 0, exists delta in RR, forall z in X: |z - a| < delta => abs(f(z) - f(a)) < epsilon.
  $


] <continuity>

#remark[
  If $a in X$ is an isolated point, then $f$ is #ponder("analysis.continuity")[continuous] at $a$. Inf $a in CC$ is an #ponder("analysis.accumulation-point")[accumulation point] for $X$, then $f$ is #ponder("analysis.continuity")[continuous] at $a$ iff $lim_(z->a) f(z) = f(a)$.
]

#example[
  - $f(z)=z$ is #ponder("analysis.continuity")[continuous], since $forall epsilon > 0, exists delta$ given by $delta(epsilon) = epsilon$ such that $forall z in X, |z - a| < delta => abs(f(z) - f(a)) = abs(z - a) < epsilon$.

  - $f(x) = cases(
      sin((1)/(x)) quad &"if" x != 0,
      0 quad &"if" x = 0,
    )$
    is not #ponder("analysis.continuity")[continuous] at $0$, since $lim_(x->0) sin((1)/(x))$ does not exist.
]

#lecture-separator(lecture: 8, date: "2026-02-10")

#definition[Sequential Continuity][
  Let $f: X subset.eq CC -> CC$. We say that $f$ is *#ponder("analysis.sequential-continuity")[sequentially continuous]* at $a in X$ if for every #ponder("analysis.sequence")[sequence] $(z_n)$ in $X$ such that $z_n -> a$, we have $f(z_n) -> f(a)$.
] <sequential-continuity>

#proposition[
  Let $f: X subset.eq CC -> CC$. Then $f$ is #ponder("analysis.continuity")[continuous] at $a in X$ iff $f$ is #ponder("analysis.sequential-continuity")[sequentially continuous] at $a$.
]

#proof[

  #fade[[$=>$]] By #ponder("analysis.continuity")[continuity] of $f$, $forall epsilon > 0$, $exists delta = delta(epsilon)$ such that $abs(z-a) < delta => abs(f(z) - f(a)) < epsilon$.
  Take $(z_n)$ on $X$ with $z_n -> a$, then $exists N = N(epsilon)$ such that $abs(z_n - a) < delta$ for all $n >= N$. Hence $abs(f(z_n) - f(a)) < epsilon$ for all $n >= N$, so $f(z_n) -> f(a)$.

  #fade[[$arrow.l.double$]] We shall prove by contradiction. Suppose $f$ is not #ponder("analysis.continuity")[continuous] at $a$, then $exists epsilon > 0$ such that $forall delta > 0$, $exists z in X$ with $abs(z-a) < delta$ but $abs(f(z) - f(a)) >= epsilon$.

  Take $delta = 1, (1)/(2), ..., (1)/(n), ...$ to find $(z_n)$ with $abs(z_n - a) < (1)/(n) -> 0$ but $abs(f(z_n) - f(a)) >= epsilon$ for all $n$. Hence $z_n -> a$ but $f(z_n)$ does not #ponder("analysis.sequence-convergence")[converge] to $f(a)$, contradicting the #ponder("analysis.sequential-continuity")[sequential continuity] of $f$ at $a$.
]

#example[
  - For
    $
      f(x) = cases(
        sin((1)/(x)) quad & "if" x != 0,
        0 quad & "if" x = 0,
      )
    $
    consider the #ponder("analysis.sequence")[sequence] $(x_n)$ with $x_n = (1)/((2n + (1)/(2))ppi)$. Then $f(x_n) = 1$ for all $n$ and $x_n -> 0$. Hence $f$ is not #ponder("analysis.sequential-continuity")[sequentially continuous] at $0$, and thus not #ponder("analysis.continuity")[continuous] at $0$.

  - Consider $f(x) = bb(1)_QQ (x)$. $f$ is #ponder("analysis.continuity")[discontinuous] at every point $a in RR$:

    - if $a in QQ$ then $exists (x_n) subset.eq RR \\ QQ$ with $x_n -> a$ but $f(x_n) = 0$ for all $n$ and $f(a) = 1$.

    - if $a in RR \\ QQ$ then $exists (x_n) subset.eq QQ$ with $x_n -> a$ but $f(x_n) = 1$ for all $n$ and $f(a) = 0$.

  - Consider $f(x) = sin x$, we shall show that it is #ponder("analysis.continuity")[continuous] at every point $a in RR$. Fix $a in RR$. We can choose $delta(epsilon) = min (epsilon, (ppi)/(2))$,
    $
      abs(f(x) - f(a)) & = abs(sin x - sin a) \
                       & <= 2 cos ((x+a)/(2)) sin((x-a)/(2)) \
                       & <= abs(sin((x-a)/(2))) \
                       & <= abs(x-a) quad "by taking" (x-a)/(2) in [-(ppi)/(2), (ppi)/(2)].
    $
    Therefore, $abs(f(x_n)-f(a)) <= abs(x_n-a)$ holds for $n$ sufficiently large.
]

#lemma[
  Let $f, g : X subset.eq CC -> CC$ be #ponder("analysis.continuity")[continuous] at $a in X$. Then so are $lambda f + g$ and $f g$. If $f(z) != 0$ forall $z in X$, then so is $(1)/(f)$.
]

#lemma[
  Let $U, V in CC$, $f: U -> V$, $g: V -> CC$. If $f$ is #ponder("analysis.continuity")[continuous] at $a in U$ and $g$ is #ponder("analysis.continuity")[continuous] at $f(a) in V$, then $g compose f: U->CC$ is #ponder("analysis.continuity")[continuous] at $a$.
]

#proof[
  Since $g$ is #ponder("analysis.continuity")[continuous] at $f(a)$,
  $
    forall epsilon > 0, exists sigma = sigma(epsilon), forall y in V: abs(y-f(a)) < sigma => abs(g(y) - g(f(a))) < epsilon.
  $
  Also, $f$ is #ponder("analysis.continuity")[continuous] at $a$. So

  $
    exists delta = delta(epsilon), forall z in U: abs(z - a) < delta => abs(f(z) - f(a)) < sigma.
  $
  Putting everything together,
  $
    forall epsilon > 0, exists delta= delta(epsilon), forall z in U: abs(z-a) < delta => abs(f(z) - f(a)) < sigma => abs(g(f(z)) - g(f(a))) < epsilon.
  $
  Hence $g compose f$ is #ponder("analysis.continuity")[continuous] at $a$.
]

#remark[
  Composition preserves #ponder("analysis.continuity")[continuity].
]

== Extreme Value Theorem

#definition[Closed set][
  A set $X subset.eq CC$ is *#ponder("analysis.closed-set")[closed]* if all #ponder("analysis.sequence")[sequences] $(x_n)$ in $X$ which #ponder("analysis.sequence-convergence")[converge] in $CC$ have their limits in $X$.
] <closed-set>

#example[
  - $[0, 1]$ is #ponder("analysis.closed-set")[closed],
  - $(0, 1)$ is not #ponder("analysis.closed-set")[closed],
  - $(0, 1]$ or $[0, 1)$ are not #ponder("analysis.closed-set")[closed],
  - $[0, oo)$ is #ponder("analysis.closed-set")[closed],
  - $(0, oo)$ is not #ponder("analysis.closed-set")[closed].
]

#definition[Bounded Set][
  We say $X subset.eq CC$ is #ponder("analysis.bounded-set")[bounded] if $exists M > 0$ such that $X subset.eq {z in CC: abs(z) <= M }$.

  In other words, if $exists M > 0$ such that $sup_(z in X) abs(z) <= M$.
] <bounded-set>

#example[
  - $[0, 1]$, $(0, 1)$, $[0, 1)$ are #ponder("analysis.bounded-set")[bounded],
  - $[0, oo)$, $(0, oo)$ are not #ponder("analysis.bounded-set")[bounded].
]

#proposition[Continuity preserves closedness and boundedness][
  Let $X subset.eq CC$ be a #ponder("analysis.closed-set")[closed] #ponder("analysis.bounded-set")[bounded] set. If $f: X -> CC$ is #ponder("analysis.continuity")[continuous] then $f(X) subset.eq CC$ is a #ponder("analysis.bounded-set")[bounded] #ponder("analysis.closed-set")[closed] subset of $CC$.
] <prop-continuity-preserves-closedness-and-boundedness>

#lecture-separator(lecture: 9, date: "2026-02-12")

#proof[

  #fade[[$f(X)$ is #ponder("analysis.bounded-set")[bounded].]] Suppose $f(X)$ is not #ponder("analysis.bounded-set")[bounded], then for each $n in NN$ we can find $x_n$ such that $abs(f(x_n)) > n$. Now, $(x_n)$ is a #ponder("analysis.sequence")[sequence] in $X$, and it must be #ponder("analysis.bounded-sequence")[bounded] since $X$ is #ponder("analysis.bounded-set")[bounded].

  By @bolzano-weierstrass-theorem[Bolzano-Weierstrass Theorem], there exists a #ponder("analysis.sequence-convergence")[convergent] #ponder("analysis.subsequence")[subsequence] $(x_n_k)$. Let the limit of $(x_n_k)$ be $x$. Since $X$ is #ponder("analysis.closed-set")[closed], $x in X$. On the other hand, $abs(f(x_n_k)) > n_k >= k$. So $f(x_n_k)$ cannot #ponder("analysis.sequence-convergence")[converge] as $k->oo$. Then $f$ is not #ponder("analysis.continuity")[continuous] at $x$. $smash$ Therefore $f(X)$ must be #ponder("analysis.bounded-set")[bounded].

  #fade[[$f(X)$ is #ponder("analysis.closed-set")[closed].]] Take $(y_n)$ in $f(X)$, suppose that it #ponder("analysis.sequence-convergence")[converges] to some $y in CC$. We want to show that $y in f(X)$. Note that $y_n in f(X) => exists x_n in X$ such that $f(x_n) = y_n$. This #ponder("analysis.sequence")[sequence] $(x_n)$ is inside $X$, hence it is #ponder("analysis.bounded-sequence")[bounded]. Copying the argument above to get $x_n_k -> x in X$. Thus $y_n_k = f(x_n_k)$. By #ponder("analysis.continuity")[continuity] of $f$,
  $
    y = lim_(k -> oo) y_n_k = lim_(k -> oo) f(x_n_k) = f(lim_(k->oo) x_n_k) = f(x).
  $
  Hence $y in f(X)$.

]

#theorem[Extreme Value Theorem][
  Let $X subset.eq RR$ be a #ponder("analysis.closed-set")[closed] #ponder("analysis.bounded-set")[bounded] set. If $f: X -> RR$ is #ponder("analysis.continuity")[continuous], then there exist $a, b in X$ with
  $
    a & = sup f(X), quad b = inf f(X).
  $

] <extreme-value-theorem>

#remark[
  We know by #ponder("analysis.least-upper-bound")[Supremum Axiom] (from IA Numbers and Sets), that there exist #ponder("analysis.least-upper-bound")[supremum] and #ponder("analysis.greatest-lower-bound")[infimum] of $f(X)$. The proof here is that these are always attained, so that they actually maximum and minimum.
]

#proof[
  We will focus on the first equality, since the other can be proved similarly.

  Let $M = sup f(X)$. Hence, $M-(1)/(n)$ is not an #ponder("analysis.bounded-above")[upper bound] for $f(X)$ for all $n in NN$. Hence, we can find a #ponder("analysis.sequence")[sequence] $(y_n)$ on $f(X)$ such that
  $
    M - (1)/(n) < y_n <= M.
  $
  Note that $exists x_n$ such that $y_n = f(x_n)$ for each of $y_n$. This gives us a #ponder("analysis.sequence")[sequence] $(x_n)$ on $X$ such that $f(x_n) = y_n$ for all $n$ with $M-(1)/(n ) < f(x_n) <= M$. Now take limits and use the fact that $f$ is #ponder("analysis.continuity")[continuous], we get
  $
    M <= lim_(n->oo) f(x_n) <= M => lim_(n->oo) f(x_n) = M.
  $

  By #ponder("analysis.closed-set")[closedness] of $X$, $f(X)$ is also #ponder("analysis.closed-set")[closed] by @prop-continuity-preserves-closedness-and-boundedness. Hence $M in f(X)$, so there exists $a in X$ such that $f(a) = M$. Hence $a = sup f(X)$.
]

== Intermediate Value Theorem


#theorem[Intermediate Value Theorem][
  If $f: [a, b] -> RR$ is #ponder("analysis.continuity")[continuous], then $f([a, b])$ is an interval. Hence, if $f(a) <= y <= f(b)$, then there exists $c in [a, b]$ such that $f(c) = y$.
] <intermediate-value-theorem>

#remark[
  The theorem guarantees existence, but not uniqueness.
]


#proof[
  If $f$ is constant, or if $y = f(a)$ or $y = f(b)$, then this is trivially true.

  If not, WLOG assume $f(a) < y < f(b)$, and let $S = {x in [a, b]:f (x) <= y }$. Then $a in S$, so $S$ is non-empty. Also, $S$ is bonunded above by $b$, so $exists d = sup S in [a, b]$. We aim to show that $f(d) = y$.

  - Suppose $f(d) > y$. Then $epsilon = f(d) - y > 0$. By #ponder("analysis.continuity")[continuity] of $f$, $exists delta = delta(epsilon) > 0$ such that $forall abs(x - d) < delta$, $x in [a, b] => abs(f(x) - f(d)) < epsilon => f(x) > f(d) - epsilon = y => x in.not S$.

    This means that $(d - delta, d) inter S = emptyset$, which contradicts the definition of $d$.

  - Suppose $f(d) < y$. Then $epsilon = y - f(d) > 0$. By #ponder("analysis.continuity")[continuity] of $f$, $exists delta = delta(epsilon) > 0$ such that $forall abs(x - d) < delta$, $x in [a, b] => abs(f(x) - f(d)) < epsilon => f(x) < f(d) + epsilon = y$. But then, $f(d + (delta)/(2)) < y => d <= d + (delta)/(2) in S$, again contradicting the definition of $d$.

  Hence $f(d) = y$.
]

#example[
  We can apply this to show the existence of $N$-th roots (where $N in NN$). Take $t > 0$, and consider
  $
    f: [0, 1+t] & -> RR \
              x & |-> x^N.
  $
  This is a #ponder("analysis.continuity")[continuous] function, and $0 = f(0) < t < (1+t)^N = f(1+t)$. By @intermediate-value-theorem[Intermediate Value Theorem], $exists c in [0, 1+t]$ such that $f(c) = t <=> c^N = t$, Hence $c$ is a positive $N$-th root of $t$.
]

#definition[Monotone Function][
  Consider $f: [a, b] -> RR$. We say $f$ is (strictly) #ponder("analysis.monotone-function")[monotone] if either

  - it is (strictly) #ponder("analysis.monotone-function")[increasing], so $a <= x_1 <= x_2 <= b => f(x_1) <= f(x_2)$,

  - it is (strictly) #ponder("analysis.monotone-function")[decreasing], so $a <= x_1 <= x_2 <= b => f(x_1) >= f(x_2)$.
] <monotone-function>

#proposition[Inverse Function Theorem, Version 1][
  Let $f: [a, b] -> RR$ be a #ponder("analysis.continuity")[continuous] function that is strictly #ponder("analysis.monotone-function")[monotone]. Let $c = min{f(a), f(b)}$ and $d = max{f(a), f(b)}$. Then $f: [a, b] -> [c, d]$ is a #ponder("algebra.bijection")[bijection] and $f^(-1): [c, d] -> [a, b]$ is #ponder("analysis.continuity")[continuous] and strictly #ponder("analysis.monotone-function")[monotone].
] <inverse-function-theorem-version-1>

#lecture-separator(lecture: 10, date: "2026-02-14")

#proof[

  #fade[[Bijiectivity of $f$.]] Since $f$ is #ponder("analysis.continuity")[continuous] and #ponder("analysis.monotone-function")[monotone], so it maps $[a, b]$ to $[c, d]$ because its #ponder("analysis.monotone-function")[monotonicity] implies that the extreme values are attained at the endpoints. Since it is strictly #ponder("analysis.monotone-function")[monotone], it is #ponder("set-theory.injection-surjection")[injective]. By @intermediate-value-theorem[Intermediate Value Theorem], it is #ponder("set-theory.injection-surjection")[surjective]. Hence $f$ is a #ponder("algebra.bijection")[bijection].

  #fade[[#ponder("analysis.monotone-function")[Monotonicity] of $f^(-1)$.]] WLOG take $f$ to be strictly #ponder("analysis.monotone-function")[increasing]. If $f^(-1) : [c, d] -> [a, b]$ is not strictly #ponder("analysis.monotone-function")[increasing], then $exists y_1, y_2 in [c, d]$ such that $y_1 < y_2$ yet $f^(-1)(y_1) >= f^(-1)(y_2)$. Since $f$ is strictly #ponder("analysis.monotone-function")[increasing], $f(f^(-1)(y_1)) >= f(f^(-1)(y_2)) => y_1 >= y_2$, contradicting the choice of $y_1, y_2$. Hence $f^(-1)$ is strictly #ponder("analysis.monotone-function")[increasing].

  #fade[[#ponder("analysis.continuity")[Continuity] of $f^(-1)$.]] Fix $y_0 in [c, d]$ and $x_0 = f^(-1)(y_0)$. There are three cases:

  - if $x_0 in (a, b)$, fix $epsilon > 0$. Then choose $eta in (0, epsilon]$ sufficiently small that $[x_0 - eta, x_0 + eta] subset.eq [a, b].$ Now, $f$ is strictly #ponder("analysis.monotone-function")[increasing], so
    $
      f(x_0 - eta) < f(x_0) = y_0 < f(x_0 + eta).
    $
    Then take $delta = min {f(x_0 + eta) - y_0, y_0 - f(x_0 - eta)}$. We want to prove that for $y in [c, d]$,
    $
      abs(y - y_0) < delta => abs(f^(-1)(y) - x_0) < epsilon.
    $
    We have
    $
      abs(y - y_0) < delta & => y_0-delta < y < y_0 + delta \
                           & => f(x_0 - eta) < y < f(x_0 + eta) \
                           & => x_0 - eta < f^(-1)(y) < x_0 + eta \
                           & => abs(f^(-1)(y) - x_0) < eta <= epsilon.
    $

  - if $x_0 = a$, fix $epsilon > 0$. Then $y_0 = f(a)$. Choose $eta = min{epsilon, b-a}$ and set $delta = f(a + eta) - f(a) > 0$. Then,
  $
    abs(y - y_0) < delta, y in [c, d] & => f(a) <= y <= f(a + eta) \
                                      & => a <= f^(-1)(y) <= a + eta \
                                      & => abs(f^(-1)(y) - a) <= eta <= epsilon.
  $

  - if $x_0 = b$, the case is similar to the previous one.


]
