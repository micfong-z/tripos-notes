#import "../prelude.typ": *
#show: chapter.with(4)

= Long-Run Behaviours

We wish to study how $PP(X_n = x)$ or $PP_x (X_n = y)$ behave as $n->oo$.

== Invariant Distributions

If $PP(X_n = j)-> pi_j$ as $n->oo$ for all $j in I$, for some probability distribution $vb(pi) = (pi_j)_(j in I)$, then we expect that if $X_n ~ vb(pi)$, then $X_(n+1) ~ vb(pi)$, _i.e._

$
  pi_j & = PP(X_(n+1) = j) \
       & = sum_(i) PP(X_n = i) P(i, j) \
       & = sum_(i) pi_i P(i, j) \
$
Hence, if $vb(pi)$ is a row vector, then $vb(pi) = vb(pi) matbold(P)$.

#definition[
  A *measure* $vb(lambda)$ on $I$ is a (row) vector $(lambda_i)_(i in I)$ such that $lambda_i >= 0$ for all $i$, and it is a *probability distribution* if $sum_i lambda_i = 1$.

  A measure $vb(lambda)$ is *invariant* or *stationary* with respect to some transition matrix $matbold(P)$ iff
  $
    vb(lambda) = vb(lambda) matbold(P).
  $
  #fade[[Or alternatively, $lambda_j = sum_i lambda_i P(i, j)$ for all $j in I$.]]
]

#intuition[
  Note that a non-zero invariant measure is a left eigenvector of $matbold(P)$ with eigenvalue $1$. For example, take the chain on ${1, 2, 3}$ from Chapter 1. The first two entries of $vb(pi) = vb(pi) matbold(P)$ give $pi_1 = pi_3 \/ 2$ and $pi_2 = pi_1 + pi_2 \/ 2$, so $pi_2 = pi_3 = 2 pi_1$. Normalising gives $vb(pi) = (1\/5, 2\/5, 2\/5)$, and $pi_1 = 1\/5$ is the limit of $P_11 (n)$ found there.

  If $X_n ~ vb(pi)$, the table lists $PP(X_n = i, X_(n+1) = j) = pi_i P(i, j)$. Row $i$ sums to $pi_i$, as the rows of $matbold(P)$ sum to $1$, and invariance says that column $j$ also sums to $pi_j$.
  #let diagram = markov-chain((
    "1": ("1": $0$, "2": $1$, "3": $0$),
    "2": ("1": $0$, "2": $1/2$, "3": $1/2$),
    "3": ("1": $1/2$, "2": $0$, "3": $1/2$),
  ))
  #let flows = table(
    columns: 5,
    table.header[][$j = 1$][$j = 2$][$j = 3$][sum],
    [$i = 1$], [$0$], [$1\/5$], [$0$], [$1\/5$],
    [$i = 2$], [$0$], [$1\/5$], [$1\/5$], [$2\/5$],
    [$i = 3$], [$1\/5$], [$0$], [$1\/5$], [$2\/5$],
    [sum], [$1\/5$], [$2\/5$], [$2\/5$], [],
  )
  #if is-html [#diagram #flows] else {
    grid(columns: (1fr, 1fr), column-gutter: 1em, align: center + horizon, diagram, flows)
  }
]

#theorem[
  If $vb(pi)$ is invariant for $vb(X)$ and $X_0 ~ vb(pi)$, then $X_n ~ vb(pi)$ for all $n >= 0$.
]

#proof[
  We will prove by induction.

  *Base case.* Obviously, $X_0 ~ vb(pi)$.

  *Inductive step.* Suppose that $X_n ~ vb(pi)$ for some $n >= 0$. Then,
  $
    PP(X_(n+1) = j) = sum_(i) PP(X_n = i) P(i, j) = sum_(i) pi_i P(i, j) = pi_j.
  $
  Hence, $X_(n+1) ~ vb(pi)$.
]

#theorem[
  If $vb(X)$ is a Markov chain on a finite state space $I$, and
  $
    PP(X_n = i) -> "some" pi_i "as" n-> oo "for all" i in I,
  $
  then $vb(pi)$ is an invariant distribution for $vb(X)$.
]

#proof[
  We have
  $
    PP(X_(n+1) = j) & = sum_(i) PP(X_n = i) P(i, j).
  $
  Since $I$ is finite, taking $n->oo$ gives
  $
    pi_j = sum_(i) pi_i P(i, j)
  $
  and hence $vb(pi)$ is invariant.
  Also, since $sum_i PP(X_n = i) = 1$ for all $n$, we have $sum_i pi_i = 1$. Hence $vb(pi)$ is a probability distribution.
]

#remark[
  Here, the assumption that $I$ is finite is crucial. For example, for the simple symmetric random walk on $ZZ$,
  $
    P_(x y)(n) -> 0
  $
  for all $x, y$ as $n-> oo$, but clearly $vb(0)$ is not a probability distribution.
]


#remark[
  If $I$ is finite, then $vb(X)$ always has an invariant distribution, by compactness. Otherwise, there are more complex discussions.
]

#example[
  Recall the simple chain as follows.
  #markov-chain((
    "0": ("1": $alpha$, "0": $1-alpha$),
    "1": ("0": $beta$, "1": $1-beta$),
  ))
  We saw that, if $0 < alpha + beta < 2$,
  $
    P_00(n) & = (beta)/(alpha + beta) + (alpha)/(alpha + beta) (1-alpha-beta)^n, \
            & -> (beta)/(alpha + beta) "as" n-> oo. \
  $
  So, if $X_0 = 0$,
  $
    PP(X_n = dot) -> (beta/(alpha + beta), alpha/(alpha + beta)) "as" n-> oo.
  $
  Hence, the chain converges to a stationary distribution.

  #exercise[
    Check that the vector is invariant to the matrix $matbold(P) = mat(delim: "[", 1-alpha, alpha; beta, 1-beta)$.
  ]
]

=== Existence and Uniqueness

#definition[
  For a fixed $k in I$, define
  $
    nu_k (j) = EE_k [sum_(n=0)^(T_k-1) bb(1)[X_n = j]]
  $
  where
  $
    T_k = inf Set(n >= 1; X_n = k)
  $
  is the first return time to $k$. The measure $vb(nu)_k = (nu_k (j))_(j in I)$ is the *expected number of visits* for $k$.
]

#intuition[
  So $nu_k (j)$ is the expected number of visits to $j$ in one excursion from $k$, counting time $0$ but not time $T_k$. The chain on ${1, 2, 3}$ above goes $1 -> 2 -> 3 -> 1$, staying at $2$ or $3$ with probability $1\/2$ at each step. One excursion from $k = 1$ is
  #align(center, table(
    columns: 8,
    table.header[$n$][$0$][$1$][$2$][$3$][$4$][$5$][$6 = T_1$],
    [$X_n$], [$1$], [$2$], [$2$], [$3$], [$3$], [$3$], [$1$],
  ))
  which visits $1$ once, $2$ twice and $3$ three times before $T_1 = 6$. Other excursions give other counts, and $vb(nu)_1$ is their mean. Every excursion enters $2$ and $3$ once each and stays at each for a geometric number of steps with mean $1 \/ (1\/2) = 2$, so $vb(nu)_1 = (1, 2, 2)$.

  Each time $0, ..., T_k - 1$ is a visit to exactly one state, so $sum_j nu_k (j) = EE_k [T_k]$, here $1 + 2 + 2 = 5$.
]

#lecture-separator(lecture: 9, date: "2026-11-05")

