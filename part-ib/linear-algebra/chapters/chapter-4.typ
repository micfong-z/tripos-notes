#import "../prelude.typ": *
#show: chapter.with(4)

// #show <intuition>: none

= Dual Spaces

#intuition[
  In $FF^n$, a row times a column is a scalar: the left-hand side of $2x - y + z = 3$ is the row $mat(2, -1, 1)$, and the $i$-th coordinate of $v$ is $e_i^TT v$. A general vector space has no rows until we choose a basis, but linear maps to scalars still exist, _e.g._ $f |-> f(0)$, $f |-> integral_0^1 f(t) dif t$, $tr$, and the coordinates w.r.t. any basis. $V^*$ collects them, so it is the abstract version of row vectors. The table at the end of the chapter lists the correspondences.

  #fade[[In IB Methods, $delta(x)$ is really the functional $f |-> f(0)$.]]
]

#definition[Dual Space][
  Let $V$ be a $FF$-vector space. The *dual space* of $V$ is
  $
    V^* = scr(L)(V, FF) = Set(theta\: V-> FF; theta "is linear"). \
  $
  Note that $V^*$ is an $FF$-vector space.
]

#example[
  + Consider $V = RR^4$, we have the following $theta_1, theta_2, theta_3in V^*$:
    $
      theta_1(v) & = 2 (v_2 + v_4) - v_3 \
      theta_2(v) & = 2 (v_2 - v_4) - v_3 \
      theta_3(v) & = 2v_2 - 4v_3 - 3v_4. \
    $

  + $tr in (MM_(n times n)(FF))^*$.

  + Consider $V = C[0, 1] = Set(f\: [0, 1] -> RR; f "is continuous")$. Then
    $
      theta(f) := integral_(0)^(1) f(t) ee^(-t) dif t in V^*.
    $
]

#intuition[
  On $FF^n$, $theta$ is the row $mat(theta(e_1), dots.c, theta(e_n))$, since $theta(v) = sum_i v_i theta(e_i)$. For example, $theta_1 = mat(0, 2, -1, 2)$, $theta_2 = mat(0, 2, -1, -2)$ and $theta_3 = mat(0, 2, -4, -3)$.

  On $RR^2$, the graph of $theta$ is a plane through the origin, so seen from above its contour lines $theta = c$ are parallel and evenly spaced. Here $theta(x, y) = x + y$ and $v = vec(2, 1)$.
  #align(center, dynamic-svg2("/part-ib/linear-algebra/media/d1e1.svg", width: 33.8em))
  - $theta(v)$ is the height above $v$, so $v$ ends on the line $theta = 3$.
  - A vector $w$ crosses the same lines wherever it starts, which is $theta(v + w) = theta(v) + theta(w)$.
  - $2 theta$ is twice as steep, so its lines are twice as close (bottom row).
  - $theta(v)$ does not change as $v$ moves along $ker theta$ (thick).

  Most of this chapter is about which vectors a functional sends to $0$, so we draw a functional by its lines rather than as an arrow #fade[[the arrow $(a_1, a_2)$ is perpendicular to the lines only w.r.t. the dot product, which a general $V$ does not have]].
]

#definition[Dual Basis][
  Let $V$ be a $FF$-vector space. Suppose $B$ is a basis for $V$. For $b in B$, define $b^* in V^*$ by
  $
    b^* (sum'_(c in B) lambda_c dot c) & = lambda_b \
  $
  _i.e._ $b^* (c) = delta_(b c)$. Let $B^* = Set(b^*; b in B) subset.eq V^*$.

  For finite-dimensional $V$, the *dual basis* to $B$ is $B^* = Set(b^*; b in B)$.
]

#intuition[
  $b^*$ reads off the $b$-coordinate of a vector, as $e_i^TT$ does in $FF^n$. It depends on the whole basis, not just on $b$: below, $b_1$ is fixed and $b_2$ is replaced by $b'_2$.
  #align(center, dynamic-svg2("/part-ib/linear-algebra/media/d1e2.svg", width: 28.8em))
  - The level sets of $b_1^*$ are parallel to the other basis vector, on which $b_1^*$ vanishes.
  - The dashed segment is the multiple of $b_1$ in $v$: $v = 2 b_1 + b_2$ on the left, but $v = b_1 + b'_2$ on the right.

  #fade[[So the isomorphism $V -> V^*$, $b |-> b^*$, depends on the basis.]]

  In $FF^n$, $b_i^*$ is the $i$-th row of $matbold(P)^(-1)$, where $matbold(P)$ has columns $b_1, ..., b_n$, since $matbold(P)^(-1) matbold(P) = matbold(I)$. On the right, $b_1 = vec(1, 0)$ and $b'_2 = vec(1, 1)$, so
  $
    matbold(P) = mat(1, 1; 0, 1), quad matbold(P)^(-1) = mat(1, -1; 0, 1),
  $
  _i.e._ $b_1^*(x, y) = x - y$ and $(b'_2)^*(x, y) = y$.
]

#proposition[
  + $B^*$ is linearly independent.

  + If $V$ is finite-dimensional, then $B^*$ is a basis for $V^*$.
]

