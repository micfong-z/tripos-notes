#import "../prelude.typ": *

#lecture-separator(lecture: 3, date: "2025-01-28")

= Axiomatic Approach

Recall our definition of probability spaces in @def-probability-space.

== #ponder("probability.probability-space")[Probability Measure]

There are several important properties of the #ponder("probability.probability-space")[probability measure] $PP$.

#proposition[Countable Subaddivity][
  If $(A_n)$ is a collection in $cal(F)$, _i.e._ $(A_n in cal(F)) space forall n$, then
  $
    PP(union.big_(n in NN) A_n) <= sum_(n in NN) PP(A_n).
  $
] <prop-countable-subadditivity>
#proof[
  Define $B_1 = A_1$ and for $n >= 2$,
  $
    B_n = A_n \\ (A_1 union ... union A_(n-1)).
  $
  Then $(B_n)$ is a disjoint collection in $cal(F)$ and $union.big_n A_n = union.big_n B_n$.

  So
  $
    PP(union.big A_n) = PP(union.big B_n) = sum_n PP(B_n) <= sum_n PP(A_n)
  $
  because $B_n subset.eq A_n$ for all $n$.
]

#proposition[#ponder("probability.continuity-of-probability-measures")[Continuity of Probability Measures] 1][
  Let $(A_n)_(n in NN)$ where $A_n in cal(F)$ and $A_n subset.eq A_(n+1)$ for all $n$. We call $(A_n)$ an *increasing sequence* in $cal(F)$.

  Then $PP(A_n)$ is an increasing sequence in $RR$ and #ponder("analysis.sequence-convergence")[converges] to $PP(union.big_(n in NN) A_n)$.
] <prop-continuity-probability-measure-1>

#proof[
  Define $B_1 = A_1$, and for $n >= 2$,
  $
    B_n = A_n \\ A_(n-1) = A_n \\ (A_1 union ... union A_(n-1)).
  $
  Then $(B_n)$ is a disjoint collection, and
  $
    union.big_(k=1)^n B_k & = A_n \
    PP(A_n) & = union.big_(k=1)^n B_k & = sum_(k=1)^n PP(B_k) -> PP(union.big_(k=1)^oo B_k) quad "as" quad n->oo.
  $
  Now we also have
  $
    sum_(k=1)^oo PP(B_k) = PP(union.big_(k=1)^oo B_k) = PP(union.big_(n in NN) A_n).
  $
  Hence
  $
    lim_(n->oo) PP(A_n) = PP(union.big_(n in NN) A_n).
  $

]

#proposition[#ponder("probability.continuity-of-probability-measures")[Continuity of Probability Measures] 2][
  Let $(A_n)_(n in NN)$ where $A_n in cal(F)$ and $A_n supset.eq A_(n+1)$ for all $n$. We call $(A_n)$ a *decreasing sequence* in $cal(F)$.

  Then $PP(A_n)$ is a decreasing sequence in $RR$ and #ponder("analysis.sequence-convergence")[converges] to $PP(inter.big_(n in NN) A_n)$.
] <prop-continuity-probability-measure-2>

#proof[
  Taking complements, we have that $(A_n^(cp))$ is an increasing sequence in $cal(F)$. By @prop-continuity-probability-measure-1[Continuity of Probability Measures 1], the result follows.
]

== #ponder("probability.inclusion-exclusion-formula")[Inclusion-Exclusion Formula]

#proposition[Inclusion-Exclusion Formula][
  Let $A, B in cal(F)$. Then
  $
    PP(A union B) = PP(A) + PP(B) - PP(A inter B).
  $
  In general, for $n$ #ponder("probability.outcomes-and-events")[events] $A_1, ..., A_n in cal(F)$, we have
  $
    PP(union.big_(i = 1)^n A_i) = sum_(k=1)^n (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n) PP(A_(i_1) inter ... inter A_(i_k))).
  $
] <prop-inclusion-exclusion-formula>

