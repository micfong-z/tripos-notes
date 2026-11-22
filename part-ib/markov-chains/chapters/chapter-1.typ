#import "../prelude.typ": *
#show: chapter.with(1)

#lecture-separator(lecture: 1, date: "2026-10-08")

Throughout the course, we will always implicitly assume that all our random variables (RVs) are defined on some underlying probability space $(Omega, cal(F), PP)$.


= Definitions

#definition[Markov Chain][
  A *Markov chain* is a *random process* (or *stochastic process*)
  $
    vb(X) = (X_0, X_1, ...) = (X_n)_(n >= 0)
  $
  taking values in a discrete state space $I$, with the property that
  $
    PP(underbracket(X_(n+1) = x_(n+1), "future") mid(|) underbracket(X_n = x_n, "present"), underbracket(X_(n-1) = x_(n-1)\, ...\, X_0 = x_0, "past")) = PP(X_(n+1) = x_(n+1) mid(|) X_n = x_n),
  $
  for all paths $x_0, ..., x_(n+1)$ of values in $I$ and all $n >= 0$.

  If $PP(X_(n+1) = y mid(|) X_n = x)$ is independent of $n$, then the Markov chain (MC) $vb(X)$ is called *homogeneous* and all MCs will be assumed to be homogeneous in this course. In this course, we call
  $
    matbold(P) = (P_(x y))_(x, y in I)
  $
  the *transition matrix* of $vb(X)$, where $P_(x y) = P(x, y)$ is the probability of transitioning from state $x$ to state $y$ in one time step.

  We say $matbold(P)$ is a *stochastic matrix* because each row is a distribution on $I$:
  $
    P_(x y) >= 0 quad forall x, y, quad "and" quad sum_(y in I) P_(x y) = 1 quad forall x in I.
  $
]

#intuition[
  The following process is not a Markov chain. Let $X_0 = 0$ and $X_1 = plus.minus 1$ with probability $1/2$ each, and from then on let $X_n$ move by $plus.minus 1$, repeating its previous step with probability $2/3$ and reversing it with probability $1/3$. Then
  $
    PP(X_3 = 1 mid(|) X_2 = 0, X_1 = -1, X_0 = 0) = 2/3, quad PP(X_3 = 1 mid(|) X_2 = 0, X_1 = 1, X_0 = 0) = 1/3,
  $
  so given $X_2 = 0$, the distribution of $X_3$ still depends on $X_1$. Adding the last step to the state gives a Markov chain: $Y_n = (X_n, X_n - X_(n-1))$, $n >= 1$, on $ZZ times {plus.minus 1}$ goes from $(x, s)$ to $(x + s, s)$ with probability $2/3$ and to $(x - s, -s)$ with probability $1/3$.
]

#example[
  For $I = {0,1}$, consider
  $
    matbold(P) = mat(delim: "[", 1-alpha, alpha; beta, 1-beta),
  $
  we have the Markov chain illustrated as follows:

  #markov-chain((
    "0": ("1": $alpha$, "0": $1-alpha$),
    "1": ("0": $beta$, "1": $1-beta$),
  ))
] <ex-1>

#example[
  For $I = {1, 2, 3}$, consider
  $
    matbold(P) = mat(delim: "[", (1)/(3), (1)/(3), (1)/(3); (1)/(2), 0, (1)/(2); 0, 0, 1),
  $
  we have the Markov chain illustrated as follows:
  #markov-chain((
    "1": ("1": $(1)/(3)$, "2": $(1)/(3)$, "3": $(1)/(3)$),
    "2": ("1": $(1)/(2)$, "2": $0$, "3": $(1)/(2)$),
    "3": ("1": $0$, "2": $0$, "3": $1$),
  ))
  It can be seen that in the long run, we will settle at state 3.
]

#definition[
  A process $vb(X) = (X_n)_(n >= 0)$ with values in a discrete set $I$ is $vb(X) ~ "Markov"(vb(lambda), matbold(P))$ where $vb(lambda) = (lambda_i)_(i in I)$ is a probability distribution on $I$, written as a row vector, and $matbold(P)$ is a transition matrix, if $vb(X)$ is a Markov chain with transition matrix $matbold(P)$ and initial distribution $vb(lambda)$, _i.e._
  $
                                                          PP(X_0 = i) & = lambda_i \
    PP(X_n = y mid(|) X_(n-1) = x, X_(n-2) = x_(n-2), ..., X_0 = x_0) & = PP(X_n = y mid(|) X_(n-1) = x) = P_(x y),
  $
  for all $i in I$, $n >= 1$ and $x, y, x_0, ..., x_(n-2) in I$.
]

