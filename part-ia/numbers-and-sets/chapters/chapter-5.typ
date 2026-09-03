#import "../prelude.typ": *

= The #ponder("analysis.real-numbers")[Reals]

== Construction of $RR$

Recall the construction of $NN$ using Peano's axioms in @peano-axioms. We obtain $ZZ$ from $NN$ by allowing for subtraction. Formally, $ZZ$ is the #ponder("set-theory.equivalence-class")[equivalence classes] of $NN times NN$ under the #ponder("set-theory.equivalence-relation")[equivalence relation] $ (a, b) R (c, d) <=> a + d = b + c. $

We can now think of $(a, b)$ as $a-b$.

Write 0 for $[(1, 1)]$, $-a$ for $[(1, 1+a)]$ and define addition and multiplication on $ZZ$ by

$
      [(a, b)] + [(c, d)] & = [(a + c, b + d)] \
  [(a, b)] times [(c, d)] & = [(a c + b d, a d + b c)]
$

The rules of arithmetic can be verified for $ZZ$.

We obtain $QQ$ from $ZZ$ by allowing for division. Formally, $QQ$ is the #ponder("set-theory.equivalence-class")[equivalence classes] of $ZZ times NN$ under the #ponder("set-theory.equivalence-relation")[equivalence relation] $ (a, b) R (c, d) <=> a d = b c. $

We write $(a)/(b)$ for $[(a, b)]$. We can define $+, times$ on $QQ$ by
$
      [(a, b)] + [(c, d)] & = [(a d + b c, b d)] \
  [(a, b)] times [(c, d)] & = [(a c, b d)]
$

We can also define an order on $QQ, <$, which has the property that

1. If $a, b in QQ$, then only one of the following holds: $a < b$, $a = b$, $a > b$.

2. If $a < b$ and $b < c$ then $a<c$.

#lecture-separator(lecture: 15, date: "2025-11-11")

The ordering $<$ on $QQ$ has the useful property that between any 2 rational numbers there is another rational number: if $p, q in QQ$ and $p < q$, then $p < (p+q)/(2) < q$.

Nonetheless, there are _gaps_ in $QQ$.

#proposition[
  There is no rational $x$ with $x^2 = 2$.
] <prop-no-rational-sqrt2>

#proof[
  Suppose $x^2 = 2$, and WLOG assume that $x > 0$. If $x$ is rational, then we can write $x = (a)/(b)$ for some $a, b in ZZ^+$. Then $(a^2)/(b^2)=2$, so $a^2 = 2b^2$.

  But the exponent of 2 in the #ponder("number-theory.prime-factorisation-existence")[prime factorisation] of $a^2$ is even, while that in $2b^2$ is odd, contradicting the #ponder("number-theory.fundamental-theorem-of-arithmetic")[fundamental theorem of arithmetic]. $smash$
]

#remark[
  The same proof shows that if $exists x in QQ$ with $x^2=n$ for some $n in NN$, then $n$ must be a square number.
]

Now we shall see an alternative proof.

#proof[
  Suppose $x^2=2$ for some $x = (a)/(b)$ with $a, b in ZZ^+$. Then for any $c, d in ZZ$, $c x + d$ is of the form $(e )/(b)$ for some $e in ZZ$.

  Thus if $c x + d > 0$, then $(c x + d) >= 1 / b$. But we have $0 < x - 1 < 1$ as $1 < x < 2$, so if $n$ is sufficiently large,
  $ 0 < (x - 1)^n < (1)/(b). $
  But for any $n in NN$, $(x-1)^n$ is of the form $c x + d$ #fade[[we replace all even powers of $x$ by $2$]], for some $c, d in ZZ$. Thus $0 < c x + d < (1)/(b)$. $smash$
]

So $QQ$ clearly has gaps. We shall express this fact making reference only to $QQ$, in order to motivate the construction of $RR$.

Let $A$ be the set of positive rationals $p$ such that $p^2 < 2$. We will show that $A$ contains no largest number. For any $p in A$, consider $q = p - (p^2-2)/(p+2)$. Then $q in QQ$, and by definition $p^2 - 2 < 0$, so $q > p$.
Also,
$
  q^2 - 2 & = (p - (p^2-2)/(p+2))^2 - 2 \
          & = (2(p^2-2))/( p+2)^2 < 0.
$
Thus $q in A$, so $A$ has no largest number. Similarly the set ${q in QQ: q > 0, q^2 > 2}$ has no smallest number.

#important[
  In $QQ$, there is no #ponder("analysis.least-upper-bound")[least upper bound] for the set $A = {p in QQ: p > 0, p^2 < 2}$. This implies a _gap_ in $QQ$.
]

#definition[Real numbers][
  The *#ponder("analysis.real-numbers")[real numbers]*, $RR$, are a set with elements $0$ and $1$ where $0 != 1$, equipped with operations $+$ and $times$, and an ordering $<$ satisfying the following axioms:

  1. $+$ is #ponder("algebra.commutativity-associativity-distributivity")[commutative] and #ponder("algebra.commutativity-associativity-distributivity")[associative] with identity $0$, and every $x$ has an inverse under $+$.

  2. $times$ is #ponder("algebra.commutativity-associativity-distributivity")[commutative] and #ponder("algebra.commutativity-associativity-distributivity")[associative] with identity $1$, and every $x != 0$ has an inverse under $times$.

  3. $times$ is #ponder("algebra.commutativity-associativity-distributivity")[distributive] over $+$.

  4. $forall a, b in RR$, exactly one of the following holds: $a < b$, $a = b$, $b < a$, and $forall a, b, c in RR$, if $a < b$ and $b < c$ then $a < c$.

  5. $forall a, b, c in RR$, if $a < b$ then $a + c < b + c$, and if $a < b$ and $0 < c$ then $a c < b c$.

  6. Given any set $S$ of reals that is non-empty and bounded above, there exists a #ponder("analysis.least-upper-bound")[least upper bound] of $S$ in $RR$. #fade[[This is the #ponder("analysis.least-upper-bound")[least upper bound axiom].]]
] <def-real-numbers>

