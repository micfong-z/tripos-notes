#import "../prelude.typ": *

= #ponder("probability.continuous-random-variable")[Continuous Random Variables]

== #ponder("probability.distribution-function")[Probability Distribution Function]

Consider a #ponder("probability.probability-space")[probability space] $(Omega, cal(F), PP)$. Recall that a #ponder("probability.random-variable")[random variable] is a function
$
  X: omega -> RR
$
where $forall x in RR$, the set $X^(-1)({x}) = {X <= x} = {omega in Omega : X(omega) = x}$ is an #ponder("probability.outcomes-and-events")[event] in $cal(F)$.

Recall @def-probability-distribution-function[Definition of Probability Distribution Function]. Let $F(x)$ be the #ponder("probability.distribution-function")[probability distribution function] of $X$. We have the following properties of $F$:

#proposition[Properties of #ponder("probability.distribution-function")[Probability Distribution Function]][
  Let $F$ be the #ponder("probability.distribution-function")[probability distribution function] of a #ponder("probability.random-variable")[random variable] $X$. Then, we have the following properties:

  1. $F$ is increasing, i.e. $F(x) <= F(y)$ for all $x <= y$.

  2. For all $a, b in RR$ with $a < b$, we have
    $ PP(a < X <= b) = F(b) - F(a). $

  3. $F$ is right-continuous and $F$ always has left limits, i.e. for all $x in RR$, we have
    $
      F(x^-) = lim_(y -> x^-) F(y) <= F(x)\
      F(x^+) = lim_(y -> x^+) F(y) = F(x).
    $
  4. $F(x^-) = PP(X < x)$.

  5. $F(-oo) = 0$ and $F(oo) = 1$.
]

#lecture-separator(lecture: 15, date: "2026-02-25")

#proof[

  For (2), we have
  $
    PP(a < X <= b) & = PP(X <= b, X > a) \
                   & = PP(X <= b) - PP(X<=b, X<=a) & quad "by the law of total probability" \
                   & = F(b) - PP(X<=a)             &                     quad "since" a < b \
                   & = F(b) - F(a).
  $

  #separator

  For (3), let $(x_n)$ be a decreasing sequence with $x_n -> x$. Then, we want to show that $F(x_n) -> F(x)$. Define
  $
    A_n = {x < X <= x_n}
  $
  so
  $
    PP(A_n) = F(x_n) - F(x).
  $
  Note that $A_(n+1) subset.eq A_n$, and hence $PP(A_n) -> PP(inter.big_n A_n)$ by the #ponder("probability.continuity-of-probability-measures")[continuity of probability measures].

  Now, we have $inter.big_n A_n = {x < X <= x} = emptyset$, so $PP(inter.big_n A_n) = 0$. Therefore, $F(x_n) -> F(x)$.

  Since $F$ is increasing, left limits always exist, and so $F(x^-) = lim_(y -> x^-) F(y) <= F(x)$.

  #separator

  For (4), consider
  $
    F(x^-) = lim_(n->oo) F(x - (1)/(n)).
  $
  Define $B_n = {X <= x - 1/n}$. Then we have $B_n subset.eq B_(n+1)$. Hence
  $
    PP(B_n) -> PP(union.big_n B_n) = PP(X < x) = F(x^-).
  $
]

#definition[Continuous Random Variable][
  A #ponder("probability.random-variable")[random variable] $X$ is said to be #ponder("probability.continuous-random-variable")[*continuous*] if its #ponder("probability.distribution-function")[probability distribution function] $F$ is continuous. Equivalently, for all $x in RR$,
  $
                F(x^-) & = F(x) \
    <=> quad PP(X < x) & = PP(X <= x) \
    <=> quad PP(X = x) & = 0.
  $
] <def-continuous-random-variable>

For the purpose of this course, we will only consider #ponder("probability.continuous-random-variable")[continuous random variables] whose PDF is differentiable. These are also known as *absolutely continuous* random variables.

#definition[Probability Density Function][
  Let $X$ be a #ponder("probability.continuous-random-variable")[continuous random variable] with #ponder("probability.distribution-function")[probability distribution function] $F$. If $F$ is differentiable, then the #ponder("probability.probability-density-function")[*probability density function*] $f$ of $X$ is defined as
  $
    f(x) = F'(x).
  $
] <def-probability-density-function>

#proposition[Properties of #ponder("probability.probability-density-function")[Probability Density Function]][
  Let $X$ be a #ponder("probability.continuous-random-variable")[continuous random variable] with #ponder("probability.probability-density-function")[probability density function] $f$. Then, we have the following properties:

  1. $f(x) >= 0$ for all $x in RR$.

  2. $integral_( - oo)^(oo) f(x) dif x = 1$.

  3. $F(x) = integral_(-oo)^x f(t) dif t$ for all $x in RR$. More generally, for every $A subset.eq RR$,
    $
      PP(X in A) = integral_A f(x) dif x.
    $

    #fade[[If $X$ is discrete, then $PP(X in A) = sum_(x in A) PP(X = x)$, so the above formula can be seen as a continuous analogue of the discrete case.]]
]

Intuitively, $f$ can be thought as being proportional to the probability that $X$ takes values around $x$. Mathematically, for $Delta x$ small, we have
$
  PP(x < X <= x + Delta x) = integral_x^(x + Delta x) f(t) dif t approx f(x) Delta x.
$

== #ponder("probability.uniform-distribution")[Uniform Distribution]

#definition[Uniform Distribution][
  A #ponder("probability.uniform-distribution")[*uniform distribution*] on $[a, b]$ is a #ponder("probability.continuous-random-variable")[continuous random variable] $X$, denoted $U[a, b]$, with #ponder("probability.probability-density-function")[probability density function]
  $
    f(x) = cases(
      (1)/(b - a) & quad x in [a, b],
      0 & quad "otherwise"
    )
  $

  #prooflike("Proof of density validity")[
    We have
    $
      integral_(-oo)^(oo) f(x) dif x & = integral_a^b (1)/(b - a) dif x \
                                     & = (1)/(b - a) integral_a^b dif x \
                                     & = (1)/(b - a) (b - a) \
                                     & = 1.
    $
  ]
] <def-uniform-distribution>

Suppose $X ~ U[a, b]$. Then for every $x in [a, b]$,
$
  PP(X <= x) = integral_(-oo)^x f(t) dif t = (x-a)/(b-a)
$
Otherwise, if $x > b$, then $PP(X <= x) = 1$, and if $x < a$, then $PP(X <= x) = 0$.

Note that for $U[0, 1]$, we have $PP(X <= x) = x$ for all $x in [0, 1]$.


== #ponder("probability.exponential-distribution")[Exponential Distribution]

#definition[Exponential Distribution][
  An #ponder("probability.exponential-distribution")[*exponential distribution*] with parameter $lambda > 0$ is a #ponder("probability.continuous-random-variable")[continuous random variable] $X$, denoted $"Exp"(lambda)$, with #ponder("probability.probability-density-function")[probability density function]
  $
    f(x) = cases(
      lambda ee^(-lambda x) & quad x >= 0,
      0 & quad "otherwise"
    )
  $
  #prooflike("Proof of density validity")[
    We have
    $
      integral_(-oo)^(oo) f(x) dif x & = integral_0^(oo) lambda ee^(-lambda x) dif x \
                                     & = lambda integral_0^(oo) ee^(-lambda x) dif x \
                                     & = [lambda (-1/lambda) ee^(-lambda x)]_(0)^(oo) \
                                     & = 1.
    $
  ]
] <def-exponential-distribution>

Suppose $X ~ "Exp"(lambda)$. Then for every $x >= 0$,
$
  PP(X <= x) & = integral_(-oo)^x f(t) dif t = 1 - ee^(-lambda x) \
  PP(X >= x) & = 1 - PP(X < x) = ee^(-lambda x).
$

#remark[
  Let $T ~ "Exp"(lambda)$, and $T_n = floor(n T)$ with $n in NN$. Then, for every $k in NN$,
  $
    PP(T_n >= k) = PP(n T >= k) = PP(T >= k/n) = (ee^(-lambda/n))^k. \
  $
  Note that $T_n$ is a #ponder("probability.geometric-distribution")[geometric random variable] with parameter $p = 1 - ee^(-lambda/n)$. As $n->oo$, $p approx (lambda)/(n)$.

  Hence, $T_n / n$ converges in distribution to $T$ as $n -> oo$. So, we can think of an #ponder("probability.exponential-distribution")[exponential distribution] as a continuous analogue of a #ponder("probability.geometric-distribution")[geometric distribution].
]

