#import "../prelude.typ": *

= Convergence Results and Limit Theorems

== Convergence Results

#definition[Convergence in Probability][
  A sequence of #ponder("probability.random-variable")[random variables] $(X_n)_(n in NN)$ converges to a #ponder("probability.random-variable")[random variable] $X$ #ponder("probability.convergence-in-probability")[*in probability*] and we write
  $
    X_n stretch(->)^PP_(n->oo) X
  $
  if as $n->oo$,
  $
    forall epsilon > 0, quad PP(|X_n - X| > epsilon) -> 0.
  $
] <def-convergence-in-probability>

#theorem[Weak Law of Large Numbers][
  Let $X_1, X_2, ...$ be i.i.d. #ponder("probability.random-variable")[random variables] with mean $mu = EE[X_i] < oo$. Let $S_n = X_1 +... + X_n$. Then
  $
    (S_n)/n stretch(->)^PP_(n->oo) mu.
  $
  _i.e._
  $
    forall epsilon > 0, quad PP(abs((S_n)/n - mu) > epsilon) stretch(->)_(n->oo) 0.
  $
  This is called the #ponder("probability.weak-law-of-large-numbers")[*weak law of large numbers*] (WLLN).
] <thm-weak-law-of-large-numbers>

#lecture-separator(lecture: 22, date: "2026-03-13")

#proof[
  Assume that $sigma^2 = "Var"(X_1) < oo$. We need to show that
  $
    PP(abs(S_(n)/(n) - mu) > epsilon) -> 0 quad "as" n-> oo.
  $
  We have
  $
    PP(abs(S_(n)/(n) - mu) > epsilon) & = PP(abs(S_n - n mu) > n epsilon) \
                                      & <= EE[abs(S_n - n mu)^2]/(n^2 epsilon^2) quad "by Chebyshev's" \
                                      & = "Var"(S_n)/(n^2 epsilon^2) \.
  $
  By definition, we have $"Var"(S_n) = n sigma^2$. So
  $
    PP(abs((S_n)/(n) - mu) > epsilon) <= (sigma^2 n)/(n^2 epsilon^2) = (sigma^2)/(n epsilon^2) stretch(->)^(n->oo) 0.
  $
]

#definition[Convergence Almost Surely][
  Let $(X_n)_(n in NN)$ be a sequence of #ponder("probability.random-variable")[random variables] and $X$ be a #ponder("probability.random-variable")[random variable]. We say that $X_n$ converges to $X$ #ponder("probability.convergence-almost-surely")[*almost surely*] (a.s.) or *with probability $1$* if
  $
    PP(lim_(n->oo) X_n = X) = 1.
  $
  We write $X_n -> X$ as $n-> oo$ #ponder("probability.convergence-almost-surely")[almost surely].
] <def-convergence-almost-surely>

#remark[
  The above statement, more precisely, means that
  $
    exists A in cal(F) "with" PP(A) = 1, forall omega in A, forall epsilon > 0, exists n_0, forall n >= n_0: abs(X_n (omega) - X(omega)) <= epsilon
  $
  where $X_n : Omega -> RR$ and $X: Omega -> RR$.

  To compare with @def-convergence-in-probability, this is equivalently saying that
  $
    PP(forall epsilon > 0, exists n_0, forall n >= n_0: abs(X_n - X) <= epsilon) = 1.
  $
  Note that the quantifiers are now inside $PP$.

]
#fade[[It can be clearer to see the difference between #ponder("probability.convergence-in-probability")[*convergence in probability*] and #ponder("probability.convergence-almost-surely")[*convergence almost surely*] without any shorthands.
  Let the underlying #ponder("probability.probability-space")[probability space] be $(omega, cal(F), PP)$. Let $X$ and the sequence $X_1, X_2, ...$ be #ponder("probability.random-variable")[random variables], where $X, X_i: Omega -> RR$.

  #ponder("probability.convergence-in-probability")[*Convergence in probability*] states that $forall epsilon > 0$,
  $
    & lim_(n->oo) PP({omega in Omega: abs(X_n (omega) - X(omega)) > epsilon}) = 0\
    <=> quad &forall epsilon > 0, forall delta > 0, exists n_0 in NN, forall n >= n_0, PP({omega in Omega: abs(X_n (omega) - X(omega)) > epsilon}) < delta.
  $
  #ponder("probability.convergence-almost-surely")[*Convergence almost surely*] states that
  $
    &PP({omega in Omega: lim_(n->oo) X_n (omega) = X(omega)}) = 1\
    <=> quad &PP({omega in Omega: forall epsilon > 0, exists n_0 in NN, forall n <= n_0, abs(X_n (omega) - X(omega)) < epsilon}) = 1.
  $

  _i.e._ #ponder("probability.convergence-in-probability")[*convergence in probability*] cares about that as $n->oo$, (at each snapshot of $n$ big enough) the percentage of the population $Omega$ that behaves badly (away from $X(omega)$) shrinks to zero; whereas #ponder("probability.convergence-almost-surely")[*convergence almost surely*] cares about that the percentage of the population that converges to $X(omega)$ as $n->oo$ (without leaving there) is 1. This is a much stronger condition. For a sequence to converge #ponder("probability.convergence-almost-surely")[almost surely], the individuals can't keep jumping away from the target infinitely often, but they could for #ponder("probability.convergence-in-probability")[convergence in probability].

  This is indeed a challenging topic. See #link("https://en.wikipedia.org/wiki/Convergence_of_random_variables")[Wikipedia], #link("https://math.stackexchange.com/questions/149775/convergence-of-random-variables-in-probability-but-not-almost-surely")[Maths Stack Exchange] for further explanation.]]

