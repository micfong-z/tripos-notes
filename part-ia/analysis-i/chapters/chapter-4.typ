#import "../prelude.typ": *

= Integration

== Basics

We want to define $integral_a^b f(x) dif x$ as the signed area under the graph of $f$. If the region enclosed by the graph if a simple shape, then we can define the area using geometry. However, in general, the region may be very complicated, and we need to try to approximate.

#align(center)[
  #dynamic-svg("/part-ia/analysis-i/media/d1e3.svg", width: 36em)
]

#definition[Upper/Lower Riemann Sums][
  Let $f: [a, b] -> RR$ be bounded. Given a partition, $cal(P) = {x_0, x..., x_n}$ with $a = x_0 < x_1 < ... < x_n = b$, we set
  $
    L(f, cal(P)) & = sum_(j=1)^n (x_j - x_(j-1)) inf_(x in [x_(j-1), x_j]) f(x) \
    U(f, cal(P)) & = sum_(j=1)^n (x_j - x_(j-1)) sup_(x in [x_(j-1), x_j]) f(x)
  $
  where $L$ is the *#ponder("calculus.upper-lower-riemann-sums")[lower Riemann sum]* and $U$ is the *#ponder("calculus.upper-lower-riemann-sums")[upper Riemann sum]* of $f$ associated with $cal(P)$.
] <upper-lower-riemann-sums>

#example[
  Consider, on $[0, 1]$, the function
  $
    f(x) = cases(
      1 quad "if" x in QQ,
      0 quad "if" x in.not QQ
    )
  $
  No matter what $cal(P)$ we take, we always have rationals and irrationals in each subinterval $I_j = [x_(j-1), x_j]$, hence
  $
    U(f, cal(P)) & = 1 dot sum_(j=1)^n (x_j - x_(j-1)) = 1 \
    L(f, cal(P)) & = 0 dot sum_(j=1)^n (x_j - x_(j-1)) = 0.
  $
] <dirichlet-function>

#remark[
  If $f$ is bounded, then $sup_[a, b] abs(f) = k$ for some $k$, and
  $
    U(f, cal(P)) & <= sum_(j=1)^n sup_[a, b] abs(f) (x_j - x_(j-1)) = k (b-a) \
    L(f, cal(P)) & >= sum_(j=1)^n (-sup_[a, b] abs(f)) (x_j - x_(j-1)) = -k (b-a).
  $
  Also, $U(f, cal(P)) >= L(f, cal(P))$, hence both
  $
    {L(f, cal(P)): cal(P) "is a partition of" [a, b]} quad "and" quad {U(f, cal(P)): cal(P) "is a partition of" [a, b]}
  $
  are non-empty #ponder("analysis.bounded-set")[bounded sets].
]

#definition[Upper/Lower Integral][
  Let $f: [a, b] -> RR$ be bounded. We say
  $
    I_*(f) = sup_cal(P) L(f, cal(P)) quad "and" quad I^*(f) = inf_cal(P) U(f, cal(P))
  $
  to be the *#ponder("calculus.upper-lower-integral")[lower integral]* and *#ponder("calculus.upper-lower-integral")[upper integral]* of $f$ on $[a, b]$ respectively.

  We say $f$ is *#ponder("calculus.riemann-integrable-function")[Riemann integrable]* on $[a, b]$ if $I_*(f) = I^*(f)$, and in this case we set
  $
    I(f) = integral_a^b f(x) dif x = I_*(f) = I^*(f).
  $
] <upper-lower-integral>

#remark[
  By the way we set up the sums, $integral_a^b f dif x = -integral_b^a f dif x$.
]

#example[
  Take the function on $[0, 1]$, defined by
  $
    f(x) = cases(
      1 quad "if" x in QQ,
      0 quad "if" x in.not QQ
    )
  $
  as before, we have $I^* (f) = 1$, $I_* (f) = 0$, and $f$ is not #ponder("calculus.riemann-integrable-function")[Riemann integrable].
]

#lecture-separator(lecture: 15, date: "2026-02-26")

The coarsest partition of $[a, b]$ is $cal(P) = {a, b}$. Our intuition is that a #ponder("calculus.partition-refinement")[finer partition] leads to a better estimate for the area.

#lemma[
  Let $cal(P), cal(P')$ be partitions of $[a, b]$, such that $cal(P') supset.eq cal(P)$, such that $cal(P')$ is a #ponder("calculus.partition-refinement")[refinement] of $cal(P)$. Then
  $
    L(f, cal(P)) <= L(f, cal(P')) <= U(f, cal(P')) <= U(f, cal(P)).
  $
] <lemma-refinement>

