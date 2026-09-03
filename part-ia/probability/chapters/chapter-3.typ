#import "../prelude.typ": *

= #ponder("probability.discrete-random-variable")[Discrete Random Variables]

#definition[Random Variable][
  Consider a #ponder("probability.probability-space")[probability space] $(Omega, cal(F), PP)$. A #ponder("probability.random-variable")[*random variable*] is a function $X: Omega -> RR$, satisfying that $forall x in RR$,
  $
    {omega in Omega: X(omega) <= x} in cal(F).
  $

  We write ${X <= x} = {omega in Omega: X(omega) <= x}$ and $forall A subset.eq RR$, ${X in A} = {omega in Omega: X(omega) in A}$.
] <def-random-variable>

#definition[Indicator][
  Let $A in cal(F)$. The #ponder("set-theory.indicator-function")[*indicator*] of $A$ is a #ponder("probability.random-variable")[random variable] $bb(1)_A: Omega -> [0, 1]$ defined by
  $
    bb(1)_A (omega) = bb(1)(omega in A) = cases(
      1 quad & "if" omega in A,
      0 quad & "if" omega in A^cp,
    )
  $
]

#definition[Probability Distribution Function][
  Suppose $X$ is a #ponder("probability.random-variable")[random variable]. Define the #ponder("probability.distribution-function")[*probability distribution function*] of $X$ to be
  $
    F_X (x) = PP(X <= x)
  $
  where $F_X: RR -> [0, 1]$.
] <def-probability-distribution-function>

#definition[Multidimensional Random Variable][
  $X = (X_1, ..., X_n)$ is called a #ponder("probability.random-variable")[random variable] in $RR^n$ if
  $
    (X_1, ..., X_n): Omega -> RR^n
  $
  is a function such that $forall x_1, x_2, ..., x_n in RR$,
  $
    {X_1 <= x_1, ..., X_n <= x_n} = {omega in Omega: X_1 (omega) <= x_1, X_2 (omega) <= x_2, ..., X_n (omega) <= x_n} in cal(F).
  $
  Equivalently, all $X_i$ are real #ponder("probability.random-variable")[random variables].
] <def-multidimensional-random-variable>

#definition[Discrete Random Variable][
  A #ponder("probability.random-variable")[random variable] $X$ is called #ponder("probability.discrete-random-variable")[*discrete*] if its range is #ponder("set-theory.countable-set")[countable].

  Suppose it takes values in a #ponder("set-theory.countable-set")[countable] set $S$, then for every $x in S$ we write
  $
    p_x = PP(X=x) = PP({omega: X(omega) = x}).
  $
  We call $(p_x)_(x in S)$ the #ponder("probability.probability-mass-function")[*probability mass function*] of $X$, or the *distribution* of $X$. Note that $forall A subset.eq S$,
  $
    PP(X in A) = sum_(x in A) p_x.
  $
] <def-discrete-random-variable>

Recall that two #ponder("probability.outcomes-and-events")[events] $A$ and $B$ are #ponder("probability.independence-of-events")[independent] if $PP(A inter B) = PP(A) PP(B)$.

#definition[Independence][
  Let $X_1, X_2, ..., X_n$ be #ponder("probability.discrete-random-variable")[discrete random variables] with values in $S_1, ..., S_n$. They are #ponder("probability.independence-of-random-variables")[*independent*] if for any $x_1 in S_1, ..., x_n in S_n$,
  $
    PP(X_1 = x_1, ..., X_n = x_n) = PP(X_1 = x_1) dot ... dot PP(X_n = x_n).
  $
] <def-independence-of-random-variables>

#example[
  Consider tossing a $p$-coin $N$ times #ponder("probability.independence-of-events")[independently]. let $Omega = {0, 1}$ with $omega in Omega$, where
  $
    omega = (omega_1, omega_2, ..., omega_N)
  $
  and $omega_i$ is the result of the $i$-th toss. Then
  $
    p_omega = PP({omega}) = product_(k=1)^N p^(omega_k) (1 - p)^(1 - omega_k).
  $
  For all $k = 1, ..., N$ define #ponder("probability.random-variable")[random variables] $X_k: Omega -> {0, 1}$ with $X_k (omega) = omega_k$. Then
  $
      PP(X_k=1) & =p \
    PP(X_k = 0) & =1-p. \
  $
  Note that $X$ is a #ponder("probability.bernoulli-distribution")[Bernoulli] #ponder("probability.random-variable")[random variable] with parameter $p$.

  #claim[
    $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables].
  ]

  #proof[
    $
      PP(X_1 = x_1, ..., X_n = x_n) & = product_(k=1)^N p^(x_k) (1 - p)^(1 - x_k) \
                                    & = product_(k=1)^N PP(X_k = x_k). \
    $

  ]
]

#lecture-separator(lecture: 7, date: "2026-02-06")

== #ponder("probability.expectation")[Expectation]

#definition[Expectation for non-negative discrete random variables][
  Let $Omega$ be a #ponder("set-theory.countable-set")[countable] set and $X: Omega->RR$ be a #ponder("probability.discrete-random-variable")[discrete random variable].

  For $X>=0$, the #ponder("probability.expectation")[*expectation*] of $X$ is defined by
  $
    EE[X] = sum_(omega in Omega) PP({omega}) X(omega) .
  $
  Alternatively, consider
  $
    Omega_X & = {X(omega):omega in Omega} \
      Omega & = union.big_(x in Omega_X) {omega: X(omega) = x} \
  $
  Then
  $
    EE[X] & = sum_(omega in Omega) X(omega) dot PP({omega}) \
          & = sum_(x in Omega_X) sum_(omega in {X = x}) X(omega) dot PP({omega}) \
          & = sum_(x in Omega_X) sum_(omega in {X = x}) x dot PP({omega}) \
          & = sum_(x in Omega_X) x sum_(omega in {X = x}) PP({omega}) \
          & = sum_(x in Omega_X) x PP(X = x).
  $

  So the #ponder("probability.expectation")[expectation] of $X$ is the weighted average of the values taken by $X$, with weights given by the probabilities of $X$ taking those values.
] <def-expectation-non-negative>

#example[
  Consder $X ~ "Bin"(N, p)$. Then $forall k in {0, ..., N}$,
  $
    PP(X=k) = binom(N, k) p^k (1-p)^(N-k).
  $
  Then, for the #ponder("probability.expectation")[expectation],
  $
    EE[X] & = sum_(k=0)^N k dot PP(X=k) \
          & = sum_(k=0)^N k dot binom(N, k) p^k (1-p)^(N-k) \
          & = sum_(k=0)^N k dot (N!)/(k! (N-k)!) p^k (1-p)^(N-k) \
          & = sum_(k=0)^(N-1) N binom(N-1, k) p^(k) (1-p)^(N-1-k) p \
          & = N p (p + 1 - p)^(N-1) \
          & = N p.
  $
]

#example[
  Consider $X ~ "Poi"(lambda)$ with $lambda > 0$. Then for all $k in ZZ_(>=0)$,
  $
    PP(X = k) = ee^(-lambda) lambda^k / k!
  $
  Hence
  $
    EE[X] & = sum_(k=0)^(oo) k dot PP(X=k) \
          & = sum_(k=0)^(oo) k dot ee^(-lambda) lambda^k / k! \
          & = ee^(-lambda) lambda sum_(k=1)^oo lambda^(k-1) / (k-1)! \
          & = lambda ee^(-lambda) ee^(lambda) \
          & = lambda.
  $


]

#notation[
  Let $X$ be a random variable. Define
  $
    X^+ = max(X, 0) quad "and" quad X^- = max(-X, 0).
  $
  Then
  $
    X = X^+ - X^- quad "and" quad |X| = X^+ + X^-.
  $
]

#definition[Expectation for general discrete random variables][
  Suppose $X$ is discrete. We can define $EE[X^+]$ and $EE[X^-]$ as in @def-expectation-non-negative.

  If at least one of $EE[X^+]$ and $EE[X^-]$ is finite, then we can define the #ponder("probability.expectation")[*expectation*] of $X$ by
  $
    EE[X] = EE[X^+] - EE[X^-].
  $
  Otherwise, $EE[X]$ is not defined.
] <def-expectation-general>

#definition[Integrable Random Variable][
  A #ponder("probability.random-variable")[random variable] $X$ is #ponder("probability.integrable-random-variable")[*integrable*] if $EE[abs(X) ] < oo$.
] <def-integrable-random-variable>

#proposition[
  If $EE[X]$ is well-defined, then we have
  $
    EE[X] = sum_(x in Omega_X) x PP(X = x).
  $
]

#remark[
  We shall assume that whenever we write $EE[X]$, it is well-defined.
]

