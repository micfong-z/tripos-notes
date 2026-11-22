#import "../prelude.typ": *
#show: chapter.with(2)

#lecture-separator(lecture: 6, date: "2026-10-21")

= Matrices and Linear Maps

Let $V, W$ be $FF$-vector spaces.

Let
$
  scr(L)(V, W) = Set(alpha\: V -> W; alpha "is linear") subset.eq W^V
$

For $alpha, beta in scr(L)(V, W)$, $lambda in FF$, define $(alpha + beta), lambda alpha in scr(L)(V, W)$ by
$
  (alpha + beta) (v) & = alpha(v) + beta(v) \
  (lambda alpha) (v) & = lambda dot alpha(v).
$

#fade[[Check that $(alpha + beta), lambda alpha$ are indeed linear maps.]]

#exercise[
  Under the above operations, $scr(L)(V, W)$ is a vector space over $FF$.
]


#theorem[
  Suppose $V, W$ are finite-dimensional with $dim V = n$, $dim W = m$. We have
  $
    scr(L)(V, W) teq MM_(m times n)(FF).
  $
  Thus, $scr(L)(V, W)$ is finite-dimensional with $dim scr(L)(V, W) = m n$.
] <thm-dim-linear-maps>

#notation[
  For $matbold(A) in MM_(m times n)(FF)$, write $matbold(A) = (a_(i,j))$ where $a_(i, j) in FF$, $1 <= i <= m$, $1 <= j <= n$.
]

Note that $MM_(m times n)(FF)$ has a standard basis
$
  Set(matbold(E)_(r, s); 1 <= r <= m, 1 <= s <= n)
$
where $matbold(E)_(r, s) = (delta_(r,i) dot delta_(s,j))$ #fade[[matrix with $1$ at $(r, s)$ and $0$ elsewhere]].

Let $B = {v_1, ..., v_n}$ and $C = {w_1, ..., w_m}$ be ordered bases for $V$ and $W$. Given $alpha in scr(L)(V, W)$, we can write
#set math.equation(numbering: "(1)")
$
  alpha(v_1) & = a_(1, 1) w_1 + a_(2, 1) w_2 + ... + a_(m, 1) w_m \
  alpha(v_2) & = a_(1, 2) w_1 + a_(2, 2) w_2 + ... + a_(m, 2) w_m \
             & dots.v \
  alpha(v_n) & = a_(1, n) w_1 + a_(2, n) w_2 + ... + a_(m, n) w_m \
$ <eq-2-1>
#set math.equation(numbering: none)

for some coefficients $a_(i, j) in FF$.

#definition[Matrix][
  The matrix of $alpha$ w.r.t. the bases $B, C$ is
  $
    [alpha]^B_C = (a_(i, j)) in MM_(m times n)(FF).
  $
]
#warning[
  We have transposed the entries, so that the rows of @eq-2-1 correspond to the columns of $[alpha]^B_C$.
]
The reason for this is that, recalling that there is an isomorphism #fade[[see @cor-coordinate-map-isomorphism]]
$
                        F_B: V & -> FF^n \
  v = sum_(j=1)^n lambda_j v_j & |-> [v]_B = vec(lambda_1, dots.v, lambda_n)
$
which gives the coordinate vector of $v$ w.r.t. the basis $B$, we have the following theorem.

#theorem[
  + For all $v in V$,
    $
      [alpha]^B_C [v]_B = [alpha(v)]_C.
    $

  + $[alpha]^B_C$ is the only matrix $matbold(A) in MM_(m times n)(FF)$ satisfying
    $
      matbold(A)[v]_B = [alpha(v)]_C
    $
    for all $v in V$.

  + There is an isomorphism of $FF$-vector spaces
    $
      F_C^B: scr(L)(V, W) & -> MM_(m times n)(FF) \
                    alpha & |-> [alpha]^B_C.
    $
] <thm-matrix-of-linear-map>