#proof[
  We shall prove this by induction on $n$. The base case $n = 2$ has already been shown.

  Assume that the formula holds for $n-1$ events. We shall show it holds for $n$ events.

  $
    PP(union.big_(i=1)^n A_i) & = PP(union.big_(i=1)^(n-1) A_i union A_n) \
    & = PP(union.big_(i=1)^(n-1) A_i) + PP(A_n) - PP((union.big_(i=1)^(n-1) A_i) inter A_n) \
    & = PP(union.big_(i=1)^(n-1) A_i) + PP(A_n) - PP(union.big_(i=1)^(n-1) underbracket((A_i inter A_n), B_i)). \
  $
  By induction hypothesis,
  $
    PP(union.big_(i=1)^(n-1) A_i) &= sum_(k=1)^(n-1) (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n-1) PP(A_(i_1) inter ... inter A_(i_k)))\
    PP(union.big_(i=1)^(n-1) B_i) &= sum_(k=1)^(n-1) (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n-1) PP(underbracket(A_(i_1) inter ... inter A_(i_k) inter A_n, B_i_1 inter ... inter B_i_k))). \
  $
  Plugging these into the previous equation gives the result.

]

#lemma[Bonferroni Inequalities][
  Let $A, B in cal(F)$. We have
  $
    PP(A union B) <= PP(A) + PP(B)
  $
  Let $A_1, ..., A_n$ be #ponder("probability.outcomes-and-events")[events] in $cal(F)$. Then for any $r <= n$,
  $
    PP(union.big_(i=1)^n A_i) cases(
      <= sum_(k=1)^r (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n) PP(A_(i_1) inter ... inter A_(i_k))) quad "if" r "is odd",
      >= sum_(k=1)^r (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n) PP(A_(i_1) inter ... inter A_(i_k))) quad "if" r "is even",
    )
  $
] <lem-bonferroni-inequalities>
#proof[
  We shall prove this by induction. The base case $n = 2$ is clear.

  Suppose the result holds for $n-1$ events. We shall show it holds for $n$ events.

  Assume that $r$ is odd. Then
  $
    PP(union.big_(i=1)^n A_i) = PP(union.big_(i=1)^(n-1) A_i union A_n) & = PP(union.big_(i=1)^(n-1) A_i) + PP(A_n) - PP((union.big_(i=1)^(n-1) A_i) inter A_n) \
    &= PP(union.big_(i=1)^(n-1) A_i) + PP(A_n) - PP(union.big_(i=1)^(n-1) underbracket(A_i inter A_n, B_i)). \
  $
  By the induction hypothesis, since $r$ is odd,
  $
    PP(union.big_(i=1)^(n-1) A_i) & <= sum_(k=1)^r (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n-1) PP(A_(i_1) inter ... inter A_(i_k))) \
    PP(union.big_(i=1)^(n-1) B_i) & >= sum_(k=1)^(r-1) (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n-1) PP(underbracket(A_(i_1) inter ... inter A_(i_k) inter A_n, B_i_1 inter ... inter B_i_k))). \
  $
  Substituting these into the previous equation gives the result. The case where $r$ is even is similar.
]

#remark[
  If $Omega$ is a #ponder("set-theory.finite-set")[finite set] and $(omega, cal(F), PP)$ is a #ponder("probability.probability-space")[probability space] with $cal(F) = cal(P)(Omega)$, and define
  $
    PP(A) = abs(A) / abs(Omega) quad forall A in cal(F).
  $
  Take $A_1, ..., A_n in cal(F)$, then by the #ponder("probability.inclusion-exclusion-formula")[inclusion-exclusion formula] on $PP(union.big_(i=1)^n A_i)$, we can get
  $
    abs(union.big_(i=1)^n A_i) = sum_(k=1)^n (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n) abs(A_(i_1) inter ... inter A_(i_k))).
  $
  This is the *#ponder("combinatorics.inclusion-exclusion-principle")[inclusion-exclusion principle]* in combinatorics.
]

#lecture-separator(lecture: 4, date: "2025-01-30")