#proposition[Properties of Expectation][
  1. If $X >= 0$, then $EE[X] >= 0$.

  2. If $X >= 0$ and $EE[X] = 0$, then $PP(X = 0) = 1$.

  3. If $c in RR$, then $EE[c X] = c EE[X]$ and $EE[c+X] = c + EE[X]$.

  4. If $X$ and $Y$ are random variables, then $EE[X+Y] = EE[X] + EE[Y]$.

  5. Let $c_1, ..., c_n in RR$ and $X_1, ..., X_n$ be #ponder("probability.integrable-random-variable")[integrable random variables]. Then
    $
      EE[sum_(k=1)^n c_k X_k] = sum_(k=1)^n c_k EE[X_k].
    $

  6. Suppose that $X_1, X_2, ...$ are non-negative #ponder("probability.random-variable")[random variables]. Then
    $
      EE[sum_(k=1)^(oo) X_k] = sum_(k=1)^(oo) EE[X_k].
    $
] <prop-expectation-properties>

#proof[
  Suppose that $Omega$ is #ponder("set-theory.countable-set")[countable].

  For (6), we have
  $
    EE[sum_n X_n] & = sum_(omega in Omega) (sum_n X_n (omega)) dot PP({omega}) \
                  & = sum_n sum_(omega in Omega) X_n (omega) PP({omega}) quad "since all terms are non-negative" \
                  & = sum_n EE[X_n].
  $
]

#example[
  Let $A in cal(F), X= bb(1)(A), X(omega) = bb(1)(omega in A)$. Then
  $
    EE[X] & = sum_(omega in Omega) bb(1)(omega in A) dot PP({omega}) \
          & = sum_(omega in A) PP({omega}) \
          & = PP(A).
  $
]

#proposition[
  Let $g: RR->RR, X:Omega->RR$ and consider $g(X)$ defined by $g(X)(omega) = g(X(omega))$. Then $g(X)$ is a #ponder("probability.random-variable")[random variable], with
  $
    EE[g(X)] = sum_(x in Omega_X) g(x) PP(X = x).
  $
] <prop-expectation-function>
#proof[
  Let $Y = g(X)$. Then we have
  $
    {Y=y} & = {omega: g(X(omega)) = y} = {omega: X(omega) in g^(-1)({y})} ={X in g^(-1)({y})} \
  $
  Hence,
  $
    EE[Y] & = sum_(y in Omega_y) y PP(Y = y) \
          & = sum_(y in Omega_y) y PP(X in g^(-1)({y})) \
          & = sum_(y in Omega_y) y sum_(x in g^(-1)({y})) PP(X = x) \
          & = sum_(y in Omega_Y) sum_(x in g^(-1)({y})) g(x) PP(X = x) \
          & = sum_(x in Omega_X) g(x) PP(X = x).
  $
]

#proposition[
  Suppose $X>=0$ and takes integer values. Then
  $
    EE[X] = sum_(k=1)^(oo) PP(X >= k) = sum_(k=0)^(oo) PP(X > k).
  $
] <prop-tail-sum>

#proof[
  Note that for any $x in NN$,
  $
    x & = sum_(k=1)^(oo) bb(1)(x >= k) & = sum_(k=0)^(oo) bb(1)(x > k). \
  $
  Since $X >= 0$ and $X in ZZ_(>=0)$, we have
  $
    X(omega) & = sum_(k=1)^(oo) bb(1)(X(omega) >= k) & = sum_(k=0)^(oo) bb(1)(X(omega) > k). \
  $
  Taking #ponder("probability.expectation")[expectation] on both sides, we get
  $
    EE[X] & = EE[sum_(k=1)^(oo) bb(1)(X >= k)] = EE[sum_(k=0)^(oo) bb(1)(X > k)] \
    EE[X] & = sum_(k=1)^(oo) EE[bb(1)(X >= k)] = sum_(k=0)^(oo) EE[bb(1)(X > k)] \
    EE[X] & = sum_(k=1)^(oo) PP(X >= k) = sum_(k=0)^(oo) PP(X > k). \
  $
]

#lecture-separator(lecture: 8, date: "2026-02-09")

With #ponder("probability.expectation")[expectation], we can form another proof of the #ponder("probability.inclusion-exclusion-formula")[inclusion-exclusion formula].

#proof[ #fade[[of @prop-inclusion-exclusion-formula[Inclusion-Exclusion Formula]]]
  Let $A, B in cal(F)$. Then
  $
         bb(1)(A^cp) & = 1-1(A) \
    bb(1)(A inter B) & = bb(1)(A) dot bb(1)(B) \
    bb(1)(A union B) & = 1 - bb(1)(A^cp inter B^cp) = 1 - (1 - bb(1)(A)) dot (1 - bb(1)(B)).
  $


  More generally, if we have $A_1, ..., A_n in cal(F)$, then
  $
    bb(1)(A_1 union ... union A_n) & = 1 - bb(1)(A_1^cp inter ... inter A_n^cp) \
    & = 1 - product_(i=1)^n (1 - bb(1)(A_i))\
    &= sum_(i-1)^n bb(1)(A_i) - sum_(1 <= i < j <= n) bb(1)(A_i) dot bb(1)(A_j) + ... + (-1)^(n-1) bb(1)(A_1) dot ... dot bb(1)(A_n).
  $
  Taking #ponder("probability.expectation")[expectation] on both sides, since $EE[bb(1)(A)]=PP(A)$, we get
  $
    PP(A_1 union ... union A_n) & = sum_(i-1)^n PP(A_i) - sum_(1 <= i < j <= n) PP(A_i inter A_j) + ... + (-1)^(n-1) PP(A_1 inter ... inter A_n). \
  $
]

== #ponder("probability.variance")[Variance] and #ponder("probability.covariance")[Covariance]

#definition[Moment][
  Let $X$ be a #ponder("probability.random-variable")[random variable] and $r in NN$. We call $EE[X^r]$ the #ponder("probability.moment")[*$r$-th moment*] of $X$, as long as it is well-defined.
] <def-moment>

#definition[Variance][
  The #ponder("probability.variance")[*variance*] of $X$ is defined by
  $
    "Var"(X) = EE[(X - EE[X])^2].
  $
] <def-variance>

The #ponder("probability.variance")[variance] is a measure of concentration of the distribution of $X$ around its #ponder("probability.expectation")[expectation]. The smaller the #ponder("probability.variance")[variance], the more concentrated the distribution is around its #ponder("probability.expectation")[expectation].

#definition[Standard Deviation][
  The *standard deviation* of $X$ is defined by $sqrt("Var"(X))$.
] <def-standard-deviation>

#proposition[Propositions of $"Var"(X)$][
  1. $"Var"(X) >= 0$.

  2. If $"Var"(X) = 0$, then $PP(X = EE[X]) = 1$.

  3. If $c in RR$, then $"Var"(c X) = c^2 "Var"(X)$ and $"Var"(c + X) = "Var"(X)$.

  4. $"Var"(X) = EE[X^2] - (EE[X])^2$.

  5. $"Var"(X) = min_(c in RR) EE[(X - c)^2]$, with the minimum attained at $c = EE[X]$.
] <prop-variance-properties>

#proof[
  For (4), we have
  $
    "Var"(X) & = EE[X^2 - 2X EE[X] + (EE[X])^2] \
             & = EE[X^2] - 2 EE[X] EE[X] + (EE[X])^2 \
             & = EE[X^2] - (EE[X])^2.
  $

  #separator

  For (5), define $f(c) = EE[(X-c)^2]$. Then
  $
    f(c) & = EE[X^2]-2c EE[X] + c^2.
  $
  Hence, taking derivative with respect to $c$, we get
  $
    f'(c) = -2EE[X] + 2c.
  $
  Therefore, $f'(c) = 0$ if and only if $c = EE[X]$. Moreover, $f''(c) = 2 > 0$, so $f$ is #ponder("analysis.convex-function")[convex] and the minimum is attained at $c = EE[X]$. Hence
  $
    "Var"(X) = f(EE[X]) = EE[(X - EE[X])^2] = min_(c in RR) EE[(X - c)^2].
  $
]

#example[
  1. Consider $X ~ "Bin"(n, p)$. Then $EE[X] = n p$ and
    $
      "Var"(X) = EE[X(X-1)] + EE[X] - (EE[X])^(2).
    $
    Note that
    $
      EE[X(X-1)] & = sum_(k=2)^n k(k-1) (n!)/(k! (n-k)!) p^k (1-p)^(n-k) \
                 & = n(n-1) p^2 underbracket(sum_(k=0)^(n-2) (n-2)!/(k! (n-2-k)!) p^k (1-p)^(n-2-k), 1) \
                 & = n(n-1) p^2.
    $
    Hence,
    $
      "Var"(X) & = n(n-1) p^2 + n p - n^2 p^2 \
               & = n p (1-p).
    $

  2. Consider $X ~ "Poi"(lambda)$. Then $EE[X] = lambda$ and
    $
      EE[X(X-1)] & = sum_(k=2)^(oo) k(k-1) ee^(-lambda) lambda^k / k! \
                 & = lambda^2 underbracket(sum_(k=0)^(oo) ee^(-lambda) lambda^k / k!, 1) \
                 & = lambda^2. \
    $
    Hence,
    $
      "Var"(X) = lambda^2 + lambda - lambda^2 = lambda.
    $
]

