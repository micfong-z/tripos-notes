#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/mannot:0.4.0": markul

= Applications of Linear Programming

Linear programming is widely used in various fields such as game theory and network flow problems.

== Two Person Zero-Sum Games

A two person zero-sum game can be described as a $m times n$ *payoff matrix* $matbold(A)$, where
$
  matbold(A) = #h(1.25em) labelmat(
    mat(
      a_(11), a_(12), dots.c, a_(1n);
      a_(21), a_(22), dots.c, a_(2n);
      dots.v, dots.v, dots.down, dots.v;
      a_(m 1), a_(m 2), dots.c, a_(m n)
    ),
    1, 2, dots.v, m,
    1, 2, ..., n,
    dx: #{ 2em }, dy: #{ 1.2em },
  ).
$
where $1, ..., m$ describes the strategies of player 1 (P1) and $1, ..., n$ describes the strategies of player 2 (P2). The entry $a_(i j)$ is the payoff to P1 when P1 plays strategy $i$ and P2 plays strategy $j$. Since the game is zero-sum, the payoff to P2 is $-a_(i j)$.

#example[Rock-Paper-Scissors][
  Consider the game of rock-paper-scissors. The payoff matrix for P1 is
  $
    matbold(A) = #h(1em) labelmat(
      mat(
        0, -1, 1;
        1, 0, -1;
        -1, 1, 0
      ),
      "R", "P", "S",
      "R", "P", "S",
      dx: #{ 1.5em }, dy: #{ 1em },
    ).
  $
]

Assuming both players are rational, then if P1 plays $i$ then they can expect a payoff of
$
  i |-> min_(j in {1, ..., n}) a_(i j).
$
Hence, P1 will try to find
$
  max_(i in {1, ..., m}) (min_(j in {1, ..., n}) a_(i j)).
$

Similarly, P2 will try to find
$
  min_(j in {1, ..., n}) (max_(i in {1, ..., m}) a_(i j)).
$

=== Pure and Mixed Strategies

#example[Pure strategies][
  Consider the following game with payoff matrix
  $
    matbold(A) = mat(1, 2; 3, 4).
  $
  From P1's perspective, if P2 plays strategy 1 then they should play strategy 2, and if P2 plays strategy 2 then they should still play strategy 2. Hence, P1 will choose strategy 2.

  From P2's perspective, if P1 plays strategy 1 then they should play strategy 1, and if P1 plays strategy 2 then they should still play strategy 1. Hence, P2 will choose strategy 1.

  In this case we have a *saddle point* at $(2, 1)$, and the expected outcome is $a_(21) = 3$. We say that both players are playing *pure strategies*, since they are choosing a single strategy to play.
] <ex-pure-strategies>

#example[Mixed strategies][
  Consider the following game with payoff matrix
  $
    matbold(A) = mat(4, 2; 1, 3).
  $

  From P1's perspective, if P2 plays strategy 1 then they should play strategy 1, and if P2 plays strategy 2 then they should play strategy 2.

  From P2's perspective, if P1 plays strategy 1 then they should play strategy 2, and if P1 plays strategy 2 then they should play strategy 1.

  Note that there is no saddle point in this game, and the expected outcome is not well-defined. In this case, we will need to consider *mixed strategies*.
] <ex-mixed-strategies>

#definition[Pure and Mixed Strategies][
  A *pure strategy* is a strategy that is chosen with probability 1.

  A *mixed strategy* is a probability distribution over the set of pure strategies.
]

In @ex-pure-strategies, both players are playing pure strategies, and in @ex-mixed-strategies, P1 would pick a distribution $vb(p)$ on their action, where
$
  vb(p) = vec(p_(1), dots.v, p_(m)).
$

If P1's strategy is $vb(p)$, then their expected payoff is $min_(j in {1, ..., n}) sum_(i=1)^m p_i a_(i j)$. Hence they will try to find
$
  max_(vb(p)) (min_(j in {1, ...,, n}) sum_(i=1)^m p_i a_(i j)).
$
We can express P1's optimisation problem as
$
  & "maximise"   && v \
  & "subject to" && matbold(A)^tp vb(p) >= v vb(e) \
  &              && vb(e)^tp vb(p) = 1 \
  &              && vb(p) >= vb(0) \
  & "where"      && vb(e) = (1, dots.c, 1)^tp in RR^m.
$

We can also express P2's optimisation problem as
$
  & "minimise"   && w \
  & "subject to" && matbold(A) vb(q) <= w vb(e) \
  &              && vb(e)^tp vb(q) = 1 \
  &              && vb(q) >= vb(0) \
  & "where"      && vb(e) = (1, dots.c, 1)^tp in RR^n.
$