#proof[
  We can do this by induction. Let
  $
    cal(P) = {x_0, x_1, ..., x_n},
  $
  and choose some $y in (x_(k-1), x_k)$ for some $k$. Let $cal(P') = {y} union cal(P)$. Then
  $
    sup_([x_(k-1), y]) f(x), sup_([y, x_k]) f(x) &<= sup_([x_(k-1), x_k]) f(x)\
    (y-x_(k-1)) sup_([x_(k-1), y]) f(x) + (x_k - y) sup_([y, x_k]) f(x) &<= ((y - x_(k-1)) + (x_k - y)) sup_([x_(k-1), x_k]) f(x)\
    (y-x_(k-1)) sup_([x_(k-1), y]) f(x) + (x_k - y) sup_([y, x_k]) f(x) &<= (x_k - x_(k-1)) sup_([x_(k-1), x_k]) f(x)\
    U(f, cal(P')) &<= U(f, cal(P)).
  $
  So similarly, using $inf$ instead of $sup$, we can show $L(f, cal(P)) <= L(f, cal(P'))$.

  This argument can be repeated for any #ponder("calculus.partition-refinement")[refinement],
  $
    cal(P') \\ cal(P) = {y_1, y_2, ..., y_m},
  $
  and the result follows by induction.
]

#lemma[
  Let $cal(P), cal(P')$ be partitions of $[a, b]$ #fade[[not necessarily #ponder("calculus.partition-refinement")[refinements] of each other]]. Then
  $
    L(f, cal(P)) <= U(f, cal(P')).
  $
]

#proof[
  Note that $cal(P), cal(P') subset.eq cal(P) union cal(P')$. By @lemma-refinement, we have
  $
    L(f, cal(P)) <= L(f, cal(P) union cal(P')) <= U(f, cal(P) union cal(P')) <= U(f, cal(P')).
  $
]

#lemma[
  If $f: [a, b] -> RR$, then $I_*(f) <= I^*(f)$.
]

#proof[
  We have
  $
                 L(f, cal(P)) & <= inf_cal(P') U(f, cal(P')) \
    sup_(cal(P)) L(f, cal(P)) & <= inf_cal(P') U(f, cal(P')) \
                       I_*(f) & <= I^*(f).
  $
]

#remark[
  This means that $f$ is #ponder("calculus.riemann-integrable-function")[integrable] iff $I_* (f) >= I^* (f)$.
]

== Integrability Criteria

There is another way to define #ponder("calculus.riemann-integral")[integrals]. No matter how small the threshold is, we can always find a partition of $[a, b]$ so that the gap between the optimistic and pessimistic estimates is smaller than the threshold. Our definition of #ponder("calculus.riemann-integrable-function")[integrability] is equivalent to this.

#proposition[Riemann Integrability Criteria][
  Let $f: [a, b] -> RR$ be bounded. Then $f$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable] iff
  $
    forall epsilon > 0, exists cal(P) = cal(P)(epsilon) "partition of" [a, b]: U(f, cal(P)) - L(f, cal(P)) < epsilon.
  $
] <prop-riemann-integrability-criteria>

#proof[

  #fade[[$arrow.l.double$]] We have $forall epsilon > 0$,
  $
    0 <= I^* (f) - I_* (f) <= U(f, cal(P)) - L(f, cal(P)) < epsilon.
  $
  Hence $I^* (f) = I_* (f)$.

  #fade[[$=>$]] From the definition of $sup$ and $inf$, we can always find partitions $cal(P), cal(P')$ such that
  $
     U(f, cal(P)) & <= I^*(f) + epsilon / 2 \
    L(f, cal(P')) & >= I_*(f) - epsilon / 2
  $
  By assumption, $I^*(f) = I_*(f)$, so $U(f, cal(P)) - L(f, cal(P')) <= epsilon$. To conclude, we can take $cal(P'') = cal(P) union cal(P')$, and by @lemma-refinement, we have
  $
    U(f, cal(P'')) - L(f, cal(P'')) <= U(f, cal(P)) - L(f, cal(P')) <= epsilon < 2 epsilon.
  $
]

It can be shown that this is equivalent to a sequential version.

#proposition[
  Let $f : [a, b]->RR$ be bounded. Then $f$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable] iff there exists a #ponder("analysis.sequence")[sequence] of partitions $(cal(P)_n)$ of $[a, b]$ such that
  $
    U(f, cal(P)_n) - L(f, cal(P)_n) -> 0 quad "as" n -> oo.
  $
] <prop-riemann-integrability-sequential-criteria>

#exercise[
  The proof is left as an exercise.
]

#example[
  1. Consider $f(x) = x$ on $[0, 1]$. Let $cal(P)_n = {0, (1)/(n), (2)/(n), ..., (n-1)/(n), 1}$. Then
    $
      U(f, cal(P)_n) &= sum_(j=1)^n (sup_([(j-1)/(n), j/(n)]) x) (1)/(n) = (1)/(n^2) sum_(j=1)^n sup_([j-1, j]) x = (1)/(n^2) sum_(j=1)^n j = (1)/(2) (1+(1)/(n))\
      L(f, cal(P)_n) &= sum_(j=1)^n (inf_([(j-1)/(n), j/(n)]) x) (1)/(n) = (1)/(n^2) sum_(j=1)^n inf_([j-1, j]) x = (1)/(n^2) sum_(j=1)^n (j-1) = (1)/(2) (1-(1)/(n))
    $

    - With original definition,
      $
        I_*(f) = sup_cal(P) L(f, cal(P)) >= sup_n L(f, cal(P)_n) = (1)/(2) \
        I^*(f) = inf_cal(P) U(f, cal(P)) <= inf_n U(f, cal(P)_n) = (1)/(2)
      $
      So $I_*(f) >= (1)/(2) >= I^*(f)$. By $I^*(f) >= I_*(f)$, we have $integral_0^1 f(x) dif x = (1)/(2)$, and the function is #ponder("calculus.riemann-integrable-function")[integrable].

    - With @prop-riemann-integrability-criteria[Riemann Integrability Criteria], we have
      $
        U(f, cal(P)_n) - L(f, cal(P)_n) = (1)/(n) -> 0 quad "as" n -> oo.
      $
      So $f$ is #ponder("calculus.riemann-integrable-function")[integrable].

  2. Consider on $[0, 1]$ the function
    $
      f(x) = cases(
        1 quad "if" x <= (1)/(2),
        0 quad "if" x > (1)/(2)
      )
    $
    Take $cal(P)_n$ as before for $n >= 3$. Then
    $
      sup_(x_(k-1), x_k) f - inf_(x_(k-1), x_k) f = cases(
        1 quad "if" 1/2 in (x_(k-1), x_k),
        0 quad "otherwise".
      )
    $
    Hence,
    $
      U(f, cal(P)_n) - L(f, cal(P)_n) = 1 dot (1)/(n) = (1)/(n) -> 0 quad "as" n -> oo.
    $
    By @prop-riemann-integrability-sequential-criteria, $f$ is #ponder("calculus.riemann-integrable-function")[integrable].
]

We can try to generalize the above examples to get classes of functions that are #ponder("calculus.riemann-integrable-function")[integrable].

#proposition[
  Let $f: [a, b] -> RR$. If $f$ is #ponder("analysis.monotone-function")[monotone], then $f$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable].
] <monotone-implies-integrable>

#lecture-separator(lecture: 16, date: "2026-02-28")

#proof[
  If $f$ is #ponder("analysis.monotone-function")[monotone], then $f$ is bounded by $max{abs(f(a)), abs(f(b))}$.
  $
    U(f, cal(P)) - L(f, cal(P)) = sum_(j=1)^n (sup_(I_j) f - inf_(I_j) f) abs(I_j) quad & "where" I_j = [x_(j-1), x_j].
  $
  Since $f$ is #ponder("analysis.monotone-function")[monotone], $sup_(I_j)$ and $inf_(I_j)$ are attained at the endpoints of $I_j$. WLOG assume $f$ is #ponder("analysis.monotone-function")[increasing], then
  $
    sup_(I_j) = f(x_j), quad inf_(I_j) = f(x_(j-1)).
  $

  Hence, for any partition $cal(P)$ of $[a, b]$,
  $
    U(f, cal(P)) - L(f, cal(P)) = sum_(j=1)^n (f(x_j) - f(x_(j-1))) abs(I_j).
  $
  Set $cal(P)_n = {a, a + (b-a)/(n), a + 2(b-a)/(n), ..., b}$, so that $abs(I_j) = (b-a)/(n)$ for all $j$. Then
  $
    U(f, cal(P)_n) - L(f, cal(P)_n) = (b-a)/(n) sum_(j=1)^n (f(x_j) - f(x_(j-1))) = (b-a)/(n) (f(b) - f(a)) -> 0 quad "as" n -> oo.
  $
]