#definition[Covariance][
  Let $X$ and $Y$ be #ponder("probability.random-variable")[random variables]. The #ponder("probability.covariance")[*covariance*] of $X$ and $Y$ is defined by
  $
    "Cov"(X, Y) = EE[(X - EE[X]) (Y - EE[Y])].
  $
] <def-covariance>

It is a measure of the dependency between $X$ and $Y$.

#proposition[Properties of #ponder("probability.covariance")[Covariance]][
  1. $"Cov"(X, Y) = "Cov"(Y, X)$.

  2. $"Cov"(X, X) = "Var"(X)$.

  3. $"Cov"(X, Y) = EE[X Y] - EE[X] EE[Y]$.

  4. Let $c in RR$. Then $"Cov"(c X, Y) = c "Cov"(X, Y)$ and $"Cov"(c + X, Y) = "Cov"(X, Y)$.

  5. $"Var"(X + Y) = "Var"(X) + "Var"(Y) + 2 "Cov"(X, Y)$.

  6. Let $c in RR$. Then $"Cov"(c, X) = 0$.

  7. Let $X, Y, Z$ be #ponder("probability.random-variable")[random variables]. Then $"Cov"(X+Y, Z) = "Cov"(X, Z) + "Cov"(Y, Z)$.

    More generally, for all $c_1, ..., c_n, d_1, ..., d_n in RR$, we have
    $
      "Cov"(sum_(i=1)^n c_k X_k, sum_(j=1)^n d_k Y_k) = sum_(i=1)^n sum_(j=1)^n c_k d_l "Cov"(X_k, Y_l).
    $

    In particular,
    $
      "Var"(sum_(i=1)^n X_i) & = "Cov"(sum_(i=1)^n X_i, sum_(j=1)^n X_j) \
                             & = sum_(i=1)^n "Var"(X_i) + sum_(i != j) "Cov"(X_i, X_j).
    $

] <prop-covariance-properties>

#proof[
  For (3), we have
  $
    "Cov"(X, Y) & = EE[(X - EE[X]) (Y - EE[Y])] \
                & = EE[X Y - X EE[Y] - Y EE[X] + EE[X] EE[Y]] \
                & = EE[X Y] - EE[X] EE[Y] - EE[Y] EE[X] + EE[X] EE[Y] \
                & = EE[X Y] - EE[X] EE[Y].
  $

  #separator

  For (5), we have
  $
    "Var"(X + Y) & = EE[((X-EE[X]) + (Y - EE[Y]))^2] \
                 & = EE[(X - EE[X])^2] + EE[(Y - EE[Y])^2] + 2 EE[(X - EE[X]) (Y - EE[Y])] \
                 & = "Var"(X) + "Var"(Y) + 2 "Cov"(X, Y).
  $
]

Recall that if $X_1, .., X_n$ are #ponder("probability.discrete-random-variable")[discrete random variables], then they are #ponder("probability.independence-of-random-variables")[independent] iff for all $x_1, ..., x_n$,
$ PP(X_1 = x_1, ..., X_n = x_n) = PP(X_1 = x_1) dot ... dot PP(X_n = x_n). $

#proposition[
  If $X_1, X_2, X_3$ are #ponder("probability.independence-of-random-variables")[independent], then $X_1$ is #ponder("probability.independence-of-random-variables")[independent] of $X_2$.
] <prop-independence-subset>

#proof[
  We need to show that
  $
    forall x_1, x_2, quad PP(X_1 = x_1, X_2 = x_2) = PP(X_1 = x_1) PP(X_2 = x_2).
  $
  We have
  $
    PP(X_1 = x_1, X_2 = x_2) & = sum_(x_3) PP(X_1 = x_1, X_2 = x_2, X_3 = x_3) \
                             & = sum_(x_3) PP(X_1 = x_1) PP(X_2 = x_2) PP(X_3 = x_3) \
                             & = PP(X_1 = x_1) PP(X_2 = x_2) underbracket(sum_(x_3) PP(X_3 = x_3), 1).
  $


]

#lemma[
  Let $X$ and $Y$ be 2 #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables], and $f, g: RR->RR_+$. Then
  $
    EE[f(X)g(Y)] = EE[f(X)] EE[g(Y)].
  $
] <lem-independent-factorisation>

#proof[
  Let $bold(Z) = (X, Y)$ and define $h(bold(Z)) = f(X) g(Y)$. Then
  $
    EE[h(bold(Z))] & = sum_(x, y) h(x, y) PP(bold(Z) = (x, y)) \
                   & = sum_(x, y) f(x) g(y) PP(X = x, Y = y) \
                   & = sum_(x, y) f(x) g(y) PP(X = x) PP(Y = y) \
                   & = (sum_x f(x) PP(X = x)) (sum_y g(y) PP(Y = y)) \
                   & = EE[f(X)] EE[g(Y)].
  $

]

#lemma[
  Let $X$ and $Y$ be 2 #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables]. Then
  $
    "Cov"(X, Y) = 0.
  $
] <lem-independent-uncorrelated>

#important[
  The converse of the above lemma is not true.
]

#example[
  Let $X_1, X_2, X_3 ~ "Ber"((1)/(2))$ be #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables]. Let

  $
    & Y_1 & = & 2X_1 - 1, quad & Y_2 & = & 2X_2 - 1 \
    & Z_1 & = & Y_1 X_3, quad  & Z_2 & = & Y_2 X_3.
  $

  Then $EE[Y_1] = EE[Y_2] = 0$. Moreover,
  $
    EE[Z_1] = EE[Y_1 X_3] = EE[Y_1] EE[X_3] = 0, quad EE[Z_2] = EE[Y_2 X_3] = EE[Y_2] EE[X_3] = 0.
  $
  So,
  $
    "Cov"(Z_1, Z_2) & = EE[Z_1 Z_2] - EE[Z_1] EE[Z_2] \
                    & = EE[Y_1 Y_2 X_3^2] - 0 \
                    & = EE[Y_1 Y_2] EE[X_3^2] \
                    & = EE[Y_1 Y_2] EE[X_3] \
                    & = 0.
  $
  However,
  $
    PP(Z_1 = 0, Z_2 = 0) & = PP(X_3 = 0) + PP(X_3 = 1, Y_1 = 0) + PP(X_3 = 1, Y_2 = 0) \
                         & = (1)/(2) + (1)/(8) + (1)/(8) \
                         & = (3)/(4) != PP(Z_1 = 0) PP(Z_2 = 0) = (1)/(4). \
  $
  Hence $Z_1$ and $Z_2$ are not #ponder("probability.independence-of-random-variables")[independent], even though $"Cov"(Z_1, Z_2) = 0$.
] <exm-uncorrelated-dependent>

#lecture-separator(lecture: 9, date: "2026-02-11")

#corollary[
  Let $X_1, X_2, ..., X_n$ be #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables]. Then
  $
    "Var"(sum_(i=1)^n X_i) = sum_(i=1)^n "Var"(X_i).
  $
] <cor-variance-sum-independent>

#example[
  Consider $n$ #ponder("probability.random-variable")[random variables] $S_n ~ "Bin"(n, p)$ . Then we have $"Var"(S_n)=n p(1-p)$ as seen before.

  We also know that $S_n = X_1 + ... + X_n$ where $(X_i)$ are #ponder("probability.independence-of-random-variables")[independent] and $X_i ~ "Ber"(p)$.

  Hence, by the above corollary, we have
  $
    "Var"(S_n) & = sum_(i=1)^n "Var"(X_i) \
               & = sum_(i=1)^n p(1-p) \
               & = n p(1-p).
  $
]

== Inequalities

#proposition[Markov's Inequality][
  Let $X$ be a non-negative #ponder("probability.random-variable")[random variable] and $a > 0$. Then
  $
    PP(X >= a) <= (EE[X]) / a.
  $
] <prop-markov-inequality>

#proof[
  Observe that
  $
    X >= a dot bb(1)(X >= a).
  $
  Taking #ponder("probability.expectation")[expectation] on both sides, we get
  $
    EE[X] >= a EE[bb(1)(X >= a)] = a PP(X >= a).
  $
]

#proposition[Chebyshev's Inequality][
  Let $X$ be a #ponder("probability.random-variable")[random variable] and $a > 0$. Then
  $
    PP(abs(X - EE[X]) >= a) <= ("Var"(X)) / (a^2).
  $
] <prop-chebyshevs-inequality>

