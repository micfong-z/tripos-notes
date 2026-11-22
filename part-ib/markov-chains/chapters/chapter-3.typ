#import "../prelude.typ": *
#show: chapter.with(3)

= Recurrence and Transience

#definition[Recurrence and Transience][
  Suppose $vb(X)$ is a Markov chain on $I$ with transition matrix $matbold(P)$. Then,

  - a state $i in I$ is *recurrent* if $PP_i (X_n = i "for infinitely many" n) = 1$;

  - $matbold(P)$ is *recurrent* if all states are recurrent;

  - a state $i in I$ is *transient* if $PP_i (X_n = i "for infinitely many" n) = 0$;

  - $matbold(P)$ is *transient* if all states are transient.
]

#intuition[#block(width: 100%, breakable: false)[
  For the chain of @ex-markov-chain-four-state,
  #markov-chain((
    "0": ("0": $1$),
    "1": ("0": $1/2$, "2": $1/2$),
    "2": ("1": $1/2$, "3": $1/2$),
    "3": ("3": $1$),
  ))
  $0$ and $3$ are absorbing, so they are recurrent. From $1$ the chain moves to $0$ with probability $1\/2$, and from $2$ to $3$ with probability $1\/2$, and it then stays there. So the chance of staying in ${1, 2}$ for $n$ steps is $2^(-n)$, and with probability $1$ the chain visits $1$ and $2$ only finitely often, so they are transient.

  #fade[[A priori $PP_i (X_n = i "infinitely often")$ could lie strictly between $0$ and $1$; the theorem after @lem-markov-chain-1 shows that it is $0$ or $1$.]]
]]

#definition[Return Times][
  Define the *return times* to $i$
  $
    T_i^((0)) = 0\
    T_i^((k+1)) = inf Set(n > T_i^((k)); X_n = i)
  $
  and in particular, the *first return time* $T_i = T_i^((1))$.
]


#definition[Return Probability][
  Define the *return probability* to $i$ as
  $
    f_i = PP_i (T_i < oo).
  $
]

#definition[Total Number of Visits][
  Define the *total number of visits* to $i$
  $
    V_i = sum_(k=0)^oo bb(1)[X_k = i].
  $
]

#lemma[
  For every $r >= 0$, $PP_i (V_i > r) = f_i^r$.
] <lem-markov-chain-1>

#proof[
  By induction on $r$.

  *Base case.* For $r = 0$, $PP_i (V_i > 0) = 1 = f_i^0$ trivially.

  *Inductive step.* Suppose $PP_i (V_i > r) = f_i^r$. Then
  $
    PP_i (V_i > r+1) & = PP_i (V_i > r+1 mid(|) V_i > r) PP_i (V_i > r) \
                     & = PP_i (T_i^((r+1)) < oo mid(|) T_i^((r)) < oo) f_i^r \
                     & = PP_i (T_i^((1)) < oo) f_i^r #eq-note[by the strong Markov property] \
                     & = f_i f_i^r = f_i^(r+1). \
  $
]

