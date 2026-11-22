#import "../prelude.typ": *
#show: chapter.with(3)

= Determinants and Traces

We will assume that $matbold(A) in MM_(n times n) (FF)$, and write
$
  matbold(A) = mat(
    delim: "[",
    bar, , bar;
    C_1, dots.c, C_n;
    bar, , bar;
  )
$
where $C_i in FF^n$ are the columns of $matbold(A)$.


#theorem[
  For each $n in NN$, there exists a unique function
  $
    det: MM_(n times n) (FF) -> FF
  $
  satisfying

  + #fade[[alternating.]] If $exists i!= j$ such that $C_i = C_j$, then $det matbold(A) = 0$.

  + #fade[[multilinearity.]] For each $i$ and each $matbold(A)$, the map
    $
      d_(matbold(A), i): FF^n & -> FF \
                            v & |-> det(matbold(A) "with column" i "replaced by" v)
    $
    is linear.

  + #fade[[normalisation.]] $det matbold(I)_n = 1$.
] <thm-det-exists-unique>

#definition[Determinant][
  $det matbold(A)$ is the *determinant* of $matbold(A)$.

  A function that satisfies (1) and (2) in @thm-det-exists-unique is called an *$n$-dimensional volume form*.
]

#lemma[
  Let $F: MM_(n times n) (FF) -> FF$ be an $n$-dimensional volume form, and $matbold(A) in MM_(n times n) (FF)$.

  + If $matbold(A)$ has a zero column, then $F(matbold(A)) = 0$.

  + $F(matbold(A) dot matbold(T)_(i, j)) = - F(matbold(A))$ for $i!= j$.

  + $F(matbold(A) dot matbold(M)_(i, lambda)) = lambda F(matbold(A))$ for any $0 != lambda in FF$.

  + $F(matbold(A) dot matbold(C)_(i, j, lambda)) = F(matbold(A))$.
] <lem-n-dim-vol-form-properties>

#proof[
  Let $d_(matbold(A), i) : FF^n -> FF$ be as in hypothesis (2) of @thm-det-exists-unique, with $det$ replaced by $F$. Note that $d_(matbold(A), i) (C_j) = delta_(i, j) F(matbold(A))$.

  + If $C_i = vb(0)$, then $F(matbold(A)) = d_(matbold(A), i)(vb(0)) = 0$.

  + Let $overline(matbold(A))$ be obtained from $matbold(A)$ by replacing both $C_i$ and $C_j$ by $C_i + C_j$. Then
    $
      0 = F(overline(matbold(A))) & = F(matbold(A)) + F(matbold(A) dot matbold(T)_(i, j)) + d_(matbold(A), i) (C_j) + d_(matbold(A), j) (C_i) \
      & = F(matbold(A)) + F(matbold(A) dot matbold(T)_(i, j)).
    $

  + We have
    $
      F(matbold(A) dot matbold(M)_(i, lambda)) & = d_(matbold(A), i) (lambda C_i) \
                                               & = lambda d_(matbold(A), i) (C_i) \
                                               & = lambda F(matbold(A)).
    $

  + We have
    $
      F(matbold(A) dot matbold(C)_(i, j, lambda)) & = d_(matbold(A), j) (C_j + lambda C_i) \
                                                  & = d_(matbold(A), j) (C_j) + lambda d_(matbold(A), j) (C_i) \
                                                  & = F(matbold(A)).
    $
]

