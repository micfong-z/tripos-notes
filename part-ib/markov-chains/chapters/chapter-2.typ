#import "../prelude.typ": *
#show: chapter.with(2)

= Class Structure

== Communicating Classes

We wish to consider if a Markov chain contains separate components in the long run, or if it has some strange behaviour, as in the following two examples.

#grid(columns: (1fr, 1fr), align: center + horizon, column-gutter: 2em)[
  #markov-chain((
    "1": ("2": $1/2$, "4": $1/2$),
    "2": ("1": $1/2$, "3": $1/2$),
    "3": ("2": $1/2$, "4": $1/2$),
    "4": ("3": $1/2$, "1": $1/2$),
  ))
][
  #markov-chain((
    "1": ("1": $$, "2": $$, "3": $$, "5": $$),
    "2": ("1": $$, "2": $$, "3": $$),
    "3": ("1": $$, "2": $$, "3": $$),
    "4": ("5": $$, "4": $$),
    "5": ("4": $$, "5": $$),
  ))
]


#notation[
  We will write
  $
    PP_x (dot) = PP(dot mid(|) X_0 = x) quad "and" quad EE_x [dot] = EE[dot mid(|) X_0 = x].
  $
]



#definition[
  We say $x -> y$ "$x$ leads to $y$" if
  $
    PP_x (X_n = y "for some" n >= 0) > 0.
  $

  We say $x <-> y$ "$x$ communicates with $y$" if $x -> y$ and $y -> x$.
]

#theorem[
  The following are equivalent:

  + $x -> y$

  + There is a sequence of states
    $
      x = x_0, x_1, ..., x_n = y
    $
    such that $P(x_(i-1), x_i) > 0$ for all $i = 1, 2, ..., n$.

  + $PP_x (X_n = y) > 0$ for some $n >= 0$.
] <thm-markov-chain-2>

#proof[
  We have
  $
    {X_n = y "for some" n>=0} = union.big_(n >= 0) {X_n = y}.
  $
  A countable union of events has positive probability iff one of them does, so $PP_x (X_n = y "for some" n>=0) > 0$ iff $PP_x (X_n = y) > 0$ for some $n >= 0$. Hence (1) $<=>$ (3).

  To see that (2) $<=>$ (3), note that
  $
    PP_x (X_n = y) & = PP(X_n = y mid(|)X_0 = x) \
                   & = sum_(x_1, ..., x_(n-1)) PP(X_1 = x_1, ..., X_(n-1) = x_(n-1), X_n = y mid(|) X_0 = x) \
                   & = sum_(x_1, ..., x_(n-1)) P(x, x_1) P(x_1, x_2) dots.c P(x_(n-1), y). \
  $
  Every term is non-negative, so this is positive iff some term is, _i.e._ iff there is a path $x = x_0, x_1, ..., x_(n-1), x_n = y$ such that $P(x_(i-1), x_i) > 0$ for all $i = 1, ..., n$.
]

#intuition[
  For the first chain of the section, with $x = 1$, $y = 3$ and $n = 2$, each route is one term of the sum.
  #align(center, grid(
    columns: (auto, auto),
    column-gutter: 3em,
    align: horizon,
    canvas({
      import draw: *
      let pt(t, s) = (t * 1.5, -(s - 1) * 0.62)
      // A segment from state to state, stopping short of both labels.
      let seg(p, q, ..style) = {
        let (dx, dy) = (q.at(0) - p.at(0), q.at(1) - p.at(1))
        let r = 0.24 / calc.sqrt(dx * dx + dy * dy)
        line((p.at(0) + dx * r, p.at(1) + dy * r), (q.at(0) - dx * r, q.at(1) - dy * r), ..style)
      }
      for t in range(3) { content((t * 1.5, 0.62), $X_#t$) }
      for b in (2, 4) {
        seg(pt(0, 1), pt(1, b), stroke: 0.9pt + rule("blue"))
        seg(pt(1, b), pt(2, 3), stroke: 0.9pt + rule("blue"))
      }
      let on = ((0, 1), (1, 2), (1, 4), (2, 3))
      for t in range(3) {
        for s in range(1, 5) {
          content(pt(t, s), text(fill: ink(if (t, s) in on { "blue" } else { "gray" }), $#s$))
        }
      }
    }),
    $
      PP_1 (X_2 = 3) = underbrace(P(1, 2) P(2, 3), 1 -> 2 -> 3) + underbrace(P(1, 4) P(4, 3), 1 -> 4 -> 3) = 1 / 2.
    $,
  ))
]

#corollary[
  The relation $<->$ is an equivalence relation on $I$.
]

#proof[
  $P_(x x) (0) = 1$ so $x<->x$. Symmetry is immediate from the definition.

  If $x <-> y$ and $y <-> z$ then by part (2) of @thm-markov-chain-2, we can concatenate the paths from $x$ to $y$ and $y$ to $z$ to get a path from $x$ to $z$, and likewise from $z$ to $x$. Hence $x <-> z$.
]

#definition[
  The equivalence classes induced on $I$ by $<->$ are called *communicating classes*.

  + A class $C subset.eq I$ is *closed* if for any $x in C$ and $y in I$, if $x -> y$ then $y in C$.

  + A transition matrix $matbold(P)$ (or a Markov chain $vb(X)$ with transition matrix $matbold(P)$) is called *irreducible* if there is only one communicating class, $I$.

  + A state $x in I$ is *absorbing* if ${x}$ is a closed class, _i.e._ $P_(x x) = 1$, so $P_(x x) (n) = 1$ for all $n >= 0$.
]