#proof[
  + Suppose
    $
      f = sum'_(b in B) lambda_b dot b^* = 0. \
    $
    Then for $c in B$,
    $
      0 = f(c) = sum'_(b in B) lambda_b dot b^*(c) = sum'_(b in B) lambda_b dot delta_(b c) = lambda_c.
    $

  + *Proof 1.* From (1), $B^*$ is linearly independent of size
    $
      abs(B) = dim V & = dim(scr(L)(V, FF)) #eq-note[by @thm-dim-linear-maps] \
                     & = dim V^* \
    $
    Hence $B^*$ is a basis for $V^*$.

    *Proof 2.* Let $theta in V^*$. Write $lambda_b = theta(b) in FF$, for $b in B$. Then set
    $
      overline(theta) = sum_(b in B) lambda_b b^* in V^*.
    $
    Then for $c in B$,
    $
      overline(theta)(c) = sum_(b in B) lambda_b b^*(c) = sum_(b in B) lambda_b delta_(b c) = lambda_c = theta(c). \
    $
    So $theta = overline(theta) in span(B^*)$. Hence $B^*$ spans $V^*$.
]

#intuition[
  For a finite basis $B = {b_1, ..., b_n}$,
  $
    v = sum_(i=1)^n b_i^*(v) thin b_i, quad quad theta = sum_(i=1)^n theta(b_i) thin b_i^*,
  $
  the first by definition and the second by Proof 2. So the coordinates of a functional are its values on the basis. For example, with $b_1, b'_2$ as above and $theta(x, y) = x + y$, we have $theta(b_1) = 1$ and $theta(b'_2) = 2$, so $theta = b_1^* + 2 (b'_2)^* = (x - y) + 2y$.
]

#corollary[
  If $V$ is finite-dimensional, then $V teq V^*$.
]

#proof[
  $dim V = dim V^*$.
]

#example[
  The above breaks down for infinite-dimensional $V$. For example, let $V = P(RR)$ be the space of real polynomial maps. By Example Sheet 2, $V^* teq RR^NN$. By Example Sheet 1, $RR^NN teq.not P(RR)$.
]

#intuition[
  With an infinite basis, a functional can be an _infinitely long row_, while a vector is still a finite combination. Take $B = {1, x, x^2, ...}$.
  #table(
    columns: 3,
    table.header[][Determined by][Possible sequences],
    [$p in V$], [its coefficients $(lambda_0, lambda_1, ...)$], [finitely many non-zero terms],
    [$theta in V^*$], [its values $(theta(1), theta(x), ...)$], [any sequence],
    [$theta in span(B^*)$], [its values on $B$], [finitely many non-zero terms],
  )
  For example, $theta(p) = p(1)$ has values $(1, 1, 1, ...)$, so $theta in.not span(B^*)$, and $B^*$ is not a basis of $V^*$.

  #fade[[This alone does not show $V teq.not V^*$; that needs $RR^NN teq.not P(RR)$.]]
]

#remark[
  Let $V$ be finite-dimensional. For $B = Set(b_i; 1 <= i <= n)$ a basis for $V$, $v in V$, $theta in V^*$, we can write
  $
    v = sum_(i=1)^n lambda_i b_i, quad theta = sum_(i=1)^n mu_i b_i^*.
  $
  Then
  $
    theta(v) = sum_(i, j) lambda_i mu_j b_j^*(b_i) = sum_(i, j) lambda_i mu_j delta_(i j) = sum_(i=1)^n lambda_i mu_i. \
  $
  However, $vec(lambda_1, dots.v, lambda_n) = [v]_B$ and $vec(mu_1, dots.v, mu_n) = [theta]_(B^*)$. Hence,
  $
    theta(v) = ([theta]_(B^*))^TT dot [v]_B \
  $
]

#definition[
  For $S subset.eq V$, define the *annihilator* of $S$ in $V^*$ by
  $
    S^0 = Set(theta in V^*; theta(s) = 0 space forall s in S) subset.eq V^*.
  $
]

#intuition[
  Think of $theta in V^*$ as the equation $theta(v) = 0$, _e.g._ $mat(1, -1, 0)$ on $RR^3$ is $x - y = 0$. Then $S^0$ is the set of equations satisfied by every vector in $S$. In $FF^n$, if $U$ is the set of solutions of $matbold(A) v = vb(0)$, then $U^0$ is the span of the rows of $matbold(A)$ #fade[[by a proposition later in the chapter]].

  On $RR^2$, $theta in U^0$ iff the graph of $theta$ is hinged on the line $U$, _i.e._ iff its contour lines are parallel to $U$.
  #align(center, dynamic-svg2("/part-ib/linear-algebra/media/d1e3.svg", width: 33.8em))
  The planes hinged on $U$ differ only in their tilt, so $U^0 = span(theta)$ and $dim U^0 = 2 - dim U$. On $RR^3$:
  #table(
    columns: 3,
    table.header[$U$][$U^0$][$dim U + dim U^0$],
    [${vb(0)}$], [$(RR^3)^*$], [$0 + 3$],
    [the line $x = y = z$], [$span(mat(1, -1, 0)\, mat(0, 1, -1))$], [$1 + 2$],
    [the plane $x + y + z = 0$], [$span(mat(1, 1, 1))$], [$2 + 1$],
    [$RR^3$], [${vb(0)}$], [$3 + 0$],
  )
  #fade[[With the dot product, $U^0$ looks like $U^perp$ written as rows, but $U^0$ needs no inner product.]]
]