#theorem[
  Let $vb(lambda)$ be a distribution on $I$ and $matbold(P)$ be a transition matrix. Then a sequence $vb(X) ~ "Markov"(vb(lambda), matbold(P))$ if and only if
  $
    PP(X_0 = x_0, X_1 = x_1, ..., X_n = x_n) = lambda_(x_0) P(x_0, x_1) dots.c P(x_(n-1), x_n),
  $
  for all $x_0, ..., x_n in I$ and $n >= 1$, and
  $
    PP(X_0 = i) = lambda_i quad forall i in I.
  $

] <thm-markov-chain-1>

#lecture-separator(lecture: 2, date: "2026-10-13")

#proof[
  #fade[[$=>$]] We have
  $
    PP(X_0 = x_0, ..., X_n = x_n) &= PP(X_n = x_n mid(|) X_(n-1) = x_(n-1), ..., X_0 = x_0) PP(X_0 = x_0, ..., X_(n-1) = x_(n-1)) \
    &= P(x_(n-1), x_n) PP(X_0 = x_0, ..., X_(n-1) = x_(n-1)) \
    &= dots.c quad "(iterating)"\
    &= P(x_(n-1), x_n) P(x_(n-2), x_(n-1)) dots.c P(x_0, x_1) PP(X_0 = x_0) \
    &= lambda_(x_0) product_(i=1)^n P(x_(i-1), x_i). \
  $

  #fade[[$arrow.l.double$]] We further have,

  $
    PP(X_(n+1) = x_(n+1) mid(|) X_n = x_n, X_(n-1) = x_(n-1), ..., X_0 = x_0) &= PP(X_0 = x_0, ..., X_(n+1) = x_(n+1))/PP(X_0 = x_0, ..., X_n = x_n) \
    &= (lambda_(x_0) P(x_0, x_1) dots.c P(x_(n-1), x_n) P(x_n, x_(n+1)))/(lambda_(x_0) P(x_0, x_1) dots.c P(x_(n-1), x_n)) \
    &= P(x_n, x_(n+1)) \
    &= PP(X_(n+1) = x_(n+1) mid(|) X_n = x_n) \
  $
]

#intuition[
  For the chain of @ex-1, the path $0, 1, 1, 0$ with the weight of each step:
  #fletcher-diagram(
    spacing: (5em, 0.4em),
    node((0, 0), $0$, stroke: colors.text + 0.6pt, shape: circle, inset: 0.45em),
    node((1, 0), $1$, stroke: colors.text + 0.6pt, shape: circle, inset: 0.45em),
    node((2, 0), $1$, stroke: colors.text + 0.6pt, shape: circle, inset: 0.45em),
    node((3, 0), $0$, stroke: colors.text + 0.6pt, shape: circle, inset: 0.45em),
    node((0, 1), text(fill: ink("gray"), $X_0$)),
    node((1, 1), text(fill: ink("gray"), $X_1$)),
    node((2, 1), text(fill: ink("gray"), $X_2$)),
    node((3, 1), text(fill: ink("gray"), $X_3$)),
    edge((-0.75, 0), (0, 0), $lambda_0$, "->"),
    edge((0, 0), (1, 0), $alpha$, "->"),
    edge((1, 0), (2, 0), $1 - beta$, "->"),
    edge((2, 0), (3, 0), cblue($beta$), "->", stroke: rule("blue") + 0.8pt),
  )
  $
    PP(X_0 = 0, X_1 = 1, X_2 = 1, X_3 = 0) & = lambda_0 dot alpha dot (1 - beta) dot cblue(beta), \
    PP(X_3 = 0 mid(|) X_0 = 0, X_1 = 1, X_2 = 1) & = (lambda_0 alpha (1 - beta) cblue(beta))/(lambda_0 alpha (1 - beta)) = cblue(beta) = P_10.
  $
  Every event about $X_0, ..., X_n$ is a disjoint union of events ${X_0 = x_0, ..., X_n = x_n}$, so $vb(lambda)$ and $matbold(P)$ determine its probability.
]