#intuition[
  Part 2, writing only columns $i$ and $j$ of each matrix:
  $
    0 = F\(cblue(C_i) + cred(C_j), cblue(C_i) + cred(C_j)\) = underbrace(F lr((cblue(C_i), cblue(C_i)), size: #1em), 0) + underbrace(F lr((cblue(C_i), cred(C_j)), size: #1em), F(matbold(A))) + underbrace(F lr((cred(C_j), cblue(C_i)), size: #1em), F\(matbold(A) matbold(T)_(i, j)\)) + underbrace(F lr((cred(C_j), cred(C_j)), size: #1em), 0).
  $
]

#proof[
  #fade[[Proof of @thm-det-exists-unique.]]

  *Uniqueness.* Suppose $F: MM_(n times n)(FF) -> FF$ satisfies (1), (2) and (3). By @lem-n-dim-vol-form-properties, we have
  $
            F(matbold(T)_(i, j)) & = -1 \
       F(matbold(M)_(i, lambda)) & = lambda \
    F(matbold(C)_(i, j, lambda)) & = 1 \
        F(matbold(A) matbold(E)) & = F(matbold(A)) F(matbold(E)) #eq-note[$matbold(E)$ is an elementary matrix.]
  $
  Let $matbold(E)_1, ..., matbold(E)_l$ be elementary matrices such that
  $
    matbold(A)' = matbold(A) matbold(E)_1 ... matbold(E)_l
  $
  is in CRE form. Then
  $
    F(matbold(A)) = F(matbold(A)') (F(matbold(E)_1))^(-1) ... (F(matbold(E)_l))^(-1).
  $

  - If $rank matbold(A) < n$, then $matbold(A)'$ has a zero column, so $F(matbold(A)') = 0$ and hence $F(matbold(A)) = 0$.

  - If $rank matbold(A) = n$, then $matbold(A)' = matbold(I)_n$, so $F(matbold(A))$ is determined by $F(matbold(E)_1), ..., F(matbold(E)_l)$.

  *Existence.* Recall from IA Groups that

  - $S_n$ is the group of permutations of ${1, ..., n}$

  - $sgn: S_n -> {plus.minus 1}$ is the unique homomorphism such that $sgn(tau) = -1$ for all transpositions $tau$.

  - $A_n = ker sgn$, so $S_n = A_n union.sq A_n tau$ for any transposition $tau$.

  We define the determinant of $matbold(A)$ as follows.

  #definition[Leibniz formula for determinants][
    Define $det: MM_(n times n) (FF) -> FF$ by
    $
      det matbold(A) = sum_(sigma in S_n) sgn(sigma) product_(i=1)^n a_(sigma(i), i) #eq-note[$a_(i, j)$ is the $(i, j)$-th entry of $matbold(A)$.]
    $
  ] <def-leibniz-formula-for-determinants>

  Then from the definition,

  3. $det (matbold(I)_n) = 1$ (only $sigma = id$ contributes to the sum).

  2. Each product $product_i a_(sigma (i), i)$ is multilinear in columns of $matbold(A)$, and hence so is their signed sum.

  1. Suppose $C_k = C_l$ for some $k != l$. Set $tau = mat(k, l)$. Then $a_(j, i) = a_(j, tau(i))$ for all $i, j$. Then

    $
      det matbold(A) &= sum_(sigma in A_n) sgn(sigma) product_(i=1)^n a_(sigma(i), i) + sum_(sigma in A_n) sgn(sigma tau) product_(i=1)^n a_(sigma tau(i), i) \
      &= sum_(sigma in A_n) product_(i=1)^n a_(sigma(i), i) - sum_(sigma in A_n) product_(i=1)^n a_(sigma tau(i), i) \
      &= sum_(sigma in A_n) product_(i=1)^n a_(sigma(i), i) - sum_(sigma in A_n) product_(i=1)^n a_(sigma tau(i), tau(i)) \
      &= sum_(sigma in A_n) product_(i=1)^n a_(sigma(i), i) - sum_(sigma in A_n) product_(j=1)^n a_(sigma(j), j) #eq-note[since $tau(i)$ permutes all indices] \
      &=0.
    $

]

