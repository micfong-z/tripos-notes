#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2026-01-23")

= Basic Concepts

We shall begin by general definitions in probability theory.

== #ponder("probability.probability-space")[Probability Spaces]

#definition[Probability Space][
  Suppose $Omega$ is a set and $cal(F)$ is a collection of subsets of $Omega$. Then we call $cal(F)$ a *#ponder("probability.probability-space")[$sigma$-algebra]* if

  - $Omega in cal(F)$ #fade[[ the whole space is in $cal(F)$. ]]

  - If $A in cal(F)$, then $A^(cp) in cal(F)$ #fade[[ closed under complements. ]]

  - If $(A_n)_(n in NN)$ is a #ponder("set-theory.countable-set")[countable] collection of sets in $cal(F)$, then
    #fade[[ closed under #ponder("set-theory.countable-set")[countable] unions. ]]
    $ union.big_n A_n in cal(F). $

  #separator

  Let $cal(F)$ be a #ponder("probability.probability-space")[$sigma$-algebra] on $Omega$. A function
  $
    PP: cal(F) -> [0, 1]
  $
  is called a *#ponder("probability.probability-space")[probability measure]* if

  - $PP(Omega) = 1$

  - *#ponder("probability.probability-space")[Countable additivity.]* For any #ponder("set-theory.countable-set")[countable] disjoint collection of sets $(A_n)_(n in NN)$ in $cal(F)$, we have
    $
      PP(union.big_n A_n) = sum_n PP(A_n).
    $

  #separator

  We say $PP(A)$ to be the *probability* of the #ponder("probability.outcomes-and-events")[event] $A in cal(F)$.

  We call $(Omega, cal(F), PP)$ a *#ponder("probability.probability-space")[probability space]*.
] <def-probability-space>

#definition[Outcomes and Events][
  Suppose $(Omega, cal(F), PP)$ is a #ponder("probability.probability-space")[probability space].

  The elements of $Omega$ are called *#ponder("probability.outcomes-and-events")[outcomes]*, and the elements of $cal(F)$ are called *#ponder("probability.outcomes-and-events")[events]*.
] <def-outcomes-events>

#remark[
  We talk about probabilities of #ponder("probability.outcomes-and-events")[events] instead of #ponder("probability.outcomes-and-events")[outcomes].

  When $Omega$ is #ponder("set-theory.countable-set")[countable], we take $cal(F)$ to be the #ponder("set-theory.power-set")[power set] of $Omega$.
]

#proposition[Properties of Probability Measures][
  Suppose $(Omega, cal(F), PP)$ is a #ponder("probability.probability-space")[probability space]. Then for any $A, B in cal(F)$, we have

  - $PP(A^cp) = 1-PP(A)$

  - $PP(emptyset) = 0$

  - $PP(A) <= PP(B)$ if $A subset.eq B$

  - $PP(A union B) = PP(A) + PP(B) - PP(A inter B)$
] <prop-probability-properties>

#example[
  1. Consider rolling a fair die. We have

    $
            Omega & = {1, 2, 3, 4, 5, 6} \
           cal(F) & = cal(P)(Omega) \
      PP({omega}) & = 1/6 quad           & quad forall omega in Omega. \
            PP(A) & = abs(A)/6 quad      &    quad forall A in cal(F). \
    $

  2. Consider
    $
       Omega & = {omega_1, ..., omega_n} \
      cal(F) & = cal(P)(Omega) \
       PP(A) & = abs(A)/abs(Omega)       & quad forall A in cal(F).
    $

    This models the experiment of picking a uniformly random element from $Omega$. We have

    $
      PP({omega} = (1)/(abs(Omega) )) quad forall omega in Omega.
    $

  3. Consider picking balls from a bag. Suppose we have $n$ balls labelled ${1, 2, ..., n}$. We pick $k$ balls at random without replacement. Then we have

    $
            Omega & = { A subset.eq {1, ..., n} : abs(A) = k } \
       abs(Omega) & = binom(n, k) \
           cal(F) & = cal(P)(Omega) \
      PP({omega}) & = 1/(binom(n, k))                          & quad forall omega in Omega. \
    $

  4. Consider a well-shuffled deck of 52 cards. Then

    $
                           Omega & = {"all permutations of 52 cards"} \
      PP("top 2 cards are aces") & = (4 dot 3 dot 50!)/(52!) = 1/221.
    $

  5. *Largest digit problem.* Consider a string of $n$ random digits from $0, ..., 9$. Then

    $
       Omega & = {0, 1, ..., 9}^n \
      cal(F) & = cal(P)(Omega).
    $

    Then we define
    $
      A_k = {"no digit exceeds" k}.
    $
    And so
    $
      PP(A_k) = ((k+1)^n)/(10^n).
    $
    Another example is the #ponder("probability.outcomes-and-events")[event]
    $
      B_k = {"largest digit is" k}.
    $
    Then
    $
      PP(B_k) = PP(A_k \\ A_(k-1)) = ((k+1)^n - (k)^n)/(10^n).
    $

  6. *Birthday problem.* There are $n$ people. What is the probability that at least two people share a birthday?

    We may assume that there are 365 days in a year, and each person's birthday is equally likely to be any of the 365 days, independently of other people.

    We have

    $
       Omega & = {1, 2, ..., 365}^n \
      cal(F) & = cal(P)(Omega).
    $

    Then
    $
      PP({omega}) = 1/365^n quad forall omega in Omega.
    $


    Let $A$ be the #ponder("probability.outcomes-and-events")[event] that at least two people share a birthday. Then we have
    $
      PP(A^(cp)) = (365)/(365) dot (364)/(365) dot ... dot (365 - n + 1)/(365).
    $
    Thus
    $
      PP(A) = 1 - PP(A^(cp)).
    $
]

