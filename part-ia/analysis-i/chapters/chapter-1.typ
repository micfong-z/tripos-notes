#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2026-01-22")

= Numerical Sequences and Series <chapter-1>

== Basics

#definition[Sequence][
  #ponder("analysis.sequence")[A sequence] $(x_(n))_(n in NN)$ on a set $X$ is an enumerated list where each element is in the set $X$.
]

In this section, $X subset.eq RR$ or $X subset.eq CC$. A concrete important case is $X = RR$ #fade[[ real sequences ]].

We shall now consider the issues of

- convergence, where $(x_(n))$ converges to $x in X$, and

- divergence of sequences.

On #ponder("analysis.sequence-convergence")[convergence]:

- we need $abs(x_(n)-x)$ to be smaller than any given threshold $epsilon > 0$ that we choose;

- for the comparison, only the tail of the sequence matters, i.e. large $n$ behaviour. We can always ignore the first $N$ terms of the sequence, for some $N$ depending on $epsilon$.


On #ponder("analysis.divergence-to-infinity")[divergence to infinity]:

- we need $abs(x_n)$ to clear any threshold $L > 0$ that we choose;

- again, only the tail of the sequence matters. We can always ignore the first $N$ terms of the sequence, for some $N$ depending on $L$.

#definition[Convergence][
  We say that $(x_(n))$ *#ponder("analysis.sequence-convergence")[converges]* to some finite $x$ if
  $
    forall epsilon > 0, exists N in NN, forall n >= N: abs(x_(n)-x) < epsilon.
  $
  We write $x_n -> x$ or $lim_(n->oo) x_n = x$.
]

#definition[Divergence to Infinity][
  We say that a real sequence $(x_(n))$ *#ponder("analysis.divergence-to-infinity")[diverges to (positive) infinity]* if
  $
    forall L > 0, exists N in NN, forall n >= N: x_(n) > L.
  $
  We write $x_n -> oo$.
] <divergence-to-infinity>

#remark[
  We can replace $<$ by $<=$, and replace $epsilon$ by $2epsilon$, _etc._ in the definitions above without changing their meanings.
]

#remark[
  For complex sequences, we can use analogus definitions of diverging to infinity.
]

#example[
  - Consider $x_n = (1)/(n)$. Then $x_n -> 0$ because $forall epsilon > 0$,
    $
      abs(x_n - 0) = (1)/(n) < epsilon quad forall n >= 1 + ceil((1)/(epsilon)) .
    $

  - Consider $x_n = (1)/(2^n)$. Then $x_(n) -> 0$ because $forall epsilon > 0$,
    $
      abs(x_n - 0) = (1)/(2^n) < epsilon quad forall n >= max {1, 1 + ceil(log_2((1)/(epsilon)))} .
    $

  - Consider $x_n = ii n$. Then $(x_n)$ #ponder("analysis.divergence-to-infinity")[diverges to infinity] since $forall L > 0$,

    $
      (x_n)/(ii) = n > L quad forall n >= 1+ceil(L) .
    $

  - Consider $x_n = (-1)^n$. Then $(x_n)$ does not #ponder("analysis.divergence-to-infinity")[diverge] to $oo$, but it does not #ponder("analysis.sequence-convergence")[converge] either.
]

#lemma[
  If a sequence $(x_n)$ #ponder("analysis.sequence-convergence")[converges], then the #ponder("analysis.limit-of-sequence")[limit is unique].
]

#proof[
  Suppose $x_n -> a$ and $x_n -> b$. Take $epsilon > 0$, then we have
  $
    & exists N_1 = N_1(epsilon), & forall n >= N_1: & abs(x_n-a) < epsilon, \
    & exists N_2 = N_2(epsilon), & forall n >= N_2: & abs(x_n-b) < epsilon.
  $
  In particular, for $n >= max{N_1, N_2}$, both inequalities hold. Then
  $
    abs(a-b) = abs(a - x_(n) + x_(n) - b) <= abs(a - x_(n)) + abs(x_(n) - b) < epsilon + epsilon = 2 epsilon.
  $
  Since $epsilon$ is arbitrary, we can conclude that $abs(a-b) = 0$. Hence $a = b$.
]

#proposition[Sandwich Theorems][
  Let $(x_n)$, $(y_n)$, $(z_n)$ be real sequences. Then

  - If $x_n <= y$ for all $n$ and $x_n -> x$, then $x <= y$.

  - If $x_n -> x$, $z_n -> x$, and $x_n <= y_n <= z_n$, then $y_n -> x$.

  #important[
    The best conclusion in the case that $x_n < y$ for all $n$ and $x_n -> x$, is still $x <= y$.
  ]
] <sandwich-theorems>

#lemma[
  Let $(x_n)$ be a complex sequence. Then $x_n -> x$ if and only if $re(x_n) -> re(x)$ and $im(x_n) -> im(x)$.
] <componentwise-convergence>

#proof[
  Recall that for $z in CC$, $abs(z) = sqrt(re(z)^2 + im(z)^2)$.

  #fade[[$=>$]] We have that $abs(re z) <= abs(z)$ and $abs(im z) <= abs(z)$. By the defintiion of convergence, the result follows.

  #fade[[$arrow.l.double$]] Note the inequality $abs(z) <= abs(re z) + abs(im z).$ Fix $epsilon > 0$. By definiition of convergence,
  $
    & exists N_1 = N_1(epsilon), & forall n >= N_1: & abs(re x_n - re x) < epsilon, \
    & exists N_1 = N_2(epsilon), & forall n >= N_2: & abs(im x_n - im x) < epsilon. \
  $
  Hence $abs(x_n - x) <= 2 epsilon$ for all $n >= max{N_1, N_2}$.
]