Rather surprisingly, these two linear programmes are dual to each other. Hence, we can solve either one of them to find the optimal strategies for both players, and we have a saddle point $(vb(p)^*, vb(q)^*)$ in the sense of mixed strategies.

#lemma[
  The two linear programmes in a two person zero-sum game are dual to each other.
]

#proof[
  The dual of P2's problem is
  $
    lagr(w, vb(q), vb(s), vb(lambda_1), lambda_2) &= w + vb(lambda_1)^tp (matbold(A) vb(q) + vb(s) - w vb(e)) - lambda_2 (vb(e)^tp vb(q) - 1) \
    &= w(1-vb(lambda_1)^tp vb(e)) + (vb(lambda_1)^tp matbold(A) - lambda_2 vb(e)^tp) vb(q) + vb(lambda_1)^tp vb(s) + lambda_2.
  $

  Note that $Lambda$ satisfies

  1. $vb(lambda_1)^tp vb(e) = 1$,

  2. $vb(lambda_1)^tp matbold(A) >= lambda_2 vb(e)^tp$,

  3. $vb(lambda_1) >= vb(0)$.

  When $lambda in Lambda$, $min lagr = lambda_2$. Hence, the dual of P2's problem is
  $
    & "maximise"   && lambda_2 \
    & "subject to" && vb(lambda_1)^tp vb(e) = 1 \
    &              && vb(lambda_1) >= vb(0) \
    &              && matbold(A)^tp vb(lambda_1) >= lambda_2 vb(e). \
  $
  Replacing $vb(lambda_1)$ with $vb(p)$ and $lambda_2$ with $v$, we see that this is exactly P1's problem.
]

#theorem[Optimal Strategies in Two Person Zero-Sum Games][
  A strategy $vb(p)$ is optimal for P1 if and only if there exists a strategy $vb(q)$ and $v$ such that

  1. $matbold(A)^tp vb(p) >= v vb(e), vb(e)^tp vb(p) = 1, vb(p) >= 0$ #fade[[primal feasibility]],

  2. $matbold(A) vb(q) <= v vb(e), vb(e)^tp vb(q) = 1, vb(q) >= 0$ #fade[[dual feasibility]],

  3. $vb(p)^tp matbold(A) vb(q) = v$ #fade[[complementary slackness]].
]

#proof[
  We are only left to check the complementary slackness condition.

  If $(vb(p), v)$ and $(vb(q), w)$ are primal/dual optimal, then

  1. $(matbold(A) vb(q) - w vb(e))^tp vb(p) = 0$

  2. $vb(q)^tp (matbold(A)^tp vb(p) - v vb(e)) = 0$

  Hence, we must have
  $
    vb(p)^tp matbold(A) vb(q) = v = w.
  $

]

#lecture-separator(lecture: 10, date: "2026-05-22")

=== Finding Optimal Strategies

#listing[Finding Optimal Strategies in Two Person Zero-Sum Games][
  To find the optimal strategies in a two person zero-sum game,

  1. Look for a saddle point in the payoff matrix. If one exists, then both players will play it.

  2. Look for dominating actions, _i.e._ actions that are always better than some other action. For example, for P1, if there exists $i_1$ and $i_2$ such that $a_(i_1 j) >= a_(i_2 j)$ for all $j$, then P1 will never play action $i_2$.

  3. Solve the linear programme, either graphically or using the simplex method.
]

#example[
  Consider the following game with payoff matrix (for P1),
  $
    matbold(A) = mat(2, 3, 4; 3, 1, (1)/(2); 1, 3, 2).
  $
  First of all, note that action 3 is always worse than action 1 for P1, so P1 will never play action 3. Hence, we can reduce the payoff matrix to
  $
    matbold(A) = mat(2, 3, 4; 3, 1, (1)/(2)).
  $

  Then, we need to find $vb(p) = (p, 1-p)^tp$ and $vb(q) = (q_1, q_2, q_3)^tp$ in the following problem:
  $
    & "maximise"   && v \
    & "subject to" && 2p + 3(1-p) >= v \
    &              && 3p + (1-p) >= v \
    &              && 4p + (1)/(2)(1-p) >= v \
    &              && 0 < p <= 1.
  $
  It might be easier to solve this problem graphically as shown in the figure below.

  #align(center)[
    #dynamic-svg2("/part-ib/optimisation/media/d1e9.svg", width: 16em)
  ]
  In this case, we find that the optimal strategy is $((2)/(3), (1)/(3), 0)$.

]

== Network Flows

#definition[Directed Graph][
  A *directed graph* is a pair $G = (V, E)$ where $V$ is a set of vertices and $E subset.eq V times V$ is a set of directed edges.
]