#proposition[#ponder("probability.memoryless-property")[Memoryless Property] of the #ponder("probability.exponential-distribution")[Exponential Distribution]][
  Let $T ~ "Exp"(lambda)$ with $lambda > 0$. Let $s, t in RR_+$. Then
  $
    PP(T >= s + t mid(|) T >= s) & = PP(T >= s + t, T >= s) / PP(T >= s) \
                                 & = PP(T >= s + t) / PP(T >= s) \
                                 & = (ee^(-lambda(s + t))) / (ee^(-lambda s)) \
                                 & = ee^(-lambda t) \
                                 & = PP(T >= t).
  $
] <prop-memoryless-exponential>

It is significant that the #ponder("probability.exponential-distribution")[exponential distribution] is the only continuous distribution with the #ponder("probability.memoryless-property")[memoryless property].

#theorem[
  Let $T$ be a positive #ponder("probability.random-variable")[random variable] which is not identically zero or $oo$. Then $T$ has the #ponder("probability.exponential-distribution")[exponential distribution] iff $T$ has the #ponder("probability.memoryless-property")[memoryless property], i.e. for all $s, t in RR_+$,
  $
    PP(T >= s + t mid(|) T >= s) = PP(T >= t).
  $
]

#proof[

  #fade[[$=>$]] This is shown in @prop-memoryless-exponential[Memoryless Property of the Exponential Distribution].

  #fade[[$arrow.l.double$]] Suppose that $T$ has the #ponder("probability.memoryless-property")[memoryless property]. Let $t in RR_+$ and
  $
    g(t) = PP(T >= t).
  $
  Then $g(t+s) = g(t) g(s)$. For every $m in NN$, $g(m t) = (g(t))^m$.

  In particular, when $t = 1$, we have $g(m) = (g(1))^m$.

  Let $g(1) = PP(T >= 1) = ee^(-lambda)$. We have
  $
    lambda = -log PP(T >= 1),
  $
  and so $g(m) = ee^(-lambda m)$.

  By our definition, for any $m, n in NN$,
  $
    (g((m)/(n)))^n = g(m) = ee^(-lambda m),
  $
  so $g((m)/(n)) = ee^(-(lambda m)/(n))$. Therefore, $g(r) = ee^(-lambda r)$ for all $r in QQ_+$. We shall extend this to $RR_+$.

  Let $t > 0$, and $r, s in QQ_+$ such that $s < t < r$ and $r - s <= epsilon$. Then
  $
    ee^(-lambda r) = g(r) <= g(t) <= g(s) = ee^(-lambda s).
  $
  Taking $epsilon -> 0$, we have $g(t) = ee^(-lambda t)$.
]

#lecture-separator(lecture: 16, date: "2026-02-27")

== #ponder("probability.expectation")[Expectation] and #ponder("probability.variance")[Variance] of a #ponder("probability.continuous-random-variable")[Continuous Random Variable]

#definition[#ponder("probability.expectation")[Expectation] of a #ponder("probability.continuous-random-variable")[Continuous Random Variable]][
  Let $X$ be a #ponder("probability.continuous-random-variable")[continuous random variable] with #ponder("probability.probability-density-function")[density] $f$ with $X >= 0$. The #ponder("probability.expectation")[*expectation*] of $X$ is defined as
  $
    EE[X] = integral_(0)^(oo) x f(x) dif x.
  $
  Let $g$ be a non-negative function on $RR$. Then, we define
  $
    EE[g(X)] = integral_(-oo)^(oo) g(x) f(x) dif x.
  $

  For a general #ponder("probability.random-variable")[random variable] $X$, define $X_+ = max(X, 0)$ and $X_- = max(-X, 0)$. Then, $X = X_+ - X_-$.
  If $EE[X_+] < oo$ or $EE[X_-] < oo$, then we define
  $
    EE[X] = EE[X_+] - EE[X_-] = integral_(-oo)^(oo) x f(x) dif x.
  $
]

#remark[
  As in the discrete case, we have
  $
    EE[sum_(i=1)^n a_i X_i] = sum_(i=1)^n a_i EE[X_i].
  $

]

#lemma[
  If $X$ is a #ponder("probability.continuous-random-variable")[continuous random variable] with $X >= 0$, then
  $
    EE[X] = integral_0^(oo) PP(X >= x) dif x.
  $
]

#proof[
  We have
  $
    EE[X] & = integral_0^oo x f(x) dif x \
          & = integral_0^oo (integral_0^x dif t) f(x) dif x \
          & = integral_0^oo (integral_t^(oo) f(x) dif x) dif t \
          & = integral_0^oo (1 - F(t)) dif t \
          & = integral_0^oo PP(X >= t) dif t.
  $
]

Recall that in the discrete case, we have
$
  X = sum_(n=1)^oo bb(1)(X >= n).
$

#lemma[
  If $X$ is a #ponder("probability.continuous-random-variable")[continuous random variable] with $X >= 0$, then for any #ponder("probability.outcomes-and-events")[outcome] $omega$,
  $
    X(omega) & = integral_0^(oo) bb(1)(X(omega) >= x) dif x, \
       EE[X] & = EE[integral_0^(oo) bb(1)(X >= x) dif x] = integral_0^(oo) PP(X >= x) dif x.
  $
]

#definition[#ponder("probability.variance")[Variance] of a #ponder("probability.continuous-random-variable")[Continuous Random Variable]][
  Let $X$ be a #ponder("probability.continuous-random-variable")[continuous random variable] with $EE[X^2] < oo$. The #ponder("probability.variance")[*variance*] of $X$ is defined as
  $
    "Var"(X) = EE[(X - EE[X])^2] = EE[X^2] - (EE[X])^2.
  $
]

#example[
  1. Consider $X ~ U[a, b]$. Then the #ponder("probability.probability-density-function")[density] $f$ of $X$ is given by
    $
      f = cases(
        (1)/(b - a) & quad x in [a, b],
        0 & quad "otherwise"
      )
    $
    Hence
    $
      EE[X] & = integral_(-oo)^(oo) x f(x) dif x = (a + b)/(2).
    $

  2. Consider $X ~ "Exp"(lambda)$. Then for $lambda > 0$, $f(x) = lambda ee^(-lambda x)$ and $x > 0$. Hence
    $
      EE[X] & = integral_0^(oo) x lambda ee^(-lambda x) dif x \
            & = integral_0^(oo) PP(X >= x) dif x \
            & = integral_0^(oo) ee^(-lambda x) dif x \
            & = (1)/(lambda).
    $
]

== #ponder("probability.normal-distribution")[Normal Distribution]

=== Introduction

#definition[Normal Distribution][
  An #ponder("probability.normal-distribution")[*normal distribution*] with parameters $-oo < mu < oo$ and $sigma in RR_+$ is a #ponder("probability.continuous-random-variable")[continuous random variable] $X$, denoted $N(mu, sigma^2)$, with #ponder("probability.probability-density-function")[probability density function]

  $
    f(x) = 1/sqrt(2 ppi sigma^2) exp(- (x-mu)^(2)/(2sigma^2)).
  $

  #prooflike("Proof of density validity")[
    We have
    $
      I & = integral_(-oo)^(oo) f(x) dif x \
        & = integral_(-oo)^(oo) (1/sqrt(2 ppi sigma^2)) exp(- (x-mu)^(2)/(2sigma^2)) dif x \
        & = integral_(-oo)^(oo) (1/sqrt(2 ppi)) exp(- u^(2)/(2)) dif u                     & quad "with" u = (x - mu)/(sigma) \
        & = 2 integral_0^oo (1/sqrt(2 ppi)) exp(- u^(2)/(2)) dif u \
    $
    Consider $I^2$. We have
    $
      I^2 & = (2)/(ppi) integral_0^oo integral_0^oo exp(-u^2/2) exp(- v^2/2) dif u dif v \
    $
    Changing to polar coordintates with $u = r cos(theta)$ and $v = r sin(theta)$, we have
    $
      I^2 & = (2)/(ppi) integral_0^(ppi/2) r ee^(-r^(2)/2) dif theta dif r \
          & = integral_0^(oo) r ee^(-r^(2)/2) dif r \
          & = [- ee^(-r^(2)/2)]_0^(oo) \
          & = 1.
    $
    Since $I > 0$, we have $I = 1$. Hence, $f$ is a valid probability density function.
  ]
] <def-normal-distribution>