#proposition[
  If $X_n -> 0$ as $n->oo$ #ponder("probability.convergence-almost-surely")[almost surely], then $X_n stretch(->)_(n->oo)^PP 0$.
] <prop-as-implies-in-probability>

#proof[
  We need to show that $forall epsilon > 0, PP(abs(X_n) <= epsilon) -> 1$ as $n->oo$. We have
  $
    PP(abs(X_n) <= epsilon) >= PP(underbracket(inter.big_(m=n)^oo abs(X_m) <= epsilon, A_n)).
  $
  Note that $A_n subset.eq A_(n+1)$. Hence
  $
    PP(A_n) stretch(->)^("increasing")_(n->oo) PP(union.big_n A_n) = PP(union.big_A inter.big_(m=n)^oo {abs(X_m) <= epsilon}).
  $
  So
  $
    lim_(n->oo) PP(abs(X_n) <= epsilon) >= PP(forall epsilon > 0, abs(X_m) <= epsilon "for all" m "sufficiently large").
  $
  By assumption, the RHS is exactly $1$.
]

#remark[
  In general, #ponder("probability.convergence-almost-surely")[almost sure convergence] implies #ponder("probability.convergence-in-probability")[convergence in probability], but not the other way around.
]

#theorem[Strong Law of Large Numbers][
  Let $X_1, X_2, ...$ be i.i.d. #ponder("probability.random-variable")[random variables] with mean $mu = EE[X_i] < oo$. Let $S_n = X_1 +... + X_n$. Then
  $
    (S_n)/n stretch(->)^"almost surely"_(n->oo) mu.
  $
  This is called the #ponder("probability.strong-law-of-large-numbers")[*strong law of large numbers*] (SLLN).
] <thm-strong-law-of-large-numbers>

#proof[
  #fade[[Non-examinable.]]

  Assume that $E[X_1^4] < oo$. Set $Y_i = X_i - mu$. Then $EE[Y_i] = 0$ and
  $
    EE[Y_1^4] = EE[(X_1 - mu)^4] <= 2^4 (EE[X_1^4] + mu^4) < oo.
  $

  Set $S_n = sum_(i=1)^n Y_i$. We need to show that $PP(lim_(n->oo) S_n/n = 0) = 1$.

  The goal is to show that $PP(sum_(n=1)^oo (S_(n)/(n))^4 < oo) = 1$ since this will imply that with probability 1, $S_n/n -> 0$ as $n->oo$.

  It suffices to show that $EE[sum_(n=1)^oo (S_(n)/(n))^4] < oo$. We have
  $
    EE[sum ((S_n)/(n))^4] = sum_n (1)/(n^4) EE[S_n^4].
  $
  By definition, we have
  $
    EE[S_n^4] = EE[(Y_1 + ... + Y_n)^4] = EE[sum_(i=1)^n Y_i^4 + 6 sum_(1 <= i < j <= n) Y_i^2 Y_j^2 + R]
  $
  where $R$ is a sum of terms of the form
  $
    Y_i^3 Y_j, Y_i^2 Y_j Y_k, Y_i Y_j Y_k Y_ell
  $
  for distinct $i, j, k, ell$. By #ponder("probability.independence-of-random-variables")[independence] and the fact that $EE[Y_i] = 0$, we have $EE[R] = 0$. Moreover,
  $
    EE[Y_i^2 Y_j^2] = (EE[Y_i^2])^2 <= EE[Y_i^4] < oo.
  $
  Therefore,
  $
    EE[S_n^4] & = n EE[Y_1^4] + (6(n)(n-1))/(2) EE[Y_1^4] \
              & <= 3 n^2 EE[Y_1^4].
  $
  So
  $ sum EE[S_n^4]/n^4 <= sum (3 EE[Y_1^4])/n^2 < oo. $
]