#remark[
  If $vb(X) = (X_n)_(n >= 0)$ is a Markov chain, then given $X_n$, $X_(n+1)$ and $X_(n-1)$ are conditionally independent but typically not independent.
]

#exercise[
  Check the above remark in a couple of examples of specific Markov chains.
]

#exercise[
  If $(X_n)_(n >= 0)$ are independent and identically distributed (i.i.d.) random variables, then $(X_n)_(n >= 0)$ is a Markov chain. What are $vb(lambda)$ and $matbold(P)$ in this case?
]

#definition[
  For any $i in I$, let $vb(delta)_i$ denote the probability distribution that places a unit mass at $i$, and
  $
    delta_(i j) = bb(1)[j = i].
  $
]

Recall the following:

- the random variables $X_0, X_1, ..., X_n$ are independent if
  $
    PP(X_0=x_0, ..., X_n=x_n) = product_(i=0)^n PP(X_i = x_i),
  $
  for all $x_0, ..., x_n$;

- the random variables in the process $vb(X) = (X_n)_(n>=0)$ are independent if $(X_0, ..., X_n)$ are independent $forall n$;

- the processes $vb(X)$ and $vb(Y)$ are independent if for any $0 <= t_1 < t_2 < ... < t_m$ and $0 <= s_1 < s_2 < ... < s_k$,

  $
    PP(X_(t_1) = x_1, ..., X_(t_m) = x_m, Y_(s_1) = y_1, ..., Y_(s_k) = y_k) = PP(X_(t_1) = x_1, ..., X_(t_m) = x_m) PP(Y_(s_1) = y_1, ..., Y_(s_k) = y_k),
  $
  for all $x_1, ..., x_m, y_1, ..., y_k$.

== The Markov Property

#theorem[Markov Property][
  Suppose $vb(X) = (X_n)_(n>=0) ~ "Markov"(vb(lambda), matbold(P))$. Let $m >= 0$ and $i in I$. Then, conditional on ${X_m = i}$, the new process $(X_(m+n))_(n>=0) ~ "Markov"(vb(delta)_i, matbold(P))$ and is independent of $(X_0, ..., X_m)$.
] <thm-markov-property>

#proof[
  Clearly $PP(X_m = j mid(|) X_m = i) = delta_(i j)$. Using @thm-markov-chain-1, we have
  $
    PP(X_m = x_m, ..., X_(m+n) = x_(m+n) mid(|) X_m = i) & = bb(1)[x_m = i] PP(X_m = x_m, ..., X_(m+n) = x_(m+n))/PP(X_m = i). \
  $
  But
  $
    PP(X_m = x_m, ..., X_(m+n) = x_(m+n)) & = sum_(x_0, ..., x_(m-1)) PP(X_0 = x_0, ..., X_(m+n) = x_(m+n)) \
    & = sum_(x_0, ..., x_(m-1)) lambda_(x_0) P(x_0, x_1) dots.c P(x_(m-1), x_m) dot P(x_m, x_(m+1)) dots.c P(x_(m+n-1), x_(m+n)) \
    &= PP(X_m = x_m) P(x_m, x_(m+1)) dots.c P(x_(m+n-1), x_(m+n)). \
  $
  Hence, using the two equations,
  $
    PP(X_m = x_m, ..., X_(m+n) = x_(m+n) mid(|) X_m = i) = bb(1)[x_m = i] P(x_m, x_(m+1)) dots.c P(x_(m+n-1), x_(m+n)),
  $
  which is the equivalent condition for a $"Markov"(vb(delta)_i, matbold(P))$ from @thm-markov-chain-1.

  To prove independence, fix times $m <= i_1 < i_2 < dots.c < i_k$ and states $x_0, ..., x_m, x_(m+1), ..., x_(m+k)$, and write
  $
    E = {X_0 = x_0, ..., X_m = x_m} quad "and" quad F = {X_(i_1) = x_(m+1), ..., X_(i_k) = x_(m+k)}
  $
  for the past and the future. We need $PP(E inter F mid(|) X_m = i) = PP(E mid(|) X_m = i) PP(F mid(|) X_m = i)$. Both sides vanish unless $x_m = i$, so take $x_m = i$, which gives $E subset.eq {X_m = i}$. Then,
  $
    PP(E inter F mid(|) X_m = i) & = (PP(E) PP(F mid(|) E))/PP(X_m = i) #eq-note($"by" PP(A, B) = PP(A)PP(B mid(|) A)$) \
    & = (lambda_(x_0) P(x_0, x_1) dots.c P(x_(m-1), x_m) PP(F mid(|) X_m = i))/PP(X_m = i) #eq-note[by @thm-markov-chain-1] \
    & = PP(E mid(|) X_m = i) PP(F mid(|) X_m = i). \
  $
]