#theorem[
  Suppose $matbold(P)$ is irreducible and recurrent. Then

  + $nu_k (k) = 1$

  + $0 < nu_k (i) < oo$ for all $i in I$.

  + $vb(nu)_k$ is invariant for $matbold(P)$.
] <thm-expected-number-of-visits>

#proof[
  1. Follows from definition.

  3. We have
    $
      nu_k (i) & = EE_k [sum_(n=0)^(T_k-1) bb(1)[X_n = i]] \
    $

    Since $matbold(P)$ is recurrent, $T_k < oo$ with probability $1$, and $X_(T_k) = k$. So
    $
      nu_k (i) & = EE_k [sum_(n=1)^(T_k) bb(1)[X_n = i]] \
               & = EE_k [sum_(n=1)^oo bb(1)[X_n = i, n <= T_k]] \
               & = sum_(n=1)^oo EE_k [bb(1)[X_n = i, n <= T_k]] \
               & = sum_(n=1)^oo PP_k (X_n = i, n <= T_k) \
               & = sum_(n=1)^oo sum_(j in I) PP_k (X_n = i, X_(n-1) = j, n <= T_k) \
               & = sum_(n=1)^oo sum_(j in I) PP_k (X_n = i mid(|) X_(n-1) = j, n <= T_k) dot PP_k (X_(n-1) = j, n <= T_k). \
    $

    Note that
    $
      {T_k >= n} & = {T_k <= n-1}^complement \
                 & = [union.big_(t=1)^(n-1) {T_k = t}]^complement \
    $
    which only depends on $X_0, X_1, ..., X_(n-1)$. Hence by the Markov property,
    $
      nu_k (i) & = sum_(n=1)^oo sum_(j in I) P(j, i) PP_k (X_(n-1) = j, n <= T_k) \
               & = sum_(j in I) P(j, i) sum_(n=1)^oo EE_k [bb(1)[X_(n-1) = j, n <= T_k]] \
               & = sum_(j in I) P(j, i) sum_(n=0)^oo EE_k [bb(1)[X_n = j, T_k >= n+1]] \
               & = sum_(j in I) P(j, i) EE_k [sum_(n=0)^(T_k -1) bb(1)[X_n = j]] \
               & = sum_(j in I) P(j, i) nu_k (j). \
    $
    Therefore, $vb(nu)_k$ is invariant for $matbold(P)$.

  2. Since $vb(nu)_k$ is invariant, _i.e._  $vb(nu)_k = vb(nu)_k matbold(P)$, we also have $vb(nu)_k = vb(nu)_k matbold(P)^n$ for all $n >= 1$. Hence, for any fixed $i in I$,
    $
      nu_k (i) & = (vb(nu)_k matbold(P)^n)_i \
               & = sum_(j in I) nu_k (j) P_(j i) (n).
    $
    By irreducibility, we can choose $n$ such that $P_(k i) (n) > 0$. Then
    $
      nu_k (i) & >= nu_k (k) P_(k i) (n) = P_(k i) (n) > 0.
    $
    Also, by irreducibility, we can choose $m$ such that $P_(i k) (m) > 0$. Then, by invariance,
    $
      1 = nu_k (k) & = sum_(j in I) nu_k (j) P_(j k) (m) \
                   & >= nu_k (i) P_(i k) (m)
    $
    so we have
    $
      nu_k (i) <= (1)/(P_(i k) (m)) < oo.
    $
]

#intuition[#block(breakable: false)[
  In (3), a visit to $i$ counted by $nu_k (i)$ is one step after a visit to some $j$ counted by $nu_k (j)$.
  #canvas({
    import draw: *
    import cetz.decorations: flat-brace
    let dx = 1.5
    let r = 0.27
    let x(t) = t * dx
    // Slots 0, ..., 7 stand for the times 0, 1, 2, n - 1, n, n + 1, T_k - 1, T_k.
    let named = ("0": $cblue(k)$, "3": $j$, "4": $i$, "7": $cblue(k)$)
    let times = ("0": $0$, "1": $1$, "3": $n - 1$, "4": $n$, "6": $T_k - 1$, "7": $T_k$)
    for t in range(7) {
      let a = if str(t) in named { r } else { 0.06 }
      let b = if str(t + 1) in named { r } else { 0.06 }
      if t == 3 {
        line((x(t) + a, 0), (x(t + 1) - b, 0), stroke: rule("orange") + 0.9pt, mark: (
          end: ">",
          fill: rule("orange"),
          stroke: rule("orange"),
        ))
        content((x(3.5), 0.42), text(fill: ink("orange"), $P(j, i)$))
      } else {
        line((x(t) + a, 0), (x(t + 1) - b, 0), stroke: colors.text-secondary + 0.6pt)
      }
    }
    for t in range(8) {
      if str(t) in named {
        let hue = if t == 0 or t == 7 { "blue" } else { none }
        circle((x(t), 0), radius: r, stroke: if hue == none { colors.text + 0.6pt } else { rule(hue) + 0.6pt })
        content((x(t), 0), named.at(str(t)))
      } else {
        circle((x(t), 0), radius: 0.06, fill: colors.text-secondary, stroke: none)
      }
      if str(t) in times { content((x(t), -0.55), text(size: 0.85em, times.at(str(t)))) }
    }
    flat-brace((x(1) - 0.15, 0.85), (x(7) + 0.3, 0.85), amplitude: 0.18, stroke: colors.text + 0.5pt)
    content((x(4.075), 1.35), [times $1, ..., T_k$ of $nu_k (i)$])
    flat-brace((x(6) + 0.15, -0.9), (x(0) - 0.3, -0.9), amplitude: 0.18, stroke: colors.text + 0.5pt)
    content((x(2.925), -1.4), [times $0, ..., T_k - 1$ of $nu_k (j)$])
  })
  Counting over times $1, ..., T_k$ instead of $0, ..., T_k - 1$ changes nothing, as $X_0 = X_(T_k) = k$. This needs $T_k < oo$, which is where recurrence is used.
]]

#theorem[
  Suppose $matbold(P)$ is irreducible and $vb(lambda)$ is an invariant measure such that $lambda_k = 1$. Then $vb(lambda) >= vb(nu)_k$.

  If $matbold(P)$ is also recurrent, then $vb(lambda) = vb(nu)_k$.
] <thm-invariant-measure-expected-number-of-visits>

#proof[
  Fix $i != k$. Since $vb(lambda)$ is invariant, we have
  $
    lambda_i &= sum_(j in I) lambda_j P(j, i) \
    & = lambda_k P(k, i) + sum_(j != k) lambda_j P(j, i) \
    & = P(k, i) + sum_(j_1 != k) sum_(j_2 in I) lambda_(j_2) P(j_2, j_1) P(j_1, i) \
    & = P(k, i) + sum_(j_1 != k) P(k, j_1) P(j_1, i) + sum_(j_1, j_2 != k) lambda_(j_2) P(j_2, j_1) P(j_1, i) \
    &= dots.c \
    &= P(k, i) + sum_(j_1 != k) P(k, j_1) P(j_1, i) + dots.c + sum_(j_1, ..., j_(n-1) != k) P(k, j_(n-1)) P(j_(n-1), j_(n-2)) dots.c P(j_1, i) + sum_(j_1, ..., j_n != k) lambda_(j_n) P(j_n, j_(n-1)) dots.c P(j_1, i) \
  $
  Therefore,
  $
    lambda_i >= PP_k (X_1 = i, T_k >= 1) + PP_k (X_2 = i, T_k >= 2) + dots.c + PP_k (X_n = i, T_k >= n).
  $
  Since this holds for all $n$,
  $
    lambda_i & >= sum_(n=1)^oo PP_k (X_n = i, T_k >= n) \
             & = sum_(n=1)^oo EE_k [bb(1)[X_n = i, T_k >= n]] \
             & = EE_k [sum_(n=1)^T_k bb(1)[X_n = i]] = nu_k (i).
  $

  In addition, if $matbold(P)$ is recurrent, then $vb(nu)_k$ is invariant by @thm-expected-number-of-visits, and so is the new measure $vb(lambda) - vb(nu)_k$. So
  $
    vb(lambda) - vb(nu)_k = (vb(lambda) - vb(nu)_k) matbold(P)^n
  $
  for all $n >= 1$. Hence, for any $i in I$ where $i!=k$,
  $
    0 = (vb(lambda) - vb(nu)_k)_k & = ((vb(lambda) - vb(nu)_k) matbold(P)^n)_k \
                                  & = sum_(j in I) (vb(lambda) - vb(nu)_k)_j P_(j k) (n). \
  $
  Choose $n >= 1$ such that $P_(i k) (n) > 0$. Then
  $
    0 >= (lambda_i - nu_k (i)) P_(i k) (n) quad => quad lambda_i - nu_k (i) = 0.
  $
  Therefore $vb(lambda) = vb(nu)_k$.
]

