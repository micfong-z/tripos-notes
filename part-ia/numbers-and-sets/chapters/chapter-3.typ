#import "../prelude.typ": *

= How to Count

== Construction of $NN$

We shall construct $NN$ from a #ponder("set-theory.set")[set] of axioms.

The natural number $NN$ is a #ponder("set-theory.set")[set] containing a special element $1$, together with a #ponder("set-theory.function")[map], called the successor function:
$ S:NN->NN $
which #ponder("set-theory.function")[maps] $n$ to its successor #fade[[intuitively, this is the "$+1$" operation.]], such that it satisfies the following axioms.

#axiom("Peano axioms")[
  1. $forall n in NN, S(n) != 1$ #fade[[$1$ is not the successor of anything.]]

  2. $forall m, n in NN$, $S(m)=S(n)=>m=n$.

  3. Let $A$ be a #ponder("set-theory.subset")[subset] of $NN$ such that

    - $1 in A$, and
    - $n in A => S(n) in A$,
    then $A = NN$.
] <peano-axioms>

Note that @peano-axioms (3) is the axiom of induction. We can now write $2 = S(1)$, $3 = S(2)$ _etc._ Also, we can define addition recursively by

- $n + 1 = S(n)$
- $n + S(m) = S(n+m)$

Similarly for multiplication, we can define it by

- $n times 1 = n$
- $n times S(m) = n times m + n$

We can show by induction that these satisfy the usual rules of arithmetic, that

- $+$ and $times$ are #ponder("algebra.commutativity-associativity-distributivity")[commutative] and #ponder("algebra.commutativity-associativity-distributivity")[associative]
- $times$ is #ponder("algebra.commutativity-associativity-distributivity")[distributive] over $+$

#example[
  $
    1 + 2 & = 1 + S(1) \
          & = S(1+1) \
          & = S(S(1)) \
          & = S(1) + 1 \
          & = 2 + 1. \
  $
]

#example[
  To #ponder("set-theory.proof")[prove] that $n + m = m + n$, we will need to do the followings:

  - induct on $m$
  - base case is $m = 1$

  _i.e._ $n + 1 = 1 + n$
  - #ponder("set-theory.proof")[prove] this by inclusion on $n$
]

#lecture-separator(lecture: 7, date: "2025-10-23")

== Induction and Ordering

We can also define an ordering: $m < n$ if $m + k = n$ for some $k in NN$. We may check by induction that the usual rules hold, _i.e._ #ponder("set-theory.reflexivity-symmetry-transitivity")[transitivity] holds.

A key feature of $<$ is that for any distinct $m, n in NN$, exactly one of $m < n$ or $n < m$ holds. This is called a total order.

#example[
  We shall show that we cannot get $1<2$ and $2<1$ at the same time. If $1 < 2$ and $2 < 1$. Then $exists k, l in NN$ such that $1 = 2 + k$ and $2 = 1 + l$. By #ponder("algebra.commutativity-associativity-distributivity")[associativity] we have
  $ 1 = 2 + k = 1 + l + k $
  Hence $1 = S(l + k)$. By @peano-axioms (1), this is a contradiction. $smash$
]

The fact that we have ordering means that we can write down two types of induction.

1. The *weak principle of induction* (WPI), which is just @peano-axioms (3):

  If $P(1)$ holds, and $forall n in NN, P(n)=>P(n+1)$, then $P(n)$ holds $forall n in NN$.

2. The *strong principle of induction* (SPI) is based on the ordering above:

  If we are given that

  1. $P(1)$ holds,
  2. $forall n in NN$, $P(1) and P(2) and ... and P(n) => P(n+1)$,

  then $P(n)$ holds $forall n in NN$.

  #remark[
    We need ordering since we are effectively saying that to #ponder("set-theory.proof")[prove] $P(n+1)$, we need $P(k)$ for all $k < n+1$.
  ]

#proposition[
  $"SPI" <=> "WPI"$.
] <prop-spi-wpi>

