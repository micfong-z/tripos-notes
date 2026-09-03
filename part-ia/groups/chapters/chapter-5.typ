#import "../prelude.typ": *

#lecture-separator(lecture: 12, date: "2025-11-05")

= #ponder("algebra.mobius-group")[The Möbius Group]

This chapter is about an interesting #ponder("algebra.group")[group]. It is almost a group of #ponder("algebra.bijection")[bijections] of $CC$, but we need to add a formal point at $oo$.

== #ponder("geometry.riemann-sphere")[Riemann Sphere] and #ponder("algebra.mobius-transformation")[Möbius Transformations]

#definition[#ponder("geometry.riemann-sphere")[Riemann Sphere]][
  The *#ponder("geometry.riemann-sphere")[Riemann sphere]* is the set
  $ CC_oo := CC union {oo}. $
]<riemann-sphere>

This set is called a #ponder("geometry.riemann-sphere")[sphere] because we can visualize it as follows.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d7e1.svg", width: 28em)
]

We can define a map $pi: CC->S^2$ called the *stereographic projection*. It identifies $CC$ with all the points on the #ponder("geometry.riemann-sphere")[sphere] except the north pole at $oo$.

#definition[#ponder("algebra.mobius-transformation")[Möbius Transformation]][
  Let $a, b, c, d$ be complex numbers with $a d - b c != 0$. If $c != 0$, then the corresponding *#ponder("algebra.mobius-transformation")[Möbius transformation]* is the map $mu: CC_oo -> CC_oo$ defined by, if $c != 0$,
  $
    z |-> cases(
      ( a z + b)/(c z + d) quad & "if" z in CC \\ { - (d)/(c)},
      oo quad & "if" z = - (d)/(c),
      a/(c) quad & "if" z = oo
    )
  $
  If $c = 0$, then $mu$ is defined by
  $
    z |-> cases(
      (a z + b)/(d) quad & "if" z in CC,
      oo quad & "if" z = oo
    )
  $
  We usually just write $mu(z) = (a z + b)/(c z + d)$ and interpreting the cases of $0$ and $oo$ appropriately.
]<mobius-transformation>

Then
$ cal(M) = {f: C_oo -> C_oo : f "is a Möbius transformation"} $
together with #ponder("algebra.function-composition")[composition of functions] forms a #ponder("algebra.group")[group], called the *#ponder("algebra.mobius-group")[Möbius group]*.

#proposition[
  If
  $
    mu_1(z) & = (a_1 z + b_1)/(c_1 z + d_1), quad mu_2(z) & = (a_2 z + b_2)/(c_2 z + d_2)
  $
  then
  $
    mu_1 compose mu_2(z) = ((a_1 a_2 + b_1 c_2) z + (a_1 b_2 + b_1 d_2))/((c_1 a_2 + d_1 c_2) z + (c_1 b_2 + d_1 d_2)).
  $
]<mobius-composition>

#remark[
  Compare this with matrix multiplication:
  $
    mat(a_1, b_1; c_1, d_1) mat(a_2, b_2; c_2, d_2) = mat(a_1 a_2 + b_1 c_2, a_1 b_2 + b_1 d_2; c_1 a_2 + d_1 c_2, c_1 b_2 + d_1 d_2).
  $
]

== #ponder("algebra.mobius-group")[The Möbius Group]

#theorem[#ponder("algebra.mobius-group")[Möbius Group]][
  $(cal(M), compose, id)$ is a #ponder("algebra.group")[group].
]<mobius-group>

#proof[

  - #ponder("algebra.function-composition")[Composition of functions] is associative.

  - The identity map $id(z) = (1 z + 0)/(0 z + 1) = z$ is a #ponder("algebra.mobius-transformation")[Möbius transformation] with $a = d = 1$ and $b = c = 0$.

  - For $mu: z |-> (a z + b)/(c z + d)$, let $nu: z |-> (d z - b)/(-c z + a)$.

    Then $nu$ is also a #ponder("algebra.mobius-transformation")[Möbius transformation] and $mu compose nu = id$ and $nu compose mu = id$. Hence $nu$ is the #ponder("algebra.inverse-element")[inverse] of $mu$.
]

One important way to study #ponder("algebra.mobius-transformation")[Möbius transformations] is via their #ponder("algebra.fixed-point")[fixed points].