#definition[Bounded above][
  A set $S subset RR$ is *#ponder("analysis.bounded-above")[bounded above]* if there exists some $x in RR$ such that $forall y in S, y <= x$. Such an $x$ is called an *#ponder("analysis.bounded-above")[upper bound]* of $S$.
] <def-bounded-above>

#definition[Least upper bound][
  An #ponder("analysis.bounded-above")[upper bound] $x$ of a set $S subset RR$ is a *#ponder("analysis.least-upper-bound")[least upper bound]* if for any #ponder("analysis.bounded-above")[upper bound] $x'$ of $S$, $x <= x'$. We write $sup S$ for the #ponder("analysis.least-upper-bound")[least upper bound] of $S$.
] <def-least-upper-bound>

#remark[
  1. In @def-real-numbers, from (1-5) we can check for example that $0 < 1$, indeed, if not then $1 < 0$, so
    $ 0 = 1 - 1 < 0 < 0 - 1 = -1 $

    so $0 = 0 dot (-1) < (-1) dot (-1) = 1$. $smash$

  2. We may consider $QQ$ as contained in $RR$ by identifying $(a)/(b) in QQ$ with $a times b^(-1) in RR$.

  3. $QQ$ does not satisfy (6), _e.g._ $A = {p in QQ: p > 0, p^2 < 2}$ as shown above.

  4. In (6), it is crucial that $S$ is non-empty and bounded above. If $S$ is empty, then every $x in RR$ is an upper bound of $S$, so there is no least upper bound. If $S$ is not bounded above, then there is no upper bound, hence no least upper bound.
]

#lecture-separator(lecture: 16, date: "2025-11-13")

#example[Examples of least upper bounds][
  1. Consider the set $S = {x in RR: 0 <= x <= 1} = [0, 1]$.

    $2$ is an #ponder("analysis.bounded-above")[upper bound] for $S$, since $forall x in S, x <= 2$.

    $(3)/(4)$ is not an #ponder("analysis.bounded-above")[upper bound] for $S$, since $(7)/(8) > (3)/(4)$ and $(7)/(8) in S$.

    The #ponder("analysis.least-upper-bound")[LUB] is $1$ because:

    - $1$ is an #ponder("analysis.bounded-above")[upper bound] of $S$.

    - Every other #ponder("analysis.bounded-above")[upper bound] $x$ of $S$ satisfies $x >= 1$ since $1 in S$.

  2. Consider the set $S = {x in RR: 0 < x < 1} = (0, 1)$.

    $2$ is an #ponder("analysis.bounded-above")[upper bound] for $S$.

    $(3)/(4)$ is not an #ponder("analysis.bounded-above")[upper bound] for $S$.

    We have $sup S = 1$ because

    - $1$ is an #ponder("analysis.bounded-above")[upper bound] of $S$.

    - We claim that there is no #ponder("analysis.bounded-above")[upper bound] $c$ such that $c < 1$:

      Certainly $c > 0$. So if $c < 1$, then $0 < c < 1$, and $(c + 1)/(2) in S$ with $(c + 1)/(2) > c$, contradicting the fact that $c$ is an #ponder("analysis.bounded-above")[upper bound] of $S$.

  #important[
    If $S$ has a greatest element, then $sup S = max S in S$.

    However, it is not necessary that $sup S in S$.
  ]

  3. Consider $S = {0, (1)/(2), (3)/(4), (4)/(5), ...} = {1-(1)/(n): n in NN}$.

    It is clear that $1$ is an #ponder("analysis.bounded-above")[upper bound] of $S$. We wish to show that $sup S = 1$.
]


#proposition[Axiom of Archimedes][
  $NN$ is not #ponder("analysis.bounded-above")[bounded above] in $RR$.
] <axiom-of-archimedes>

#proof[
  Suppose, on the contrary, that $NN$ is #ponder("analysis.bounded-above")[bounded above]. Let $c = sup NN$. By definition, $c - 1$ cannot be an #ponder("analysis.bounded-above")[upper bound] of $NN$, so there exists some $n in NN$ with $n > c - 1$. Then $n + 1 in NN$, and $n + 1 > c$, contradicting the fact that $c$ is an #ponder("analysis.bounded-above")[upper bound] of $NN$. $smash$
]

#corollary[
  For any real number $t > 0$, $exists n in NN$ such that $(1)/(n) < t$.
] <cor-archimedes>

#proof[
  Given $t > 0$, by #ponder("analysis.archimedean-property")[Axiom of Archimedes], there exists some $n in NN$ such that $n > (1)/(t)$. Thus $(1)/(n) < t$.
]

#definition[Bounded below][
  A set $S$ is said to be *#ponder("analysis.bounded-below")[bounded below]* if $exists x$ such that $x <= y$ for all $y <= S$. Such an $x$ is called a *#ponder("analysis.bounded-below")[lower bound]* of $S$.
] <def-bounded-below>