#proposition[Continuity implies Integrability][
  If $f: [a, b] -> RR$ is #ponder("analysis.continuity")[continuous], then it is #ponder("calculus.riemann-integrable-function")[integrable].
] <continuity-implies-integrable>
#proof[
  By @extreme-value-theorem[Extreme Value Theorem], $f$ is #ponder("analysis.continuity")[continuous] on $[a, b]$ with $abs(a), abs(b) < oo$, so $f$ is bounded.

  We will show that contrapositive, that if $f$ is not #ponder("calculus.riemann-integrable-function")[integrable], then $f$ is not #ponder("analysis.continuity")[continuous].

  If $f$ is not #ponder("calculus.riemann-integrable-function")[integrable], $exists epsilon > 0$ such that $forall cal(P)$ partition of $[a, b]$,
  $
    epsilon < U(f, cal(P)) - L(f, cal(P)) & = sum_(j=1)^n abs(I_j) (sup_(I_j) f - inf_(I_j) f) \
                                          & <=sum_(k=1)^n abs(I_k) max_(1 <= j <= n) (sup_(I_j) f - inf_(I_j) f) \
                                          & = (b-a) max_(1 <= j <= n) (sup_(I_j) f - inf_(I_j) f).
  $
  Hence $exists j$ such that $sup_(I_j) f - inf_(I_j) f > epsilon/(b-a)$.

  By @extreme-value-theorem[Extreme Value Theorem], $exists y, z in [x_(j-1), x_j]$ such that $f(y) - f(z) > (epsilon)/(b - a)$.

  Since the above is true for all partitions, it should also be true for the $cal(P)_n$ in the previous proof. So for each $n$, we can get $y_n, z_n$ with $abs(y_n - z_n) <= (b-a)/(n)$ and $abs(f(y_n) - f(z_n)) > epsilon/(b-a)$.

  From this point, we want to show that $f$ is not #ponder("analysis.sequential-continuity")[sequentially continuous]. The problem is that we do not know if $(y_n), (z_n)$ are #ponder("analysis.sequence-convergence")[convergent]. However, since $(y_n)$ and $(z_n)$ are both #ponder("analysis.bounded-sequence")[bounded], by @bolzano-weierstrass-theorem[Bolzano-Weierstrass Theorem], we can find #ponder("analysis.subsequence")[subsequences] $(y_(n_k)), (z_(n_k))$ that are #ponder("analysis.sequence-convergence")[convergent].

  Let $y = lim_(k -> oo) y_(n_k)$ and $z = lim_(k -> oo) z_(n_k)$. Then $y, z in [a, b]$, and by
  $
    abs(z_n_k - y_n_k) < (b-a)/(n_k) -> 0 quad "as" k -> oo,
  $
  we have $y = z$. We can now invoke the #ponder("analysis.sequential-continuity")[sequential continuity]: we have
  $
    y_(n_k), z_(n_k) -> y = z quad "as" k -> oo, \
    abs(f(y_(n_k)) - f(z_(n_k))) > (epsilon)/(b-a) quad "as" k -> oo, \
  $
  hence $f(y_(n_k))$ and $f(z_(n_k))$ do not #ponder("analysis.sequence-convergence")[converge] to the same limit, and $f$ is not #ponder("analysis.sequential-continuity")[sequentially continuous], hence not #ponder("analysis.continuity")[continuous].
]

#proposition[Piecewise Continuity implies Integrability][
  If $f: [a, b] -> RR$ is piecewise continuous, _i.e._ suppose there is a partition $cal(P)$ of $[a, b]$ such that $eval(f)_((x_(j-1), x_j))$ is #ponder("analysis.continuity")[continuous] and has a finite #ponder("analysis.limit-of-function")[limit] as $x->x_j^-$ and $x->x_j^+$, for all $j = 1, ..., n$, then $f$ is integrable, and
  $
    integral_a^b f(x) dif x = sum_(j=1)^n integral_(x_(j-1))^x_j overline(f_j)(x) dif x
  $
  where
  $
    overline(f_j)(x) = cases(
      f(x) & quad "if" x in (x_(j-1), x_j),
      lim_(x->x_j^-) f(x) & quad "if" x = x_j,
      lim_(x->x_(j-1)^+) f(x) & quad "if" x = x_(j-1)
    )
  $
] <prop-piecewise-continuity-implies-integrability>