#intuition[
  #block(width: 100%, breakable: false)[
  In the second chain at the start of the section, the classes are ${1, 2, 3}$ and ${4, 5}$. The arrow $1 -> 5$ (red) leaves ${1, 2, 3}$, so that class is not closed, while ${4, 5}$ (blue) is closed. The first chain is irreducible.
  #markov-chain(
    (
      "1": ("1": $$, "2": $$, "3": $$, "5": $$),
      "2": ("1": $$, "2": $$, "3": $$),
      "3": ("1": $$, "2": $$, "3": $$),
      "4": ("5": $$, "4": $$),
      "5": ("4": $$, "5": $$),
    ),
    style: (
      "4": (fill: tint("blue")),
      "5": (fill: tint("blue")),
      "1-5": (stroke: rule("red"), mark: (fill: rule("red"), stroke: rule("red"))),
    ),
  )
  ]
  A chain that leaves a class never returns to it: if it is at $x in C$, later at $y in.not C$ and later still at $z in C$, then $x -> y$, and $y -> z -> x$ as $z, x in C$, so $x <-> y$, which contradicts $y in.not C$.
]

== Hitting Times

#definition[
  Let $A subset.eq I$.

  + The *first hitting time* $T_A$ is
    $
      T_A = inf Set(n >= 0; X_n in A)
    $
    with the convention $inf emptyset = oo$.

  + The *hitting probabilities* $vb(h)^A: I -> [0, 1]$ are
    $
      h^A_i = PP_i (T_A < oo).
    $

  + The *mean hitting time* is $vb(k)^A: I->[0, oo]$ given by
    $
      k^A_i = EE_i [T_A] = sum_(n>=0) n PP_i (T_A = n) + oo dot PP_i (T_A = oo)
    $
]

#intuition[
  #block(width: 100%, breakable: false)[
  Take the chain on ${0, 1, 2, 3}$ that moves from $i = 1, 2$ to $i - 1$ or $i + 1$ with probability $1 \/ 2$ each, with $0$ and $3$ absorbing. Two paths from $1$, with $A = {3}$:
  #canvas({
    import draw: *
    let (sx, sy) = (0.75, 0.5)
    let last = 6
    let pt(t, s) = (t * sx, s * sy)
    let hit = (1, 2, 1, 2, 3, 3, 3)
    let miss = (1, 0, 0, 0, 0, 0, 0)
    rect((-0.25, 2.6 * sy), (last * sx + 0.25, 3.4 * sy), fill: tint("gray"), stroke: none)
    content((last * sx + 0.4, 3 * sy), $A$, anchor: "west")
    for s in range(4) {
      line((-0.25, s * sy), (last * sx + 0.25, s * sy), stroke: 0.4pt + rule("gray"))
      content((-0.4, s * sy), text(size: 0.85em, $#s$), anchor: "east")
    }
    for t in range(last + 1) { content((t * sx, -0.4), text(size: 0.85em, fill: ink("gray"), $#t$)) }
    line((4 * sx, -0.15), (4 * sx, 3.75 * sy), stroke: (paint: rule("blue"), dash: "dashed"))
    content((4 * sx, 3.8 * sy), text(size: 0.85em, fill: ink("blue"), $T_A = 4$), anchor: "south")
    line(..miss.enumerate().map(((t, s)) => pt(t, s)))
    line(..hit.enumerate().map(((t, s)) => pt(t, s)), stroke: 0.9pt + rule("blue"))
    for (t, s) in miss.enumerate() { circle(pt(t, s), radius: 0.05, fill: colors.text, stroke: none) }
    for (t, s) in hit.enumerate() { circle(pt(t, s), radius: 0.05, fill: rule("blue"), stroke: none) }
    content((last * sx + 0.4, 0), text(size: 0.85em, $T_A = oo$), anchor: "west")
  })
  The path with $T_A = oo$ is absorbed at $0$ and never enters $A$. As $PP_1 (X_1 = 0) = 1 \/ 2$, we get $h_1^A <= 1 \/ 2$, and so $k_1^A = oo$. In general $k_i^A = oo$ whenever $h_i^A < 1$.
  ]
]

#lecture-separator(lecture: 4, date: "2026-10-20")

#theorem[
  Suppose $vb(X)$ is a Markov chain on $I$ with transition matrix $matbold(P)$. If $A subset.eq I$ then the vector of hitting probabilities $vb(h)^A = (h_i^A)_(i in I)$ satisfies
  $
    h_i^A = cases(
      1 quad & "if" i in A,
      sum_(j in I) P(i, j) h_j^A quad & "if" i in.not A.
    )
  $
  Moreover $vb(h)^A$ is the minimal non-negative solution of the above equations, _i.e._ if $vb(h) = (h_i)_(i in I)$ is any other non-negative solution, then $h_i^A <= h_i$ for all $i in I$.
] <thm-markov-chain-3>