#definition[Greatest lower bound][
  If $S$ is a non-empty set and #ponder("analysis.bounded-below")[bounded below], then define $-S = {-y: y in S}$, which is non-empty and #ponder("analysis.bounded-above")[bounded above]. We define the *#ponder("analysis.greatest-lower-bound")[greatest lower bound]* of $S$ by $inf S = - sup(-S)$.
] <def-greatest-lower-bound>

@cor-archimedes immediately implies that
$
  inf {(1)/(n) : n in NN} = 0.
$

@axiom-of-archimedes and @cor-archimedes imply that there are no _infinitely large_ or _infinitely small_ #ponder("analysis.real-numbers")[real numbers].

#example[
  Consider $S = {1 - (1)/(n): n in NN}$.

  We have $sup S = 1$. Since if we suppose $c < 1$ is an #ponder("analysis.bounded-above")[upper bound] of $S$, then
  $
    1 - (1)/(n) & <= c quad forall n in NN, \
      0 < 1 - c & <= (1)/(n) quad forall n in NN,
  $
  contradicting @cor-archimedes.
]

#proposition[
  There exists $x in RR$ with $x^2 = 2$.
]

#proof[
  Let $S = {x in RR: x^2 < 2}$. We have $S$ is non-empty (since $1 in S$) and #ponder("analysis.bounded-above")[bounded above] (since $2 in RR$ is an #ponder("analysis.bounded-above")[upper bound] of $S$). Let $c = sup S$, and identify that $1 < c < 2$. We claim that $c^2 = 2$.

  Suppose $c^2 < 2$. For $0 < t < 1$, we have
  $
    (c + t)^2 & = c^2 + 2 c t + t^2 \
              & < c^2 + 4 t + t \
              & = c^2 + 5 t \
              & < 2,
  $
  provided we pick a sufficiently small $t$ (_e.g._ $t < (2 - c^2)/(5)$). Thus $c + t in S$, contradicting the fact that $c$ is an #ponder("analysis.bounded-above")[upper bound] of $S$.

  Suppose $c^2 > 2$. For $0 < t < 1$, we have
  $
    (c - t)^2 & = c^2 - 2 c t + t^2 \
              & > c^2 - 4 t \
              & > 2,
  $
  provided we pick a sufficiently small $t$ (_e.g._ $t < (c^2 - 2)/(4)$). Thus $c - t in.not S$ and it is an #ponder("analysis.bounded-above")[upper bound], contradicting the fact that $c = sup S$.
]

#remark[
  The same proof shows that $root(n, x)$ exists $forall n in NN, forall x in RR^+$.
]

#definition[Irrational number][
  A #ponder("analysis.real-numbers")[real number] that is not rational is called *#ponder("analysis.irrational-number")[irrational]*.
] <def-irrational-number>

#example[
  $sqrt(2), sqrt(3), sqrt(6)$ are all #ponder("analysis.irrational-number")[irrational numbers].

  We can also construct #ponder("analysis.irrational-number")[irrationals] from linear combinations of rationals and irrationals, such as $2+3sqrt(5)$. Indeed, if $2 + 3sqrt(5) = (a)/(b)$ with $a, b in NN$, then $sqrt(5) = ((a)/(b) - 2)/(3) in QQ$, contradicting the fact that $sqrt(5)$ is #ponder("analysis.irrational-number")[irrational].
] <ex-irrational-examples>

#lecture-separator(lecture: 17, date: "2025-11-18")

#proposition[
  The rationals are *#ponder("analysis.density-of-rationals")[dense]* in $RR$. That is, $forall a, b in RR$ with $a < b$, $exists q in QQ$ such that $a < q < b$.
] <proposition-rationals-dense>

#proof[
  WLOG assume that $a >= 0$. By @cor-archimedes, there exists some $n in NN$ such that $(1)/(n) < b - a$.

  Consider the set $T = {k in NN: (k)/(n) >= b}$. By @axiom-of-archimedes[Axiom of Archimedes], $exists N in NN$ such that $N > b$, hence $n N in T$ and $T != emptyset$.

  By the @well-ordering-principle[Well-ordering Principle], $T$ has a least element, say $m$. Let $c = (m-1)/(b)$. Since $m-1 in.not T$, we have $c < b$.

  Suppose $c <= a$. Then $(m)/(n) = c + (1)/(n) < a + (b - a) = b$. $smash$

  Hence $a < c < b$, and $c in QQ$ as required.
]

Note that the #ponder("analysis.irrational-number")[irrationals] $RR\\QQ$ is also #ponder("analysis.density-of-rationals")[dense] in $RR$. Indeed, if we take a non-zero rational $c$ with $a sqrt(2) < c < b sqrt(2)$, then $(c)/(sqrt(2))$ is #ponder("analysis.irrational-number")[irrational] and satisfies $a < (c)/(sqrt(2)) < b$.

== #ponder("analysis.sequence")[Sequences]

#definition[Sequence][
  A *#ponder("analysis.sequence")[sequence]* is an enumerated collection of objects in which repetitions are allowed, and order matters. We write $a_1, a_2, a_3, ...$ or $(a_n)_(n=1)^oo$.
] <def-sequence>

#ponder("analysis.limit-of-sequence")[Sequence limits] are important in analysis, and we shall define them rigorously. For a sequence $a_1, a_2, a_3, ...$ to tend to a #ponder("analysis.limit-of-sequence")[limit] $l$, it is not enough to show that the terms get _closer_ to $l$.