#intuition[
  #block(breakable: false)[
    Uniqueness for two $2 times 2$ matrices, with the value of $F$ under each matrix:
    #fletcher-diagram(
      spacing: (3.4em, 0.5em),
      node-outset: 4pt,
      node((-1, 0.5), text(fill: ink("gray"))[$rank matbold(A) = 2$]),
      node((0, 0), $display(mat(0, 2; 1, 3))$),
      edge((0, 0), (1, 0), "->", $matbold(T)_(1, 2)$),
      node((1, 0), $display(mat(2, 0; 3, 1))$),
      edge((1, 0), (2, 0), "->", $matbold(M)_(1, 1\/2)$),
      node((2, 0), $display(mat(1, 0; 3\/2, 1))$),
      edge((2, 0), (3, 0), "->", $matbold(C)_(2, 1, -3\/2)$),
      node((3, 0), $display(mat(1, 0; 0, 1))$),
      node((0, 1), $F(matbold(A))$),
      node((1, 1), $-F(matbold(A))$),
      node((2, 1), $-1/2 F(matbold(A))$),
      node((3, 1), $-1/2 F(matbold(A)) = 1$),
      node((-1, 3.5), text(fill: ink("gray"))[$rank matbold(A) = 1$]),
      node((0, 3), $display(mat(1, 2; 2, 4))$),
      edge((0, 3), (1, 3), "->", $matbold(C)_(1, 2, -2)$),
      node((1, 3), $display(mat(1, 0; 2, 0))$),
      node((0, 4), $F(matbold(A))$),
      node((1, 4), $F(matbold(A)) = 0$),
    )
  ]

  #block(breakable: false)[
    Part 1 of existence for $n = 3$, $C_1 = C_2$ and $tau = (1 med 2)$, with the entries $a_(sigma(i), i)$ highlighted:
    #align(center, grid(
      columns: 4,
      column-gutter: 2.2em,
      row-gutter: (0.7em, 1.5em, 0.7em),
      align: center + horizon,
      text(fill: ink("gray"))[$sigma in A_3$],
      $display(mat(hblue(a), a, d; b, hblue(b), e; c, c, hblue(f)))$,
      $display(mat(a, a, hblue(d); hblue(b), b, e; c, hblue(c), f))$,
      $display(mat(a, hblue(a), d; b, b, hblue(e); hblue(c), c, f))$,

      [], $+a b f$, $+b c d$, $+c a e$,
      text(fill: ink("gray"))[$sigma tau$],
      $display(mat(a, hblue(a), d; hblue(b), b, e; c, c, hblue(f)))$,
      $display(mat(a, a, hblue(d); b, hblue(b), e; hblue(c), c, f))$,
      $display(mat(hblue(a), a, d; b, b, hblue(e); c, hblue(c), f))$,

      [], $-b a f$, $-c b d$, $-a c e$,
    ))
  ]
]

We have also proved:

#corollary[
  $det matbold(A) != 0$ iff $matbold(A)$ is invertible. In this case, for $matbold(A) = matbold(E)_1 ... matbold(E)_l$,
  $
    det matbold(A) = det (matbold(E)_1) ... det (matbold(E)_l) #eq-note[$matbold(E)_i$ are elementary matrices.]
  $
] <cor-det-invertible>

== Properties of Determinants

#lemma[
  For all $matbold(A) in MM_(n times n) (FF)$,
  $
    det matbold(A)^TT = det matbold(A).
  $
] <lem-det-transpose>
#proof[
  We have
  $
    det matbold(A)^TT & = sum_(sigma in S_n) sgn(sigma) product_(i=1)^n a_(i, sigma(i)) \
    & = sum_(sigma in S_n) sgn(sigma) product_(j=1)^n a_(sigma^(-1) (j), j) #eq-note[using $j = sigma (i)$] \
    & = sum_(sigma in S_n) sgn(sigma^(-1)) product_(j=1)^n a_(sigma^(-1) (j), j) \
    & = sum_(sigma in S_n) sgn(sigma) product_(i=1)^n a_(sigma(i), i) #eq-note[since $sigma^(-1)$ ranges over all $S_n$] \
    & = det matbold(A).
  $
]

#intuition[
  For $n = 3$ and $sigma = (1 med 2 med 3)$, the term of $sigma$ in $det matbold(A)^TT$ uses the highlighted entries of $matbold(A)$:
  #align(center, grid(
    columns: 4,
    column-gutter: (2.5em, 0.3em, 1.2em),
    row-gutter: 0.9em,
    align: (center + horizon, right + horizon, left + horizon, left + horizon),
    grid.cell(rowspan: 2, $display(mat(a_11, hblue(a_12), a_13; a_21, a_22, hblue(a_23) thin; thin hblue(a_31), a_32, a_33; row-gap: #0.4em))$),
    $a_(1, sigma(1)) a_(2, sigma(2)) a_(3, sigma(3))$,
    $= a_12 a_23 a_31$,
    text(fill: ink("gray"))[by rows],
    $a_(sigma^(-1)(1), 1) a_(sigma^(-1)(2), 2) a_(sigma^(-1)(3), 3)$,
    $= a_31 a_12 a_23$,
    text(fill: ink("gray"))[by columns],
  ))
]