#proof[
  If $i in A$, then $T_A = 0$ under $PP_i$, so $h_i^A = 1$.

  Suppose $i in.not A$. Then $PP_i (T_A = 0) = 0$, so
  $
    h_i^A & = PP_i (T_A < oo) \
          & = PP_i ({T_A = 0} union union.big_(n >= 1) {T_A = n}) \
          & = sum_(n >= 1) PP_i (T_A = n) \
          & = PP_i (X_1 in A) + sum_(n >= 2) PP_i (X_1, ..., X_(n-1) in.not A, X_n in A) \
          & = sum_(j in I) P(i, j) PP_i (X_1 in A mid(|) X_1 = j) \
          & quad + sum_(n >= 2) sum_(j in I) P(i, j) PP_i (X_1, ..., X_(n-1) in.not A, X_n in A mid(|) X_1 = j). \
  $
  By the @thm-markov-property[Markov property] at time $1$, given $X_1 = j$ the chain starts again from $j$. Therefore,
  $
    h_i^A & = sum_(j in I) P(i, j) [PP_j (X_0 in A) + sum_(n >= 1) PP_j (X_0, ..., X_(n-1) in.not A, X_n in A)] \
          & = sum_(j in I) P(i, j) [PP_j (T_A = 0) + sum_(n >= 1) PP_j (T_A = n)] \
          & = sum_(j in I) P(i, j) PP_j (T_A < oo) \
          & = sum_(j in I) P(i, j) h_j^A. \
  $

  To show minimality, suppose $vb(h) = (h_i)_(i in I)$ is another non-negative solution. Then, if $i in A$, $h_i = 1 = h_i^A$.

  If $i in.not A$, then, using $h_j = 1$ for $j in A$ and substituting the equation for $h_j$ for each $j in.not A$,
  $
    h_i & = sum_(j in I) P(i, j) h_j \
    & = sum_(j in A) P(i, j) + sum_(j in.not A) P(i, j) h_j \
    &= sum_(j in A) P(i, j) + sum_(j in.not A \ k in A) P(i, j) P(j, k) + sum_(j in.not A \ k in.not A) P(i, j) P(j, k) h_k. \
  $
  Iterating this process $n$ times gives the following, where the last sum is non-negative because every $h_j >= 0$:
  $
    h_i &= sum_(j_1 in A) P(i, j_1) + sum_(j_1 in.not A \ j_2 in A) P(i, j_1) P(j_1, j_2) + dots.c + sum_(j_1, ..., j_(n-1) in.not A \ j_n in A) P(i, j_1) dots.c P(j_(n-1), j_n) + underbracket(sum_(j_1, ..., j_n in.not A) P(i, j_1) dots.c P(j_(n-1), j_n) h_(j_n), >= 0) \
    &>= PP_i (X_1 in A) + PP_i (X_1 in.not A, X_2 in A) + dots.c + PP_i (X_1, ..., X_(n-1) in.not A, X_n in A) \
    &= PP_i (T_A = 1) + PP_i (T_A = 2) + dots.c + PP_i (T_A = n) \
    &= PP_i (T_A <= n). #eq-note[as $PP_i (T_A = 0) = 0$] \
  $
  This holds for every $n$, and the events ${T_A <= n}$ increase to ${T_A < oo}$, so taking $n -> oo$,
  $
    h_i >= lim_(n -> oo) PP_i (T_A <= n) = PP_i (T_A < oo) = h_i^A.
  $
]

#intuition[
  Note that $h_i = 1$ for all $i$ always solves the equations, as each row of $matbold(P)$ sums to $1$. So the equations alone need not determine $vb(h)^A$, but together with minimality they do.
  #align(center, canvas({
    import draw: *
    let xs = (0, 1.7, 3.4, 4.9, 6.4, 8.1)
    let names = ($i$, $j_1$, $j_2$, $dots.c$, $j_(n-1)$, $j_n$)
    rect((-0.7, -1.85), (7.1, -1.15), fill: tint("gray"), stroke: none)
    content((-0.85, -1.5), $in A$, anchor: "east")
    content((-0.85, 0), $in.not A$, anchor: "east")
    for (k, (x, l)) in xs.zip(names).enumerate() { content((x, 0), l, name: "s" + str(k), padding: 0.14) }
    for k in range(5) { line("s" + str(k) + ".east", "s" + str(k + 1) + ".west", mark: (end: ">")) }
    for (k, m) in ((0, $1$), (1, $2$), (2, $3$), (4, $n$)) {
      line("s" + str(k) + ".south", (xs.at(k), -1.12), mark: (end: ">"))
      content((xs.at(k), -1.5), text(size: 0.85em, $T_A = #m$))
    }
    content((xs.at(3), -1.5), $dots.c$)
    content("s5.east", text(fill: ink("gray"), $dot h_(j_n) >= 0$), anchor: "west")
    cetz.decorations.flat-brace((6.9, -2.0), (-0.5, -2.0), amplitude: 0.25)
    content((3.2, -2.55), $PP_i (T_A <= n)$, anchor: "north")
  }))
]

#example[
  Consider the Markov chain
  #markov-chain((
    "0": ("0": $1$),
    "1": ("0": $1/2$, "2": $1/2$),
    "2": ("1": $1/2$, "3": $1/2$),
    "3": ("3": $1$),
  ))
  Let $A = {3}$. Consider $h_1^A$ and $h_2^A$. We have the transition matrix
  $
    matbold(P) = mat(delim: "[", 1, 0, 0, 0; 1/2, 0, 1/2, 0; 0, 1/2, 0, 1/2; 0, 0, 0, 1)
  $
  so that there are two absorbing states, $0$ and $3$. By @thm-markov-chain-3, we have
  $
    h_0^A & = h_0^A, \
    h_1^A & = 1/2 h_0^A + 1/2 h_2^A, \
    h_2^A & = 1/2 h_1^A + 1/2 h_3^A, \
    h_3^A & = 1.
  $
  This is not enough information to solve for $h_1^A$ and $h_2^A$: setting $h_0^A = c$, the equations give
  $
    h_1^A = (1 + 2c)/(3), quad h_2^A = (2 + c)/(3).
  $
  Minimality forces $c = 0$, which is also the obvious fact that $h_0^A = 0$ as $0$ is absorbing, so
  $
    h_1^A = (1)/(3), quad h_2^A = (2)/(3).
  $
  #exercise[
    Show that the probability of the game going on forever, _i.e._ of never hitting ${0, 3}$, is $0$.
  ]
] <ex-markov-chain-four-state>