#lemma[
  For any $S, T subset.eq V$,

  + $S^0 <= V^*$.

  + If $S subset.eq T$, then $T^0 <= S^0$.

  + $S^0 = span(S)^0$.

  + $V^0 = Set(vb(0)_(V^*))$, $Set(vb(0)_V)^0 = V^*$.
] <lem-annihilator>

#proof[
  + By @prop-subspace-test[Subspace Test].

  + By (1), it is sufficient to show that $T^0 subset.eq S^0$, which is immediate from the definition of annihilator.

  + $S subset.eq span(S)$ so by (2), $span(S)^0 subset.eq S^0$. Conversely, let $theta in S^0$ and $v = sum'_(s in S) lambda_s dot s in span(S)$. Then
    $
      theta(v) = sum'_(s in S) lambda_s dot theta(s) = 0. \
    $
    Hence $theta in span(S)^0$. Thus $S^0 subset.eq span(S)^0$.

  + If $theta in V^0$, then $theta(v) = 0$ for all $v in V$, so $theta = vb(0)_(V^*)$.

    Moreover, for all $theta in V^*$, $theta(vb(0)_V) = 0$, so $theta in V^0$.
]

#intuition[
  @lem-annihilator in terms of equations:
  #table(
    columns: 2,
    table.header[Statement][Meaning],
    [(2) $S subset.eq T ==> T^0 <= S^0$], [an equation holding on $T$ holds on any subset of $T$],
    [(3) $S^0 = span(S)^0$], [an equation holding at $s$ and $t$ holds at $lambda s + mu t$],
    [(4) $V^0 = {vb(0)}$, ${vb(0)}^0 = V^*$], [only $0 = 0$ holds everywhere, and every equation holds at $vb(0)$],
  )
]

#proposition[
  Let $V$ be finite-dimensional and $U <= V$. Then,
  $
    dim V = dim U + dim U^0.
  $
  #fade[[This is reminiscent of the rank-nullity theorem.]]
] <prop-annihilator-dim>

#proof[
  Suppose $dim V = n$ and $dim U = k$. Let $B_U = {v_1, ..., v_k}$ be a basis for $U$. Extend to a basis $B_V = {v_1, ..., v_k, v_(k+1), ..., v_n}$ for $V$.

  We have a dual basis $B_V^* = {v_1^*, ..., v_n^*}$ for $V^*$. It is sufficient to prove that
  $
    {v^*_(k+1), ..., v^*_n} "is a basis for" U^0. \
  $

  *Subset of $U^0$.* For $i <= k$, $j >= k+1$, we have
  $
    v_j^* (v_i) = delta_(i j) = 0.
  $
  So $v_j^* in (B_U)^0 = span(B_U)^0 = U^0$ by @lem-annihilator (3).


  *Linear independence.* Immediately follows since this is a subset of $B_V^*$.

  *Spanning.* Let $theta in U^0 <= V^*$. Write
  $
    theta = sum_(j=1)^n lambda_j v_j^*.
  $
  Then for $i <= k$,
  $
    0 = theta(v_i) = sum_(j=1)^n lambda_j v_j^*(v_i) = sum_(j=1)^n lambda_j delta_(i j) = lambda_i.
  $
  Hence all $lambda_i = 0$ for $i <= k$, so
  $
    theta = sum_(j=k+1)^n lambda_j v_j^* in span({v^*_(k+1), ..., v^*_n}).
  $
]

#intuition[
  So each independent equation cuts the dimension by one, as in IA Vectors and Matrices: a plane in $RR^3$ is cut out by one equation, and a line by two. The proof picks a basis whose first $k$ vectors span $U$; then $U^0$ is spanned by the last $n - k$ coordinate functions.
  #align(center, grid(
    columns: 3,
    column-gutter: 1.2em,
    row-gutter: 0.8em,
    align: (right + horizon, center + horizon, center + horizon),
    $B_V :$, $overbrace(cblue(v_1\, ...\, v_k), "basis of" U)$, $v_(k+1), ..., v_n$,
    $B_V^* :$, $v_1^*, ..., v_k^*$, $underbrace(cred(v_(k+1)^*\, ...\, v_n^*), "basis of" U^0)$,
  ))
    Each red $v_j^*$ is $0$ on each blue $v_i$, as $i != j$.
]

#lecture-separator(lecture: 12, date: "2026-11-04")

#remark[
  By the proof, for any $U <= V$, there exists $X <= V^*$ such that
  $
    U = Set(v in V; theta(v) = 0 space forall theta in X)
  $
  and
  $
    dim X = dim V - dim U.
  $
]

#proposition[
  For any $FF$-vector space $V$ and $U, W <= V$,

  + $(U + W)^0 = U^0 inter W^0$.

  + $U^0 + W^0 <= (U inter W)^0$.

  + If $V$ is finite-dimensional, then $U^0 + W^0 = (U inter W)^0$.
]