#proof[
  #lemma[
    Let $f, g: [a, b] -> RR$ be bounded. Suppose $g$ is #ponder("calculus.riemann-integrable-function")[integrable], and the set
    $
      {x in [a, b]: f(x) != g(x)} = {z_1, ..., z_N}
    $
    is finite, then $f$ is #ponder("calculus.riemann-integrable-function")[integrable] and $integral_a^b f = integral_a^b g$.
  ] <lemma-finite-differences-implies-same-integral>

  #proof[
    Set $M = sup_[a, b] f$. Fix $epsilon > 0$ then $exists cal(P)$ of $[a, b]$ such that
    $
      U(g, cal(P)) - L(g, cal(P)) < epsilon.
    $
    The idea is to choose a partition which isolates problematic points, and gives them very little weight. Choose intervals $J_j = [z_k - r_k, z_k + r_k]$ with
    $
      sum_(n=1)^N abs(J_k) = 2 sum_(n=1)^N r_k < epsilon.
    $
    Set $cal(P)' = cal(P) union {z_1 plus.minus r_1, z_2 plus.minus r_2, ..., z_N plus.minus r_N}$. Also, let $J = union.big_(n=1)^N J_n$. Then
    $
      U(g, cal(P)') - L(g, cal(P)') & <= U(g, cal(P)) - L(g, cal(P)) < epsilon. \
    $

    Try to estimate
    $
      U(f, cal(P)) - L(f, cal(P)) & = sum_(j=1)^n abs(I_j) (sup_(J_j) f - inf_(J_j) f) \
      &= sum_(j = 1, I_j subset.eq J)^n abs(I_j) (sup_(J_j) f - inf_(J_j) f) + sum_(j = 1, I_j subset.eq.not J)^n abs(I_j) (sup_(J_j) f - inf_(J_j) f). \
    $
    Note that if $I_j subset.eq.not J$, then $f = g$, and hence
    $
      sum_(j = 1, I_j subset.eq J)^n abs(I_j) (sup_(J_j) f - inf_(J_j) f) <= sum_(j=1)^n abs(I_j) (sup_(J_j) g - inf_(J_j) g) = U(g, cal(P)') - L(g, cal(P)') < epsilon, \
    $
    and if $I_j subset.eq J$, then we only know that $f$ is bounded, and
    $
      (sup_(I_j) f - inf_(I_j) f) <= 2 M.
    $
    Hence,
    $
      sum_(j=1, I_j subset.eq J)^n abs(I_j) (sup_(I_j) f - inf_(I_j) f) <= 2 M sum_(j=1, I_j subset.eq J)^n abs(I_j) <= 2 M sum_(n=1)^N abs(J_n) < 2 M epsilon.
    $
    Thus,
    $
      U(f, cal(P)') - L(f, cal(P)') < (2 M + 1) epsilon.
    $
    For the formula for the integral, we have
    $
      L(f, cal(P)') & <= integral_a^b f <= U(f, cal(P)'), \
      L(g, cal(P)') & <= integral_a^b g <= U(g, cal(P)'). \
    $
    Hence
    $
      integral_a^b f - integral_a^b g <= underbracket(U(f, cal(P)') - U(g, cal(P)'), < epsilon) + underbracket((g, cal(P)') - L(g, cal(P)'), <epsilon).
    $
    Thus $integral_a^b f - integral_a^b g < 2 epsilon$. Similarly, we can show $integral_a^b g - integral_a^b f < 2 epsilon$, and the result follows by arbitrariness of $epsilon$.

  ]

  By @lemma-finite-differences-implies-same-integral we have that $eval(f)_[x_(j-1), x_j]$ is #ponder("calculus.riemann-integrable-function")[integrable] and $integral_(x_(j-1))^(x_j) f = integral_(x_(j-1))^(x_j) overline(f_j)$. To conclude, we just need to show that

  #proposition[
    Let $f: [a, b] -> RR$ and $c in (a, b)$. Then $f$ is #ponder("calculus.riemann-integrable-function")[integrable] iff $eval(f)_[a, c]$ and $eval(f)_[c, b]$ are #ponder("calculus.riemann-integrable-function")[integrable]. Moreover,
    $
      integral_a^b f(x) dif x = integral_a^c f(x) dif x + integral_c^b f(x) dif x.
    $

  ] <integral-additivity-over-subintervals>

  #lecture-separator(lecture: 17, date: "2025-03-03")

  #proof[
    We will set $I_L = [a, c]$, $I_R = [c, b]$, $f_L = eval(f)_I_L$ and $f_R = eval(f)_I_R$ for brevity.

    #fade[[$=>$]] For $epsilon > 0$, then there exists a partition $cal(P)$ of $[c, b]$ such that $U(f, cal(P)) - L(f, cal(P)) < epsilon$. WLOG let $c = x_ell$ for some $ell in {0, ..., n}$ #fade[[otherwise add $c$ to $cal(P)$, which can only make $U(f, cal(P))-L(f, cal(P))$ smaller]]. Then $cal(P) = cal(P)_L union cal(P)_R$ where $cal(P)_L = {underbracket(x_0, a), ..., underbracket(x_ell, c)}$ and $cal(P)_R = {underbracket(x_ell, c), ..., underbracket(x_n, b)}$ are partitions of $[a, c]$ and $[c, b]$ respectively. Furthermore,
    $
      cases(
        U(f, cal(P)) & = U(f_L, cal(P)_L) + U(f_R, cal(P)_R),
        L(f, cal(P)) & = L(f_L, cal(P)_L) + L(f_R, cal(P)_R)
      )
    $
    gives
    $
      underbracket(U(f_L, cal(P)_L) - L(f_L, cal(P)_L), >=0) + underbracket(U(f_R, cal(P)_R) - L(f_R, cal(P)_R), >=0) < epsilon.
    $
    So $f_L$ and $f_R$ are #ponder("calculus.riemann-integrable-function")[integrable].

    #fade[[$arrow.l.double$]] For $epsilon > 0$, $exists cal(P)_L, cal(P)_R$ partitions of $I_L$ and $I_R$ respectively such that
    $
      cases(
        U(f_R, cal(P)_R) - L(f_R, cal(P)_R) & < epsilon,
        U(f_L, cal(P)_L) - L(f_L, cal(P)_L) & < epsilon
      )
    $
    Hence by the equalities in the first part,
    $
      U(f, cal(P)) - L(f, cal(P)) < 2 epsilon.
    $
    Hence $f$ is #ponder("calculus.riemann-integrable-function")[integrable] in $[a, b]$. Furthermore,
    $
      integral_a^b f & >= L(f_L, cal(P)_L) + L(f_R, cal(P)_R) \
                     & >= integral_a^c f_L + integral_c^b f_R - 2 epsilon, \
      integral_a^b f & <= integral_a^c f_L + integral_c^b f_R + 2 epsilon.
    $
    Hence, $abs(integral_a^b f - (integral_a^c f_L + integral_c^b f_R)) < 2 epsilon$. Since $epsilon$ is arbitrary, the result follows.

  ]
]

#ponder("analysis.continuity")[Continuous], piecewise continuous and #ponder("analysis.monotone-function")[monotone] functions are all #ponder("calculus.riemann-integrable-function")[integrable], we may wonder if these are all the #ponder("calculus.riemann-integrable-function")[Riemann integrable] functions. The answer is negative.

#example[Thomae Function][
  Consider the function $f: [0, 1] -> RR$ defined by
  $
    f(x) = cases(
      (1)/(q) quad "if" x = (p)/(q) in QQ "with" gcd(p, q) = 1,
      0 quad "otherwise"
    )
  $
  Since $RR\\ QQ$ is dense in $RR$, $L(f, cal(P)) = 0$ for any partition $cal(P)$ of $[0, 1]$, hence $I_*(f) = 0$. We claim that $f$ is #ponder("calculus.riemann-integrable-function")[integrable], then $forall epsilon > 0, exists cal(P)$ such that $U(f, cal(P)) < epsilon$.

  Pick $N in NN$ such that $N > (1)/(epsilon)$. Set
  $
    X_N & = {x in [0, 1]: f(x) >= (1)/(N)} \
        & subset.eq{(p)/(q): 1 <= q <= N, 0 <= p <= q} \
        & = {y_1, ..., y_M} quad "for some finite" M. \
  $
  Define $cal(P)$ such that

  1. each $y_k$ is some subinterval of $cal(P)$

  2. this subinterval has length $< (epsilon)/(M)$ #fade[[we wish to give little weight to the bad points]]

  Then,
  $
    U(f, cal(P)) &= sum_(I in cal(P)\ I inter X_N != emptyset) abs(I) underbracket(sup_I f, <= 1) + sum_(I in cal(P)\ I inter X_N = emptyset) abs(I) underbracket(sup_I f, <= (1)/(N))\
    &<= sum_(I in cal(P) \ I inter X_N !=emptyset) abs(I) + sum_(I in cal(P) \ I inter X_N = emptyset) abs(I) (1)/(N) \
    &<= sum_(I in cal(P) \ I inter X_N !=emptyset) abs(I) + (1)/(N) sum_(I in cal(P)) abs(I) \
    &<= M dot (epsilon)/(M) + (1)/(N) dot 1\
    &< 2 epsilon.
  $
] <thomae-function>
This gives us a different result compared to the #ponder("analysis.dirichlet-function")[Dirichlet function]. Despite both functions have infinitely many discontinuities, the #ponder("calculus.riemann-integrable-function")[integrability] properties are fundamentally different.

#proposition[Countable Discontinuities implies Integrability][
  If $f: [a, b] -> RR$, and $D = {x in [a, b]: f "is not continuous at" x}$, then

  1. $D$ is finite implies that $f$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable].

  2. $D$ is #ponder("set-theory.countable-set")[countable] implies that $f$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable].
] <prop-countable-discontinuities-implies-integrability>

#proof[

  1. See Example Sheet 3 Q13.

  2. The proof is non-examinable.
]