#intuition[
  #canvas(length: 0.95cm, {
    import draw: *
    let path = (
      ((0, 0), (0.4, 0.55), (0.8, 0.3), (1.2, 0.95), (1.6, 0.55), (2.0, 0.75), (2.4, 0)),
      ((2.4, 0), (2.8, 0.45), (3.2, 0.2), (3.6, 0)),
      ((3.6, 0), (4.0, 0.6), (4.4, 0.35), (4.8, 1.05), (5.2, 0.8), (5.6, 1.2), (6.0, 0.5), (6.4, 0.75), (6.8, 0)),
      ((6.8, 0), (7.2, 0.5), (7.6, 0.25), (8.0, 0.85), (8.4, 0.6), (8.8, 1.1), (9.2, 0.9)),
    )
    line((-0.3, 0), (10.6, 0), stroke: rule("gray") + 0.5pt, mark: (end: "stealth", fill: rule("gray"), stroke: rule("gray")))
    content((-0.4, 0), $i$, anchor: "east")
    content((10.7, 0), $n$, anchor: "west")
    for p in path { line(..p) }
    line((9.2, 0.9), (10.4, 1.45), stroke: (dash: "dashed"))
    // One bracket per excursion, with the chance that it returns to i.
    let spans = ((0, 2.4, $f_i$), (2.4, 3.6, $f_i$), (3.6, 6.8, $f_i$), (6.8, none, $1 - f_i$))
    for (a, b, lab) in spans {
      let y = 1.75
      let a = a + 0.1
      if b == none {
        line((a, y - 0.12), (a, y), (10.4, y), stroke: 0.4pt)
        content(((a + 10.4) / 2, y), lab, anchor: "south")
      } else {
        let b = b - 0.1
        line((a, y - 0.12), (a, y), (b, y), (b, y - 0.12), stroke: 0.4pt)
        content(((a + b) / 2, y), lab, anchor: "south")
      }
    }
    for (t, lab) in ((0, $0$), (2.4, $T_i^((1))$), (3.6, $T_i^((2))$), (6.8, $T_i^((3))$)) {
      circle((t, 0), radius: 0.07, fill: colors.text, stroke: none)
      content((t, -0.2), lab, anchor: "north")
    }
  })
  $V_i > r$ iff the first $r$ excursions from $i$ all return; here $V_i = 4$. In @ex-markov-chain-four-state, a return to $1$ must go $1 -> 2 -> 1$, so $f_1 = 1\/4$ and $PP_1 (V_1 > r) = 4^(-r)$.
]

#theorem[
  For a Markov chain $vb(X)$ on $I$,

  + if $f_i = PP_i (T_i < oo) = 1$, then $i$ is recurrent, and $sum_(k>=0) P_(i i)(k) = oo$.

  + if $f_i = PP_i (T_i < oo) < 1$, then $i$ is transient, and $sum_(k>=0) P_(i i)(k) < oo$.
]

#proof[
  First notice that
  $
    EE_i [V_i] & = EE_i [sum_(k=0)^oo bb(1) [X_k = i]] \
               & = sum_(k=0)^oo EE_i [bb(1)[X_k = i]] \
               & = sum_(k=0)^oo P_(i i)(k).
  $

  + If $f_i = 1$, then by @lem-markov-chain-1, $V_i = oo$ with probability $1$. Hence $i$ is recurrent, and also $EE_i [V_i] = sum_(k>=0) P_(i i)(k) = oo$.

  + If $f_i < 1$, then by @lem-markov-chain-1, $V_i < oo$ with probability $1$. Therefore, $i$ is transient, and also $EE_i [V_i] = sum_(r>=0) PP_i (V_i > r) = sum_(r>=0) f_i^r = 1/(1-f_i) < oo$, so $sum_(k>=0) P_(i i)(k) < oo$.

]

#intuition[
  By the theorem, every state is either recurrent or transient, according as $f_i = 1$ or $f_i < 1$. So to show that $i$ is recurrent it is enough to show $sum_k P_(i i)(k) = oo$, or $PP_i (X_n = i "infinitely often") > 0$, since both fail for a transient state.
]

== Class Properties

#theorem[
  If $x <-> y$, then $x$ and $y$ are either both recurrent or both transient.
] <thm-communicating-classes-recurrence>

#proof[
  Suppose $x$ is recurrent. Since $x <-> y$, there are $k, l in ZZ^+$ such that $P_(x y) (k) > 0$ and $P_(y x) (l) > 0$. Then
  $
    sum_(n>=0) P_(y y)(n) & >= sum_(n>=0) P_(y y)(n+k+l) \
                          & >= sum_(n>=0) P_(y x)(l) P_(x x)(n) P_(x y)(k) \
                          & = P_(y x) (l) P_(x y) (k) sum_(n>=0) P_(x x)(n) \
                          & = oo.
  $
  Hence $y$ is recurrent.
]