== Combinatorial Analysis

1. Let $Omega$ be a #ponder("set-theory.finite-set")[finite set] with $abs(Omega) = n$.

  We want to #ponder("set-theory.partition")[partition] $Omega$ into $k$ disjoint subsets $Omega_1, ... ,Omega_k$ with $abs(Omega_i) = n_i$ and $sum_(n_i) = n$. Consider the number of ways to do this.

  Let $M$ be the number of ways to do this. Then

  $
    M = binom(n, n_1) dot binom(n - n_1, n_2) dot dots.c dot binom(n - n_1 - ... - n_(k-1), n_k) = (n!)/(n_1! dot n_2! dot ... dot n_k!) = binom(n, n_1, n_2, ..., n_k).
  $

2. Let $f: {1, ..., k} -> {1, ..., n}$. We say that $f$ is

  - strictly increasing if $x < y => f(x) < f(y)$

  - increasing if $x < y => f(x) <= f(y)$

  Each strictly increasing functions can be determined by its range. Hence the number of strictly increasing functions is $binom(n, k)$.

  #lecture-separator(lecture: 2, date: "2026-01-26")

  For increasing functions, define a #ponder("algebra.bijection")[bijection]
  $
    g: {f: {1, ..., k} -> {1, ..., n} "increasing"} -> {f: {1, ..., k}->{1, ..., n} "strictly increasing"}
  $

  by
  $
    g(f(i)) = f(i) + i - 1.
  $
  Hence the number of increasing functions is $binom(n + k - 1, k)$.

== #ponder("calculus.stirlings-formula")[Stirling's Formula]

#notation[
  Let $(a_n)$, $(b_n)$ be 2 sequences. We write
  $
    (a_n) ~ (b_n) quad "as" quad n->oo
  $
  if $(a_n)/(b_n) -> 1$ as $n -> oo$.
]

#theorem[Stirling's Formula][
  As $n -> oo$, we have
  $
    n! ~ n^n ee^(-n) sqrt(2 ppi n) .
  $
] <stirlings-formula>

We shall first consider a weaker statement.

#proposition[
  $
    log(n!) ~ n log(n) quad "as" quad n->oo .
  $
]

#proof[
  Define
  $
    l_n = log(n!) = log 2 + ... + log(n).
  $

  For $x in RR$, we shall write $floor(x)$ as the integer part of $x$. Then
  $
    log floor(x) <= log x <= log floor(x+1) .
  $
  Integrating from $1$ to $n$, we have
  $
    sum_(k=1)^(n-1) log k & <= & integral_1^n log x dif x & <= &            sum_(k=2)^n log k \
                  l_(n-1) & <= &          n log n - n + 1 & <= &                          l_n \
          n log n - n + 1 & <= &                      l_n & <= & (n+1) log (n+1) - (n+1) + 1.
  $
  Dividing by $n log n$, we have
  $
    l_n / (n log n) -> 1 quad "as" quad n->oo .
  $
]