#remark[
  @prop-countable-discontinuities-implies-integrability (1) is a stronger version of @prop-piecewise-continuity-implies-integrability, since we do not require the #ponder("analysis.limit-of-function")[one-sided limits] to exist at the discontinuities. For example, consider oscillating functions like $sin((1)/(x))$.
]

#important[
  If $f$ is not #ponder("calculus.riemann-integrable-function")[Riemann integrable] then $D$ cannot be #ponder("set-theory.countable-set")[countable]. However, there are functions which have #ponder("set-theory.uncountable-set")[uncountably many] discontinuities but are still #ponder("calculus.riemann-integrable-function")[Riemann integrable], such as the #ponder("set-theory.indicator-function")[indicator function] of the Cantor set.
]

== Basic Properties of Integrals

#lemma[
  Let $f, g : [a, b] -> RR$ be #ponder("calculus.riemann-integrable-function")[integrable] functions. Then

  1. $f(x) <= g(x)$ for all $x in [a, b]$ implies $integral_a^b f <= integral_a^b g$.

  2. For $lambda in RR$, $integral_a^b lambda f = lambda integral_a^b f$.

  3. $f+g$ is #ponder("calculus.riemann-integrable-function")[integrable] and $integral_a^b (f+g) = integral_a^b f + integral_a^b g$.

  4. $abs(f)$ is #ponder("calculus.riemann-integrable-function")[integrable] and $abs(integral_a^b f) <= integral_a^b abs(f)$. #fade[[Triangle inequality for integrals]]

  5. $f g$ is #ponder("calculus.riemann-integrable-function")[integrable] but $integral f g != integral f integral g$ in general.
] <lemma-integral-properties>

In order to show the lemma, we first need a few other lemmas, including

- an intermediate lemma about #ponder("calculus.upper-lower-riemann-sums")[upper and lower Riemann sums]

- an intermediate lemma on $sup$ and $inf$ of functions on intervals.


#exercise[
  Write out the equivalent lemma for the first one, having seen the second one below.
]

#lemma[
  Let $I$ be a closed and bounded interval, and let $f, g: I -> RR$ be bounded. Then

  1. If $f(x) <= g(x)$ for all $x in I$, then $sup$ and $inf$ preserves this inequality.

  2.1. $sup_I (-f) = - inf_I f$.

  2.2. For $lambda > 0$ fixed, $sup_I (lambda f) = lambda sup_I f$.

  3. $sup_I (f + g) <= sup_I f + sup_I g$, and $inf_I (f + g) >= inf_I f + inf_I g$.

  4. $sup_I abs(f) - inf_I abs(f) <= sup_I f - inf_I f$.

  5. $sup_I f^2 - inf_I f^2 <= 2 sup abs(f) (sup_I f - inf_I f)$.

] <sup-inf-interval-properties>

#lecture-separator(lecture: 18, date: "2026-03-05")

#proof[
  #exercise[
    1–3 are exercises.
  ]

  4. If $f >= 0$ on all of $I$, or if $f <= 0$ on all of $I$, then the result is immediate.

    If $inf_I f < 0 < sup_I f$, then
    $
      sup_I abs(f) - inf_I abs(f) & <= sup_I abs(f) <= max (sup_I f, sup_I (-f)) \
                                  & <= sup_I f + sup_I (-f) = sup_I f - inf_I f.
    $

  5. We have
    $
            f^2(x) - f^2(y) & = (f(x) - f(y)) (f(x) + f(y)) \
      sup_I f^2 - inf_I f^2 & <= sup_(x in I) inf_(y in I) abs([f(x) - f(y)] [f(x) + f(y)]) \
                            & <= 2 sup_I abs(f) underbracket(sup_(x in I) inf_(y in I) [f(x) - f(y)], sup_I f - inf_I f).
    $

]

#proof[
  #fade[[of @lemma-integral-properties]]

  #exercise[
    1–3 are exercises.
  ]

  4. For any partition $cal(P)$ of $[a, b]$,
    $
      U(abs(f), cal(P)) - L(abs(f), cal(P)) <= U(f, cal(P)) - L(f, cal(P)).
    $
    Hence if $f$ is #ponder("calculus.riemann-integrable-function")[integrable], then $abs(f)$ is also #ponder("calculus.riemann-integrable-function")[integrable].

    Since for all $x in [a, b]$,
    $
      - abs(f(x)) < f(x) < abs(f(x)),
    $
    by (1) we have
    $
      - integral_a^b abs(f) <= integral_a^b f <= integral_a^b abs(f).
    $
    Hence $abs(integral_a^b f) <= integral_a^b abs(f)$.

  5. We have
    $
      f g = (1)/(4) [(f+g)^2 - (f-g)^2]
    $
    Hence we only need to show that $f$ being #ponder("calculus.riemann-integrable-function")[integrable] implies that $f^2$ is #ponder("calculus.riemann-integrable-function")[integrable].

    For any partition $cal(P)$ of $[a, b]$,
    $
      U(f^2, cal(P)) - L(f^2, cal(P)) <= 2 sup_I abs(f) dot [U(f, cal(P)) - L(f, cal(P))].
    $
    Hence if $f$ is #ponder("calculus.riemann-integrable-function")[integrable], then $f^2$ is also #ponder("calculus.riemann-integrable-function")[integrable].
]

== Integration and Differentiation

One have probably heard that integration and differentiation are inverse operations. We will make this precise in this section.

We will think about integral of $f$ in this section as
$
  F: [a, b] -> RR, quad F(x) = integral_a^x f(t) dif t.
$

If we want $F$ to be #ponder("calculus.derivative")[differentiable], it must be #ponder("analysis.continuity")[continuous]:
#proposition[Integration is Continuous][
  Let $f: [a, b] -> RR$ be #ponder("calculus.riemann-integrable-function")[Riemann integrable], ans let $F(x) = integral_a^x f(t) dif t$. Then $F$ is #ponder("analysis.continuity")[continuous] in $[a, b]$.
] <integration-is-continuous>

#proof[
  $
    abs(F(x+h)-F(x)) & = abs(integral_a^(x+h) f(t) dif t - integral_a^x f(t) dif t) \
                     & = abs(integral_x^(x+h) f(t) dif t) \
                     & <= integral_x^(x+h) abs(f(t)) dif t \
                     & <= sup_[a, b] abs(f) underbracket(integral_x^(x+h) dif t, h) -> 0 quad "as" h -> 0.
  $

]

#theorem[Fundamental Theorem of Calculus, Part 1][
  If $f: [a, b] -> RR$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable] and #ponder("analysis.continuity")[continuous] at $x_0$, then $F(x) = integral_a^x f(t) dif t$ is #ponder("calculus.derivative")[differentiable] at $x_0$, with
  $
    F'(x_0) = eval((dif)/(dif x) [integral_a^x f(t) dif t])_(x=x_0) = f(x_0).
  $
] <thm-fundamental-theorem-calculus-part-1>