#lemma[
  Let $x_n -> x$, $y_n -> y$. Then $x_n + y_n -> x + y$ and $x_n y_n -> x y$. If $x_(n) != 0$ for every $n$, then $(1)/(x_(n)) -> (1)/(x)$.
] <algebra-of-limits>

#proof[
  The first and third part is left as an exercise.

  We shall prove that $x_n y_n -> x y$. We have
  $
    abs(x_n y_n - x y) & = abs(x_n y_n - x y_(n) + x y_(n) - x y) \
                       & <= abs(x) abs(y_n - y) + abs(y_n) abs(x - x_n). \
  $
  We have
  $
    forall epsilon > 0, exists N_1 = N_1(epsilon), exists N_2 = N_2(epsilon), cases(
      forall n >= N_1:abs(x_n - x) < epsilon,
      forall n >= N_2: abs(y_n - y) < epsilon
      .
    )
  $
  Hence
  $
    abs(x_n y_n - x y) <= epsilon (abs(x) + abs(y_n) ) quad forall n >= max{N_1, N_2}.
  $

  #lemma[
    If $x_n -> x$, then $(x_n)$ must be #ponder("analysis.bounded-sequence")[bounded]. _i.e._
    $
      exists M, forall n :abs(x_n) <= M
    $
  ]

  #lecture-separator(lecture: 2, date: "2026-01-24")

  #proof[
    Take $epsilon = 1$. Then there exists $N$ such that $forall n >= N$, $abs(x_n - x) < 1$. Hence for $n >= N$, we have
    $
      abs(x_n) <= abs(x_n - x) + abs(x) < 1 + abs(x).
    $
    Let
    $
      M = max {abs(x_1), abs(x_2), ..., abs(x_(N-1)), 1 + abs(x)}.
    $
    Then $forall n$, $abs(x_n) <= M$.
  ]

  Hence we can replace $abs(y_n)$ with $M$ and the result follows.
]

#definition[Bounded Sequence][
  We say $(x_n)$ is *#ponder("analysis.bounded-sequence")[bounded]* if $exists M > 0$ such that $abs(x_n) <= M$ for all $n$. Equivalently, $sup_(n >= 0) abs(x_n) <= M$.
]

#definition[Monotonic Sequence][
  We say a real sequence $(x_n)$ is #ponder("analysis.monotonic-sequence")[monotone] if either

  - it is increasing, $x_(n) <= x_(n+1)$ for every $n$,

  - it is decreasing, $x_(n) >= x_(n+1)$ for every $n$.
]

#proposition[Monotone Convergence Theorem][
  Every #ponder("analysis.bounded-sequence")[bounded] #ponder("analysis.monotonic-sequence")[monotone] real sequence #ponder("analysis.sequence-convergence")[converges].
] <monotone-convergence-theorem>

#proof[
  WLOG suppose $(x_n)$ is strictly increasing and #ponder("analysis.bounded-above")[bounded above]. We will use the #ponder("analysis.least-upper-bound")[supremum axiom], that every non-empty set of $RR$ #ponder("analysis.bounded-above")[bounded above] has a #ponder("analysis.least-upper-bound")[supremum] in $RR$.

  Refer to IA Numbers and Sets for a full proof of this proposition.
]

If we drop the #ponder("analysis.monotonic-sequence")[monotonicity] condition, we may not have convergence. For example, $x_n = (-1)^n$ is #ponder("analysis.bounded-sequence")[bounded] but does not #ponder("analysis.sequence-convergence")[converge]. However, we can still extract #ponder("analysis.sequence-convergence")[convergent] #ponder("analysis.subsequence")[subsequences] from #ponder("analysis.bounded-sequence")[bounded] sequences, _e.g._ by taking all even terms in $x_(n) = (-1)^n$.

== #ponder("analysis.bolzano-weierstrass-theorem")[Bolzano-Weierstrass Theorem]

#theorem[Bolzano-Weierstrass Theorem][
  If $(x_n)$ is a real and #ponder("analysis.bounded-sequence")[bounded] sequence, then there exists a #ponder("analysis.sequence-convergence")[convergent] #ponder("analysis.subsequence")[subsequence].
] <bolzano-weierstrass-theorem>

#definition[Subsequence][
  A *#ponder("analysis.subsequence")[subsequence]* of a #ponder("analysis.sequence")[sequence] $(x_n)$ is a sequence of the form $(x_(n_k))$ where $(n_k)$ is a strictly increasing sequence of natural numbers.
] <subsequence>

#lemma[
  If $x_n -> x$, then any #ponder("analysis.subsequence")[subsequence] $(x_n_k)$ must #ponder("analysis.sequence-convergence")[converge] to the same limit.
] <subsequence-limit>

#proof[
  Since $n_k < n_(k+1) => n_(k+1) >= n_k + 1$, by induction, we can show that
  $n_k >= k$ for all $k$.

  Take $epsilon > 0$, then $exists N = N(epsilon)$ such that $forall n >= N$, $abs(x_n - x) < epsilon$. So if $k >= N$ then $n_k >= k >= N$ and hence $abs(x_(n_k) - x) < epsilon$.

  Hence $lim_(k->oo) x_n_k = x$.
]