#definition[Minimum Cost Flow Problem on Graphs][

  Let $G = (V, E)$ with $abs(V) = n$. There is a flow $x_(i j)$ for each edge $(i, j) in E$. Consider

  1. A vector $vb(b) in RR^n$ such that $b_i$ is the flow entering vertex $i$.

  2. A cost matrix $matbold(C)$ where $C_(i j)$ is the cost per unit flow along edge $(i, j)$.

  3. The matrices $overline(matbold(M))$ and $underline(matbold(M))$ such that the flow along edge $(i, j)$ is bounded by $underline(M)_(i j) <= x_(i j) <= overline(M)_(i j)$.

  We always have $sum_(i=1)^n b_i = 0$. The *minimum cost flow problem* is to find a flow $x_(i j)$ that solves the following problem:
  $
    & "minimise"   && sum_((i, j) in E) C_(i j) x_(i j) \
    & "subject to" && b_i + sum_((j, i) in E) x_(j i) = sum_((i, j) in E) x_(i j) , \
    &              && underline(M)_(i j) <= x_(i j) <= overline(M)_(i j).
  $

  #remark[
    The condition of $sum_(i=1)^n b_i = 0$ is automatic by taking double sums over the first constraint.
  ]
]

We will, however, focus primarily on the transport problem, which is a special case of the minimum cost flow problem.

#definition[Transport Problem][
  The *transport problem* is a special case of the minimum cost flow problem where there are

  - $n$ suppliers $i in {1, ..., n}$
  - $m$ consumers $j in {1, ..., m}$

  and supplier $i$ produces $s_i$ units of goods; consumer $j$ demand $d_j$ units of goods. We have
  $
    sum_(i=1)^n s_i = sum_(j=1)^m d_j.
  $

  The cost of moving one unit of goods from supplier $i$ to consumer $j$ is $C_(i j)$. The *transport problem* is to find a flow $x_(i j)$ that solves the following problem:
  $
    & "minimise"   && sum_(1<=i<=n\ 1<=j<=m) C_(i j) x_(i j) \
    & "subject to" && sum_(j=1)^m x_(i j) = s_i              && quad "for" 1 <= i <= n \
    &              && sum_(i=1)^n x_(i j) = d_j              && quad "for" 1 <= j <= m \
    &              && x_(i j) >= 0                           && quad "for" 1 <= i <= n, 1 <= j <= m.
  $
]

Note that this is a linear programme in standard form, and we might be able to solve it using the simplex algorithm as mentioned in @sec-simplex-algorithm. However, note that the first and the second constraints are linearly dependent, so we need to remove at least one of the equations.

In this course, we will use another version of the simplex algorithm called the *transportation simplex algorithm*, which is more efficient for this problem. We will see this in the following sections.

#theorem[
  Every minimum cost flow problem with finite capacities (i.e. $overline(M)_(i j) < oo$ for all $(i, j) in E$) can be recast as an equivalent transport problem.
]

#remark[
  If $C_(i j) > 0$ for all $(i, j) in E$, then we can assume $overline(M)_(i j) < oo$ WLOG. In fact, we could set
  $
    overline(M)_(i j) = sum_(i in V) abs(b_i)
  $
  for those $(i, j)$ where $overline(M)_(i j) = oo$.

]

#proof[
  We could set
  $
    tilde(x)_(i j) = x_(i j) - underline(M)_(i j).
  $
  Such that
  $
                      0 & <= tilde(x)_(i j) <= overline(M)_(i j) - underline(M)_(i j) \
    sum C_(i j) x_(i j) & = sum C_(i j) tilde(x)_(i j) + sum C_(i j) underline(M)_(i j).
  $
  We can rewrite the flow condition by substituting $b_i$ by $tilde(b)_i$ by $tilde(b)_i = b_i + sum_(j: (j, i) in E) underline(M)_(j i) - sum_(j: (i, j) in E) underline(M)_(i j)$.

  Hence WLOG, assume $underline(matbold(M)) = matbold(0)$.

  For every vertex $i$, construct a consumer ($abs(V)$ consumers), and for every edge $(i, j)$ construct a supplier ($abs(E)$ suppliers), and consider the following transport problem:

  #align(center)[
    #dynamic-svg2("/part-ib/optimisation/media/d1e11.svg", width: 24em)
  ]

  The total flow into consumer $i$ is
  $
    sum_(k : (i, k) in E) (overline(M)_(i k) - x_(i k)) + sum_(k : (k, i) in E) x_(k i).
  $
  The total demand at consumer $i$ is
  $
    sum_(k : (i, k) in E) overline(M)_(i k) - b_i.
  $
  Setting these equal, we have
  $
    sum_(k : (i, k) in E) x_(i k) = b_i + sum_(k : (k, i) in E) x_(k i).
  $
  These are exactly what we want. Also, for any solution $matbold(x)$ to the transport problem, the cost is
  $
    sum_((i, j) in E) x_(i j) c_(i j)
  $
  which is exactly the cost in the minimum cost flow problem. Hence, we have an equivalent transport problem.
]