#intuition[
  #canvas(length: 0.95cm, {
    import draw: *
    let (ty, tx) = (1.5, 0) // heights of y and x
    let guide = (paint: rule("gray"), thickness: 0.4pt, dash: "dotted")
    for (h, lab) in ((ty, $y$), (tx, $x$)) {
      line((-0.2, h), (8.2, h), stroke: (paint: rule("gray"), thickness: 0.5pt, dash: "dashed"))
      content((-0.3, h), lab, anchor: "east")
    }
    line((-0.2, -0.6), (8.6, -0.6), stroke: rule("gray") + 0.5pt, mark: (end: "stealth", fill: rule("gray"), stroke: rule("gray")))
    for (t, h, lab) in ((0, ty, $0$), (2, tx, $l$), (6, tx, $l + n$), (8, ty, $l + n + k$)) {
      line((t, h), (t, -0.6), stroke: guide)
      content((t, -0.7), lab, anchor: "north")
    }
    line((0, ty), (0.4, 1.1), (0.8, 1.3), (1.2, 0.75), (1.6, 0.5), (2, tx))
    line(
      (2, tx), (2.4, 0.35), (2.8, 0.15), (3.2, 0.55), (3.6, 0.3), (4.0, 0.7),
      (4.4, 0.45), (4.8, 0.6), (5.2, 0.2), (5.6, 0.4), (6, tx),
      stroke: rule("blue") + 0.8pt,
    )
    line((6, tx), (6.4, 0.5), (6.8, 0.3), (7.2, 0.9), (7.6, 1.2), (8, ty))
    // One bracket per stretch of the path, with its probability.
    for (a, b, lab, hue) in ((0, 2, $P_(y x)(l)$, none), (2, 6, $P_(x x)(n)$, "blue"), (6, 8, $P_(x y)(k)$, none)) {
      let (y, a, b) = (ty + 0.4, a + 0.08, b - 0.08)
      let st = if hue == none { 0.4pt } else { rule(hue) + 0.6pt }
      line((a, y - 0.12), (a, y), (b, y), (b, y - 0.12), stroke: st)
      content(((a + b) / 2, y), if hue == none { lab } else { text(fill: ink(hue), lab) }, anchor: "south")
    }
    for (t, h) in ((0, ty), (2, tx), (6, tx), (8, ty)) {
      circle((t, h), radius: 0.07, fill: colors.text, stroke: none)
    }
  })
  These paths, from $y$ to $y$ in $l + n + k$ steps and at $x$ at times $l$ and $l + n$, have total probability $P_(y x)(l) P_(x x)(n) P_(x y)(k) <= P_(y y)(l + n + k)$.

  The proof shows that $y$ is recurrent if $x$ is, and swapping $x$ and $y$ gives the converse. As every state is recurrent or transient, $x$ and $y$ are then also transient together.
]

#corollary[
  If $A subset.eq I$ is a communicating class, then either all states in $A$ are recurrent or they are all transient.
]

#theorem[
  If $C subset.eq I$ is a recurrent communicating class, then it is closed.
] <thm-recurrent-communicating-class-closed>

#proof[
  Suppose otherwise, that $x in C$ is recurrent and $x->y$ for some $y in.not C$ #fade[[so $y arrow.not x$]]. Then there is some $m$ such that $P_(x y)(m) > 0$. So
  $
    PP_x (V_x < oo) >= PP_x (X_m = y) > 0.
  $
  Hence $x$ is transient, which is a contradiction.
]

#lecture-separator(lecture: 7, date: "2026-10-29")

#theorem[
  Suppose $C subset.eq I$ is a closed communicating class. If $C$ is finite, then $C$ is recurrent.
]

#proof[
  Let $x in C$. Since $C$ is closed, the chain started at $x$ stays in the finite set $C$ forever, so by the pigeonhole principle there must be a $y in C$ such that
  $
    PP_x (X_n = y "infinitely often") > 0.
  $
  Since $C$ is a communicating class, $x <-> y$, so there is $m >= 1$ such that $P_(y x)(m) > 0$. Then
  $
    PP_y (X_n = y "infinitely often") & >= PP_y (X_m = x "and" X_n = y "for infinitely many" n >= m) \
                                      & = P_(y x)(m) PP_y (X_n = y "for infinitely many" n >= m mid(|) X_m = x) \
                                      & = P_(y x)(m) PP_x (X_n = y "infinitely often") > 0 \
  $
  Hence $y$ is recurrent. Since recurrence is a class property, $C$ is recurrent.
]