For example, we would not want $0, (1)/(2), (2)/(3), (3)/(4), ...$ to tend to $35$.

And it is also not enough that the terms get _arbitrarily close_ to $l$, in the sense that
$
  forall epsilon > 0, exists n in NN: l - epsilon < a_n < l + epsilon.
$


For example, we would not want $0, 10, (1)/(2), 10, (2)/(3), 10, (3)/(4), 10, ...$ to tend to $1$.

Therefore, we want the #ponder("analysis.sequence")[sequence] to get and stay within $epsilon$ of $l$ after some point.

#definition[Limit of a sequence][
  We say that the #ponder("analysis.sequence")[sequence] $a_1, a_2, a_3, ...$ tends to the *#ponder("analysis.limit-of-sequence")[limit]* $l in RR$ as $n$ tends to $oo$, if
  $
    forall epsilon > 0, exists N in NN, forall n in NN, abs(a_n - l) < epsilon.
  $
  where the absolute value $abs(x)$ for $x in RR$ is defined by
  $
    abs(x) = cases(
      x & "if" x >= 0,
      -x & "if" x < 0,
    ).
  $
] <def-limit-of-sequence>


We think of $abs(a - b)$ as the _distance between_ $a$ and $b$ on our number line. We can also check that the triangle inequality holds:
$
  abs(a-c) <= abs(a-b) + abs(b-c).
$

#remark[
  We will typically apply the triangle inequality using the the following technique:
  $
    abs(a-c) & = abs(a - b + b - c) & <= abs(a - b) + abs(b - c).
  $
]

#notation[
  When $(a_n)_(n=1)^oo$ tends to $l$ as $n$ tends to $oo$, we can write $a_n -> l$ as $n -> oo$ or $lim_(n -> oo) a_n = l$.
]

#definition[Sequence convergence][
  If there is a #ponder("analysis.limit-of-sequence")[limit] $l$ such that $a_n -> l$ as $n -> oo$, we say that the sequence $(a_n)_(n=1)^oo$ *#ponder("analysis.sequence-convergence")[converges]*. Otherwise, we say that it *#ponder("analysis.sequence-convergence")[diverges]*.
] <def-sequence-convergence>

#example[
  1. $0, (1)/(2), (2)/(3), (3)/(4), (4)/(5), ...$, _i.e._ $a_n = 1-(1)/(n)$ tends to $1$ as $n$ tends to $oo$.

    #align(center)[
      #dynamic-svg("/part-ia/numbers-and-sets/media/d3e1.svg", width: 20em)
    ]

    Given $epsilon > 0$, choose $N > (1)/(epsilon)$ (using @axiom-of-archimedes[Axiom of Archimedes]). Then if $n >= N$,
    $
      abs(a_n - 1) = abs(1 - (1)/(n) - 1) = (1)/(n) <= (1)/(N) < epsilon.
    $

    Hence $a_n -> 1$ as $n -> oo$.

  2. $0, (1)/(2), 0, (1)/(4), 0, ...$ defined by
    $
      a_n = cases(
        (1)/(n) & "if" n "is even",
        0 & "if" n "is odd",
      )
    $
    Given $epsilon > 0$, pick $N > (1)/(epsilon)$. If $n >= N$, then
    $
      abs(a_n - 0) = cases(
        abs((1)/(n) - 0) = (1)/(n) <= (1)/(N) < epsilon & "if" n "is even",
        abs(0 - 0) = 0 < epsilon & "if" n "is odd",
      )
    $
    Hence $a_n -> 0$ as $n -> oo$.

  3. $(1)/(2), (3)/(4), (7)/(8), ...$ defined by $a_n = 1 - (1)/(2^n)$ tends to $1$ as $n$ tends to $oo$.

    Let us consider which $N$ to choose for a given $epsilon > 0$. We want

    $
      abs(a_n-1) = (1)/(2^n) <= (1)/(n) <= (1)/(N) < epsilon,
    $

    so choosing $N > (1)/(epsilon)$ suffices.

    Hence $a_n -> 1$ as $n -> oo$.

  #lecture-separator(lecture: 18, date: "2025-11-20")

  4. $-1, 1, -1, 1, ...$ defined by $a_n = (-1)^n$.

    If $a_n$ does not tend to $l$, we write $a_n arrow.not l$. This means

    $
      exists epsilon > 0, forall N in NN, exists n >= N, abs(a_n-l) >= epsilon.
    $

    We claim that $a_n arrow.not 0$. Indeed let $epsilon = 1$, and observe that for any $N in NN$, $abs(a_n - 0) = 1$ for all $n in NN$.

    In fact, $a_n$ does not #ponder("analysis.sequence-convergence")[converge] to any #ponder("analysis.limit-of-sequence")[limit] $l in RR$. Suppose $a_n -> l$ as $n->oo$ for some $l in RR$, let $epsilon > 1$. Then $exists N in NN$ such that $forall n >= N$, $abs(a_n - l) < 1$. In particular,
    $
      abs(1-l) < 1 quad "and" quad abs(-1-l) < 1.
    $
    But we also have
    $
      2 & = abs(1-(-1)) \
        & = abs(1 - l + l - (-1)) \
        & <= abs(1 - l) + abs(1+l) \
        & <= abs(1 - l) + abs(-1 - l) \
        & < 1 + 1 = 2,
    $
    which is a contradiction. $smash$

    Hence $a_n$ #ponder("analysis.sequence-convergence")[diverges]. #fade[[#ponder("analysis.sequence-convergence")[Divergence] does not always mean that the terms tend to $oo$ or $-oo$.]]
]