#lecture-separator(lecture: 11, date: "2026-05-25")

#theorem[Optimality Conditions for the Transport Problem][
  If for some feasible $matbold(x)$, we have dual variables $vb(lambda) in RR^n$, $vb(mu) in RR^m$ such that
  $
                                  c_(i j) & >= lambda_i + mu_j quad && "for all" i, j \
    (c_(i j) - (lambda_i + mu_j)) x_(i j) & = 0 quad                && "for all" i, j,
  $
  then $matbold(x)$ is optimal.
] <thm-optimality-conditions-for-transport-problem>

#proof[
  The Lagrangian is given by
  $
    lagr(matbold(x), vb(lambda), vb(mu)) &= sum_(i = 1)^n sum_(j =1)^m c_(i j) x_(i j) - sum_(i = 1)^n lambda_i (sum_(j=1)^m x_(i j) - s_i) - sum_(j = 1)^m mu_j (sum_(i=1)^n x_(i j) - d_j) \
    &= sum_(i=1)^n sum_(j =1)^m (c_(i j) - lambda_i - mu_j) x_(i j) + sum_(i=1)^n lambda_i s_i + sum_(j=1)^m mu_j d_j.
  $

  The conditions in the theorem mean that given $vb(lambda), vb(mu)$ are dual feasible, and complementary slackness holds. Using @thm-optimality-conditions-for-linear-programming[Optimality Conditions for Linear Programming], we see that $matbold(x)$ is optimal.
]

#remark[
  For a given basic feasible solution $matbold(x)$, when we solve for $vb(lambda), vb(mu)$ using complementary slackness, assume $lambda_1 = 0$ WLOG.

  #fade[[This comes from the additional degree of freedom in the dual problem, since we can add a constant to all $lambda_i$ and subtract the same constant from all $mu_j$.]]
]

=== Solving the Transport Problem

In order to run the transportation simplex algorithm, we need to form a transportation tableau:


#let const(content) = mark(content, colors.yellow.shade700)
#let new(content) = mark(content, colors.blue.shade700)


#align(center)[
  #table(
    columns: 9,
    align: center + horizon,
    stroke: (x, y) => {
      if (x != 0) and (y != 0) and (x != 8) and (y != 8) {
        stroke(colors.border-dark + 0.75pt)
      }
    },
    [], table.cell(colspan: 2, $mu_1$), table.cell(colspan: 2, $mu_2$), $dots.c$, table.cell(colspan: 2, $mu_m$), [],
    table.cell(rowspan: 2, $lambda_1$),
    table.cell(colspan: 2, $lambda_1+mu_1$),
    table.cell(colspan: 2, $lambda_1+mu_2$),
    $dots.c$,
    table.cell(colspan: 2, $lambda_1+mu_m$),
    table.cell(rowspan: 2, $const(s_1)$),
    $x_(1 1)$, $const(C_(1 1))$, $x_(1 2)$, $const(C_(1 2))$, $dots.c$, $x_(1 m)$, $const(C_(1 m))$,

    table.cell(rowspan: 2, $lambda_2$),
    table.cell(colspan: 2, $lambda_2+mu_1$),
    table.cell(colspan: 2, $lambda_2+mu_2$),
    $dots.c$,
    table.cell(colspan: 2, $lambda_2+mu_m$),
    table.cell(rowspan: 2, $const(s_2)$),
    $x_(2 1)$, $const(C_(2 1))$, $x_(2 2)$, $const(C_(2 2))$, $dots.c$, $x_(2 m)$, $const(C_(2 m))$,

    $dots.v$,
    table.cell(colspan: 2, $dots.v$),
    table.cell(colspan: 2, $dots.v$),
    $dots.down$,
    table.cell(colspan: 2, $dots.v$),
    $dots.v$,

    table.cell(rowspan: 2, $lambda_n$),
    table.cell(colspan: 2, $lambda_n+mu_1$),
    table.cell(colspan: 2, $lambda_n+mu_2$),
    $dots.c$,
    table.cell(colspan: 2, $lambda_n+mu_m$),
    table.cell(rowspan: 2, $const(s_n)$),
    $x_(n 1)$, $const(C_(n 1))$, $x_(n 2)$, $const(C_(n 2))$, $dots.c$, $x_(n m)$, $const(C_(n m))$,
    [],
    table.cell(colspan: 2, $const(d_1)$),
    table.cell(colspan: 2, $const(d_2)$),
    $dots.c$,
    table.cell(colspan: 2, $const(d_m)$),
    [],
  )
]


