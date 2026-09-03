#import "../prelude.typ": *

#lecture-separator(lecture: 21, date: "2026-03-12")

= Sequences and Series of Functions

We now have sufficient tools to revisit and generalise notions in @chapter-1.

== Introduction

#definition[Sequence of Functions][
  A #ponder("analysis.sequence-of-functions")[*sequence* of complex-valued functions] $(f_n)_(n in NN)$ on a set $X$ is an enumerated list $(f_1, f_2, ...)$ where each element is a function $f_i: X -> CC$.

  If, for each $x in Y subset.eq X$, the numerical sequences $(f_n (x))_(n in NN)$ #ponder("analysis.sequence-convergence")[converges], we can define a function $f: Y subset.eq X -> C$ such that
  $
    x |-> f(x) = lim_(n -> oo) f_n (x)
  $

] <definition-sequence-of-functions>

#definition[Series of Functions][
  Let $(f_n)_(n in NN)$ be a sequence of complex-valued functions. We call the enumerated sum
  $
    sum_(n=1)^oo f_n = f_1 + f_2 + ...
  $
  a #ponder("analysis.series-of-functions")[*series* of complex-valued functions] on $X$.

  If, for each $x in Y subset.eq X$, the numerical series $sum_(n=1)^oo f_n (x)$ #ponder("analysis.series")[converges], we can define a function $f: Y subset.eq X -> C$ such that
  $
    x |-> f(x) = sum_(n=1)^oo f_n (x)
  $
] <definition-series-of-functions>

Since we have discussed #ponder("analysis.continuity")[continuity], #ponder("calculus.derivative")[differentiability] and #ponder("calculus.riemann-integrable-function")[integrability] of functions, it is natural to ask whether these properties are preserved under limits.

For the easiest case of continuity we are asking whether
$
  lim_(n->oo) lim_(x->a) f_n (x) = lim_(n->oo) f_n (a) = f(a) =^? lim_(x->a) f(x) = lim_(x->a) lim_(n->oo) f_n (x).
$

#example[
  Swapping limits is not trivial. Consider $s_(n, m) = (m)/(m+n)$.

  - Fixing $n$, $lim_(m->oo) s_(n, m) = 1$ and hence $lim_(n->oo) lim_(m->oo) s_(n, m)$ = 1.

  - Fixing $m$, $lim_(n->oo) s_(n, m) = 0$ and hence $lim_(m->oo) lim_(n->oo) s_(n, m)$ = 0.
]

#remark[
  For a general and formal treatment on this issue, see Part IB Analysis II.
]

== Basics on Power Series

#definition[Power Series][
  For $a in CC$ and $(c_n)_(n in ZZ_(>=0))$, we say
  $
    sum_(n=0)^oo underbracket(c_n (x-a)^n, f_n (x))
  $
  is a #ponder("analysis.power-series")[power series] with centre $a$ and coefficients $(c_n)$.

] <definition-power-series>

#example[
  The #ponder("calculus.taylor-series")[Taylor series] of a #ponder("calculus.smooth-function")[smooth function] $f$ around $a$  is a #ponder("analysis.power-series")[power series], where
  $
    c_n = (f^((n)) (a))/(n!).
  $

]

Tautologically, any #ponder("analysis.power-series")[power series] #ponder("analysis.series")[converges] at its centre. We would like to consider if
$
  {x in CC: sum_(n=0)^oo c_n (x-a)^n}
$
has any points other than $a$. #fade[[Otherwise we can define a function by $sum c_n (x-a)^n$ only at $a$, which is not very interesting.]]

#lemma[
  If $sum_(n=0)^oo c_n (x-a)^n$ #ponder("analysis.series")[converges] for some $x$ and $abs(y-a) < abs(x-a)$, then $sum_(n=0)^oo c_n (y-a)^n$ #ponder("analysis.absolute-convergence")[converges absolutely].
] <lemma-convergence-within-radius>

#proof[
  Fix $x$ such that $sum c_n (x-a)^n$ converges, and let $y$ be such that $abs(y-a) < abs(x-a)$. Then since $sum c_n (x-a)^n$ converges, by @nth-term-test[$n$-th term test] we have $lim_(n->oo) c_n (x-a)^n = 0$.

  Hence $(c_n (x-a)^n)_(n in NN)$ is #ponder("analysis.bounded-sequence")[bounded], so there exists $M > 0$ such that
  $
    abs(c_n (x-a)^n) <= M quad forall n in NN.
  $
  Thus
  $
    abs(c_n (y-a)^n) <= abs(c_n (x-a)^n) dot abs((y-a)/(x-a))^n <= M r^n
  $
  where $r = abs((y-a)/(x-a)) < 1$. Since $sum M r^n$ converges, by #ponder("analysis.comparison-test")[comparison test] $sum abs(c_n (y-a)^n)$ converges.
]