#intuition[#block(breakable: false)[
  The terms of $lambda_i$ for $n = 3$, as paths into $i$, where every $j_m != k$.
  #canvas({
    import draw: *
    let dx = 1.5
    let dy = 0.9
    let r = 0.28
    for row in range(4) {
      let y = -row * dy
      let rest = row == 3
      let len = if rest { 3 } else { row + 1 }
      let pen = if rest { colors.text-secondary } else { colors.text }
      for t in range(len + 1) {
        let x = (3 - len + t) * dx
        let start-k = t == 0 and not rest
        let name = if t == len { $i$ } else if start-k { $k$ } else { $j_#(len - t)$ }
        circle((x, y), radius: r, stroke: (if start-k { rule("blue") } else { pen }) + 0.6pt)
        content((x, y), text(fill: if start-k { ink("blue") } else { pen }, name))
        if t < len {
          line((x + r, y), (x + dx - r, y), stroke: pen + 0.6pt, mark: (end: ">", fill: pen, stroke: pen))
        }
      }
      let weight = if rest { $lambda_(j_3)$ } else { $lambda_k = 1$ }
      content(((3 - len) * dx - r - 0.1, y), anchor: "east", text(fill: pen, weight))
      let term = if rest { [$>= 0$, dropped] } else { $PP_k (X_#(row + 1) = i, T_k >= #(row + 1))$ }
      content((3 * dx + r + 0.3, y), anchor: "west", text(fill: pen, term))
    }
  })
  By the second part, if $matbold(P)$ is irreducible and recurrent, every non-zero invariant measure $vb(mu)$ is a multiple of $vb(nu)_k$: choosing $j$ with $mu_j > 0$ and $n$ with $P_(j k)(n) > 0$ gives $mu_k = (vb(mu) matbold(P)^n)_k >= mu_j P_(j k)(n) > 0$, and then $vb(mu) \/ mu_k = vb(nu)_k$.
]]

=== Positive Recurrence

Recall that a state $i$ is recurrent if $PP_i (T_i < oo) = 1$.

#definition[
  A state $i$ is *positive recurrent* if it is recurrent and $EE_i [T_i] < oo$.

  A state $i$ is *null recurrent* if it is recurrent but $EE_i [T_i] = oo$.
]

#intuition[
  For example:
  #align(center, table(
    columns: 4,
    table.header[Chain, state][$PP_i (T_i < oo)$][$EE_i [T_i]$][State $i$ is],
    [the chain on ${1, 2, 3}$ above, $i = 1$], [$1$], [$5$], [positive recurrent],
    [simple symmetric random walk on $ZZ$, $i = 0$], [$1$], [$oo$], [null recurrent],
    [asymmetric random walk on $ZZ$, $i = 0$], [$< 1$], [$oo$], [transient],
  ))
  Here $EE_1 [T_1] = 5$ is the sum of $vb(nu)_1$ above, and the values of $PP_0 (T_0 < oo)$ are from Chapter 3. The symmetric walk is recurrent and $lambda_i = 1$ is invariant with $lambda_0 = 1$, so $vb(nu)_0 = vb(lambda)$ by @thm-invariant-measure-expected-number-of-visits and $EE_0 [T_0] = sum_i nu_0 (i) = oo$. A transient state always has $EE_i [T_i] = oo$, as $T_i = oo$ with positive probability.
]

#theorem[
  If $matbold(P)$ is irreducible, the following are equivalent:

  + All states are positive recurrent.

  + At least one state is positive recurrent.

  + $matbold(P)$ has an invariant probability distribution $vb(pi)$.

  If any of these hold, then $pi_i = (1)/(EE_i [T_i])$ for all $i in I$.
]

#proof[

  #fade[[$(1) => (2)$]] This is trivial.

  #fade[[$(2) => (3)$]] Suppose $k$ is positive recurrent. Then
  $
    sum_(i in I) nu_k (i) & = sum_(i in I) EE_k [sum_(n=0)^(T_k-1) bb(1)[X_n = i]] \
                          & = EE_k [sum_(n=0)^(T_k-1) sum_(i in I) bb(1)[X_n = i]] \
                          & = EE_k [T_k] < oo.
  $
  So define $pi_i = (nu_k (i))/(EE_k [T_k])$. Then $vb(pi)$ is a probability distribution. Since $matbold(P)$ is irreducible and $k$ is recurrent, every state is recurrent by @thm-communicating-classes-recurrence, so $vb(pi)$ is invariant by @thm-expected-number-of-visits.

  #fade[[$(3) => (1)$]] Let $k$ be arbitrary. Then by invariance of $vb(pi)$,
  $
    pi_k = sum_(j) pi_j P_(j k) (n) quad forall n >= 0.
  $
  Choose a state $i$ such that $pi_i > 0$, and by irreducibility choose $n$ such that $P_(i k) (n) > 0$. Then
  $
    pi_k >= pi_i P_(i k) (n) > 0.
  $
  So $pi_k > 0$ for all $k$. Now define a new invariant measure
  $
    lambda_i = (pi_i)/(pi_k)
  $
  for all $i$. So $lambda_k = 1$. Then we must have by @thm-invariant-measure-expected-number-of-visits that
  $
    vb(lambda) >= vb(nu)_k.
  $
  Thus
  $
    EE_k [T_k] = sum_(i in I) nu_k (i) <= sum_(i in I) lambda_i = (1)/(pi_k) sum_(i in I) pi_i = (1)/(pi_k) < oo.
  $
  Hence $k$ is positive recurrent, and since $k$ was arbitrary, all states are positive recurrent.

  Finally, since the chain is (positive) recurrent, we must have $vb(lambda) = vb(nu)_k$. So
  $
    (1)/(pi_k) = sum_(i in I) (pi_i)/(pi_k) = sum_(i in I) lambda_i = sum_(i in I) nu_k (i) = EE_k [T_k]
  $

]