#notation[
  In the tableau, we will use

  - yellow values to denote constants that do not change during the algorithm,

  - blue values to denote variables that recently changed,

  - faded values to denote variables that we have not yet solved for, and

  - shaded cells to denote non-zero flows in the current solution.
]


#example[Transportation Simplex Algorithm][
  Consider the following transport problem with $n = 3$ and $m = 4$ with demand and supply
  $
    vb(s) = (14, 10, 9)^tp quad vb(d) = (12, 5, 8, 8)^tp,
  $
  and a cost matrix
  $
    matbold(C) = mat(5, 3, 4, 6; 2, 7, 4, 1; 5, 6, 2, 4).
  $

  Hence we can construct the following transportation tableau:

  #align(center, table(
    columns: 10,
    align: center + horizon,
    stroke: (x, y) => {
      if (x != 0) and (y != 0) and (x != 9) and (y != 7) {
        stroke(colors.border-dark + 0.75pt)
      }
    },
    [],
    table.cell(colspan: 2, $fade(mu_1)$),
    table.cell(colspan: 2, $fade(mu_2)$),
    table.cell(colspan: 2, $fade(mu_3)$),
    table.cell(colspan: 2, $fade(mu_4)$),
    [],
    table.cell(rowspan: 2, $fade(lambda_1)$),
    table.cell(colspan: 2, $fade(lambda_1+mu_1)$),
    table.cell(colspan: 2, $fade(lambda_1+mu_2)$),
    table.cell(colspan: 2, $fade(lambda_1+mu_3)$),
    table.cell(colspan: 2, $fade(lambda_1+mu_4)$),
    table.cell(rowspan: 2, $const(14)$),
    $fade(x_(1 1))$,
    $const(5)$,
    $fade(x_(1 2))$,
    $const(3)$,
    $fade(x_(1 3))$,
    $const(4)$,
    $fade(x_(1 4))$,
    $const(6)$,

    table.cell(rowspan: 2, $fade(lambda_2)$),
    table.cell(colspan: 2, $fade(lambda_2+mu_1)$),
    table.cell(colspan: 2, $fade(lambda_2+mu_2)$),
    table.cell(colspan: 2, $fade(lambda_2+mu_3)$),
    table.cell(colspan: 2, $fade(lambda_2+mu_4)$),
    table.cell(rowspan: 2, $const(10)$),
    $fade(x_(2 1))$,
    $const(2)$,
    $fade(x_(2 2))$,
    $const(7)$,
    $fade(x_(2 3))$,
    $const(4)$,
    $fade(x_(2 4))$,
    $const(1)$,

    table.cell(rowspan: 2, $fade(lambda_3)$),
    table.cell(colspan: 2, $fade(lambda_3+mu_1)$),
    table.cell(colspan: 2, $fade(lambda_3+mu_2)$),
    table.cell(colspan: 2, $fade(lambda_3+mu_3)$),
    table.cell(colspan: 2, $fade(lambda_3+mu_4)$),
    table.cell(rowspan: 2, $const(9)$),
    $fade(x_(3 1))$,
    $const(5)$,
    $fade(x_(3 2))$,
    $const(6)$,
    $fade(x_(3 3))$,
    $const(2)$,
    $fade(x_(3 4))$,
    $const(4)$,
    [],
    table.cell(colspan: 2, $const(12)$),
    table.cell(colspan: 2, $const(5)$),
    table.cell(colspan: 2, $const(8)$),
    table.cell(colspan: 2, $const(8)$),
    [],
  ))

  We start by constructing a feasible solution using the *northwest corner method*, by starting from the first supplier and the first consumer, and allocating as much as possible to that cell. Then, we move to the next cell  depending on whether the supply or demand is exhausted. We continue this process until all supply and demand is satisfied. #fade[[On the tableau, this looks like going from the northwest corner to the southeast corner.]] The results are shown as follows:

  #align(center)[
    #grid(
      columns: 2,
      column-gutter: 2em,
      dynamic-svg2("/part-ib/optimisation/media/d1e12.svg", width: 12em),
      table(
        columns: 10,
        fill: (x, y) => {
          let shaded = (
            (1, 1),
            (1, 2),
            (2, 2),
            (2, 3),
            (3, 3),
            (3, 4),
          )
          for (j, i) in shaded {
            if (calc.quo(x + 1, 2) == i) and (calc.quo(y + 1, 2) == j) {
              colors.blue.shade50
            }
          }
        },
        align: center + horizon,
        stroke: (x, y) => {
          if (x != 0) and (y != 0) and (x != 9) and (y != 7) {
            stroke(colors.border-dark + 0.75pt)
          }
        },
        [],
        table.cell(colspan: 2, $fade(mu_1)$),
        table.cell(colspan: 2, $fade(mu_2)$),
        table.cell(colspan: 2, $fade(mu_3)$),
        table.cell(colspan: 2, $fade(mu_4)$),
        [],
        table.cell(rowspan: 2, $fade(lambda_1)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_1)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_2)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_3)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_4)$),
        table.cell(rowspan: 2, $const(14)$),
        $new(12)$,
        $const(5)$,
        $new(2)$,
        $const(3)$,
        $new(0)$,
        $const(4)$,
        $new(0)$,
        $const(6)$,

        table.cell(rowspan: 2, $fade(lambda_2)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_1)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_2)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_3)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_4)$),
        table.cell(rowspan: 2, $const(10)$),
        $new(0)$,
        $const(2)$,
        $new(3)$,
        $const(7)$,
        $new(7)$,
        $const(4)$,
        $new(0)$,
        $const(1)$,

        table.cell(rowspan: 2, $fade(lambda_3)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_1)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_2)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_3)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_4)$),
        table.cell(rowspan: 2, $const(9)$),
        $new(0)$,
        $const(5)$,
        $new(0)$,
        $const(6)$,
        $new(1)$,
        $const(2)$,
        $new(8)$,
        $const(4)$,
        [],
        table.cell(colspan: 2, $const(12)$),
        table.cell(colspan: 2, $const(5)$),
        table.cell(colspan: 2, $const(8)$),
        table.cell(colspan: 2, $const(8)$),
        [],
      ),
    )
  ]

  Recall @thm-optimality-conditions-for-transport-problem[Optimality Conditions for the Transport Problem]. If $x_(i j) != 0$, then we have $c_(i j) = lambda_i + mu_j$. Hence, we have
  $
    lambda_1 + mu_1 = 5, quad lambda_1 + mu_2 = 3, quad lambda_2 + mu_2 = 7, \
    lambda_2 + mu_3 = 4, quad lambda_3 + mu_3 = 2, quad lambda_3 + mu_4 = 4.
  $

  Furthermore, we can set $lambda_1 = 0$ WLOG. Hence, we can solve the system with 6 equations and 6 unknowns to find
  $
    lambda_1 = 0, lambda_2 = 4, lambda_3 = 2, mu_1 = 5, mu_2 = 3, mu_3 = 0, mu_4 = 2.
  $
  Hence we arrive at the following tableau:


  #align(center)[
    #set block(breakable: false)
    #table(

      columns: 10,
      fill: (x, y) => {
        let shaded = ((1, 1), (1, 2), (2, 2), (2, 3), (3, 3), (3, 4))
        for (j, i) in shaded { if (calc.quo(x + 1, 2) == i) and (calc.quo(y + 1, 2) == j) { colors.blue.shade50 } }
      },
      align: center + horizon,
      stroke: (x, y) => { if (x != 0) and (y != 0) and (x != 9) and (y != 7) { stroke(colors.border-dark + 0.75pt) } },
      [],
      table.cell(colspan: 2, $new(5)$),
      table.cell(colspan: 2, $new(3)$),
      table.cell(colspan: 2, $new(0)$),
      table.cell(colspan: 2, $new(2)$),
      [],
      table.cell(rowspan: 2, $new(0)$),
      table.cell(colspan: 2, $new(5)$),
      table.cell(colspan: 2, $new(3)$),
      table.cell(colspan: 2, $new(0)$),
      table.cell(colspan: 2, $new(2)$),
      table.cell(rowspan: 2, $const(14)$),
      $12$,
      $const(5)$,
      $2$,
      $const(3)$,
      $0$,
      $const(4)$,
      $0$,
      $const(6)$,

      table.cell(rowspan: 2, $new(4)$),
      table.cell(colspan: 2, $new(9)$),
      table.cell(colspan: 2, $new(7)$),
      table.cell(colspan: 2, $new(4)$),
      table.cell(colspan: 2, $new(6)$),
      table.cell(rowspan: 2, $const(10)$),
      $0$,
      $const(2)$,
      $3$,
      $const(7)$,
      $7$,
      $const(4)$,
      $0$,
      $const(1)$,

      table.cell(rowspan: 2, $new(2)$),
      table.cell(colspan: 2, $new(7)$),
      table.cell(colspan: 2, $new(5)$),
      table.cell(colspan: 2, $new(2)$),
      table.cell(colspan: 2, $new(4)$),
      table.cell(rowspan: 2, $const(9)$),
      $0$,
      $const(5)$,
      $0$,
      $const(6)$,
      $1$,
      $const(2)$,
      $8$,
      $const(4)$,
      [],
      table.cell(colspan: 2, $const(12)$),
      table.cell(colspan: 2, $const(5)$),
      table.cell(colspan: 2, $const(8)$),
      table.cell(colspan: 2, $const(8)$),
      [],
    )
  ]

  We also require that $lambda_i + mu_j <= c_(i j)$. Note that in row 2, column 1, we have $9 > 2$. Hence, this means that we need to add an edge from supplier 2 to consumer 1. Once we add the edge, within a cycle in the graph we need to adjust the flow along the edges to make sure that the supply and demand constraints are still satisfied.

  Suppose the new edge has flow $theta$. Then, the maximum $theta$ we can take #fade[[without making any flow negative]] is $theta = 3$. Thus, we arrive at the following situation:

  #align(center)[
    #dynamic-svg2("/part-ib/optimisation/media/d1e13.svg", width: 12em)
  ]

  This leads to the following tableau:

  #align(center)[
    #grid(
      columns: 2,
      column-gutter: 2em,
      dynamic-svg2("/part-ib/optimisation/media/d1e14.svg", width: 12em),
      table(
        columns: 10,
        fill: (x, y) => {
          let shaded = (
            (1, 1),
            (1, 2),
            (2, 1),
            (2, 3),
            (3, 3),
            (3, 4),
          )
          for (j, i) in shaded {
            if (calc.quo(x + 1, 2) == i) and (calc.quo(y + 1, 2) == j) {
              colors.blue.shade50
            }
          }
        },
        align: center + horizon,
        stroke: (x, y) => {
          if (x != 0) and (y != 0) and (x != 9) and (y != 7) {
            stroke(colors.border-dark + 0.75pt)
          }
        },
        [],
        table.cell(colspan: 2, $fade(mu_1)$),
        table.cell(colspan: 2, $fade(mu_2)$),
        table.cell(colspan: 2, $fade(mu_3)$),
        table.cell(colspan: 2, $fade(mu_4)$),
        [],
        table.cell(rowspan: 2, $fade(lambda_1)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_1)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_2)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_3)$),
        table.cell(colspan: 2, $fade(lambda_1+mu_4)$),
        table.cell(rowspan: 2, $const(14)$),
        $new(9)$,
        $const(5)$,
        $new(5)$,
        $const(3)$,
        $0$,
        $const(4)$,
        $0$,
        $const(6)$,

        table.cell(rowspan: 2, $fade(lambda_2)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_1)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_2)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_3)$),
        table.cell(colspan: 2, $fade(lambda_2+mu_4)$),
        table.cell(rowspan: 2, $const(10)$),
        $new(3)$,
        $const(2)$,
        $new(0)$,
        $const(7)$,
        $7$,
        $const(4)$,
        $0$,
        $const(1)$,

        table.cell(rowspan: 2, $fade(lambda_3)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_1)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_2)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_3)$),
        table.cell(colspan: 2, $fade(lambda_3+mu_4)$),
        table.cell(rowspan: 2, $const(9)$),
        $0$,
        $const(5)$,
        $0$,
        $const(6)$,
        $1$,
        $const(2)$,
        $8$,
        $const(4)$,
        [],
        table.cell(colspan: 2, $const(12)$),
        table.cell(colspan: 2, $const(5)$),
        table.cell(colspan: 2, $const(8)$),
        table.cell(colspan: 2, $const(8)$),
        [],
      ),
    )
  ]

  Similar to the steps above, we can repeat this process until we arrive at an optimal solution.
]