#proof[
  + For $theta in V^*$
    $
      theta in (U + W)^0 quad & <=> quad theta(u+w) = 0 quad          & forall u in U, w in W \
                              & <=> quad theta(u) = theta(w) = 0 quad & forall u in U, w in W \
                              & <=> quad theta in U^0 inter W^0. \
    $

  + We have $U inter W <= U, W$. So by @lem-annihilator (2),
    $
       U^0, W^0 & <= (U inter W)^0 \
      U^0 + W^0 & <= (U inter W)^0. \
    $

  + Let $dim V = n$. Then
    $
      dim (U^0 + W^0) & = dim U^0 + dim W^0 - dim (U^0 inter W^0) \
                      & = dim U^0 + dim W^0 - dim((U + W)^0) \
                      & = (n - dim U) + (n - dim W) - (n - dim (U + W)) \
                      & = n - dim U - dim W + dim (U + W) \
                      & = n - dim (U inter W) \
                      & = dim((U inter W)^0). \
    $
    Hence by (2), $U^0 + W^0 = (U inter W)^0$.
]

#intuition[
  In $FF^n$, the equations of $U inter W$ are those of $U$ together with those of $W$ #fade[[stack the two systems]], which is $(U inter W)^0 = U^0 + W^0$. An equation holds on $U + W$ iff it holds on both, which is $(U + W)^0 = U^0 inter W^0$.

  Taking annihilators reverses inclusions. Below, larger subspaces are drawn higher, and lines are inclusions.

  #let big = colors.orange.strong
  #let small = colors.blue.strong
  #fletcher-diagram(
    spacing: (2.4em, 2.2em),
    node((1, 0), text(fill: big, $U + W$)),
    node((0, 1), $U$),
    node((2, 1), $W$),
    node((1, 2), text(fill: small, $U inter W$)),
    edge((1, 0), (0, 1)),
    edge((1, 0), (2, 1)),
    edge((0, 1), (1, 2)),
    edge((2, 1), (1, 2)),
    edge((2.6, 1), (4.4, 1), $X |-> X^0$, "->"),
    node((6, 0), text(fill: small)[$(U inter W)^0 = U^0 + W^0$]),
    node((5, 1), $U^0$),
    node((7, 1), $W^0$),
    node((6, 2), text(fill: big)[$(U + W)^0 = U^0 inter W^0$]),
    edge((6, 0), (5, 1)),
    edge((6, 0), (7, 1)),
    edge((5, 1), (6, 2)),
    edge((7, 1), (6, 2)),
  )
  The colours show where $U + W$ and $U inter W$ are sent #fade[[the top equality needs $V$ finite-dimensional]].

  For example, in $RR^3$, let $U$ be the plane $z = 0$ and $W$ the plane $x = 0$, so $U inter W$ is the $y$-axis and $U + W = RR^3$. Then $U^0 = span(e_3^*)$, $W^0 = span(e_1^*)$, $(U inter W)^0 = span(e_1^*\, e_3^*) = U^0 + W^0$ and $(U + W)^0 = {vb(0)} = U^0 inter W^0$.
]

#definition[Dual map][
  Let $alpha in scr(L)(V, W)$. The *dual map* of $alpha$ is
  $
      alpha^*: W^* & -> V^* \
             theta & |-> theta compose alpha.
  $
]

#intuition[
  In $FF^n$, an $m times n$ matrix $matbold(A)$ acts on columns from the left, $v |-> matbold(A) v$, and on rows from the right, $theta |-> theta matbold(A)$, taking rows of length $m$ to rows of length $n$. The dual map is the second action, which is why $alpha^*$ goes from $W^*$ to $V^*$.
  #fletcher-diagram(
    spacing: (6em, 3em),
    node((0, 0), $V$),
    node((1, 0), $W$),
    node((2, 0), $FF$),
    edge((0, 0), (1, 0), $alpha$, "->"),
    edge((1, 0), (2, 0), $theta$, "->"),
    edge((0, 0), (2, 0), $alpha^*(theta) = theta compose alpha$, "->", bend: -40deg, label-side: right),
  )
  Indeed, $(alpha^* theta)(v) = theta(matbold(A) v) = (theta matbold(A)) v$. For example, for $alpha(x, y) = (x, y, x + y)$ and $theta = mat(1, 2, 3)$,
  $
    alpha^* theta = mat(1, 2, 3) mat(1, 0; 0, 1; 1, 1) = mat(4, 5),
  $
  _i.e._ $theta(x, y, x + y) = 4x + 5y$.
]

#lemma[
  If $alpha, beta in scr(L)(V, W)$, $gamma in scr(L)(U, V)$, $lambda in FF$, then

  + $alpha^* in scr(L)(W^*, V^*)$.

  + $(alpha + lambda beta)^* = alpha^* + lambda beta^*$.

  + $(alpha compose gamma)^* = gamma^* compose alpha^*$.

  + If $beta$ is an isomorphism, then so is $beta^*$, and $(beta^*)^(-1) = (beta^(-1))^*$.
]