#intuition[#block(breakable: false)[
  #let by(it) = text(size: 0.85em, fill: colors.text-secondary, it)
  #fletcher-diagram(
    spacing: (3em, 3.6em),
    node-stroke: colors.text + 0.6pt,
    node-inset: 0.5em,
    node-corner-radius: 2pt,
    node((0, 0), align(center)[(2) $k$ positive \ recurrent], name: <pr-two>),
    node((2, 0), align(center)[(3) invariant \ distribution $vb(pi)$], name: <pr-three>),
    node((1, 1), align(center)[(1) all states \ positive recurrent], name: <pr-one>),
    node((4, 0), $pi_k = 1 \/ EE_k [T_k]$, name: <pr-formula>),
    edge(<pr-one>, <pr-two>, by[trivial], "->", label-side: left),
    edge(
      <pr-two>,
      <pr-three>,
      align(center)[$vb(pi) = vb(nu)_k \/ EE_k [T_k]$ \ #by[@thm-expected-number-of-visits]],
      "->",
    ),
    edge(
      <pr-three>,
      <pr-one>,
      align(center)[$vb(nu)_k <= vb(pi) \/ pi_k$ \ #by[@thm-invariant-measure-expected-number-of-visits]],
      "->",
      label-side: left,
    ),
    edge(
      <pr-three>,
      <pr-formula>,
      align(center)[$vb(nu)_k = vb(pi) \/ pi_k$ \ #by[@thm-invariant-measure-expected-number-of-visits]],
      "->",
    ),
  )
  The chain returns to $i$ on average every $EE_i [T_i]$ steps, so $pi_i = 1 \/ EE_i [T_i]$ is the long-run fraction of time it spends at $i$ #fade[[made precise by the ergodic theorem at the end of the chapter]]. For the chain on ${1, 2, 3}$, $EE_1 [T_1] = 5 = 1 \/ pi_1$.
]]

#lecture-separator(lecture: 10, date: "2026-11-10")

#corollary[
  If $matbold(P)$ is irreducible and has invariant distribution $vb(pi)$, then
  $
    nu_x (y) = (pi_y)/(pi_x) quad forall x, y in I.
  $

]
#example[
  Consider a simple symmetric random walk on $ZZ$. We have
  $
    P(i, i+1) = P(i, i-1) = (1)/(2).
  $
  The invariance equation is
  $
    pi_i = pi_(i-1) (1)/(2) + pi_(i+1) (1)/(2) quad forall i in ZZ.
  $
  So $lambda_i = 1$ is an invariant measure. Since the chain is recurrent, by @thm-invariant-measure-expected-number-of-visits every invariant measure is a multiple of $vb(lambda)$, but $vb(lambda)$ cannot be normalised to give an invariant distribution. Hence, the chain is not positive recurrent.
]

#example[
  Consider a simple asymmetric random walk on $ZZ$. We have
  $
    P(i, i+1) = p != (1)/(2), quad P(i, i-1) = q = 1 - p.
  $
  In this case, the invariance equation is
  $
    pi_i = pi_(i-1) p + pi_(i+1) q quad forall i in ZZ.
  $
  Solving gives the general solution
  $
    pi_i = a + b ((p)/(q))^i
  $
  with $i in ZZ$ for any $a, b >= 0$. So we have a family of invariant measures that are not multiples of each other. Hence the chain is not positive recurrent.
]

#intuition[
  The walk is irreducible, so if it were recurrent, then by @thm-invariant-measure-expected-number-of-visits the only invariant measure with $lambda_0 = 1$ would be $vb(nu)_0$. But $a + b (p\/q)^i$ with $a + b = 1$ is one for every $a in [0, 1]$. So the chain is not even recurrent, which agrees with Chapter 3, where it was shown to be transient.
]

#example[
  Consider an asymmetric random walk on $ZZ_(>=0)$ with reflection. We have
  $
    P(i, i+1) = p < (1)/(2), & quad P(i, i-1) = q = 1 - p, #eq-note[$i >= 1$] \
                P(0, 1) = p, & quad P(0, 0) = q.
  $
  Here, the invariance equation is
  $
    pi_i & = pi_(i-1) p + pi_(i+1) q quad forall i >= 1, \
    pi_0 & = pi_0 q + pi_1 q.
  $

  Solving gives the general solution
  $
    pi_i = ((p)/(q))^i pi_0 quad forall i >= 0.
  $
  Normalising gives
  $
    pi_i = (1 - (p)/(q)) ((p)/(q))^i quad forall i >= 0.
  $
  So the chain is positive recurrent and this is its unique invariant distribution.
]

== Time Reversibility

#definition[
  A chain with transition matrix $matbold(P)$ and invariant distribution $vb(pi)$ is called reversible if
  $
    P(x, y) = hat(P) (x, y) := P(y, x) (pi_y)/(pi_x) quad forall x, y in I.
  $
]

#remark[
  $hat(matbold(P))$ is always a transition matrix, since
  $
    sum_(y in I) hat(P) (x, y) = [sum_(y in I) P(y, x) pi_y] / pi_x = pi_x / pi_x = 1 quad forall x in I.
  $
]

#theorem[
  Suppose $vb(X) ~ "Markov" (vb(pi), matbold(P))$ is irreducible and $vb(pi)$ is invariant for $matbold(P)$.

  Let, for fixed $N >= 1$, $Y_n = X_(N-n)$. Then the process $(Y_n)_(0<=n<=N) ~ "Markov"(vb(pi),hat(matbold(P)))$ and it is also irreducible.
]
#proof[
  Since $vb(pi)$ is invariant and $X_0$ has distribution $vb(pi)$, we have $X_n ~ vb(pi)$ for all $n$. Hence $X_N = Y_0 ~ vb(pi)$. Also,
  $
    PP(Y_0 = y_0, ..., Y_N = y_N) & = PP(X_0 = y_N, ..., X_N = y_0) \
                                  & = pi_(y_N) P(y_N, y_(N-1)) dots.c P(y_1, y_0) \
                                  & = pi_(y_0) hat(P) (y_0, y_1) dots.c hat(P) (y_(N-1), y_N). \
  $
  So $vb(Y) = (Y_n)_(0<=n<=N) ~ "Markov"(vb(pi),hat(matbold(P)))$.

  And since all $pi_i > 0$, $hat(P)(x, y) > 0$ iff $P(y, x) > 0$. Hence $vb(Y)$ is irreducible if and only if $vb(X)$ is irreducible.
]

#intuition[
  For the chain on ${1, 2, 3}$ from Chapter 1, with $vb(pi) = (1\/5, 2\/5, 2\/5)$, the reversed chain goes round the cycle the other way.
  #let forward = markov-chain((
    "1": ("1": $0$, "2": $1$, "3": $0$),
    "2": ("1": $0$, "2": $1/2$, "3": $1/2$),
    "3": ("1": $1/2$, "2": $0$, "3": $1/2$),
  ))
  #let backward = markov-chain((
    "1": ("1": $0$, "2": $0$, "3": $1$),
    "2": ("1": $1/2$, "2": $1/2$, "3": $0$),
    "3": ("1": $0$, "2": $1/2$, "3": $1/2$),
  ))
  #if is-html [$matbold(P)$ #forward $hat(matbold(P))$ #backward] else {
    grid(
      columns: (1fr, 1fr),
      row-gutter: 0.6em,
      align: center + horizon,
      forward, backward,
      $matbold(P)$, $hat(matbold(P))$,
    )
  }
  If $X_0 ~ vb(pi)$, then $(X_0, ..., X_N)$ is $"Markov"(vb(pi), matbold(P))$ and, by the theorem, $(X_N, ..., X_0)$ is $"Markov"(vb(pi), hat(matbold(P)))$. So $vb(X)$ is reversible iff these two sequences have the same distribution for every $N$. For $N = 1$ this says
  $
    PP(X_0 = x, X_1 = y) = pi_x P(x, y) = pi_y P(y, x) = PP(X_0 = y, X_1 = x),
  $
  which is $P(x, y) = hat(P)(x, y)$ multiplied by $pi_x$, _i.e._ in equilibrium the chain steps from $x$ to $y$ as often as from $y$ to $x$. The chain above steps from $1$ to $2$ but never from $2$ to $1$.
]