#proposition[Nested Interval Property][
  Take a sequence of nested closed intervals in $RR$: $forall n$, $I_n supset.eq I_(n+1)$ where $I_n = [a_n, b_n]$.

  If $b_n - a_n = abs(I_n) -> 0$ as $n -> oo$, then $inter.big_(n in NN) I_n$ contains exactly one point.
] <nested-interval-property>

#proof[
  This is an application of @monotone-convergence-theorem[Monotone Convergence Theorem].

  Since $I_n supset.eq I_(n+1)$ and $I_1 supset.eq I_n$, we have

  - $a_n <= a_(n+1)$

  - $b_n >= b_(n+1)$

  - $a_1 <= a_n <= b_n <= b_1$

  Hence,

  - $(a_n)$ is increasing and bounded above by $b_1$,

  - $(b_n)$ is decreasing and bounded below by $a_1$.

  So $(a_n)$ and $(b_n)$ converge. Let $a = lim_(n->oo) a_n in RR$ and $b = lim_(n->oo) b_n in RR$. Since #ponder("analysis.sandwich-theorem")[limits preserve inequalities], we have $a <= b$. Now we shall prove this proposition by considering two aspects.

  *Existence.* For all $k >= n$, $a_k in [a_k, b_k] subset.eq [a_n, b_n]$. So $a_n <= a_k <= b_n$. Now, as $k->oo$, we have $a_n <= a <= b_n$. Since this is true for all $n$, we have $a in inter.big_(n in NN) I_n$.

  *Uniqueness.* $b_n - a_n -> b - a$ by construction. Since $b_n - a_n -> 0$, we must have $b - a = 0$ because #ponder("analysis.limit-of-sequence")[limits are unique]. Hence $a = b$.

  Thus $x in inter_n I_n <=> x in I_n space forall n <=> a_n <= x <= b_n space forall n => a <= x <= b = a => x = a = b.$
]

#proof[ #fade[[of @bolzano-weierstrass-theorem[Bolzano-Weierstrass Theorem]]]
  We are given $(x_n)$ and $M > 0$ such that $abs(x_n) <= M$ for all $n$. We will construt a sequence of nested intervals from which we can sample our subsequence, since that will ensure that our subsequence will converge to the unique intersection point of nested intervals.

  Let $a_1 = -M, b_1 = M$. Then $I_1 = [-M, M] supset.eq {x_n: n in NN}$.

  Now take $c = (a_1 + b_1)/(2)$. Then at least one of the intervals $[a_1, c]$ and $[c, b_1]$ must contain infinitely many terms of the sequence $(x_n)$. #fade[[If both intervals contained only finitely many terms, then the whole interval $[-M, M]$ would contain only finitely many terms, contradicting the fact that $(x_n)$ is an infinite sequence.]] Take $I_2$ to be a half interval that contains infinitely many terms. Continuing inductively gives a sequence of nested intervals $I_n = [a_n, b_n]$ with $b_n - a_n = (M)/(2^(n-1)) -> 0$ as $n -> oo$, and each $I_n$ contains infinitely many terms of the sequence.

  By @nested-interval-property[Nested Interval Property], $exists! x in inter.big_n I_n$. We can now choose $(x_n_k)$ as follows: pick $n_1$ such that $x_n_1 in I_1$, then $I_2$ has infinitely many elements of $(x_n)$ with indices greater than $n_1$, so pick $n_2 > n_1$ such that $x_n_2 in I_2$. Continuing in this manner gives a subsequence $(x_n_k)$ with $x_n_k in I_k$ for all $k$.

  By construction, $x_n_k in I_k$ for every $k$, so $x_n_k in inter.big_(n <= k) I_n$, so $x_n_k -> x$ as $k -> oo$.
]

#lecture-separator(lecture: 3, date: "2026-01-27")

#remark[
  The #ponder("analysis.bolzano-weierstrass-theorem")[Bolzano-Weierstrass Theorem] also works for complex sequences.
]

== #ponder("analysis.cauchy-sequence")[Cauchy Sequences]

#definition[Cauchy Sequence][
  A #ponder("analysis.sequence")[sequence] $(x_n) in CC$ is *#ponder("analysis.cauchy-sequence")[Cauchy]* if
  $
    forall epsilon > 0, exists N in NN, forall m, n >= N: abs(x_n - x_m) < epsilon.
  $
] <cauchy-sequence>

#example[
  - $x_(n)=(1)/(n)$. Assume WLOG $m >= n$, Then $forall epsilon >0$
    $
      abs(x_n - x_m) = abs((1)/(n) - (1)/(m)) = (m-n)/(m n) <= (1)/(n) < epsilon quad forall m, n >= N(epsilon) = 1 + ceil((1)/(epsilon)).
    $

  - $x_n = (-1)^n$ is not a #ponder("analysis.cauchy-sequence")[Cauchy sequence], because if $n = 2k$, $m = 2k + 1$ for any $k in NN$, then
    $ abs(x_n - x_m) = abs(1 - (-1)) = 2. $
    The definition fails for $epsilon = 1$.

  - $(x_n)$ on $QQ$ defined by truncation of decimal expansion of $sqrt(2)$:
    $
      x_1 = 1, x_2 = 1.4, x_3 = 1.41, x_4 = 1.414, ...
    $
    This is #ponder("analysis.cauchy-sequence")[Cauchy], since for WLOG $m > n$, we have
    $
      abs(x_m - x_n) < 10^(-n+1) -> 0 quad "as" n -> oo.
    $
    This sequence does not #ponder("analysis.sequence-convergence")[converge] over $QQ$, but it does #ponder("analysis.sequence-convergence")[converge] over $RR$.
] <cauchy-sequence-examples>