#intuition[#block(width: 100%, breakable: false)[
  With the class property, the last two theorems give, for a communicating class $C$:
  #table(
    columns: 2,
    table.header[$C$][Recurrence],
    [not closed], [transient],
    [closed and finite], [recurrent],
    [closed and infinite], [either],
  )
  So for a finite chain, recurrence can be read off the diagram: in @ex-markov-chain-four-state, ${1, 2}$ is not closed, as $1 -> 0$, while ${0}$ and ${3}$ are closed. For a closed infinite class both cases occur: the simple symmetric random walk below is recurrent on $ZZ$ and transient on $ZZ^3$.
]]

#theorem[
  If $A subset.eq I$ is a recurrent class, then
  $
    PP_x (T_y < oo) = 1 quad "for all" x, y in A.
  $
]
#proof[
  Choose $x, y in A$ and pick $m >= 1$ such that $P_(y x) (m) > 0.$ Then, by recurrence,
  $
    1 & = PP_y (X_n = y "infinitely often") \
      & = sum_(z in I) PP_y (X_m = z, X_n = y "for infinitely many" n >= m) \
      & = sum_(z in I) P_(y z)(m) underbracket(
          PP_y (X_n = y "for infinitely many" n >= m mid(|) X_m = z),
            & PP_z (X_n = y "infinitely often") \
          = & PP_z (X_n = y "infinitely often", T_y < oo) \
          = & PP_z (T_y < oo) PP_y (X_n = y "infinitely often") \
          = & PP_z (T_y < oo)
        ) \
  $
  Hence we have shown that
  $
    sum_(z in I) P_(y z)(m) PP_z (T_y < oo) = 1.
  $
  Since $sum_z P_(y z)(m) = 1$ and $PP_z (T_y < oo) <= 1$, we have that $PP_z (T_y < oo) = 1$ for all $z in I$ with $P_(y z)(m) > 0$. In particular, since $P_(y x)(m) > 0$, we have $PP_x (T_y < oo) = 1$.
]

#intuition[#block(width: 100%, breakable: false)[
  #let bl = rule("blue") + 0.8pt
  #let lb(x) = text(fill: ink("blue"), x)
  #let gr(x) = text(fill: ink("gray"), x)
  #fletcher-diagram(
    spacing: (6em, 1.4em),
    node((0, 1), $y$),
    node((1, 0), lb($x$)),
    node((1, 2), $z$),
    node((2, 1), $y$),
    edge((0, 1), (1, 0), lb($P_(y x)(m)$), "->", stroke: bl, label-side: left, label-sep: 0.6em),
    edge((0, 1), (1, 2), $P_(y z)(m)$, "->", label-side: right, label-sep: 0.6em),
    edge((1, 0), (2, 1), lb($PP_x (T_y < oo)$), "->", stroke: bl, label-side: left, label-sep: 0.8em),
    edge((1, 2), (2, 1), $PP_z (T_y < oo)$, "->", label-side: right, label-sep: 0.8em),
    node((0, 2.8), gr[time $0$]),
    node((1, 2.8), gr[time $m$]),
    node((2, 2.8), gr[later]),
  )
  The blue path is the term $z = x$. Under the bracket, the chain from $z$ visits $y$ infinitely often iff it hits $y$ and then returns infinitely often, which has probability $PP_z (T_y < oo)$ by the strong Markov property at $T_y$, as $y$ is recurrent.

  With $z = x$ this gives $PP_x (X_n = y "infinitely often") = PP_x (T_y < oo) = 1$, so from any state of $A$ the chain visits every state of $A$ infinitely often. This needs recurrence: in @ex-markov-chain-four-state, $1 <-> 2$ but $PP_1 (T_2 < oo) = 1\/2$.
]]

== Random Walks