#proof[

  + Write $v = sum_(j=1)^n lambda_j v_j$. Then
    $
      alpha(v) & = sum_(j=1)^n lambda_j alpha(v_j) \
               & = sum_(j=1)^n lambda_j (sum_(i=1)^m a_(i, j) w_i) \
               & = sum_(i=1)^m (sum_(j=1)^n a_(i, j) lambda_j) w_i.
    $
    Thus
    $
      [alpha(v)]_C & = (sum_(j=1)^n a_(i, j) lambda_j)_i \
                   & = (a_(i, j))_(i, j) (lambda_j)_j \
                   & = [alpha]^B_C [v]_B. \
    $

  + By definition, $[v_i]_B = e_i$ #fade[[standard basis vectors]]. Hence for any $matbold(A) in MM_(m times n)(FF)$,
    $
      matbold(A)[v_i]_B = matbold(A) e_i = i"-th column of" matbold(A).
    $
    But if $matbold(A)$ satisfies $matbold(A)[v]_B = [alpha(v)]_C$, then
    $
      matbold(A)[v_i]_B & = [alpha(v_i)]_C \
                        & = [alpha]^B_C [v_i]_B \
                        & = [alpha]^B_C e_i \
                        & = i"-th column of" [alpha]^B_C.
    $
    Since this holds for all $i$, we must have $matbold(A) = [alpha]^B_C$.

  + *Linearity.* For $alpha, beta in scr(L)(V, W)$ and $lambda in FF$ we compare
    $
      [alpha]^B_C + lambda [beta]^B_C quad "with" quad [alpha + lambda beta]^B_C.
    $
    For $v in V$,
    $
      ([alpha]^B_C + lambda [beta]^B_C)[v]_B & = [alpha]^B_C [v]_B + lambda [beta]^B_C [v]_B \
                                             & = [alpha(v)]_C + lambda [beta(v)]_C #eq-note[by (1)] \
                                             & = [alpha(v) + lambda beta(v)]_C \
                                             & = [(alpha + lambda beta)(v)]_C \
                                             & = [alpha + lambda beta]^B_C [v]_B. #eq-note[by (1)]
    $
    By (2), we conclude that
    $
      [alpha]^B_C + lambda [beta]^B_C = [alpha + lambda beta]^B_C.
    $

    *Injectivity.* If $alpha, beta in scr(L)(V, W)$ with $[alpha]_C^B = [beta]_C^B$, then
    $
      alpha(v_i) = beta(v_i) quad forall i.
    $
    By @prop-linear-map-determined-by-basis, we conclude that $alpha = beta$.

    *Surjectivity.* Given $matbold(A) in MM_(m times n)(FF)$, let $alpha in scr(L)(V, W)$ be the linear extension of
    $
      alpha(v_j) = sum_(i=1)^m a_(i, j) w_i.
    $
    Then $[alpha]^B_C = matbold(A)$ by definition.
]

#intuition[
  Take $n = 2$, $m = 3$ and $v = cblue(lambda_1) v_1 + cred(lambda_2) v_2$. Column $j$ of $[alpha]^B_C$ is $[alpha(v_j)]_C$, and $[v]_B$ gives the coefficient of each column.
  #let lab(x) = math.display(text(size: 0.8em, x))
  $
    [alpha]^B_C [v]_B
    = mat(cblue(a_(1,1)), cred(a_(1,2)); cblue(a_(2,1)), cred(a_(2,2)); cblue(a_(3,1)), cred(a_(3,2))) vec(cblue(lambda_1), cred(lambda_2))
    = cblue(lambda_1) underbrace(vec(cblue(a_(1,1)), cblue(a_(2,1)), cblue(a_(3,1))), lab([alpha(v_1)]_C))
    + cred(lambda_2) underbrace(vec(cred(a_(1,2)), cred(a_(2,2)), cred(a_(3,2))), lab([alpha(v_2)]_C))
    = [alpha(v)]_C
  $
  In (2), $[v_1]_B = e_1$ keeps only the blue column.
]

#remark[
  Given $B, C$,
  #let el = colors.blue.strong
  #let elt(x) = text(fill: el, x)
  #fletcher-diagram(
    spacing: (10em, 8.5em),
    // Elements on the outer corners; the spaces sit at fractional coordinates
    // between them, so the inner square stays centred whatever the labels.
    node((0, 0), elt($v$)),
    node((1, 0), elt($alpha(v)$)),
    node((0, 1), elt($[v]_B$)),
    node((1, 1), elt($[alpha]^B_C [v]_B = [alpha(v)]_C$)),
    edge((0, 0), (1, 0), elt($alpha$), "|->", stroke: el),
    edge((0, 0), (0, 1), elt($F_B$), "|->", stroke: el, label-side: right),
    edge((1, 0), (1, 1), elt($F_C$), "|->", stroke: el, label-side: left),
    edge((0, 1), (1, 1), elt($[alpha]^B_C$), "|->", stroke: el, label-side: right),
    node((0.2, 0.2), $V$, name: <V>),
    node((0.8, 0.2), $W$, name: <W>),
    node((0.2, 0.8), $FF^n$, name: <Fn>),
    node((0.8, 0.8), $FF^m$, name: <Fm>),
    edge(<V>, <W>, $alpha$, "->"),
    edge(<V>, <Fn>, $F_B$, "->", label-side: right),
    edge(<W>, <Fm>, $F_C$, "->", label-side: left),
    edge(<Fn>, <Fm>, $[alpha]^B_C$, "->", label-side: right),
  )

  This is a commutative diagram.
]

#example-sheet-separator(from: 1, to: 2)

#proposition[
  Let $V, W, X$ be finite-dimensional vector spaces with bases $B, C, D$ respectively, where $alpha in scr(L)(V, W)$ and $beta in scr(L)(W, X)$. Then
  $
    [beta compose alpha]^B_D = [beta]^C_D [alpha]^B_C.
  $
] <prop-composition-of-mat-linear-maps>

#proof[
  By @thm-matrix-of-linear-map, $matbold(A) = [beta compose alpha]^B_D$ is uniquely determined by
  $
    matbold(A)[v]_B = [beta(alpha(v))]_D quad forall v in V.
  $
  But
  $
    [beta]^C_D [alpha]^B_C [v]_B = [beta]^C_D [alpha(v)]_C = [beta(alpha(v))]_D,
  $
  hence by @thm-matrix-of-linear-map (2), $matbold(A) = [beta]^C_D [alpha]^B_C$.
]