#proof[
  + Let $theta, eta in W^*$, $mu in FF$. Then for $v in V$,
    $
      alpha^* (theta + mu eta) (v) & = (theta + mu eta)(alpha(v)) \
                                   & = theta(alpha(v)) + mu eta(alpha(v)) \
                                   & = alpha^*(theta)(v) + mu alpha^*(eta)(v) \
                                   & = (alpha^*(theta) + mu alpha^*(eta))(v).
    $
    Since this holds for all $v in V$, we have
    $
      alpha^* (theta + mu eta) = alpha^*(theta) + mu alpha^*(eta).
    $

  + Let $theta in W^*$, $v in V$. Then
    $
      (alpha + lambda beta)^*(theta)(v) & = theta((alpha + lambda beta)(v)) \
                                        & = theta(alpha(v) + lambda beta(v)) \
                                        & = theta(alpha(v)) + lambda theta(beta(v)) \
                                        & = alpha^*(theta)(v) + lambda beta^*(theta)(v) \
                                        & = (alpha^* + lambda beta^*)(theta)(v).
    $
    Since this holds for all $v in V$, we have
    $
      (alpha + lambda beta)^*(theta) = (alpha^* + lambda beta^*)(theta).
    $
    Since this holds for all $theta in W^*$, we have
    $
      (alpha + lambda beta)^* = alpha^* + lambda beta^*.
    $

  + Let $theta in W^*$. Then
    $
      (alpha compose gamma)^*(theta) & = theta compose (alpha compose gamma) \
                                     & = (theta compose alpha) compose gamma \
                                     & = (alpha^*(theta)) compose gamma \
                                     & = gamma^*(alpha^*(theta)) \
                                     & = (gamma^* compose alpha^*)(theta).
    $
    Since this holds for all $theta in W^*$, we have
    $
      (alpha compose gamma)^* = gamma^* compose alpha^*.
    $

  + For all $theta in V^*$,

    $
      (id_V)^* (theta) = theta compose id_V = theta.
    $
    Thus $(id_V)^* = id_(V^*)$. Hence by (3),
    $
      id_(V^*) = (beta^(-1) compose beta)^* = beta^* compose (beta^(-1))^* \.
    $
    Similarly, $(beta^(-1))^* compose beta^* = id_(W^*)$. Hence $beta^*$ is an isomorphism and $(beta^*)^(-1) = (beta^(-1))^*$.
]

#intuition[
  For (3), both sides send $u$ to $theta(alpha(gamma(u)))$.
  #fletcher-diagram(
    spacing: (5em, 3em),
    node((0, 0), $U$),
    node((1, 0), $V$),
    node((2, 0), $W$),
    node((3, 0), $FF$),
    edge((0, 0), (1, 0), $gamma$, "->"),
    edge((1, 0), (2, 0), $alpha$, "->"),
    edge((2, 0), (3, 0), $theta$, "->"),
    edge((1, 0), (3, 0), $alpha^* theta$, "->", bend: 40deg),
    edge((0, 0), (3, 0), $gamma^*(alpha^* theta)$, "->", bend: -40deg, label-side: right),
  )
  In $FF^n$, with $matbold(A), matbold(G)$ the matrices of $alpha, gamma$, this is associativity on rows:
  $
    theta quad |->^(alpha^*) quad theta matbold(A) quad |->^(gamma^*) quad (theta matbold(A)) matbold(G) = theta (matbold(A) matbold(G)).
  $
  So $alpha^*$ acts first on rows although $alpha$ acts last on columns, as in $(matbold(A) matbold(G))^TT = matbold(G)^TT matbold(A)^TT$.
]

#proposition[
  Suppose $V, W$ are finite-dimensional and $alpha in scr(L)(V, W)$. Let $B, C$ be bases for $V, W$ respectively. Then
  $
    [alpha^*]^(C^*)_(B^*) = ([alpha]^(B)_C)^TT.
  $
] <prop-dual-map-matrix>

#proof[
  Let $n = dim V$, $m = dim W$, $B = {b_1, ..., b_n}$, $C = {c_1, ..., c_m}$. Let $matbold(A) = [alpha]^B_C$. Then
  $
    alpha(b_i) = sum_(k=1)^m a_(k i) c_k.
  $
  Let $matbold(A') = [alpha^*]^(C^*)_(B^*)$. Then
  $
    alpha^*(c_j^*) = sum_(l=1)^n a'_(l j) b_l^*.
  $
  Then
  $
    a'_(i j) & = alpha^* (c_j^*) (b_i) \
             & = c_j^* (alpha (b_i)) \
             & = a_(j i). \
  $
]

#intuition[
  In $FF^n$, $alpha^*$ is $theta |-> theta matbold(A)$, with no transpose. The transpose appears only because the coordinates of a functional are written as a column: $(theta matbold(A))^TT = matbold(A)^TT theta^TT$.
]

#example[Change of Basis][
  Let $B, C$ be bases for a finite-dimensional vector space $V$. Let $matbold(P) = [id_V]^B_C in "GL"_n (FF)$. Then
  $
    [id_(V^*)]^(C^*)_(B^*) = ([id_V]^B_C)^TT = matbold(P)^TT,
  $
  so
  $
    [id_(V^*)]^(B^*)_(C^*) = (matbold(P)^TT)^(-1).
  $
]

#intuition[
  This is why we do not identify a column $v$ with the row $v^TT$: the coordinates of a vector change by $matbold(P)$, those of a functional by $(matbold(P)^TT)^(-1)$, and $theta(v)$ is unchanged. For example, take lengths with $B = {1 "m"}$ and $C = {1 "cm"}$, so $matbold(P) = (100)$.
  #table(
    columns: 4,
    table.header[][In $B$ (metres)][In $C$ (centimetres)][From $B$ to $C$],
    [$v = 2 "m"$], [$2$], [$200$], [$times matbold(P)$],
    [$theta =$ £3 per metre], [$3$], [$0.03$], [$times (matbold(P)^TT)^(-1)$],
    [$theta(v) =$ £6], [$3 times 2$], [$0.03 times 200$], [unchanged],
  )
  #fade[[In physics, vectors and functionals are called _contravariant_ and _covariant_, after the way their coordinates change.]]
]