#definition[Radius of Convergence][
  Let $sum c_n (x-a)^n$ be a #ponder("analysis.power-series")[power series]. Then $R in [0, oo]$ is called the *#ponder("analysis.radius-of-convergence")[radius of convergence]* of the #ponder("analysis.power-series")[power series], if

  - $sum c_n (x-a)^n$ #ponder("analysis.absolute-convergence")[converges absolutely] for all $x$ such that $abs(x-a) < R$.

  - if $R < oo$, then $sum c_n (x-a)^n$ diverges for all $x$ such that $abs(x-a) > R$.
] <definition-radius-of-convergence>

#remark[
  On $abs(x-a) = R$ #fade[[either 2 points if over $RR$, or a circle if over $CC$]], this definition does not enforce anything.

  Moreover, if $R = 0$, the #ponder("analysis.power-series")[power series] only #ponder("analysis.series")[converges] at $a$; if $R = oo$, the #ponder("analysis.power-series")[power series] #ponder("analysis.absolute-convergence")[converges absolutely] for all $x in CC$.
]

#proposition[
  Every #ponder("analysis.power-series")[power series] has a #ponder("analysis.radius-of-convergence")[radius of convergence].
] <proposition-radius-of-convergence-existence>

#proof[
  Define
  $
    A := {r >= 0: exists x in CC "with" abs(x-a) = r "such that" sum c_n (x-a)^n "converges"}.
  $
  Clearly $0 in A$ and $A$ is hence non-empty.

  If $A$ is #ponder("analysis.bounded-set")[unbounded], we set $R = oo$; by @lemma-convergence-within-radius, not only $forall r >= 0$, there exists $x$ with $abs(x-a) = r$ such that $sum c_n (x-a)^n$ #ponder("analysis.series")[converges], but in fact $sum c_n (x-a)^n$ #ponder("analysis.absolute-convergence")[converges absolutely] for all $x in CC$.

  Otherwise, if $A$ is #ponder("analysis.bounded-set")[bounded], let $R = sup A$. Then

  - $sum c_n (x-a)^n$ diverges for $abs(x-a) > R$ by the definition of $A$

  - if $abs(y-a) < R = sup A$, then $exists r in A$ with $abs(y-a) < r <= R$. Hence $exists x in CC$ with $abs(x-a) = r > abs(y - a)$, such that $sum c_n (x-a)^n$ #ponder("analysis.series")[converges]. By @lemma-convergence-within-radius, $sum c_n (y-a)^n$ #ponder("analysis.absolute-convergence")[converges absolutely].
]

To compute the #ponder("analysis.radius-of-convergence")[radius of convergence], we can use our usual tests for series.

#proposition[Root Test for Power Series][
  Let $(c_n)$ be a sequence in $CC$ such that
  $
    L = lim_(n->oo) root(n, abs(c_n))
  $
  exists. Then the #ponder("analysis.power-series")[power series] $sum c_n (x-a)^n$ has #ponder("analysis.radius-of-convergence")[radius of convergence]
  $
    R = (1)/(L)
  $
  with the convention that $R = 0$ if $L = oo$ and $R = oo$ if $L = 0$.
] <root-test-for-power-series>

#proposition[Ratio Test for Power Series][
  Let $(c_n)$ be a sequence in $CC$ such that
  $
    L = lim_(n->oo) abs((c_(n+1)/(c_n)))
  $
  exists. Then the #ponder("analysis.power-series")[power series] $sum c_n (x-a)^n$ has #ponder("analysis.radius-of-convergence")[radius of convergence]
  $
    R = (1)/(L)
  $
  with the convention that $R = 0$ if $L = oo$ and $R = oo$ if $L = 0$.
] <ratio-test-for-power-series>

#exercise[
  Show that

  - $abs(c_(n+1)/c_n) -> oo$ implies $R = 0$.

  - $root(n, abs(c_n)) -> oo$ implies $R = 0$.
]