#example[Random Walk on $ZZ_(>=0)$ with Reflection][
  Suppose $vb(X)$ is a Markov chain on $I = ZZ_(>=0)$ with, for some $p in (0, 1)$,
  $
    P(i, i+1) & = p, #eq-note[$i >= 1$] \
    P(i, i-1) & = q = 1-p, #eq-note[$i >= 1$] \
      P(0, 1) & = 1. \
  $
  Let $A = {0}$, so that $h_i^A$ is the probability of ever hitting $0$ from $i$. From @thm-markov-chain-3, we have $h_0^A = 1$ and
  $
    h_i^A & = p h_(i+1)^A + q h_(i-1)^A. #eq-note[$i >= 1$] \
  $

  - If $p != q$, the general solution is
    $
      h_i^A = a + b ((q)/(p))^i,
    $
    where $a + b = 1$ since $h_0^A = 1$. We discuss by cases.

    - If $p > q$ #fade[[drift towards $oo$]], then $h_i^A -> a$ as $i -> oo$, so non-negativity forces $a >= 0$. Since
      $
        h_i^A = ((q)/(p))^i + a(1 - ((q)/(p))^i)
      $
      increases with $a$, minimality gives $a = 0$ and $b = 1$, so that
      $
        h_i^A = ((q)/(p))^i. #eq-note[$i >= 0$]
      $

    - If $p < q$ #fade[[drift towards $0$]], then $((q)/(p))^i -> oo$, so non-negativity forces $b >= 0$. Since
      $
        h_i^A = 1 + b(((q)/(p))^i - 1) >= 1,
      $
      minimality gives $a = 1$ and $b = 0$, so that
      $
        h_i^A = 1. #eq-note[$i >= 0$]
      $

  - If $p = q$, then the general solution is of the form
    $
      h_i^A = a + b i,
    $
    where $a = 1$ since $h_0^A = 1$. Non-negativity forces $b >= 0$, so minimality gives $b = 0$, and
    $
      h_i^A = 1. #eq-note[$i >= 0$]
    $
]

#lecture-separator(lecture: 5, date: "2026-10-22")

=== Birth and Death Chains

#example[Birth and Death Chain on $ZZ_(>=0)$][
  Suppose $vb(X)$ is a Markov chain on $I = {0, 1, ...}$ #fade[[population]] with, for some $p_1, p_2, ... in (0, 1)$,
  $
    P(i, i+1) & = p_i quad "and" quad P(i, i-1) & = 1 - p_i = q_i, #eq-note[$i >= 1$] \
      P(0, 0) & = 1.
  $
  Let $A = {0}$. We wish to find $h_i^A$ #fade[[the probability of extinction starting from $i$]]. Clearly $h_0^A = 1$.

  For $i >= 1$,
  $
    (p_i + q_i) h_i^A = h_i^A = p_i h_(i+1)^A + q_i h_(i-1)^A.
  $
  Hence,
  $
    p_i (h_(i+1)^A - h_i^A) = q_i (h_i^A - h_(i-1)^A).
  $
  Let $u_i = h_i^A - h_(i-1)^A$. Then
  $
    u_(i+1) = (q_i)/(p_i) u_i = underbracket((product_(j=1)^i (q_j)/(p_j)), gamma_i) u_1.
  $
  Also let $gamma_0 = 1$. Hence we have
  $
    u_(i+1) = gamma_i u_1.
  $
  Hence by definition of $u_i$, we can write
  $
    h_i^A & = sum_(j=1)^i u_j + h_0^A \
          & = (sum_(j=1)^i gamma_(j-1)) u_1 + 1.
  $
  Since all $h_i^A >= 0$, we must have
  $
            (sum_(j=1)^i gamma_(j-1)) u_1 + 1 & >= 0 \
    (h_1^A - 1) sum_(j=0)^(i-1) gamma_(j) + 1 & >= 0.
  $
  Therefore
  $
    h_1^A >= 1 - (1)/(underbracket(sum_(j=0)^(i-1) gamma_j, S_i)). #eq-note[$forall i >= 1$]
  $
  Let $S = sum_(j=0)^oo gamma_j$. Letting $i -> oo$, we have $S_i arrow.t S$, which gives
  $
    h_1^A >= 1 - (1)/(S),
  $
  with the convention $1\/S = 0$ if $S = oo$.

  The choice $u_1 = -1\/S$ gives
  $
    h_i = 1 - (S_i)/(S) = (sum_(j>=i) gamma_j)/(S) >= 0 #eq-note[$i >= 1$]
  $
  if $S < oo$, and $h_i = 1$ for all $i$ if $S = oo$. This is a non-negative solution, so by minimality $h_1^A <= 1 - 1\/S$. Combined with the lower bound, we have
  $
    h_1^A = 1 - (1)/(S)
  $
  and hence that $u_1 = -(1)/(S)$. Note that now we have solved the problem since $S$ is a constant independent of $i$. Two cases that arise are:

  - if $S < oo$, then $h_0^A = 1$, $h_1^A = 1-(1)/(S)$, and
    $
      h_i^A = (sum_(j>=i) gamma_j)/(sum_(j>=0) gamma_j). #eq-note[$i >= 1$] \
    $

  - if $S = oo$, then $h_0^A = 1$, $h_1^A = 1$ and $h_i^A = 1$ for all $i$.
]