#proposition[
  Let $X ~ N(mu, sigma^2)$ with $-oo < mu < oo$ and $sigma in RR_+$. Then
  $
    EE[X] = mu, quad "Var"(X) = sigma^2.
  $
]
#proof[
  We have
  $
    EE[X] & = integral_(-oo)^(oo) x f(x) dif x \
    & = integral_(-oo)^(oo) (x-mu) 1/sqrt(2 ppi sigma^2) exp(- (x-mu)^(2)/(2sigma^2)) dif x + underbracket(integral_(-oo)^(oo) mu 1/sqrt(2 ppi sigma^2) exp(- (x-mu)^(2)/(2sigma^2)) dif x, mu integral_(-oo)^oo f(x) dif x = mu) \
    &= integral_(-oo)^(oo) u/sqrt(2 ppi sigma^2) exp(- u^(2)/(2sigma^2)) dif x + mu & quad "with" u = x - mu \
    & = mu. &quad "the integrand is odd"
  $
  Hence, $EE[X] = mu$. Moreover,
  $
    "Var"(X) &= EE[(X - mu)^2] \
    & = integral_(-oo)^(oo) (x - mu)^2 1/sqrt(2 ppi sigma^2) exp(- (x-mu)^(2)/(2sigma^2)) dif x \
    & = integral_(-oo)^(oo) sigma^2 u^2 1/sqrt(2 ppi sigma^2) exp(- u^(2)/(2)) dif u & quad "with" u = (x - mu)/(sigma) \
    & = sigma^2.
  $
  Hence $"Var"(X) = sigma^2$.
]

=== Linear Transformations of #ponder("probability.normal-distribution")[Normal Distributions]

#theorem[
  Let $X$ have #ponder("probability.probability-density-function")[density] $f$, and let $g$ be a function which is strictly monotone and $g^(-1)$ is differentiable. Then $g(X)$ has #ponder("probability.probability-density-function")[density]
  $
    f(g^(-1)(x)) dot abs((g^(-1))'(x)).
  $
] <thm-change-of-variables-monotone>

#proof[
  - Suppose that $g$ is strictly increasing. Then
    $
                      PP(g(X) <= x) & = PP(X <= g^(-1)(x)) \
                                    & = F(g^(-1)(x)) \
      (dif)/(dif x) (PP(g(X) <= x)) & = f(g^(-1)(x)) dot (g^(-1))'(x) \
    $

  - Suppose that $g$ is strictly decreasing. Then
    $
                      PP(g(X) <= x) & = PP(X >= g^(-1)(x)) \
                                    & = 1 - PP(X < g^(-1)(x)) \
      (dif)/(dif x) (PP(g(X) <= x)) & = - f(g^(-1)(x)) dot (g^(-1))'(x) \
    $

  Hence the result follows in either case.
]

#proposition[Linear Transformations of #ponder("probability.normal-distribution")[Normal Distributions]][
  Let $X ~ N(mu, sigma^2)$ with $-oo < mu < oo$ and $sigma in RR_+$. Let $a, b in RR$ with $a != 0$. Then
  $
    a X + b ~ N(a mu + b, (a sigma)^2).
  $
]

#proof[
  Define $g(x) = a x + b$ and $Y = g(X)$. We have $g^(-1)(x) = (x - b)/(a)$ and $(g^(-1))'(x) = 1/a$. Hence,
  $
    f_Y (y) & = f_X (g^(-1)(y)) dot abs((g^(-1))'(y)) \
            & = 1/sqrt(2 ppi sigma^2) exp(- ((y - b)/a - mu)^(2)/(2sigma^2)) dot 1/abs(a) \
            & = (1)/(sqrt(2 ppi a^2 sigma^2)) exp(- (y - (a mu + b))^(2)/(2 a^2 sigma^2)). \
  $
  So $Y ~ N(a mu + b, (a sigma)^2)$.
]
#remark[
  If $X ~ N(mu, sigma^2)$, then
  $
    Z = (X - mu)/(sigma) ~ N(0, 1).
  $
]

#example[
  Let $X ~ N(mu, sigma^2)$, and consider
  $
    PP(-2 sigma <X - mu < 2 sigma) = PP(-2 < (X-mu)/(sigma) < 2).
  $
  Let
  $
    Phi(x) = integral_(-oo)^x (1)/(sqrt(2ppi) ) exp(- u^(2)/(2)) dif u & = PP(Z <= x). \
  $
  Note that
  $
                 phi(x) & = Phi'(x) = (1)/(sqrt(2ppi) ) ee^(-(x^2)/(2)) \
    (Phi(x) + Phi(-x))' & = 0.
  $
  Since $Phi(0) = (1)/(2)$, we have $Phi(x) + Phi(-x) = 1$. Hence,
  $
    PP(X <= x) + PP(X <= -x) = 1.
  $
  We have existing tables of $Phi$ values, so we can compute $PP(X <= x)$ for any $x$, in particular,
  $
    PP(-2 sigma <X - mu < 2 sigma) = PP(-2 < Z < 2) = Phi(2) - Phi(-2) = 2 Phi(2) - 1 > 0.95.
  $
]

#lecture-separator(lecture: 17, date: "2026-03-02")

#definition[Median][
  Let $X$ be a #ponder("probability.continuous-random-variable")[continuous random variable]. The #ponder("probability.median")[median] of $X$, denoted by $m$, is the value such that
  $
    PP(X >= m) = PP(X <= m) = (1)/(2).
  $

  Alternatively,
  $
    integral_oo^m f(x) dif x = integral_m^(oo) f(x) dif x = (1)/(2)
  $
  where $f$ is the #ponder("probability.probability-density-function")[density] of $X$.
] <def-median>

#example[
  Suppose that $X ~ N(mu, sigma^2)$. Then
  $
    PP(X <= mu) = PP((X-mu)/(sigma) <= 0) = PP(N(0, 1) <= 0) = (1)/(2).
  $
  Hence the #ponder("probability.median")[median] of $X$ is $mu$.
]

== #ponder("probability.multivariate-density-function")[Multivariate Density Functions]

=== Introduction

#definition[Multivariate Density Function][
  Let $bold(X) = (X_1, ..., X_n)^tp$ be a #ponder("probability.multidimensional-random-variable")[random vector]. We say that $bold(X)$ has a #ponder("probability.multivariate-density-function")[*multivariate density function*] if there exists a non-negative function $f: RR^n -> RR$ such that for all $x_1, ..., x_n in RR$,
  $
    PP(X_1 <= x_1, ..., X_n <= x_n) = integral_(-oo)^(x_1) ... integral_(-oo)^(x_n) f(y_1, ..., y_n) dif y_n ... dif y_1.
  $

  The #ponder("probability.distribution-function")[*probability distribution function*] $F$ of $bold(X)$ is defined as
  $ F(x_1, ..., x_n) = PP(X_1 <= x_1, ..., X_n <= x_n). $

] <def-multivariate-density-function>
Therefore,
$
  f(x_1, ..., x_n) = (∂^n)/(∂ x_1 ... ∂ x_n) F(x_1, ..., x_n).
$
More generally, for $B subset.eq RR^n$,
$
  PP((X_1, ..., X_n)^tp in B) = integral_B f(y_1, ..., y_n) dif y_1 ... dif y_n.
$

#definition[#ponder("probability.independence-of-random-variables")[Independence] of #ponder("probability.continuous-random-variable")[Continuous Random Variables]][
  Let $X_1, ..., X_n$ be #ponder("probability.continuous-random-variable")[continuous random variables]. They are #ponder("probability.independence-of-random-variables")[*independent*] if for all $x_1, ..., x_n in RR$,
  $
    PP(X_1 <= x_1, ..., X_n <= x_n) = PP(X_1 <= x_1) ... PP(X_n <= x_n).
  $
]

#theorem[
  Let $bold(X) = (X_1, ..., X_n)^tp$ be a #ponder("probability.multidimensional-random-variable")[random vector] with #ponder("probability.probability-density-function")[density] $f$.

  1. Suppose $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent] with #ponder("probability.probability-density-function")[densities] $f_1, ..., f_n$, then for all $x_1, ..., x_n in RR$,
    $
      f(x_1, ..., x_n) = f_1 (x_1) ... f_n (x_n).
    $

  2. Conversely, suppose $f$ factorises as $f(x_1, ..., x_n) = f_1 (x_1) ... f_n (x_n)$ for some non-negative functions $f_1, ..., f_n$ on $RR$. Then $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent] with #ponder("probability.probability-density-function")[densities] proportional to $f_1, ..., f_n$.
] <thm-independence-multivariate-density>