#example[
  - $sum (x^n)/n!$ #ponder("analysis.series")[converges] on all of $CC$, since

    $
      abs(c_(n+1)/(c_n)) = abs(n!/(n+1)!) = 1/(n+1) -> 0 => R = oo
    $

  - $sum n! x^n$ #ponder("analysis.series")[converges] only for $x=0$.

    $
      abs(c_(n+1)/c_n) = abs((n+1)!/n!) = n+1 -> oo => R = 0
    $

  - $sum_(n=1)^oo (x^n)/(n^2)$  has $R = 1$ and #ponder("analysis.absolute-convergence")[converges absolutely] at $abs(x) = 1$.

    $
      abs(c_(n+1)/c_n) = ((n)/(n+1))^2 -> 1 => R = 1.
    $

    At $abs(x)=1$, we have $sum_(n=1)^oo abs((x^n)/(n^2)) = sum_(n=1)^oo (1)/(n^2) < oo$.

  - $sum_(n=1)^oo (x^(n))/(n)$ has $R = 1$, but behavior at $abs(x) = 1$ is more subtle.

    If $x = 1$, then it diverges as harmonic series.

    If $x != 1$, then
    $
      (1-x) sum_(n=1)^N x^(n)/(n) & = sum_(n=1)^n (x^(n)/(n) - x^(n+1)/n) \
                                  & = sum_(n=1)^n (x^(n+1)/(n+1) - x^(n+1)/n) + x - x^(N+1)/(N+1) \
                                  & = -x sum_(n=1)^n x^(n)/(n(n+1)) + x - x^(N+1)/(N+1).
    $
    Hence
    $
      sum_(n=1)^N x^(n)/(n) = (x)/(1-x) - (x)/(1-x) sum_(n=1)^n x^(n)/(n(n+1)) + (x^(N+1))/((N+1)(1-x)).
    $
    By taking the limit as $N->oo$, observe that $sum_(n=1)^oo x^(n)/(n(n+1))$ #ponder("analysis.absolute-convergence")[converges absolutely], so $sum_(n=1)^oo x^(n)/(n)$ #ponder("analysis.absolute-convergence")[converges absolutely] for all $x$ with $abs(x) = 1$ and $x != 1$.
]

#lecture-separator(lecture: 22, date: "2026-03-14")

#remark[
  The set
  $
    {x in CC: sum c_n (x-a)^n "converges"}
  $
  can be bigger or equal to
  $
    {x in CC: abs(x-a) < R}.
  $
]

== Term-by-Term Operations on Power Series

Since $f_n (x) = c_n (x-a)^n$ are polynomials, they are hence #ponder("analysis.continuity")[continuous], #ponder("calculus.riemann-integrable-function")[integrable] and #ponder("calculus.derivative")[differentiable]. It is natural to consider whether possible to conclude something about the #ponder("analysis.continuity")[continuity], #ponder("calculus.riemann-integrable-function")[integrability], #ponder("calculus.derivative")[differentiability] of
$
  f: Y & -> CC \
     x & |-> sum_(n=0)^oo c_n (x-a)^n.
$
And if so, whether
$
   (dif)/(dif x) f(x) & =^? sum_(n=0)^oo c_n (dif)/(dif x) (x-a)^k \
  integral f(x) dif x & =^? sum_(n=0)^oo c_n integral (x-a)^n dif x
$

#example[
  - $sum_(n=0)^oo x^(n)/(n!)$ #ponder("analysis.series")[converges] on all of $CC$.

    $
      sum_(n=0)^oo (1)/(n!) (dif)/(dif x) (x^n) = sum_(n=1)^oo x^(n-1)/(n-1)! = sum_(n=0)^oo x^(n)/(n!)
    $

    which again converges on all of $CC$. This seems to be consistent.

  - $sum_(n=1)^oo x^(n)/(n^2)$ #ponder("analysis.series")[converges] on $D = {x in CC: abs(x) <= 1}.$

    $
      sum_(n=0)^oo (1)/(n^2) (dif)/(dif x)(x^n) = sum_(n=1)^oo x^(n)/(n)
    $
    which does not #ponder("analysis.series")[converge] on all of $D$, but it #ponder("analysis.series")[converge] on ${x in CC: abs(x) < 1}.$ This hints that the argument above is not totally correct.
]

We need to be careful that term-by-term operations will not hold on the entire set of convergence of #ponder("analysis.power-series")[power series], but we will show that they do within the #ponder("analysis.radius-of-convergence")[radius of convergence].

#proposition[Continuity of power series][
  Let
  $
    B_R (a) & = {x in CC: abs(x - a) < R} \
    D_r (a) & = {x in CC: abs(x-a)<= r}.
  $


  Let $sum_(n=0)^oo c_n (x-a)^n$ have a #ponder("analysis.radius-of-convergence")[radius of convergence] $R>0$. Then
  $
    f: B_R (a) & -> CC \
             x & |-> sum_(n=0)^oo c_n (x-n)^n
  $
  is #ponder("analysis.continuity")[continuous] inside $D_r (a)$ for every $r < R$.
] <proposition-continuity-of-power-series>