#intuition[
  Here $m = 2$ and $F$ fixes $X_(m+1)$ and $X_(m+2)$, so $S$ is the blue product.
  #canvas({
    import draw: *
    let (dx, dy) = (2.2, 0.85)
    let pt(t, s) = (t * dx, -s * dy)
    let past = (paint: rule("gray"), thickness: 0.5pt)
    for a in range(3) {
      for b in range(3) { line(pt(0, a), pt(1, b), stroke: past) }
    }
    for b in range(3) { line(pt(1, b), pt(2, 1), stroke: past) }
    line(pt(2, 1), pt(3, 1), pt(4, 2), stroke: rule("blue") + 1pt)
    for t in range(5) {
      for s in range(3) {
        let used = t < 2 or (t, s) in ((2, 1), (3, 1), (4, 2))
        circle(pt(t, s), radius: 0.055, stroke: none, fill: if used { colors.text } else { rule("gray") })
      }
    }
    content((rel: (0, -0.32), to: pt(2, 1)), $i$)
    content((dx, 0.5), text(fill: ink("gray"))[sum $= PP(X_m = i)$])
    content((3 * dx, 0.5), text(fill: ink("blue"), $P(i, x_(m+1)) P(x_(m+1), x_(m+2))$))
    for (t, l) in ((0, $X_0$), (1, $X_1$), (2, $X_m$), (3, $X_(m + 1)$), (4, $X_(m + 2)$)) {
      content((t * dx, -2 * dy - 0.45), text(fill: ink("gray"), l))
    }
  })
  To see $PP(F mid(|) E) = PP(F mid(|) X_m = i)$ in the proof, let $N = i_k$. Then $E inter F$ is the disjoint union of the events ${X_0 = x_0, ..., X_(m-1) = x_(m-1), X_m = y_m, ..., X_N = y_N}$ over all $y_m, ..., y_N$ with $y_m = i$ and $y_(i_j) = x_(m+j)$ for each $j$; the other $y_t$ range over $I$. By @thm-markov-chain-1, each has probability
  $
    underbrace(lambda_(x_0) P(x_0, x_1) dots.c P(x_(m-1), i), PP(E)) dot P(y_m, y_(m+1)) dots.c P(y_(N-1), y_N),
  $
  so $PP(E inter F) = PP(E) S$, where $S$ is the sum of $P(y_m, y_(m+1)) dots.c P(y_(N-1), y_N)$ over these $y_m, ..., y_N$. Hence $PP(F mid(|) E) = S$, which depends only on $i$ and $F$. Summing $PP(E inter F) = PP(E) S$ over $x_0, ..., x_(m-1)$, _i.e._ over the gray paths, gives $PP(X_m = i, F) = PP(X_m = i) S$, so $PP(F mid(|) X_m = i) = S$ too.
]

== $n$-Step Transition Probabilities

Naturally, we wish to learn the long-run behaviour of a Markov chain.

#question[
  If $vb(X) ~ "Markov"(vb(lambda), matbold(P))$, what is $PP(X_n = x)$ for some fixed, or potentially large, $n$?
]

We have
$
  PP(X_n = x) & = sum_(x_0, ..., x_(n-1)) PP(X_0 = x_0, ..., X_n = x) \
              & = sum_(x_0, ..., x_(n-1)) lambda_(x_0) P(x_0, x_1) dots.c P(x_(n-1), x) \
              & = (vb(lambda) matbold(P)^n)_x
$