#proof[

  1. We have
    $
      PP(X_1 <= x_1, ..., X_n <= x_n) & = PP(X_1 <= x_1) ... PP(X_n <= x_n) \
      & = (integral_(-oo)^(x_1) f_1(y_1) dif y_1) ... (integral_(-oo)^(x_n) f_n (y_n) dif y_n) \
      & = integral_(-oo)^(x_1) ... integral_(-oo)^(x_n) f_1(y_1) ... f_n (y_n) dif y_n ... dif y_1.
    $

    So $f(x_1, ..., x_n) = f_1 (x_1) ... f_n (x_n)$.

  2. We have
    $
      PP(X_1 <= x_1, ..., X_n <= x_n) & = integral_(-oo)^(x_1) ... integral_(-oo)^(x_n) f(y_1, ..., y_n) dif y_n ... dif y_1 \
      & = integral_(-oo)^(x_1) ... integral_(-oo)^(x_n) f_1 (y_1) ... f_n (y_n) dif y_n ... dif y_1 \
      & = (integral_(-oo)^(x_1) f_1 (y_1) dif y_1) ... (integral_(-oo)^(x_n) f_n (y_n) dif y_n).
    $

    Note that
    $
      integral_(-oo)^(oo) ... integral_(-oo)^(oo) f(y_1) ... f_n (y_n) dif y_n ... dif y_1 = 1.
    $
    Hence
    $
      PP(X_1 <= x_1, ..., X_n <= x_n) = (integral_(-oo)^x_1 f_1 (y_1) dif y_1)/(integral_(-oo)^(oo) f_1 (y_1) dif y_1) ... (integral_(-oo)^x_n f_n (y_n) dif y_n)/(integral_(-oo)^(oo) f_n (y_n) dif y_n).
    $
    So, $X_1, ..., X_n$ are independent with densities proportional to $f_1, ..., f_n$.
]

=== #ponder("probability.marginal-density-function")[Marginal Density Functions]

#definition[Marginal Density Function][
  Let $bold(X) = (X_1, ..., X_n)^tp$ be a #ponder("probability.multidimensional-random-variable")[random vector] with #ponder("probability.probability-density-function")[density] $f$. The #ponder("probability.marginal-density-function")[*marginal density function*] of $X_1$ is defined as
  $
    f_(X_1)(x) = integral_(-oo)^(oo) ... integral_(-oo)^(oo) f(x, x_2, ..., x_n) dif x_n ... dif x_2.
  $
] <def-marginal-density-function>
#proof[
  Suppose $bold(X) = (X_1, ..., X_n)^tp$ has #ponder("probability.probability-density-function")[density] $f$. Then consider
  $
    PP(X_1 <= x) & = PP(X_1 <= x, X_2 in RR, ..., X_n in RR) \
    & = integral_(-oo)^x (integral_(-oo)^(oo) ... integral_(-oo)^(oo) f(x_1, ..., x_n) dif x_n ... dif x_2) dif x_1. \
  $
  So the #ponder("probability.probability-density-function")[density] of $X_1$ is
  $
    f_(X_1)(x) = integral_(-oo)^(oo) ... integral_(-oo)^(oo) f(x, x_2, ..., x_n) dif x_n ... dif x_2.
  $
]

=== Sum of #ponder("probability.independence-of-random-variables")[Independent] Random Variables

Suppose $X$ and $Y$ are #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables] with #ponder("probability.probability-density-function")[densities] $f_X$ and $f_Y$ respectively. We want to find the #ponder("probability.probability-density-function")[density] of $X + Y$.

Recall that in the discrete case, we used the discrete convolution formula
$
  PP(X+Y = z) = sum_(x in RR) PP(X = x, Y = z - x).
$
For the continuous case, we have the following analogue of the discrete convolution formula.
$
  f_(X+Y) (z) = integral_(-oo)^(oo) f_X (x) f_Y (z - x) dif x.
$
#proof[
  We have
  $
    PP(X+Y <= z) & = PP((X, Y) in {(x, y) in RR^2 : x + y <= z})) \
                 & = integral_{x+y <= z} f_(X, Y) (x, y) dif x dif y \
                 & = integral_{x+y <= z} f_X (x) f_Y (y) dif x dif y \
                 & = integral_(-oo)^oo f_X (x) integral_(-oo)^(z-x) f_Y (y) dif y dif x \
                 & = integral_(-oo)^oo f_X (x) integral_(-oo)^z f_Y (y-x) dif y dif x \
                 & = integral_(-oo)^z integral_(-oo)^(oo) f_X (x) f_Y (y-x) dif x dif y, \
  $
  So the #ponder("probability.probability-density-function")[density] of $X + Y$ is given by the convolution formula
  $
    f_(X+Y) (z) = integral_(-oo)^(oo) f_X (x) f_Y (z - x) dif x.
  $
]

=== #ponder("probability.conditional-density-function")[Conditional Density Functions]


#definition[Conditional Density Function][
  Let $X$ and $Y$ be two #ponder("probability.random-variable")[random variables] with #ponder("probability.multivariate-density-function")[joint density] $f_(X, Y)$ and #ponder("probability.marginal-density-function")[marginal densities] $f_X$ and $f_Y$ respectively.

  The #ponder("probability.conditional-density-function")[*conditional density function*] of $X$ given $Y=y$ is defined as
  $
    f_(X mid(|) Y) (x mid(|) y) = (f(X, Y) (x, y)) / (f_Y (y)) quad "for" f_Y (y) > 0.
  $

] <def-conditional-density-function>

#proposition[#ponder("probability.law-of-total-probability")[Law of Total Probability] for #ponder("probability.continuous-random-variable")[Continuous Random Variables]][
  Let $X$ and $Y$ be two #ponder("probability.random-variable")[random variables] with #ponder("probability.multivariate-density-function")[joint density] $f_(X, Y)$ and #ponder("probability.marginal-density-function")[marginal densities] $f_X$ and $f_Y$ respectively. Then, for every $x in RR$,
  $
    f_X (x) = integral_(-oo)^oo f_(X, Y)(x, y) dif y = integral_(-oo)^(oo) f_(X mid(|) Y) (x mid(|) y) f_Y (y) dif y.
  $
]

Similarly, we can define the #ponder("probability.conditional-expectation")[*conditional expectation*] of $X$ given $Y$.

#definition[#ponder("probability.conditional-expectation")[Conditional Expectation] of a #ponder("probability.continuous-random-variable")[Continuous Random Variable]][
  The #ponder("probability.conditional-expectation")[*conditional expectation*] of $X$ given $Y$ is defined as $EE[X mid(|)Y] = g(Y)$, where
  $
    g(y) = integral_(-oo)^(oo) x f_(X mid(|) Y) (x mid(|) y) dif x.
  $
]

=== #ponder("probability.change-of-variables")[Transformation of Random Variables]

#theorem[
  Let $bold(X)$ be a #ponder("probability.random-variable")[random variable] with values in $D subset.eq RR^n$ and #ponder("probability.probability-density-function")[density] $f$. Let $g: D -> g(D)$ be a bijection with a continuous derivative on $D$, and
  $
    det g'(bold(x)) != 0 quad "for all" bold(x) in D.
  $
  Then, the #ponder("probability.random-variable")[random variable] $Y = g(bold(X))$ has #ponder("probability.probability-density-function")[density]
  $
    f_Y (bold(y)) = f_X (g^(-1) (bold(y))) dot abs(J)
  $
  where $J = det (((∂ x_i)/(∂ y_j))_(i, j = 1)^n)$ is the Jacobian determinant of $g^(-1)$.
] <thm-change-of-variables-jacobian>

#lecture-separator(lecture: 18, date: "2026-03-04")

#example[
  Let $X, Y ~ N(0, 1)$ be #ponder("probability.independence-of-random-variables")[independent]. Then, consider $(R, Theta)$ in polar coordinates with $R = sqrt(X^2 + Y^2)$ and $Theta = arctan(Y/X)$. We have
  $
    X & = R cos Theta \
    Y & = R sin Theta.
  $
  We want to find the #ponder("probability.probability-density-function")[density] of $(R, Theta)$. We have
  $
    f_(R, Theta) (r, theta) = f_(X, Y) (r cos theta, r sin theta) dot abs(det matbold(J))
  $
  where
  $
    matbold(J) = mat(cos theta, -r sin theta; sin theta, r cos theta)
  $
  and $det matbold(J) = r$. Hence,
  $
    f_(R, Theta) (r, theta) & = f_X (r cos theta) dot f_Y (r sin theta) dot r \
    & = (1)/sqrt(2 ppi) exp(-(r^2 cos^2 theta)/(2)) dot (1)/sqrt(2 ppi)exp(-(r^2 sin^2 theta)/(2)) dot r \
    & = (1)/(2 ppi) ee^(-(r^2)/(2)) dot r
  $
  where $r >= 0$ and $theta in [0, 2 ppi]$.

  Hence, $Theta ~ U[0, 2 ppi]$ and $R$ has #ponder("probability.probability-density-function")[density] $f_R (r) = r ee^(-(r^2)/(2))$ for $r >= 0$, and they are #ponder("probability.independence-of-random-variables")[independent], by @thm-independence-multivariate-density (2).
] <example-polar-coordinates>