#proof[
  #fade[[Non-examinable.]]

  Let
  $
    S_N (x) & = sum_(n <= N) c_n (x-a)^n, quad   & "which is a polynomial of degree" N \
    T_N (x) & = sum_(n >= N+1) c_n (x-a)^n, quad &               "which is a \"tail\""
  $
  and note the tail estimate
  $
    abs(T_N (x)) <= sum_(n >= N+1) abs(c_n) abs(x- a)^n <= sum_(n >= N+1) abs(c_n) r^n quad forall x in D_r (a).
  $
  By the definition of #ponder("analysis.radius-of-convergence")[radius of convergence], $forall epsilon > 0, exists N = N(epsilon)$ such that
  $
    sum_(n >= N+1) abs(c_n) r^n < epsilon => abs(T_N (x)) < epsilon quad forall x in D_r (a).
  $
  Take $x_0 in D_r (a)$. We want to show that it is #ponder("analysis.continuity")[continuous] at $x_0$. We have
  $
    abs(f(x) - f(x_0)) & = abs(S_N (x) - S_N (x_0) + T_N (x) - T_N (x_0)) \
                       & <= abs(S_N (x) - S_N (x_0)) + abs(T_N (x)) + abs(T_N (x_0)) \
                       & < abs(S_N (x) - S_N (x_0)) + 2 epsilon quad forall x in D_r (a).
  $
  To conclude the proof, choose $delta= delta(epsilon)$ so that
  $
    abs(S_N (x) - S_N (x_0)) < epsilon
  $
  which is possible because $S_N$ is a polynomial.
]

#proposition[Integration of Power Series][
  Let $sum_(n=0)^oo c_n (x-a)^n$ have a #ponder("analysis.radius-of-convergence")[radius of convergence] $R > 0$. Then
  $
    f: (a-R, a+R) & -> RR \
                x & |-> sum_(n=0)^oo c_n (x-a)^n
  $
  is #ponder("calculus.riemann-integrable-function")[integrable] on $[a-r, a+r]$ for every $r < R$, and
  $
    integral_a^x f(t) dif t & = sum_(n=0)^oo c_n integral_a^x (t-a)^n dif t \
                            & = sum_(n=0)^oo (c_n)/(n+1) (x-a)^(n+1).
  $

] <proposition-integration-of-power-series>

#proof[
  #fade[[Non-examinable.]]

  We use the same split
  $
    f(x) = S_N (x) + T_N (x).
  $
  Then
  $
    abs(integral_a^x f(t) dif t - sum_(n <= N) (c_n (x-a)^(n+1))/(n+1)) & = abs(integral_a^x f(t) dif t - integral_a^x S_N (t) dif t) \
    & = abs(integral_a^x T_N (t) dif t) \
    & <= sup_(abs(t-a) < r) abs(T_N (t)) abs(integral_a^x dif t) \
    & <= r dot sup_(abs(t-a) < r) abs(T_N (t)) \
    & < r epsilon
  $
  if we choose $N$ large enough. Hence
  $
    integral_a^x f(t) dif t = lim_(N->oo) sum_(n <= N) (c_n (x-a)^(n+1))/(n+1) = sum_(n=0)^oo (c_n (x-a)^(n+1))/(n+1) .
  $
]

#proposition[Differentiation of Power Series][
  Let $sum c_n (x-a)^n$ and $f$ as in the previous proposition. Then $f$ is #ponder("calculus.derivative")[differentiable] on $(a-R, a+R)$, and
  $
    f'(x) = sum_(n=0)^oo c_n (dif)/(dif x) (x-a)^n = sum_(n=1)^oo n c_n (x-a)^(n-1).
  $
] <proposition-differentiation-of-power-series>
#proof[
  #fade[[Non-examinable.]]

  If $g(x) = sum_(n=1)^oo n c_n (x-a)^(n-1)$ has a #ponder("analysis.radius-of-convergence")[radius of convergence] $R' >= R$, then $g$ is #ponder("analysis.continuity")[continuous] on $[a-r, a + r]$ for every $r < R$ by @proposition-continuity-of-power-series, and by @proposition-integration-of-power-series we have
  $
    integral_a^x g(t) dif t = sum_(n=1)^oo n c_n integral_a^x (t-a)^(n-1) dif t = sum_(n=1)^oo c_n (x-a)^n = f(x) - c_0.
  $
  Hence, by @thm-fundamental-theorem-calculus-part-1[Fundamental Theorem of Calculus], we have
  $
       & f'(x) = g(x) quad & forall x in [a -r, a + r], forall r < R \
    => & f'(x) = g(x) quad &              forall x in (a - R, a + R)
  $

  It remains to show that new series has #ponder("analysis.radius-of-convergence")[radius of convergence] $>=R$. Take $r < R$, then we have some $s in (r, R)$. THen
  $
    abs(n c_n (x-a)^(n-1)) & <=abs(c_n) s^n (n)/(s) (abs(x-a)/s)^(n-1) \
                           & <= abs(c_n) s^n (n)/(s) (r/s)^(n-1) quad  & forall abs(x-a) < r. \
  $
  Since $s < R$, $abs(c_n) s^n stretch(->)_(n->oo) 0$ by the definition of #ponder("analysis.radius-of-convergence")[radius of convergence]. Hence $exists M$ such that $abs(c_n) s^n < M/s$ for all $n >= 0$. Thus
  $
    abs(n c_n (x-a)^(n-1)) <= M (n)/(s) ((r)/(s))^(n-1) quad forall abs(x-a) < r.
  $
  Now
  $
    sum_(n=0)^oo (M n)/(s) ((r)/(s))^(n-1) "converges since" (r)/(s) < 1.
  $
  Hence,
  $
    sum_(n=1)^oo n c_n (x-a)^(n-1) "converges absolutely for all" abs(x-a) < r, forall r < R.
  $
]