#proof[
  Note that
  $
    PP(abs(X-EE[X]) >= a) & = PP(abs(X - EE[X])^2 >= a^2) \
                          & <= (EE[(X - EE[X])^2]) / (a^2) quad "by Markov's" \
                          & = ("Var"(X)) / (a^2).
  $
]

#proposition[Cauchy-Schwarz Inequality][
  Let $X$ and $Y$ be #ponder("probability.random-variable")[random variables]. Then
  $
    EE[abs(X Y) ] <= sqrt(EE[X^2] EE[Y^2]).
  $
]

#proof[
  Assume that $EE[X^2] < oo$ and $EE[Y^2] < oo$, otherwise there is nothing to prove. Then
  $
    abs(X Y) <= (1)/(2) (X^2 + Y^2) => EE[abs(X Y)] <= oo.
  $
  Assume that $EE[X^2] > 0$ and $EE[Y^2] > 0$, otherwise this is the trivial case. Assume WLOG that $X$ and $Y$ are non-negative.

  Let $t in RR$ and consider $(X-t Y)^2 >= 0$. Then
  $
                                            EE[(X-t Y)^2 ] & >= 0 \
    underbracket(EE[X^2] - 2t EE[X Y] + t^2 EE[Y^2], f(t)) & >= 0.
  $
  Then
  $
    f'(t) = -2 EE[X Y] + 2 t EE[Y^2].
  $
  This function is minimised at $f(t_*)$ where $t_* = (EE[X Y]) / (EE[Y^2])$. Hence, using the fact that $f(t_*) >= 0$, we get
  $
       & EE[X^2] - 2 t_* EE[X Y] + t_*^2 EE[Y^2] >= 0 \
    => & EE[X^2] - (EE[X Y])^2 / (EE[Y^2]) >= 0 \
    => & EE[abs(X Y)] <= sqrt(EE[X^2] EE[Y^2]).
  $
]

#remark[
  The equality holds when $f(t_*) = 0$, so
  $
    EE[(X - t_* Y)^2] = 0 => PP(X - t_* Y = 0) = 1 => PP(X = t_* Y) = 1.
  $
]

#definition[Convex Function][
  A function $f: RR -> RR$ is called #ponder("analysis.convex-function")[*convex*] if $forall x, y in RR$, $forall t in [0, 1]$, we have
  $
    f(t x + (1-t) y) <= t f(x) + (1-t) f(y).
  $
] <def-convex-function>

#proposition[Jensen's Inequality][
  Let $X$ be a #ponder("probability.random-variable")[random variable] and $f: RR -> RR$ be a #ponder("analysis.convex-function")[convex function]. Then
  $
    f(EE[X]) <= EE[f(X)].
  $
] <prop-jensens-inequality>

#proof[
  We first need an additional claim.

  #claim[
    Let $f :RR-> RR$ be a #ponder("analysis.convex-function")[convex function]. Then $f$ is the #ponder("analysis.least-upper-bound")[supremum] of all the lines below it, i.e. for all $m in RR$, $exists a, b in RR$ such that
    $
      f(x) & >= a x + b quad "for all" x in RR, \
      f(m) & = a m + b.
    $
  ]

  #proof[
    Let $m in RR$ and $x < m < y$. Then for some $t in (0, 1)$, we have
    $
      m = t x + (1-t) y <=> t(m-x) = (1-t)(y-m).
    $
    By the #ponder("analysis.convex-function")[convexity] of $f$, we have
    $
         & f(m) = f(t x + (1-t) y) <= t f(x) + (1-t) f(y) \
      => & t(f(m) - f(x)) <= (1-t)(f(y) - f(m)) . \
    $
    Hence, using the fact that $t(m-x) = (1-t)(y-m)$, we get
    $
      (f(m) - f(x)) / (m-x) <= (f(y) - f(m)) / (y-m).
    $

    Let $a = sup_(x < m) (f(m) - f(x)) / (m-x)$. Then $forall x < m < y$,
    $
      (f(m) - f(x))/(m-x) <= a <= (f(y) - f(m))/(y-m).
    $
    So, this gives that $forall z$,
    $
      f(z) >= a (z - m) + f(m).
    $
    Hence, we can take $b = f(m) - a m$ and get the desired result.
  ]

  Let $m = EE[X]$.  By the claim, $exists a, b in RR$ such that
  $
    f(x) & >= a x + b quad "for all" x in RR, \
    f(m) & = a m + b.
  $
  Then we have $f(X) >= a X + b$. Taking expectations on both sides, we get
  $
    EE[f(X)] >= a EE[X] + b = a m + b = f(m) = f(EE[X]).
  $
]

#remark[
  For the equality case, let $f: RR -> RR$ be #ponder("analysis.convex-function")[convex] with the extra property that for $m = EE[X]$, $exists a, b in RR$, such that $f(x) > a x + b$ for all $x in RR \\ {m}$ and $f(m) = a m + b$.

  We wish to find a condition of $X$ such that we have
  $
    EE[f(X)]= f[EE[X]].
  $
  We have $f(X) >= a X + b => f(X)-(a X + b) >= 0$. Taking expectations gives
  $
    EE[f(X)] >= a EE[X] + b = a m + b = f(m) = f(EE[X]).
  $
  Hence, the equality forces $EE[f(X)- (a X + b)] = 0$.

  Since $f(X) - (a X + b) >= 0$, we must have $PP(f(X) - (a X + b) = 0) = 1$. By the extra property of $f$, this is equivalent to $PP(X = m) = 1$.
]

#lecture-separator(lecture: 10, date: "2026-02-13")

#proposition[AM-GM Inequality][
  Let $x_1, x_2, ..., x_n in RR_+$, then
  $
    (1)/(n) sum_(k=1)^n x_k >= (product_(k=1)^n x_k)^(1/n).
  $
] <prop-am-gm-inequality>

#proof[
  #claim[
    Let $f$ be a #ponder("analysis.convex-function")[convex function]. Then $forall x_1, ..., x_n in RR$, we have
    $
      (1)/(n) sum_(k=1)^n f(x_k) >= f((1)/(n) sum_(k=1)^n x_k).
    $
  ]

  #proof[
    Let $X$ be a #ponder("probability.random-variable")[random variable] with $PP(X = x_i) = (1)/(n)$ for all $i = 1, ..., n$. Then
    $
      EE[f(X)] = (1)/(n) sum_(k=1)^n f(x_k) >= f(EE[X]) = f((1)/(n) sum_(k=1)^n x_k).
    $
  ]
  Let $f(x) = -log x$ with $x>0$. This is a #ponder("analysis.convex-function")[convex function]. Hence, by the above claim, we have
  $
    (1)/(n) sum_(k=1)^n -log x_k >= -log((1)/(n) sum_(k=1)^n x_k).
  $
  Rearranging gives the desired result.
]

== Multiple #ponder("probability.discrete-random-variable")[Discrete Random Variables]

=== #ponder("probability.joint-distribution")[Joint Distribution] and #ponder("probability.conditional-distribution")[Conditional Distribution]

Recall that if $X$ is a #ponder("probability.discrete-random-variable")[discrete random variable], then the distribution of $X$ is given by $(PP(X = x))_x$.

#definition[Joint Distrbution and Marginal Distribution][
  Let $X_1, X_2,..., X_n$ be #ponder("probability.discrete-random-variable")[discrete random variables]. Their #ponder("probability.joint-distribution")[*joint distribution*] is defined to be
  $
    PP(X_1 = x_1, ..., X_n = x_n) quad "for all" x_1, ..., x_n.
  $
  In particular,
  $
    PP(X_1 = x_1) = sum_(x_2, ..., x_n) PP(X_1 = x_1, X_2 = x_2, ..., X_n = x_n).
  $
  where $PP(X_1=x_1)$ is called the #ponder("probability.joint-distribution")[*marginal distribution*] of $X_1$.
] <def-joint-distribution>

#definition[Conditional Distribution][
  Let $X$ and $Y$ be two #ponder("probability.discrete-random-variable")[discrete random variables]. The #ponder("probability.conditional-distribution")[conditional distribution] of $X$ given $Y=y$ is defined by
  $
    PP(X = x mid(|) Y = y) = (PP(X = x, Y = y)) / (PP(Y = y)).
  $

  By the #ponder("probability.law-of-total-probability")[law of total probability], we have
  $
    PP(X = x) = sum_y PP(X = x, Y = y) = sum_y PP(X = x mid(|) Y = y) PP(Y = y).
  $
] <def-conditional-distribution>

=== Distribution of the Sum of Random Variables

Let $X$ and $Y$ be two #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables]. We wish to find the distribution of $X+Y$.

$
  PP(X + Y = z) & = sum_(y) PP(X = z - y, Y = y) \
                & = underbracket(sum_(y) PP(X = z - y) PP(Y = y), "convolution of the 2 distributions").