#remark[
  For any basis $B$ of $V$,
  $
    [id_V]^B_B = matbold(I)_n.
  $

]

#definition[Base-change matrix][
  Given bases $B, B'$ for $V$, the *base-change matrix* from $B$ to $B'$ is
  $
    matbold(P) = [id_V]^(B)_(B') in MM_(n times n)(FF).
  $
  Equivalently, for $B = {v_1, ..., v_n}$ and $B' = {v'_1, ..., v'_n}$, we have $matbold(P) = (p_(i, j))$, where
  $
    v_j = sum_(i=1)^n p_(i, j) v'_i.
  $
  So the $j$-th column of $matbold(P)$ is $[v_j]_B'$.
]

Recall that $matbold(A) in MM_(n times n)(FF)$ is invertible if there exists $matbold(A)^(-1) in MM_(n times n)(FF)$ such that $matbold(A) matbold(A)^(-1) = matbold(A)^(-1) matbold(A) = matbold(I)_n$. Then $matbold(A)^(-1)$ is called the inverse of $matbold(A)$. The group of invertible $n times n$ matrices over $FF$ is denoted by $"GL"_n (FF)$.

#proposition[
  + $[id_V]^B_B'$ is invertible, and $([id_V]^B_B')^(-1) = [id_V]^(B')_(B)$.

  + *Change of basis formula.* For $alpha in scr(L)(V, W)$, $B, B'$ bases of $V$ and $C, C'$ bases of $W$,
    $
      [alpha]^B'_C' =[id_W]^(C)_(C') [alpha]^B_C [id_V]^(B')_(B).
    $
] <prop-invertible-base-change-matrix>

#proof[
  + By @prop-composition-of-mat-linear-maps,
    $
      [id_V]^B'_B [id_V]^B_B' = [id_V]^B_B = matbold(I)_n.
    $
    Swapping $B$ and $B'$ gives $[id_V]^B_B' [id_V]^B'_B = [id_V]^B'_B' = matbold(I)_n$ too.

  + Immediate from @prop-composition-of-mat-linear-maps.
]

#intuition[
  For (2), write $alpha = id_W compose alpha compose id_V$ and follow $v$ through the three maps. Adjacent bases match, and the matrices multiply from right to left.
  #fletcher-diagram(
    spacing: (6em, 3em),
    node((0, 0), $[v]_cblue(B')$),
    node((1, 0), $[v]_B$),
    node((2, 0), $[alpha(v)]_C$),
    node((3, 0), $[alpha(v)]_cblue(C')$),
    edge((0, 0), (1, 0), $[id_V]^cblue(B')_B$, "|->"),
    edge((1, 0), (2, 0), $[alpha]^B_C$, "|->"),
    edge((2, 0), (3, 0), $[id_W]^C_cblue(C')$, "|->"),
    edge((0, 0), (3, 0), $[alpha]^cblue(B')_cblue(C')$, "|->", bend: -30deg, label-side: right),
  )
]

#remark[
  Converse to @prop-invertible-base-change-matrix (1): every invertible matrix is a base-change matrix.
]

#lecture-separator(lecture: 7, date: "2026-10-23")

#theorem[
  Let $V, W$ be finite-dimensional and $alpha in scr(L)(V, W)$.

  + There exist bases $B, C$ for $V, W$ respectively such that
    $
      [alpha]^B_C = mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0))
    $
    where $r = rank alpha$.

  + If $B', C'$ are bases for $V, W$ such that $[alpha]^B'_C' = mat(delim: "[", matbold(I)_r', matbold(0); matbold(0), matbold(0))$, then $r' = rank alpha$.
] <thm-rank-of-linear-map>

#proof[

  + By @thm-rank-nullity[Rank-Nullity Theorem], $ker alpha$ has a basis $Set(v_(r+1), ..., v_n;).$ Extend to a basis $B= Set(v_1, ..., v_n;)$ for $V$. Then $Set(alpha(v_1), ..., alpha(v_r);)$ span $im alpha$ and has size of at most $r$.

    Thus $Set(w_1 = alpha(v_1), ..., w_r = alpha(v_r);)$ is a basis for $im alpha$.  Extend to a basis $C= Set(w_1, ..., w_m;)$ for $W$. Then
    $
      alpha(v_i) = cases(w_i quad & 1 <= i <= r, vb(0) quad &"otherwise".)
    $
    Thus $[alpha]^B_C = mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0))$.

  + If $B' = {v'_1, ..., v'_n}$ and $C' = {w'_1, ..., w'_m}$ are bases for $V$ and $W$ respectively such that $[alpha]^B'_C'$ has the form in (2), then
    $
      alpha(v'_i) = cases(w'_i quad & 1 <= i <= r', vb(0) quad &"otherwise".)
    $
    Hence $Set(w'_1, ..., w'_(r');)$ span $im alpha$ and has size of at most $r'$.  It is linearly independent as a subset of $C'$, so $r' = rank alpha$.

]

#intuition[
  In (1), the bases are chosen in the order 1--4. Column $j$ is $[alpha(v_j)]_C$.
  #canvas(length: 1em, {
    import draw: *
    // Column split, width, row split and height of the matrix.
    let (a, w, h, d) = (6.5, 15, 2.4, 4.8)
    let line-style = (paint: colors.border-dark, thickness: 0.5pt)
    rect((0, 0), (a, -h), fill: tint("blue"), stroke: none)
    rect((a, 0), (w, -d), fill: tint("red"), stroke: none)
    line((a, 0), (a, -d), stroke: line-style)
    line((0, -h), (a, -h), stroke: line-style)
    line((0.25, 0.15), (-0.15, 0.15), (-0.15, -d - 0.15), (0.25, -d - 0.15))
    line((w - 0.25, 0.15), (w + 0.15, 0.15), (w + 0.15, -d - 0.15), (w - 0.25, -d - 0.15))
    content((a / 2, -h / 2), text(fill: ink("blue"), $matbold(I)_r$))
    content(((a + w) / 2, -d / 2), text(fill: ink("red"), $matbold(0)$))
    content((a / 2, -(h + d) / 2), $matbold(0)$)
    // Columns: the basis B of V.
    let small(body) = text(size: 0.85em, body)
    content((a / 2, 0.8), text(fill: ink("blue"), $v_1, ..., v_r$))
    content((a / 2, 1.9), small[2\. extend to $B$])
    content(((a + w) / 2, 0.8), text(fill: ink("red"), $v_(r+1), ..., v_n$))
    content(((a + w) / 2, 1.9), small[1\. basis of $ker alpha$])
    // Rows: the basis C of W.
    content((-0.7, -h / 2 + 0.45), anchor: "east", text(fill: ink("blue"), $w_1, ..., w_r$))
    content((-0.7, -h / 2 - 0.5), anchor: "east", small[3\. basis of $im alpha$])
    content((-0.7, -(h + d) / 2 + 0.45), anchor: "east", $w_(r+1), ..., w_m$)
    content((-0.7, -(h + d) / 2 - 0.5), anchor: "east", small[4\. extend to $C$])
  })
]