#example[
  - $sum_(n=0)^oo x^(n)/(n!)$  has $R = oo$. So

    $
           (dif)/(dif x) sum_(n=0)^oo x^(n)/(n!) & = sum_(n=1)^oo x^(n-1)/(n-1)! = sum_(n=0)^oo x^(n)/(n!) \
      integral_0^x sum_(n=0)^oo x^(n)/(n!) dif t & = sum_(n=0)^oo (x^(n+1))/((n+1)(n!)) = sum_(n=1)^oo (x^(n))/(n!) \
                                                 & = sum_(n=0)^oo x^(n)/(n!) - 1.
    $

  - $sum_(n=1)^oo x^(n)/(n^2)$ has $R = 1$. For $abs(x) < 1$, we have

    $
             dif/(dif x) sum_(n=1)^oo x^(n)/(n^2) & = sum_(n=1)^oo x^(n-1)/n \
      integral_0^x sum_(n=1)^oo x^(n)/(n^2) dif t & = sum_(n=1)^oo (x^(n+1))/((n+1)(n^2)).
    $


]

#lecture-separator(lecture: 23, date: "2026-03-17")

== Exponential and Logarithms

#exercise[
  Using familiar properties of $exp$, namely $(dif)/(dif x) ee^x = ee^x$, to show that they #ponder("calculus.taylor-series")[Taylor series] of $ee^x$ at $x=0$ is, with #ponder("analysis.radius-of-convergence")[radius of convergence] $R= oo$,
  $
    sum_(n=0)^oo x^(n)/(n!).
  $

  More ambitiously, #ponder("calculus.taylors-theorem")[Taylor's theorem] says that $exists xi in [0, x]$
  $
    R_(N, 0) (x) - sum_(n <= N-1)x^(n)/(n!) = (ee^xi)/(N!) x^N.
  $

  For fixed $x in RR$,
  $
    abs(R_(N, 0) (x)) <= abs(ee^xi) abs(x)^(N)/(N!) -> 0 quad "as" N->oo.
  $
  Hence $ee^x = sum_(n=0)^oo x^(n)/(n!)$ for all $x in RR$.

]

#lemma[

  We define
  $
    e: CC & -> CC \
        z & |-> sum_(n=0)^oo z^(n)/(n!)
  $
  with #ponder("analysis.radius-of-convergence")[radius of convergence] $R = oo$.

  With this definition,

  1. $e$ is #ponder("calculus.smooth-function")[smooth] with $e'(z)=e(z)$,

  2. $e(0) = 1$,

  3. $e(a+b) = e(a) e(b)$.
] <lemma-e-1>

#proof[
  (1) and (2) are immediate from what we know about #ponder("analysis.power-series")[power series]. For (3), let
  $
    f(z) = e(a+b-z) e(z).
  $
  Then
  $
    f'(z) & = -e'(a+b-z)e(z) + e(a+b-z)e'(z) \
          & = -f(z) + f(z) = 0 quad forall z.
  $
  Hence $f$ is constant on $CC$, and thus
  $
    e(a) e(b) = f(a) = f(0) = e(a+b).
  $
]

#lemma[
  Consider $e: RR -> RR$, the restirction of $e$ to the real axis. Then

  1. $e$ is #ponder("calculus.smooth-function")[smooth] with $e'(x) = e(x)$,

  2. $e(x+y) = e(x) e(y)$,

  3. $e(x) > 0$ for all $x in RR$,

  4. $e$ is #ponder("analysis.monotone-function")[strictly increasing],

  5. $e(x) -> oo$ as $x->oo$, and $e(x) -> 0$ as $x->-oo$,

  6. $e: RR -> (0, oo)$ is a #ponder("algebra.bijection")[bijection].
] <lemma-real-exponential>

#proof[
  (1) and (2) follows immediately from @lemma-e-1.

  For $x > 0$, every term in the series is non-negative, so
  $
    e(x) > 1+ x => cases(
      e(x) > 0 & quad "for" x >= 0,
      e(x) -> oo & quad "as" x->oo
    )
  $

  For $x < 0$, $e(-x) e(x) = e(0) = 1$. Hence $e(-x) = e(0)/(e(x)) = (1)/(e(x))$. Then
  $
    cases(
      e(x)> 0 & quad forall x < 0,
      e(-x) -> 0^+ & "as" x-> -oo
    )
  $
  It follows that

  - $e'(x) = e(x) > 0$ gives that $e$ is #ponder("analysis.monotone-function")[strictly increasing], and that $e$ is #ponder("set-theory.injection-surjection")[injective].

  - given $y in (0, oo)$ = $(lim_(x->-oo) e(x), lim_(x->oo) e(x))$, there are $a, b in RR$ such that $e(a) < y < e(b)$. By @intermediate-value-theorem[Intermediate Value Theorem], $exists x in [a, b]$ such that $e(x) = y$. Hence $e$ is #ponder("set-theory.injection-surjection")[surjective].

  Thus we have proved all statements.

]