#definition[#ponder("algebra.fixed-point")[Fixed Point]][
  Suppose $f: X-> X$ is a #ponder("algebra.permutation")[permutation]. Any $x in X$ such that $f(x) = x$ is called a *#ponder("algebra.fixed-point")[fixed point]* of $f$.
]<fixed-point>

#lemma[#ponder("algebra.mobius-three-point-lemma")[Three-point lemma for] $cal(M)$][
  If $mu in cal(M)$ fixes three distinct points $w_1, w_2, w_3$ of $CC_oo$, then $mu = id$.
] <three-point-lemma-mobius>

#proof[
  Let $mu(z) = (a z + b)/(c z + d)$. A #ponder("algebra.fixed-point")[fixed point] $w_i$ satisfies
  $
    w_i & = (a w_i + b)/(c w_i + d).
  $

  *Case 1.* If there is a #ponder("algebra.fixed-point")[fixed point] $oo$, WLOG let $w_1 = oo$, then $c = 0$. So $w_2$ and $w_3$ satisfy

  $
              w_i & = (a w_i + b)/(d) \
    (a-d) w_i + b & = 0.
  $
  This is a linear equation with at least 2 roots, so we cannot have two distinct #ponder("algebra.fixed-point")[fixed points] $w_2$ and $w_3$ unless $a = d$ and $b = 0$. Then $mu = id$.

  *Case 2.* If none of the fixed points is $oo$, then we have three distinct complex numbers $w_1, w_2, w_3$ satisfying
  $
    (a - c w_i) w_i + b - d w_i & = 0 \
      c w_i^2 + (d - a) w_i - b & = 0.
  $

  This is a quadratic equation with at least 3 roots, so we cannot have three distinct #ponder("algebra.fixed-point")[fixed points] $w_1, w_2, w_3$ unless $a = d$, $b = 0$, and $c = 0$. Then $mu = id$.
]

#exercise[
  Show that every $mu in cal(M)$ has at least one #ponder("algebra.fixed-point")[fixed point] in $CC_oo$.
]

#example[
  1. Consider $mu(z) = z + 1$. Then $fix(mu) = {oo}$.

  2. Consider $mu(z) = 2z$. Then $fix(mu) = {0, oo}$.
]

#lemma[#ponder("algebra.mobius-triple-transitivity")[Triple transitivity]][
  For any triples of distinct points $z_1, z_2, z_3 in CC_oo$ and $w_1, w_2, w_3 in CC_oo$, there exists a $mu in cal(M)$ such that $mu(z_i) = w_i$ for $i = 1, 2, 3$.
] <triple-transitivity>

#proof[
  Instead of constructing $mu$ directly, we construct two auxiliary #ponder("algebra.mobius-transformation")[Möbius transformations] $alpha$ and $beta$ such that $alpha(z_i) = 0, 1, oo$ and $beta(w_i) = 0, 1, oo$. Then we can let $mu = beta^(-1) compose alpha$.

  Let $alpha(z)$ be defined by
  $
    alpha(z) = ((z_2 - z_3)/(z_2-z_1))(z - z_1)/(z - z_3).
  $
  #fade[[Modify appropriately if any of $z_1, z_2, z_3$ is $oo$.]]

  Then $alpha(z_1) = 0$, $alpha(z_2) = 1$, and $alpha(z_3) = oo$.

  Similarly, let $beta(z)$ be defined by
  $
    beta(z) = ((w_2 - w_3)/(w_2-w_1))(z - w_1)/(z - w_3).
  $
  #fade[[Modify appropriately if any of $w_1, w_2, w_3$ is $oo$.]]

  Then $beta(w_1) = 0$, $beta(w_2) = 1$, and $beta(w_3) = oo$.

  Note that $alpha$ and $beta$ are both in $cal(M)$. Then let
  $ mu = beta^(-1) compose alpha. $
  Then $mu(z_i) = w_i$ for $i = 1, 2, 3$.
]

#remark[
  The #ponder("algebra.mobius-three-point-lemma")[three-point lemma] implies that $mu$ in @triple-transitivity is unique. We say that $cal(M) arrow.cw.half CC_oo$ is #ponder("algebra.mobius-triple-transitivity")[sharply triply transitive].
]