#lecture-separator(lecture: 10, date: "2026-10-30")

#proposition[
  For all $matbold(A), matbold(B) in MM_(n times n) (FF)$,
  $
    det (matbold(A) matbold(B)) = det (matbold(A)) det (matbold(B)).
  $
]

#proof[
  If $rank matbold(A) < n$ or $rank matbold(B) < n$, then $rank matbold(A B) < n$, since $rank matbold(A B) <= min(rank matbold(A), rank matbold(B))$. Hence both sides are zero by @cor-det-invertible.

  If $matbold(A), matbold(B)$ both have rank $n$, then write
  $
    matbold(A) & = matbold(E)_1 ... matbold(E)_l \
    matbold(B) & = matbold(E)'_1 ... matbold(E)'_k
  $
  where $matbold(E)_i, matbold(E)'_j$ are elementary matrices. Then
  $
    det (matbold(A) matbold(B)) & = det (matbold(E)_1 ... matbold(E)_l matbold(E)'_1 ... matbold(E)'_k) \
                                & = det (matbold(E)_1) ... det (matbold(E)_l) det (matbold(E)'_1) ... det (matbold(E)'_k) \
                                & = det (matbold(A)) det (matbold(B)). \
  $
]

#corollary[
  $det$ defines a homomorphism of groups $"GL"_n (FF) -> (FF\\{0}, dot)$.
]

#corollary[
  If $matbold(A)$ is invertible, then $det (matbold(A)^(-1)) = (det matbold(A))^(-1)$.
]

#corollary[
  Similar matrices have the same determinant.
] <cor-similar-matrices-same-det>

#proof[
  We have
  $
    det (matbold(P) matbold(A) matbold(P)^(-1)) & = det (matbold(P)) det (matbold(A)) det (matbold(P)^(-1)) \
                                                & = det (matbold(P)) det (matbold(A)) (det (matbold(P)))^(-1) \
                                                & = det (matbold(A)). \
  $
]

This gives us an opportunity to define the determinant of a linear map.

#definition[
  Let $V$ be a finite-dimensional $FF$-vector space, and let $alpha in scr(L) (V, V)$. Fix a basis $B$ for $V$. The determinant of $alpha$ is defined as
  $
    det alpha = det ([alpha]^B_B)
  $
] <def-det-linear-map>

#proposition[
  @def-det-linear-map is independent of the choice of basis $B$.
]

#proof[
  Let $B'$ be another basis for $V$. Set $matbold(P) = [id_V]^B_B' in "GL"_n (FF)$ with $matbold(P)^(-1) = [id_V]^B'_B$. Then
  $
    [alpha]^B'_B' & = matbold(P) [alpha]^B_B matbold(P)^(-1) \
  $
  is similar to $[alpha]^B_B$. Hence by @cor-similar-matrices-same-det,
  $
    det ([alpha]^B'_B') = det ([alpha]^B_B).
  $

]

#definition[
  $alpha in scr(L)(V, V)$ is *singular* if $det alpha = 0$.
]

#corollary[
  The following are equivalent for $alpha in scr(L)(V, V)$:

  + $rank alpha = dim V$;

  + $alpha$ is invertible;

  + $alpha$ is non-singular.
] <cor-invertible-non-singular>

#proof[

  #fade[[(1) $<=>$ (2)]] By @thm-rank-nullity[Rank-Nullity Theorem].

  #fade[[(1) $<=>$ (3)]] Fix any basis $B$ for $V$. Let $matbold(A) = [alpha]^B_B$. Then $rank alpha = rank matbold(A)$. Hence $rank alpha = dim V$ iff $det matbold(A) != 0$ by @cor-det-invertible.
]