== #ponder("probability.order-statistics")[Order Statistics] of a Random Sample

#definition[Order Statistics][
  Let $X_1, ..., X_n$ be i.i.d. #ponder("probability.random-variable")[random variables] with #ponder("probability.distribution-function")[probability distribution function] $F$ and #ponder("probability.probability-density-function")[density] $f$. Order them from the smallest to the largest as
  $
    X_((1)) <= X_((2)) <= ... <= X_((n)).
  $
  Lete $Y_i = X_((i))$. Then, $Y_1, ..., Y_n$ are called the #ponder("probability.order-statistics")[*order statistics*] of the random sample $X_1, ..., X_n$.
] <def-order-statistics>

We aim to find the #ponder("probability.probability-density-function")[density] of $(Y_1, ..., Y_n)$. For the minimum $Y_1$, we have
$
  PP(Y_1 <= x) & = 1- PP(Y_1 > x) \
               & = 1 - PP(X_1 > x, ..., X_n > x) \
               & = 1 - (1 - F(x))^n \
   f_(Y_1) (x) & = (dif)/(dif x) PP(Y_1 <= x) = n (1 - F(x))^(n-1) f(x).
$
For the maximum $Y_n$, we have
$
  PP(Y_n <= x) & = PP(X_1 <= x)^n = (F(x))^n \
   f_(Y_n) (x) & = (dif)/(dif x) PP(Y_n <= x) = n (F(x))^(n-1) f(x).
$

In order to find $f_(Y_1, ..., Y_n) (x_1, ..., x_n)$ with $x_1 < x_2< ... < x_n$, we have
$
  PP(Y_1 <= x_1, ..., Y_n <= x_n) & = n! PP(X_1 <= x_1, ..., X_n <= x_n, X_1 <= X_2 <= ... <= X_n)\
  &= n! integral ... integral f_(X_1, ..., X_n)^tp (u_1, ..., u_n) bb(1)(u_1 <= x_1, ..., u_n <= x_n, u_1 <= u_2 <= ... <= u_n) dif u_n ... dif u_1 \
  &= n! integral_(-oo)^(x_1) integral_(u_1)^(x_2) ... integral_(u_(n-1))^(x_n) f(u_1) f(u_2) ... f(u_n) dif u_n ... dif u_1. \
$
Hence,
$
  f_(Y_1, ..., Y_n) (x_1, ..., x_n) & = (∂^n)/(∂x_1 ... ∂x_n) PP(Y_1 <= x_1, ..., Y_n <= x_n) \
                                    & = cases(
                                        n! f(x_1) f(x_2) ... f(x_n) & quad "for" x_1 < x_2 < ... < x_n,
                                        0 & quad "otherwise"
                                      )
$

=== #ponder("probability.order-statistics")[Order Statistics] of #ponder("probability.exponential-distribution")[Exponential Distributions]

Let $X ~ "Exp"(lambda)$ and $Y ~ "Exp"(mu)$, where $X indep Y$ and $lambda, mu > 0$. Let $Z = min(X, Y)$. Then

$
  PP(Z <= z) & = 1 - PP(Z > z) = 1 - PP(X > z) PP(Y > z) \
             & = 1 - ee^(-lambda z) ee^(-mu z) = 1 - ee^(-(lambda + mu) z) quad "for" z > 0.
$
Hence, $Z ~ "Exp"(lambda + mu)$.

If $(X_i)$ are #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables] with $X_i ~ "Exp"(lambda_i)$, then $min(X_1, ..., X_n)^tp ~ "Exp"(sum_(i=1)^n lambda_i)$.

Now, consider $X_1, X_2, ..., X_n$ be i.i.d. random variables with $X_i ~ "Exp"(lambda)$. Let $Y_i = X_((i))$ be the #ponder("probability.order-statistics")[order statistics] of $X_1, ..., X_n$.

Let $Z_1 = Y_1, Z_2 = Y_2 - Y_1, ..., Z_n = Y_n - Y_(n-1)$. Note that we have found the distribution of $Z_1$ above.

Consider the #ponder("probability.multivariate-density-function")[joint density] of $(Z_1, ..., Z_n)$. We have
$
  bold(Z) = vec(Z_1, dots.v, Z_n) = matbold(A) vec(Y_1, dots.v, Y_n) quad "where" matbold(A) = mat(1, 0, ..., 0, 0, 0; -1, 1, 0, ..., 0, 0; 0, -1, 1, 0, ..., 0; dots.v, dots.v, dots.down, dots.down, dots.v, dots.v; 0, ..., 0, 0, -1, 1).
$
Hence, with the transformation of $z = matbold(A) y$ and $y_j = sum_(i=1)^j z_i$, we have
$
  f_(Z_1, ..., Z_n) (z_1, ..., z_n) &= f_(Y_1, ..., Y_n) (y_1, ...., y_n) abs(det matbold(J)) quad "where" matbold(J) = matbold(A)^(-1)\
  &= n! f(y_1) ... f(y_n)\
  &= n! lambda ee^(-lambda y_1) ... lambda ee^(-lambda y_n) \
  &= product_(i=1)^n ((n - i + 1) lambda ee^(-lambda (n-i+1) z_i)). \
$
Hence, $Z_i ~ "Exp"((n - i + 1) lambda)$ and they are #ponder("probability.independence-of-random-variables")[independent], by @thm-independence-multivariate-density (2).

== #ponder("probability.moment-generating-function")[Moment Generating Functions]

#definition[Moment Generating Function][
  Let $X$ be a #ponder("probability.random-variable")[random variable] with #ponder("probability.probability-density-function")[density] $f$. The #ponder("probability.moment-generating-function")[*moment generating function*] (MGF) of $X$ is
  $
    m(theta) = EE[ee^(theta X)] = integral_(-oo)^(oo) ee^(theta x) f(x) dif x
  $
  whenever the integral is finite. Note that $m(0) = 1$.
] <def-moment-generating-function>

#theorem[
  The MGF uniquely determines the distribution of a #ponder("probability.random-variable")[random variable], provided it is defined for an open interval of values of $theta$.
] <thm-mgf-uniqueness>

#theorem[
  Suppose that the MGF is defined for an interval of values of $theta$, then
  $
    m^((r))(0) = eval((dif^r m(theta))/(dif theta^r))_(theta = 0) = EE[X^r].
  $

]

=== #ponder("probability.gamma-distribution")[Gamma Distribution]

#example[Gamma Distribution][
  For $n in NN$ and $lambda > 0$, the #ponder("probability.gamma-distribution")[*gamma distribution*] with parameters $n$ and $lambda$ is a #ponder("probability.continuous-random-variable")[continuous random variable] $X$ with #ponder("probability.probability-density-function")[density]
  $
    f(x) = (ee^(-lambda x) dot lambda^n dot x^(n-1)) / (n-1)! quad "for" x > 0.
  $

  #prooflike[Proof of density validity][
    We have
    $
      I_n & = integral_0^oo f(x) dif x = integral_0^oo lambda ee^(-lambda x) (lambda^(n-1) x^(n-1))/((n-1)!) dif x \
          & = integral_0^oo lambda ee^(-lambda x) (lambda^(n-1) x^(n-1))/((n-1)!) dif x \
          & = integral_0^oo lambda ee^(-lambda x) (lambda^(n-2) x^(n-2))/((n-2)!) dif x \
          & = I_(n-1) = ... = I_1 = integral_0^oo lambda ee^(-lambda x) dif x = 1.
    $
  ]
  We denote $X ~ Gamma(n, lambda)$. Then,
  $
    m(theta) = EE[ee^(theta x)] & = integral_0^oo ee^(theta x) dot ee^(-lambda x) dot (lambda^n dot x^(n-1))/(n-1)! dif x \
    & = underbracket(integral_0^oo ee^(-(lambda-theta)) ((lambda-theta)^n dot x^(n-1))/(n-1)! dif x, = 1) dot lambda^n / (lambda - theta)^n. \
  $
  If $theta < lambda$, then $m(theta) = (lambda/(lambda - theta))^n$.

] <example-gamma-distribution>

#lecture-separator(lecture: 19, date: "2026-03-06")

#proposition[
  If $X_1, X_2, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent] #ponder("probability.random-variable")[random variables], then
  $
    m(theta) = EE[ee^(theta (X_1 + X_2 +... + X_n))] = product_(i=1)^n EE[ee^(theta X_i)].
  $
]

Suppose $X ~ Gamma(n, lambda)$ and $Y ~ Gamma(m lambda)$, where $m, n in NN$, $lambda > 0$ and $X indep Y$. Consider the #ponder("probability.probability-density-function")[density] of $X + Y$.