#proposition[
  Let $V, W$ be $FF$-vector spaces #fade[[not necessarily finite-dimensional]]. Let $alpha in scr(L)(V, W)$. Then

  + $ker (alpha^*) = (im alpha)^0$.

  + $im (alpha^*) <= (ker alpha)^0$.

  + If $V, W$ are finite-dimensional, then $im (alpha^*) = (ker alpha)^0$, and
    $
      rank (alpha^*) = rank alpha.
    $

] <prop-dual-map-kernel-image>


#proof[
  + For $theta in W^*$,
    $
      theta in ker (alpha^*) quad & <=> quad theta compose alpha = 0 "in" V^*, \
                                  & <=> quad theta(alpha(v)) = 0 quad forall v in V \
                                  & <=> quad theta in (im alpha)^0. \
    $

  + For $eta in V^*$, if $exists theta in W^*$ such that $eta = alpha^* (theta) = theta compose alpha$ #fade[[_i.e._ $eta in im alpha^*$]], then for $v in ker alpha$,
    $
      eta(v) = theta(alpha(v)) = theta(vb(0)) = 0.
    $
    Hence $eta in (ker alpha)^0$.

  + Suppose $rank(alpha^*) = rank alpha$, then
    $
      dim ((ker alpha)^0) & = dim V - null alpha \
                          & = rank alpha \
                          & = rank (alpha^*) \
                          & = dim (im (alpha^*)). \
    $
    So by (2), $im (alpha^*) = (ker alpha)^0$. We are left to show that $rank (alpha^*) = rank alpha$. Fix bases $B, C$ for $V, W$ respectively. Then by @prop-dual-map-matrix, if $matbold(A) = [alpha]^(B)_C$, then $matbold(A)^TT = [alpha^*]^(C^*)_(B^*)$. So
    $
      rank alpha = colrank matbold(A) = rowrank matbold(A) = colrank matbold(A)^TT = rank (alpha^*).
    $
]

#intuition[
  (1) and (2) only unwind the definitions: $(alpha^* theta)(v) = theta(alpha(v))$ only depends on $alpha(v)$. The content is the reverse inclusion in (3). An $eta in (ker alpha)^0$ also only depends on $alpha(v)$, so $theta(alpha(v)) = eta(v)$ defines $theta$ on $im alpha$; extending it to $W$ gives $eta = alpha^* theta$.

  For example, let $matbold(A) = mat(1, 2; 3, 6)$, so $ker alpha = span(vec(2, -1))$ and $im alpha = span(vec(1, 3))$. The contour lines of $eta in (ker alpha)^0$ are parallel to $ker alpha$, and those of $theta in ker alpha^*$ to $im alpha$.
  #align(center, dynamic-svg2("/part-ib/linear-algebra/media/d1e4.svg", width: 27.3em))
  By (1), $matbold(A) v = b$ has a solution iff $theta b = 0$ for every row $theta$ with $theta matbold(A) = 0$ #fade[[by the remark after @prop-annihilator-dim]], _e.g._ here iff $3 b_1 - b_2 = 0$.
]

#definition[Double Dual Space][
  Let $V$ be a $FF$-vector space. The *double dual space* of $V$ is
  $
    V^(**)= (V^*)^*.
  $
  If $V$ is finite-dimensional, then $V^(**) teq V^* teq V$. #fade[[They have the same dimension.]]
]

#theorem[
  Let $V$ be a $FF$-vector space. There is a linear map $epsilon: V -> V^(* *)$ given by
  $
    epsilon(v)(theta) = theta(v)
  $
  for $v in V$, $theta in V^*$. If $V$ is finite-dimensional, then $epsilon$ is an isomorphism.
] <thm-evaluation-map-isomorphism>

#definition[Evaluation Map][
  $epsilon: V -> V^(* *)$ is called the *evaluation map* or the *natural isomorphism*.
]

#intuition[
  In $FF^n$, a row $theta$ is a function of columns, $v |-> theta v$, and likewise a column $v$ is a function of rows, $theta |-> theta v$. $epsilon(v)$ is the second made abstract. On $RR^2$, we tabulate $theta(v)$ with one row for each $theta$ and one column for each $v$.

  #let by-row = colors.blue.soft
  #let by-col = colors.orange.soft
  #align(center, table(
    columns: 4,
    align: center,
    table.header[][$v_1 = vec(1, 0)$][#table.cell(fill: by-col)[$v_2 = vec(2, 3)$]][$v_3 = vec(-1, 1)$],
    [$theta_1 = mat(1, 0)$], [$1$], table.cell(fill: by-col)[$2$], [$-1$],
    [$theta_2 = mat(0, 1)$], [$0$], table.cell(fill: by-col)[$3$], [$1$],
    table.cell(fill: by-row)[$theta_3 = mat(1, 1)$],
    table.cell(fill: by-row)[$1$],
    table.cell(fill: by-row)[*$5$*],
    table.cell(fill: by-row)[$0$],
  ))
  - The #text(fill: colors.blue.strong)[blue row] is $theta_3 in V^*$, a function of $v$.
  - The #text(fill: colors.orange.strong)[orange column] is $epsilon(v_2) in V^(**)$, a function of $theta$. It is linear: $theta_3 = theta_1 + theta_2$ and $5 = 2 + 3$.

  Unlike $b |-> b^*$, the map $epsilon$ needs no choice of basis. On $RR$, the basis ${1}$ sends $1 |-> 1^* = (x |-> x)$, but the basis ${2}$ sends $1 = 1/2 dot 2 |-> 1/2 dot 2^* = (x |-> x slash 4)$; whereas $epsilon(1)$ is $theta |-> theta(1)$ for any basis.
]