#exercise[
  If $(x_(n))$ satisfies
  $
    forall epsilon > 0, exists N = N(epsilon), forall n >= N: abs(x_(n+1) - x_(n)) < epsilon,
  $
  must $(x_n)$ be a #ponder("analysis.cauchy-sequence")[Cauchy sequence]?
]

#lemma[
  If $(x_n)$ is #ponder("analysis.cauchy-sequence")[Cauchy], then it is #ponder("analysis.bounded-sequence")[bounded].
] <cauchy-sequence-bounded>

#proof[
  Take $epsilon = 1$. Then $exists N$ such that $forall n >= N$,
  $
    abs(x_n - x_N) < 1.
  $
  Hence $abs(x_n) < 1 + abs(x_N)$ for all $n >= N$. Note that $x_N$ is a finite number independent of $n$. So
  $
    sup_(n>=1) abs(x_n) <= max {abs(x_1), abs(x_2), ..., abs(x_(N-1)), 1 + abs(x_N)}.
  $
]

#lemma[
  A complex sequence $(x_n)$ is #ponder("analysis.cauchy-sequence")[Cauchy] if and only if $(re(x_n))$ and $(im(x_n))$ are #ponder("analysis.cauchy-sequence")[Cauchy] in $RR$.
] <cauchy-componentwise>

#lemma[
  If $x_(n) -> x$, then $(x_n)$ is #ponder("analysis.cauchy-sequence")[Cauchy].
] <convergence-implies-cauchy>

#proof[
  $forall epsilon >0, exists N = N(epsilon), forall m, n >= N$, we have
  $
    abs(x_n - x_m) & = abs(x_n - x + x - x_m) \
                   & = abs(x_n - x) + abs(x - x_m) \
                   & < epsilon + epsilon = 2 epsilon.
  $
]

Consider the converse of @convergence-implies-cauchy. Note that @cauchy-sequence-examples (3) shows that there are #ponder("analysis.cauchy-sequence")[Cauchy sequences] in $QQ$ that do not #ponder("analysis.sequence-convergence")[converge] in $QQ$. However, we have the following important theorem.

#theorem[Completeness of $RR$ and $CC$][
  Every #ponder("analysis.cauchy-sequence")[Cauchy sequence] in $RR$ or $CC$ #ponder("analysis.sequence-convergence")[converges].
] <completeness-real-complex>

#remark[
  So one can prove #ponder("analysis.sequence-convergence")[convergence] of $RR$ or $CC$ sequences without having to know the actual limit, by showing that they are #ponder("analysis.cauchy-sequence")[Cauchy].
]

#proof[
  Recall that a sequence on $CC$ is Cauchy/convergent if and only if its real and imaginary parts are Cauchy/convergent. So it suffices to prove the result for real sequences.

  We have seen that $(x_n)$ being #ponder("analysis.cauchy-sequence")[Cauchy] implies that it is bounded by @cauchy-sequence-bounded. Then by @bolzano-weierstrass-theorem[Bolzano-Weierstrass Theorem], $exists$ #ponder("analysis.sequence-convergence")[convergent] #ponder("analysis.subsequence")[subsequence] $(x_n_k)$ with limit $x in RR$. We have

  $
    abs(x_n - x) & <= abs(x_n - x_n_k) + abs(x_n_k - x).
  $
  More precisely, take $epsilon > 0$,

  - since $(x_n)$ is Cauchy, $exists N_1 = N_1(epsilon)$ such that $forall m, n >= N_1$, $abs(x_n - x_m) < epsilon$,

  - since $x_n_k -> x$, $exists N_2 = N_2(epsilon)$ such that $forall k >= N_2$, $abs(x_n_k - x) < epsilon$.

  We can choose $k >= N_2$ such that $n_k >= N_1$, then
  $
    abs(x_n - x) < epsilon + epsilon = 2 epsilon quad forall n >= N_1.
  $
]

== Series and Convergence Tests

#definition[Series and Series Convergence][
  Let $(a_n)_(n in NN)$ be a sequence over $RR$ or $CC$. We say that $sum_(n=1)^oo a_n$ is a *#ponder("analysis.series")[series]*.

  We say it *#ponder("analysis.series")[converges]* if the sequence of partial sums
  $
    s_k = sum_(n=1)^k a_n
  $
  converges to some finite $s in RR$ or $CC$ as $k -> oo$. In this case, $s$ is called the sum of the series,
  $
    s = sum_(n=1)^oo a_n.
  $
]