== #ponder("probability.central-limit-theorem")[Central Limit Theorem]

Let $X_1, X_2, ...$ be i.i.d. #ponder("probability.random-variable")[random variables] with mean $mu = EE[X_1] < oo$ and #ponder("probability.variance")[variance] $sigma^2 = "Var"(X_1) < oo$. Set $S_n = X_1 + ... + X_n$. By @thm-strong-law-of-large-numbers[SLLN], we expect that
$
  S_n approx n mu quad "for large" n.
$
Note that
$
  "Var"(S_n - n mu) = n sigma^2, quad EE[S_n - n mu] = 0.
$
Hence $(S_n - n mu)/(sqrt(n sigma^2) )$ has #ponder("probability.expectation")[expectation] $0$ and #ponder("probability.variance")[variance] $1$.

Also, we have
$
  (S_n - n mu)/(sqrt(n sigma^2) ) = (S_(n)/(n) - mu)/(sqrt("Var"(S_(n)/(n) - mu)) ).
$
So, if $X_1, X_2, ...$ are i.i.d. with $X_i ~ N(mu, sigma^2)$, then
$
  (S_n-n mu)/(sigma sqrt(n) ) ~ N(0, 1).
$

The #ponder("probability.normal-distribution")[normal distribution] is universal as it appears as the limit of the distribution of $(S_n - n mu)/(sigma sqrt(n))$ no matter what the distribution of $X_i$ is, as long as $X_i$ are i.i.d. with mean $mu$ and variance $sigma^2$. This is the content of the #ponder("probability.central-limit-theorem")[central limit theorem] (CLT).

#definition[Convergence in Distribution][
  A sequence of #ponder("probability.random-variable")[random variables] $(X_n)_(n in NN)$ converges to $X$ #ponder("probability.convergence-in-distribution")[in distribution] as $n->oo$ and we write
  $
    X_n stretch(->)^((d))_(n->oo) X quad "if" quad PP(X_n <= x) = F_(X_n)(x) stretch(->)_(n->oo) F_X (x) = PP(X <= x)
  $
  for all $x$ where $F_X$ is continuous.

] <def-convergence-in-distribution>

#lecture-separator(lecture: 23, date: "2026-03-16")

#proposition[
  If $X_n stretch(->)^(PP)_(n->oo) X$, then $X_n stretch(->)^((d))_(n->oo) X$.
] <prop-in-probability-implies-in-distribution>

#proof[
  Let $x$ be a continuity point of $F_X$. We need to show that $F_(X_n)(x) stretch(->)_(n->oo) F_X (x)$. Let $epsilon > 0$.

  We have
  $
    {X <= x - epsilon } & subset.eq {X_n <= x} union {abs(X_n - X) > epsilon} \
             {X_n <= x} & subset.eq {X <= x + epsilon} union {abs(X_n - X) > epsilon}.
  $
  So we have
  $
    PP(X <= x - epsilon) & <= PP(X_n <= x) + PP(abs(X_n - X) > epsilon) \
       F_X (x - epsilon) & <= liminf_(n->oo) PP(X_n <= x) \
  $
  Also,
  $
                  PP(X_n <= x) & <= PP(X <= x+ epsilon) + PP(abs(X_n - X) > epsilon) \
    limsup_(n->oo) F_(X_n) (x) & <= F_X (x + epsilon).
  $
  Hence
  $
    F_X (x-epsilon) <= liminf_(n->oo) F_(X_n)(x) <= limsup_(n->oo) F_(X_n)(x) <= F_X (x+epsilon).
  $
  Therefore, letting $epsilon -> 0$, we have
  $
    F_X (x) <= liminf_(n->oo) F_(X_n)(x) <= limsup_(n->oo) F_(X_n)(x) <= F_X (x).
  $
  So $F_(X_n)(x) stretch(->)_(n->oo) F_X (x)$ as required.
]