#intuition[
  In $FF^n$ with the standard basis, with $alpha(v) = matbold(A) v$:

  #table(
    columns: 2,
    table.header[Abstract][In $FF^n$],
    [$v in V$], [a column vector $vec(v_1, dots.v, v_n)$],
    [$theta in V^*$], [a row vector $mat(a_1, dots.c, a_n)$],
    [$theta(v)$], [row times column, $a_1 v_1 + dots.c + a_n v_n$],
    [dual basis $B^*$], [the rows of $matbold(P)^(-1)$, where $matbold(P)$ has columns $b_1, ..., b_n$],
    [annihilator $U^0$], [the rows $theta$ with $theta u = 0$ for all $u in U$],
    [dual map $alpha^*$], [$theta |-> theta matbold(A)$ on rows, _i.e._ $matbold(A)^TT$ on columns],
    [$ker alpha^*$], [the rows $theta$ with $theta matbold(A) = 0$],
    [$im alpha^*$], [the span of the rows of $matbold(A)$],
    [change of basis], [$[v]$ changes by $matbold(P) = [id_V]^B_C$, and $[theta]$ by $(matbold(P)^TT)^(-1)$],
    [$epsilon: V -> V^(**)$], [a column vector, viewed as a function of rows],
  )
]

#lecture-separator(lecture: 13, date: "2026-11-06")

#proof[
  #fade[[Alternative proof to @prop-dual-map-kernel-image (3)]] Note that $dim (ker alpha)^0 = dim V - null alpha = rank alpha$, so $rank alpha^* <= rank alpha$ by (2). Suppose $rank alpha^* < rank alpha$. Then
  $
    dim W & = dim W^* \
          & = rank alpha^* + null alpha^* \
          & < (dim V - null alpha) + (dim W - rank alpha) \
          & = dim W,
  $
  which is a contradiction. Hence $rank alpha^* = rank alpha$, and so $im (alpha^*) = (ker alpha)^0$ by (2).

]

#intuition[
  #canvas(length: 1em, {
    import draw: *
    let (r, w, h) = (6, 17, 1.7)
    for (y, name, left, right) in (
      (2.6, $W$, $rank alpha$, $dim W - rank alpha$),
      (0, $W^*$, $rank alpha^*$, $null alpha^* = dim (im alpha)^0$),
    ) {
      rect((0, y), (r, y + h), fill: tint("blue"))
      rect((r, y), (w, y + h))
      content((r / 2, y + h / 2), left)
      content(((r + w) / 2, y + h / 2), right)
      content((-0.3, y + h / 2), name, anchor: "east")
    }
  })
  Both bars have length $dim W = dim W^*$, and the right parts are equal by @prop-dual-map-kernel-image (1) and @prop-annihilator-dim. Hence so are the left parts. #fade[[This proof does not use $rowrank matbold(A) = colrank matbold(A)$, so the next proof can deduce it.]]
]


#proof[
  #fade[[Alternative proof of $rowrank matbold(A) = colrank matbold(A)$]] Let $matbold(A) in MM_(m times n)(FF)$ and $alpha: FF^n -> FF^m$ with $alpha(v) = matbold(A) v$.

  Then
  $
    matbold(A) = [alpha]^(E_n)_(E_m), quad matbold(A)^TT = [alpha^*]^(E_m^*)_(E_n^*).
  $
  Therefore
  $
    colrank matbold(A) = rank alpha = rank (alpha^*) = colrank matbold(A)^TT = rowrank matbold(A).
  $
]

#proof[
  #fade[[Proof of @thm-evaluation-map-isomorphism]]

  *Linearity.* Let $v, w in V$, $lambda in FF$, $theta in V^*$. Then
  $
    epsilon(v + lambda w) (theta) & = theta(v + lambda w) \
                                  & = theta(v) + lambda theta(w) \
                                  & = epsilon(v) (theta) + lambda epsilon(w) (theta) \
                                  & = (epsilon(v) + lambda epsilon(w)) (theta). \
  $
  This holds for all $theta$, so
  $
    epsilon(v + lambda w) = epsilon(v) + lambda epsilon(w).
  $

  Now suppose $V$ is finite-dimensional.

  *Injectivity.* Suppose $vb(0) != v in ker epsilon$. Then for all $theta in V^*$,
  $
    0 = epsilon (v) (theta) = theta(v).
  $
  Extend ${v}$ to a basis ${v=v_1, ..., v_n}$ for $V$. Let $B^* = {v_1^*, ..., v_n^*}$ be the dual basis.

  Set $theta = v_1^*$. Then $theta(v) = v_1^*(v_1) = 1$, which is a contradiction. Hence $ker epsilon = {vb(0)}$, so $epsilon$ is injective.

  *Surjectivity.* Follows from $dim V = dim V^(**)$.
]

#remark[
  For a finite-dimensional vector space $V$, $V teq V^*$ but any such isomorphism depends on a choice of basis.
]