Since $e: RR->(0, oo)$ is a #ponder("algebra.bijection")[bijection], it must have an inverse. We will call it $ell: (0, oo) -> RR$.

#lemma[
  For $ell$ as defined above, we have

  1. $ell: (0, oo) -> RR$ is a #ponder("algebra.bijection")[bijection] with $ell(e(x)) = x$ for all $x in RR$, $e(ell(y))= y$ for all $y in (0, oo)$.

  2. $ell$ is #ponder("calculus.smooth-function")[smooth] and #ponder("analysis.monotone-function")[monotone] with $ell'(y) = (1)/(y)$.

  3. $ell(1) = 0$ and $ell(y) = integral_1^y (1)/(t) dif t$.

  4. $ell(y z) = ell(y) + ell(z)$

  5. $ell(y) -> oo$ as $y->oo$, and $ell(y) -> -oo$ by $y -> 0^+$.
] <lemma-natural-logarithm>

#proof[
  (1) follows from the definition of inverse. It also gives us that $exists u, v$ such that
  $
    ell(y z) = ell(e(u) e(v)) = ell(e(u+v)) = u+v = ell(y) + ell(z)
  $
  where $y=e(u) <=> u = ell(y)$, and $z = e(v) <=> v = ell(z)$.

  Using @inverse-function-theorem-version-2[Inverse Function Theorem], we get that $ell$ is #ponder("calculus.smooth-function")[smooth], and $ell'(y) = (1)/(e'(ell(y))) = (1)/(y)$.

  Since $y > 0$ in the domain of $ell$, $ell$ is #ponder("analysis.monotone-function")[monotone].

  Since $e(0) = 1 <=> e(1) = 0$, by @thm-fundamental-theorem-calculus-part-1[Fundamental Theorem of Calculus],
  $
    ell(y) & = integral_1^y ell'(t) dif t \
           & = integral_1^y (1)/(t) dif t.
  $

  #exercise[
    The final part is left as an exercise.
  ]
]

#remark[
  $
    ell(1+y) = integral_1^y (dif t)/(1+t) & = integral_1^y (1)/(1-(-t)) dif t \
    & = integral_1^y underbracket(sum_(n=0)^oo (-1)^n t^n, R=1) dif t &quad "given" abs(t) <= abs(y) < 1\
    &= sum_(n=0)^oo integral_1^y (-1)^n t^n dif t& quad forall abs(y) < 1\
    &= sum_(n=0)^oo (-1)^(n)/(n+1) y^(n+1) &quad forall abs(y) < 1.
  $
  One can push this, in Part IB Analysis II, to show that
  $
    sum_(n=1)^oo (-1)^(n-1)/(n) = ell(2).
  $
]

We shall define
$
  Gamma_alpha (x) = e(alpha ell(x))
$
#fade[[The aim is to show that $Gamma_alpha (x) = x^alpha$.]]

#lemma[
  Let $x, y > 0$, $alpha, beta in RR$. Then

  1. $Gamma_alpha (x y) = Gamma_alpha (x) Gamma_alpha (y)$

  2. $Gamma_(alpha + beta) (x) = Gamma_alpha (x) Gamma_beta (x)$

  3. $Gamma_alpha (Gamma_beta (x)) = Gamma_(alpha beta) (x)$

  4. $Gamma_1 (x) = x$, $Gamma_0 (x)$ = 1.
] <lemma-general-powers>

#proof[
  (1) and (2) follow by group isomorphism properties of $e$ and $ell$. (4) is clear from the analogous statements for $e$ and $ell$. Now for (3),
  $
    Gamma_alpha (Gamma_beta (x)) & = e(alpha ell (e (beta ell (x)))) \
                                 & = e(alpha beta ell(x)) = Gamma_(alpha beta ) (x).
  $
]
#corollary[
  Take $p, q in ZZ$, then

  - $Gamma_p (x) = underbracket(Gamma_1 (x) dot dots.c dot Gamma_1 (x), p "products") = x^p$,

  - $Gamma_(-p) (x) = x^(-p)$ by (3),

  - $(Gamma_(1/p) (x))^p = underbracket(Gamma_(1/p) (x) dot dots.c dot Gamma_(1/p) (x), p "products") = Gamma_1 (x) = x$, and so $Gamma_(1/p) (x) = x^(1/p)$,

  - $x^(p/q) = Gamma_(p/q) (x)$.
] <corollary-rational-powers>