#example[Counting surjections][
  Let $ Omega & = {f: {1, ..., n} -> {1, ..., m}} \
      A & = {f in omega: f "is a surjection"}. $
  We want to find $abs(A)$.

  Define
  $
    A_i = {f in Omega: i in.not f({1, ..., n})} quad forall i = 1, ..., m.
  $
  Then
  $
         A & = A_1^(cp) inter ... inter A_m^(cp) = (union.big_(i=1)^m A_i)^(cp) \
    abs(A) & = abs(Omega) - abs(union.big_(i=1)^m A_i). \
  $
  Note that we have
  $
    abs(Omega) &= m^n\
    abs(A_1 union ... union A_m) & = sum_(k=1)^m (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= m) abs(A_(i_1) inter ... inter A_(i_k))) \
    & = sum_(k=1)^m (-1)^(k+1) binom(m, k) (m-k)^n. \
  $
  So
  $
    abs(A) = m^n - sum_(k=1)^m (-1)^(k+1) binom(m, k) (m-k)^n.
  $
] <exm-counting-surjections>

#example[Counting Derangements][
  A #ponder("combinatorics.derangement")[derangement] is a #ponder("algebra.permutation")[permutation] with no #ponder("algebra.fixed-point")[fixed points]. Let
  $
    Omega & = {"permutations of" {1, 2, ..., n}} \
        A & = {"derangement"} = {f in Omega: f(i) != i quad forall i = 1, ..., n}.
  $
  Pick a #ponder("algebra.permutation")[permutation] at random. Consider the probability that it is in $A$. For $i = 1, ..., n$, let
  $
    A_i = {f in Omega: f(i) = i}.
  $
  Then
  $
    A = A_1^(cp) inter ... inter A_n^(cp) = (union.big_(i=1)^n A_i)^(cp).
  $
  So
  $
    PP(A) = 1 - PP(union.big_(i=1)^n A_i).
  $
  Using @prop-inclusion-exclusion-formula[Inclusion-Exclusion Formula], we have
  $
    PP(union.big_(i=1)^n A_i) &= sum_(k=1)^n (-1)^(k+1) (sum_(1 <= i_1 < ... < i_k <= n) underbracket(PP(A_(i_1) inter ... inter A_(i_k)), = (n-k)!/n!))\
    &= sum_(k=1)^n (-1)^(k+1) binom(n, k) (n-k)!/n!\
    & = sum_(k=1)^n (-1)^(k+1) 1/k!. \
  $
  Therefore,
  $
    PP(A) = 1 - sum_(k=1)^n (-1)^(k+1) 1/k! = sum_(k=0)^n (-1)^k 1/k!.
  $
  Note that as $n -> oo$, $PP(A) -> ee^(-1)$.
] <exm-derangements>

== #ponder("probability.independence-of-events")[Independence]

#definition[Independence of Events][
  Let $(Omega, cal(F), PP)$ be a probability space. Let $A, B in cal(F)$. We say that $A$ and $B$ are *#ponder("probability.independence-of-events")[independent]* if
  $
    PP(A inter B) = PP(A) PP(B).
  $
  We write $A indep B$.

  Let $(A_n)_(n in NN)$ be a collection of #ponder("probability.outcomes-and-events")[events] in $cal(F)$. We say that $(A_n)$ are *#ponder("probability.independence-of-events")[mutually independent]* if for any finite subset $I subset.eq NN$,
  $
    PP(inter.big_(i in I) A_i) = product_(i in I) PP(A_i).
  $
] <def-independence-of-events>

#remark[
  #ponder("probability.independence-of-events")[Pairwise independence] does not imply #ponder("probability.independence-of-events")[mutual independence].
]


#example[
  Consider tossing a fair coin twice. Let
  $
          Omega & = {(0, 0), (0, 1), (1, 0), (1, 1)} \
    PP({omega}) & = 1/4 quad forall omega in Omega. \
  $
  Define events
  $
    A & = {(0, 0), (0, 1)} \
    B & = {(0, 0), (1, 0)} \
    C & = {(1, 0), (0, 1)}. \
  $
  Then we have
  $
                            PP(A) = PP(B) = PP(C) & = 1/2, \
    PP(A inter B) = PP(A inter C) = PP(B inter C) & = 1/4, \
             PP(A inter B inter C) = PP(emptyset) & = 0. \
  $
  Thus, $A, B, C$ are #ponder("probability.independence-of-events")[pairwise independent] but not #ponder("probability.independence-of-events")[mutually independent].
]

#proposition[
  If $A indep B$, then $A indep B^cp$.
]