== Applications to Matrices

#definition[Equivalence of matrices][
  $matbold(A), matbold(A)' in MM_(m times n)(FF)$ are *equivalent* if there exist $matbold(P) in "GL"_m (FF)$ and $matbold(Q) in "GL"_n (FF)$ such that $matbold(A)' = matbold(P) matbold(A) matbold(Q)$.
]

#example[
  By change of basis formula, for any bases $B, B'$ for $V$ and $C, C'$ for $W$, and $alpha in scr(L)(V, W)$,
  $
    [alpha]^B'_C' quad "is equivalent to" quad [alpha]^B_C.
  $
]

#remark[
  The equivalence of matrices is an equivalence relation on $MM_(m times n)(FF)$. #fade[[This is due to $"GL"_m (FF)$ and $"GL"_n (FF)$ being groups.]]
]

#definition[
  For $matbold(A) in MM_(m times n) (FF)$, the *column-space* of $matbold(A)$ is the subspace $col matbold(A) <= FF^m$ spanned by the columns of $matbold(A)$.

  The *column-rank* of $matbold(A)$ is $colrank matbold(A) = dim col matbold(A)$.
]

#definition[
  The *row-space* of $matbold(A)$ is
  $
    row matbold(A) = col matbold(A)^TT <= FF^n.
  $
  The *row-rank* of $matbold(A)$ is $rowrank matbold(A) = dim row matbold(A)$.
]

#remark[
  We also have $col matbold(A) = row matbold(A)^TT$.
]

#notation[
  For $matbold(A) in MM_(m times n) (FF)$, there is a linear map $alpha: FF^n -> FF^m$ given by
  $
    alpha(v) = matbold(A) v.
  $
  Then $matbold(A) = [alpha]^(E_n)_(E_m)$ where $E_k$ is the standard basis for $FF^k$.

  Moreover, $im alpha = col matbold(A)$, so $rank alpha = colrank matbold(A)$. Therefore, we will write
  $
    ker matbold(A), im matbold(A), rank matbold(A), null matbold(A) quad "for" quad
    ker alpha, im alpha, rank alpha, null alpha
  $
  respectively.
]

#theorem[
  Suppose $matbold(A), matbold(A)' in MM_(m times n) (FF)$.

  + $matbold(A)$ is equivalent to
    $
      mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0))
    $
    where $r = colrank matbold(A)$.

  + $matbold(A)$ and $matbold(A)'$ are equivalent if and only if $colrank matbold(A) = colrank matbold(A)'$.
] <thm-equivalence-of-matrices>