#definition[Simple Symmetric Random Walk][
  A *simple symmetric random walk* (SSRW) on $ZZ^d$ is the Markov chain with transition probabilities
  $
    P(x, x+e_i) = P(x, x-e_i) = (1)/(2d) quad "for" i = 1, ..., d,
  $
  where $(e_i)_(i = 1)^d$ is the standard basis of $RR^d$.
]

#theorem[
  The SSRW on $ZZ^d$ is

  - recurrent for $d = 1, 2$;

  - transient for $d = 3$.
]

#proof[

  *$d=1$.* We will show that $0$ is recurrent, _i.e._
  $
    sum_(n>=0) P_(00)(n) = oo.
  $
  Note that $P_00 (n) > 0$ iff $n$ is even. Also, for $P_00(2n)$ to be positive, we have to take $n$ steps to the right and $n$ steps to the left, in some order. Hence
  $
    P_00(2n) = binom(2n, n) ((1)/(2))^(2n) = (2n)!/(n! n!) 2^(-2n).
  $
  By Stirling's formula $n! ~ sqrt(2 ppi n) (n/ee)^n$, we have
  $
    P_00 (2n) ~ (1)/(sqrt(ppi n))
  $
  Hence for some $N_0$ sufficiently large, we have
  $
    P_00 (2n) >= (1)/(2 sqrt(ppi n)) "for all" n >= N_0.
  $
  Therefore,
  $
    sum_(n>=0) P_00(n) = sum_(n>=0) P_00(2n) >= sum_(n>=N_0) (1)/(2 sqrt(ppi n)) = oo.
  $
  Hence $0$ is recurrent and since the chain is irreducible, the chain itself is recurrent.

  #separator

  *$d=2$.* Let $vb(X) = (X_n)_(n>=0)$ be the SSRW on $ZZ^2$ with $X_0 = 0$. Let $f: ZZ^2 -> RR^2$ be the projection map onto the lines $y = x$ and $y = -x$, _i.e._
  $
    f(x, y) = ((x+y)/(sqrt(2)), (x-y)/(sqrt(2))).
  $
  Write
  $
    (X_n^+, X_n^-) = f(X_n).
  $
  #lemma[
    $(X_n^+)_(n>=0)$ and $(X_n^-)_(n>=0)$ are independent SSRWs on $ZZ\/sqrt(2)$.
  ]

  #proof[
    We can write
    $
      X_n = sum_(i=1)^n xi_i
    $
    where $(xi_i)$ consists of independent and identically distributed copies of
    $
      xi_i = cases(
        (1, 0),
        (-1, 0),
        (0, 1),
        (0, -1)
      ) = (xi_i^1, xi_i^2)
    $
    each with probability $1/4$. Then
    $
      X_n^+ = sum_(i=1)^n (xi_i^1 + xi_i^2)/(sqrt(2)), quad X_n^- = sum_(i=1)^n (xi_i^1 - xi_i^2)/(sqrt(2)).
    $
    Hence each of them is a SSRW on $ZZ\/sqrt(2)$. To see that they are also independent, it suffices to check that each step is independent, _i.e._ that
    $
      xi_i^1 + xi_i^2 indep xi_i^1 - xi_i^2.
    $
    There are only 4 cases to check by hand. For example,
    $
      PP(xi_i^1 + xi_i^2 = 1, xi_i^1 - xi_i^2 = -1) & = PP(xi_i^1 = 0, xi_i^2 = 1) \
                                                    & = 1/4 \
                                                    & = (1)/(2) dot (1)/(2) \
                                                    & = PP(xi_i^1 + xi_i^2 = 1) PP(xi_i^1 - xi_i^2 = -1).
    $
  ]

  #intuition[
    #let steps = canvas(length: 1.15cm, {
      import draw: *
      let (b, r) = (rule("blue"), rule("red"))
      line((-1.4, -1.4), (1.4, 1.4), stroke: b + 0.6pt, mark: (end: "stealth", fill: b, stroke: b))
      line((-1.4, 1.4), (1.4, -1.4), stroke: r + 0.6pt, mark: (end: "stealth", fill: r, stroke: r))
      content((1.45, 1.45), text(fill: ink("blue"), $X^+$), anchor: "south-west")
      content((1.45, -1.45), text(fill: ink("red"), $X^-$), anchor: "north-west")
      line((1, 0), (0, 1), (-1, 0), (0, -1), close: true, stroke: (paint: rule("gray"), thickness: 0.5pt, dash: "dashed"))
      for (p, lab, anc) in (
        ((1, 0), $(1, 0)$, "west"),
        ((0, 1), $(0, 1)$, "south"),
        ((-1, 0), $(-1, 0)$, "east"),
        ((0, -1), $(0, -1)$, "north"),
      ) {
        line((0, 0), p, stroke: 0.8pt, mark: (end: "stealth"))
        content(p, lab, anchor: anc, padding: 0.12)
      }
    })
    #let cases = [
      #table(
        columns: 3,
        align: center + horizon,
        table.header[][$cred(X^-)$ up][$cred(X^-)$ down],
        [$cblue(X^+)$ up], $(1, 0)$, $(0, 1)$,
        [$cblue(X^+)$ down], $(0, -1)$, $(-1, 0)$,
      )
      Each pair of signs is one step, with probability $1\/4 = 1\/2 dot 1\/2$.
    ]
    #if is-html [#steps #cases] else {
      grid(columns: (auto, 1fr), column-gutter: 2em, align: horizon, steps, cases)
    }
  ]

  Now, arguing as before, $P_(00)(n) > 0$ iff $n$ is even, and
  $
    P_00(2n) & = PP_0 ((X_(2n)^+, X_(2n)^-) = (0, 0)) = PP_0 (X_(2n)^+ = 0) PP_0 (X_(2n)^- = 0) \
             & ~ ((1)/(sqrt(ppi n)))^2 = (1)/(ppi n)
  $
  Hence for some $N_0$ sufficiently large,
  $
    sum_(n>=0) P_00(n) = sum_(n>=0) P_00(2n) >= sum_(n>=N_0) (1)/(2 ppi n) = oo.
  $
  Therefore $0$ is recurrent and since $vb(X)$ is irreducible, $vb(X)$ is recurrent.

  #lecture-separator(lecture: 8, date: "2026-11-03")

  *$d = 3$.* As before, we note that $P_00(n)>0$ iff $n$ is even. In $2n$ steps, being back at $0$ having started at $0$ means that the walk took
  $
    & i "steps left",    && quad i "steps right", \
    & j "steps up",      && quad j "steps down", \
    & k "steps forward", && quad k "steps backward"
  $
  in some order, where $i + j + k = n$. Hence
  $
    P_00 (2n) & = sum_(i, j, k\ i+j+k = n) binom(2n, i, i, j, j, k, k) ((1)/(6))^(2n) \
              & = sum_(i+j+k = n) binom(2n, n) binom(n, i, j, k)^2 ((1)/(2))^(2n) ((1)/(3))^(2n). \
  $
  Suppose $n = 3m$. Then, a simple calculation shows that
  $
    binom(n, i, j, k) <= binom(n, m, m, m).
  $
  Hence
  $
    P_00 (2n) & <= underbracket(binom(2n, n) binom(n, m, m, m) ((1)/(2))^(2n) ((1)/(3))^n, ~ (c)/(n^(3\/2))) underbracket(sum_(i+j+k = n) binom(n, i, j, k) ((1)/(3))^(n), =1\ "probabilities of placing" n=3m \ "balls into" 3 "boxes at random"). \
  $
  Therefore, $sum_(m >= 0) P_00 (6 m) < oo$.

  #intuition[
    #block(width: 100%, breakable: false)[
    For $d = 3$, let $q_(i j k) = binom(n, i, j, k) (1\/3)^n$, the chance that $n$ balls thrown at random into $3$ boxes land $i$, $j$, $k$ in them.
    #let discs = canvas(length: 0.8cm, {
      import draw: *
      let n = 6
      let q(i, j, k) = calc.fact(n) / (calc.fact(i) * calc.fact(j) * calc.fact(k)) / calc.pow(3, n)
      let side = 5.4
      // (i, j, k) is drawn at (i a + j b + k c) / n, and a is the origin.
      let (a, b, c) = ((0, 0), (side, 0), (side / 2, side * calc.sqrt(3) / 2))
      for i in range(n + 1) {
        for j in range(n + 1 - i) {
          let k = n - i - j
          let pos = ((j * b.at(0) + k * c.at(0)) / n, (k * c.at(1)) / n)
          let hue = if (i, j, k) == (2, 2, 2) { "blue" } else { "gray" }
          circle(pos, radius: 0.36 * calc.sqrt(q(i, j, k) / q(2, 2, 2)), fill: rule(hue), stroke: none)
        }
      }
      content(a, $(6, 0, 0)$, anchor: "north", padding: 0.25)
      content(b, $(0, 6, 0)$, anchor: "north", padding: 0.25)
      content(c, $(0, 0, 6)$, anchor: "south", padding: 0.25)
    })
    #let bound = [
      Discs of area proportional to $q_(i j k)$, for $n = 6$. Moving a ball from a box with $i$ balls to one with $j <= i - 2$ multiplies $q$ by $i\/(j + 1) > 1$, so the largest $q$ has $i, j, k$ within $1$ of each other, which for $n = 3m$ forces $i = j = k = m$. As the $q_(i j k)$ sum to $1$,
      $
        sum_(i+j+k=n) q_(i j k)^2 <= cblue(q_(m m m)) sum_(i+j+k=n) q_(i j k) = cblue(q_(m m m)).
      $
    ]
    #if is-html [#discs #bound] else {
      grid(columns: (auto, 1fr), column-gutter: 2em, align: horizon, discs, bound)
    }
    ]
    So $P_00 (2n) = binom(2n, n) 2^(-2n) sum q_(i j k)^2 <= binom(2n, n) 2^(-2n) q_(m m m)$, and by Stirling's formula $binom(2n, n) 2^(-2n) ~ 1\/sqrt(ppi n)$ and $q_(m m m) = (3m)! \/ ((m!)^3 3^(3m)) ~ sqrt(3)\/(2 ppi m)$, which gives the $c \/ n^(3\/2)$ above.
  ]

  But we also have the relations
  $
    P_00 (6 m) & >= ((1)/(6))^2 P_00 (6 m - 2), \
    P_00 (6 m) & >= ((1)/(6))^4 P_00 (6 m - 4).
  $
  So $sum_(n>=0) P_00 (2n) < oo$, and $0$ is transient. Since $vb(X)$ is irreducible, $vb(X)$ is transient.
]