#theorem[
  If $vb(X) ~ "Markov"(vb(lambda), matbold(P))$, then,

  + $PP(X_n = x) = (vb(lambda) matbold(P)^n)_x$ for all $n >= 0$ and $x in I$.

  + $PP(X_(m +n) = y mid(|) X_(m) = x) = (matbold(P)^n)_(x y)$ for all $m, n >= 0$ and $x, y in I$.
]

#proof[

  + As above.

  + By @thm-markov-property[Markov property] and (1),
    $
      PP(X_(m+n) = y mid(|)X_m = x) = (vb(delta)_x matbold(P)^n)_y = (matbold(P)^n)_(x y).
    $
]

#intuition[
  For the chain of @ex-1, $(matbold(P)^2)_00$ is the sum over the two paths from $0$ to $0$, grouped by $X_1$, with the first step in blue and the second in red:
  #align(center, grid(
    columns: 2,
    column-gutter: 3em,
    align: horizon,
    canvas({
      import draw: *
      let (dx, dy) = (2.2, 1.1)
      let pt(t, s) = (t * dx, -s * dy)
      let (first, second) = (rule("blue") + 1pt, rule("red") + 1pt)
      line(pt(0, 0), pt(1, 0), stroke: first)
      line(pt(0, 0), pt(1, 1), stroke: first)
      line(pt(1, 0), pt(2, 0), stroke: second)
      line(pt(1, 1), pt(2, 0), stroke: second)
      for t in range(3) {
        for s in range(2) {
          let used = (t, s) in ((0, 0), (1, 0), (1, 1), (2, 0))
          circle(pt(t, s), radius: 0.055, stroke: none, fill: if used { colors.text } else { rule("gray") })
        }
      }
      content((0.5 * dx, 0), anchor: "south", text(fill: ink("blue"), $1 - alpha$))
      content((0.5 * dx, -0.5 * dy), anchor: "north-east", text(fill: ink("blue"), $alpha$))
      content((1.5 * dx, 0), anchor: "south", text(fill: ink("red"), $1 - alpha$))
      content((1.5 * dx, -0.5 * dy), anchor: "north-west", text(fill: ink("red"), $beta$))
      for s in range(2) { content((-0.6, -s * dy), text(fill: ink("gray"), $#s$)) }
      for t in range(3) { content((t * dx, -dy - 0.55), text(fill: ink("gray"), $X_#t$)) }
    }),
    $
      matbold(P) matbold(P) & = mat(delim: "[", cblue(1 - alpha), cblue(alpha); beta, 1 - beta) mat(delim: "[", cred(1 - alpha), alpha; cred(beta), 1 - beta), \
      (matbold(P)^2)_00 & = underbrace((cblue(1 - alpha)) (cred(1 - alpha)), "via" 0) + underbrace(cblue(alpha) cred(beta), "via" 1).
    $,
  ))
  In general, grouping the paths of length $m + n$ from $x$ to $y$ by their state $w$ at time $m$ gives the $(x, y)$ entry of $matbold(P)^(m+n) = matbold(P)^m matbold(P)^n$.
]

#notation[
  We will write
  $
    PP(X_(m + n) = y mid(|)X_m = x) = PP(X_n = y mid(|)X_0 = x) = P_(x y) (n) = (matbold(P)^n)_(x y).
  $

]


#example[
  Consider @ex-1 again, with $I = {0,1}$ and
  $
    matbold(P) = mat(delim: "[", 1-alpha, alpha; beta, 1-beta),
  $
  we have the Markov chain illustrated as follows:

  #markov-chain((
    "0": ("1": $alpha$, "0": $1-alpha$),
    "1": ("0": $beta$, "1": $1-beta$),
  ))
  We wish to find $P_00 (n)$. Since $matbold(P)^(n+1) = matbold(P)^n dot matbold(P)$, we have
  $
    P_00 (n+1) & = P_00 (n) (1-alpha) + underbracket(P_01 (n), 1-P_00 (n)) beta \
               & = beta + (1-alpha - beta) P_00 (n).
  $
  Noting that $P_00 (0) = 1$, solving gives
  $
    P_00(n) = cases(
      (beta)/(alpha + beta) + (alpha)/(alpha + beta) (1-alpha - beta)^n quad & "if" alpha + beta != 0,
      1 quad & "if" alpha + beta = 0.
    )
  $
]