#lecture-separator(lecture: 12, date: "2026-05-27")

== Max-Flow Min-Cut Theorem

#definition[Max-Flow Problem][
  Given a graph $G = (V, E)$ with source vertex $1$ and sink vertex $n$ (where $abs(v) = n$), the *max-flow problem* is:
  $
    & "maximise"   && delta \
    & "subject to" && sum_({j: (1, j) in E}) x_(1 j) = delta \
    &              && sum_({i: (i, n) in E}) x_(i n) = delta \
    &              && sum_({j: (i, j) in E}) x_(i j) - sum_({j: (j, i) in E}) x_(j i) = 0 quad && "for" 2 <= i <= n-1. \
    &              && 0 <= x_(i j) <= c_(i j) quad                                             && "for" (i, j) in E. \
  $
  Alternatively, let $phi_i (x) = sum_({j: (i, j) in E}) x_(i j) - sum_({j: (j, i) in E}) x_(j i)$, the max-flow problem can be written as
  $
    & "maximise"   && delta \
    & "subject to" && phi_1 (x) = delta \
    &              && phi_n (x) = delta \
    &              && phi_i (x) = 0 quad           && "for" 2 <= i <= n-1. \
    &              && 0 <= x_(i j) <= c_(i j) quad && "for" (i, j) in E. \
  $
  Furthermore, by defining
  $
    b_i = cases(
      +1 quad & "if" i = 1,
      -1 & "if" i = n,
      0 & "otherwise",
    )
  $
  we can write
  $
    & "maximise"   && delta \
    & "subject to" && phi_i (x) - b_i delta = 0 quad && "for" 1 <= i <= n. \
    &              && 0 <= x_(i j) <= c_(i j) quad   && "for" (i, j) in E. \
  $

]