#intuition[
  #block(width: 100%, breakable: false)[
  Solutions $h_i = 1 + u_1 S_i$, where $u_1 = h_1 - 1$, when every $p_i = 2 \/ 3$, so that $gamma_j = 2^(-j)$ and $S = 2$.
  #canvas({
    import draw: *
    let (sx, sy) = (0.72, 2.0)
    let pt(i, h) = (i * sx, h * sy)
    let S(i) = 2 * (1 - calc.pow(0.5, i))
    let (lo, hi, last) = (-0.65, 1.15, 8)
    // Box, with the line h = 0.
    rect(pt(-0.3, lo), pt(last + 0.3, hi), stroke: rule("gray"))
    line(pt(-0.3, 0), pt(last + 0.3, 0))
    for i in range(last + 1) {
      line(pt(i, lo), (i * sx, lo * sy + 0.08), stroke: rule("gray"))
      content((i * sx, lo * sy - 0.08), text(size: 0.8em, $#i$), anchor: "north")
    }
    for (h, l) in ((-0.5, $-1 \/ 2$), (0, $0$), (0.5, $1 \/ 2$), (1, $1$)) {
      line(pt(-0.3, h), (-0.3 * sx + 0.08, h * sy), stroke: rule("gray"))
      content((-0.3 * sx - 0.08, h * sy), text(size: 0.8em, l), anchor: "east")
    }
    content(((last / 2) * sx, lo * sy - 0.5), $i$, anchor: "north")
    content(pt(-0.3, hi + 0.04), $h_i$, anchor: "south")
    for (u, line-colour, label-colour, l) in (
      (0, colors.text, colors.text, $u_1 = 0$),
      (-0.25, colors.text, colors.text, $u_1 = -1 \/ 4$),
      (-0.5, rule("blue"), ink("blue"), [$u_1 = -1 \/ S = -1 \/ 2$, minimal]),
      (-0.75, rule("red"), ink("red"), [$u_1 = -3 \/ 4$, negative]),
    ) {
      let pts = range(last + 1).map(i => pt(i, 1 + u * S(i)))
      line(..pts, stroke: 0.9pt + line-colour)
      for p in pts { circle(p, radius: 0.045, fill: line-colour, stroke: none) }
      content(((last + 0.5) * sx, (1 + u * S(last)) * sy), text(size: 0.85em, fill: label-colour, l), anchor: "west")
    }
  })
  ]
  As $S_i > 0$, a smaller $u_1$ gives a smaller solution, and for $u_1 < 0$, $h_i$ decreases to $1 + u_1 S$ as $i -> oo$, so the minimal non-negative one has $u_1 = -1 \/ S$. Here it is $h_i^A = 2^(-i)$, the $(q \/ p)^i$ of the random walk with reflection when $p = 2 \/ 3$ #fade[[the two chains agree until they reach $0$]]. If $S = oo$, _e.g._ when every $p_i = 1 \/ 2$, so that $S_i = i$, every $u_1 < 0$ makes $h_i$ negative for large $i$, so $u_1 >= 0$ and the minimal solution is $h_i^A = 1$ for all $i$.
]

=== Mean Hitting Times

Now consider mean hitting times for @ex-markov-chain-four-state.

#example[
  Consider the Markov chain #fade[[from @ex-markov-chain-four-state]]
  #markov-chain((
    "0": ("0": $1$),
    "1": ("0": $1/2$, "2": $1/2$),
    "2": ("1": $1/2$, "3": $1/2$),
    "3": ("3": $1$),
  ))
  Let $A = {0, 3}$. Here, intuitively we have
  $
    k_1^A & = 1 + (1)/(2) k_2^A \
          & = 1 + (1)/(2) k_1^A #eq-note[by symmetry of the problem] \
  $
  Hence $k_1^A = k_2^A = 2$.
]

#intuition[
  The first line takes one step, to $0$ or $2$, and $k_0^A = 0$ as $0 in A$. For the second, the map $i |-> 3 - i$ swaps $1$ and $2$ and preserves $A$ and the transition probabilities, so $k_2^A = k_1^A$.
]

We claimed that the result is intuitive, but we can also prove it formally.

#theorem[
  Suppose $vb(X) = (X_n)_(n >= 0)$ is a Markov chain on state space $I$ with transition matrix $matbold(P)$, and let $A subset.eq I$. Then the mean hitting times $(k_i^A)_(i in I)$ satisfy
  $
    k_i^A = cases(
      0 quad & i in A,
      1 + sum_(j in.not A) P(i, j) k_j^A quad & i in.not A.
    )
  $
  Moreover, $(k^A_i)_(i in I)$ are the minimal non-negative solution of the above equations.

  Equivalently, this can be written as
  $
    k_i^A = 1 + (matbold(P) vb(k)^A)_i quad "if" i in.not A.
  $
]