#definition[#ponder("geometry.cross-ratio")[Cross Ratio]][
  Let $z_1, z_2, z_3, z_4 in CC_oo$  be distinct points. Because $cal(M) arrow.cw.half CC_oo$ #ponder("algebra.mobius-triple-transitivity")[sharply triply transitively], there exists a unique $alpha in cal(M)$ such that

  $
    alpha(z_1) = 0, quad alpha(z_2) = 1, quad alpha(z_3) = oo.
  $

  The *#ponder("geometry.cross-ratio")[cross-ratio]* is defined as
  $
    [z_1, z_2, z_3, z_4] := alpha(z_4).
  $

  Note that we saw that $[z_1, z_2, z_3, z_4]$ can be computed by
  $
    [z_1, z_2, z_3, z_4] = ((z_4 - z_1)(z_2 - z_3))/((z_4 - z_3)(z_2 - z_1))
  $
  by the proof of @triple-transitivity.
]<cross-ratio>

#lecture-separator(lecture: 13, date: "2025-11-07")

Just like for dihedral groups, we can use the #ponder("algebra.mobius-three-point-lemma")[3-point lemma] to find a #ponder("algebra.mobius-generators")[generating set] for $cal(M)$.

#proposition[
  $cal(M)$ is generated by the set of elements of the following 3 forms:
  1. $alpha_a : z |-> a z$, where $a != 0$
  2. $beta_b : z |-> z + b$, where $b in CC$
  3. $gamma : z |-> 1/z$
]<mobius-generators>

#proof[
  Let $mu in cal(M)$ be arbitrary, and let $z_1 = mu(0)$, $z_2 = mu(1)$, $z_3 = mu(oo)$.

  *Step 1.* Construct $mu_1$ such that $mu_1(z_3)=oo$.

  Either $z_3 = oo$ and $mu_1 = id$ or
  $
    mu_1 = (1)/(z+b)
  $
  where $b = - z_3$. Then $mu_1 = gamma compose beta_b$

  Let $z'_1 = mu_1(z_1)$ and $z'_2 = mu_1(z_2)$.

  *Step 2.* Let $b' = -z'_1$, and let $mu_2 = beta_b'$, _i.e._
  $ mu_2 (z) = z + b'. $

  Note that $mu_2(oo)=oo$ and $mu_2 (z'_1) = 0$. By construction,
  $
    mu_2 compose mu_1 (z_3) = oo, quad mu_2 compose mu_1 (z_1) = 0.
  $
  Let
  $
    z''_2 = mu_2 compose mu_1 (z_2) != 0 "or" oo.
  $
  *Step 3.* Let $a = (1)/(z''_2)$ and
  $ mu_3 (z) := alpha_a (z). $

  By construction,

  $
    mu_3 compose mu_2 compose mu_1 (z_1) & = 0, \
    mu_3 compose mu_2 compose mu_1 (z_2) & = 1, \
    mu_3 compose mu_2 compose mu_1 (z_3) & = oo.
  $
  By the #ponder("algebra.mobius-three-point-lemma")[three-point lemma], $mu_3 compose mu_2 compose mu_1 = mu^(-1)$, so
  $
    mu = mu_1^(-1) compose mu_2^(-1) compose mu_3^(-1).
  $
]

== #ponder("geometry.circle-in-riemann-sphere")[Circles]

#definition[#ponder("geometry.circle-in-riemann-sphere")[Circle in] $CC_oo$][
  A *#ponder("geometry.circle-in-riemann-sphere")[circle]* in $C_oo$ is either

  - a Euclidean #ponder("geometry.circle-in-riemann-sphere")[circle] in $CC$, or

  - $l union {oo}$ where $l$ is a Euclidean straight line in $CC$.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d7e2.svg", width: 16em)
]
]<circle-in-riemann-sphere>

Euclidean #ponder("geometry.circle-in-riemann-sphere")[circles] are described by the equation
$
  abs(z-a) = r
$
for some $a in CC$ and $r > 0$,

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d7e3.svg", width: 5em)
]

while lines are described by

$
  abs(z-a) = abs(z-b) "for" a, b in CC.
$

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d7e4.svg", width: 10em)
]

#theorem[#ponder("algebra.mobius-circle-preservation")[Circles and Möbius Transformations]][
  #ponder("algebra.mobius-transformation")[Möbius transformations] map #ponder("geometry.circle-in-riemann-sphere")[circles] to #ponder("geometry.circle-in-riemann-sphere")[circles]. Formally, if $C subset.eq CC_oo$ is a #ponder("geometry.circle-in-riemann-sphere")[circle], then $mu in cal(M)$ then $mu(C)$ is also a #ponder("geometry.circle-in-riemann-sphere")[circle].
]<mobius-circle-preservation>