#lemma[
  If a measure $vb(lambda)$ satisfies the detailed balance condition
  $
    lambda_i P(i, j) = lambda_j P(j, i) quad forall i, j in I,
  $
  then $vb(lambda)$ is invariant for $matbold(P)$.

]

#proof[
  Assuming the detailed balance condition, we have
  $
    sum_i lambda_i P(i, j) = sum_i lambda_j P(j, i) = lambda_j sum_i P(j, i) = lambda_j
  $
  for all $j in I$.
]

#intuition[
  Call $lambda_i P(i, j)$ the flow from $i$ to $j$. As the rows of $matbold(P)$ sum to $1$, invariance says that the flow into each state equals the flow out of it,
  $
    sum_i lambda_i P(i, j) = lambda_j = sum_i lambda_j P(j, i),
  $
  and detailed balance says this holds term by term. An invariant measure need not satisfy detailed balance: below are the flows for the uniform $vb(pi)$ of the walk on ${0, 1, 2}$ with $P(i, i + 1) = 2\/3$ and $P(i, i - 1) = 1\/3$ (mod $3$) #fade[[the next example with $n = 3$]]. Each state has flow $1\/3$ in and $1\/3$ out, but the flows of $2\/9$ (blue) go round one way and those of $1\/9$ the other, so there is a net flow of $1\/9$ round $0 -> 1 -> 2 -> 0$.
  #let forward = (
    stroke: rule("blue"),
    mark: (fill: rule("blue"), stroke: rule("blue")),
    label: (fill: ink("blue")),
  )
  #markov-chain(
    (
      "0": ("1": $2/9$, "2": $1/9$),
      "1": ("2": $2/9$, "0": $1/9$),
      "2": ("0": $2/9$, "1": $1/9$),
    ),
    spacing: 4,
    style: ("0-1": forward, "1-2": forward, "2-0": forward),
  )
]

#example[
  Suppose $vb(X)$ is a random walk on the circle $ZZ_n = {0, 1, ..., n-1}$ with
  $
    P(i, i + 1 space (mod n)) = (2)/(3), quad P(i, i - 1 space (mod n)) = (1)/(3).
  $
  Then,
  $
    pi_i = pi_(i+1) (1)/(3) + pi_(i-1) (2)/(3)
  $
  so $pi_i = (1)/(n)$ is an invariant distribution. Also, since the chain is irreducible, it is unique. Moreover, it satisfies
  $
    pi_i (2)/(3) != pi_(i+1) (1)/(3)
  $
  so the chain is not reversible.
]

#example[
  Suppose $vb(X)$ is again a random walk on $ZZ_n$, with
  $
    P(i, i+1 space (mod n)) = (2)/(3) quad 1 <= i <= n-2,\
    P(i, i-1 space (mod n)) = (1)/(3) quad 1 <= i <= n-2,\
    P(0, 0) = (1)/(3), quad
    P(0, 1) = (2)/(3),\
    P(n-1, n-1) = (2)/(3), quad
    P(n-1, n-2) = (1)/(3).
  $
  For this chain, it is easy to check that $lambda_i = 2^i$ satisfies the detailed balance condition, so it is invariant, since
  $
    lambda_i P(i, j)= lambda_j P(j, i).
  $
]

#example[
  Suppose $G = (V, E)$ is a finite simple connected undirected graph. Let $d(x)$ be the degree of vertex $x$. Let
  $
    P(x, y) = cases(
      (1)/(d(x)) quad & "if" (x, y) in E,
      0 & "otherwise".
    )
  $
  Then consider the distribution
  $
    pi_x = (d(x))/(2abs(E)) quad forall x in V.
  $
  Then $vb(pi)$ satisfies the detailed balance condition, since for $(x, y) in E$,
  $
    pi_x P(x, y) = (d(x))/(2abs(E)) (1)/(d(x)) = (1)/(2abs(E)) = (d(y))/(2abs(E)) (1)/(d(y)) = pi_y P(y, x).
  $
  Since the chain is irreducible, $vb(pi)$ is the unique invariant distribution, and it is reversible.
]

#lecture-separator(lecture: 11, date: "2026-11-12")

== Convergence to Equilibrium

Recall that if $vb(X)$ is a Markov chain on a finite state space $I$, and
$
  PP(X_n = i) -> pi_i
$
as $n -> oo$ for all $i$, then $vb(pi)$ is invariant for $vb(X)$.

=== Periodicity

#definition[Periodicity][
  Let $matbold(P)$ be a transition matrix. A state $i$ has period
  $
    d_i = gcd Set(n>=1; P_(i i) (n) > 0).
  $
  A state $i$ is aperiodic if $d_i = 1$.

  The chain $vb(X)$ (or the transition matrix $matbold(P)$) is aperiodic if all states are aperiodic.
]

#intuition[
  For example:
  - The chain of @ex-1 with $alpha = beta = 1$ alternates between $0$ and $1$, so $P_00 (n) > 0$ iff $n$ is even, and $d_0 = 2$.
  - In the chain on ${1, 2, 3}$ from Chapter 1, $P_11 (1) = P_11 (2) = 0$, but the chain can return to $1$ in $3$ steps, $1 -> 2 -> 3 -> 1$, and in $4$ by staying once at $2$ or $3$. So $d_1 = gcd(3, 4, ...) = 1$, not the length $3$ of the shortest return.

  Periodicity can stop $P_(i i)(n)$ from converging. Both chains are irreducible with an invariant distribution, $(1\/2, 1\/2)$ and $(1\/5, 2\/5, 2\/5)$. In the first, which has period $2$, $P_00 (n)$ alternates between $1$ and $0$; in the second, which is aperiodic, $P_11 (n) -> 1\/5$, as found in Chapter 1. #fade[[The first is the case $alpha + beta = 2$ left out of the example on ${0, 1}$ at the start of the chapter.]]
]

#lemma[
  A state $i$ is aperiodic if and only if $P_(i i) (n) > 0$ for all $n$ sufficiently large.
]

#proof[
  #fade[[$arrow.l.double$]] Obvious.

  #fade[[$=>$]] Let $D(i) = Set(n>=1; P_(i i) (n) > 0)$. Then $gcd D(i) = 1$, and it is closed under addition, _i.e._ if $m, n in D(i)$, then
  $
    P_(i i) (m + n) >= P_(i i) (m) P_(i i) (n) > 0
  $
  So $m + n in D(i)$. The result is a consequence of the elementary number-theoretic fact that any set $D subset.eq NN$ with these properties contains all $n >= N$ for some $N$.

  #fade-block[
    Excerpt from lecturer's notes: Suppose next that $d_i = 1$ and set $D(i) = Set(n >= 1; P^n (i, i) > 0)$. We first show that $D(i)$ contains two consecutive integers. First of all, if $m, n in D(i)$, then also $m + n in D(i)$. Suppose now that the minimum distance between any two elements of $D(i)$ is $r >= 2$ and let $n, m in D(i)$ with $n = m + r$. Let also $k in D(i)$ with $k = l r + s$ with $l in NN$ and $0 < s < r$, which exists since otherwise only multiples of $r$ would be contained in $D(i)$ and this would contradict that $op("g.c.d.")(D(i)) = 1$. Letting $a = (l + 1) n$ and $b = (l + 1) m + k$ we see that both $a$ and $b$ are contained in $D(i)$ and
    $
      a - b = r - s in (0, r),
    $
    which contradicts the definition of $r$ as the minimum distance between any two elements of $D(i)$. Therefore, $D(i)$ contains two consecutive numbers $n_1, n_1 + 1$. Since $a n_1 + b(n_1 + 1) in D(i)$ for all $a, b$ it easily follows that $D(i)$ contains all $n$ sufficiently large ($n >= n_1^2$) and this completes the proof.
  ]
]