#example[
  - $sum_(n=1)^oo n$ does not converge as $s_k = sum_(n=1)^k n = (1)/(2 ) k (k+1) -> oo$ as $k->oo$.

  - *Geometric series.* $sum_(k=1)^oo r^n < oo$ #ponder("analysis.series")[converges] iff $abs(r) < 1$. The partial sums for $abs(r) < 1$ are
    $
      s_k = sum_(n=0)^k r^n = (1 - r^(k+1))/(1 - r) -> (1)/(1 - r) quad "as" k -> oo.
    $

  #lecture-separator(lecture: 4, date: "2026-01-29")

  - $sum_(n=1)^oo (1)/n(n+1)$ converges to $1$, since we have
    $
      s_k = sum_(n=1)^k (1)/(n(n+1)) = sum_(n=1)^k (1)/(n) - (1)/(n+1) = 1 - (1)/(k+1) -> 1 quad "as" k -> oo.
    $
]

#lemma[
  Fix $lambda in CC$. If $sum a_n$ and $sum b_n$ #ponder("analysis.series")[converge], then $sum (lambda a_n + b_n)$ also #ponder("analysis.series")[converges].
]

#remark[
  Note that the product of two #ponder("analysis.series")[convergent] series need not #ponder("analysis.series")[converge].
]

As usual, only the tail of the series matters for #ponder("analysis.series")[convergence].

#lemma[
  If $a_n = b_n$ for all $n >= N$ for some $N in NN$, then $sum a_n$ #ponder("analysis.series")[converges] iff $sum b_n$ #ponder("analysis.series")[converges].
]

#proof[
  Let
  $
    s_k = sum_(n=1)^k a_n , quad r_k & = sum_(n=1)^k b_n = sum_(n=1)^(N-1) b_n + sum_(n=N)^k a_n \
                                     & = sum_(n=1)^(N) b_n + sum_(n=N+1)^k a_n \
                                     & = s_k + sum_(n=1)^(N) (b_n - a_n).
  $

  Note that $sum_(n=1)^n (b_n - a_n)$ is a finite sum, so it does not affect #ponder("analysis.series")[convergence]. If $k -> oo$, then $s_k$ #ponder("analysis.series")[converges] iff $r_k$ #ponder("analysis.series")[converges].

]

#proposition[$n"th"$ term test][
  A necessary condition for $sum a_n$ to #ponder("analysis.series")[converge] is that $a_n -> 0$ as $n -> oo$.

  #fade[[_i.e._, if $a_n$ does not #ponder("analysis.series")[converge] to $0$, then $sum a_n$ diverges.]]
] <nth-term-test>

#remark[
  $a_n -> 0$ is not a sufficient condition for $sum a_n$ to #ponder("analysis.series")[converge].

  For example, the harmonic series $sum_(n=1)^oo (1)/(n)$ diverges even though its terms #ponder("analysis.sequence-convergence")[converge] to $0$. To see that it diverges, note that the #ponder("analysis.series")[partial sums] satisfy
  $
    s_k = sum_(n=1)^k (1)/(n) \
                       s_(2k) & = s_k + (1)/(k+1) + (1)/(k+2) + ... + (1)/(2k) \
                              & >= s_k + k (1)/(2k) = s_k + (1)/(2).
  $
  Hence $(s_k)$ is not #ponder("analysis.cauchy-sequence")[Cauchy], so it diverges.

]

#proof[
  $
    sum a_n "converges" & <=> s_k -> s "as" k-> oo "for some" s \
                        & => (s_k) "is Cauchy" \
                        & => a_(k+1) = s_(k+1) - s_k -> 0 "as" k-> oo. \
  $
]

We shall first focus on tests for #ponder("analysis.series")[convergence] of $sum a_n$ where $a_n >= 0$ for all $n$.

#proposition[Comparison Test][
  If $0 <= b_n <= a_n$ for all sufficiently large $n$, then
  $
    sum a_n "converges" => sum b_n "converges."
  $
] <comparison-test>

#proof[
  Let $s_k$ and $r_k$ be the #ponder("analysis.series")[partial sums] of $sum a_n$ and $sum b_n$. Because $a_n, b_n >=0$, the sequences $(s_k)$ and $(r_k)$ are increasing. Since $s_k -> s$, we have $s_k <= s$ for all $k$. Hence
  $
    b_n <= a_n & => sum_(n=1)^k b_n <= sum_(n=1)^k a_n <= s \
               & => r_k "is bounded above by" s \
               & => (r_k) "converges by monotone convergence theorem". \
  $
]

#example[
  $sum (1)/(n^2)$ #ponder("analysis.series")[converges]. This is because
  $
    sum_(n=1)^oo (1)/(n^2) = 1 + sum_(n=2)^oo (1)/(n^2) <= 1 + sum_(n=1)^oo (1)/((n+1)^2) <= 1 + sum_(n=1)^oo (1)/(n(n+1)).
  $
  so by @comparison-test[Comparison Test], $sum (1)/(n^2)$ #ponder("analysis.series")[converges].
]

The next two tests are about asymptotic comparisons to the geometric series.

#proposition[Root Test][
  If $a_n >= 0$ for all $n$, then consider $root(n, a_n)$, and assume $exists a$ such that $a = lim_(n->oo) root(n, a_n)$.

  Then

  - $a < 1$ implies $sum a_n$ #ponder("analysis.series")[converges].

  - $a > 1$ implies $sum a_n$ diverges.

  - $a = 1$ is inconclusive.
] <root-test>