$

#example[Independent #ponder("probability.poisson-distribution")[Poisson] Random Variables][
  Let $X ~ "Poi"(lambda)$ and $Y ~ "Poi"(mu)$ with $X indep Y$ Then
  $
    PP(X + Y = n) & = sum_(k=0)^n PP(X = n-k) PP(Y = k) \
                  & = sum_(k=0)^n ee^(-lambda) lambda^(n-k) / (n-k)! ee^(-mu) mu^k / k! \
                  & = (ee^(-(lambda + mu)))/n! sum_(k=0)^n binom(n, k) lambda^(n-k) mu^k \
                  & = ee^(-(lambda + mu)) (lambda + mu)^n / n!.
  $
  So $PP(X + Y = n) = ee^(-(lambda + mu)) (lambda + mu)^n / n!$. Hence $X + Y ~ "Poi"(lambda + mu)$
]

=== #ponder("probability.conditional-expectation")[Conditional Expectation]

Recall that for $PP(B) > 0$,
$
  PP(A mid(|) B) = (PP(A inter B)) / (PP(B)).
$

#definition[Conditional Expectation][
  Let $X$ be a #ponder("probability.discrete-random-variable")[discrete random variable] and $B in cal(F)$ with $PP(B) > 0$. The #ponder("probability.conditional-expectation")[*conditional expectation*] of $X$ given and #ponder("probability.outcomes-and-events")[event] $B$ is defined by
  $
    EE[X mid(|) B] = (EE[X dot bb(1)(B)]) / (PP(B)).
  $
] <def-conditional-expectation>

Note that if $X = bb(1)(A)$, we recover
$
  EE[bb(1)(A) mid(|) B] = EE[bb(1)(A inter B)] / PP(B) = PP(A inter B) / PP(B) = PP(A mid(|) B).
$

#proposition[Law of Total Expectation][
  Let $X$ be a #ponder("probability.discrete-random-variable")[discrete random variable] and $(Omega_n)$ a #ponder("set-theory.partition")[partition] of $Omega$ with $PP(Omega_n) > 0$ for all $n$. Then
  $
    EE[X] = sum_n EE[X mid(|) Omega_n] PP(Omega_n).
  $
] <prop-law-of-total-expectation>
#proof[
  We have
  $
    EE[X] & = sum_(omega in Omega) X(omega) PP({omega}) \
          & = sum_n sum_(omega in Omega_n) X(omega) PP({omega}) \
          & = sum_n EE[X dot bb(1)(Omega_n)] \
          & = sum_n EE[X mid(|) Omega_n] PP(Omega_n).
  $
]

In particular, for the #ponder("probability.conditional-probability")[conditional probability] of $X$ given $Y = y$, we have
$
  EE[X mid(|) Y=y] & = EE[X dot bb(1)(Y=y)] / PP(Y=y) \
                   & = sum_x x PP(X=x, Y=y) / PP(Y=y) \
                   & = sum_x x PP(X=x mid(|) Y=y).
$
Let $g(y) = EE[X mid(|) Y=y]$ since this is a function of $y$. Consider what is meant by $EE[X|Y]$.

We will define $EE[X mid(|) Y]$ as a #ponder("probability.random-variable")[random variable], which is a function of $Y$.

#definition[Conditional Expectation given a Random Variable][
  Let $X$ and $Y$ be #ponder("probability.discrete-random-variable")[discrete random variables]. The #ponder("probability.conditional-expectation")[*conditional expectation*] of $X$ given $Y$ is defined by
  $
    EE[X mid(|) Y] = sum_y EE[X mid(|) Y=y] bb(1)(Y=y) = g(Y).
  $
  where $g(y) = EE[X mid(|) Y=y]$.
] <def-conditional-expectation-random-variable>

#remark[
  The above notation can be confusing. $EE[X mid(|) Y]$ is a #ponder("probability.random-variable")[random variable], which is a function of $Y$. In particular, if $Y(omega) = y$, then $EE[X mid(|) Y](omega) = EE[X mid(|) Y=y]$.

  Bear in mind that #ponder("probability.random-variable")[random variables] are functions. We have $X, Y: Omega -> RR$, and so $g(Y)$ really means $g compose Y$.
]

#example[
  Consider tossing a $p$-coin $n$ times #ponder("probability.independence-of-events")[independently]. For $i = 1, ..., n$, let
  $
    X_i & = bb(1)(i-"th toss is H") \
    Y_n & = X_1 + ... + X_n
  $
  We wish to find $EE[X_1 mid(|) Y_n]$. Let
  $
    g(y) & = EE[X_1 mid(|) Y_n = y] \
         & = EE[X_1 dot bb(1)(Y_n = y)] / PP(Y_n = y) \
         & = PP(X_1 = 1, Y_n = y) / PP(Y_n = y) \
         & = p dot (binom(n-1, y-1) p^(y-1) (1-p)^(n-y)) / (binom(n, y) p^y (1-p)^(n-y)) \
         & = (y)/(n). \
  $
  So, $EE[X_1 mid(|) Y_n] = g(Y_n) = (Y_n)/(n)$.
]

#proposition[
  Let $X$ and $Y$ be #ponder("probability.discrete-random-variable")[discrete random variables]. Then for some constant $c in RR$,

  1. $EE[c X mid(|) Y] = c EE[X mid(|) Y]$.

  2. $EE[c + X mid(|) Y] = c + EE[X mid(|) Y]$.

    In particular, $EE[c mid(|) Y] = c$.

  3. $EE[sum_(i=1)^n X_i mid(|) Y] = sum_(i=1)^n EE[X_i mid(|) Y]$.
] <prop-conditional-expectation-linearity>

#lecture-separator(lecture: 11, date: "2026-02-16")

#proposition[Tower Property][
  Let $X$ and $Y$ be #ponder("probability.discrete-random-variable")[discrete random variables]. Then
  $
    EE[X] = EE[EE[X mid(|) Y]].
  $
] <prop-tower-property-expectation>

#proof[
  We have
  $
    EE[X mid(|) Y] & = sum_y EE[X mid(|) Y=y] bb(1)(Y=y).
  $
  Taking #ponder("probability.expectation")[expectation] on both sides gives
  $
    EE[EE[X mid(|) Y]] & = sum_y EE[X mid(|) Y=y] PP(Y=y) \
                       & = EE[X] quad "by the law of total expectation".
  $
]

#proposition[
  Let $X$ and $Y$ be #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.discrete-random-variable")[discrete random variables]. Then
  $
    EE[X mid(|) Y] = EE[X].
  $
] <prop-tower-property>

#proof[
  We have
  $
    EE[X mid(|) Y] & = sum_y EE[X mid(|) Y=y] bb(1)(Y=y) \
                   & = sum_y bb(1)(Y=y) sum_x x PP(X=x| Y=y) \
                   & = sum_y bb(1)(Y=y) sum_x x PP(X=x) quad "by independence" \
                   & = sum_y bb(1)(Y=y) EE[X] \
                   & = EE[X].
  $

]

#proposition[
  Let $Y, Z$ be #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.discrete-random-variable")[discrete random variables]. Then for any #ponder("probability.random-variable")[random variable] $X$,
  $
    EE[EE[X mid(|)Y] mid(|)Z] = EE[X].
  $
] <prop-tower-property-2>

#proof[
  Let $g(Y) = EE[X mid(|) Y]$ and $g(y) = EE[X mid(|) Y=y]$.

  #claim[
    $g(Y)$ is #ponder("probability.independence-of-random-variables")[independent] of $Z$.
  ]

  #proof[
    We need to show that
    $
      forall w, z in RR, quad PP(g(Y) = w, Z = z) = PP(g(Y) =w) PP(Z = z).
    $

    We have
    $
      PP(g(Y)=w, Z=z) & = sum_(y in g^(-1)({w})) PP(Y=y, Z=z) \
                      & = sum_(y in g^(-1)({w})) PP(Y=y) PP(Z=z) quad "by independence" \
                      & = PP(g(Y)=w) PP(Z=z).
    $
  ]
  Then, by @prop-tower-property-2, we have $EE[g(Y) mid(|) Z] = EE[g(Y)]$.

  By @prop-tower-property, we have $EE[g(Y)] = EE[X]$. Hence, $EE[EE[X mid(|) Y] mid(|) Z] = EE[X]$.
]

#proposition[
  Let $X, Y$ be two #ponder("probability.random-variable")[random variables] and $h: RR->RR$. Then
  $
    EE[h(Y) dot X mid(|) Y] = h(Y) EE[X mid(|) Y].
  $
] <prop-conditional-expectation-pulling>