#proposition[
  #ponder("analysis.limit-of-sequence")[Limits] of sequences are unique.
] <prop-unique-limits>

#proof[
  Suppose $a_n -> l$ and $a_n -> k$ as $n -> oo$ with $l != k$. Choose $epsilon = (1)/(2) abs(l-k) > 0$. Then
  $
    & exists N in NN, & forall n >= N, & abs(a_n - l) & < epsilon, \
    & exists M in NN, & forall n >= M, & abs(a_n - k) & < epsilon.
  $
  But then for any $n >= max {N, M}$,
  $
    2epsilon = abs(l - k) = abs(l - a_n + a_n - k) <= abs(l - a_n) + abs(a_n - k) < epsilon + epsilon = 2 epsilon,
  $
  which is a contradiction. $smash$

]

#definition[Bounded sequence][
  A #ponder("analysis.sequence")[sequence] $(a_n)_(n=1)^oo$ is *#ponder("analysis.bounded-sequence")[bounded]* if there exists some $B in RR$ such that $forall n in NN, abs(a_n) <= B$.
] <def-bounded-sequence>

#proposition[
  Every #ponder("analysis.sequence-convergence")[convergent sequence] is #ponder("analysis.bounded-sequence")[bounded].
] <prop-convergent-bounded>

#proof[
  If $a_n -> l$ as $n->oo$, then $exists N in NN$ such that $forall n >= N$, $abs(a_n - l) < 1$.

  Hence $abs(a_n) <= max {abs(a_1), abs(a_2), ..., abs(a_(N-1)), abs(l) + 1 }$ for all $n in NN$.
]

#definition[Monotonic sequence][
  A #ponder("analysis.sequence")[sequence] is *#ponder("analysis.monotonic-sequence")[monotonic]* if it is either increasing or decreasing. That is,
  - *#ponder("analysis.monotonic-sequence")[monotonic increasing]*: $forall n in NN, a_n <= a_(n+1)$,
  - *#ponder("analysis.monotonic-sequence")[monotonic decreasing]*: $forall n in NN, a_n >= a_(n+1)$,
] <def-monotonic-sequence>

#theorem[Monotonic convergence theorem][
  Every #ponder("analysis.bounded-sequence")[bounded] #ponder("analysis.monotonic-sequence")[monotonic] sequence #ponder("analysis.sequence-convergence")[converges].
] <monotonic-convergence-theorem>

#proof[
  Suppose $(a_n)_(n=1)^oo$ is #ponder("analysis.monotonic-sequence")[monotonic increasing] and #ponder("analysis.bounded-sequence")[bounded]. Then the set ${a_n: n >= 1}$ is non-empty and #ponder("analysis.bounded-above")[bounded above]. By the #ponder("analysis.least-upper-bound")[least upper bound axiom], let $l = sup {a_n: n >= 1}$.

  Given $epsilon > 0$, $l - epsilon$ cannot be an #ponder("analysis.bounded-above")[upper bound] of ${a_n: n >= 1}$, so there exists some $N in NN$ such that $a_N > l - epsilon$. Then for any $n >= N$,
  $
    l - epsilon < a_n <= l,
  $
  since the #ponder("analysis.sequence")[sequence] is #ponder("analysis.monotonic-sequence")[increasing]. Thus $abs(a_n - l) < epsilon$ for all $n >= N$, so $a_n -> l$ as $n -> oo$.

  The case where $(a_n)_(n=1)^oo$ is monotonic decreasing is similar.
]

#remark[

  1. Note that for an #ponder("analysis.monotonic-sequence")[increasing sequence] to #ponder("analysis.sequence-convergence")[converge], we only need to know that it is #ponder("analysis.bounded-above")[bounded above].

  2. #ponder("analysis.bounded-sequence")[Boundedness] is necessary: consider $a_n = n$. This #ponder("analysis.sequence")[sequence] is #ponder("analysis.monotonic-sequence")[increasing], unbounded and does not #ponder("analysis.sequence-convergence")[converge].

  3. The #ponder("analysis.monotone-convergence-theorem")[monotonic convergence theorem] is equivalent to the #ponder("analysis.least-upper-bound")[least upper bound axiom].

  4. We can show that every #ponder("analysis.sequence")[sequence] has a #ponder("analysis.monotonic-sequence")[monotonic] subsequence.
]

#proposition[
  If $a_n <= d$ for all $n in NN$ and $a_n -> c$ as $n -> oo$, then $c <= d$.
]

#proof[
  Suppose $c > d$. Let $epsilon = abs(c-d) > 0$. Then $exists N in NN$ such that $forall n > N$, $abs(a_n - c) < epsilon$. But then for any such $n$,
  $ a_n & = c + (a_n - c) \
      & >= c - abs(a_n - c) \
      & > c - epsilon = d, $ contradicting the fact that $a_n <= d$ for all $n in NN$. $smash$
]

#important[
  If $a_m < d$ for all $n in NN$ and $a_n -> c$ as $n -> oo$, we need not the strict inequality $c < d$.
]

#proposition[
  If $a_n -> c$ as $n->oo$ and $b_n -> d$ as $n->oo$, then $a_n + b_n -> c + d$ as $n->oo$.
]