#proof[
  If $a > 1$, then by the #ponder("analysis.limit-of-sequence")[definition of limit],
  $
    exists N in NN, forall n >= N: a_n^((1)/(n)) > 1.
  $
  This implies that $a_n > 1$ for all $n >= N$, so $sum a_n$ diverges by @nth-term-test[$n$th term test].

  Now, if $a < 1$, then there is some $r in RR$ such that $a < r < 1$. By the #ponder("analysis.limit-of-sequence")[definition of limit],
  $
    exists N in NN, forall n >= N, a_n^((1)/(n)) < r.
  $
  Hence $a_n <= r^n$ for all $n >= N$. By @comparison-test[Comparison Test], $sum a_n$ #ponder("analysis.series")[converges] since $sum r^n$ #ponder("analysis.series")[converges].

]

#example[
  - $sum (1)/(2^n)$: $root(n, a_n) = (1)/(2) < 1$, so it #ponder("analysis.series")[converges].

  - $sum 4^n$: $root(n, a_n) = 4 > 1$, so it diverges.
]

#proposition[Ratio test][
  If $a_n >= 0$ for all $n$, then consider $a_(n+1)/(a_n)$, and assume $exists a$ such that $a = lim_(n->oo) a_(n+1)/(a_n)$.

  Then

  - $a < 1$ implies $sum a_n$ #ponder("analysis.series")[converges].

  - $a > 1$ implies $sum a_n$ diverges.

  - $a = 1$ is inconclusive.
] <ratio-test>

#example[
  - $sum (1)/(n)$ (divergent) and $sum (1)/(n^2)$ (convergent) are both inconclusive under the #ponder("analysis.root-test")[root] and #ponder("analysis.ratio-test")[ratio] tests, since both have limit $1$ in both tests.

  - $sum (n)/(2^n)$ #ponder("analysis.series")[converges], since $ lim_(n->oo) a_(n+1)/(a_n) = lim_(n->oo) ((n+1)/(2^(n+1))) / (n/(2^n)) = lim_(n->oo) (n+1)/(2n) = (1)/(2) < 1. $

    Or alternatively, by the #ponder("analysis.root-test")[root test],
    $
      ((n)/(2^n))^((1)/(n)) = (n^((1)/(n)))/(2) -> (1)/(2) < 1.
    $

    #remark[
      To show that $n^((1)/(n)) -> 1$, write $n^((1)/(n)) = ee^((log n) / n)$ and #ponder("calculus.lhopitals-rule")[L'Hospital's rule] shows that $(log n) / n -> 0$.
    ]
]

#exercise[
  Show that if the #ponder("analysis.ratio-test")[ratio test] is inconclusive, then so is the #ponder("analysis.root-test")[root test]. Show also that the converse is not true, using
  $
    a_n = cases(
      2^(-n) quad & n "even",
      2^(-(n+1)) quad & n "odd"
    )
  $

]

#lecture-separator(lecture: 5, date: "2026-01-31")

#proposition[Integral Test][
  Suppose $f: [1, oo) -> [0, oo)$ is a continuous decreasing function (so it is integrable in $[1, N]$ for each $N in NN$ #fade[[we will see this later]]). Let $a_n = f(n)$ for each $n in NN$.

  Then
  $
    sum_(n>=1) a_n "converges" <=> lim_(n->oo) f(t) dif t "exists".
  $
  Furthermore, as $k->oo$,
  $
    sum_(n=1)^k a_n - integral_1^k f(x) dif x -> l "for some" l in [0, f(1)].
  $
  #remark[
    The RHS is an improper integral, which will be discussed later. The last part tells us that the integral is a good approximation for the #ponder("analysis.series")[series] (if it #ponder("analysis.series")[converges]), or the rate of divergence (if it diverges).
  ]
] <integral-test>

#proof[
  #align(center)[
    #dynamic-svg("/part-ia/analysis-i/media/d1e1.svg", width: 16em)
  ]
  We have
  $
    s_k - a_1 & = sum_(n=2)^k a_n & = sum #box(width: 0.8em, height: 0.8em, baseline: 0.15em, stroke: colors.red.shade500) &<= integral_1^k f(t) dif t, \
    s_(k-1) &= sum_(n=1)^(k-1) a_n &= sum #box(width: 0.8em, height: 0.8em, baseline: 0.15em, stroke: colors.blue.shade500) &>= integral_1^k f(t) dif t. \
  $

  #fade[[$=>$]] $integral_1^k f(t) dif t <= s_(k-1) <= s$ since $(s_k)$ is increasing and #ponder("analysis.sequence-convergence")[converges] by assumption. Thus $(integral_1^k f(t) dif t)_k$ is increasing and #ponder("analysis.bounded-above")[bounded above], so it #ponder("analysis.sequence-convergence")[converges].

  #fade[[$arrow.l.double$]] if the integral exists, then $(integral_1^k f(t) dif t)_k$ is #ponder("analysis.bounded-sequence")[bounded]. Hence $(s_k)$ is a #ponder("analysis.monotonic-sequence")[monotone] #ponder("analysis.bounded-sequence")[bounded] sequence and it #ponder("analysis.sequence-convergence")[converges].

  For the last part, let $b_k = sum_(n=1)^k a_n - integral_1^k f(x) dif x$. We have

  - $b_k - b_(k-1) = a_k - integral_(k-1)^k f(t) dif t = f(k) - integral_(k-1)^k f(t) dif t <= 0.$

  - $b_k >= a_k = f(k) >= 0$.

  Hence $(k)$ is decreasing and #ponder("analysis.bounded-below")[bounded below], so it #ponder("analysis.sequence-convergence")[converges] to some $l >= 0$. Also, since

  $
    0 <= f(k) <= b_k <= a_1 = f(1)
  $
  we get $0 <= l <= f(1)$.
]