#proof[
  Clearly $k_i^A = 0$ if $i in A$ by definition. Let $i in.not A$. Then
  $
    k_i^A & = EE_i [T_A] \
          & = sum_(n>=0) PP_i (T_A > n) #eq-note[see IA Probability] \
          & = 1 + sum_(n>=1) PP_i (T_A > n) \
          & = 1 + sum_(n>=1) PP (cancel(X_0 in.not A), X_1 in.not A, ..., X_n in.not A mid(|)X_0 = i) \
          & = 1 + sum_(n >= 1) sum_(j in I) P(i, j) PP(X_1 in.not A, ..., X_n in.not A mid(|) cancel(X_0 = i), X_1 = j) \
          & = 1 + sum_(j in I) P(i, j) sum_(n>=1) PP(X_1 in.not A, ..., X_n in.not A mid(|) X_1 = j) \
          & = 1 + sum_(j in I) P(i, j) sum_(n>=0) PP(X_0 in.not A, ..., X_n in.not A mid(|) X_0 = j) \
          & = 1 + sum_(j in I) P(i, j) sum_(n >= 0) PP_j (T_A > n) \
          & = 1 + sum_(j in I) P(i, j) k_(j)^A \
          & = 1 + sum_(j in.not A) P(i, j) k_(j)^A. \
  $
  To show minimality, suppose $(k_i)$ is a non-negative solution of the equations. Then if $i in A$, $k_i = 0 = k_i^A$. If $i in.not A$, then
  $
    k_i & = 1 + sum_(j_1 in.not A) P(i, j_1) k_(j_1)\
    &= 1 + sum_(j_1 in.not A) P(i, j_1) + sum_(j_1, j_2 in.not A) P(i, j_1) P(j_1, j_2) + dots.c + sum_(j_1, ..., j_n in.not A) P(i, j_1) dots.c P(j_(n-1), j_n) + underbracket(sum_(j_1, ..., j_(n+1) in.not A) P(i, j_1) dots.c P(j_(n), j_(n+1)) k_(j_(n+1)), >= 0). \
  $
  Hence
  $
    k_i & >= 1 + PP_i (X_1 in.not A) + PP_i (X_1, X_2 in.not A) + dots.c + PP_i (X_1, ..., X_n in.not A) \
        & = 1 + PP_i (T_A > 1) + PP_i (T_A > 2) + dots.c + PP_i (T_A > n) \
        & = 1 + sum_(m=1)^n PP_i (T_A > m) \
        & = sum_(m = 0)^n PP_i (T_A > m). \
  $
  Taking $n -> oo$,
  $
    k_i >= sum_(m=0)^oo PP_i (T_A > m) = EE_i [T_A] = k_i^A.
  $
  Hence $(k_i^A)_(i in I)$ are indeed minimal.
]

#intuition[
  The equations alone need not determine $vb(k)^A$ either. Take $p = 1 \/ 3$ and $A = {0}$ in the random walk with reflection. Then the equations read $k_0 = 0$ and $k_i = 1 + 1/3 k_(i+1) + 2/3 k_(i-1)$ for $i >= 1$, so each real value of $k_1$ fixes every $k_i$. Note that $k_i = 3i + b(2^i - 1)$ solves them for every $b in RR$ #fade[[$3i = i \/ (q - p)$ is one solution, and $1$ and $2^i = (q \/ p)^i$ solve them without the $1 +$]], with $k_1 = 3 + b$, so these are all the real solutions. For $b < 0$ the term $b 2^i$ makes $k_i$ negative for large $i$, so non-negativity forces $b >= 0$, and minimality gives $b = 0$, _i.e._ $k_i^A = 3i$.

  In the proof of minimality, the state at each time $m <= n$ gives the term $PP_i (T_A > m)$, and the gray remainder is dropped:
  #align(center, canvas({
    import draw: *
    let xs = (0, 2.5, 5.0, 6.4, 7.8, 10.2)
    let names = ($i$, $j_1$, $j_2$, $dots.c$, $j_n$, $j_(n+1)$)
    content((-0.85, 0), $in.not A$, anchor: "east")
    for (k, (x, l)) in xs.zip(names).enumerate() { content((x, 0), l, name: "s" + str(k), padding: 0.14) }
    for k in range(5) { line("s" + str(k) + ".east", "s" + str(k + 1) + ".west", mark: (end: ">")) }
    for (k, l) in ((0, $1$), (1, $PP_i (T_A > 1)$), (2, $PP_i (T_A > 2)$), (3, $dots.c$), (4, $PP_i (T_A > n)$)) {
      content((xs.at(k), 0.3), text(size: 0.85em, l), anchor: "south")
    }
    content("s5.east", text(fill: ink("gray"), $dot k_(j_(n+1)) >= 0$), anchor: "west")
    cetz.decorations.flat-brace((-0.5, 0.95), (xs.at(4) + 0.8, 0.95), amplitude: 0.25)
    content(((xs.at(4) + 0.3) / 2, 1.3), $display(sum_(m=0)^n) PP_i (T_A > m)$, anchor: "south")
  }))
]

== Stopping Times and the Strong Markov Property

#definition[
  A random variable $T$ with values in $ZZ_(>=0) union {oo}$ is a *stopping time* with respect to a random process $vb(X) = (X_i)_(i >= 0)$ if the event ${T = n}$ is determined by $X_0, ..., X_n$ for each $n >= 0$.
]

#intuition[
  #block(width: 100%, breakable: false)[
  For $A subset.eq I$, $i in I$, $m >= 0$ and $r >= 1$:
  #table(
    columns: 3,
    table.header[$T$][Stopping time][${T = n}$],
    [the constant $m$], [yes], [$Omega$ if $n = m$, $emptyset$ otherwise],
    [the time of the $r$-th return to $i$], [yes], [$X_n = i$, and exactly $r - 1$ of $X_1, ..., X_(n-1)$ equal $i$],
    [$T_A - 1$ #fade[[if $X_0 in.not A$]]], [no], [${T_A = n + 1}$, which depends on $X_(n+1)$],
  )
  ]
]