#proof[ #fade[[of @stirlings-formula[Stirling's Formula], non-examinable proof]]
  For all $f: RR->RR$ that is twice #ponder("calculus.derivative")[differentiable], for all $a< b$ we have
  $
    integral_a^b f(x) dif x = (f(a) + f(b))/2 (b - a) - (1)/(2) integral_a^b (x - a)(b - x) f''(x) dif x.
  $
  This can be checked using integration by parts twice.


  Take $f(x) = log x, a = k, b = k+1, k in NN$. Then we get
  $
    integral_k^(k+1) log x dif x = (log k + log(k+1))/(2) + (1)/(2) integral_k^(k+1) ((x - k)(k + 1 - x))/(x^2) dif x.
  $
  Therefore,
  $
    integral_1^n log x dif x = (log (n-1)! + log(n!))/(2) + sum_(k=1)^(n-1) a_k
  $
  where
  $
    a_k = (1)/(2) integral_0^1 (x(1 - x))/((x + k)^2) dif x.
  $
  We have
  $
    n log n - n + 1 & = log(n!) - (log n)/(2) + sum_(k=1)^(n-1) a_k \
            log(n!) & = n log n - n + 1 + (log n)/(2) - sum_(k=1)^(n-1) a_k \
                 n! & = n^n dot ee^(-n) dot sqrt(n) dot exp(1 - sum_(k=1)^(n-1) a_k).
  $
  Now, for $a_k$,
  $
    a_k = (1)/(2) integral_0^1 (x(1 - x))/((x + k)^2) dif x <= (1)/(2k^2) integral_0^1 x(1-x) dif x = (1)/(12k^2).
  $
  So the #ponder("analysis.series")[series] $sum_(k=1)^oo a_k$ converges. Let
  $
    A = exp(1 - sum_(k=1)^oo a_k).
  $
  Therefore,
  $
    n! = A dot n^n dot ee^(-n) dot sqrt(n) dot underbracket(exp(sum_(k=n)^oo a_k), ->1 "as" n->oo).
  $
  We have shown that
  $
    n!/(n^n dot ee^(-n) sqrt(n) ) -> A "as" n->oo.
  $
  #separator
  It remains to show that $A = sqrt(2 ppi)$. We already know that
  $
    n! ~ A dot n^n dot ee^(-n) dot sqrt(n).
  $


  Consider
  $
    2^(-2n) binom(2n, n) & = 2^(-2n) (2n)!/(n! n!) \
                         & ~ (2^(-2n) dot (2n)^(2n) dot ee^(-2n) sqrt(2n) dot A )/( (n^n dot ee^(-n) sqrt(n) dot A)^2 ) \
                         & = sqrt(2)/(A sqrt(n) ) .
  $

  We shall use a different method to show that
  $ 2^(-2n) dot binom(2n, n) ~ (1)/(sqrt(ppi n) ) quad "as"quad n->oo. $
  This would imply that $A = sqrt(2 ppi)$.

  Consider
  $
    I_n = integral_0^((ppi)/(2)) (cos theta)^n dif theta quad "with" quad I_0 = (ppi)/(2), I_1 = 1.
  $
  Using integration by parts, we have the recurrence relation
  $
    I_n = ((n-1)/(n)) I_(n-2).
  $
  So
  $
    I_(2n) & = (2n - 1)/(2n) I_(2n - 2) \
           & = ((2n - 1)(2n - 3) dot ... dot 1)/((2n)(2n - 2) dot ... dot 2) ppi/2 \
           & = (2n)!/(2^(2n) (n!)^2) ppi/2 \
           & = (pi)/(2) 2^(-2n) binom(2n, n).
  $

  Thus $I_(2n) = (pi)/(2) dot 2^(-2n) binom(2n, n)$.

  Similarly,
  $
    I_(2n + 1) = (2n dot ... dot 4 dot 2)/((2n+1) dot ... dot 3 dot 1) I_1 = (1)/(2n+1) (2^(-2n) dot binom(2n, n))^(-1).
  $
  Now, if we have that $(I_(2n))/(I_(2n+1)) -> 1$ as $n->oo$, then we have
  $
    ((pi)/(2) 2^(-2n) binom(2n, n))/((1)/(2n+1) (2^(-2n) dot binom(2n, n))^(-1)) -> 1 quad => quad (2^(-2n) binom(2n, n))^2 ~ (1)/(ppi n) quad "as" quad n->oo.
  $

  #separator

  In order to show that $(I_(2n))/(I_(2n+1)) -> 1$ as $n->oo$, we note that
  $
    (I_n)/(I_(n-2)) -> 1 "as" n->oo.
  $
  Recall that
  $
    I_n = integral_0^((ppi)/(2)) (cos theta)^n dif theta .
  $
  Since $I_n$ is decreasing in $n$,
  $
    I_(2n) / I_(2n + 1) & <= (I_(2n-1)) / I_(2n + 1) -> 1, \
    I_(2n) / I_(2n + 1) & >= (I_(2n)) / I_(2n + 2) -> 1.
  $
  So
  $
    I_(2n)/(I_(2n+1)) -> 1 "as" n->oo .
  $
  
  This completes the proof.
]