#proof[
  We will first need a lemma to speed up this proof.

  #lemma[
    If $matbold(A) in MM_(m times n) (FF)$ and $matbold(B) in MM_(n times p) (FF)$, then
    $
      rank matbold(A) matbold(B) <= min(rank matbold(A), rank matbold(B)).
    $
  ]

  #proof[
    Note that $im matbold(A) matbold(B) <= im matbold(A)$. So clearly $rank matbold(A) matbold(B) <= rank matbold(A)$.

    Moreover, if $matbold(B) v = vb(0)$, then $matbold(A) matbold(B) v = vb(0)$. Hence $null matbold(B) <= null matbold(A) matbold(B)$. By @thm-rank-nullity[Rank-Nullity Theorem],
    $
      rank matbold(A) matbold(B) = p - null matbold(A) matbold(B) <= p - null matbold(B) = rank matbold(B).
    $
  ]

  + Let $alpha$ be the linear map $FF^n -> FF^m$ given by $alpha(v) = matbold(A) v$. So $matbold(A) = [alpha]^(E_n)_(E_m)$. Hence by @thm-rank-of-linear-map, there exist bases $B, C$ for $FF^n, FF^m$ respectively such that
    $
      [alpha]^B_C = mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0))
    $
    where $r = rank alpha = colrank matbold(A)$. By change of basis formula,
    $
      [alpha]^B_C = underbracket([id_(FF^m)]^(E_m)_(C), matbold(P) in "GL"_m (FF)) underbracket([alpha]^(E_n)_(E_m), matbold(A)) underbracket([id_(FF^n)]^(B)_(E_n), matbold(Q) in "GL"_n (FF)).
    $


  + #fade[[$arrow.double.l$]] If $colrank matbold(A) = colrank matbold(A)' = r$, then $matbold(A)$ and $matbold(A)'$ are both equivalent to $mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0))$ by (1). Hence $matbold(A)$ is equivalent to $matbold(A)'$ by symmetry and transitivity of equivalence.

    #fade[[$arrow.double.r$]] If $matbold(A)$ is equivalent to $matbold(A)'$, then there exist $matbold(P) in "GL"_m (FF)$ and $matbold(Q) in "GL"_n (FF)$ such that
    $
      matbold(A)' = matbold(P) matbold(A) matbold(Q).
    $
    By the lemma, we have
    $
      rank matbold(A)' <= min(rank matbold(P), rank matbold(A), rank matbold(Q)) = rank matbold(A).
    $
    By symmetry, we also have $rank matbold(A) <= rank matbold(A)'$. Hence $colrank matbold(A) = colrank matbold(A)'$.
]

#intuition[
  In (1), the columns of $matbold(Q)$ are $B$, and those of $matbold(P)^(-1)$ are $C$. For example:
  #let lab(x) = math.display(text(size: 0.8em, x))
  $
    matbold(A) matbold(Q) = mat(delim: "[", 1, 2; 2, 4)
    underbrace(mat(delim: "[", cblue(1), cred(2); cblue(0), cred(-1)), lab([cblue(v_1) | cred(v_2)]))
    = underbrace(mat(delim: "[", cblue(1), 0; cblue(2), 0), lab([matbold(A) cblue(v_1) | matbold(A) cred(v_2)]))
    = underbrace(mat(delim: "[", cblue(1), 0; cblue(2), 1), lab(matbold(P)^(-1) = [cblue(w_1) | w_2]))
    mat(delim: "[", 1, 0; 0, 0)
  $
]

#theorem[
  For any $matbold(A) in MM_(m times n)(FF)$,
  $
    colrank matbold(A) = rowrank matbold(A).
  $
] <thm-colrank-equals-rowrank>

#proof[
  By @thm-equivalence-of-matrices, we can write
  $
    matbold(P) matbold(A) matbold(Q) = mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0)) in MM_(m times n)(FF)
  $
  where $r = colrank matbold(A)$. Taking transposes, we have #fade[[as $(matbold(X) matbold(Y))^TT = matbold(Y)^TT matbold(X)^TT$, and in particular if $matbold(X)$ is invertible, then so is $matbold(X)^TT$]]
  $
    matbold(Q)^TT matbold(A)^TT matbold(P)^TT = mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0)) in MM_(n times m)(FF).
  $
  Thus by @thm-rank-of-linear-map (2), $rowrank matbold(A) = colrank matbold(A)^TT = r = colrank matbold(A)$.
]

#remark[
  If $V$ is a finite-dimensional $FF$-vector space, $B, B'$ are bases for $V$, and $alpha in scr(L)(V, V)$, we have
  $
    [alpha]^B'_B' = underbracket([id_V]^(B)_(B'), matbold(P)) [alpha]^B_B underbracket([id_V]^(B')_(B), matbold(P)^(-1))
  $
  by @prop-invertible-base-change-matrix.
]

#definition[Similarity of matrices][
  $matbold(A), matbold(A)' in MM_(n times n) (FF)$ are similar if there exists $matbold(P) in "GL"_n (FF)$ such that
  $
    matbold(A)' = matbold(P) matbold(A) matbold(P)^(-1).
  $
  #fade[[Note that this is slightly different from the definition of conjugacy in group theory, where we would require $matbold(A), matbold(A)' in "GL"_n (FF)$ instead of any $n times n$ matrix.]]
]