#proof[
  We have
  $
    EE[h(Y) dot X mid(|) Y] & = sum_y bb(1)(Y=y) EE[h(Y) dot X mid(|) Y=y] \
                            & = sum_y h(y) bb(1)(Y=y) EE[X mid(|) Y=y] \
                            & = h(Y) EE[X mid(|) Y].
  $
]

#corollary[
  Let $X, Y$ be two #ponder("probability.random-variable")[random variables]. Then

  1. $EE[EE[X mid(|) Y] mid(|) Y] = EE[X mid(|) Y].$

  2. $EE[X mid(|)X] = X$.
] <cor-conditional-expectation-idempotent>

#example[
  Consider tossing a $p$-coin $n$ times #ponder("probability.independence-of-events")[independently]. For $i = 1, ..., n$, let
  $
    X_i & = bb(1)(i-"th toss is H") \
    Y_n & = X_1 + ... + X_n
  $
  We wish to find $EE[X_1 mid(|) Y_n]$. By symmetry, $EE[X_i mid(|) Y_n] = EE[X_1 mid(|) Y_n]$ for all $i$. Hence,
  $
    Y_n = EE[Y_n mid(|) Y_n] & = EE[X_1 + ... + X_n mid(|) Y_n] \
                             & = sum_(i=1)^n EE[X_i mid(|) Y_n] \
                             & = n EE[X_1 mid(|) Y_n].
  $
  So, $EE[X_1 mid(|) Y_n] = (Y_n)/(n)$.
]

== #ponder("probability.random-walk")[Random Walks]

#definition[Random Process / Stochastic Process][
  A #ponder("probability.stochastic-process")[*random process*] or #ponder("probability.stochastic-process")[*stochastic process*] is a sequence of #ponder("probability.random-variable")[random variables] $(X_n)_(n in NN)$.
] <def-stochastic-process>

#definition[Random Walk][
  A #ponder("probability.random-walk")[*random walk*] is a #ponder("probability.stochastic-process")[random process] that can be expressed as
  $
    X_n = x + Y_1 + Y_2 + ... + Y_n
  $
  where $x$ is a deterministic constant and $(Y_n)_(n in NN)$ are #ponder("probability.independence-of-random-variables")[independent] and identically distributed (i.i.d.) #ponder("probability.random-variable")[random variables].

  The steps of the #ponder("probability.random-walk")[random walk] are the #ponder("probability.random-variable")[random variables] $Y_n$.
] <def-random-walk>

=== #ponder("probability.simple-random-walk")[Simple Random Walk]

#definition[Simple Random Walk][
  A #ponder("probability.simple-random-walk")[*simple random walk*] is a #ponder("probability.random-walk")[random walk] satisfying $PP(Y_i = 1) = p = 1 - PP(Y_i = -1)$.

  If $p = q = 1-p = (1)/(2)$, then we call it a #ponder("probability.simple-random-walk")[simple *symmetric* random walk].
] <def-simple-random-walk>

#example[Gambler's Ruin][
  Consider $(X_n)$ as a #ponder("probability.simple-random-walk")[simple random walk], which is the fortune of a gambler who starts with $£x$ at time $0$ and at every time step, he wins $£1$ with probability $p$ and loses $£1$ with probability $q = 1-p$.The game ends if he reaches $0$ or if he reaches $£a$, whichever comes first.

  #notation[
    We will denote $PP_x (A) = PP(A mid(|)X_0 = x)$, and $X = (X_n)$.
  ]
  Let $h(x) = PP_x ((X_n) "reaches" a "before reaching" 0)$. Then $h(0) = 0$ and $h(a) = 1$.

  Then,
  $
    h(x) & = PP_x (X "reaches" a "before reaching" 0) \
    & = PP_x (X "reaches" a "before" 0, Y_1 = 1) + PP_x (X "reaches" a "before" 0, Y_1 = -1) \
    & = p PP_(x+1) (X "reaches" a "before" 0 mid(|) Y_1 = 1) + (1-p) PP_(x-1) (X "reaches" a "before" 0 mid(|) Y_1 = -1) \
    &= p dot h(x+1) + (1-p) dot h(x-1). \
  $
  So we can solve the following system of equations to find $h(x)$ for all $x$:
  $
    cases(
      h(x) = p h(x+1) + (1-p) h(x-1),
      h(0) = 0,
      h(a) = 1
    )
  $

  #lecture-separator(lecture: 12, date: "2026-02-18")

  - For $p=q=(1)/(2)$, we get a #ponder("probability.simple-random-walk")[simple symmetric random walk] (SSRW), in which case we have
    $
      cases(
        h(x) = (1)/(2) h(x+1) + (1)/(2) h(x-1),
        h(0) = 0,
        h(a) = 1
      )
    $
    This leads to
    $
      h(x+1)-h(x) = h(x) -h(x-1) = c.
    $
    Hence,
    $
      h(x)=sum_(i=1)^x (h(i)-h(i-1)) = sum_(i=1)^x c = c x.
    $
    Considering boundary conditions, $h(a) = 1$ gives $c = (1)/(a)$. Hence, for a SSRW, we have
    $
      h(x) = (x)/(a).
    $

  - For $p!=q$, we need to try a solution of the form $lambda^x$ for some $lambda$. Then

    $
      lambda^x = p dot lambda^(x+1) + q lambda^(x-1) => lambda = 1 "or" lambda = q/p.
    $

    The general solution is of the form $h(x) = A + B (q/p)^x$ for some constants $A, B in RR$. Using the boundary conditions, we get
    $
      h(x) = ((q/p)^x - 1) / ((q/p)^a - 1).
    $
] <exm-gamblers-ruin>

=== Time to Absorption

Let $(X_n)$ be a #ponder("probability.simple-random-walk")[simple random walk]. We are interested in the time to absorption, which is the duration of the game. Let the time to absorption be denoted by $T$. Then
$
  T = min {n >= 0: X_n in {0, a}}.
$

We would like to consider the expected time to absorption, i.e. $EE[T mid(|) X_0 = x]$.


#notation[
  We will denote $EE_x [T] = EE[T mid(|) X_0 = x] = k(x)$.
]


By the #ponder("probability.law-of-total-expectation")[law of total expectation], we have
$
  k(x) & = EE_x [T] \
       & = EE_x [T mid(|) Y_1 = 1] PP(Y_1 = 1) + EE_x [T mid(|) Y_1 = -1] PP(Y_1 = -1) \
       & = p EE_(x+1) [T + 1] + q EE_(x-1) [T + 1] \
       & = p (k(x+1) + 1) + q (k(x-1) + 1) \
       & = p k(x+1) + q k(x-1) + 1.
$
Boundary conditions are $k(0)=k(a)=0$.

- For $p=q=(1)/(2)$, try a solution of the form $k(x) = A x^2$. Then
  $
    A x^2 = (1)/(2) A (x+1)^2 + (1)/(2) A (x-1)^2 + 1 => A = -1.
  $
  The general solution will be of the form $k(x) = -x^2 + B x + C$. Using boundary conditions, we get
  $
    k(x) = x (a-x).
  $

- For $p!=q$, try $C x$ as a solution. Then $C = (1)/(q-p)$. Hence

  $
    k(x) = A + (1)/(q-p) x + B((q)/(p))^x.
  $

  Solving this gives
  $
    k(x) = (1)/(q-p) x - (a)/(q-p) (((q)/(p))^x - 1) / (((q)/(p))^a - 1).
  $

== #ponder("probability.probability-generating-function")[Probability Generating Functions]

=== Introduction

#definition[Probability Mass Function][
  Let $X$ be a #ponder("probability.discrete-random-variable")[discrete random variable]. The #ponder("probability.probability-mass-function")[*probability mass function*] of $X$ is defined by
  $
    p_r = PP(X = r).
  $
] <def-probability-mass-function>

#definition[Probability Generating Function][
  Let $X$ be a #ponder("probability.discrete-random-variable")[discrete random variable] taking values in $NN$. The #ponder("probability.probability-generating-function")[*probability generating function*] (PGF) of $X$ is defined by
  $
    p(z) = EE[z^X] = sum_(r=0)^oo p_r z^r
  $
  where $abs(z) <= 1$.
] <def-probability-generating-function>

Note that $p(z)$ #ponder("analysis.absolute-convergence")[converges absolutely] for $abs(z) <= 1$ since $p_r >= 0$ and $sum_(r=0)^oo p_r = 1$. Hence the radius of convergence of $p(z)$ is at least $1$. Therefore, $p(z)$ is well-defined for $abs(z) <= 1$.

#remark[
  In this section, we will only consider #ponder("probability.discrete-random-variable")[discrete random variables] taking values in $NN$.
]

#theorem[
  The PGF of a #ponder("probability.random-variable")[random variable] $X$ uniquely determines the distribution of $X$.
] <thm-pgf-uniqueness>