#proposition[Block-Triangular Matrix][
  For $matbold(A) in MM_(k times k)(FF)$, $matbold(B) in MM_(l times l)(FF)$,
  $
    det(
      mat(
        delim: "[",
        matbold(A), *;
        matbold(0), matbold(B);
      )
    ) = det matbold(A) det matbold(B).
  $

] <prop-block-triangular-matrices>
#proof[
  Let
  $
    matbold(C) = mat(
      delim: "[",
      matbold(A), *;
      matbold(0), matbold(B);
    )
  $
  and $n = k + l$. Then $c_(i, j) = 0$ for $i >= k + 1$, $j <= k$. So for $sigma in S_n$, if $product_(i=1)^n c_(sigma(i), i) !=0$ then $sigma$ preserves $X = {1, ..., k}$. Hence, it also preserves $Y = {k+1, ..., n}$.

  Hence we can decompose $sigma = tau dot theta$, where $tau$ permutes $X$ and $theta$ permutes $Y$. Conversely, given $tau in Sym(X)$ and $theta in Sym(Y)$, we obtain $tau dot theta in S_n$.

  Moreover,
  $
    product_(i=1)^n c_((tau theta)(i), i) &= (product_(x in X) c_(tau(x), x)) (product_(y in Y) c_(theta(y), y)) #eq-note[$X union.sq Y = {1, ..., n}$]\
  $
  So,
  $
    det matbold(C) & = sum_(sigma in S_n) sgn(sigma) product_(i=1)^n c_(sigma(i), i) \
    & = sum_(tau in Sym(X)\ theta in Sym(Y)) sgn(tau theta) product_(i=1)^n c_((tau theta)(i), i) \
    &= sum_(tau in Sym(X)\ theta in Sym(Y)) sgn(tau) sgn(theta) product_(x in X) c_(tau(x), x) product_(y in Y) c_(theta(y), y) \
    &= (sum_(tau in Sym(X)) sgn(tau) product_(x in X) c_(tau(x), x)) (sum_(theta in Sym(Y)) sgn(theta) product_(y in Y) c_(theta(y), y)) \
    &= det matbold(A) det matbold(B). \
  $
]

#intuition[
  For $k = l = 2$, two terms of $det matbold(C)$, with the entries $c_(sigma(i), i)$ highlighted:
  #align(center, grid(
    columns: 2,
    column-gutter: 4em,
    row-gutter: 0.9em,
    align: center + horizon,
    $display(mat(a_11, a_12, hblue(*), *; a_21, hblue(a_22), *, *; hred(0), 0, b_11, b_12; 0, 0, b_21, hblue(b_22) thin; augment: #(hline: 2, vline: 2), row-gap: #0.45em, column-gap: #0.7em))$,
    $display(mat(a_11, hblue(a_12), *, *; thin hblue(a_21), a_22, *, *; 0, 0, b_11, hblue(b_12) thin; 0, 0, hblue(b_21), b_22; augment: #(hline: 2, vline: 2), row-gap: #0.45em, column-gap: #0.7em))$,

    [$sigma = (1 med 3)$ sends $1 in X$ to $3 in Y$, \ so the term has the factor $c_(3, 1) = 0$],
    [$sigma = tau theta$ with $tau = (1 med 2)$, $theta = (3 med 4)$, \ and the term is $(-a_21 a_12)(-b_21 b_12)$],
  ))
]

#warning[
  $
    det mat(matbold(W), matbold(X); matbold(Y), matbold(Z)) != det matbold(W) det matbold(Z) - det matbold(X) det matbold(Y)
  $
  in general.
]

#corollary[
  $
    det mat(
      matbold(A)_1, dots.c, *;
      dots.v, dots.down, dots.v;
      matbold(0), dots.c, matbold(A)_k
    ) = det matbold(A)_1 ... det matbold(A)_k
  $
]

#definition[
  For $matbold(A) in MM_(n times n)(FF)$, let $matbold(A)_hat(i j) in MM_((n-1) times (n-1))(FF)$ be the matrix obtained by deleting the $i$-th row and $j$-th column of $matbold(A)$. Its determinant $det matbold(A)_hat(i j)$ is the *$(i, j)$-minor* of $matbold(A)$.
]

#lemma[Laplace Expansion Along a Column/Row][
  + For a fixed $j$,
    $
      det matbold(A) = sum_(i = 1)^n (-1)^(i+j) a_(i j) det matbold(A)_hat(i j).
    $

  + For a fixed $i$,
    $
      det matbold(A) = sum_(j = 1)^n (-1)^(i+j) a_(i j) det matbold(A)_hat(i j).
    $

]