#remark[
  + Similarity of matrices is an equivalence relation on $MM_(n times n)(FF)$.

  + If $matbold(A), matbold(A)'$ are similar then they are equivalent.
]

#example[
  $matbold(I)_n in MM_(n times n)(FF)$ is equivalent to every $matbold(P) in "GL"_n (FF)$, but only similar to itself.
]

#lecture-separator(lecture: 8, date: "2026-10-26")

== Elementary Operations on Matrices

Consider $matbold(A) in MM_(m times n)(FF)$. Suppose the rows of $matbold(A)$ are $r_1, ..., r_m$.
$
  matbold(A) = mat(delim: "[", dash.em, r_1, dash.em; dots.v, dots.v, dots.v; dash.em, r_m, dash.em)
$

#definition[Elementary Row Operations][
  There are three types of *elementary row operations* (EROs):

  + Swap $r_i$ and $r_j$ ($i != j$).

  + Replace $r_i$ by $lambda r_i$ ($lambda in FF^* = FF \\ {0}$).

  + Replace $r_i$ by $r_i + lambda r_j$ ($lambda in FF$, $i != j$).
]

#remark[
  All elementary row operations are invertible.
]

Similarly, there are three types of *elementary column operations* (ECOs).

The corresponding matrices for EROs and ECOs are called *elementary matrices*.

#definition[Swap Matrix][
  For $1 <= i, j <= n$ with $i != j$, the *swap matrix* $matbold(T)_(i, j) in MM_(n times n)(FF)$ is
  $
    matbold(T)_(i, j) = mat(delim: "[", dash.em, e_1, dash.em; dots.v, dots.v, dots.v; dash.em, e_j, dash.em; dots.v, dots.v, dots.v; dash.em, e_i, dash.em; dots.v, dots.v, dots.v; dash.em, e_n, dash.em).
  $
  #fade[[This is just swapping the $i$-th and $j$-th rows (equivalently, columns) of the identity matrix.]]
]

#definition[Scaling Matrix][
  For $1 <= i <= n$ and $lambda in FF^*$, the *scaling matrix* $matbold(M)_(i, lambda) in MM_(n times n)(FF)$ is
  $
    matbold(M)_(i, lambda) = mat(delim: "[", dash.em, e_1, dash.em; dots.v, dots.v, dots.v; dash.em, lambda e_i, dash.em; dots.v, dots.v, dots.v; dash.em, e_n, dash.em).
  $

  #fade[[This is just changing the $(i, i)$ entry of the identity matrix to $lambda$.]]
]

#definition[Shear Matrix][
  For $1 <= i, j <= n$ with $i != j$ and $lambda in FF$, the *shear matrix* $matbold(C)_(i, j, lambda) in MM_(n times n)(FF)$ is
  $
    matbold(C)_(i, j, lambda) = mat(delim: "[", dash.em, e_1, dash.em; dots.v, dots.v, dots.v; dash.em, e_i + lambda e_j, dash.em; dots.v, dots.v, dots.v; dash.em, e_n, dash.em).
  $
  #fade[[This is just changing the $(i, j)$ entry of the identity matrix to $lambda$.]]
]

#remark[
  + The elementary matrices are all invertible, and in particular,
    $
      matbold(T)_(i, j)^(-1) = matbold(T)_(i, j), quad matbold(M)_(i, lambda)^(-1) = matbold(M)_(i, lambda^(-1)), quad matbold(C)_(i, j, lambda)^(-1) = matbold(C)_(i, j, -lambda).
    $

  + The matrices are obtained by applying an ERO/ECO to $matbold(I)_n$.
]

#lemma[
  Let $matbold(E) in "GL"_m (FF)$ be an elementary matrix.

  Then $matbold(E) dot matbold(A)$ is obtained from $matbold(A)$ by applying an ERO of the same type as $matbold(E)$ to $matbold(A)$.
]

#proof[
  Direct computation.
]

Similarly, $matbold(A) dot matbold(E)$ for $matbold(E) in "GL"_n (FF)$ is obtained from $matbold(A)$ by applying an ECO of the same type as $matbold(E)$ to $matbold(A)$.

#warning[
  $matbold(A) dot matbold(C)_(i, j, lambda)$ changes the $j$-th column of $matbold(A)$ by adding $lambda$ times the $i$-th column of $matbold(A)$.
]

#intuition[
  Take $matbold(E) = matbold(C)_(1, 2, lambda)$. Row $i$ of $matbold(E) matbold(A)$ only uses row $i$ of $matbold(E)$, and column $j$ of $matbold(A) matbold(E)$ only uses column $j$ of $matbold(E)$.
  $
    mat(delim: "[", cblue(1), cblue(lambda); 0, 1)
    mat(delim: "[", dash.em, r_1, dash.em; dash.em, r_2, dash.em)
    = mat(delim: "[", dash.em, cblue(r_1 + lambda r_2), dash.em; dash.em, r_2, dash.em),
    quad quad
    mat(delim: "[", bar, bar; c_1, c_2; bar, bar)
    mat(delim: "[", 1, cblue(lambda); 0, cblue(1))
    = mat(delim: "[", bar, bar; c_1, cblue(c_2 + lambda c_1); bar, bar)
  $
]