#proof[
  $
    PP(A inter B^cp) & = PP(A) - PP(A inter B) \
                     & = PP(A) - PP(A) PP(B) quad "since" A indep B \
                     & = PP(A) (1 - PP(B)) \
                     & = PP(A) PP(B^cp).
  $
]

== #ponder("probability.conditional-probability")[Conditional Probability]

#definition[Conditional Probability][
  Let $(Omega, cal(F), PP)$ be a probability space. Let $A, B in cal(F)$ where $PP(B) > 0$. The *#ponder("probability.conditional-probability")[conditional probability]* of $A$ given $B$ is
  $
    PP(A mid(|) B) = PP(A inter B) / PP(B).
  $
  In particular, if $A indep B$, then
  $ PP(A mid(|) B) = PP(A). $
] <def-conditional-probability>

#proposition[#ponder("probability.probability-space")[Countable additivity] for conditional probability][
  Let $(A_n)_(n in NN)$ is a disjoint sequence in $cal(F)$. Then for some $B in cal(F)$ where $PP(B) > 0$,
  $
    PP(union.big_n A_n mid(|) B) = sum_n PP(A_n mid(|) B).
  $
] <prop-cond-countable-additivity>
#proof[
  $
    PP(union.big_n A_n mid(|) B) & = PP((union.big_n A_n) inter B) / PP(B) \
                                 & = PP(union.big_n (A_n inter B)) / PP(B) \
                                 & = (sum_n PP(A_n inter B)) / PP(B) quad "by countable additivity" \
                                 & = sum_n (PP(A_n inter B) / PP(B)) \
                                 & = sum_n PP(A_n mid(|) B).
  $
]

#proposition[Law of Total Probability][
  Suppose $(B_n)_(n in NN)$ is a disjoint collection if $cal(F)$ such that $union.big_n B_n = Omega$ and $PP(B_n) > 0$ for all $n$. Then for any $A in cal(F)$,

  $
    PP(A) = sum_n PP(A mid(|) B_n) PP(B_n).
  $
] <prop-law-of-total-probability>

#proof[
  $
    PP(A) & = PP(A inter (union.big_n B_n)) \
          & = PP(union.big_n (A inter B_n)) \
          & = sum_n PP(A inter B_n) quad "since" B_n "are disjoint" \
          & = sum_n PP(A mid(|) B_n) PP(B_n).
  $
]

#proposition[Bayes' formula][
  Consider $(B_n)$ to be a collection of disjoint #ponder("probability.outcomes-and-events")[events] in $cal(F)$ such that $union.big_n B_n = Omega$ and $PP(B_n) > 0$ for all $n$. Then for any $A in cal(F)$ where $PP(A) > 0$,
  $
    PP(B_k mid(|) A) = (PP(A mid(|) B_k) PP(B_k)) / (sum_n PP(A mid(|) B_n) PP(B_n)).
  $
] <prop-bayes-formula>

#proof[
  By @def-conditional-probability[Conditional Probability],
  $
    PP(B_k mid(|) A) = PP(B_k inter A) / PP(A).
  $
  By @prop-law-of-total-probability[Law of Total Probability], we have
  $
    PP(A) = sum_n PP(A mid(|) B_n) PP(B_n).
  $
  Also,
  $
    PP(B_k inter A) = PP(A mid(|) B_k) PP(B_k).
  $
  Plugging these into the first equation gives the result.
]

This formula is the basis of Bayesian statistics; if we know the probabilities of $PP(B_k)$ and we have a model which gives us $PP(A mid(|) B_k)$, then we can compute the posterior probability $PP(B_n mid(|) A)$.