#proof[
  (2) follows from (1) by transposing $matbold(A)$ and using @lem-det-transpose. Hence we only need to prove (1).

  Recall that the elementary matrix $matbold(T)_(i, j)$ #fade[[row/column swap]] has $det matbold(T)_(i, j) = -1$.

  Let $matbold(A) = mat(
    delim: "[",
    bar, , bar;
    C_1, dots.c, C_n;
    bar, , bar;
  )$
  and let $C_j = sum_(i=1)^n a_(i j) e_i$ where $e_i$ is the $i$-th standard basis vector. Then by linearity in column $j$,
  $
    det matbold(A) = sum_(i=1)^n a_(i j) det underbracket(
      mat(
        delim: "[",
        bar, , bar, bar, bar, , bar;
        C_1, dots.c, C_(j-1), e_i, C_(j+1), dots.c, C_n;
        bar, , bar, bar, bar, , bar;
      ), matbold(A)^((i))
    )
  $
  We just need to find $det(matbold(A)^((i)))$. Applying $(j-1)$ column swaps to move $e_i$ to column $1$, we get
  $
    det (matbold(A)^((i))) = (-1)^(j-1) det
    mat(
      delim: "[",
      bar, bar, , bar, bar, , bar;
      e_i, C_1, dots.c, C_(j-1), C_(j+1), dots.c, C_n;
      bar, bar, , bar, bar, , bar;
    ),
  $
  Applying $(i-1)$ row swaps to move $e_i$ to row $1$, we get
  $
    det (matbold(A)^((i))) & = (-1)^(i+j - 2) det
                             mat(
                               delim: "[",
                               1, *, dots.c, *;
                               0, , , ;
                               dots.v, , matbold(A)_hat(i j), ;
                               0, , , ;
                             ) \
                           & = (-1)^(i + j) det matbold(A)_hat(i j) \
  $
  using @prop-block-triangular-matrices. Hence we have the desired result.
]

#intuition[
  For $n = 3$, $i = 2$ and $j = 3$, with $cred(e_2)$ in red and the entries of $matbold(A)_hat(2 3)$ in blue:
  #fletcher-diagram(
    spacing: 7.5em,
    node-outset: 5pt,
    node((0, 0), $matbold(A)^((2)) = display(mat(cblue(a_11), cblue(a_12), cred(0); a_21, a_22, cred(1); cblue(a_31), cblue(a_32), cred(0)))$),
    edge((0, 0), (1, 0), "->", label: text(size: 0.85em)[column swaps], label-sep: 0.4em),
    edge((0, 0), (1, 0), stroke: none, label: text(size: 0.85em)[$j - 1 = 2$], label-side: right, label-sep: 0.4em),
    node((1, 0), $display(mat(cred(0), cblue(a_11), cblue(a_12); cred(1), a_21, a_22; cred(0), cblue(a_31), cblue(a_32)))$),
    edge((1, 0), (2, 0), "->", label: text(size: 0.85em)[row swap], label-sep: 0.4em),
    edge((1, 0), (2, 0), stroke: none, label: text(size: 0.85em)[$i - 1 = 1$], label-side: right, label-sep: 0.4em),
    node((2, 0), $display(mat(cred(1), a_21, a_22; cred(0), cblue(a_11), cblue(a_12); cred(0), cblue(a_31), cblue(a_32); augment: #(hline: 1, vline: 1)))$),
  )
  $
    det matbold(A)^((2)) = (-1)^(2 + 1) det cblue(mat(a_11, a_12; a_31, a_32)) = (-1)^(2 + 3) det cblue(matbold(A)_hat(2 3)).
  $
]

#definition[Adjugate Matrix][
  The *adjugate matrix* of $matbold(A)$ is the matrix $adj matbold(A) in MM_(n times n)(FF)$ defined by
  $
    (adj matbold(A))_(i, j) = (-1)^(i+j) det matbold(A)_hat(j i).
  $
]

#theorem[Cramer's Rule][
  + $adj matbold(A) dot matbold(A) = matbold(A) dot adj matbold(A) = det matbold(A) dot matbold(I)_n.$

  + If $det matbold(A) != 0$, then $matbold(A)$ is invertible and
    $
      matbold(A)^(-1) = (1)/(det matbold(A)) adj matbold(A).
    $
]<thm-cramers-rule>