#proof[
  Given $epsilon > 0$, then
  $
    & exists N in NN, forall n >= N, abs(a_n - c) & < epsilon/(2), \
    & exists M in NN, forall n >= M, abs(b_n - d) & < epsilon/(2).
  $
  Choose $N^* = max {N, M}$, then for any $n >= N^*$,
  $
    abs((a_n + b_n) - (c + d)) & = abs((a_n - c) + (b_n - d)) \
                               & <= abs(a_n - c) + abs(b_n - d) \
                               & < epsilon/(2) + epsilon/(2) = epsilon.
  $
  Hence $a_n + b_n -> c + d$ as $n -> oo$.
]

#lecture-separator(lecture: 19, date: "2025-11-22")

== #ponder("analysis.series")[Series]

In the reals, the sum of two numbers is defined, so by induction we can define the sum of finitely many numbers. However, we cannot directly define the sum of infinitely many numbers.

#definition[Series][
  Let $(a_n)$ be a #ponder("analysis.sequence")[sequence] in $RR$. Then
  $
    s_k = sum_(n=1)^k a_n
  $
  is the *$k$th #ponder("analysis.series")[partial sum]* of the *#ponder("analysis.series")[series]* whose $n$th term is $a_n$. We write
  $
    sum_(n=1)^oo a_n = lim_(k -> oo) s_k
  $
  if the #ponder("analysis.limit-of-sequence")[limit] exists.
] <def-series>

#example[
  1. The #ponder("analysis.series")[series] whose $n$th term is $a_n = r^n$ for some $abs(r) < 1$ is called the *geometric series*:
    $
      s_k & = r + r^2 + ... + r^k \
          & = r dot (1 - r^k)/(1 - r) \
          & -> r dot (1)/(1-r) quad "as" k -> oo "since" r^k < 1.
    $
    Hence $sum_(n=1)^oo r^n = r/(1-r)$ for $abs(r) < 1$.

  2. The #ponder("analysis.series")[series] whose $n$th term is $a_n = (1)/(n)$ is known as the *harmonic series*:

    $
      s_(2^k) & = 1 + (1)/(2) + underbracket((1)/(3) + (1)/(4), "each" >= (1)/(4)) + underbracket((1)/(5) + (1)/(6) + (1)/(7) + (1)/(8), "each" >= (1)/(8)) + ... + (1)/(2^k) \
      & >= 1+ 1/2 + (1)/(4) + (1)/(4) + (1)/(8) + (1)/(8) + (1)/(8) + (1)/(8) + ... + (1)/(2^k). \
    $
    In general,
    $
      (1)/(2^m + 1) + (1)/(2^m + 2) + ... + (1)/(2^(m+1)) >= 2^m dot (1)/(2^(m+1)) = (1)/(2).
    $
    Hence
    $
      s_(2^k) & >= 1 + (1)/(2) + k dot (1)/(2) \
              & = 1 + (k)/(2).
    $
    So the #ponder("analysis.series")[partial sums] are increasing and unbounded, hence $sum_(n=1)^oo (1)/(n)$ #ponder("analysis.series")[diverges].

  3. The #ponder("analysis.series")[series] whose $n$th term is $a_n = (1)/(n^2)$:

    $
      s_(2^k - 1) = 1 + underbracket((1)/(2^2) + (1)/(3^2), <= 2 dot (1)/(2^2)) + underbracket((1)/(4^2) + (1)/(5^2) + (1)/(6^2) + (1)/(7^2), <= 4 dot (1)/(4^2)) +...+ (1)/(2k-1)^2.
    $

    In general,
    $
      (1)/(2^m)^2 + (1)/(2^m + 1)^2 + ... + (1)/(2^(m+1) - 1)^2 <= 2^m dot (1)/(2^(2 m)) = (1)/(2^m).
    $
    Hence
    $
      s_(2^k - 1) & <= 1 + (1)/(2) + (1)/(4) + ... + (1)/(2^(k-1)) \
                  & = 2 - (1)/(2^(k-1)) \
                  & < 2.
    $

    So the #ponder("analysis.series")[partial sums] are increasing and #ponder("analysis.bounded-above")[bounded above], hence by @monotonic-convergence-theorem[Monotonic Convergence Theorem], $sum_(n=1)^oo (1)/(n^2)$ #ponder("analysis.series")[converges].

    In fact, $sum_(n=1)^oo (1)/(n^2) = ppi^2/(6)$.
]

== Decimal Expansions

Let $(d_n)$ be a sequence where each $d_n in {0, 1, 2, ..., 9}$. Then $sum_n=1^oo (d_n)/(10^n)$ converges to some limit $x$ with $0 <= x <= 1$, since te #ponder("analysis.series")[partial sums] are increasing and #ponder("analysis.bounded-above")[bounded above] by
$
  sum_(n=1)^oo (9)/(10^n) = 9/(10) dot (1)/(1 - (1)/(10)) = 1.
$

We say that $x$ has *decimal expansion* $0.d_1 d_2 d_3 ...$. We shall consider whether every $x$ with $0 <= x < 1$ have a decimal expansion.

We can pick $d_1 in ZZ$ to be maximal such that $(d_1)/(10) <= x < 1$.

Then $0 <= d_1 <= 9$ because $0<= x < 1$ and $0 <= x - (d_1)/(10) < (1)/(10)$ by maximality of $d_1$.

Then, pick $d_2 in ZZ$ to be maximal such that $d_2 / 100 <= x - (d_1)/(10)$, and we have $0 <= x - (d_1)/(10) - (d_2)/(100) < (1)/(100)$ by maximality of $d_2$.

Inductively, we can pick $d_n in ZZ$ to be maximal such that
$
  (d_n)/(10^n) <= x - sum_(j = 1)^(n-1) (d_j)/(10^j)