We aim to show this by @thm-mgf-uniqueness. Consider, for $theta < lambda$,
$
  EE[ee^(theta (X + Y))] & = EE[ee^(theta X)] EE[ee^(theta Y)] \
                         & = ((lambda)/(lambda- theta))^n ((lambda)/(lambda - theta))^m \
                         & = ((lambda)/(lambda - theta))^(n + m).
$
Hence $X + Y ~ Gamma(n+m, lambda)$

Suppose $X_1, ..., X_n$ are i.i.d. with $X_i ~ "Exp"(lambda)$. Then, $X_1 + ... + X_n ~ Gamma(n, lambda)$.

#remark[
  One could also define $Gamma(alpha, lambda)$ with $alpha, lambda > 0$ by replacing $(n-1)!$ in the #ponder("probability.probability-density-function")[density] by
  $
    Gamma(alpha) = integral_0^oo ee^(-x) x^(alpha - 1) dif x.
  $
  We say $X ~ Gamma(alpha, lambda)$ if $f(x) = (ee^(-lambda x) dot lambda^alpha dot x^(alpha-1)) / (Gamma(alpha))$ for $x > 0$.
]

#prooflike("Cauchy Distribution (Non-Examinable)")[
  The Cauchy distribution is defined as the distribution with #ponder("probability.probability-density-function")[density]
  $
    f(x) = (1)/(ppi (1 + x^2)) quad "for" x in RR.
  $
  The MGF is
  $
    m(theta) = integral_(-oo)^(oo) ee^(theta x)/(ppi (1 + x^2)) dif x = cases(
      1 & quad "for" theta = 0,
      oo & quad "otherwise"
    )
  $
  Hence, $X, 2X, 3X, ...$ all have the same MGF. However, it is not the case that $X, 2X, 3X, ...$ all have the same distribution. So the assumption that the MGF must be finite for an open interval of values of $theta$ is necessary in @thm-mgf-uniqueness.

]

=== MGF of the #ponder("probability.normal-distribution")[Normal Distribution]

Recall that if $X ~ N(mu, sigma^2)$, then
$
  f(x) = (1)/(sqrt(2 ppi sigma^2)) exp(- (x-mu)^(2)/(2sigma^2)).
$
Hence, the MGF of $X$ is
$
  m(theta) = EE[ee^(theta x)] &= integral_(-oo)^(oo) ee^(theta x) (1)/(sqrt(2 ppi sigma^2)) exp(- (x-mu)^(2)/(2sigma^2)) dif x \
$
Note that, the exponent is
$
  "exponent" & = theta x - ((x - mu)^2)/(2 sigma^2) \
  & = theta x - (x^2)/(2 sigma^2) + (2 x mu)/(2sigma^2) - (mu^2)/(2 sigma^2) \
  & = - (x^2)/(2sigma^2) + 2 (x)/(2sigma^2)(mu + theta sigma^2) - (mu^2)/(2 sigma^2) \
  &= - (x^2)/(2sigma^2) + 2 (x)/(2sigma^2)(mu + theta sigma^2) - (mu + theta sigma^2)^(2)/(2sigma^2) + (mu + theta sigma^2)^(2)/(2sigma^2) - (mu^2)/(2sigma^2) \
  &= -(1)/(2sigma^2) (x - (mu + theta sigma^2))^2 cancel(+ (mu^2)/(2sigma^2)) + (2mu theta sigma^2)/(2sigma^2) + (theta^2sigma^2)/2 cancel(- (mu^2)/(2sigma^2)) \
$
Hence,
$
  m(theta) &= underbracket(integral_(-oo)^oo (1)/sqrt(2 ppi sigma^2) exp(- (x - (mu+theta sigma^2))^(2)/(2 sigma^2)) dif x, "integral of density of" N(mu+theta sigma^2, sigma^2)) dot exp(mu theta + (theta^2 sigma^2)/2)\
  &= exp(mu theta + (theta^2 sigma^2)/2).
$

Let $X ~ N(mu, sigma^2)$ and $Y ~ N(nu, tau^2)$, and $X indep Y$. Then
$
  m(theta) = EE[ee^(theta(X+ Y))] & = exp(mu theta + (theta^2 sigma^2)/(2)) exp(nu theta + (theta^2 tau^2)/(2)) \
                                  & = exp((mu + nu) theta + (theta^2 (sigma^2 + tau^2))/(2)).
$
Hence $X + Y ~ N(mu + nu, sigma^2 + tau^2)$.

=== Multivariate #ponder("probability.moment-generating-function")[Moment Generating Functions]

#definition[Multivariate #ponder("probability.moment-generating-function")[Moment Generating Function]][
  Let $bold(X) = (X_1, ..., X_n)^tp in RR^n$ be a #ponder("probability.random-variable")[random variable]. The MGF of $X$ is defined to be
  $
    m(theta) = EE[ee^(bold(theta)^tp dot bold(X))] = EE[ee^(sum_(i=1)^n theta_i X_i)],
  $
  where $bold(theta) = (theta_1, ..., theta_n)^tp$.
]

#theorem[
  For a multivariate #ponder("probability.random-variable")[random variable], if the MGF is finite for an open set of values of $bold(theta)$, then it uniquely determines the distribution of the #ponder("probability.random-variable")[random variable].

  In this case,
  $
    eval((∂^r m)/(∂theta_i^r))_(bold(theta) = bold(0)) = EE[X_i^r] quad "and" quad eval((∂^(r+s)m)/(∂theta_i^r ∂theta_j^s))_(bold(theta) = bold(0)) = EE[X_i^r X_j^s].
  $
]

#proposition[
  Let $bold(X) = (X_1, ..., X_n)^tp$ be a #ponder("probability.random-variable")[random variable] in $RR^(n)$. Then
  $
    m(theta) = EE[ee^(bold(theta)^tp bold(X))] = product_(i=1)^n EE[ee^(theta_i X_i)]
  $
  iff $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent].
]

#proof[

  #fade[[$arrow.double.l$]] This is a direct consequence of the definition of MGF.

  #fade[[$=>$]] If $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent], then $m(theta)$ factorises. If $m(theta)$ factorises, then by @thm-mgf-uniqueness, $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent].
]

== Multidimensional #ponder("probability.gaussian-vector")[Gaussian Random Variables]

=== Introduction

#definition[Gaussian Random Variable][
  A #ponder("probability.random-variable")[random variable] $X$ with values in $RR$ is called #ponder("probability.normal-distribution")[*Gaussian*] (or #ponder("probability.normal-distribution")[*normal*]) in $RR$ if it can be written as
  $
    X ~ mu + sigma Z
  $
  where $Z ~ N(0, 1)$, $mu in RR$, $sigma >= 0$.


  If $sigma > 0$, then the #ponder("probability.probability-density-function")[density] of $X$ is, for $x in RR$,
  $
    f(x) = (1)/(sqrt(2 ppi sigma^2)) exp(- (x - mu)^(2)/(2 sigma^2)).
  $
]

#definition[Gaussian Vector][
  Let $bold(X) = (X_1, ..., X_n)^tp in RR^n$  be a #ponder("probability.random-variable")[random variable]. We say that $bold(X)$ is a #ponder("probability.gaussian-vector")[*Gaussian vector*] (or *Gaussian in $RR^n$*) if for all $bold(u) in RR^n$,
  $
    bold(u)^tp bold(X) = sum_(i=1)^n u_i X_i
  $
  is a #ponder("probability.normal-distribution")[Gaussian random variable] in $RR$.
] <def-gaussian-vector>

#proposition[
  Let $bold(X) = (X_1, ..., X_n)^tp$ be a #ponder("probability.gaussian-vector")[Gaussian vector]. Let $matbold(A)$ be an $m times n$ matrix and $b in RR^m$. Then $matbold(A) bold(X) + bold(b)$ is also a #ponder("probability.gaussian-vector")[Gaussian vector].

]
#proof[
  Let $bold(u) = (u_1, ..., u_n)^tp in RR^n$. We need to show that $bold(u)^tp (matbold(A) bold(X) + bold(b))$ is a #ponder("probability.normal-distribution")[Gaussian random variable] in $RR$. Note that
  $
    bold(u)^tp (matbold(A) bold(X) + bold(b)) & = bold(u)^tp matbold(A) bold(X) + bold(u)^tp bold(b)
  $
  Letting $bold(v) = matbold(A)^tp bold(u)$, we have
  $
    bold(u)^tp (matbold(A) bold(X) + bold(b)) & = bold(v)^tp bold(X) + bold(u)^tp bold(b) \
                                              & = bold(v)^tp bold(X) + sum_(i=1)^n u_i b_i.
  $
  Since $bold(X)$ is a #ponder("probability.gaussian-vector")[Gaussian vector], $bold(v)^tp bold(X)$ is a #ponder("probability.normal-distribution")[Gaussian random variable] in $RR$. Note that $sum_(i=1)^n u_i b_i$ is a constant. Hence, $bold(u)^tp (matbold(A) bold(X) + bold(b))$ is also a #ponder("probability.normal-distribution")[Gaussian random variable] in $RR$.
]