#theorem[Central Limit Theorem][
  Let $X_1, X_2, ...$ be i.i.d. #ponder("probability.random-variable")[random variables] with mean $mu = EE[X_i] < oo$ and #ponder("probability.variance")[variance] $sigma^2 = "Var"(X_i) < oo$. Set $S_n = X_1 + ... + X_n$. Then
  $
    (S_n - n mu)/(sigma sqrt(n)) stretch(->)^((d))_(n->oo) N(0, 1) = Z.
  $
  _i.e._ $forall x in RR$,
  $
    PP((S_n - n mu)/(sigma sqrt(n)) <= x) stretch(->)_(n->oo) integral_(-oo)^x (exp(-t^y/2))/(sqrt(2 pi)) dif y = Phi(x).
  $
] <thm-central-limit-theorem>

#proof[
  We will need the following continuity property for #ponder("probability.moment-generating-function")[moment generating functions].
  #theorem[Continuity Property for MGFs][
    Suppose $(X_n)$ are #ponder("probability.random-variable")[random variables] with $m_n (theta) = EE[ee^(theta X_n)]$ for $theta in RR$ and $X$ is a #ponder("probability.random-variable")[random variable] with $m(theta) = EE[ee^(theta X)]$ for $theta in RR$. Assume $m(theta) < oo$ for some $theta != 0$.

    If $m_n (theta) -> m(theta)$ as $n->oo$ for all $theta$ in $RR$, then
    $
      X_n stretch(->)^((d))_(n->oo) X.
    $
  ] <thm-mgf-continuity-property>

  The proof is beyond the scope of this course.

  Consider $Y_i = (X_i - mu)/(sigma)$. Then
  $
    EE[Y_i] = 0, quad "Var"(Y_i) = 1.
  $
  It is enough to prove the theorem for a sequence $X_1, X_2, ...$, i.i.d. with mean $0$ and variance $1$. Set $S_n = X_1 + ... + X_n$. We need to show that
  $
    S_n/(sqrt(n)) stretch(->)^((d))_(n->oo) Z.
  $

  Assume that $exists delta > 0$ such that $EE[ee^(delta X_1)] + EE[-ee^(delta X_1)] < oo$.

  Set $m(theta) = EE[ee^(theta X_1)]$. By the #ponder("probability.mgf-continuity-property")[continuity property for MGFs], it suffices to show that
  $
    EE[ee^(theta S_n/(sqrt(n)))] stretch(->)_(n->oo) EE[ee^(theta Z)] = exp(theta^2/2).
  $
  Note that
  $
    EE[ee^(theta S_(n)/(sqrt(n) ))] & = (m ((theta)/(sqrt(n) )))^n
  $
  We want to show that
  $
    (m((theta)/(sqrt(n) )))^n stretch(->)_(n->oo) exp(theta^2/2) quad forall theta in RR.
  $
  We have
  $
    m((theta)/(sqrt(n) )) = EE[ee^((theta X_1)/(sqrt(n) ))] = 1 + (theta^2)/(2 n) + EE[sum_(k>=3) (theta X_1)^k/((sqrt(n))^k (k!))].
  $

  #claim[
    $
      abs(EE[sum_(k>=3) (theta X_1)^k/ (k!)]) = o(abs(theta)^(2)) quad "as" n-> oo.
    $

  ]

  #proof[
    Let $abs(theta) < (delta)/(2)$.
    $
      abs(EE[sum_(k>=3) (theta X_1)^k/ (k!)]) & <= EE[sum_(k>=3) abs(theta)^k abs(X_1)^k/ (k!)] \
                                              & = EE[abs(theta X_1)^3 sum_(k>=0) abs(theta X_1)^k/((k+3)!)] \
                                              & <= EE[abs(theta X_1)^3 ee^(abs(theta X_1))] \
                                              & <= EE[abs(theta X_1)^3 ee^((delta)/(2) abs(X_1))]. \
    $
    However,
    $
      abs(theta X_1)^3 = abs(theta)^3 abs((delta)/(2) X_1)^(3)/(3!) dot 3!/((delta)/(2))^3 <= C dot abs(theta)^3 ee^((delta)/(2) abs(X_1))
    $
    where $C = 3! dot 2^(3)/delta^3$. So
    $
      EE[abs(theta X_1)^3 ee^((delta)/(2) abs(X_1))] & <= C dot abs(theta)^3 EE[ee^(delta abs(X_1))] \
                                                     & <= C dot abs(theta)^3 (EE[ee^(delta X_1)] + EE[-ee^(delta X_1)]) < oo.
    $
    So
    $
      abs(EE[sum_(k>=3) (theta X_1)^k/ (k!)]) <= C' dot abs(theta)^3 = o(abs(theta)^2) quad "as" theta -> 0
    $
    where $C' = C (EE[ee^(delta X_1)] + EE[-ee^(delta X_1)])$.
  ]

  Then we can conclude, because
  $
    m((theta)/(sqrt(n) )) = 1 + (theta^2)/(2n) + o((theta^2)/(n)) quad "as" n->oo,
  $
  and hence
  $
    (m((theta)/(sqrt(n) )))^n -> exp(theta^2/2) quad "as" n->oo.
  $
]