We have that $Gamma_alpha (x) =x^alpha$ for $alpha in QQ$. Thus
$
  e(x) = e(x log ee) = Gamma_x (ee) = ee^x.
$
This allows us to identify $e(x) = ee^x$ and use standard notation. We shall write $ell = log$ from now on.

#proposition[Exponentials, Powers and Logarithms][
  1. $x^r ee^(-x) -> 0$ as $x -> oo$,

  2. $x^(-r) log x -> 0$ as $x -> oo$,

  3. $x^r log x -> 0^+$ as $x->0^+$.
] <proposition-growth-comparisons>

#proof[
  1. Let $x > 1$,

    $
      ee^x = sum_(k>=0) x^(k)/(k!) > x^(n)/(n!)
    $
    for any $n in NN, x > 0$. Choose $n -r >= 1$. Then
    $
      0 <= x^(r)/(ee^x) <= n!/x^(n-r) <= n!/x -> 0 quad "as" x->oo.
    $

  2. $t^(-1) <= t^(epsilon - 1)$, $t >= 1$ and any $epsilon > 0$. Pick $epsilon in (0, r)$. Then
  $
    0 <= x^(-r) log x = x^(-r) integral_1^x (dif t)/(t) <= x^(-r) integral t^(epsilon - 1) dif t <= x^(epsilon -r)/(epsilon) stretch(->)_(n->oo) 0
  $

  3. $lim_x->0^+ x^r log x stretch(=)^(x = ee^(-t)) -lim_(t->oo) t ee^(-r t) stretch(=)^(y = r t) = - lim_(y ->0 ) (y ee^(-y))/(r) = 0$.
]

#lecture-separator(lecture: 24, date: "2026-03-19")

== Trigonometric Functions

With A-Level knowledge about $sin$ and $cos$, we can calculate the #ponder("calculus.taylor-series")[Taylor series] of them at $x=0$. Moreover, using #ponder("calculus.taylors-theorem")[Taylor's theorem], we can show that for all $x in RR$,
$
  sin x & = sum_(n=0)^oo (-1)^n x^(2n+1)/((2n+1)!) \
  cos x & = sum_(n=0)^oo (-1)^n x^(2n)/((2n)!)
$

#lemma[
  We define
  $
    c : CC & -> CC \
         z & |-> (1)/(2) [e(ii z) + e(-ii z)] = sum_(k=0)^oo (-1)^k z^(2k)/((2k)!), \
     s: CC & -> CC \
         z & |-> (1)/(2 ii) [e(ii z) - e(-ii z)] = sum_(k=0)^oo (-1)^k z^(2k+1)/((2k+1)!).
  $
  Note that both series have #ponder("analysis.radius-of-convergence")[radius of convergence] $R = oo$. We will show that $c$ and $s$ are the #ponder("calculus.complex-trigonometric-functions")[complex cosine and sine functions], respectively.

  With this definition, for $w, z in CC$,

  1. $c(0) = 1, s(0) = 0$

  2. $c'(z) = -s(z), s'(z)= c(z)$

  3. $s(z+w) = s(z) c(w) + c(z) s(w)$

  4. $c(z+w) = c(z) c(w) - s(z) s(w)$

  5. $c^2(z) + s^2(z)= 1$.
] <lemma-trigonometric-functions>

#proof[
  All statements follow from the definition and properties of $e$. For example, for (4),
  $
    c(z)c(w) - s(z)s(w) & = (1)/(4) (ee^(ii z) + ee^(-ii z))(ee^(ii w) + ee^(-ii w)) + (1)/(4) (ee^(ii z) - ee^(-ii z))(ee^(ii w) - ee^(-ii w)) \
    &=(1)/(2) (ee^(ii z) ee^(ii w) + ee^(-ii z) ee^(-ii w))\
    & = c(z+w).
  $
  Taking $z = -w$, we get (5).
]

#remark[
  From (5), $forall x in RR$,
  $
    s^2(x) + c^2(x) = 1 => abs(s(x)) <= 1, abs(c(x)) <= 1.
  $
  Note that this is generally not true for complex $z$.
]

#proposition[Periodicity of Trignometric Functions][
  There is a smallest positive $omega$ such that $c((omega)/(2)) = 0, s((omega)/(2)) = 1$, and

  1. $s: RR->RR, c: RR->RR$ are #ponder("analysis.periodicity-of-trigonometric-functions")[periodic] with period $2 omega$, _i.e._

    $
      s(x+2omega) = s(x), quad c(x+2omega) = c(x) quad forall x in RR.
    $

  2. $s(x+omega) = -s(x), c(x+omega) = -c(x)$ for all $x in RR$.

  3. $s(x+(omega)/(2)) = c(x), c(x+(omega)/(2)) = -s(x)$ for all $x in RR$.
] <proposition-periodicity-of-trigonometric-functions>