$
so that
$
  0 <= x - sum_(j = 1)^n (d_j)/(10^j) < (1)/(10^n).
$
Since $(1)/(10^n) -> 0$ as $n -> oo$, we have
$
  x - sum_(j = 1)^n (d_j)/(10^j) -> 0 quad "as" n -> oo.
$
Thus
$
  x = sum_(j = 1)^oo (d_j)/(10^j) = 0.d_1 d_2 d_3 ...
$

#remark[

  1. Decimal expansions are not unique: for example, $0.47999999... = 0.48000000...$.

    We show that this happens if and only if the decimal expansion ends in an infinite string of $9$s.

    Suppose $0.a_1 a_2 a_3 ... = 0.b_1 b_2 b_3 ...$ with $a_i$ and $b_i$ not all equal, then suppose $a_j = b_j$ for all $j < k$ for some $k$, and WLOG assume $a_k < b_k$.

    Then
    $
      sum_(j = k + 1)^oo (a_j)/(10^j) <= sum_(j = k+1)^oo (9)/(10^j) = (9)/(10^(k+1)) dot (1)/(1-(1)/(10)) = (1)/(10^k).
    $
    We must have $b_k = a_k + 1$, for that if $b_k > a_k + 1$, then $b - a >= 2dot 10^(-k) - 10^(-k) > 0$.

    Also, for all $j > k$, we have $a_j = 0$ and $b_k = 0$.

  #lecture-separator(lecture: 20, date: "2025-11-25")

  2. A decimal expansion if *periodic* if, after a finite number of terms, it repeats in blocks, of length $k$ say. _i.e._ $exists l, k$ such that $forall n > l$, $d_n = d_(n+k)$.

    A periodic decimal is rational, _e.g._
    $
      x = 0.underbracket(7832, l)underbracket(147147147147, k=3)...
    $
    Then we have
    $
      10^4 - x - 7832 & = 0.147147147... \
                      & = 147 sum_(j = 1)^oo (1)/(10^(3 j)) \
                      & = 147 dot (1)/(10^3) dot (1)/(1 - (1)/(10^3)) in QQ.
    $
    So $x in QQ$.

    Conversely, if $x in QQ$, then it has a periodic decimal expansion. To see that, we write $x = (p)/(2^a 5^b q)$ where $a, b, p, q in ZZ$ with $a, b, q >= 0$, and $gcd(10, q) = 1$. Then
    $
      10^(max(a, b))x = (t)/(q) = n + (c)/(q)
    $
    where $n, c in ZZ$ and $0 <= c < q$.

    By @fermat-euler-theorem[Fermat-Euler Theorem], since $gcd(q, 10) = 1$, we have
    $
          10^phi(q) & equiv 1 mod q \
      10^phi(q) - 1 & = k q quad "for some" k in NN.
    $
    Hence
    $
      (c)/(q) = (k c)/(k q)=(k c)/(10^phi(q) - 1) = k c dot sum_(j = 1)^oo (1)/((10^phi(q))^j).
    $
    Since $0 <= k c < k q$, and $k q$ has at most $10^phi(q)$ digits (by Fermat-Euler), we can write $k c$ as a $phi(q)$-digit number $d_1d_2...d_(phi(q))$.

    Thus $c / q = 0.d_1d_2...d_(phi(q))d_1d_2...d_(phi(q))...$ and so $x$ has a periodic decimal expansion.
]

== Euler's Number $ee$

We define
$
  ee = 1 + (1)/(1!) + underbracket((1)/(2!), <=(1)/(2)) + underbracket((1)/(3!), <=(1)/(4)) + underbracket((1)/(4!), <= (1)/(8)) + ...
$

By @monotonic-convergence-theorem[Monotonic Convergence Theorem], the #ponder("analysis.series")[series] #ponder("analysis.series")[converges], since the #ponder("analysis.series")[partial sums] are increasing and #ponder("analysis.bounded-above")[bounded above] by $3$.

If we define $0! = 1$, then $ee = sum_(j=0)^oo (1)/(j!)$.

#proposition[
  $ee$ is #ponder("analysis.irrational-number")[irrational].
] <prop-e-irrational>

#proof[
  Suppose $ee$ were rational, _i.e._ $ee = (p)/(q)$ where $p, q in NN$ and $q > 1$ (since $2 < ee < 3$).

  But

  $
    q! ee in NN & = q! + (q!)/(1!) + (q!)/(2!) + ... + (q!)/(q!) + (q!)/(q+1!) + ... \
                & = N + x quad "for some" N in NN \
  $
  where
  $
    x & = sum_(j = q + 1)^oo (q!)/(j!) = sum_(j = 1)^oo (q!)/(q + j)! \
    & = (1)/(q+1) + underbracket((1)/((q+1)(q+2)), <=(1)/((q+1)^2)) + underbracket((1)/((q+1)(q+2)(q+3)), <= (1)/((q+1)^3)) +... \
  $
  and in general,
  $
    (q!)/((q+j)!) <= (1)/((q+1)^j).
  $
  So $x <= (1)/(q+1) + (1)/(q+1)^2 + (1)/(q+1)^3 + ... = (1)/(q) <= (1)/(2)$.
  Thus $0 < x < 1$, contradicting the fact that $q! ee in NN$. $smash$

  Hence $ee$ is #ponder("analysis.irrational-number")[irrational].
]

Recall the definitions of @def-algebraic-number[Algebraic Numbers] and @def-transcendental-number[Transcendental Numbers].