#intuition[
#block(breakable: false)[
  For example, if $3, 5 in D(i)$, then $D(i)$ contains every sum of $3$s and $5$s, such as $8 = 3 + 5$, $9 = 3 + 3 + 3$ and $10 = 5 + 5$. Adding $3$s to these gives every integer from $8$ on, while $1, 2, 4, 7$ are not such sums.
]
]

#lemma[
  Let $matbold(P)$ be irreducible. If there is an aperiodic state $i$, then all states are aperiodic.
]

#proof[
  Let $j in I$. By irreducibility, we can find $m, l$ such that $P_(i j) (m) > 0$ and $P_(j i) (l) > 0$. Then
  $
    P_(j j) (l + n + m) >= P_(j i) (l) P_(i i) (n) P_(i j) (m) > 0
  $
  for all $n$ sufficiently large. Hence $j$ is aperiodic.
]

Thus, aperiodicity is a communicating class property.

#example[
  If $matbold(P)$ is irreducible and $P(i, i) > 0$ for some $i in I$, then the whole chain is aperiodic.
]

=== Coupling

#theorem[
  Let $vb(X) ~ "Markov"(vb(lambda), matbold(P))$ on $I$ be irreducible, aperiodic, and have invariant distribution $vb(pi)$. Then
  $
    PP(X_n = j) -> pi_j "as" n-> oo "for all" j in I.
  $
  In particular, taking $vb(lambda) = vb(delta)_i$,
  $
    P_(i j) (n) = PP(X_n = j mid(|) X_0 = i) -> pi_j "as" n-> oo "for all" i, j in I.
  $
]

#proof[
  Let $vb(Y) = (Y_n)_(n >=0) ~ "Markov"(vb(pi), matbold(P))$ be independent of $vb(X)$.

  Consider the new process $vb(W) = (W_n)_(n>=0)$ defined by $W_n = (X_n, Y_n)$. Then $vb(W)$ is a Markov chain on $I times I$, with transition matrix
  $
    tilde(P)((x, y), (x', y')) = P(x, x') P(y, y') quad forall x, x', y, y' in I.
  $
  We wish to show that $vb(W)$ is irreducible. Note that
  $
    tilde(P)_((x, y), (x', y')) (n) = P_(x x') (n) P_(y y') (n).
  $
  By irreducibility of the original chain, we can find $m, l$ such that $P_(x x') (m) > 0$ and $P_(y y') (l) > 0$. Then
  $
    tilde(P)_((x, y), (x', y')) (m + l + n) >= P_(x x') (m) P_(x' x')(l + n) P_(y y') (l) P_(y' y')(m + n) > 0
  $
  since $P_(x' x')(l + n) > 0$ and $P_(y' y')(m + n) > 0$ for all $n$ sufficiently large by aperiodicity. Hence $vb(W)$ is irreducible.

  Now define $T = inf Set(n >= 1; W_n = (a, a))$ for some fixed $a in I$. Let $tilde(pi)(x, y) = pi(x) pi(y)$. Then
  $
    sum_(x, y) tilde(pi) (x, y) tilde(P) ((x, y), (x', y')) & = sum_(x) pi(x) P(x, x') sum_(y) pi(y) P(y, y') \
                                                            & = pi(x') pi(y') #eq-note[by invariance of $pi$] \
                                                            & = tilde(pi) (x', y')
  $
  Therefore, $tilde(vb(pi))$ is invariant for $tilde(matbold(P))$. Therefore, $tilde(matbold(P))$ is positive recurrent. In particular, $PP(T < oo) = 1$.

  Now define a new process $vb(Z) = (Z_n)_(n>=0)$ on $I$ as
  $
    Z_n = cases(
      X_n quad & "for" n < T,
      Y_n quad & "for" n >= T.
    )
  $
  Next we aim to show that $vb(Z) ~ "Markov"(vb(lambda), matbold(P))$.

  By definition $T >= 1$, so $Z_0 = X_0 ~ vb(lambda)$. Consider for some event $A = {Z_0 = z_0, ..., Z_(n-1) = z_(n-1)}$,
  $
    &quad PP(Z_(n+1) = y mid(|)Z_n = x, A) \
    &= PP(Z_(n+1) = y, T > n mid(|)Z_n = x, A) + PP(Z_(n+1) = y, T <= n mid(|)Z_n = x, A)\
    &= PP(Z_(n+1) = y mid(|)Z_n = x, A, T > n) dot PP(T > n mid(|)Z_n = x, A) + PP(Z_(n+1) = y mid(|)Z_n = x, A, T <= n) dot PP(T <= n mid(|)Z_n = x, A). \
  $
  We have
  $
    PP(Z_(n+1) = y mid(|)Z_n = x, A, T > n) & = PP(Z_(n+1) = y mid(|)X_n = x, A, T > n) \
    & = sum_(z in I) PP(Z_(n+1) = y, Y_n = z mid(|)X_n = x, A, T > n) \
    &= sum_(z in I) underbracket(PP(Z_(n+1) = y mid(|)X_n = x, Y_n = z, A, T > n), = P(x, y) "by Markov property for" vb(W)) dot PP(Y_n = z mid(|)X_n = x, A, T > n) \
    &= P(x, y). \
  $
  Similarly, we can show that
  $
    PP(Z_(n+1) = y mid(|)Z_n = x, A, T <= n) = P(x, y).
  $
  Therefore, $PP(Z_(n+1) = y mid(|)Z_n = x, A) = P(x, y)$. Hence, $vb(Z) ~ "Markov"(vb(lambda), matbold(P))$.

  Hence,
  $
    abs(PP(X_n = x) - pi(x)) & = abs(PP(Z_n = x) - PP(Y_n = x)) \
    & = abs(PP(Z_n = x, T > n) + underbracket(PP(Z_n = x, T <= n), = PP(Y_n = x, T <= n)) - PP(Y_n = x, T > n) - PP(Y_n = x, T <= n)) \
    &= abs(PP(Z_n = x, T > n) - PP(Y_n = x, T > n)) \
  $
  But this is the absolute difference of two non-negative quantities, each of which is bounded by $PP(T > n)$. Hence, since we have $PP(T<oo) = 1$, we conclude that
  $
    abs(PP(X_n = x) - pi(x)) <= PP(T > n) -> 0 "as" n-> oo.
  $
]