#proof[
  Recall that $cal(M)$ is #ponder("algebra.generated-subgroup")[generated] by
  $
    alpha_a (z) & = a z \
     beta_b (z) & = z + b \
      gamma (z) & = 1/z.
  $
  So it suffices to show that each of these #ponder("algebra.mobius-generators")[generators] maps #ponder("geometry.circle-in-riemann-sphere")[circles] to #ponder("geometry.circle-in-riemann-sphere")[circles].

  It is clear that $alpha_a$ and $beta_b$ map #ponder("geometry.circle-in-riemann-sphere")[circles] to #ponder("geometry.circle-in-riemann-sphere")[circles]. So we just need to show that $gamma$ maps #ponder("geometry.circle-in-riemann-sphere")[circles] to #ponder("geometry.circle-in-riemann-sphere")[circles].

  If $C$ is a Euclidean #ponder("geometry.circle-in-riemann-sphere")[circle] in $CC$, then $gamma(C)$ has equation
  $
    abs(1/z - c) =r & <=> abs((1)/(z)-c)^2 = r^2 \
                    & <=> ((1)/(z ) - c) ( (1)/(z) - overline(c)) = r^2 \
                    & <=> (1)/(abs(z)^2 ) - (c)/(z) - overline(c)/(z) + abs(c)^2 - r^2 = 0 \
                    & <=> (abs(c)^2-r^2) abs(z^2)- c z - overline(c)space overline(z) + 1 = 0.
  $

  If $abs(c)^2=r^2$, then we have
  $
    c z + overline(c) space overline(z) = 1 & <=> (z)/(overline(c)) + overline(z)/(c) = (1)/(abs(c)^2) \
    &<=> abs(z)^2 = abs(z)^2 - (z)/(overline(c)) - overline(z) /c + (1)/(abs(c)^2 ) = abs(z - (1)/(c))^2 \
    &<=> abs(z) = abs(z - (1)/(c)).
  $
  This is the equation of a line. Otherwise, $abs(c)^2 != r^2$, and the equation becomes

  $
    & abs(z)^2 - ((c)/(abs(c)^2-r^2))z - (overline(c)/(abs(c)^2-r^2))overline(z) + (1)/(abs(c)^2-r^2 ) = 0 \
    <=> & abs(z-overline(c)/(abs(c)^2-r^2 ))^2 =abs(c)^(2)/((abs(c^2)-r^2 )^2) - (1)/(abs(c^2)-r^2) = (r^2)/(abs(c)^2-r^2 )^2 \
  $
  which is the equation of a #ponder("geometry.circle-in-riemann-sphere")[circle].

  We are left with the case where $C$ is a line, which follows a very similar calculation to the above and is left as an exercise.
]

#corollary[
  Four points $z_1, z_2, z_3, z_4 in CC_oo$ lie on a circle if and only if their cross-ratio $[z_1, z_2, z_3, z_4] in RR_oo$.
]<cross-ratio-circle-criterion>

#proof[
  Let $alpha in cal(M)$ such that $alpha(z_1) = 0$, $alpha(z_2) = 1$, $alpha(z_3) = oo$, and so $alpha(z_4) = [z_1, z_2, z_3, z_4]$

  #fade[[$=>$]] If $z_1, ..., z_4 in CC$ lie on a #ponder("geometry.circle-in-riemann-sphere")[circle] $C$, then by the previous theorem, $alpha(C)$ is also a #ponder("geometry.circle-in-riemann-sphere")[circle] containing $0, 1, oo$. The only such #ponder("geometry.circle-in-riemann-sphere")[circle] is the real line $RR_oo$, so $[z_1, z_2, z_3, z_4] in RR_oo$.

  #fade[[$arrow.l.double$]] If $alpha(z_4) in RR_oo$, then $0, 1, oo, [z_1, z_2, z_3, z_4]$ lie on the #ponder("geometry.circle-in-riemann-sphere")[circle] $RR_oo$. So by the previous theorem, their preimages $z_1, z_2, z_3, z_4$ also lie on a #ponder("geometry.circle-in-riemann-sphere")[circle].
]