#definition[Cut][
  A *cut* of $G$ is a partition of the vertices $V$ into $S$ and $V \\ S$. The capacity of the cut is
  $
    sum_({(i, j) in E: i in S, j in V \\S}) c_(i j)
  $
  #fade[[This is the total capacity of edges that crosses the cut from $S$ to $V \\ S$.]]

]

#theorem[
  Let $matbold(x)$ be a feasible flow with value $delta$. Then for any cut $(S, V \\ S)$ such that $1 in S$, $n in V \\ S$, we have
  $
    delta <= sum_({(i, j) in E: i in S, j in V \\S}) c_(i j) = c(S).
  $
] <thm-max-flow-min-cut-inequality>

#remark[
  This leads to
  $
    max_(matbold(x)) delta <= min_(S) c(S).
  $
]

#proof[

  #notation[
    For any sets $A, B subset.eq V$, write $f_matbold(x) (A, B) = sum_({(i, j) in E: i in A, j in B}) x_(i j)$. #fade[[We do not require $A$ and $B$ to be disjoint.]]
  ]

  Summing up the flow constraints over all $i in S$ gives
  $
    sum_(i in S) (sum_({j: (i, j) in E}) x_(i j) - sum_({j: (j, i) in E}) x_(j i)) = sum_(i in S) b_i delta = delta.
  $
  We can rewrite this using $f$ as
  $
    delta & = f_matbold(x) (S, V) - f_matbold(x) (V, S) \
          & = f_matbold(x) (S, V \\ S) + f_matbold(x) (S, S) - f_matbold(x) (V \\ S, S) - f_matbold(x) (S, S) \
          & = f_matbold(x) (S, V \\ S) - underbracket(f_matbold(x) (V \\ S, S), >= 0) \
          & <= f_matbold(x) (S, V \\ S) \
          & <= c(S).
  $
]