#example[
  The first hitting times
  $
    T_A = inf Set(n>=0; X_n in A)
  $
  have
  $
    {T_A = n} = {X_0 in.not A, ..., X_(n-1) in.not A, X_n in A}.
  $
  Hence $T_A$ is a stopping time with respect to $vb(X)$.
]

#example[
  The last exit time
  $
    S_A = sup Set(n>=0; X_n in A)
  $
  is not a stopping time, since ${S_A = n}$ is not determined by $X_0, ..., X_n$. #fade[[We need to know if the chain will return to $A$ in the future.]]
]

#theorem[Strong Markov Property][
  Suppose $vb(X) = (X_n)_(n >= 0)$ is a Markov chain with $vb(X) ~ "Markov"(vb(lambda), matbold(P))$. Let $T$ be a stopping time w.r.t. $vb(X)$ and $i in I$ be a fixed state. Then, conditional on ${T < oo} inter {X_T = i}$, the process $(X_(T+n))_(n >= 0) ~ "Markov"(vb(delta)_i, matbold(P))$ and is independent of $X_0, ..., X_T$.
] <thm-strong-markov-property>

#lecture-separator(lecture: 6, date: "2026-10-27")

#proof[
  We will show that, for any $x_0, x_1, ..., x_n in I$ and any finite-length path $vb(w) in union.big_(k>=0) I^(k+1)$, we have
  $
      & PP((X_0, ..., X_T) = vb(w) and X_T = x_0, X_(T+1) = x_1, ..., X_(T+n) = x_n mid(|) T < oo, X_T = i) \
    = & bb(1)[x_0 = i] P(x_0, x_1) dots.c P(x_(n-1), x_n) PP((X_0, ..., X_T) = vb(w) mid(|) T < oo, X_T = i). \
  $

  Consider a fixed $vb(w) in I^(k+1)$ and fixed $x_0, ..., x_n$. Then
  $
    & PP((X_0, ..., X_T) = vb(w) and X_T = x_0, X_(T+1) = x_1, ..., X_(T+n) = x_n mid(|) T < oo, X_T = i)\
    = &PP((X_0, ..., X_T) = vb(w) and X_T = x_0, X_(T+1) = x_1, ..., X_(T+n) = x_n and T = k, X_T = i) / PP(T < oo, X_T = i)\
    = &(PP((X_0, ..., X_T) = vb(w) and T = k, X_T = i) dot PP(X_k = x_0, ..., X_(k+n) = x_n mid(|) (X_0, ..., X_T) = vb(w) and T = k, X_T = i)) / PP(T < oo, X_T = i)\
    = &(PP((X_0, ..., X_T) = vb(w) and T = k, X_T = i) dot PP(X_k = x_0, ..., X_(k+n) = x_n mid(|) X_k = i)) / PP(T < oo, X_T = i)\
    = &(PP((X_0, ..., X_T) = vb(w) and T = k, X_T = i) dot bb(1)[x_0 = i] P(x_0, x_1) dots.c P(x_(n-1), x_n)) / PP(T < oo, X_T = i)\
    = & bb(1)[x_0 = i] P(x_0, x_1) dots.c P(x_(n-1), x_n) PP((X_0, ..., X_T) = vb(w) and T = k, X_T = i) / PP(T < oo, X_T = i) \
    = & bb(1)[x_0 = i] P(x_0, x_1) dots.c P(x_(n-1), x_n) PP((X_0, ..., X_T) = vb(w) mid(|) T < oo, X_T = i). \
  $
]

#intuition[
  #block(width: 100%, breakable: false)[
  In the proof, $vb(w) in I^(k+1)$, so $(X_0, ..., X_T) = vb(w)$ forces $T = k$.
  #canvas({
    import draw: *
    let sx = 0.9
    let k = 4
    let ys = (1.1, 1.4, 0.8, 1.3, 0.55, 1.15, 0.75, 1.5, 1.1)
    let pt(t) = (t * sx, ys.at(t))
    // The past, which decides {T = k}.
    rect((-0.35, 0.25), (k * sx, 2.15), fill: tint("gray"), stroke: none)
    content((-0.25, 2.07), text(size: 0.85em, $(X_0, ..., X_k) = vb(w)$), anchor: "north-west")
    line((k * sx, 0), (k * sx, 2.2), stroke: (paint: rule("gray"), dash: "dashed"))
    content((k * sx, 2.22), text(size: 0.85em, $T = k$), anchor: "south")
    line(..range(k + 1).map(pt))
    line(..range(k, 9).map(pt), stroke: 0.9pt + rule("blue"))
    for t in range(k) { circle(pt(t), radius: 0.05, fill: colors.text, stroke: none) }
    for t in range(k, 9) { circle(pt(t), radius: 0.05, fill: rule("blue"), stroke: none) }
    content((k * sx + 0.14, ys.at(k) - 0.06), text(fill: ink("blue"), $i$), anchor: "north-west")
    content((k * sx + 0.25, 2.07), text(size: 0.85em, fill: ink("blue"), $"Markov"(vb(delta)_i, matbold(P))$), anchor: "north-west")
    // The two clocks.
    line((-0.35, 0), (8 * sx + 0.35, 0), stroke: rule("gray"))
    for t in range(9) { line((t * sx, 0), (t * sx, -0.1), stroke: rule("gray")) }
    content((-0.5, -0.33), text(size: 0.85em)[time], anchor: "east")
    content((-0.5, -0.78), text(size: 0.85em, fill: ink("blue"))[from $i$], anchor: "east")
    for (t, l) in ((0, $0$), (1, $1$), (2.5, $dots.c$), (4, $k$), (5, $k + 1$), (6.5, $dots.c$), (8, $k + n$)) {
      content((t * sx, -0.33), text(size: 0.85em, l))
    }
    for (t, l) in ((4, $0$), (5, $1$), (6.5, $dots.c$), (8, $n$)) {
      content((t * sx, -0.78), text(size: 0.85em, fill: ink("blue"), l))
    }
  })
  $
    PP(X_k = x_0, ..., X_(k+n) = x_n mid(|) hgray((X_0, ..., X_T) = vb(w) and T = k, tag: #<smp-past>), X_T = i) = PP(X_k = x_0, ..., X_(k+n) = x_n mid(|) X_k = i)
    #annot(<smp-past>)[determined by $X_0, ..., X_k$]
  $
  #v(1em)
  ]
  For the constant $T = m$ the theorem is the @thm-markov-property[Markov property], and the proof uses that property at time $k$ on each event ${T = k}$, which is why $T$ must be a stopping time. Otherwise it can fail: in @ex-markov-chain-four-state with $A = {0}$, under $PP_1$ and conditional on $T_A < oo$, the time $T = T_A - 1$ has $X_T = 1$, as $0$ is entered only from $1$, and $X_(T+1) = 0$, while a chain started at $1$ moves to $0$ with probability $1 \/ 2$.
]