#example[False positives for a rare condition][
  Suppose that a rare condition $A$ affects $0.1%$ of the population, _i.e._ $PP(A) = 0.001$. A test for the condition has a $98%$ true positive rate and a $1%$ false positive rate. #fade[[For affected individuals, the test is positive with probability $0.98$, and for unaffected individuals, the test is positive with probability $0.01$.]]

  An individual takes the test and tests positive. Consider the probability that they actually have the condition.

  Define
  $
    A & = {"individual suffers from" A} \
    P & = {"test is positive"}.
  $
  We have
  $
    PP(A) = 0.001, quad PP(P mid(|) A) = 0.98, quad PP(P mid(|) A^(cp)) = 0.01.
  $
  Then
  $
    PP(A mid(|) P) = (PP(P mid(|) A) PP(A)) / (PP(P mid(|) A) PP(A) + PP(P mid(|) A^(cp)) PP(A^(cp))) = (0.98 times 0.001) / (0.98 times 0.001 + 0.01 times 0.999) approx 0.09.
  $

  Note that we can rewrite this as
  $
    PP(A mid(|) P) = (1)/(1+ (PP(P mid(|) A^(cp)) PP(A^(cp))) / (PP(P mid(|) A) PP(A))) = (1)/(1 + (0.01 times 0.999) / (0.98 times 0.001)) approx 0.09.
  $
  Since $PP(A^cp)$ and $PP(P mid(|) A)$ are both very close to $1$, so the relavent ration is approximately
  $
    PP(P mid(|) A^cp) / PP(A).
  $
  But $PP(P mid(|) A^cp) >> PP(A)$ and hence the posterior probability is still quite small.
]

#lecture-separator(lecture: 5, date: "2026-02-02")

#example[
  Consider the probability that a person have 2 boys given that,

  1. They have exactly 2 children, one of whom is a boy.

    Since no further information is given, we assume that all outcomes are equally likely.

    Let
    $
      "BG" & = {"elder child is a boy, younger child is a girl"} \
      "GB" & = {"elder child is a girl, younger child is a boy"} \
      "BB" & = {"both children are boys"}. \
      "GG" & = {"both children are girls"}. \
    $
    We want to find
    $
      PP("BB" mid(|) "BB" union "BG" union "GB") & = PP("BB") / PP("BB" union "BG" union "GB") \
                                                 & = (1)/(4) slash.big (3)/(4) \
                                                 & = (1)/(3). \
    $

  2. They have exactly 2 children, the elder of whom is a boy.

    We want to find
    $
      PP("BB" mid(|) "BB" union "BG") & = PP("BB") / PP("BB" union "BG") \
                                      & = (1)/(4) slash.big (2)/(4) \
                                      & = (1)/(2). \
    $

  3. They have exactly 2 children, exactly one of them is a boy, who was born on a Thursday.

    Let  $"T"$ denote the #ponder("probability.outcomes-and-events")[event] that a child is a boy born on a Thursday, and $"N"$ denote the #ponder("probability.outcomes-and-events")[event] that a child is a boy not born on a Thursday. We want to find
    $
      PP("TT" union "TN" union "NT" mid(|) "TT" union "TN" union "NT" union "GT" union "TG") & = PP("TT" union "TN" union "NT") / PP("TT" union "TN" union "NT" union "GT" union "TG") \
      & = ((1)/(2) dot (1)/(7) dot (1)/(2) dot (1)/(7) + (1)/(2) dot (1)/(7) dot (1)/(2) dot (6)/(7)+ (1)/(2) dot (6)/(7) dot (1)/(2) dot (1)/(7))/((1)/(2) dot (1)/(7) dot (1)/(2) dot (1)/(7) + (1)/(2) dot (1)/(7) dot (1)/(2) + (1)/(2) dot (1)/(7) dot (1)/(2) + (1)/(2) dot (1)/(7) dot (1)/(2) dot (6)/(7) dot 2) \
      & = (13)/(27). \
    $
]