#example[
  1. Every rational number is #ponder("number-theory.algebraic-number")[algebraic], since if $x = (p)/(q) in QQ$, then $q x - p = 0$.

  2. $sqrt(2)$ is #ponder("number-theory.algebraic-number")[algebraic], since it satisfies $x^2 - 2 = 0$.
] <ex-algebraic-examples>


#theorem[Liouville number is transcendental][
  The number $L = sum_(n=1)^oo (1)/(10^(n!))$ is #ponder("number-theory.transcendental-number")[transcendental].
] <thm-liouville-transcendental>

#proof[
  We will need two facts about polynomials:

  *Fact A.* For any polynomial $p$, there exists some $K$ such that $abs(p(x) - p(y)) <= k abs(x - y), forall 0 <= x, y <= 1.$

  Indeed, suppose $p(x) = a_d x^d + a_(d-1)x^(d-1) + ... + a_1x + a_0$. Then
  $
    p(x) - (y) & = a_d (x^d - y^d) + a_(d-1)(x^(d-1) - y^(d-1)) + ... + a_1(x - y) \
               & = (x-y)[a_d (x^(d-1) + x^(d-2)y +...+y^(d-1)) + ... + a_1]. \
  $
  So
  $
    abs(p(x)-p(y)) <= abs(x-y)underbracket([d abs(a_d) + (d-1) abs(a_(d-1)) + ... + abs(a_1)], K).
  $

  *Fact B.* A non-zero polynomial of degree $d$ has at most $d$ real roots.

  #lecture-separator(lecture: 21, date: "2025-11-27")


  Write $L_n = sum_(k-1)^n (1)/(10^k!)$, so that $L = lim_(n -> oo) L_n$.

  Suppose that there is a polynomial $p$ of which $p(L) = 0$. Note  $0 < L < 1$.

  Then by Fact A, there exists some $K$ such that
  $
    p(x) - p(y) <= K abs(x - y) quad forall 0 <= x, y <= 1.
  $
  Note
  $
    abs(L-L_n) = sum_(k=n+1)^oo (1)/(10^(k!)) <= 2 dot (1)/(10^((n+1)!)).
  $
  Suppose $p$ has degree $d$, _i.e._
  $
    p(x) = a_d x^d + a_(d-1)x^(d-1) + ... + a_1 x + a_0
  $
  with $a_i in ZZ, a_d != 0$.

  Notice that $L_n = (s)/(10^(n!))$ for some $s in NN$. So
  $
    p(L_n) = (t)/(10^(d n!)) quad "for some" t in ZZ.
  $
  By Fact B, $p(L_n) = 0$ for at most $d$ values of $n$. So for sufficiently large $n$, we have $p(L_n) != 0$. Hence
  $
    abs(p(L_n)-p(L)) = abs(p(L_n)) >= (1)/(10^(d n!)).
  $
  Therefore,
  $
    (1)/(10^(d n!)) <= abs(p(L_n)-p(L)) <= K abs(L_n - L) <= 2 K (1)/(10^((n+1)!)).
  $
  This is a contradiction for sufficiently large $n$, since $(n+1)!$ grows faster than $d n!$. $smash$
]

#remark[
  1. Such $L$ are called *#ponder("number-theory.liouville-number")[Liouville numbers]*.

  2. This proof does not show that $ee$ is #ponder("number-theory.transcendental-number")[transcendental], but nonetheless it is known that $ee$ is #ponder("number-theory.transcendental-number")[transcendental].

  3. The same proof shows that any #ponder("analysis.real-numbers")[real number] $x$ that satisfies

    $
      forall n in NN, exists p/q in QQ: 0 < abs(x - (p)/(q)) < (1)/(q^(n))
    $

    is #ponder("number-theory.transcendental-number")[transcendental].

    In loose terms, if $x$ has a very good rational approximation, then it is #ponder("number-theory.transcendental-number")[transcendental].
]

== Brief Introduction to Complex Numbers

Some polynomials have no real roots, _e.g._ $x^2 + 1 = 0$. We will define $x$, a complex number, satisfying this equation.

The *complex numbers* $CC$ consists of $RR^2$ together with operations $+$ and $times$ defined by
$
      (a, b) + (c, d) & = (a + c, b + d), \
  (a, b) times (c, d) & = (a c - b d, a d + b c).
$

We can view $RR$ as contained in $CC$ ny identifying $a in RR$ with $(a, 0) in CC$.

Note that $(a, 0) + (b, 0) = (a + b, 0)$ and similarly $(a, 0)times (b, 0) = (a b, 0)$.
We define $i = (0, 1) in CC$. Then
$i^2 = (0, 1) times (0, 1) = (-1, 0)$, so $i^2 + 1 = 0$.

Note that $z in CC$ is of the form $a + ii b$ with $a, b in RR$.

Indeed, $(a, b) = a (1, 0) + b(0, 1) = a + b ii$.

#remark[

  1. $CC$ obeys all the usual rules of arithmetic. In particualr, if $0 != z in CC$, then there exists some $w in CC$ such that $z w = 1$.

    Indeed, ,given $z = a + ii b$, note that
    $
      (a + ii b) (a - ii b) = a^2 + b^2.
    $
    So
    $
      (a + ii b)^(-1) = (a - ii b)/(a^2 + b^2).
    $

  2. Every non-constant polynomial (allowing complex coefficients) has a complex root. This is known as the #ponder("algebra.fundamental-theorem-of-algebra")[Fundamental Theorem of Algebra].
]