#proof[
  Let $(p_r)$ and $(q_r)$ be 2 probability distributions with the same PGF, _i.e._ for all $abs(z) <= 1$,
  $
    sum_(r=0)^oo p_r z^r = sum_(r=0)^oo q_r z^r.
  $
  We need to show that $p_r = q_r$ for all $r$. We shall show this by induction. For $z -> 0$,
  $
    p_0 = q_0.
  $
  Assume that $p_r = q_r$ for all $r <= n$. Then
  $
    sum_(r=n+1)^oo p_r z^r = sum_(r=n+1)^oo q_r z^r.
  $
  Dividing both sides by $z^(n+1)$ and letting $z -> 0$ gives
  $
    p_(n+1) = q_(n+1).
  $
]

#example[
  Consider $X ~ "Bin"(n, p)$. Then
  $
    p(z) = EE[z^X] = sum_(r=0)^n binom(n, r) p^r (1-p)^(n-r) z^r = (1-p + p z)^n.
  $

]


#remark[
  Suppose that $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables] with PGFs
  $
    q_i (z) = EE[z^(X_i)].
  $
  Consider the PGF of $S_n = X_1 + ... + X_n$:
  $
    p(z) = EE[z^(X_1 + ... + X_n)] = EE[z^(X_1) z^(X_2) ... z^(X_n)] = EE[z^(X_1)] EE[z^(X_2)] ... EE[z^(X_n)] = product_(i=1)^n q_i(z).
  $
]

#example[
  Consider $X ~ "Bin"(n, p)$ and $Y ~ "Bin"(m, p)$ with $X indep Y$. Then
  $
    EE[z^(X+Y)] = EE[z^X] EE[z^Y] = (1-p + p z)^n (1-p + p z)^m = (1-p + p z)^(n+m).
  $
  Hence $X + Y ~ "Bin"(n+m, p)$.
]

#example[
  Consider $X ~ "Geo"(p)$. Then
  $
    EE[z^X] & = sum_(r=1)^oo z^r (1-p)^(r-1) p = (p z)/(1 - z(1-p)).
  $
]

#example[
  Consider $X ~ "Poi"(lambda)$. Then
  $
    EE[z^X] & = sum_(r=0)^oo z^r ee^(-lambda) lambda^r / r! = ee^(-lambda) sum_(r=0)^oo (lambda z)^r / r! = ee^(-lambda) ee^(lambda z) = ee^(lambda(z-1)).
  $
]

#example[
  Consider $X ~ "Poi"(lambda)$ and $Y ~ "Poi"(mu)$ with $X indep Y$. Then
  $
    EE[z^(X+Y)] & = EE[z^X] EE[z^Y] = ee^(lambda(z-1)) ee^(mu(z-1)) = ee^((lambda + mu)(z-1)).
  $
  Hence, $X + Y ~ "Poi"(lambda + mu)$.
]

#theorem[
  Let $p(z)$ be the PGF of a #ponder("probability.random-variable")[random variable] $X$. Then
  $
    lim_(z-> 1^-) p'(z) = p'(1^-) = EE[X].
  $
] <thm-pgf-derivative>

#proof[
  - Assume that $EE[X] < oo$. Take $0 < z < 1$. Then
    $
      p'(z) = sum_(r=1)^oo r p_r z^(r-1) <= sum_(r=1)^oo r p_r = EE[X].
    $
    So $p'(z)$ is increasing in $z$ and bounded above by $EE[X]$. Hence, $lim_(z-> 1^-) p'(z) <= EE[X]$.

    Take $epsilon > 0$. There exists $N$ such that
    $
      sum_(r=1)^N r p_r >= EE[X] - epsilon.
    $
    Then,
    $
      lim_(z-> 1^-) p'(z) & >= lim_(z-> 1^-) sum_(r=1)^N r p_r z^(r-1) = sum_(r=1)^N r p_r >= EE[X] - epsilon.
    $
    Hence, $lim_(z-> 1^-) p'(z) = EE[X]$.

  - Assume that $EE[X] = oo$. Then $forall M > 0, exists N$ such that
    $
      sum_(r=1)^N r p_r >= M.
    $
    Then,
    $
      lim_(z-> 1^-) p'(z) & >= lim_(z-> 1^-) sum_(r=1)^N r p_r z^(r-1) = sum_(r=1)^N r p_r >= M.
    $
    Hence, $lim_(z-> 1^-) p'(z) = oo$.
]

#theorem[
  Let $p(z)$ be the PGF of a #ponder("probability.random-variable")[random variable] $X$. Then

  - $p''(1^-) = EE[X(X-1)].$

  - $forall k >= 0, p^((k))(1^-) = EE[X(X-1)...(X-k+1)].$

  - $"Var"(X) = p''(1^-) + p'(1^-) - (p'(1^-))^2.$

  - $PP(X = n) = eval(dif^n /(dif z^n) (p(z) dot (1)/(n!)))_(z=0)$
] <thm-pgf-moments>

#lecture-separator(lecture: 13, date: "2026-02-20")

=== #ponder("probability.random-sum")[Sum of a Random Number of Random Variables]

Let $X_1, X_2, ...$ be #ponder("probability.independence-of-random-variables")[independent] and identically distributed #ponder("probability.random-variable")[random variables] and let $N$ be an #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variable] taking values in $NN$.

Let
$
          S_n & = X_1 + X_2 + ... + X_n \
  S_n (omega) & = sum_(i=1)^n X_i(omega) \
  S_N (omega) & = sum_(i=1)^N(omega) X_i(omega).
$

#lemma[
  Let $q(z) = EE[z^N]$ be the PGF of $N$ and $p(z) = EE[z^(X_1)]$ be the PGF of $X_1$.

  Then the PGF of $S_N$ is given by
  $
    r(z) = EE[z^(S_N)] = q(p(z)).
  $

] <lem-random-sum-pgf>

#proof[

  / Proof 1: We have
    $
      r(z) = EE[z^(S_N)] & = sum_(n=0)^oo EE[z^(S_n) dot bb(1)(N=n)] \
                         & = sum_(n=0)^oo EE[z^(X_1 + ... + X_n) dot bb(1)(N=n)] \
                         & = sum_(n=0)^oo EE[z^(X_1) z^(X_2) ... z^(X_n)] dot PP(N=n) \
                         & = sum_(n=0)^oo (EE[z^(X_1)])^n dot PP(N=n) \
                         & = sum_(n=0)^oo (p(z))^n dot PP(N=n) \
                         & = q(p(z)) quad "by definition of PGF".
    $

  / Proof 2: We have
    $
      r(z) = EE[z^(S_N)] & = EE[EE[z^(S_N) mid(|) N]].
    $
    Note that
    $
      EE[z^(S_N) mid(|) N](n) & = EE[z^(S_N) mid(|) N=n] \
                              & = EE[z^(S_n) mid(|) N=n] \
                              & = EE[z^(S_n)] quad "by independence" \
                              & = (p(z))^n. \
    $
    Hence, we can write $EE[z^(S_N) mid(|) N] = (p(z))^N$. Taking expectation on both sides gives
    $
      r(z) = EE[(p(z))^N] = q(p(z)).
    $
]

We have
$
     EE[S_N] & = r'(1^-) = q'(p(1^-)) p'(1^-) = EE[N] EE[X_1] \
  "Var"(S_N) & = EE[N] "Var"(X_1) + "Var"(N) (EE[X_1])^2.
$

== Branching Processes

Let $X_0 = 1$, and $X_1$ be the distribution of the number of offspring of the individual in the first generation. #fade[[$X_n$ is the number of individuals in the $n$-th generation.]]

$
  PP(X_1 = k) = g_k quad forall k in ZZ_(>=0).
$


Each individual produces an independent number of offspring with the same distribution as $X_1$.

Let $(Y_(k, n))_(k>=1, n>=0)$ be a family of #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables] such that $Y_(k, n)$ has the same distribution as $X_1$ for all $k, n$. Then we can write
$
  Y_(k, n) & = "number of offspring the" k"-th individual in the" n"-th generation produces", \
   X_(n+1) & = cases(
               0 quad & "if" X_n = 0,
               sum_(k=1)^(X_n) Y_(k, n) quad & "if" X_n > 0.
             )
$

We are interested in the probability of extinction.

=== #ponder("probability.probability-generating-function")[Generating Functions] of Branching Processes

#theorem[
  Let $(X_i)$ be a branching process with offspring distribution $X_1$. Then,
  $ EE[X_n] = (EE[X_1])^n. $
] <prop-mean-branching-process>