#example[Simpson's Paradox][
  Suppose the following data is collected for applicants to a Cambridge college:

  #table(
    align: horizon,
    columns: (1.5fr, 1fr, 1fr, 1fr, 1.2fr),
    table.cell(colspan: 2)[], [*Admitted*], [*Rejected*], [*Admission Rate*],
    table.cell(rowspan: 2)[*All Applicants*], [*State*], [25], [25], [50%],
    [*Independent*], [28], [22], [56%],
    table.cell(rowspan: 2)[*London Schools*], [*State*], [15], [22], [41%],
    [*Independent*], [5], [8], [38%],
    table.cell(rowspan: 2)[*Cambridge Schools*], [*State*], [10], [3], [77%],
    [*Independent*], [23], [14], [62%],
  )

  Note that within each school type, state school applicants have a higher admission rate than independent school applicants. However, when considering all applicants, independent school applicants have a higher admission rate than state school applicants.

  This phenomenon is called *confounding* in statistics. It arises when we aggregate data from disparate populations.

  In terms of #ponder("probability.conditional-probability")[conditional probability], let
  $
       A & = {"individual is admitted"} \
       B & = {"individual is from London"} \
    B^cp & = {"individual is from Cambridge"} \
       C & = {"individual is from a state school"} \
    C^cp & = {"individual is from an independent school"}.
  $
  We have
  $
       PP(A mid(|) B inter C) & > PP(A mid(|) B inter C^cp), \
    PP(A mid(|) B^cp inter C) & > PP(A mid(|) B^cp inter C^cp),
  $
  but
  $
    PP(A mid(|) C) & < PP(A mid(|) C^cp). \
  $
  Note that
  $
    PP(A mid(|) C) & = PP(A inter B mid(|) C) + PP(A inter B^cp mid(|) C) \
                   & = PP(A inter B inter C)/PP(C) + PP(A inter B^cp inter C)/PP(C) \
                   & = (PP(A mid(|) B inter C) PP(B inter C))/PP(C) + (PP(A mid(|) B^cp inter C) PP(B^cp inter C))/PP(C) \
                   & = PP(A mid(|) B inter C) PP(B mid(|) C) + PP(A mid(|) B^cp inter C) PP(B^cp mid(|) C) \
                   & > PP(A mid(|) B inter C^cp) PP(B mid(|) C) + PP(A mid(|) B^cp inter C^cp) PP(B^cp mid(|) C) \
  $
  Now, if we (falsely) assume that $PP(B mid(|) C) = PP(B mid(|) C^cp)$, then
  $
    PP(A mid(|)C) & > PP(A mid(|) B inter C^cp) PP(B mid(|) C^cp) + PP(A mid(|) B^cp inter C^cp) PP(B^cp mid(|) C^cp) \
                  & = PP(A mid(|) C^cp).
  $
  Nonetheless, this does not hold in our example.
] <exm-simpsons-paradox>

== #ponder("probability.discrete-distribution")[Discrete Probability Distributions]

#definition[Discrete Probability Distribution][
  Let $(Omega, cal(F), PP)$ be a #ponder("probability.probability-space")[probability space], where $Omega$ is #ponder("set-theory.countable-set")[countable] with
  $
     Omega & = {omega_1, omega_2, ...} \
    cal(F) & = cal(P)(Omega).
  $
  If we know $PP({omega_i})$ for all $i$, then $forall A subset.eq Omega$,
  $
    PP(A) = sum_(omega_i in A) PP({omega_i}).
  $
  In this case, we say that $(PP({omega_i}))_i$ a *#ponder("probability.discrete-distribution")[discrete probability distribution]*.

  We write $p_i = PP({omega_i})$ for all $i$.

] <def-discrete-distribution>

#proposition[Properties of discrete probability distributions][
  Let $(p_i)_i$ be a #ponder("probability.discrete-distribution")[discrete probability distribution] on a #ponder("set-theory.countable-set")[countable] set $Omega = {omega_1, omega_2, ...}$. Then

  1. $p_i >= 0$ for all $i$.

  2. $sum_i p_i = 1$.
] <prop-discrete-distribution-properties>

Let us see some examples of discrete probability distributions.

#definition[Bernoulli Distribution][
  A *#ponder("probability.bernoulli-distribution")[Bernoulli distribution]* models the #ponder("probability.outcomes-and-events")[outcome] of a single binary experiment, such as a biased coin toss.

  The #ponder("probability.bernoulli-distribution")[Bernoulli distribution] $"Ber"(p)$ with parameter $p in[0, 1]$ is defined by
  $
    Omega & = {0, 1} \
      p_0 & = 1 - p \
      p_1 & = p. \
  $
] <def-bernoulli-distribution>

#definition[Binomial Distribution][
  A *#ponder("probability.binomial-distribution")[binomial distribution]* models the number of successes in $n$ #ponder("probability.independence-of-events")[independent] #ponder("probability.bernoulli-distribution")[Bernoulli trials], each with success probability $p in[0, 1]$.

  The #ponder("probability.binomial-distribution")[binomial distribution] $"Bin"(n, p)$ with parameters $n in NN$ and $p in[0, 1]$ is defined by
  $
    Omega & = {0, 1, ..., n} \
      p_k & = binom(n, k) p^k (1 - p)^(n - k) quad forall k = 0, ..., n. \
  $
  where $(p_k)$ is called the #ponder("probability.binomial-distribution")[binomial distribution]. Note that in the case of a coin toss, $ p_k = PP("obtaining" k "heads in" n "tosses"). $
] <def-binomial-distribution>