#example[
  - $sum (1)/(n^p)$ #ponder("analysis.series")[converges] iff $p > 1$.

    Note that
    $
      lim_(x->oo) integral_1^x (1)/(t^p) dif t = lim_(x->oo) cases(
        (1-p)x^(-p) quad & p!=1,
        log x quad & p = 1
      )
      + "constant"
    $
    which exists for $p > 1$ and diverges for $p <= 1$.

    #remark[
      This is a much easier way to see the divergence of the harmonic series. Note _a posteriori_ that the divergence is not surprising, since for $sum a_n$ to #ponder("analysis.series")[converge] we need $a_n -> 0$ sufficiently fast to overcome the growth in the number of terms we are adding up.

      Rough calculation suggests that $a_n << (1)/(n)$ for large $n$ would be enough for #ponder("analysis.series")[convergence].
    ]

  - $sum (1)/(n log n)$ diverges since
    $
      integral 1/(t log t) dif t = integral (1)/(u) dif u = log u + C = log(log t) + C
    $
    with the substitution $u = log t$.

  - $sum (1)/(n log^2 n)$ #ponder("analysis.series")[converges] since
    $
      integral 1/(t log^2 t) dif t = integral (1)/(u^2) dif u = - (1)/(u) + C = - (1)/(log t) + C
    $
    with the substitution $u = log t$.
]

#proposition[Cauchy Condensation Test #fade[[Non-Examinable]]][
  Let $a_n >= 0$ for all $n$, and suppose that $(a_n)$ is decreasing. Then
  $
    sum a_n "converges" <=> sum 2^n a_(2^n) "converges."
  $

] <cauchy-condensation-test>

#proof[
  We have
  $
    integral_1^x f(t) dif t = log 2 integral_0^2^x f(2^t) 2^t dif t
  $
  using the substitution $u = 2^t dif t$.

  From @integral-test[Integral Test], we have
  $
    sum_(n=1)^oo a_n "converges" & <=> lim_(x->oo) integral_1^x f(t) dif t "exists" \
                                 & <=> lim_(y->oo) integral_0^y f(2^t) 2^t dif t "exists". \
  $
  Hence, letting $g(t) = 2^t f(2^t)$,
  $
    f "decreasing" & => f(2^(k+1)) <= f(t) <= f(2^k) quad & forall t in [k, k+1], \
    & => 2^k f(2^(k+1)) <= g(t) <= 2^(k+1) f(2^k) quad & forall t in [k, k+1], \
    &=> (1)/(2) sum_(n=1)^(k+1) 2^(n+1) a_(2^(n+1)) <= integral_1^(k+1) g(t) dif t <= 2 sum_(n=1)^(k+1) 2^n a_(2^n). \
  $

  Thus, $sum 2^n a_(2^n)$ #ponder("analysis.series")[converges] iff $lim_(y->oo) integral_0^y f(2^t) 2^t dif t$ exists, and the result follows.
]

#proposition[Alternating Series Test][
  Let $(a_n)$ be a decreasing sequence with $a_n >= 0$ and $a_n -> 0$. Then $sum_(n=1)^oo (-1)^(n+1) a_n$ #ponder("analysis.series")[converges].
] <alternating-series-test>

#example[
  $sum ((-1)^(n+1))/(n)$ #ponder("analysis.series")[converges] though $sum (1)/(n)$ diverges, by the #ponder("analysis.alternating-series-test")[alternating series test]. #fade[[In Section 5, we will show that it #ponder("analysis.series")[converges] to $log 2$.]]
] <ex-alternating-series-test>

#lecture-separator(lecture: 6, date: "2026-02-03")

#proof[
  Let $s_k = sum_(n=1)^k (-1)^(n+1) a_n$ be the #ponder("analysis.series")[partial sums]. Note that
  $
    s_(2k) = (a_1 - a_2) + (a_3 - a_4) + ... + (a_(2k-1) - a_(2k))
  $
  Hence,
  $
    s_2 <= s_4 <= s_6 <= ... <= s_(2k) <= ...
  $
  so $(s_(2k))$ is an increasing sequence.

  Also,
  $
    s_(2k+1) = a_1 + (-a_2 + a_3) + ... + (-a_(2k) + a_(2k+1))
  $
  so
  $ s_1 >= s_3 >= s_5 >= ... >= s_(2k+1) >= ... $

  and $(s_(2k+1)$ is decreasing.

  Moreover, $s_(2k+1) - s_(2k) = a_(2k+1) >= 0$, so we have
  $
    a_1 - a_2 = s_2 <= s_(2k) <= s_(2k+1) <= s_1 = a_1.
  $
  Therefore, both $(s_(2k))$ and $(s_(2k+1))$ are #ponder("analysis.bounded-sequence")[bounded]. By @monotone-convergence-theorem[Monotone Convergence Theorem], both sequences #ponder("analysis.sequence-convergence")[converge]. Let $s_(2k) -> s$ and $s_(2k+1) -> tilde(s)$ as $k -> oo$.

  Note that
  $
    tilde(s) - s = lim_(k->oo) (s_(2k+1) - s_(2k)) = lim_(k->oo) a_(2k+1) = 0.
  $

  #lemma[
    If the odd and even #ponder("analysis.subsequence")[subsequences] of a sequence both #ponder("analysis.sequence-convergence")[converge] to the same limit, then the whole sequence #ponder("analysis.sequence-convergence")[converges] to the same limit.
  ]

  #proof[
    Forall $epsilon > 0$,
    $
      & exists N_1 = N_1(epsilon), forall k >= N_1: abs(s_(2k) - s) < epsilon, \
      & exists N_2 = N_2(epsilon), forall k >= N_2: abs(s_(2k+1) - s) < epsilon. \
    $
    Hence $abs(s_n - s) < epsilon$ for all $n >= max{2 N_1, 2 N_2 + 1}$.
  ]

  Therefore, $s_k -> s$ as $k -> oo$.
]