#proposition[
  Let $V$ be a finite-dimensional vector space with $dim V = n$.

  Every basis $C$ of $V^*$ is dual to some basis for $V$.
]

#proof[
  Let $C = {theta_1, ..., theta_n} subset.eq V^*$. Let $C^* = {hat(theta)_1, ..., hat(theta)_n} subset.eq V^(**)$ be the dual basis of $C$.

  Let $v_i = epsilon^(-1)(hat(theta)_i)$. Then $B = {v_1, ..., v_n}$ is a basis for $V$, and
  $
    theta_i (v_j) & = epsilon(v_j)(theta_i) = hat(theta)_j (theta_i) = delta_(i j). \
  $
  So $C = B^*$.
]

#intuition[
  In $FF^n$, let $matbold(Q)$ be the matrix with rows $theta_1, ..., theta_n$, which is invertible as $C$ is a basis. Then $B$ consists of the columns $v_1, ..., v_n$ of $matbold(Q)^(-1)$, since $matbold(Q) matbold(Q)^(-1) = matbold(I)$ says $theta_i (v_j) = delta_(i j)$. For example, $theta_1 = mat(1, -1)$ and $theta_2 = mat(0, 1)$ give
  $
    matbold(Q) = mat(1, -1; 0, 1), quad matbold(Q)^(-1) = mat(1, 1; 0, 1),
  $
  so $v_1 = vec(1, 0)$ and $v_2 = vec(1, 1)$, which are $b_1$ and $b'_2$ from the example after the definition of the dual basis. Below, each $v_j$ ends on the line $theta_j = 1$ and on $theta_i = 0$ for $i != j$.
  #canvas(length: 3em, {
    import draw: *
    // The patch -3/2 <= theta_1 <= 5/2, -1/2 <= theta_2 <= 3/2, in xy-coordinates.
    let (a0, a1, b0, b1) = (-1.5, 2.5, -0.5, 1.5)
    let xy(t1, t2) = (t1 + t2, t2)
    // Baseline-aligned boxes, so that labels with subscripts line up with the digits.
    let small(c, body) = text(size: 0.85em, fill: ink(c), top-edge: "cap-height", bottom-edge: "baseline", body)
    for c in (-1, 0, 1, 2) {
      line(xy(c, b0), xy(c, b1), stroke: rule("blue") + (if c == 0 { 1.3pt } else { 0.6pt }))
      content((rel: (0, 0.1), to: xy(c, b1)), small("blue", $#c$), anchor: "south")
    }
    content((xy(-1, b1).at(0) - 0.2, b1 + 0.1), small("blue", $theta_1 =$), anchor: "south-east")
    for c in (0, 1) {
      line(xy(a0, c), xy(a1, c), stroke: rule("red") + (if c == 0 { 1.3pt } else { 0.6pt }))
      content(xy(a1, c), small("red", $theta_2 = #c$), anchor: "west")
    }
    let arrow = (mark: (end: "stealth"), stroke: 0.9pt)
    line((0, 0), (1, 0), ..arrow)
    line((0, 0), (1, 1), ..arrow)
    content((0.4, -0.22), $v_1$)
    content((0.2, 0.7), $v_2$)
  })
]

#proposition[
  Let $V$ be a finite-dimensional vector space with $dim V = n$. For any $U <= V$,
  $
    epsilon(U) = (U^0)^0.
  $
]

#proof[
  If $u in U$, then for all $theta in U^0$,
  $
    epsilon(u) (theta) = theta(u) = 0.
  $
  So $epsilon(u) in (U^0)^0$. Hence $epsilon(U) <= (U^0)^0$. But we also have
  $
    dim (U^0)^0 = n - dim U^0 = n - (n - dim U) = dim U = dim(epsilon(U))
  $

  and hence $epsilon(U) = (U^0)^0$.
]

#intuition[
  Identifying $V$ with $V^(**)$ by $epsilon$, the proposition says that taking the annihilator twice gives back $U$ #fade[[as $(U^perp)^perp = U$ for the dot product]]. In $FF^n$, $U^0$ is the set of equations satisfied by $U$, and via $epsilon$, $(U^0)^0$ is the set of vectors satisfying all of them. So $U$ is exactly the set of solutions of its equations.

  The proof checks that $epsilon$ sends $U$ into $(U^0)^0$, and then compares the dimensions, shown in gray with $k = dim U$.
  #fletcher-diagram(
    spacing: (5.5em, 0.3em),
    node((0, 0), $U <= V$),
    node((1, 0), $U^0 <= V^*$),
    node((2, 0), $(U^0)^0 <= V^(**)$),
    edge((0, 0), (1, 0), $(dot)^0$, "->"),
    edge((1, 0), (2, 0), $(dot)^0$, "->"),
    edge((0, 0), (2, 0), $epsilon$, "->", bend: -22deg, label-side: right),
    node((0, -1), cgray($k$)),
    node((1, -1), cgray($n - k$)),
    node((2, -1), cgray($n - (n - k) = k$)),
  )
]

#remark[
  For $X <= V^*$, $X^0 <= V^(**)$ is $epsilon(X_0)$, where
  $
    X_0 = Set(v in V; forall theta in X, theta(v) = 0) = inter.big_(theta in X) ker theta.
  $
  Note that $dim X_0 = n - dim X$. Thus, given $U <= V$, $U = X_0$ for some $X <= V^*$, namely $X = U^0$.

]