#intuition[#block(breakable: false)[
  $vb(Z)$, drawn solid, follows $vb(X)$ until the two chains meet at $(a, a)$, and $vb(Y)$ (blue) from then on.
  #canvas({
    import draw: *
    let (dx, dy) = (0.8, 0.5)
    let pt(t, s) = (t * dx, s * dy)
    let meet = 6
    let xs = (4, 3, 4, 3, 4, 3, 2, 3, 4, 4, 4)
    let ys = (0, 1, 0, 1, 2, 1, 2, 1, 2, 3, 3)
    for s in range(5) {
      line(pt(-0.3, s), pt(10.3, s), stroke: rule("gray") + 0.3pt)
    }
    line(pt(meet, -0.6), pt(meet, 4.5), stroke: (paint: rule("gray"), thickness: 0.6pt, dash: "dashed"))
    content(pt(meet, -0.6), $T$, anchor: "north", padding: 0.1)
    content(pt(0, -0.6), $0$, anchor: "north", padding: 0.1)
    line(..range(meet, 11).map(t => pt(t, xs.at(t))), stroke: (paint: rule("gray"), thickness: 0.7pt, dash: "dashed"))
    line(..range(0, meet + 1).map(t => pt(t, ys.at(t))), stroke: (paint: rule("blue"), thickness: 0.7pt, dash: "dashed"))
    line(..range(meet, 11).map(t => pt(t, ys.at(t))), stroke: rule("blue") + 0.9pt)
    line(..range(0, meet + 1).map(t => pt(t, xs.at(t))), stroke: colors.text + 0.9pt)
    for t in range(meet) {
      circle(pt(t, xs.at(t)), radius: 0.05, fill: colors.text, stroke: none)
    }
    for t in range(meet, 11) {
      circle(pt(t, ys.at(t)), radius: 0.05, fill: rule("blue"), stroke: none)
    }
    content(pt(-0.3, 4), $vb(X)$, anchor: "east", padding: 0.1)
    content(pt(-0.3, 0), text(fill: ink("blue"), $vb(Y)$), anchor: "east", padding: 0.1)
    content(pt(10.3, 2), text(fill: ink("gray"), $a$), anchor: "west", padding: 0.1)
  })
  $T$ is a stopping time for $vb(W)$ and $W_T = (a, a)$, so by the strong Markov property for $vb(W)$, given its path up to $T$, the paths of $vb(X)$ and $vb(Y)$ after $T$ are independent $"Markov"(vb(delta)_a, matbold(P))$ chains, as $tilde(matbold(P))$ moves the two coordinates independently by $matbold(P)$. So switching from $vb(X)$ to $vb(Y)$ at $T$ does not change the distribution, and $vb(Z)$ has the same distribution as $vb(X)$. As $vb(Y)$ starts from $vb(pi)$, $Y_n ~ vb(pi)$ for every $n$, so $PP(X_n = x)$ and $pi_x$ can only differ through the event ${T > n}$.

  The chains meet because $vb(W)$ is irreducible, which is where aperiodicity is used, and has the invariant distribution $tilde(vb(pi))$. An irreducible chain with an invariant distribution is positive recurrent, so $vb(W)$ hits $(a, a)$ with probability $1$ from any start, by the theorem on positive recurrence above and the one on recurrent classes in Chapter 3. Without aperiodicity they need not meet: in the chain of @ex-1 with $alpha = beta = 1$, copies started at $0$ and $1$ swap places at every step, so $vb(W)$ never reaches $(0, 0)$ or $(1, 1)$.
]]

#lecture-separator(lecture: 12, date: "2026-11-17")

Recall that we have shown that if $matbold(P)$ is irreducible and aperiodic, then it is positive recurrent if and only if it has an invariant distribution $vb(pi)$, in which case
$
  P_(x y)(n) -> pi_y "as" n-> oo "for all" x, y in I.
$

#theorem[
  Let $matbold(P)$ be irreducible and aperiodic. If $matbold(P)$ is null recurrent, then
  $
    P_(x y)(n) -> 0 "as" n -> oo "for all" x, y in I.
  $
]
#proof[
  Consider, as in the previous proof, the transition matrix
  $
    tilde(P)((x, y), (x', y')) = P(x, x') P(y, y') quad forall x, x', y, y' in I.
  $
  As shown there, $tilde(matbold(P))$ is irreducible, since $matbold(P)$ is irreducible and aperiodic.

  - If $tilde(P)$ is transient, then
    $
      oo > sum_(n>=1) tilde(P)^n ((x, x), (y, y)) = sum_(n>=1) P_(x y)(n)^2 quad forall x, y in I.
    $
    Thus $P_(x y)(n) -> 0$ as $n -> oo$ for all $x, y in I$.

  - If $tilde(P)$ is recurrent, then pick and fix $y in I$. Then define as before
    $
      nu_y (x) = EE_y [sum_(n=0)^(T_y-1) bb(1)[X_n = x]] quad forall x in I.
    $
    Note that
    $
      nu_y (I) & = sum_(x in I) nu_y (x) \
               & = EE_y [sum_(n=0)^(T_y-1) sum_(x in I) bb(1)[X_n = x]] \
               & = EE_y [T_y] = oo. #eq-note[as $matbold(P)$ is null recurrent] \
    $
    Then for any arbitrary $M > 0$ there exists a finite $A subset.eq I$ such that
    $
      nu_y (A) > M.
    $
    Then define a new probability measure
    $
      mu(x) = \"nu_y (x mid(|) A)\" = (nu_y (x))/(nu_y (A)) bb(1)[x in A].
    $
    Since $matbold(P)$ is irreducible and recurrent, $nu_y$ is invariant for $matbold(P)$ by @thm-expected-number-of-visits, and hence
    $
      (vb(mu) matbold(P)^n)_y & = sum_(x in I) mu(x) P_(x y)(n) \
                              & = sum_(x in A) (nu_y (x))/(nu_y (A)) P_(x y)(n) \
                              & <= (1)/(nu_y (A)) sum_(x in I) nu_y (x) P_(x y)(n) \
                              & = (1)/(nu_y (A)) nu_y (y) #eq-note[invariance of $nu_y$] \
                              & = (1)/(nu_y (A)) < (1)/(M). \
    $
    Define two new Markov chains by selecting an arbitrary $x in I$ and letting
    $
      vb(X)' = (X'_n)_(n>=0) ~ "Markov"(vb(delta)_x, matbold(P)), quad vb(Y) = (Y_n)_(n>=0) ~ "Markov"(vb(mu), matbold(P)).
    $
    Note that $vb(X)'$ and $vb(Y)$ are independent.

    Also, let $T = inf Set(n >= 1; X'_n = Y_n = x)$. As we showed last time, since $tilde(matbold(P))$ is irreducible and recurrent,
    $
      PP(T < oo) = 1.
    $
    Finally, let
    $
      Z_n = cases(
        Y_n quad & "if" n < T,
        X'_n quad & "if" n >= T.
      )
    $
    As we showed last time, $vb(Z) = (Z_n)_(n>=0) ~ "Markov"(vb(mu), matbold(P))$. Hence we can bound
    $
      P_(x y)(n) = PP(X'_n = y) & = PP(X'_n = y, T > n) + PP(X'_n = y, T <= n) \
                                & = PP(X'_n = y, T > n) + PP(Z_n = y, T <= n) \
                                & <= PP(T > n) + PP(Z_n = y) \
                                & <= PP(T > n) + (1)/(M). #eq-note[as $PP(Z_n = y) = (vb(mu) matbold(P)^n)_y$]
    $
    Therefore
    $
      limsup_(n -> oo) P_(x y)(n) <= (1)/(M)
    $
    but $M > 0$ was arbitrary, so $lim_(n->oo) P_(x y)(n) = 0$.
]

#intuition[
  Together with the convergence theorem, for $matbold(P)$ irreducible and aperiodic, $P_(x y)(n) -> 1 \/ EE_y [T_y]$ in every case, with $1 \/ oo = 0$:
  #align(center, table(
    columns: 3,
    table.header[$matbold(P)$][$EE_y [T_y]$][$lim_(n -> oo) P_(x y)(n)$],
    [positive recurrent], [finite], [$pi_y = 1 \/ EE_y [T_y]$],
    [null recurrent], [$oo$], [$0$],
    [transient], [$oo$], [$0$],
  ))
  In the transient case, choosing $m$ with $P_(y x)(m) > 0$ gives $P_(x y)(n) <= P_(y y)(m + n) \/ P_(y x)(m)$, and $sum_n P_(y y)(n) < oo$ by Chapter 3, so $P_(x y)(n) -> 0$.
]

