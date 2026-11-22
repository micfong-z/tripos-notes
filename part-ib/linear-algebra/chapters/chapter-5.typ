#import "../prelude.typ": *
#show: chapter.with(5)

// #show <intuition>: none

= Interlude --- Polynomials

== Definitions

Let $FF$ be a field. A *polynomial* over $FF$ is an expression of the form
$
  f(t) = a_n t^n + a_(n-1) t^(n-1) + ... + a_1 t + a_0
$
for some $n >= 0$, $a_i in FF$ #fade[[coefficients]]. We write

$
  FF[t] = {"polynomial expressions over" FF}
$

which is an $FF$-vector space and is not finite-dimensional.

The *degree* of $f(t) in FF[t]$ is
$
  deg f := "the largest" m "such that" a_m != 0.
$
This $a_m$ is the *leading coefficient* of $f$, and $f$ is *monic* if its leading coefficient is $1$.

#remark[
  By convention, we define $deg 0 := -oo$.
]

== Arithmetic

Consider
$
  f(t) =sum_(i=0)^n a_i t^i, quad g(t) = sum_(j=0)^m b_j t^j.
$

Then
$
  (f + g) (t) "has" t^k "coefficients" a_k + b_k, quad (f g)(t) "has" t^k "coefficients" sum_(i = 0)^k a_i b_(k-i).
$

Note that $deg(f + g) <= max(deg f, deg g)$ and $deg(f g) = deg f + deg g$.

We write $f divides g$ if $exists h in FF[t]$ such that $g = f h$.

For $lambda in FF$, write
$
  f(lambda) = sum_(i=0)^n a_i lambda^i in FF
$
so that $(f+g) (lambda) = f(lambda) + g(lambda)$ and $(f g)(lambda) = f(lambda) g(lambda)$.

#warning[
  If $FF$ is finite, then $FF[t]$ is not isomorphic to the space of polynomial functions $FF -> FF$.

  #fade[[$FF[t]$ has $oo$ dimensions, but $FF^FF$ is finite-dimensional.]]
]


#proposition[Euclidean Algorithm][
  For all $f, g in FF[t], g!=0$, there exist $q, r in FF[t]$ such that
  $
    f = q dot g + r
  $
  and $deg r < deg g$.
] <prop-euclidean-algorithm>

#prooflike[Sketch proof][
  Let $f(t) = sum_(i=0)^n a_i t^i$, $g(t) = sum_(j=0)^m b_j t^j$. Then $deg f = n, deg g = m >= 0$.

  - If $m > n$, set $q = 0$ and $r = f$.

  - For $n >= m$, set
    $
      f'(t) = f(t)- (a_n / b_m) t^(n-m) g(t)
    $
    Then $deg f' < deg f$. We can apply induction on $deg f$ to complete the proof.
]

#intuition[
  For example, take $f = 4t^3 + 2t^2 - t + 3$ and $g = 2t^2 + 1$, so $a_n = cblue(4)$ and $b_m = 2$. Each multiple of $g$ cancels the leading coefficient above it.
  #align(center, table(
    columns: 6,
    align: (left, right, right, right, right, left),
    stroke: (_, y) => (top: if y in (1, 3, 5) { 0.75pt + colors.border-dark } else { none }),
    table.header[][$t^3$][$t^2$][$t$][$1$][],
    [$f$], [$cblue(4)$], [$2$], [$-1$], [$3$], [$deg f = 3$],
    [$-cred(2t) dot g$], [$-4$], [$0$], [$-2$], [$0$], [$cred(2t) = (cblue(4) slash 2) t^(3-2)$],
    [$f'$], [$cgray(0)$], [$cblue(2)$], [$-3$], [$3$], [$deg f' = 2$],
    [$-cred(1) dot g$], [], [$-2$], [$0$], [$-1$], [$cred(1) = (cblue(2) slash 2) t^(2-2)$],
    [$r$], [], [$cgray(0)$], [$-3$], [$2$], [$deg r = 1 < deg g$],
  ))
  So $q = cred(2t + 1)$ and $r = -3t + 2$.
]

#corollary[Bezout Lemma][
  If $f_1, ..., f_k in FF[t]$ have no common factor of $deg >= 1$, then $exists p_1, ..., p_k in FF[t]$ such that
  $
    sum_(i=1)^k f_i (t) p_i (t) = 1.
  $
] <cor-bezout-lemma>

#proof[
  Same as for integers, using @prop-euclidean-algorithm[Euclidean Algorithm].
]

#intuition[
  The proof is the one for integers, with degree in place of size, applied to $I = Set(sum_i f_i p_i; p_i in FF[t])$.
  #fletcher-diagram(
    spacing: 4.4em,
    node-stroke: 0.6pt + colors.border-dark,
    node-inset: 0.35em,
    label-size: 0.8em,
    node-corner-radius: 0.2em,
    node((0, 0), [$d in I without {0}$ \ of least degree], name: <bez-a>),
    node((1, 0), [$f_i = q_i d + r_i$, \ $r_i in I$, $deg r_i < deg d$], name: <bez-b>),
    node((2, 0), [$r_i = 0$, so \ $d divides f_i$ for all $i$], name: <bez-c>),
    node((3, 0), [$deg d = 0$, so \ $1 = d^(-1) d in I$], name: <bez-d>),
    edge(<bez-a>, <bez-b>, align(center)[Euclidean \ Algorithm], "->"),
    edge(<bez-b>, <bez-c>, align(center)[least \ degree], "->"),
    edge(<bez-c>, <bez-d>, align(center)[no common \ factor], "->"),
  )
]

#lemma[
  For $lambda in FF$,
  $
    f(lambda) = 0 quad <=> quad (t - lambda) divides f(t).
  $
]

#proof[
  Apply @prop-euclidean-algorithm[Euclidean Algorithm] to $f(t)$ and $g(t) = t-lambda$.
]

#definition[Root][
  $lambda in FF$ is a *root* of $f in FF[t]$ of multiplicity $>= e$ if
  $
    (t - lambda)^e divides f(t).
  $
]

#corollary[
  If $deg f = n >= 0$, then $f$ has at most $n$ roots in $FF$ (counted with multiplicity).
]

#corollary[
  If $deg f, deg g < n$ and $lambda_(1), ..., lambda_n in FF$ are distinct such that $f(lambda_i) = g(lambda_i)$ for all $i$, then $f = g$.
]

#theorem[Fundamental Theorem of Algebra][
  For $f in CC[t]$ of degree $n>=1$, $f$ has exactly $n$ roots in $CC$ (counted with multiplicity).
] <thm-fundamental-theorem-of-algebra>

For the proof of @thm-fundamental-theorem-of-algebra[Fundamental Theorem of Algebra], see IB Complex Analysis.

#lecture-separator(lecture: 14, date: "2026-11-09")

For $a_(i j) (t) in FF[t]$, we have a matrix $matbold(A) = MM_(n times n)(FF[t])$. Then by @def-leibniz-formula-for-determinants[Leibniz Formula], $det matbold(A) in FF[t]$.