#definition[Multinomial Distribution][
  A *#ponder("probability.multinomial-distribution")[multinomial distribution]* models the number of occurrences of each #ponder("probability.outcomes-and-events")[outcome] in $n$ #ponder("probability.independence-of-events")[independent] trials, each with $k$ possible outcomes with probabilities $p_1, ..., p_k$.

  The #ponder("probability.multinomial-distribution")[multinomial distribution] $"M"(n, p_1, ..., p_k)$ with parameters $n in NN$ and $p_1, ..., p_k in[0, 1]$ where $p_1 + ... + p_k = 1$ is defined by
  $
                Omega & = {(n_1, ..., n_k) in NN^k : sum_(i=1)^k n_i= n} \
    p_(n_1, ..., n_k) & = binom(n, n_1, ..., n_k) p_1^(n_1) dot ... dot p_k^(n_k) quad forall (n_1, ..., n_k) in Omega. \
  $

  For example, suppose that there are $k$ boxes and we throw $n$ balls into these boxes independently, where each ball lands in box $i$ with probability $p_i$.  Then
  $
    PP(n_1 "balls in box" 1, ..., n_k "balls in box" k) &= binom(n, n_1) p_1^(n_1) dot ... dot binom(n - n_1 - ... - n_(k-1), n_k) p_k^(n_k) \
    & = binom(n, n_1, ..., n_k) p_1^(n_1) dot ... dot p_k^(n_k).
  $

] <def-multinomial-distribution>

#lecture-separator(lecture: 6, date: "2026-02-04")

#definition[Geometric Distribution][
  A *#ponder("probability.geometric-distribution")[geometric distribution]* models the number of #ponder("probability.bernoulli-distribution")[Bernoulli trials] needed to get the first success, where each trial has success probability $p in[0, 1]$.

  The #ponder("probability.geometric-distribution")[geometric distribution] $"Geo"(p)$ with parameter $p in[0, 1]$ is defined by
  $
    Omega & = NN \
      p_k & = (1 - p)^(k - 1) p quad forall k in NN. \
  $
  Note that,
  $
    sum_k p_k = sum_k (1 - p)^(k - 1) p = p slash.big (1)/(1 - (1 - p)) = 1.
  $

  This models, for example, the number of times we need to toss a biased coin with heads probability $p$ until we get the first heads.
] <def-geometric-distribution>

#definition[Poisson Distribution][
  A *#ponder("probability.poisson-distribution")[Poisson distribution]* models the number of events occurring in a fixed interval of time or space, where these events occur with a known constant mean rate and independently of the time since the last event.

  The #ponder("probability.poisson-distribution")[Poisson distribution] $"Poi"(lambda)$ with parameter $lambda > 0$ is defined by
  $
    Omega & = ZZ_(>=0) \
      p_k & = (lambda^k ee^(-lambda)) / (k!) quad forall k in NN_0. \
  $
  Note that
  $
    sum_k p_k = sum_k (lambda^k ee^(-lambda)) / (k!) = ee^(-lambda) / ee^(lambda) = 1.
  $
] <def-poisson-distribution>

#proof[
  Consider the number of customers arriving at a shop in a time interval $[0, 1]$. We can discretise the time interval to $[(i-1)/(N), (i)/(N)]$ with $i = 1, ..., N$, where each interval has a small probability $p$ of a customer arriving. Then
  $
    PP(k "customers have arrived") & = binom(N, k) p^k (1 - p)^(N - k) \
                                   & = (N!)/(k! (N-k)!) ((lambda)/(N))^k (1 - (lambda)/(N))^(N - k) quad
                                     "with" p = (lambda)/(N) \
                                   & = lambda^k /k! (N (N-1) ... (N-k+1))/(N^k) (1-(lambda)/(N))^(N-k) \
                                   & -> (lambda^k ee^(-lambda)) / (k!) quad "as" N -> oo.
  $



]