#proof[
  We will use $epsilon$-definition of #ponder("calculus.riemann-integrable-function")[integrability], _i.e._ $epsilon(h) = (F(x_0+h)-F(x_0) - h f(x_0))/(abs(h))$ and we want to show that $epsilon(h) -> 0$ as $h -> 0$.

  Estimating numerator, we have
  $
    abs(F(x_0+h) - F(x_0) - h f(x_0)) & = abs(integral_(x_0)^(x_0+h) f(t) dif t - h f(x_0)) \
    & = abs(integral_(x_0)^(x_0+h) abs(f(t) - f(x_0)) dif t) \
    & <= integral_(x_0)^(x_0+h) abs(f(t) - f(x_0)) dif t \
    & <= sup_(t in [0 ,h]) abs((x_0+t) - f(x_0)) dot underbracket(integral_(x_0)^(x_0+h) dif t, h) \
    => abs(epsilon(h)) & <= sup_(t in [0, h]) abs(f(x_0+t) - f(x_0)) -> 0 quad "as" h -> 0.
  $

]

#example[
  Take $[a, b] = [-1, 1]$ with
  $
    f(x) = cases(
      -1 & quad "for" x >= 0,
      1 & quad "for" x < 0
    )
  $
  is #ponder("calculus.riemann-integrable-function")[integrable], with
  $
    F(x) = integral_0^x f(t) dif t = cases(
      -1 -x & quad x<= 0,
      x - 1 & quad x>=0
    ) = abs(x) - 1
  $
  which is not #ponder("calculus.derivative")[differentiable] at $x=0$.

  Hence the condition of #ponder("analysis.continuity")[continuity] at $x_0$ is necessary in @thm-fundamental-theorem-calculus-part-1.
]

#corollary[
  If $f = g'$ is #ponder("analysis.continuity")[continuous] on $[a, b]$, then
  $
    F(x) = integral_a^x f(t) dif t = g(x) - g(a) quad forall x in [a, b].
  $

]

#proof[
  $(F - g)' = 0$ by @thm-fundamental-theorem-calculus-part-1, so by @mean-value-theorem[Mean Value Theorem], $F - g$ is constant, _i.e._
  $
    F(x) - g(x) = underbracket(F(a), 0) - g(a) quad<=>quad F(x) = g(x) - g(a) quad forall x
  $
]

#theorem[Fundamental Theorem of Calculus, Part 2][
  If $f: [a, b] -> RR$ is #ponder("calculus.riemann-integrable-function")[Riemann integrable], and there exists #ponder("calculus.derivative")[differentiable]
  $F: [a, b] -> RR$ such that $F' = f$, then
  $
    integral_a^b f(x) dif x = F(b) - F(a).
  $
] <thm-fundamental-theorem-calculus-part-2>

#proof[
  By assumption, $forall epsilon > 0$, $exists$ partition $cal(P)$ of $[a, b]$ such that $U(f, cal(P)) - L(f, cal(P)) < epsilon$.

  Applying @mean-value-theorem[Mean Value Theorem] to $F$ on intervals of this partition,
  $
            & F(x_j) - F(x_(j-1)) = f(t_j) (x_j - x_(j-1)) quad "for some" t_j in [x_(j-1), x_j]. \
    => quad & F(b) - F(a) = sum_(j=1)^n f(t_j) (x_j - x_(j-1)) in.rev [L(f, cal(P)), U(f, cal(P))] \
    => quad & I_*(f) <= F(b) - F(a) <= I^* (f).
  $
  Since $f$ is #ponder("calculus.riemann-integrable-function")[integrable], $I^* (f) = I_* (f) = I(f) = integral_a^b f$, hecne $F(b) - F(a) = integral_a^b f$.
]

#lecture-separator(lecture: 19, date: "2026-03-07")

Now we shall derive some common consequences.

#proposition[Integration by Parts][
  Suppose $f, g in C^1([a, b])$. Then
  $
    integral_a^b f' g = f(b)g(b) - f(a)g(a) - integral_a^b f g'
  $
] <integration-by-parts>
#proof[
  By @thm-fundamental-theorem-calculus-part-2[Fundamental Theorem of Calculus, Part 2] and product rule,
  $
    f'g = (f g)' - f g'
  $
  Integrate in $(a, b)$ and using #ponder("calculus.fundamental-theorem-of-calculus")[FTC], the result follows.

]

#proposition[Integration by Substitution][
  Let $f: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] and let $g in C^1([alpha, beta])$ with $g: [alpha, beta] -> [a, b]$, and $g(alpha) = a$, $g(beta) = b$. Then
  $
    integral_a^b f(x) dif x = integral_alpha^beta f(g(t)) g'(t) dif t.
  $

] <integration-by-substitution>

#proof[
  Let $F(x) = integral_a^x f(t) dif t$, then $F: [a, b]-> RR$ is well-defined and #ponder("calculus.derivative")[differentiable] by @thm-fundamental-theorem-calculus-part-1. Set $h = F compose g: [alpha, beta] -> RR$. Then $h$ is differentiable:
  $
    h'(t) = F'(g(t)) g'(t) = f(g(t))g'(t).
  $
  Hence,
  $
    integral_a^b f(x) dif x & = F(b)-F(a) = F(g(beta)) - F(g(alpha)) = h(beta) - h(alpha) \
                            & =integral_alpha^beta h'(t) dif t \
                            & = integral_alpha^beta f(g(t)) g'(t) dif t.
  $
]

#theorem[Taylor's Theorem: Integral Remainder][
  Suppose $f in C^n ([a, a+h])$. Let $R_(n, f, a)(h)$ be as before. Then
  $
    R_(n, f, a)(h) & = (h^n)/(n-1)! integral_0^1 (1-t)^(n-1) f^((n))(a + t h) dif t \
                   & = (1)/(n-1)! integral_0^h (h-u)^(n-1) f^((n)) (a+u) dif u.
  $
] <taylor-integral-remainder>

#remark[
  By @extreme-value-theorem[Extreme Value Theorem], $exists M_n = sup_(x in [0, n]) abs(f^((n)) (a+x)) < oo$. Thus, by @taylor-integral-remainder[Taylor's Theorem: Integral Remainder],
  $
    abs(R_(n, f, a)(h)) <= (h^n)/(n!) abs(integral_0^1 dots.c) = h^(n)/(n!) M_n integral_0^1 dif t = h^(n)/(n!).
  $
  Hence $R_(n, f, a)(h) -> 0$ as $h->0$ for fixed $n$.

  If we knew $sup_(n>=0) M_n = M < oo$, then we would get
  $
    abs(R_(n, f, a)(h)) <= (M h^n)/(h!) -> 0 quad "as" quad n->oo
  $
  for all $abs(h) < 1$, and this would mean $f$ to be #ponder("calculus.analytic-function")[analytic] at $a$.
]