#definition[
  Define
  $
                       bold(mu) & = EE[bold(X)] = vec(EE[X_1], dots.v, EE[X_n]) \
    matbold(V) = "Var"(bold(X)) & = EE[(bold(X) - bold(mu)) (bold(X) - bold(mu))^tp].
  $
  Note that
  $
    ((bold(X) - bold(mu)) (bold(X) - bold(mu))^tp)_(i j) = (X_i - mu_i) (X_j - mu_j).\
    "Var"(bold(X))_(i j) = "Cov"(X_i, X_j).
  $

  Hence, $"Var"(bold(X))$ is a #ponder("linear-algebra.symmetric-matrix")[symmetric matrix].
]

#lecture-separator(lecture: 20, date: "2026-03-09")

Consider the random variable $bold(u)^tp bold(X)$ for some $bold(u) in RR^n$. We have
$
     EE[bold(u)^tp bold(X)] & = EE[sum_(i=1)^n u_i X_i] = sum_(i=1)^n u_i EE[X_i] = bold(u)^tp bold(mu) \
  "Var"(bold(u)^tp bold(X)) & = "Var"(sum_(i=1)^n u_i X_i) \
                            & = sum_(i, j = 1)^n u_i u_j "Cov"(X_i, X_j) \
                            & = bold(u)^tp matbold(V) bold(u).
$

#proposition[
  $matbold(V)$ is a #ponder("linear-algebra.matrix-definiteness")[non-negative definite matrix], _i.e._ for any $bold(u) in RR^n$,
  $
    bold(u)^tp matbold(V) bold(u) >= 0.
  $
]
#proof[
  Note that $"Var"(bold(u)^tp bold(X)) = bold(u)^tp matbold(V) bold(u)$. Since $"Var"(bold(u)^tp bold(X)) >= 0$, we have $bold(u)^tp matbold(V) bold(u) >= 0$.
]

Consider the MGF of $bold(X)$. We have
$
  m(lambda) & = EE[ee^(bold(lambda)^tp bold(X))] quad forall bold(lambda) in RR^n \
$
Note that $bold(lambda)^tp bold(X)$ is $N(bold(lambda)^tp bold(mu), bold(lambda)^tp matbold(V) bold(lambda))$. So
$
  m(lambda) = exp(bold(lambda)^tp bold(mu) + (1)/(2) bold(lambda)^tp matbold(V) bold(lambda)).
$
#fade[[Recall that if $Z ~ N(mu, sigma^2)$, $EE[ee^(theta Z)] = exp(theta mu + (1)/(2) theta^2 sigma^2).$]]

We have seen that the MGF uniquely characterises the distribution if defined for an open set of values. Hence, to characterise a #ponder("probability.gaussian-vector")[Gaussian vector], we only need the mean $bold(mu)$ and the covariance matrix $matbold(V)$.

We have determined the MGF of a #ponder("probability.gaussian-vector")[Gaussian vector] purely from the definition of a #ponder("probability.gaussian-vector")[Gaussian vector], and we will consider its #ponder("probability.probability-density-function")[density function] later.

=== Construction of a #ponder("probability.gaussian-vector")[Gaussian Random Vector]

#lemma[
  Let $Z_1, Z_2, ..., Z_n$ be i.i.d. with $Z_i ~ N(0, 1)$. Let $bold(Z) = (Z_1, ..., Z_n)^tp$. Then, $bold(Z)$ is a #ponder("probability.gaussian-vector")[Gaussian vector].
]

#proof[
  We need to show that $forall bold(u) in RR^n$, $bold(u)^tp bold(Z)$ is normal in $RR$.

  The MGF of $bold(u)^tp bold(Z)$ is
  $
    m(lambda) = EE[ee^(lambda bold(u)^tp bold(Z))] = EE[ee^(sum_(i=1)^n lambda u_i Z_i)] = product_(i=1)^n EE[ee^(lambda u_i Z_i)] = exp((lambda^2)/(2) sum_(i=1)^n u_i^2) = exp((lambda^2)/(2) abs(bold(u))^2).
  $

  So $bold(u)^tp bold(Z) ~ N(0, abs(bold(u))^2)$, and hence $bold(Z)$ is a #ponder("probability.gaussian-vector")[Gaussian vector].
]

#remark[
  We have
  $
    EE[bold(Z)] = bold(0) quad "and" quad "Var"(bold(Z)) = matbold(I)_n.
  $
  We write that $bold(Z) ~ N(bold(0), matbold(I)_n)$
]

Let $bold(mu) in RR^n$ and let $matbold(V)$ be a non-negative definite matrix. We want to construct a #ponder("probability.gaussian-vector")[Gaussian vector] with mean $bold(mu)$ and (co)variance matrix $matbold(V)$, using the standard #ponder("probability.gaussian-vector")[Gaussian vector] $bold(Z) ~ N(bold(0), matbold(I)_n)$.

#fade[[Note that in the $n=1$ case, we can construct $X ~ N(mu, sigma^2)$ by letting $X = mu + sigma Z$.]]

Note that we will need some form of "square root" of $matbold(V)$.

#definition[
  Let $matbold(V)$ be a #ponder("linear-algebra.matrix-definiteness")[non-negative definite matrix]. Consider
  $
    matbold(V) = matbold(U)^tp matbold(D) matbold(U) quad "where" matbold(U)^tp = matbold(U)^(-1)
  $
  and $matbold(D)$ is a diagonal matrix with
  $
    matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, ..., 0, lambda_n) quad "where" lambda_1, ..., lambda_n >= 0.
  $
  Then, the *square root* of $matbold(V)$ is defined as
  $
    matbold(sigma) = matbold(U)^tp sqrt(matbold(D)) matbold(U) quad "where" sqrt(matbold(D)) = mat(sqrt(lambda_1), 0, ..., 0; 0, sqrt(lambda_2), ..., 0; dots.v, dots.v, dots.down, dots.v; 0, ..., 0, sqrt(lambda_n)).
  $
  Note that $matbold(sigma)^2 = matbold(V)$.
]

#lemma[
  Let $bold(mu) in RR^n$, $matbold(V)$ be a #ponder("linear-algebra.matrix-definiteness")[non-negative definite matrix]. Let $Z_1, Z_2, ..., Z_n$ be i.i.d. with $Z_i ~ N(0, 1)$, and let $bold(Z) = (Z_1, ..., Z_n)^tp$.

  Let $matbold(sigma)$ be the square root of $matbold(V)$. Then, $bold(X) = bold(mu) + matbold(sigma) bold(Z)$ is a #ponder("probability.gaussian-vector")[Gaussian vector] with mean $bold(mu)$ and covariance matrix $matbold(V)$. _i.e._, $bold(X) ~ N(bold(mu), matbold(V))$.
]

#proof[
  $bold(X)$ is a #ponder("probability.gaussian-vector")[Gaussian vector] as a linear transformation of a #ponder("probability.gaussian-vector")[Gaussian vector]. We have
  $
    EE[bold(X)] = bold(mu) \
            "Var"(bold(X)) & = EE[(bold(X) - bold(mu)) (bold(X) - bold(mu))^tp] \
                           & = EE[(matbold(sigma) bold(Z)) (matbold(sigma) bold(Z))^tp] \
                           & = matbold(sigma) EE[bold(Z) bold(Z)^tp] matbold(sigma)^tp \
                           & = matbold(sigma) matbold(I)_n matbold(sigma)^tp = matbold(sigma)^2 = matbold(V).
  $
]

=== Density of a #ponder("probability.gaussian-vector")[Gaussian Vector]

Let $bold(X) ~ N(bold(mu), matbold(V))$. We want to find the #ponder("probability.probability-density-function")[density] of $bold(X)$.

#fade[[In the $n=1$ case, we have $f(x) = (1)/(sqrt(2 ppi sigma^2)) exp(- (x - mu)^(2)/(2 sigma^2)).$]]

We shall consider two cases