#proof[
  Let us first show that SPI implies WPI. We are given the assumptions:

  1. *SPI.* If $P(1)$ holds, and  $forall n in NN$, $P(1) and P(2) and ... and P(n) => P(n+1)$, then $P(n)$ holds $forall n in NN$.
  2. *WPI's assumption.* $P(1)$ holds, and $forall n in NN, P(n)=>P(n+1)$.

  We can use (2) to show that $P(1)$ holds. Then using (2) again, we can show that $P(1) and P(2)$ holds. Continuing this way, we can show that $P(1) and P(2) and ... and P(n)$ holds for all $n in NN$. Hence by (1), $P(n)$ holds for all $n in NN$, and WPI holds.

  Conversely, to see that WPI implies SPI, we define a new predicate $Q(n)$ as "$P(k)$ holds for all $k < n$". Then we can use WPI to show that $Q(n)$ holds for all $n in NN$, which implies that $P(n)$ holds for all $n in NN$.
]

The above ordering of $NN$ satisfies a special property called the *#ponder("set-theory.well-ordering-principle")[well-ordering principle]* (WOP).

#axiom("Well-ordering principle")[
  Any non-empty #ponder("set-theory.subset")[subset] of $NN$ has a least element.

  _i.e._ if $P(n)$ holds for $n in A subset NN$ with $A != emptyset$, then there exists a least element $m in A$ such that $P(m)$ holds.
] <well-ordering-principle>

#theorem[
  $"SPI" => "WOP"$.
] <thm-spi-wop>

#proof[
  Assume that $P(n)$ holds for $n in A subset NN$ with $A != emptyset$. Suppose, for contradiction, that there is no least $n in NN$ such that $P(n)$ holds. Consider $Q(n) = not P(n)$.

  Certainly $P(1)$ is false, because otherwise $1$ will be our minimal element. Then $Q(1)$ holds.

  Now, given $n in NN$, suppose $Q(k)$ is true for all $k < n$. Then $P(k)$ must be false for all $k < n$, and so $P(n)$ must also be false (otherwise $n$ will be our minimal element). Hence $Q(n)$ holds.

  Hence by SPI, $Q(n)$ holds for all $n in NN$, and $P(n)$ is false for all $n in NN$, contradicting our assumption that there exists some $n$ such that $P(n)$ holds. $smash$
]

#remark[
  $"WOP" arrow.double.not "SPI"$, and it fails for certain ordinals. However, in any proof using SPI, one can in fact use WOP.
]

#example[
  Consider the following theorem.

  _Any natural number $n > 1$ can be written as a product of primes._

  #proof[
    Let $C = {n in NN: n > 1 and "n cannot be written as a product of primes"}$.

    We assume $C != emptyset$ and derive a contradiction. By #ponder("set-theory.well-ordering-principle")[WOP], $C$ has a least element $m$. Since $m$ is not prime, we can write $m = a times b$ for some $a, b in NN$ with $1 < a, b < m$. By minimality of $m$, both $a$ and $b$ can be written as a product of primes. Hence $m$ can also be written as a product of primes, which is a contradiction. $smash$
  ]
]

== #ponder("set-theory.finite-set")[Finite] Sets

Recall a #ponder("set-theory.set")[set] $A$ has *#ponder("set-theory.cardinality")[size]* $n$ if we can write $A = {a_1, a_2, ..., a_n}$ with the elements $a_i$ distinct. We write $abs(A) = n$ or $hash A = n$.

Let us recall the definition of #ponder("set-theory.finite-set")[finite] sets in @def-finite-infinite-set. We say $A$ is #ponder("set-theory.finite-set")[finite] if $exists n in ZZ_(>=0)$ such that $abs(A)=n$, and $A$ is #ponder("set-theory.finite-set")[infinite] otherwise.

#proposition[
  A #ponder("set-theory.set")[set] of #ponder("set-theory.cardinality")[size] $n$ has exactly $2^n$ #ponder("set-theory.subset")[subsets].
] <prop-power-set-size>

#proof[
  We shall #ponder("set-theory.proof")[prove] by induction on $n$.

  *Base case.* This is true for $n=0$ since the #ponder("set-theory.empty-set")[empty set] has exactly one #ponder("set-theory.subset")[subset], itself.

  *Inductive step.* Suppose the result holds for some $n in NN$. Let $A$ be a #ponder("set-theory.set")[set] of #ponder("set-theory.cardinality")[size] $n+1$. Pick some element $a in A$, and let $B = A \\ {a}$. Then $B$ has #ponder("set-theory.cardinality")[size] $n$, and by the inductive hypothesis, $B$ has exactly $2^n$ #ponder("set-theory.subset")[subsets].

  Now, to form the #ponder("set-theory.subset")[subsets] of $A$, we can take each #ponder("set-theory.subset")[subset] of $B$ and either include or exclude $a$. This gives us exactly two choices for each #ponder("set-theory.subset")[subset] of $B$, leading to a total of $2 times 2^n = 2^(n+1)$ #ponder("set-theory.subset")[subsets] of $A$.

  Hence, by induction, the result holds for all $n in NN$.
]