#proof[
  We will show this by induction. For $n=0$, we have $EE[X_0] = 1 = (EE[X_1])^0$. Assume that $EE[X_n] = (EE[X_1])^n$. Then
  $
    EE[X_(n+1)] & = EE[EE[X_(n+1) mid(|) X_n]].
  $
  Note that
  $
    EE[X_(n+1) mid(|)X_n = m] & = EE[Y_(1, n) + ... + Y_(m, n) mid(|) X_n = m] \
                              & = EE[Y_(1, n) + ... + Y_(m, n)] quad "by independence" \
                              & = m EE[X_1].
  $
  Thus,
  $
    EE[X_(n+1) mid(|) X_n] = X_n EE[X_1].
  $
  Taking expectation on both sides gives
  $
    EE[X_(n+1)] = EE[X_n] EE[X_1] = (EE[X_1])^(n+1).
  $
]

#theorem[
  Let $G(z) = EE[z^(X_1)]$ and $G_n (z) = EE[z^(X_n)]$. Then
  $
    G_(n+1) (z) = G(G_n(z)) = G_n (G(z)) = G compose G compose dots.c compose G (z).
  $
] <thm-branching-generating-functions>

#proof[
  We have
  $
    G_(n+1) (z) & = EE[z^(X_(n+1))] \
                & = EE[EE[z^(X_(n+1)) mid(|)X_n]] \
                & = EE[EE[z^(Y_(1, n) + ... + Y_(X_n, n)) mid(|)X_n]].
  $
  Note that,
  $
    EE[z^(Y_(1, n) + ... + Y_(X_n, n)) mid(|) X_n = m] & = EE[z^(Y_(1, n) + ... + Y_(m, n)) ] \
                                                       & = EE[z^(Y_(1, n))] ... EE[z^(Y_(m, n))] quad "by independence" \
                                                       & = (G(z))^m. \
  $
  Hence,
  $
    G_(n+1) (z) & = EE[(G(z))^(X_n)] & = G_n (G(z)).
  $

]

=== #ponder("probability.extinction-probability")[Extinction Probability]

Let
$
  q = PP(X_n = 0 "for some" n >= 0)
$
and $q_n = PP(X_n = 0)$.

Since ${X_n = 0} subset.eq {X_(n+1) = 0}$, $(q_n)$ is an increasing sequence that #ponder("analysis.sequence-convergence")[converges] to $q$, by the #ponder("probability.continuity-of-probability-measures")[continuity of probability measures].

#fade[[Recall that $A_n subset.eq A_(n+1)$ for all $n$ implies that $PP(A_n) -> PP(union.big_n A_n)$.]]

#proposition[
  Let $G(z)$ be the PGF of $X_1$. Then $G(z) = EE[z^(X_1)]$, and
  $
    q_(n+1) = G(q_n), quad q = G(q).
  $
] <prop-extinction-probability>

#proof[
  If we were given that $q_(n+1) = G(q_n)$, then since $G$ is continuous as $q_n -> q$, we have $q = G(q)$. So we just need to show that $q_(n+1) = G(q_n)$.

  / Proof 1: We have
    $
      q_(n+1) = PP(X_(n+1) = 0) & = G_(n+1) (0) \
                                & = G(G_n (0)) \
                                & = G(q_n) \.
    $

  / Proof 2: Conditioning on $X_1 = m$, let $X_n^((1)), X_n^((2)), ..., X_n^((m))$ be #ponder("probability.independence-of-random-variables")[independent] and identically distributed branching processes with the same offspring distribution as $X_1$. Then
    $
      X_(n+1) = sum_(i=1)^m X_n^((i)).
    $
    Hence,
    $
      q_(n+1) & = PP(X_(n+1) = 0) \
              & = sum_m PP(X_(n+1) = 0 mid(|) X_1 = m) PP(X_1 = m) \
              & = sum_m PP(sum_(i=1)^m X_n^((i)) = 0 mid(|) X_1 = m) PP(X_1 = m) \
              & = sum_m PP(X_n^((1)) = ... = X_n^((m)) = 0) PP(X_1 = m) \
              & = sum_m (q_n)^m PP(X_1 = m) \
              & = G(q_n).
    $
]

#lecture-separator(lecture: 14, date: "2026-02-23")

Note that in @prop-mean-branching-process, we have
$
  EE[X_n] = (EE[X_1])^n.
$
So, in order to evaluate $q$, consider the following cases:

- If $EE[X_1] < 1$, then $EE[X_n] -> 0$ as $n->oo$, so we expect that $q = 1$.

- If $EE[X_1] > 1$, then $EE[X_n] -> oo$ as $n->oo$, so we expect that $q < 1$.

- If $EE[X_1] = 1$, then $EE[X_n] = 1$ for all $n$, which does not give us an intuition on $q$.

Note that the relation $q=G(q)$ always has a solution at $q=1$, as shown in the following graphs:

#align(center)[
  #dynamic-svg("/part-ia/probability/media/d1e1.svg", width: 28em)
]

Note that the gradient of the tangent at $x=1$ is $G'(1) = EE[X_1]$. Hence, the first two cases can be justified.

#theorem[
  Let $(X_n)$ be a branching process with offspring distribution $X_1$. Assume that $PP(X_1 = 1) < 1$.

  Then the #ponder("probability.extinction-probability")[extinction probability] $q$ is the minimal non-negative solution to the equation $G(x) = x$.

  Moreover, $q < 1$ iff $EE[X_1] > 1$.
] <thm-extinction-probability>

#proof[
  We know that $q = G(q)$ in @prop-extinction-probability.

  Let $t$ be the smallest non-negative solution to $G(x) = x$. We will show that $q = t$.

  We will prove by induction that $q_n <= t$ for all $n$, which will imply that $q <= t$ as $n->oo$, but since $t$ is the smallest non-negative solution to $G(x) = x$, we have $t <= q$. Hence, $q = t$.

  For $n=0$, we have $q_0 = PP(X_0 = 0) = 0 <= t$. Assume that $q_n <= t$. Then
  $
    q_(n+1) = G(q_n) <= G(t) = t
  $
  since $G$ is increasing in $[0, 1]$. Hence, $q_(n+1) <= t$.

  #separator

  Now, we will show that $q < 1$ iff $EE[X_1] > 1$.

  Assume that $PP(X_1 <= 1) = g_0 + g_1 = 1$, then $PP(X_1 <= 1) = 1$, and then
  $
    EE[X_1] = g_1.
  $
  Then in this case, $G(z) = g_0 + g_1 z = 1 - EE[X_1] + EE[X_1] z$. Then,
  $
    G(z) = z => (1- EE[X_1]) dot z = 1 - EE[X_1].
  $
  Because $EE[X_1] = g_1 < 1$, we have $1 - EE[X_1] != 0$, and so $z = 1$.

  Now assume that $g_1 < 1$ and $g_0 + g_1 < 1$, we shall show that $q < 1$ iff $EE[X_1] > 1$. Define
  $
    H(z) = G(z) - z = sum_(r=0)^oo g_r z^r - z.
  $
  Then $H(1) = 0$. We shall first show that $H$ can have at most one more root in $[0, 1)$. We have
  $
    H''(z) = sum_(r=0)^oo r(r-q) g_r z^(r-2) > 0 "in" (0, 1)
  $
  because $g_0 + g_1 < 1$ implies that there exists $r >= 2$ such that $g_r > 0$.

  Hence $H'(z)$ is strictly increasing in $(0, 1)$. Therefore, $H$ can have at most one more root other than $1$, due to Rolle's theorem. #fade[[If not, then $exists z_1, z_2 < 1$ such that $H(z_1) = H(z_2) = 0$. Then by Rolle's theorem, there exists $z_3 in (z_1, z_2)$ such that $H'(z_3) = 0$. Also, $exists z_4 in (z_2, 1)$ such that $H'(z_4) = 0$. This contradicts the fact that $H'(z)$ is strictly increasing in $(0, 1)$.]]

  We therefore have two cases:

  - $H$ has no other root other than $1$. Then $q = 1$. We need to show that $EE[X_1] <= 1$. We have
    $
      H'(1^-) = G'(1^-) - 1 = EE[X_1] - 1 <= 0.
    $

    This is because $H(0) = G(0) = g_0 >= 0$ and $H(1) = 0$. So
    $
      H(z) >= 0 quad forall z in [0, 1].
    $
    Hence
    $
      H'(1^-) = lim_(z-> 1^-) (H(z) - H(1)) / (z-1) <= 0.
    $
    So $H'(1^-) <= 0$, and hence $EE[X_1] <= 1$.

  - $H$ has another root $r < 1$. So $r$ has to be the #ponder("probability.extinction-probability")[extinction probability] $q$. We need to show that $EE[X_1] > 1$. We have
    $
      H(r) = 0, quad H(1) = 0.
    $
    By Rolle's theorem, there exists $z in (r, 1)$ such that $H'(z) = 0$. We also have
    $
      H'(1^-) = EE[X_1] - 1.
    $
    Since $H'$ is strictly increasing in $(0, 1)$, we have $H'(1^-) > H'(z) = 0$. Hence, $EE[X_1] > 1$.


]