== The Ergodic Theorem

#theorem[
  Let $vb(X) ~ "Markov"(vb(lambda), matbold(P))$ be irreducible, aperiodic and positive recurrent, with invariant distribution $vb(pi)$. Then, for any $x in I$,
  $
    (1)/(n) sum_(i=0)^(n-1) bb(1)[X_i = x] -> pi_x "as" n-> oo "almost surely".
  $
]

#fade-block[

  Note that what the theorem really says is that
  $
    PP (Set(omega; (1)/(n) sum_(i=0)^(n-1) bb(1)[X_i (omega) = x] -> pi_x "as" n -> oo)) = 1,
  $
  for any $x in I$. It is a simple measure-theoretic fact that, since $I$ is countable,
  $
    PP((1)/(n) sum_(i=0)^(n-1) bb(1)[X_i = x] -> pi_x "as" n->oo, forall x in I) = 1.
  $
  Now let $f: I->RR$ be any function such that $EE_pi [abs(f(X))] < oo$, _i.e._
  $
    sum_(x in I) abs(f(x)) pi_x < oo.
  $
  Then
  $
    (1)/(n) sum_(i=0)^(n-1) f(X_i)& = (1)/(n) sum_(i=0)^(n-1) sum_(x in I) f(x) bb(1)[X_i = x] \
    &= sum_(x in I) f(x) underbracket((1)/(n) sum_(i=0)^(n-1) bb(1)[X_i = x], -> pi_x "almost surely")\
    & -> sum_(x in I) f(x) pi_x = EE_pi [f(X)] "as" n-> oo "almost surely".
  $
  This is exactly the usual statement of the Law of Large Numbers #fade[[_cf._ IA Probability]].
]

#proof[
  #fade[[Non-examinable.]]

  Fix $x$. Write $V_n (x) = sum_(i=0)^(n-1) bb(1)[X_i = x]$ for the number of visits to $x$ before time $n$. Consider the recurrence times
  $
      T_x^((0)) & = 0 \
    T_x^((k+1)) & = inf Set(n > T_x^((k)); X_n = x)
  $
  if the chain starts at $X_0 = x$. What we want to show is that $(1)/(n) V_n (x) -> pi_x$ almost surely.

  But we know that
  $
    PP(T_x < oo) = 1,
  $
  so by the @thm-strong-markov-property[strong Markov property],
  $
    (X_(T_x + n))_(n>=0) ~ "Markov"(vb(delta)_x, matbold(P))
  $
  is independent of $(X_0, X_1, ..., X_(T_x))$. Therefore, the long-term behaviour of $(1)/(n) V_n (x)$ is independent of the initial distribution $vb(lambda)$, so we can assume WLOG that $vb(lambda) = vb(delta)_x$.

  Define the successive excursion lengths, $S_x^((k))$, by
  $
    S_x^((k)) = cases(
      T^((k))_x - T^((k-1))_x quad & "if" T^((k))_x < oo,
      oo quad & "otherwise"
    ) quad "for" k >= 1.
  $
  Then, by the definitions we have
  $
    T_x^((V_n (x) - 1)) <= n-1 quad <=> quad S_x^((1)) + ... + S_x^((V_n (x) - 1)) <= n-1.
  $
  Similarly,
  $
    T_x^((V_n (x))) >= n quad <=> quad S_x^((1)) + ... + S_x^((V_n (x))) >= n.
  $
  Hence,
  $
    S_x^((1)) + ... + S_x^((V_n (x) - 1)) <= n <= S_x^((1)) + ... + S_x^((V_n (x))),
  $
  _i.e._
  #set math.equation(numbering: "(1)")
  $
    (V_n (x) - 1)/(V_n (x)) dot (1)/(V_n (x) - 1) sum_(k=1)^(V_n (x) - 1) S_x^((k)) <= (n)/(V_n (x)) <= (1)/(V_n (x)) sum_(k=1)^(V_n (x)) S_x^((k)).
  $ <eq-4-1>
  #set math.equation(numbering: none)

  Note that by recurrence, $V_n (x) -> oo$ almost surely, and also, by the @thm-strong-markov-property[strong Markov property], the process $(S_x^((k)))_(k>=1)$ is i.i.d. with mean
  $
    EE_x [S_x^((k))] = EE_x [T_x] = (1)/(pi_x).
  $
  Therefore, by the usual Strong Law of Large Numbers, both sides of @eq-4-1 $-> (1)/(pi_x)$ almost surely. Hence
  $
    (n)/(V_n (x)) -> (1)/(pi_x) "as" n-> oo "almost surely",
  $
  _i.e._ $(1)/(n) V_n (x) -> pi_x$ almost surely.

]

#intuition[#block(breakable: false)[
  The path splits into excursions from $x$, which are i.i.d. with mean length $EE_x [T_x] = 1 \/ pi_x$, and each contains one visit to $x$.
  #canvas(length: 0.95cm, {
    import draw: *
    let path = (
      ((0, 0), (0.4, 0.55), (0.8, 0.3), (1.2, 0.95), (1.6, 0.55), (2.0, 0.75), (2.4, 0)),
      ((2.4, 0), (2.8, 0.45), (3.2, 0.2), (3.6, 0)),
      ((3.6, 0), (4.0, 0.6), (4.4, 0.35), (4.8, 1.05), (5.2, 0.8), (5.6, 1.2), (6.0, 0.5), (6.4, 0.75), (6.8, 0)),
      ((6.8, 0), (7.2, 0.5), (7.6, 0.25), (8.0, 0.85)),
    )
    line((-0.3, 0), (8.6, 0), stroke: rule("gray") + 0.5pt, mark: (end: "stealth", fill: rule("gray"), stroke: rule("gray")))
    content((-0.4, 0), $x$, anchor: "east")
    line((5.2, -0.1), (5.2, 1.45), stroke: (paint: rule("gray"), thickness: 0.6pt, dash: "dashed"))
    content((5.2, -0.2), $n$, anchor: "north")
    for p in path { line(..p) }
    line((8.0, 0.85), (8.4, 1.15), stroke: (dash: "dashed"))
    for (a, b, lab) in ((0, 2.4, $S_x^((1))$), (2.4, 3.6, $S_x^((2))$), (3.6, 6.8, $S_x^((3))$)) {
      let y = 1.75
      let (a, b) = (a + 0.1, b - 0.1)
      line((a, y - 0.12), (a, y), (b, y), (b, y - 0.12), stroke: 0.4pt)
      content(((a + b) / 2, y), lab, anchor: "south")
    }
    for (t, lab, hue) in ((0, $0$, "blue"), (2.4, $T_x^((1))$, "blue"), (3.6, $T_x^((2))$, "blue"), (6.8, $T_x^((3))$, none)) {
      circle((t, 0), radius: 0.07, fill: if hue == none { colors.text } else { rule(hue) }, stroke: none)
      content((t, -0.2), lab, anchor: "north")
    }
  })
  Here $V_n (x) = 3$, counting the visits in blue, and time $n$ falls in the third excursion from $x$, between $S_x^((1)) + S_x^((2))$ and $S_x^((1)) + S_x^((2)) + S_x^((3))$, as in @eq-4-1.

  The theorem is about the fraction of time one path spends at $x$, whereas the convergence theorem is about the distribution of $X_n$ at one large time $n$. The proof does not use aperiodicity, so the theorem holds without it: the chain of @ex-1 with $alpha = beta = 1$ spends half its time at $0$, so $V_n (0) \/ n -> 1\/2 = pi_0$, although $P_00 (n)$ does not converge.
]]