#remark[
  @taylor-integral-remainder[Taylor's Theorem: Integral Remainder] generalises to $f: X subset.eq CC -> CC$, where $X$ contains the line segment $[a, a+h]$ (see Example Sheet 3). The reason we don't further explore this is that in $CC$, #ponder("calculus.derivative")[differentiability] implies #ponder("calculus.smooth-function")[smoothness], which in turn implies that they are #ponder("calculus.analytic-function")[analytic] #fade[[see IB Complex Analysis]]. This comes with estimates on $M_n$ as a function of $n$, that then one can plug into the above to get convergence of $R_(n, f, a)(h)$ to $0$ as $n->oo$ for some $h$.
]

#proof[
  Using @integration-by-parts[Integration by Parts],
  $
    R_(n, f, a)(h) & = (1)/(n-1)! integral_0^h (h-u)^(n-1) f^((n)) (a+u) dif u \
                   & = - h^(n-1) (f^((n-1))(a))/(n-1)! + (1)/((n-2)!) integral_0^h (h-u)^(n-2) f^((n-1)) (a+u) dif u \
                   & = ... \
                   & = -sum_(k=1)^(n-1)( f^((k))(a))/(k!)h^k + integral_0^h f'(a+u) dif u \
                   & = f(a+h) - f(a) - sum_(k=1)^(n-1) (f^((k))(a))/(k!) h^k.
  $

]

We would use @taylor-integral-remainder[Taylor's Theorem: Integral Remainder] to give an alternative proof of @taylor-cauchy-remainder[Taylor's Theorem: Cauchy Remainder] and @taylor-lagrange-remainder[Taylor's Theorem: Lagrange Remainder]. To do this, we would need to #ponder("calculus.cauchy-mean-value-theorem-for-integrals")[mean value theorem for integrals].

#proposition[Cauchy Mean Value Theorem for Integrals][
  Let $f, g: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous], and $g(x) != 0$ for all $x in [a, b]$, then $exists c in (a, b)$ such that
  $
    integral_a^b f(x) g(x) dif x = f(c) integral_a^b g(x) dif x.
  $
] <cauchy-mean-value-theorem-integrals>

#proof[
  Apply @cauchy-mean-value-theorem[Cauchy Mean Value Theorem] to $F(x) = integral_a^x f(t) g(t) dif t$ and $G(x) = integral_a^x g(t) dif t$, we get $exists c in (a, b)$ such that
  $
                    (F(b)-F(a))G'(c) & = (G(b)-G(a))F'(c) \
    g(c) integral_a^b f(t)g(t) dif t & = f(c)g(c) integral_a^b g(t) dif t \
        integral_a^b f(t) g(t) dif t & = f(c) integral_a^b g(t) dif t.
  $
]

#prooflike[Proof of @taylor-lagrange-remainder[TT: Lagrange Remainder]][
  Assuming #ponder("analysis.continuity")[continuity] of $f^((n))$, let $g(t) = (1-t)^(n-1)$, then $exists theta in (0, 1)$ such that
  $
    R_(n, f, a)(h) & = h^(n)/(n-1)! f^((n)) (a + theta h) integral_0^1 (1-t)^n dif t \
                   & = (h^n)/(n!) f^((n)) (a + theta h).
  $
]

#prooflike[Proof of @taylor-cauchy-remainder[TT: Cauchy Remainder]][
  Take $g = 1$.
  $
    R_(n, f, a)(h) & = h^(n)/(n-1)! (1-theta)^(n-1) f^(n) (a+theta h) integral_0^1 dif t \
                   & = (h^n)/(n!) (1-theta)^(n-1) f^((n)) (a + theta h).
  $
]

== #ponder("calculus.improper-integral")[Improper Integrals]

In this section, we will integrate functions of unbounded domain and unbounded image.

#definition[Improper Integrals: Unbounded Domain][
  Suppose $f: [0, oo) -> RR$ is #ponder("calculus.riemann-integrable-function")[integrable] on $[a, R]$ for every $a< R < oo$, and set
  $
    F: [a, oo) & -> RR \
             R & |-> integral_a^R f(x) dif x.
  $
  Then we say that $integral_a^oo f(x) dif x$ exists (converges) if
  $
    lim_(R->oo) = L in RR
  $
  then we set $integral_a^oo f(x) dif x = L$. Otherwise, we say that $integral_a^oo f(x) dif x$ does not exist.

  #separator

  If $f: RR->RR$ is such that $integral_a^oo f(x) dif x = L_1$ and $integral_(-oo)^a f(x) dif x = L_2$, then we say $integral_(-oo)^oo f(x)dif x$ exists, and set
  $
    integral_(-oo)^oo f(x) dif x & = L_1 + L_2 \
                                 & = integral_(-oo)^a f(x) dif x + integral_a^oo f(x) dif x \
                                 & = lim_(R->oo) integral_(-R)^a f(x) dif x + lim_(r->oo) integral_a^r f(x) dif x.
  $

  #remark[
    This is different from
    $
      lim_(R->oo) [integral_(-R)^R f(x) dif x].
    $
    See further discussion in Example Sheet 4.
  ]
] <improper-integral-unbounded-domain>

#example[
  - $integral_1^oo x^p dif x = lim_(R->oo) integral_1^R 1/x^p dif x$ exists iff $x >= 1$.

  - $integral_2^oo (1)/(x log^2 x) dif x = lim_(R->oo) integral_x^R (dif x)/(x log^2 x) = 1/(log 2).$\

  - $integral_(-oo)^oo ee^(-x^2) dif x$ exists assuming knowledge of normal distribution.
]

#lecture-separator(lecture: 20, date: "2026-03-10")

We need some convergence tests to have a proper proof for the last example.

#proposition[Comparison Test for Integrals][
  If $f, g: [a, oo) -> RR$ satisfy $0 <= f(x) <= g(x)$ for all $x >= a$, then

  1. $integral_a^oo g(x) dif x$ #ponder("calculus.improper-integral")[converges] implies $integral_a^oo f(x) dif x$ #ponder("calculus.improper-integral")[converges], and $integral_a^oo f(x) dif x <= integral_a^oo g(x) dif x$.

  2. $integral_a^oo f(x) dif x$ #ponder("calculus.improper-integral")[diverges] (to $+oo$) implies $integral_a^oo g(x) dif x$ #ponder("calculus.improper-integral")[diverges] to $+oo$.
] <comparison-test-integrals>

#proof[

  1. Let $F(R) = integral_0^R f(x) dif x$, note that this is #ponder("analysis.monotone-function")[increasing] since $f >= 0$. It is also bounded, since

    $
      0 <= F(R) <= integral_0^R g(x) dif x <= integral_0^oo g(x) dif x < oo.
    $

    Since $F$ is #ponder("analysis.monotone-function")[monotone] and bounded, let $L = sup_(R >= a) F(R)$ exists. We claim that
    $
      L = lim_(R->oo) integral_0^R f(x) dif x.
    $
    Indeed, by the definition of #ponder("analysis.least-upper-bound")[supremum], $forall epsilon > 0, exists R_0 in [a, oo)$ such that for $R >= R_0$,
    $
      L - epsilon <= F(R_0) <= F(R) <= L.
    $
    Hence,
    $
      L - epsilon <= F(R) <= L.
    $
    Taking limits to infinity,
    $
      L - epsilon <= F(R) <= L quad forall R >= R_0 quad => lim_(R->oo)F(R) = L.
    $

  2. Since $f>=0$, $lim_(R->oo) underbracket(integral_0^R f(x) dif x, F(R)) = +oo$ necessarily. Hence $forall L > 0$, $exists R$ such that $forall r >= R, F(r) > L$. But
    $ integral_0^R g(x) dif x >= F(R) > L. $
    Hence $integral_0^oo g(x) dif x$ diverges to $+oo$.
]