#theorem[Max-Flow Min-Cut Theorem][
  Let $delta^*$ be the max-value of the flow. Then
  $
    delta^* = min{c(S) : S subset.eq V, 1 in S, n in V \\ S}.
  $
] <thm-max-flow-min-cut-theorem>

#proof[
  It suffices to produce a set $S$ such that $c(S) = delta^*$ due to @thm-max-flow-min-cut-inequality.

  #lemma[
    If a flow $matbold(x)$ is optimal, then $matbold(x)$ cannot have augmenting paths. An augmenting path is a path from $1$ to $n$, ignoring edge orientations, such that every forward edge satisfies $x_(i j) < c_(i j)$ and every reverse edge satisfies $x_(j i) > 0$.
  ]

  #proof[
    If an augmenting path exists, then we can increase the flow from $1$ to $n$. For each forward edge $(i, j)$, we can increase the flow by $epsilon = min{c_(i j) - x_(i j)}$ and for each reverse edge $(j, i)$, we can decrease the flow by $epsilon = min{x_(j i)}$. This will increase the total flow from $1$ to $n$ by $epsilon > 0$, contradicting optimality.
  ]

  Set
  $
    S = {1} union {i: "there is an augmenting path from" 1 "to" i}
  $
  Observe that $1 in S$ but $n in.not S$. For this set $S$, summing up the flow constraints of $S$ as before:
  $
    delta^* = f_matbold(x)(S, V \\S) - f_matbold(x)(V \\S, S).
  $
  Consider $f_matbold(x)(S, V\\S)$. Note that every forward edge $i, j$ from $S$ to $V\\S$ must be saturated, or otherwise there would be an augmenting path from $1$ to $j$, contradicting the definition of $S$. Similarly, every reverse edge $j, i$ from $V\\S$ to $S$ must have $x_(j i) = 0$. Hence
  $
    f_matbold(x)(S, V\\S) & = c(S) \
    f_matbold(x)(V\\S, S) & = 0.
  $
  Therefore, we have $delta^* = c(S)$.
]

#listing[Ford-Fulkerson Algorithm][
  This is an algorithm to find the maximum flow in a flow network.

  1. Start with an initial flow $matbold(x) = matbold(0)$.

  2. While there exists an augmenting path from $1$ to $n$, increase the flow along the path by $epsilon = min{c_(i j) - x_(i j)}$ for forward edges and $epsilon = min{x_(j i)}$ for reverse edges.

  3. Repeat until no augmenting path exists. The resulting flow is optimal, and the set $S$ defined in the proof of @thm-max-flow-min-cut-theorem[Max-Flow Min-Cut Theorem] gives a minimum cut.

  #remark[
    If one can find a cut such that $c(S) = delta^*$, then the flow must be optimal.
  ]
]