#example[Simple Symmetric Random Walk on $ZZ_(>=0)$][
  Consider a Markov chain with
  $
    P (i, i+1) = P(i, i-1) & = (1)/(2) #eq-note[$i >= 1$] \
                   P(0, 1) & = 1.
  $
  Let $A = {0}$. We would like to find $h_i^A$, and in particular, $h_2^A$.

  From @thm-markov-chain-3, we have $h_1^A = (1)/(2) h_0^A + (1)/(2) h_2^A = (1)/(2) + (1)/(2) h_2^A$.

  Write $T_j = T_({j})$ for the first hitting time of $j$. Starting at $2$, let
  $
    tilde(T)_0 ~ [T_0 "under" PP_1], #eq-note[independent of $T_1$]
  $
  Then, by the @thm-strong-markov-property[strong Markov property], conditional on ${T_1 < oo}$, under $PP_2$, we have
  $
    T_0 = T_1 + tilde(T)_0.
  $
  Therefore,
  $
    h_2^A & = PP_2 (T_0 < oo) \
          & = PP_2 (T_0 < oo, T_1 < oo) \
          & = PP_2 (T_1 < oo) PP_2 (T_1 + tilde(T)_0 < oo mid(|)T_1 < oo) \
          & = PP_1 (T_0 < oo) PP_1 (T_0 < oo) \
          & = h_1^A dot h_1^A \
          & = (h_1^A)^2. \
  $
  Hence, using $h_1^A = (1)/(2) + (1)/(2) h_2^A$, we have
  $
    h_1^A = h_2^A = 1.
  $
]

#intuition[
  #block(width: 100%, breakable: false)[
  A path from $2$ to $0$, split at $T_1$. Steps are $plus.minus 1$, so it cannot reach $0$ without passing $1$, and $T_0 < oo$ forces $T_1 < oo$.
  #canvas({
    import draw: *
    let (sx, sy) = (0.7, 0.55)
    let path = (2, 3, 4, 3, 2, 1, 2, 1, 0)
    let t1 = 5
    let last = path.len() - 1
    let pt(t) = (t * sx, path.at(t) * sy)
    // The walk up to the stopping time T_1.
    rect((-0.2, -0.15), (t1 * sx, 4.5 * sy), fill: tint("gray"), stroke: none)
    for s in range(5) {
      line((-0.2, s * sy), (last * sx + 0.2, s * sy), stroke: 0.4pt + rule("gray"))
      content((-0.35, s * sy), text(size: 0.85em, $#s$), anchor: "east")
    }
    line(..range(t1 + 1).map(pt))
    line(..range(t1, last + 1).map(pt), stroke: 0.9pt + rule("blue"))
    for t in range(t1) { circle(pt(t), radius: 0.05, fill: colors.text, stroke: none) }
    for t in range(t1, last + 1) { circle(pt(t), radius: 0.05, fill: rule("blue"), stroke: none) }
    // T_0 = T_1 + T~_0.
    cetz.decorations.flat-brace((t1 * sx - 0.03, -0.3), (0, -0.3), amplitude: 0.2)
    content((t1 * sx / 2, -0.62), text(size: 0.85em, $T_1$), anchor: "north")
    cetz.decorations.flat-brace((last * sx, -0.3), (t1 * sx + 0.03, -0.3), amplitude: 0.2, stroke: rule("blue"))
    content(((t1 + last) * sx / 2, -0.62), text(size: 0.85em, fill: ink("blue"), $tilde(T)_0$), anchor: "north")
    cetz.decorations.flat-brace((last * sx, -1.2), (0, -1.2), amplitude: 0.2)
    content((last * sx / 2, -1.52), text(size: 0.85em, $T_0$), anchor: "north")
  })
  The blue part takes time $tilde(T)_0 = T_0 - T_1$, and by the @thm-strong-markov-property[strong Markov property] at $T_1$ it is a walk from $1$, independent of the part before $T_1$. Also $PP_2 (T_1 < oo) = PP_1 (T_0 < oo)$: before $T_1$ the walk from $2$ stays in ${2, 3, ...}$, where $P(j, j plus.minus 1) = 1 \/ 2$, so it is the walk from $1$ before $T_0$ shifted up by $1$.
  ]
]