#example[
  If $x>= 1$, $x^2 >= x$. Hence $ee^(-x^2) <= ee^(-x)$ using properties of exponentials. Thus,
  $
    &integral_1^oo ee^(-x^2) dif x <= integral_1^oo ee^(-x) dif x = [-(1)/(ee^x)]_1^oo = (1)/(ee)\
    => &integral_(-oo)^oo ee^(-x^2) dif x = 2 integral_0^oo ee^(-x^2) dif x = underbracket(2 integral_1^oo ee^(-x^2) dif x, (2)/(ee)) + underbracket(2 integral_0^1 ee^(-x^2) dif x, "finite since" ee^(-x^2)\ "is integrable").
  $
  Indeed, $integral_(-oo)^oo ee^(-x^2) dif x$ #ponder("calculus.improper-integral")[converges].
]

#proposition[Ratio Test for Integrals][
  Let $f, g: [0, oo) -> RR$ satisfy $f, g >= 0$, and
  $
    lim_(x->oo) f(x)/g(x) = L in (0, oo),
  $
  then
  $
    integral_a^oo f(x) dif x "converges" <=> integral_a^oo g(x) dif x "converges".
  $
] <ratio-test-integrals>

#proof[
  #exercise[
    This is an application of the #ponder("calculus.comparison-test-for-integrals")[comparison test]. Proof left as an exercise.
  ]
]

#remark[
  If $lim_(x->oo) f(x)/(g(x)) = 0$, then $f(x) <= g(x)$ for very large $x$, hence by @comparison-test-integrals[Comparison Test for Integrals] from the large $x$ onwards,
  $
    integral_a^oo g(x) dif x "converges" => integral_a^oo f(x) dif x "converges".
  $
  If $lim_(x->oo) f(x)/(g(x)) = oo$, then $f(x) >= g(x)$ for very large $x$, and similarly by @comparison-test-integrals[Comparison Test for Integrals] from the large $x$ onwards,
  $
    integral_a^oo g(x) dif x "diverges" => integral_a^oo f(x) dif x "diverges".
  $
]

#example[
  - For $ee^(-x^2)$, we have $lim_(x->oo) e^(-x^2)/(e^(-x)) = 0$ and $integral_0^oo ee^(-x) dif x = (1) < oo$. By the remark,
    $
      integral_0^oo ee^(-x^2) dif x < oo.
    $

  - For $integral_1^oo (x)/(x^4 + 1) dif x$ #ponder("calculus.improper-integral")[converges] since

    $
      lim_(x->oo) ((x)/(x^4 + 1))/(x^3) = 1 in (0, oo)
    $
    and by $integral_1^oo (1)/(x^3) dif x < oo$ we have $integral_1^oo (x)/(x^4 + 1) dif x < oo$.
]

#exercise[
  On Example Sheet 4, there are examples of #ponder("analysis.root-test")[root test], Dirichlet test for integrals. Is a version of the #ponder("analysis.nth-term-test")[$n$-th term test] for integrals true or false?
]

We shall now consider #ponder("calculus.improper-integral")[improper integrals] with bounded domain but isolated singularity.

#definition[Improper Integrals: Isolated Singularity][
  Let $f: (a, b] -> RR$ be #ponder("calculus.riemann-integrable-function")[integrable] on $[a + delta, b]$ for any $0 < delta <= b-a$. Set
  $
    F: (0, b-a] & -> RR \
          delta & |-> integral_(a+delta)^b f(x) dif x.
  $
  Then, we say $integral_a^b f(x) dif x$ exists (converges) if $lim_(delta -> 0) f(delta)$ exists and is finite, and we say
  $
    integral_a^b f(x) dif x= lim_(delta->0) F(delta).
  $
  Otherwise, we say it does not exist (converge).

  If $f: [B, b]\\{a}$ is such that $integral_B^a f(x) dif x = ell_1 in RR$ and $integral_a^b f(x) dif x = ell_2 in RR$, then say
  $
    integral_B^b f(x) dif x "exists", quad "and" quad integral_B^b f(x)=ell_1 + ell_2.
  $
] <improper-integral-isolated-singularity>

#remark[
  $
    integral_B^b f(x) dif x & = integral_B^a f(x) dif x + integral_a^b dif(x) dif x \
    & = lim_(delta->0) integral_B^(a-delta) f(x) dif x + lim_(sigma->0) integral_(a+sigma)^b f(x) dif x \
  $
  In general, this is not equal to
  $
    lim_(delta->0) [integral_B^(a-delta) f(x) dif x + integral_(a+delta)^b f(x) dif x].
  $
  This can be seen by taking $f(x) = (1)/(x)$.
]

#example[
  - $integral_0^1 (1)/(x^p) dif x$ #ponder("calculus.improper-integral")[converges] iff $p < 1$, since as $delta -> 0$
    $
      integral_delta^1 1/x^p dif p = cases(
        p = 1: quad & [log_x]_delta^1 = -log delta -> -oo,
        p!= 1: quad & [x^(1-p)/(1-p)]^1_delta = delta^(1-p)/(p-1) -> 0 "iff" p < 1.
      )
    $

  - Consider
    $
      integral_0^(1/2) (dif x)/(x log^p (x)) = integral_oo^(log 2) (-(1)/(u^p)) dif u = integral_(log 2)^oo (1)/(u^p) dif u
    $
    which #ponder("calculus.improper-integral")[converges] iff $p > 1$.
]

Actually, we can always reduce, by #ponder("calculus.integration-by-substitution")[substitution], an #ponder("calculus.improper-integral")[improper integral] of function with isolated singularities to #ponder("calculus.improper-integral")[improper integrals] with unbounded domain.

#lemma[
  Let $f: (a, b] -> RR$ be #ponder("calculus.riemann-integrable-function")[Riemann integrable] on $[a+delta, b]$ for all $delta in (0, b-a)$. Choose $phi: [c, oo] -> [a, b]$ on $C^1$ #ponder("analysis.monotone-function")[strictly decreasing] #ponder("algebra.bijection")[bijection] with $phi(c) = b$, $lim_(t->oo) phi(t) = a$. Then
  $
    integral_a^b f(x) dif x "exists" <=> integral_c^oo f(phi(t)) (-phi'(t)) dif t "exists".
  $
]