#proof[
  Once we have existence of smallest $omega > 0$ such that $c((omega)/(2)) = 0, s((omega)/(2)) = 1$, the rest of the statements follow from @lemma-trigonometric-functions.

  Let us find the smallest such $omega$. Starting from looking at $x in (0, 2)$, we have

  $
    c'(x) = -s(x) = - [underbracket(x -(x^3)/(3!), >0) + underbracket((x^5)/(5!) - (x^7)/(7!), >0) + dots.c] < 0.
  $

  Thus $c(x)$ is #ponder("analysis.monotone-function")[strictly decreasing] on $(0, 2)$, and thus it has at most one root in $(0, 2)$. To see the existence of the root,
  $
    c(sqrt(2) ) &= underbracket(1-(sqrt(2) )^(2)/(2!), >0) + underbracket((sqrt(2) )^(4)/(4!) - (sqrt(2) )^(6)/(6!), >0) + dots.c > 0\
    c(sqrt(3) ) &= underbracket(1 - (sqrt(3))^(2)/(2!) + (sqrt(3))^(4)/(4!), -1slash 8) - underbracket((sqrt(3))^(6)/(6!) + (sqrt(3))^(8)/(8!), >0) - underbracket((sqrt(3))^(10)/(10!) + (sqrt(3))^(12)/(12!), >0) - dots.c < 0.
  $
  By @intermediate-value-theorem[Intermediate Value Theorem], there is a root in $(omega)/(2 )= (sqrt(2), sqrt(3)) subset.eq (0, 2)$. Now
  $
    s^2((omega)/(2)) = 1-c^2((omega)/(2)) = 1 => s((omega)/(2)) = plus.minus 1.
  $
  But since $(omega)/(2) in (0, 2)$ we get $s((omega)/(2)) > 0$, so $s((omega)/(2)) = 1$.
]

#corollary[
  1. The function $ee^(ii x)$ for $x in RR$ is #ponder("calculus.exponential-periodicity")[periodic] with period $2 omega$

  2. $ee^(ii omega) = -1$ #fade[[_c.f._ #ponder("calculus.complex-trigonometric-functions")[Euler's identity] $ee^(ii ppi) + 1 = 0.$]]

  3. $ee^((ii omega)/(2)) = ii$.
]

Finally, we need to relate $omega$ to the more familiar $ppi$.

#lemma[
  $2 omega$ is the perimeter of the unit circle,
  $
    SS^1 = {z in CC: abs(z) = 1}.
  $
] <lemma-unit-circle-perimeter>

#proof[
  If we can show $gamma: [0, 2 omega) -> SS^1$ with $t |-> ee^(ii t)$ is a #ponder("algebra.bijection")[bijection], then we get that
  $
    "perimeter of" SS^1 = "length of" gamma = integral_0^(2 omega) abs(gamma'(t)) dif t = integral_0^(2 omega) abs(ii ee^(ii t)) dif t = 2 omega.
  $

  To show that $gamma$ is a surjection, take $z in SS^1$ written as $z = a+ ii b$ with $a^2 + b^2 = 1$, and $a, b in RR$. We have

  - $c: [0, omega] -> [-1, 1]$ is #ponder("analysis.continuity")[continuous] and #ponder("analysis.monotone-function")[strictly monotone], hence $exists t in [0, omega]$ with $c(t) = a$.
  - $s: [0, omega] -> [0, 1]$ is non0negative, hence $s(t) = sqrt(1-a^2)$. Then if $b = sqrt(1-a^2)$, we get $s(t) = b$. If $b = -sqrt(1-a^2)$, we get $b = -s(t) = s(2 omega- t)$.

  Hence for every $z in SS^1$, there is some $t in [0, 2 omega)$ such that $gamma(t) = z$.

  To show that $gamma$ is an #ponder("set-theory.injection-surjection")[injection], since $ee^(ii t)$ has least positive positive $2 omega$, it is #ponder("set-theory.injection-surjection")[injective] when restricted to $[0, 2 omega)$.
]

Hence $omega = ppi$, and $c(z) = cos z, s(z) = sin z$ for all $z in CC$. We can now define $tan, arccos$ etc.

We can further define, for $z in CC$,
#ponder("analysis.hyperbolic-functions")[
$
  cosh = 1/2 (e^z + e^(-z)) = cos (ii z), quad sinh = 1/2 (e^z - e^(-z)) = oo sin (ii z).
$
]

#proposition[
  For $z in CC$,

  1. $cosh'(z) = sinh(z)$

  2. $sinh'(z) = cosh(z)$

  3. $cosh^2(z) - sinh^2(z) = 1$.
] <proposition-hyperbolic-functions>

#exercise[
  The proof is left as an exercise. It should be similar to the proof of @lemma-trigonometric-functions.
]