- $matbold(V)$ is #ponder("linear-algebra.matrix-definiteness")[positive definite], _i.e._ $lambda_1, ..., lambda_n > 0$. We can write
  $
    bold(X) = bold(mu) + matbold(sigma) bold(Z) quad "where" bold(Z) ~ N(bold(0), matbold(I)_n).
  $
  Note that $bold(x) = bold(mu) + matbold(sigma) bold(z)$ gives $bold(z) = matbold(sigma)^(-1) (bold(x) - bold(mu))$. Hence,
  $
    f_bold(X)(bold(x)) & = f_bold(Z) (matbold(sigma)^(-1) (bold(x) - bold(mu))) dot abs(det matbold(sigma)^(-1)) \
    & =f_bold(Z) (z_1, ..., z_n) dot det matbold(sigma)^(-1) \
    & =(1)/ ((2 ppi)^(n/2)) exp(-abs(bold(z))^(2)/(2)) dot det matbold(sigma)^(-1) \
    & = (1)/((2 ppi)^(n/2) det matbold(sigma)) exp(- ((bold(x) - bold(mu))^tp dot (matbold(sigma)^(-1))^tp dot matbold(sigma)^(-1) dot (bold(x) - bold(mu)))/(2))\
    &= (1)/sqrt((2 ppi)^(n) det matbold(V)) exp(- ((bold(x) - bold(mu))^tp dot matbold(V)^(-1) dot (bold(x) - bold(mu)))/(2)).
  $

#lecture-separator(lecture: 21, date: "2026-03-11")

- $matbold(V)$ is #ponder("linear-algebra.matrix-definiteness")[non-negative definite], and $exists i$ such that $lambda_i = 0$.

  By an orthogonal change of basis, we could assume that
  $
    matbold(V) = mat(matbold(U), matbold(0); matbold(0), matbold(0)) quad "where" matbold(U) "is a positive definite matrix of size" m times m "for some" m < n.
  $

  Let
  $
    bold(mu) = vec(bold(lambda), bold(nu)) quad "where" bold(lambda) in RR^m "and" bold(nu) in RR^(n-m).
  $
  We can then write
  $
    bold(X) = vec(bold(Y), bold(nu)) "where" bold(Y) ~ N(bold(lambda), matbold(U))\
    f_bold(Y) (y) = (1)/(sqrt((2ppi)^m det matbold(U)) ) exp(- ((bold(y) - bold(lambda))^tp dot matbold(U)^(-1) dot (bold(y) - bold(lambda)))/(2)).
  $

#proposition[
  Let $bold(X) = (X_1, ..., X_n)$ be a #ponder("probability.gaussian-vector")[Gaussian vector]. Let $bold(mu) = EE[bold(X)]$ and $matbold(V) = "Var"(bold(X))$.

  If $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent], then $matbold(V)$ is a diagonal matrix.
]

#proof[
  Since $V_(i j) = "Cov"(X_i, X_j) = 0$ for $i != j$, the matrix $matbold(V)$ is diagonal due to #ponder("probability.independence-of-random-variables")[independence].
]

#proposition[
  Let $bold(X) = (X_1, ..., X_n)$ be a #ponder("probability.gaussian-vector")[Gaussian vector]. If $matbold(V)$  is a diagonal matrix and strictly #ponder("linear-algebra.matrix-definiteness")[positive definite], then $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent].
]

#prooflike[Proof 1][
  We have
  $
    matbold(V) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, ..., 0, lambda_n) quad "where" lambda_1, ..., lambda_n > 0.
  $
  Let $bold(mu) = (mu_1, ..., mu_n)$. We have
  $
    f_bold(X) (bold(x)) &= (1)/sqrt((2 ppi)^n det matbold(V)) exp(- ((bold(x) - bold(mu))^tp dot matbold(V)^(-1) dot (bold(x) - bold(mu)))/(2)) \
    &= (1)/(sqrt((2 ppi)^n det matbold(V))) exp(-sum_(i=1)^n ((x_i - mu_i)^2)/(2 lambda_i)). \
  $
  Since $f_bold(X)$ factorises, by @thm-independence-multivariate-density (2), $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent], and $X_i ~ N(mu_i, lambda_i)$.
]

#prooflike[Proof 2][
  Consider the MGF of $bold(X)$. We have
  $
    m(theta) = EE[ee^(bold(theta)^tp bold(X))] = exp(bold(theta)^tp bold(mu) + (1)/(2) bold(theta)^tp matbold(V) bold(theta)).
  $
  since we have
  $
    bold(theta)^tp bold(X) ~ N(bold(theta)^tp bold(mu), bold(theta)^tp matbold(V) bold(theta)).
  $
  Hence
  $
    m(theta) & = exp(sum_(i=1)^n theta_i mu_i + sum_(i=1)^n (theta_i^2 lambda_i)/(2)) \
             & = product_(i=1)^n exp(theta_i mu_i + (theta_i^2 lambda_i)/(2)) \
  $
  Since $m(theta)$ factorises into a product of functions of $theta_i$'s, by @thm-mgf-uniqueness, $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent], and $X_i ~ N(mu_i, lambda_i)$.
]

Therefore, we can conclude that if $(X_1, ..., X_n)$ is a #ponder("probability.gaussian-vector")[Gaussian vector], then $X_1, ..., X_n$ are #ponder("probability.independence-of-random-variables")[independent] iff $"Cov"(X_i, X_j) = 0$ for all $i != j$.

=== #ponder("probability.bivariate-gaussian")[Bivariate Gaussian Distribution]

#definition[
  Let $bold(X) = (X_1, X_2)$ be a #ponder("probability.gaussian-vector")[Gaussian vector] in $RR^2$. Let $mu_k = EE[X_k]$, $sigma_k^2 = "Var"(X_k)$ and

  $
    rho = "Corr"(X_1, X_2) = ("Cov"(X_1, X_2))/sqrt("Var"(X_1) "Var"(X_2)).
  $

  Then $bold(X)$ is called a #ponder("probability.bivariate-gaussian")[*bivariate Gaussian vector*] with parameters $mu_1, mu_2, sigma_1^2$ and $sigma_2^2$.
] <def-bivariate-gaussian>

#proposition[
  $rho in [-1, 1]$.
]

#proof[
  By #ponder("linear-algebra.cauchy-schwarz-inequality")[Cauchy-Schwarz inequality], the result follows.
]

Note that we can write the covariance matrix of $bold(X)$ as
$
  matbold(V) = mat(sigma_1^2, rho sigma_1 sigma_2; rho sigma_1 sigma_2, sigma_2^2).
$

#proposition[
  Let $sigma_1, sigma_2 > 0$ and $rho in [-1, 1].$ Then the matrix
  $
    matbold(V) = mat(sigma_1^2, rho sigma_1 sigma_2; rho sigma_1 sigma_2, sigma_2^2)
  $
  is #ponder("linear-algebra.matrix-definiteness")[non-negative definite].
]
#proof[
  Consider any $bold(u) = (u_1,u_2)^tp in RR^2$. Then
  $
    bold(u)^tp matbold(V) bold(u) & = (1-rho) (sigma_1^2 u_1^2 + sigma_2^2 u_2^2) + rho (sigma_1 u_1 + sigma_2 u_2)^2 \
                                  & = (1+rho) (sigma_1^2 u_1^2 + sigma_2^2 u_2^2) - rho (sigma_1 u_1 - sigma_2 u_2)^2 \
  $

  - If $rho in [-1, 0]$, the second line gives $bold(u)^tp matbold(V) bold(u) >= 0$.

  - If $rho in [0, 1]$, the first line gives $bold(u)^tp matbold(V) bold(u) >= 0$.
]

Now, consider $EE[X_2 mid(|) X_1]$. We can write
$
  X_2 = X_2 - a X_1 + a X_1 quad "for any" a in RR.
$
Let $Y = X_2 - a X_1$. Then $vec(X_1, Y)$ is a #ponder("probability.gaussian-vector")[Gaussian vector] since
$
  vec(X_1, Y) = mat(1, 0; -a, 1) vec(X_1, X_2).
$
Note that
$
  "Cov"(X_1, Y) & = "Cov"(X_1, X_2 - a X_1) \
                & = "Cov"(X_1, X_2) - a "Var"(X_1). \
$
Taking $a = "Cov"(X_1, X_2)/("Var" (X_1))$ gives $"Cov"(X_1, Y) = 0$. Hence, $X_1$ and $Y=X_2 - a X_1$ are #ponder("probability.independence-of-random-variables")[independent]. We have
$
  EE[X_2 mid(|)X_1] & = EE[X_2 - a X_1 mid(|)X_1] + EE[a X_1 mid(|)X_1] \
                    & = EE[X_2 - a X_1] + a X_1 \
                    & = mu_2 - a mu_1 + a X_1 \
                    & = mu_2 + (rho sigma_2/sigma_1) (X_1 - mu_1).
$