#remark[
  - EROs preserve $row matbold(A)$.

  - ECOs preserve $col matbold(A)$.
]

#theorem[
  By @thm-colrank-equals-rowrank, both EROs and ECOs preserve
  $
    rowrank matbold(A) = colrank matbold(A).
  $
]

#definition[Row-reduced Echelon Form][
  A matrix $matbold(A) in MM_(m times n)(FF)$ is in *row-reduced echelon form* (RRE form) if

  + all non-zero rows of $matbold(A)$ are above all zero rows;

  + in any non-zero row $r_i$, the leftmost non-zero entry of $r_i$ is $1$, at place $p(r_i) <= n$, called the *pivot entry*;

  + if $r_i$ and $r_j$ are non-zero rows and $i < j$ then $p(r_i) < p(r_j)$;

  + if a non-zero column contains a pivot entry, then all other entries in that column are $0$.
]

#example[
  A representative $3 times 5$ matrix in RRE form is
  $
    mat(
      delim: "[",
      1, a, 0, 0, b;
      0, 0, 1, 0, c;
      0, 0, 0, 1, d
    ).
  $
]

#definition[Column-reduced Echelon Form][
  $matbold(A)$ is in *column-reduced echelon form* (CRE form) if $matbold(A)^TT$ is in RRE form.
]

#lemma[
  If $matbold(A)$ is in RRE form, then $rowrank matbold(A) = "number of non-zero rows"$.
]

#proof[
  Suppose the non-zero rows are $r_1, ..., r_k$. Then $row matbold(A) = span(r_1\, ...\, r_k)$. Suppose
  $
    sum_(i=1)^k lambda_i r_i = vb(0) quad "for some" lambda_i in FF.
  $
  Let $p(r_i) = j_i$. Then $j_1 < j_2 <... < j_k$. Since a pivot entry is the only non-zero entry in its column,
  $
    lambda_i = (j_i)"-th entry of" sum_(l=1)^k lambda_l r_l = 0.
  $
  Hence $r_1, ..., r_k$ are linearly independent, and $rowrank matbold(A) = dim row matbold(A) = k$.
]

#intuition[
  For the example above, the entries of $sum_l lambda_l r_l$ in the pivot columns (blue) are $lambda_1, lambda_2, lambda_3$.
  #align(center, grid(
    columns: 6,
    align: center + horizon,
    inset: (x: 0.6em, y: 0.4em),
    fill: (x, y) => if y > 0 and x in (1, 3, 4) { tint("blue") },
    [], $j_1$, [], $j_2$, $j_3$, [],
    $lambda_1 r_1$, $lambda_1$, $lambda_1 a$, $0$, $0$, $lambda_1 b$,
    $lambda_2 r_2$, $0$, $0$, $lambda_2$, $0$, $lambda_2 c$,
    $lambda_3 r_3$, $0$, $0$, $0$, $lambda_3$, $lambda_3 d$,
    grid.hline(y: 4, start: 1, stroke: 0.5pt + colors.text),
    $sum_l lambda_l r_l$, $lambda_1$, $lambda_1 a$, $lambda_2$, $lambda_3$, $lambda_1 b + lambda_2 c + lambda_3 d$,
  ))
]

#proposition[
  Every $matbold(A) in MM_(m times n)(FF)$ can be transformed into RRE form by a sequence of EROs.
] <prop-gaussian-elimination>

#proof[#fade[[Gaussian Elimination.]]
  We will induct on the number of columns $n$.

  Let $matbold(A) = mat(delim: "[", bar, dots.c, bar; c_1, dots.c, c_n; bar, dots.c, bar)$.

  - If $c_1 = vb(0)$ then we apply induction to the sub-matrix $mat(delim: "[", bar, dots.c, bar; c_2, dots.c, c_n; bar, dots.c, bar)$.

  - If $c_1 != vb(0)$, then WLOG $a_(i, 1) != 0$.

    - By Type (1) ERO we can move $a_(i, 1)$ to $(1, 1)$ entry so that $(1, 1)$ entry is non-zero.

    - By Type (2) ERO we can scale the first row so that $(1, 1)$ entry is $1$.

    - By Type (3) ERO use the first row to eliminate all other non-zero entries in the first column.

    Then we obtain
    $
      mat(
        delim: "[",
        1, *, dots.c, *;
        0, , , ;
        dots.v, , matbold(A)', , ;
        0, , , ;
      )
    $
    By induction, we can reduce this sub-matrix $matbold(A)'$ to RRE form. Finally, use the pivot entries in $matbold(A)'$ and Type (3) EROs to eliminate entries of row 1 in pivot columns of $matbold(A)'$.
]