#corollary[
  Let $X_1, X_2, ...$ be i.i.d. #ponder("probability.random-variable")[random variables] with mean $mu = EE[X_i] < oo$ and #ponder("probability.variance")[variance] $sigma^2 = "Var"(X_i) < oo$. Set $S_n = X_1 + ... + X_n$. Then
  $
    S_n approx N(n mu, n sigma^2) quad "for large" n.
  $
] <cor-clt-normal-approximation>

#example[
  - Suppose $S_n ~ "Bin"(n, p)$. Then $S_n = X_1 + ... + X_n$ where $X_i$ are i.i.d. with $X_i ~ "Ber"(p)$. So
    $
      (S_n - n p)/(sqrt(n p (1-p))) stretch(->)^((d))_(n->oo) N(0, 1).
    $
    Therefore, for large $n$,
    $
      S_n approx N(n p, n p (1-p)).
    $

  - Suppose $S_n ~ "Bin"(n, (lambda)/(n))$ with $lambda > 0$. Then
    $
      PP(S_n = x) stretch(->)_(n->oo) PP("Poi"(lambda) = x) quad forall x in NN.
    $

  - We can approximate #ponder("probability.poisson-distribution")[Poisson distribution] with #ponder("probability.normal-distribution")[normal distribution]. Suppose $S_n ~ "Poi"(n)$ with $n > 0$. Then $S_n = X_1 + ... +X_n$ where $X_i$ are i.i.d. with $X_i ~ "Poi"(1)$. So
    $
      (S_n - n)/(sqrt(n)) stretch(->)^((d))_(n->oo) N(0, 1).
    $
    Therefore, for large $n$,
    $
      S_n approx N(n, n).
    $

] <example-clt-approximations>

#lecture-separator(lecture: 24, date: "2026-03-18")

=== Sampling Error via the CLT

Suppose we hold a referendum and a proportion $p$  of individuals is inclined to write "Yes". #fade[[Every individual writes "Yes" with probability $p$ and "No" with probability $1-p$.]] We wish to estimate $p$.

Sample $N$ individuals at random (for a large $N$) and record their votes. Let $X_i$ be $1$ if the $i$-th individual voted "Yes" and $0$ otherwise.

Let $S_N = X_1 + ... + X_N$ be the number of "Yes" votes. Then by @thm-strong-law-of-large-numbers[SLLN],
$
  hat(p)_N := S_(N)/(N) stretch(->)_(N->oo)^"almost surely" p
$
We have $S_N ~ "Bin"(N, p)$.


We need to testimate $p$ with an accuracy of $plus.minus 4 percent$ with probability $>= 0.99$. We now wish to consider how large should $N$ be.

By @thm-central-limit-theorem[Central Limit Theorem],
$
  S_N approx N p + sqrt(N p (1-p)) Z
$
where $Z ~ N(0, 1)$ for large $N$. Then we want to find $N$ such that
$
  PP(abs(hat(p)_N - p) <= 0.04) <= 0.01.
$
Note that for large $N$,
$
  hat(p)_N = S_N/N approx p + sqrt((p (1-p))/N) Z.
$
Hence
$
  abs(hat(p)_N - p) approx sqrt((p (1-p))/N) abs(Z).
$
Since we have $PP(abs(Z) >= z) = 2 (1- Phi(z))$ and that $PP(abs(Z) >= 2.58) = 0.01$ by standard tables, we requrie
$
  sqrt(N)/(sqrt(p (1-p)) ) dot 0.04 >= 2.58