So this proposition says that if $abs(A) = n$, then $abs(cal(P)(A)) = 2^n$.

=== #ponder("combinatorics.binomial-coefficient")[Binomial Coefficients]

#definition("Binomial coefficient")[
  Given $n in NN_0$, and $0<= k <= n$, we can write $binom(n, k)$ for the number of #ponder("set-theory.subset")[subsets] of an $n$-element #ponder("set-theory.set")[set] that are of #ponder("set-theory.cardinality")[size] $k$.

  $binom(n, k)$ is called a *#ponder("combinatorics.binomial-coefficient")[binomial coefficient]*.
] <def-binomial-coefficient>

In other words,
$ binom(n, k) = abs({S subset.eq{1, 2, ..., n}: abs(S) = k }). $


Note that, by definition, $binom(n, 0) = 1, binom(n, n) = 1, binom(n, 1) = n$ for $n > 0$. Also,

$ binom(n, 0) + binom(n, 1) + binom(n, 2) + ... + binom(n, n) = 2^n $

since this counts all #ponder("set-theory.subset")[subsets] of an $n$-element #ponder("set-theory.set")[set].

Also we have $binom(n, k) = binom(n, n-k)$ forall $n in ZZ_(>=0), 0 <= k <= n$. This is because specifying which $k$ elements to pick is equivalent to specifying which $n-k$ elements to leave out.

Moreover, $ binom(n, k) = binom(n - 1, k - 1) + binom(n - 1, k) quad forall n in ZZ^+, 1 <= k <= n-1. $

#example[
  Consider
  $ binom(8, 3) = binom(7, 2) + binom(7, 3). $

  Suppose that you are in a group of 8 people. To form a commitee of 3 people, either you are in the commitee, in which case you need to choose 2 more people from the remaining 7, or you are not in the commitee, in which case you need to choose all 3 people from the remaining 7.
]

#lecture-separator(lecture: 8, date: "2025-10-25")

This leads to Pascal's triangle:

$
  &   &   &   &   &    & 1 &    &   &   &   &   & \
  &   &   &   &   & 1  &   & 1  &   &   &   &   & \
  &   &   &   & 1 &    & 2 &    & 1 &   &   &   & \
  &   &   & 1 &   & 3  &   & 3  &   & 1 &   &   & \
  &   & 1 &   & 4 &    & 6 &    & 4 &   & 1 &   & \
  & 1 &   & 5 &   & 10 &   & 10 &   & 5 &   & 1 & \
$

where each row starts and ends with a 1, and the remaining entries are the sum of the 2 terms immediately above.

#proposition[
  $
    binom(n, k) = n!/(k!(n-k)!).
  $
] <prop-binomial-formula>

#proof[
  Given a #ponder("set-theory.set")[set] of #ponder("set-theory.cardinality")[size] $n$, there are $n(n-1)dots.c(n-k+1)$ to pick $k$ elements, in order, one by one. But each #ponder("set-theory.subset")[subset] of #ponder("set-theory.cardinality")[size] $k$ is picked in  $k!$ ways in this method.

  Hence, the number of subsets of size $k$ in ${1, 2, ..., n}$ is
  $ binom(n, k) = (n(n-1)dots.c(n-k+1))/k! = n!/(k!(n-k)!). $
]

Note that the formula tells us, for example, that

$
  binom(n, 2) & = (n(n-1))/(2) ~ (n^2)/(2) \
  binom(n, 3) & = (n(n-1)(n-2))/(6) ~ (n^3)/(6) \
$
for large $n$.

#theorem("Binomial theorem")[
  For all $a, b in RR$ and $n in NN$, we have
  $
    (a+b)^n = binom(n, 0) a^n + binom(n, 1) a^(n-1)b + binom(n, 2) a^(n-2) b^2 + ... + binom(n, n-1) a b^(n-1) + binom(n, n) b^n.
  $
] <thm-binomial-theorem>