#intuition[
  For example, with the pivots in blue and $matbold(A)'$ cut off by lines:
  #let step(label) = $#h(0.5em) stretch(->, size: #(100% + 1em))^display(#text(size: 0.8em, $label$)) #h(0.5em)$
  $
    mat(delim: "[", 0, 2, 2; 2, 2, 4; 1, 3, 4)
    & step(r_1 <-> r_2) mat(delim: "[", 2, 2, 4; 0, 2, 2; 1, 3, 4)
    step(r_1 \/ 2) mat(delim: "[", cblue(1), 1, 2; 0, 2, 2; 1, 3, 4)
    step(r_3 - r_1) mat(delim: "[", cblue(1), 1, 2; 0, 2, 2; 0, 2, 2; augment: #(hline: 1, vline: 1)) \
    & step("induction on" matbold(A)') mat(delim: "[", cblue(1), 1, 2; 0, cblue(1), 1; 0, 0, 0; augment: #(hline: 1, vline: 1))
    step(r_1 - r_2) mat(delim: "[", cblue(1), 0, 1; 0, cblue(1), 1; 0, 0, 0)
  $
]

#remark[
  + Gaussian elimination preserves $row matbold(A)$. Call the matrix obtained the RRE form of $matbold(A)$.

  + The RRE form of $matbold(A)$ is unique. #fade[[We will not prove it here.]]

  + Transposing, we can put $matbold(A)$ into CRE form by a sequence of ECOs.

  + If $matbold(A)$ is a square matrix, then the RRE form of $matbold(A)$ is either $matbold(I)_n$ or has a zero row.
]

#theorem[
  For $matbold(A) in MM_(n times n)(FF)$, the following are equivalent:

  + $#fade[[$colrank matbold(A) = rowrank matbold(A) =$]] rank matbold(A) = n$;

  + $matbold(A)$ is a product of elementary matrices;

  + $matbold(A)$ is invertible.
]

#proof[

  #fade[[$(1) => (2)$]] By @prop-gaussian-elimination, there exist elementary matrices $matbold(E)_1, ..., matbold(E)_k$ such that
  $
    matbold(A)' = matbold(E)_k ... matbold(E)_1 matbold(A)
  $
  and $matbold(A)'$ is in RRE form. By the remarks (1) and (4) above, we must have $matbold(A)' = matbold(I)_n$. So
  $
    matbold(A) = matbold(E)_1^(-1) ... matbold(E)_k^(-1).
  $

  #fade[[$(2) => (3)$]] The elementary matrices lie in $"GL"_n (FF)$, which is a group.

  #fade[[$(3) => (1)$]] If $matbold(A) dot matbold(B) = matbold(I)_n$, then for any $v in FF^n$, $v = matbold(A) (matbold(B) v) in im matbold(A)$. Hence $rank matbold(A) = n$.
]

#lecture-separator(lecture: 9, date: "2026-10-28")

#proof[
  #fade[[Alternative proof to @thm-equivalence-of-matrices (1).]]

  Let $matbold(E)_1, ..., matbold(E)_l$ be elementary matrices such that $matbold(A)' = matbold(E)_l ... matbold(E)_1 matbold(A)$ is in RRE form. Write $matbold(P) = matbold(E)_l ... matbold(E)_1 in "GL"_m (FF)$.

  Apply ECOs of Type (1) to $matbold(A)' = matbold(P) matbold(A)$ to move all pivot columns to the left. Then we obtain
  $
    matbold(A)'' = matbold(A)' matbold(E)'_1 ... matbold(E)'_k = mat(delim: "[", matbold(I)_r, *; matbold(0), matbold(0)).
  $
  Finally, use ECOs of Type (3) to eliminate $(*)$. Hence we obtain
  $
    matbold(A)'' matbold(E)''_1 ... matbold(E)''_j = mat(delim: "[", matbold(I)_r, matbold(0); matbold(0), matbold(0)).
  $
  Set $matbold(Q) = matbold(E)'_1 ... matbold(E)'_k matbold(E)''_1 ... matbold(E)''_j in "GL"_n (FF)$. Then $matbold(P) matbold(A) matbold(Q)$ is in the desired form.
]

#intuition[
  For example, with the pivot columns in blue:
  #let step(label) = $#h(0.5em) stretch(->, size: #(100% + 1em))^display(#text(size: 0.8em, $label$)) #h(0.5em)$
  #let lab(x) = math.display(text(size: 0.8em, x))
  $
    underbrace(mat(delim: "[", cblue(1), a, cblue(0), b; cblue(0), 0, cblue(1), c; cblue(0), 0, cblue(0), 0), lab(matbold(A)'))
    step(c_2 <-> c_3)
    underbrace(mat(delim: "[", cblue(1), cblue(0), a, b; cblue(0), cblue(1), 0, c; cblue(0), cblue(0), 0, 0; augment: #(hline: 2, vline: 2)), lab(matbold(A)''))
    step(c_3 - a c_1\, thick c_4 - b c_1 - c c_2)
    underbrace(mat(delim: "[", cblue(1), cblue(0), 0, 0; cblue(0), cblue(1), 0, 0; cblue(0), cblue(0), 0, 0; augment: #(hline: 2, vline: 2)), lab(matbold(P) matbold(A) matbold(Q)))
  $
]

#remark[
  If $matbold(A) in "GL"_n (FF)$, then it can be reduced to $matbold(I)_n$ using only EROs or ECOs.
]