#intuition[
  Each coordinate of $X_(2n)$ is a sum of $2n$ independent steps, equal to $1$ or $-1$ with probability $1\/(2d)$ each, and $0$ otherwise, so it has mean $0$ and standard deviation $sqrt(2n\/d)$. Hence the walk is spread over a box of side about $sqrt(n)$, with about $n^(d\/2)$ sites, which suggests that $P_00 (2n)$ is of order $n^(-d\/2)$. This is summable iff $d >= 3$.
]

#example[Asymmetric Random Walk on $ZZ$][
  Consider the Markov chain $vb(X) = (X_n)_(n>=0)$ on $ZZ$ with transition probabilities
  $
    P(x, x+1) = p, quad P(x, x-1) = 1-p,
  $
  for some $p in (0, 1)$, $p != (1)/(2)$. Then, arguing as before, we have that
  $
    P_00(2n) & = binom(2n, n) p^n (1-p)^n \
             & ~ (4 p (1-p))^(n) / sqrt(ppi n)
  $
  but now $4 p (1-p) < 1$, so this is summable. We have
  $
    sum_(n>=0) P_00(n) < oo.
  $
  So $0$ is transient, and hence the chain is transient.
]

#intuition[
  Under $PP_0$, $X_n$ is a sum of $n$ i.i.d. steps of mean $2p - 1 != 0$, so by the strong law of large numbers $X_n \/ n -> 2p - 1$ almost surely #fade[[_cf._ IA Probability]]. Hence $abs(X_n) -> oo$, and the walk visits $0$ only finitely often.
]