#lecture-separator(lecture: 3, date: "2026-10-15")

We wish to answer the following question:

#question[
  How do we compute $P_11 (n)$, supposing that $abs(I) = k < oo$?
]

Observe that

+ If $matbold(P)$ has $k$ distinct, real eigenvalues $lambda_1, ..., lambda_k$, then it is diagonalisable,

  $
    matbold(P) = matbold(U) diagonalmatrix(lambda_1, lambda_2, dots.down, lambda_k) matbold(U)^(-1),
  $
  and hence
  $
    matbold(P)^n = matbold(U) diagonalmatrix(lambda_1^n, lambda_2^n, dots.down, lambda_k^n) matbold(U)^(-1).
  $
  Hence $P_11 (n) = sum_(i=1)^k a_i lambda_i^n$ for some constants $a_i$. The values of the coefficients can be found by using small values of $n$ to set up a system of linear equations.

+ If $matbold(P)$ has complex eigenvalues, they will come in conjugate pairs, _e.g._ if $lambda_1, ..., lambda_(k-2)$ are real and distinct, and $lambda_(k-1) = r ee^(ii theta) = r(cos theta + ii sin theta)$, then $lambda_k = overline(lambda_(k-1)) = r ee^(-ii theta) = r(cos theta - ii sin theta)$.

  Since $P_11 (n) in RR$, we have
  $
    P_11(n) = sum_(i=1)^(k-2) a_i lambda_i^n + a_(k-1) r^n cos(n theta) + a_k r^n sin(n theta).
  $

+ If we have repeated eigenvalues, _e.g._ if $lambda_(k-1) = lambda_k = lambda$, then we can use the Jordan normal form to get an expression as before, but now including the term $(a+ b n) lambda^n$.

#exercise[
  Show that $matbold(P)$ always has an eigenvalue $1$.
]

#example[
  Suppose we have a Markov chain on $I = {1, 2, 3}$ with

  #grid(
    columns: (1fr, 1fr),
    align: center + horizon,
    $
      matbold(P) = mat(delim: "[", 0, 1, 0; 0, 1/2, 1/2; 1/2, 0, 1/2)
    $,
    markov-chain((
      "1": ("1": $0$, "2": $1$, "3": $0$),
      "2": ("1": $0$, "2": $1/2$, "3": $1/2$),
      "3": ("1": $1/2$, "2": $0$, "3": $1/2$),
    )),
  )

  Intuitively, we can observe that $P_11 (n)$ in the long run should be less than $(1)/(3)$. Here, $matbold(P)$ has eigenvalues $1, (ii)/(2), -(ii)/(2)$. Thus,
  $
    P_11(n) = a_1 + a_2((1)/(2))^n cos((n ppi)/2) + a_3((1)/(2))^n sin((n ppi)/2)
  $
  Using $P_11 (0) = 1$, $P_11 (1) = 0$ and $P_11 (2) = 0$, we can solve for $a_1, a_2, a_3$ to get
  $
    P_11(n) & = (1)/(5) + ((1)/(2))^n (4/5 cos((n ppi)/2) - 2/5 sin((n ppi)/2)) \
            & -> (1)/(5) quad "as" n -> oo.
  $
]

#intuition[
  The chain can only go round $1 -> 2 -> 3 -> 1$. Each visit to $1$ lasts one step, and each visit to $2$ or $3$ lasts a geometric number of steps with parameter $1/2$, so $2$ on average. So in the long run the chain spends a fraction $1\/(1 + 2 + 2) = 1\/5$ of its time at $1$, which is less than $1\/3$. For large $n$, $P_11 (n)$ should be close to this fraction, as it is here #fade[[Chapter 4 proves this in general, by the ergodic theorem and convergence to equilibrium]].

  Expanding along the first row,
  $
    det(lambda matbold(I) - matbold(P)) = lambda (lambda - 1/2)^2 - 1/4 = (lambda - 1)(lambda^2 + 1/4),
  $
  so the eigenvalues are $1$ and $plus.minus ii/2$, and the second case above applies with $r = 1/2$ and $theta = ppi/2$. Then $n = 0, 1, 2$ give $a_1 + a_2 = 1$, $a_1 + a_3/2 = 0$ and $a_1 - a_2/4 = 0$.
]