#proof[
  (2) is immediate from (1), by uniqueness of inverses. We just need to prove (1).

  By Laplace expansion along the $j$-th column, we have
  $
    det matbold(A) & = sum_(i = 1)^n (-1)^(i+j) a_(i j) det matbold(A)_hat(i j) \
                   & = sum_(i = 1)^n (adj matbold(A))_(j i) a_(i j) \
                   & = (adj matbold(A) dot matbold(A))_(j j). \
  $
  For $j != k$, replace the $j$-th column of $matbold(A)$ by the $k$-th column. Then
  $
    0 & = det mat(
          delim: "[",
          bar, , bar, bar, bar, , bar, bar, bar, , bar;
          C_1, dots.c, C_(j-1), C_k, C_(j+1), dots.c, C_(k-1), C_(k), C_(k+1), dots.c, C_n;
          bar, , bar, bar, bar, , bar, bar, bar, , bar;
        ) \
      & = sum_(i = 1)^n (adj matbold(A))_(j i) a_(i k) \
      & = (adj matbold(A) dot matbold(A))_(j k). \
  $
  The result for $matbold(A) dot adj matbold(A)$ is the same by expanding in the rows.
]

#intuition[
  Expanding along column 1 (red), where $cblue(alpha_i) = (-1)^(i + 1) det matbold(A)_hat(i 1) = (adj matbold(A))_(1 i)$ does not involve column 1:
  $
    underbrace(det mat(cred(a_11), a_12, a_13; cred(a_21), a_22, a_23; cred(a_31), a_32, a_33), det matbold(A)) & = cred(a_11) cblue(alpha_1) + cred(a_21) cblue(alpha_2) + cred(a_31) cblue(alpha_3) = (adj matbold(A) dot matbold(A))_(1 1) \
    underbrace(det mat(cred(a_12), a_12, a_13; cred(a_22), a_22, a_23; cred(a_32), a_32, a_33), 0) & = cred(a_12) cblue(alpha_1) + cred(a_22) cblue(alpha_2) + cred(a_32) cblue(alpha_3) = (adj matbold(A) dot matbold(A))_(1 2)
  $
]

#lecture-separator(lecture: 11, date: "2026-11-02")


#definition[Trace][
  The *trace* of $matbold(A) in MM_(n times n)(FF)$ is
  $
    tr matbold(A) = sum_(i=1)^n a_(i i).
  $
]

#remark[
  $tr in scr(L)(MM_(n times n)(FF), FF)$.
]

#lemma[
  For all $matbold(A), matbold(B) in MM_(n times n)(FF)$,
  $
    tr matbold(A B) = tr matbold(B A).
  $
]

#proof[
  Let $matbold(C) = matbold(A) matbold(B)$, and $matbold(D) = matbold(B) matbold(A)$. Then
  $
    tr matbold(C) & = sum_(i=1)^n c_(i i) \
                  & = sum_(i=1)^n sum_(j=1)^n a_(i j) b_(j i) \
                  & = sum_(j=1)^n sum_(i=1)^n b_(j i) a_(i j) \
                  & = sum_(i=1)^n d_(i i) = tr matbold(D).
  $
]

#warning[
  $tr (matbold(A) matbold(B)) != tr matbold(A) tr matbold(B)$ in general.
]

#corollary[
  Similar matrices have the same trace.
] <cor-similar-matrices-same-tr>

#proof[
  Let $matbold(P) in "GL"_n (FF)$. Then
  $
    tr (matbold(P) matbold(A) matbold(P)^(-1)) & = tr (matbold(P)^(-1) matbold(P) matbold(A)) \
                                               & = tr ((matbold(P)^(-1) matbold(P)) matbold(A)) \
                                               & = tr (matbold(A)). \
  $
]

#definition[Trace of a Linear Map][
  Let $V$ be a finite-dimensional $FF$-vector space, and let $alpha in scr(L)(V, V)$. Fix a basis $B$ for $V$. The trace of $alpha$ is defined as
  $
    tr alpha = tr ([alpha]^B_B)
  $
]

#proposition[
  Trace of a linear map is independent of the choice of basis $B$.
]

#proof[
  If $B'$ is another basis for $V$, then $[alpha]_B^B$ and $[alpha]_B'^B'$ are similar matrices and hence have the same trace by @cor-similar-matrices-same-tr.
]