$
Since $sqrt(p (1-p)) <= (1)/(2)$, taking $N = 1040$ is sufficient.

== Simulation of Random Variables

Computers can generate random numbers between $0$ to $1$. We would like to extend this to general probability distributions beyond #ponder("probability.uniform-distribution")[uniform distributions].

#example[

  Suppose $X$ is a #ponder("probability.random-variable")[random variable] with #ponder("probability.distribution-function")[probability distribution function] $F(x) = PP(X <= x)$. Suppose that we know how to simulate $U ~ U[0, 1]$.

  - Assume that $F$ is 1-1.

    Let $X = F^(-1)(U)$. Then

    $
      PP(X<=x) = PP(F^(-1)(U) <= x) = PP(U <= F(x)) = F(x).
    $

  - If $F$ is not 1-1, then define its generalised inverse $G(u) = inf {x in RR: u <= F(x)}$. Then let $X = F^(-1)(U)$. We can show that $PP(X <= x) = F(x)$ as well.

    #claim[
      $G(u) <= x$ iff $u <= F(x).$
    ]

    #proof[
      #fade[[$arrow.l.double$]] This follows by definition.

      #fade[[$=>$]] $exists (x_n) >= G(u)$ such that $x_n$ decreases to $G(u)$ and $u <= F(x_n)$. By the right continuity of $F$,
      $
        lim_(n->oo) F(x_n) = F(G(u)).
      $
      So $u <= F(G(u))$. Therefore, if $G(u) <= x$, then $u <= F(G(u)) <= F(x)$ becuase $F$ is increasing.

    ]

    Let $X = G(U)$. Then
    $
      PP(X<= x) = PP(G(U) <= x) = PP(U <= F(x)) = F(x).
    $
] <example-inverse-transform-sampling>

=== Box-Muller Transform

We want to simulate $X, Y$ #ponder("probability.independence-of-random-variables")[independent] with $X, Y ~ N(0, 1)$ using two #ponder("probability.independence-of-random-variables")[independent] $U[0, 1]$. Since
$
  F(x) = integral_(-oo)^x ee^(-(t^2)/(2))/(sqrt(2ppi) ) dif t,
$
there is no closed form solution. However, recall @example-polar-coordinates.

Let $U, V ~ U[0, 1]$ be #ponder("probability.independence-of-random-variables")[independent]. Then let
$
  Theta & = 2ppi U ~ U[0, 2ppi] \
      R & = sqrt(- 2 log V) \
$
We get
$
  PP(R>=r) = PP(sqrt(-2 log V) >= r) = PP(V <= ee^(-(r^2)/(2))) & = ee^(-(r^2)/(2))
$

and hence $R$ has the correct #ponder("probability.probability-density-function")[density]. Using the transformation in @example-polar-coordinates, we get $X, Y$:
$
  X & = R cos Theta = sqrt(-2 log V) cos(2ppi U) \
  Y & = R sin Theta = sqrt(-2 log V) sin(2ppi U).
$

== Rejection Sampling

Suppose we have a #ponder("probability.random-variable")[random variable] $X$ with #ponder("probability.probability-density-function")[density]
$
  f(bold(x)) = (bb(1)(bold(x) in A))/(abs(A))
$
where $abs(A)$ is the volume of $A subset.eq [0, 1]^d$.

Let $(U_(k, n))_(k = 1, ..., d, n in NN)$ be i.i.d. with $U_(k, n) ~ U[0, 1]$.

Set $bold(U_n) = (U_(1, n), ..., U_(d, n)) ~ U([0, 1]^d)$. Let
$
  N = min{n : bold(U_n) in A}, quad bold(X) = bold(U_N).
$

We want to show that $forall B subset.eq [0, 1]^d$,
$
  integral_B f(bold(x)) dif bold(x) = PP(bold(X) in B) = abs(B inter A)/(abs(A)).
$

Note that
$
  PP(bold(X) in B) = PP(bold(U_N) in B) &= sum_(n=1)^oo PP(bold(U_n) in B, N in n)\
  &= sum_(n=1)^oo PP(bold(U_n) in B, bold(U_n) in A, bold(U_(n-1)) in.not A, ..., bold(U_1) in.not A) \
  &= sum_(n=1)^oo PP(bold(U_n) in B inter A) PP(bold(U_1) in.not A)^(n-1) \
  &= sum_(n=1)^oo abs(B inter A) (1 - abs(A))^(n-1) = abs(B inter A)/(abs(A)).
$