#proposition[Dirichlet Test][
  Let $(a_n)$ be a decreasing sequence with $a_n >= 0$ and $a_n -> 0$. Let $(b_n)$ be a sequence such that the sequence of #ponder("analysis.series")[partial sums] $(s_k = sum_(n=1)^k b_n)_k$ is #ponder("analysis.bounded-sequence")[bounded].

  Then $sum a_n b_n$ #ponder("analysis.series")[converges].
] <dirichlet-test>

#definition[Absolute Convergence][
  A #ponder("analysis.series")[series] $sum a_n$ is said to *#ponder("analysis.absolute-convergence")[converge absolutely]* if $sum abs(a_n)$ #ponder("analysis.series")[converges].
] <absolute-convergence>

#remark[
  $abs(a_n) >= 0$ for all $n$, hence #ponder("analysis.root-test")[root], #ponder("analysis.ratio-test")[ratio], _etc._  tests can be applied to test for #ponder("analysis.absolute-convergence")[absolute convergence].
]

#lemma[
  If $sum a_n$ #ponder("analysis.absolute-convergence")[converges absolutely], then it #ponder("analysis.series")[converges].
] <absolute-implies-convergent>

#remark[
  The converse is not true by @ex-alternating-series-test. Hence, #ponder("analysis.absolute-convergence")[absolute convergence] is a strictly stronger notion. We call series that converge but not absolutely *conditionally convergent*.
]

#proof[
  Let $s_k = sum_(n<=k) a_n$, and let $r_k = sum_(n<=k) abs(a_n)$. Since $r_k$ is convergent, it is #ponder("analysis.cauchy-sequence")[Cauchy].
  $
    abs(s_k - s_l) = abs(sum_(n=l+1)^k a_n) <= sum_(n=l+1)^k abs(a_n) = abs(r_k - r_l) < epsilon quad forall k, l >= N(epsilon).
  $

  Thus, $(s_k)$ is #ponder("analysis.cauchy-sequence")[Cauchy] and hence #ponder("analysis.series")[convergent].
]

Conditionally convergent series can behave badly under #ponder("analysis.series-rearrangements")[rearrangements].

#example[
  Consider
  $
    sum_(n=1)^oo (-1)^(n+1) (1)/(n) = 1 - (1)/(2) + (1)/(3) - (1)/(4) + ...
  $
  Rearrange terms on the right as
  $
      & (1-(1)/(2)) - (1)/(4) + ((1)/(3)-(1)/(6)) - (1)/(8) + ((1)/(5)-(1)/(10)) - (1)/(12) + ... \
    = & (1)/(2) - (1)/(4) + (1)/(6) - (1)/(8) + (1)/(10) - (1)/(12) + ... \
    = & (1)/(2) (1 - (1)/(2) + (1)/(3) - (1)/(4) + ...) \
    = & (1)/(2) sum_(n=1)^oo (-1)^(n+1) (1)/(n). \
  $
  This suggests that the #ponder("analysis.series-rearrangements")[rearranged series] sums to half the original series.

  In a conditionally convergent series, the order of the sum matters. This is not the case for #ponder("analysis.absolute-convergence")[absolutely convergent] series, where any #ponder("analysis.series-rearrangements")[rearrangement] #ponder("analysis.series")[converges] to the same sum.
]

#proposition[Rearrangements of Absolutely Convergent Series][
  Let $sigma: NN->NN$ be a bijection. Let $a'_n = a_sigma(n)$. Then if $sum a_n$ is #ponder("analysis.absolute-convergence")[absolutely convergent], we have
  $
    sum a'_n = sum a_n.
  $
] <rearrangements-absolutely-convergent-series>

#proof[
  Let $s_k = sum_(n<=k) a_n$. By assumption, $exists s$ such that $s_k -> s$ as $k -> oo$. For $epsilon > 0$,
  $
    exists N = N(epsilon), forall k >= N: abs(s_k - s) < epsilon quad "and" quad sum_(k>=N) abs(a_k) < epsilon.
  $

  Now, since $sigma$ is a bijection, $exists M >= N$ such that $a_1, ..., a_N$ is contained in $a'_1, ..., a'_(M)$. Hence, for $m >= M$,
  $
             sum_(n=1)^m a'_n & = underbracket(sum_(n=1)^N a_n, s_N) + sum_(n=N+1)^m a'_n \
    abs(sum_(n=1)^m a'_n - s) & = abs(s_N - s) + sum_(k>=N) abs(a_k) \
                              & < epsilon + epsilon = 2 epsilon. \
  $
  Hence $sum a'_n = sum a_n.$

]