#proof[
  When we expand $(a+b)^n = (a+b)(a+b) dots.c(a+b)$, we obtain terms of the form $a^(n-k)b^k$ where $0<=k<=n$, and the number of terms of the form $a^(n-k) b^k$ in the expansion is $binom(n, k)$, since we must specify $k$ brackets from which to pick $b$.

  Hence
  $ (a+b)^n = sum_(k=0)^n binom(n, k) a^(n-k) b^k. $
]

#example[
  $
    (1+x)^n = 1 + n x + (n(n-1))/(2) x^2 + binom(n, 3) x^3 + ... + binom(n, n-1) x^(n-1) + x^n.
  $
  Thus, for a small $x$, a good approximation to $(1+x)^n$ is $1+n x$. #fade[[This is called the first-order approximation.]]
]

=== #ponder("combinatorics.inclusion-exclusion-principle")[Inclusion-Exclusion Principle]

What can we say about the relationship between #ponder("set-theory.cardinality")[sizes] of #ponder("set-theory.set-operations")[union] and #ponder("set-theory.set-operations")[intersection] of #ponder("set-theory.finite-set")[finite] #ponder("set-theory.set")[sets]?

#example[
  One should have seen the following formulae before:

  $
            abs(A union B) & = &   & abs(A) + abs(B) - abs(A inter B), \
    abs(A union B union C) & = &   & abs(A) + abs(B) + abs(C) \
                           &   & - & abs(A inter B) - abs(B inter C) - abs(C inter A) \
                           &   & + & abs(A inter B inter C). \
  $

  #align(center)[
    #dynamic-svg("/part-ia/numbers-and-sets/media/d2e1.svg", width: 28em)
  ]
]

#theorem("Inclusion-Exclusion Principle")[
  Let $S_1, S_2, ..., S_n$ be #ponder("set-theory.finite-set")[finite] #ponder("set-theory.set")[sets]. Then
  $
    abs(S_1 union S_2 union ... union S_n) & = sum_(
                                             i=1
                                             )^n abs(S_i) \
                                           & - sum_(
                                             1 <= i < j <= n
                                             ) abs(S_i inter S_j) \
                                           & + sum_(
                                             1 <= i < j < k <= n
                                             ) abs(S_i inter S_j inter S_k) \
                                           & dots.v \
                                           & + (-1)^(n+1) abs(S_1 inter S_2 inter ... inter S_n). \
  $
  Equivalently,
  $
    abs(union.big_(i=1)^n S_i) = sum_(r=1)^n (-1)^(r+1) sum_(A subset.eq{1, 2, ..., n}\ abs(A) = r) abs(inter.big_(i in A) S_i).
  $
] <thm-inclusion-exclusion>

#remark[
  This can be #ponder("set-theory.proof")[proven] using #ponder("set-theory.indicator-function")[indicator functions], using that if $A subset.eq X$ then
  $
    abs(A) = sum_(x in X) 1_A(x).
  $
]

#proof[
  Let $x in S_1 union S_2 union ... union S_n$, say $x in S_i$ for $k$ of the #ponder("set-theory.set")[sets] $S_i$. We want $x$ to be counted exactly once in the RHS.

  Indeed, if $A subset.eq {1, 2, 3, ..., n}$,

  $
    hash {A: abs(A) = 1 and x in inter.big_(i in A) S_i} & = binom(k, 1) \
    hash {A: abs(A) = 2 and x in inter.big_(i in A) S_i} & = binom(k, 2) \
    hash {A: abs(A) = 3 and x in inter.big_(i in A) S_i} & = binom(k, 3) \
                                                         & dots.v \
    hash {A: abs(A) = r and x in inter.big_(i in A) S_i} & = cases(binom(k, r) quad &"for" r <= k, 0 quad &"for" r > k). \
  $
  Thus the number fo times $x$ is counted on the RHS is

  $
      & k - binom(k, 2) + binom(k, 3) - binom(k, 4) + ... + (-1)^(k+1) binom(k, k) \
    = & 1-(1-k+(binom(k, 2)-binom(k, 3)+...+(-1)^k binom(k, k)) \
    = & 1-(1-1)^k \
    = & 1 quad "for" k >= 1. \
  $
]
