#import "../prelude.typ": *

#lecture-separator(lecture: 9, date: "2025-10-28")

= Matrices

== Linear Maps

#definition[Linear map][
  For two #ponder("linear-algebra.vector-space")[vector spaces] $V$ and $W$, a #ponder("linear-algebra.linear-map")[*linear map*] is a function
  $ T: V->W $
  such that
  $ T(lambda vb(x) + mu vb(y)) = lambda T(vb(x)) + mu T(vb(y)) $
  for all $vb(x), vb(y) in V$ and all scalars $lambda, mu$.
] <def-linear-map>

#definition[
  Let $T: V-> W$ be a #ponder("linear-algebra.linear-map")[linear map].

  - The #ponder("linear-algebra.kernel-image")[*image*] of $vb(x) in V$ under $T$ is the vector $vb(x')= T(vb(x)) in W$.

    The #ponder("linear-algebra.kernel-image")[*image*] of $T$ is the set
    $ im T = { vb(x') in W: vb(x') = T(vb(x)) "for some" vb(x) in V}. $

    It forms a #ponder("linear-algebra.subspace")[subspace] of $W$.

  - If $vb(x) in V$ such that $T(vb(x)) = vb(0)$, then $vb(x)$ is in the #ponder("linear-algebra.kernel-image")[*kernel*] of $T$.

    The #ponder("linear-algebra.kernel-image")[*kernel*] of $T$ is the set
    $ ker T = { vb(x) in V: T(vb(x)) = vb(0) }. $

    It forms a #ponder("linear-algebra.subspace")[subspace] of $V$.

  - For $T: V -> W$, $V$ is called the *domain* of $T$ and $W$ the *codomain* of $T$.

  - The #ponder("linear-algebra.dimension")[dimension] of the image of $T$, $dim(im T)$, is called the #ponder("linear-algebra.kernel-image")[*rank*] of $T$, denoted $rank(T)$.

  - The #ponder("linear-algebra.dimension")[dimension] of the kernel of $T$, $dim(ker T)$, is called the #ponder("linear-algebra.kernel-image")[*nullity*] of $T$, denoted $null(T)$.
] <def-kernel-image>

#remark[
  For $T: V->W$, we have
  $ dim (ker T) <= dim V, quad dim(im T) <= dim W. $
]

#example[
  1. The *zero linear map* $T: V-> W$ is defined by $T(vb(x)) = vb(0)$ for all $vb(x) in V$.

    It has $im T = {vb(0)}$ and $ker T = V$.

  2. The #ponder("set-theory.identity-function")[*identity map*] $T:V->V$ is defined by $T(vb(x)) = vb(x)$ for all $vb(x) in V$.

    It has $im T = V$ and $ker T = {vb(0)}$.

  3. Consider $V=W=RR^2$ and $T(vb(x))= vb(x')$, with
    $
      x'_1 & = 2x_1 + x_2 \
      x'_2 & = x_1 - 4x_2.
    $
    This is a #ponder("linear-algebra.linear-map")[linear map]. In this case, $im T = {lambda vec(2, 1) + mu vec(1, -4): lambda, mu in RR} = RR^2$ and $ker T = {vb(0)}$.
]

We can carry out several operations on linear maps.

- *Linear combination*

  Let $T, S: V->W$ be #ponder("linear-algebra.linear-map")[linear maps]. Then,
  $ alpha T + beta S: V->W $
  is still a linear map, defined by
  $ (alpha T + beta S)(vb(x)) = alpha T(vb(x)) + beta S(vb(x)) $
  for all $vb(x) in V$ and all scalars $alpha, beta$.

- *Composition*

  Let $T: V->W$, $S:U->V$ be #ponder("linear-algebra.linear-map")[linear maps]. Then,
  $
    T compose S: U->W
  $
  is still a linear map, defined by
  $ (T compose S)(vb(x)) = T(S(vb(x))) $
  for all $vb(x) in U$.

#theorem[Rank-Nullity Theorem][
  Let $T: V->W$ be a #ponder("linear-algebra.rank-nullity-theorem")[linear map], where $V$ is finite-dimensional. Then,
  $ dim V = rank T + null T. $
] <thm-rank-nullity>

#proof[
  Let us call $n = dim V$ and $m = null T$. Since $dim (ker T) <= dim V$, we have $m <= n$. We have two cases:

  1. $m = n$. Then, $ker T = V$, so $T$ is the zero map. Thus, $im T = {vb(0)}$ and $rank T = 0$. Therefore, $dim V = n = 0 + n = rank T + null T$.

  2. $m < n$. Then let ${vb(e_1), ..., vb(e_m)} subset.eq V$ be a #ponder("linear-algebra.basis")[basis] of $ker T$. Then, $T(vb(e_i)) = vb(0)$ for all $i$.

    We can extend ${vb(e_1), ..., vb(e_m)}$ to the #ponder("linear-algebra.basis")[basis] of the whole $V$:
    $ {vb(e_1), ..., vb(e_m), vb(e_(m+1)), ..., vb(e_n)}. $
    We need to show that  ${T(vb(e_(m+1))) , ..., T(vb(e_n))}$ is a #ponder("linear-algebra.basis")[basis] of $im T$.

    - #ponder("linear-algebra.spanning-set")[*Spanning*.] To show that ${T(vb(e_(m+1))) , ..., T(vb(e_n))}$ #ponder("linear-algebra.spanning-set")[spans] $im T$, take $y in im T$. Then $exists vb(x) in V$ such that

      $ T(vb(x)) = y. $

      Since $vb(x) in V$, we can write
      $ vb(x) = sum_(i=1)^n alpha_i vb(e_i) $

      for some scalars $alpha_1, ..., alpha_n$. Thus,

      $
        y = T(vb(x)) = T(sum_(i=1)^n alpha_i vb(e_i)) = sum_(i=1)^n alpha_i T(vb(e_i)) = sum_(i=m+1)^n alpha_i T(vb(e_i)).
      $

      Therefore, $y$ is in the #ponder("linear-algebra.span")[span] of ${T(vb(e_(m+1))) , ..., T(vb(e_n))}$.

    - #ponder("linear-algebra.linear-independence")[*Linear independence*.] To show that ${T(vb(e_(m+1))) , ..., T(vb(e_n))}$ is #ponder("linear-algebra.linear-independence")[linearly independent], suppose that
      $ sum_(i=m+1)^n alpha_i T(vb(e_i)) = vb(0) $
      for some scalars $alpha_(m+1), ..., alpha_n$. Then, by linearity of $T$, we can write
      $ T(underbracket(sum_(i=m+1)^n alpha_i vb(e_i), vb(x))) = vb(0). $
      Thus, $vb(x) in ker T$. Therefore, since we supposed that ${vb(e_1), ..., vb(e_m)}$ is a #ponder("linear-algebra.basis")[basis] of $ker T$, we write
      $ vb(x) = sum_(i=1)^m beta_i vb(e_i) $
      for some scalars $beta_1, ..., beta_m$. But since ${vb(e_1), ..., vb(e_n)}$ is a #ponder("linear-algebra.basis")[basis] of $V$, the representation of $vb(x)$ is unique. Thus, $alpha_(m+1) = ... = alpha_n = 0$.
]

#example[
  - *Zero linear map.* We have $null T = dim V$ and $rank T = 0$. Then $dim V = dim V + 0$.
  - #ponder("set-theory.identity-function")[*Identity map.*] We have $null T = 0$ and $rank T = dim V$. Then $dim V = 0 + dim V$.
]

== Matrices as Linear Maps

Let $matbold(M)$ be a matrix with entries $M_(i j) in RR$. define

$ T: RR^n -> RR^n $
such that

$ T(vb(x)) = matbold(M) vb(x) = vb(x') quad "for" vb(x), vb(x') in RR^n $

where

$ x'_i = M_(i j)x_j. $

Given $n = 2$, with

$ matbold(M) = mat(M_(11), M_(12); M_(21), M_(22)) $
we have

$
  vec(x'_1, x'_2) = mat(M_(11), M_(12); M_(21), M_(22)) vec(x_1, x_2) = vec(M_(11)x_1 + M_(12)x_2, M_(21)x_1 + M_(22)x_2).
$

Consider $vb(R_i) in RR^n$ the rows, and $vb(C_i) in RR^n$ the columns of $matbold(M)$.

#lecture-separator(lecture: 10, date: "2025-10-30")

#proposition[
  The #ponder("linear-algebra.kernel-image")[image and kernel] of the #ponder("linear-algebra.linear-map")[linear map] $T$ defined by the matrix $matbold(M)$ are given by
  $
    im T = im matbold(M) = span {vb(C_1), ..., vb(C_n)}
  $
  and
  $ ker T = ker matbold(M) = { vb(x) in RR^n: vb(R_i) dot vb(x) = 0 "for all" i = 1, ..., n }. $
] <prop-image-kernel-matrix>

#proof[
  Let us consider the #ponder("linear-algebra.kernel-image")[image and kernel] of $matbold(M)$. The components are related in the following form:

  $
    M_(i j) = (vb(C_j))_i = (vb(R_i))_j .
  $

  If ${vb(e_1), ..., vb(e_n)}$ is the standard #ponder("linear-algebra.basis")[basis] of $RR^n$, then, under $T$,

  $
    vb(e_i) |-> T(vb(e_i)) = matbold(M) vb(e_i) = vb(C_i).
  $

  Since $T$ is a #ponder("linear-algebra.linear-map")[linear map], we can write

  $
    vb(x) = sum_i x_i vb(e_i) |-> T(vb(x)) = sum_i x_i T(vb(e_i)) = sum_i x_i vb(C_i) = x_i vb(C_i).
  $

  Thus, $im T = im matbold(M) = span {vb(C_1), ..., vb(C_n)}$, which is the #ponder("linear-algebra.span")[span] of the columns of $matbold(M)$.


  Now, for the kernel, consider $x'_i = M_(i j)x_j = (vb(R_i))_j x_j = vb(R_i) dot vb(x)$.


  If $vb(x') = vb(0)$, then $vb(R_i) dot vb(x) = 0$ for all $i$. Thus, $ker T = ker matbold(M)$ is the set of vectors #ponder("linear-algebra.orthogonality")[orthogonal] to all the rows of $matbold(M)$.

]

#example[Examples of matrices as linear maps][
  1. *Zero map*. The zero map is defined by taking $matbold(M) = vb(0)$.

  2. #ponder("set-theory.identity-function")[*Identity map*]. The #ponder("set-theory.identity-function")[identity map] is defined by taking $matbold(M) = matbold(I)$, where $matbold(I)$ is the identity matrix.

  3. Consider the map $T: V->W$ where $vb(x') = T(vb(x)) = matbold(M) vb(x)$. Let $T$ be defined by

    $
      cases(
        x'_1 = 3x_1 + x_2 + 5x_3,
        x'_2 = -x_1 - 2x_3,
        x'_3 = 2x_1 + x_2 + 3x_3
      )
    $

    then, the matrix associated to $T$ is
    $
      matbold(M) = mat(3, 1, 5; -1, 0, -2; 2, 1, 3).
    $
    with columns
    $
      vb(C_1) = vec(3, -1, 2), vb(C_2) = vec(1, 0, 1), vb(C_3) = vec(5, -2, 3).
    $
    and rows
    $
      vb(R_1) = vec(3, 1, 5), vb(R_2) = vec(-1, 0, -2), vb(R_3) = vec(2, 1, 3).
    $
    Hence, the #ponder("linear-algebra.kernel-image")[image and kernel] of the #ponder("linear-algebra.linear-map")[linear map] $T$ are given by
    $
      im T = im matbold(M) = span {vb(C_1), vb(C_2), vb(C_3)} = span {vb(C_1), vb(C_2)} => rank(T) = 2,
    $
    because we have that $vec(5, -2, 3) = 2 vec(3, -1, 2) - vec(1, 0, 1)$.

    Then, for the #ponder("linear-algebra.kernel-image")[kernel], we need

    $
      vb(R_2) times vb(R_3) = mdet(vb(i), vb(j), vb(k); -1, 0, -2; 2, 1, 3) = vec(0 - (-2), 3 + (-4), -1 - 0) = vec(2, -1, -1).
    $

    Hence $ ker T = ker matbold(M) = span {vec(2, -1, -1)}. $
] <ex-image-kernel-matrix>

== Geometric examples in $RR^2$ and $RR^3$

=== In $RR^2$

1. #ponder("geometry.rotation")[*Rotations.*]

  Consider $theta$ such that $-pi < theta <= pi$. Then, a #ponder("geometry.rotation")[rotation] by an angle $theta$ about the origin in $RR^2$ is given by the matrix
  $ matbold("Rot")(theta) = rot2mat(theta). $

  Note that $det matbold("Rot")(theta) = cos^2(theta) + sin^2(theta) = 1$.

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d5e1.svg", width: 14em)
  ]

2. #ponder("geometry.reflection")[*Reflections.*]

  Consider $theta$ with $-pi < theta <= pi$. Then, a #ponder("geometry.reflection")[reflection] of angle $(theta)/(2)$ in $RR^2$is given by the matrix
  $ matbold("Ref")(theta) = mat(cos theta, sin theta; sin theta, -cos theta). $

  Note that $det matbold("Ref")(theta) = - (cos^2(theta) + sin^2(theta)) = -1$.

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d5e2.svg", width: 14em)
  ]

#proposition[Properties of rotations and reflections][

  // todo: check these. The lecturer struggled here.

  - $matbold("Rot")(theta) matbold("Rot")(phi) = matbold("Rot")(theta + phi)$

  - $matbold("Ref")(theta) matbold("Ref")(phi) = matbold("Rot")(theta - phi)$

  - $matbold("Rot")(theta) matbold("Ref")(2 phi) = matbold("Ref")(2 phi + theta)$

  - $matbold("Ref")(2 theta) matbold("Rot")(phi) = matbold("Ref")(2 theta - phi)$
]

=== In $RR^3$

1. #ponder("geometry.rotation")[*Rotations.*]

  - Consider a #ponder("geometry.rotation")[rotation] by an angle $theta$ about axis $vb(e_3)$. This is given by the matrix
    $
      matbold("Rot")(theta) = rot3zmat(theta).
    $

  - Consider a #ponder("geometry.rotation")[rotation] by an angle $theta$ about the #ponder("linear-algebra.unit-vector")[unit vector] $vb(n)$. In this case, we have
    $ vb(x') = matbold(R) vb(x) $
    where $vb(x) in RR^3$ and $x'_i = R_(i j) x_j$.

    Then,

    $
      vb(x') = (cos theta) vb(x) + (1- cos theta) (vb(n) dot vb(x)) vb(n) + (sin theta) vb(n) times vb(x)
    $
    or equivalently,
    $
      R_(i j) = (cos theta) delta_(i j) + (1 - cos theta) n_i n_j - (sin theta) epsilon_(i j k) n_k.
    $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d5e3.svg", width: 14em)
  ]

  This can be derived by decomposing $vb(x)$ into components #ponder("linear-algebra.parallel-vectors")[parallel] and #ponder("linear-algebra.orthogonality")[perpendicular] to $vb(n)$, and then rotating the #ponder("linear-algebra.orthogonality")[perpendicular] component in the plane #ponder("linear-algebra.orthogonality")[orthogonal] to $vb(n)$.

  $ vb(x) = vb(x_parallel) + vb(x_perp) $

  with

  $
    vb(x_parallel) & = (vb(n) dot vb(x)) vb(n), \
        vb(x_perp) & = vb(x) - vb(x_parallel).
  $

  After applying $matbold(R)$, we have

  $
    vb(x'_parallel) = vb(x_parallel), \
    vb(x'_perp) = (cos theta) vb(x_perp) + (sin theta) vb(n) times vb(x_perp).
  $


  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d5e4.svg", width: 14em)
  ]

2. #ponder("geometry.reflection")[*Reflections.*]

  #ponder("geometry.reflection")[Reflections] in a plane through the origin with normal #ponder("linear-algebra.unit-vector")[unit vector] $vb(n)$ are given by
  $
    vb(x') = matbold(H)vb(x) = vb(x) - 2 (vb(n) dot vb(x)) vb(n).
  $

  Thus we have
  $
    vb(x')_i = H_(i j) x_j,
  $
  where

  $
    H_(i j) = delta_(i j) - 2 n_i n_j.
  $

#lecture-separator(lecture: 11, date: "2025-11-01")

3. *Dilations.*

  Dilations from the origin with scale factor $lambda$ are given by
  $
    vb(x') = matbold(D)(lambda) vb(x) = lambda vb(x).
  $

  Thus, we have
  $
    vb(x')_i = D_(i j)(lambda) x_j,
  $
  where

  $
    D_(i j)(lambda) = lambda delta_(i j).
  $

4. *Shears.*

  Given $a, b$ with $abs(a) = abs(b) = 1$ and such that $vb(a) dot vb(b) = 0$, a shear with parameter $lambda$ is defined by

  $
    vb(x') = matbold(S)(lambda) vb(x) = vb(x) + lambda (vb(x) dot vb(a)) vb(b).
  $
  Thus, we have

  $
    vb(x')_i = S_(i j)(lambda) x_j,
  $
  where
  $
    S_(i j)(lambda) = delta_(i j) + lambda b_i a_j.
  $

== Matrices in General

=== Definitions

#definition[Matrix][
  Consider a #ponder("linear-algebra.linear-map")[linear map] $T: V-> W$, with $dim V = n$ and $dim W = m$, and take two #ponder("linear-algebra.basis")[bases] ${vb(e_1), ..., vb(e_n)}$ of $V$ and ${vb(f_1), ..., vb(f_m)}$ of $W$.

  Then, $T$ can be represented by $matbold(M)$, which is an $m times n$ array with entries $M_(i j) in RR "or" CC$ for $i = 1, ..., m$ as the rows and $j = 1, ..., n$ as the columns, such that
  $ T(vb(e_j)) = sum_(i=1)^m M_(i j) vb(f_i) $
  for $j = 1, ..., n$.
  This automatically ensures that for any $vb(x) in V$, $vb(x') = T(vb(x))$, we can always write $vb(x')$ and $vb(x)$ in terms of the bases:
  $
    vb(x) = sum_(j=1)^n x_j vb(e_j), quad vb(x') = sum_(i=1)^m x'_i vb(f_i).
  $
  This means that any coefficient from the image can be written as
  $
    x'_i = sum_(j=1)^n M_(i j) x_j.
  $
  To summarise, given $V$ and $W$ which are real or complex #ponder("linear-algebra.vector-space")[vector spaces] with $dim V = n$ and $dim W = m$, and given #ponder("linear-algebra.basis")[bases] ${vb(e_1), ..., vb(e_n)}$ of $V$ and ${vb(f_1), ..., vb(f_m)}$ of $W$, then

  - $V$ is identified with $RR^n$ or $CC^n$.
  - $W$ is identified with $RR^m$ or $CC^m$.
  - We identify the #ponder("linear-algebra.linear-map")[linear map] $T: V->W$ with the matrix $matbold(M)$ such that $vb(x') = matbold(M) vb(x)$.
] <def-matrix-representation>

#remark[
  Consider another #ponder("linear-algebra.linear-map")[linear map] $S: V-> W$ with #ponder("linear-algebra.matrix-representation")[matrix representation] $matbold(N)$ with respect to the same bases. Then, for scalars $alpha, beta$,
  $ alpha T + beta S $
  is represented by matrix
  $ alpha matbold(M) + beta matbold(N) $
  with coefficients
  $ (alpha matbold(M) + beta matbold(N))_(i j) = alpha M_(i j) + beta N_(i j). $

  This is because addition and scalar multiplication in matrices takes place entry-wise.
]

#example[
  Consider $V = M_(2 times 2)(RR)$ and $W = RR^3$. Hence $dim V = 4$ and $dim W = 3$. Consider the map
  $
    T: V-> W quad "with" quad mat(a, b; c, d) |-> vec(a + b, c, d).
  $
  The map is linear. We want to find the #ponder("linear-algebra.matrix-representation")[matrix representation] of $T$ with respect to the #ponder("linear-algebra.basis")[bases]
  $
    { vb(e_1) = mat(1, 0; 0, 0), vb(e_2) = mat(0, 1; 0, 0), vb(e_3) = mat(0, 0; 1, 0), vb(e_4) = mat(0, 0; 0, 1) }
  $
  of $V$ and
  $ { vb(f_1) = vec(1, 0, 0), vb(f_2) = vec(0, 1, 0), vb(f_3) = vec(0, 0, 1) } $
  of $W$.

  To determine $matbold(M)$, we need to compute $T(vb(e_i))$ for $i = 1, ..., 4$:
  $ T(vb(e_1)) = T(mat(1, 0; 0, 0)) = vec(1, 0, 0) $
  $ T(vb(e_2)) = T(mat(0, 1; 0, 0)) = vec(1, 0, 0) $
  $ T(vb(e_3)) = T(mat(0, 0; 1, 0)) = vec(0, 1, 0) $
  $ T(vb(e_4)) = T(mat(0, 0; 0, 1)) = vec(0, 0, 1) $
  Therefore, for $a, b, c, d in RR$,

  $
    T(mat(a, b; c, d)) = a T(vb(e_1)) + b T(vb(e_2)) + c T(vb(e_3)) + d T(vb(e_4)) = a vec(1, 0, 0) + b vec(1, 0, 0) + c vec(0, 1, 0) + d vec(0, 0, 1) = vec(a + b, c, d).
  $
  Thus, the #ponder("linear-algebra.matrix-representation")[matrix representation] of $T$ with respect to the given bases is
  $
    matbold(M) = mat(1, 1, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1).
  $
] <ex-matrix-representation>

=== Matrix Multiplication

Consider #ponder("linear-algebra.linear-map")[linear maps] $T$ and $S$ such that
$
  T: V->W, quad S: U-> V.
$

We wish to #ponder("algebra.function-composition")[compose] them. The #ponder("algebra.function-composition")[composition] is given by
$
  T compose S: U-> W
$
such that
$ (T compose S)(vb(x)) = T(S(vb(x))) $
for all $vb(x) in U$.

If $T$ is represented by the matrix $matbold(M)$ and $S$ is represented by the matrix $matbold(N)$, then $T compose S$ is represented by the matrix $matbold(L)= matbold(M) matbold(N)$.

#lecture-separator(lecture: 12, date: "2025-11-04")

Let

- ${vb(e_1), ..., vb(e_n)}$ be a #ponder("linear-algebra.basis")[basis] of $V$ ($dim V = n$),
- ${vb(f_1), ..., vb(f_m)}$ be a #ponder("linear-algebra.basis")[basis] of $W$ ($dim W = m$),
- ${vb(g_1), ..., vb(g_l)}$ be a #ponder("linear-algebra.basis")[basis] of $U$ ($dim U = l$).

If we consider $T compose S$ so that $T compose S$ is represented by the matrix $matbold(L) = matbold(M)matbold(N)$, with coefficients given by
$ L_(i k) = M_(i j) N_(j k). $

Note that
- $matbold(M)$ is an $m times n$ matrix,
- $matbold(N)$ is an $n times l$ matrix,
- $matbold(L)$ is an $m times l$ matrix.

#remark[
  1. The number of columns of $matbold(M)$ must equal the number of rows of $matbold(N)$ for the product $matbold(M) matbold(N)$ to be defined.
  2. $matbold(L)$ has the same number of rows as $matbold(M)$ and the same number of columns as $matbold(N)$.
]

We can also write
$
  L_(i k) & = (matbold(M)matbold(N))_(i k) \
          & = [ vb(R_i) (matbold(M))]_j [ vb(C_k) (matbold(N)) ]_j \
          & = vb(R_i) (matbold(M)) dot vb(C_k) (matbold(N)) .
$

If we apply $matbold(M) matbold(N)$ to a $vb(x) in U$, we obtain

$
  (matbold(M)matbold(N))vb(x) = matbold(M)(matbold(N) vb(x))
$
with
$
  [matbold(M)(matbold(N)vb(x))]_i = M_(i j) [matbold(N) vb(x)]_j
$
and Thus
$
  (matbold(M)matbold(N))_(i k) x_k = M_(i j) N_(j k) x_k.
$

#proposition[Matrix properties][
  For any three matrices $matbold(L), matbold(M), matbold(N)$ such that the products below are defined, and for any scalars $lambda, mu$,

  - $(lambda matbold(M) + mu matbold(N))matbold(L) = lambda (matbold(M) matbold(L)) + mu (matbold(N) matbold(L))$

  - $matbold(L)(lambda matbold(M) + mu matbold(N)) = lambda (matbold(L) matbold(M)) + mu (matbold(L) matbold(N))$

  - $matbold(M)(matbold(N) matbold(L)) = (matbold(M) matbold(N)) matbold(L)$.
]

=== Matrix Inverses

Consider three matrices $vb(M), vb(N), vb(L)$, satisfying

- The size of $matbold(N)$ is $m times n$,
- The size of $matbold(M)$ is $n times m$,
- The size of $matbold(L)$ is $n times m$.

We say that $matbold(L)$ is a *left inverse* of $matbold(N)$ if
$ matbold(L) matbold(N) = matbold(I)_(n) $
where $matbold(I)$ is the identity matrix of size $n times n$.

We say that $matbold(M)$ is a *right inverse* of $matbold(N)$ if
$ matbold(N) matbold(M) = matbold(I)_(m). $

If $matbold(N)$ is a square matrix (i.e., $m = n$), then
$
  matbold(L) = matbold(L) (matbold(N M)) = (matbold(L N)) matbold(M) = matbold(M),
$
so the left and right inverses coincide. In this case, we say that $matbold(N)$ is #ponder("algebra.matrix-invertibility")[*invertible*] (or *non-singular*) and we denote its inverse by $matbold(N)^(-1)$.

#remark[
  If $matbold(N)$ has an inverse, then $matbold(N)$ is a square matrix.

  Not all square matrices are #ponder("algebra.matrix-invertibility")[invertible]. For example, the zero matrix is not #ponder("algebra.matrix-invertibility")[invertible].
]

#proposition[
  For two #ponder("algebra.matrix-invertibility")[invertible] matrices $matbold(M)$ and $matbold(N)$ of the same size,
  $ (matbold(M)matbold(N))^(-1) = matbold(N)^(-1) matbold(M)^(-1). $
]

#proof[
  $
    (matbold(N)^(-1) matbold(M)^(-1))(matbold(M) matbold(N)) = matbold(N)^(-1) (matbold(M)^(-1) matbold(M)) matbold(N) = matbold(N)^(-1) matbold(I) matbold(N) = matbold(N)^(-1) matbold(N) = matbold(I).
  $
]

#example[
  1. #ponder("geometry.rotation")[*Rotation.*] For $matbold("Rot")(theta, vb(n))$, we have
    $ matbold("Rot")(theta, vb(n))^(-1) = matbold("Rot")(-theta, vb(n)). $
  2. *Shear.* Fix $vb(a), vb(b)$. Then, for $matbold(S)(lambda)$, we have
    $ matbold(S)(lambda)^(-1) = matbold(S)(-lambda). $
  3. #ponder("geometry.reflection")[*Reflection.*] If $matbold(H)$ is a #ponder("geometry.reflection")[reflection] in a plane with normal $vb(n)$, then
    $ matbold(H)^(-1) = matbold(H). $
]

=== Transpose and Hermitian Conjugate

#definition[Transpose][
  Consider a matrix $matbold(M)$ of size $m times n$. Then, the #ponder("linear-algebra.transpose")[*transpose*] of $matbold(M)$ is the matrix $matbold(M)^TT$ of size $n times m$ with entries
  $ (matbold(M)^TT)_(i j) = M_(j i). $
] <def-transpose>

#proposition[Properties of the transpose][
  1. $(matbold(M)^TT)^TT = matbold(M)$
  2. If $vb(x)$ is a column vector $vec(x_1, dots.v, x_n)$, then $vb(x)^TT$ is the row vector $mat(x_1, dots.c, x_n)$.
  3. $(matbold(M) matbold(N))^TT = matbold(N)^TT matbold(M)^TT$
  4. $(alpha matbold(M) + beta matbold(N))^TT = alpha matbold(M)^TT + beta matbold(N)^TT$
] <prop-transpose-properties>

#definition[Symmetric and antisymmetric matrices][
  If $matbold(M)$ is a square matrix, then $matbold(M)$ is

  - #ponder("linear-algebra.symmetric-matrix")[*symmetric*] if $matbold(M)^TT = matbold(M)$,
  - #ponder("linear-algebra.symmetric-matrix")[*antisymmetric*] if $matbold(M)^TT = - matbold(M)$
] <def-symmetric-antisymmetric-matrices>

#definition[Hermitian conjugate][
  Consider a matrix $matbold(M)$ of size $m times n$ with complex entries. Then, the #ponder("linear-algebra.hermitian-conjugate")[*Hermitian conjugate*] of $matbold(M)$ is the matrix $matbold(M)^dagger$ of size $n times m$
  $ matbold(M)^dagger = overline(matbold(M)^TT) $
  with entries
  $ (matbold(M)^dagger)_(i j) = overline(M_(j i)) $
  where $overline(z)$ denotes the complex conjugate of $z in CC$.
] <def-hermitian-conjugate>

#proposition[Properties of the Hermitian conjugate][
  1. $(alpha matbold(M) + beta matbold(N))^dagger = overline(alpha) matbold(M)^dagger + overline(beta) matbold(N)^dagger$
  2. $(matbold(M) matbold(N))^dagger = matbold(N)^dagger matbold(M)^dagger$
] <prop-hermitian-conjugate-properties>

#definition[Hermitian and anti-Hermitian matrices][
  If $matbold(M)$ is a square, then $matbold(M)$ is

  - #ponder("linear-algebra.hermitian-matrix")[*Hermitian*] if $matbold(M)^dagger = matbold(M)$, _i.e._ $M_(i j) = overline(M_(j i))$ for all $i, j$,
  - #ponder("linear-algebra.hermitian-matrix")[*anti-Hermitian*] (or *skew-Hermitian*) if $matbold(M)^dagger = - matbold(M)$, _i.e._ $M_(i j) = - overline(M_(j i))$ for all $i, j$.
] <def-hermitian-anti-hermitian>

=== Trace

#definition[Trace][
  Consider any $n times n$ matrix $matbold(M)$, the #ponder("linear-algebra.trace")[trace] is defined by
  $ tr(matbold(M)) = M_(i i). $
  _i.e._ the sum of the diagonal entries.
] <def-trace>

#proposition[Properties of the trace][
  1. $tr(alpha matbold(M) + beta matbold(N)) = alpha tr(matbold(M)) + beta tr(matbold(N))$
  2. $tr(matbold(M) matbold(N)) = tr(matbold(N) matbold(M))$
  3. $tr(matbold(M)^TT) = tr(matbold(M))$
  4. $tr(matbold(I))=n$ for the identity matrix of size $n times n$.
] <prop-trace-properties>

=== Decomposition of $n times n$ Matrices

Any $n times n$ matrix is a sum of #ponder("linear-algebra.symmetric-matrix")[symmetric and antisymmetric parts]. For a matrix $matbold(M)$ that is square with real entries, we can write $matbold(M)$ as $matbold(S) + matbold(A)$, where

$ matbold(S) = (1)/(2) (matbold(M) + matbold(M)^TT) $

is the #ponder("linear-algebra.symmetric-matrix")[symmetric part] and

$ matbold(A) = (1)/(2) (matbold(M) - matbold(M)^TT) $

is the #ponder("linear-algebra.symmetric-matrix")[antisymmetric part].

The #ponder("linear-algebra.symmetric-matrix")[symmetric part] can be further decomposed:
$ matbold(T) = matbold(S) - (1)/(n) tr(matbold(S)) matbold(I) $

Note that $tr(matbold(T)) = 0$, and we call $matbold(T)$ to be #ponder("linear-algebra.trace")[traceless]. Noting that $tr(matbold(S)) = tr(matbold(M))$ and $tr(matbold(A)) = 0$, we can write

$
  matbold(M) = underbracket(matbold(T), "symmetric"\ "traceless") + underbracket((1)/(n) tr(matbold(M)) matbold(I), "isotropic part") +underbracket(matbold(A), "antisymmetric part").
$

#lecture-separator(lecture: 13, date: "2025-11-06")

=== Orthogonal and Unitary Matrices

#definition[Orthogonal matrix][
  A real $n times n$ matrix $matbold(U)$ is #ponder("algebra.orthogonal-group")[*orthogonal*] if and only if
  $ matbold(U)^TT matbold(U) = matbold(U) matbold(U)^TT = matbold(I) $
  or equivalently,
  $ matbold(U)^TT = matbold(U)^(-1). $
  This means that columns and rows of $matbold(U)$ are #ponder("linear-algebra.orthonormal")[orthonormal] vectors. Equivalently, $matbold(U)$ is #ponder("algebra.orthogonal-group")[orthogonal] if and only if $matbold(U)$ #ponder("algebra.orthogonal-dot-product")[preserves the dot product], _i.e._ for all $vb(x), vb(y) in RR^n$,
  $ (matbold(U) vb(x)) dot (matbold(U) vb(y)) = vb(x) dot vb(y), $
  and in this cases, $matbold(U)$ preserves lengths and angles.
]

#definition[Unitary matrix][
  A complex $n times n$ matrix $matbold(U)$ is #ponder("linear-algebra.unitary-matrix")[*unitary*] if and only if
  $ matbold(U)^dagger matbold(U) = matbold(U) matbold(U)^dagger = matbold(I) $
  or equivalently,
  $ matbold(U)^dagger = matbold(U)^(-1). $
  Equivalently, $matbold(U)$ is #ponder("linear-algebra.unitary-matrix")[unitary] iff it preserves the complex #ponder("linear-algebra.inner-product")[inner product], _i.e._ for all $vb(x), vb(y) in CC^n$,
  $ (matbold(U) vb(x))^dagger (matbold(U) vb(y)) = vb(x)^dagger vb(y), $
  and in this cases, $matbold(U)$ preserves lengths and angles.
] <def-unitary-matrix>

#example[
  In $2times 2$, consider $matbold(U)$ as an #ponder("algebra.orthogonal-group")[orthogonal matrix]. Consider the #ponder("linear-algebra.basis")[basis]
  $
    {vec(1, 0), vec(0, 1)}.
  $

  - $matbold(U)$ preserves norms

  $
    matbold(U) vec(1, 0) = vec(cos theta, sin theta) quad "for" theta in RR
  $

  - $matbold(U)$ preserves angles, in particular, #ponder("linear-algebra.orthogonality")[orthogonality]

  $
    matbold(U) vec(0, 1) = plus.minus vec(-sin theta, cos theta) quad "for" theta in RR
  $

  Thus, we have either
  $ matbold(U) = matbold("Rot")(theta) = rot2mat(theta) $
  or
  $ matbold(U) = matbold("Ref")(theta) = mat(cos theta, sin theta; sin theta, -cos theta). $
]

== Determinant

Consider a map $RR^n -> RR^n$ given by a real $n times n$ matrix $matbold(M)$, where
$ vb(x') = matbold(M) vb(x) $
for all $vb(x) in RR^n$.

Assume that $matbold(M^(-1))$ exists, then
$ vb(x) = matbold(M^(-1)) vb(x'). $

=== In $RR^2$

Consider $matbold(M) = mat(M_(11), M_(12); M_(21), M_(22))$, and let $matbold(tilde(M)) = mat(M_(22), -M_(12); -M_(21), M_(11))$. Then,

$
  vb(x') = matbold(M) vb(x) quad => quad matbold(tilde(M)) vb(x') = matbold(M) matbold(tilde(M)) vb(x)= det(matbold(M)) vb(x).
$

with $det matbold(M) = M_(11) M_(22) - M_(12) M_(21).$

Note that $det matbold(M) = [matbold(M) vb(e_1), matbold(M) vb(e_2)]$.

Therefore, if $det matbold(M) != 0$, then $matbold(M^(-1)) = (1)/(det matbold(M)) matbold(tilde(M))$.

=== In $RR^3$

We shall attempt to generalise our construction of the $det matbold(M)$ to $RR^3$. Take $matbold(x) |-> matbold(x') = matbold(M) vb(x)$ where $matbold(M)$ is a $3 times 3$ matrix with real entries. We seek a matrix $matbold(tilde(M))$ and a scalar $det matbold(M)$ such that
$ matbold(tilde(M)) matbold(M) = (det matbold(M)) matbold(I). $

We call this scalar $det matbold(M)$ the #ponder("linear-algebra.determinant")[*determinant*] of $matbold(M)$.

Recall that the #ponder("linear-algebra.scalar-triple-product")[scalar triple product] of three vectors $vb(a), vb(b), vb(c) in RR^3$ is defined by
$ [vb(a), vb(b), vb(c)] = vb(a) dot (vb(b) times vb(c)) = epsilon_(i j k) a_i b_j c_k $
which describes the volume of the parallelepiped formed by the three vectors.

Under the action of a $3 times 3$ matrix $matbold(M)$, volumes are scaled by a factor $det matbold(M)$, where
$
  [matbold(M) vb(e_1), matbold(M) vb(e_2), matbold(M) vb(e_3)] &= [vb(C_1)(matbold(M)) , vb(C_2)(matbold(M)), vb(C_3)(matbold(M))]\
  &= [M_(i 1) matbold(e_i), M_(j 2) matbold(e_j), M_(k 3) matbold(e_k)] \
  &=M_(i 1) M_(j 2) M_(k 3) [vb(e_i), vb(e_j), vb(e_k)] \
  &= epsilon_(i j k) M_(i 1) M_(j 2) M_(k 3)\
  &=: det matbold(M).
$

Thus, in $RR^3$, the #ponder("linear-algebra.determinant")[determinant] of a matrix $matbold(M)$ is given by
$ det matbold(M) = epsilon_(i j k) M_(i 1) M_(j 2) M_(k 3). $

To construct $matbold(tilde(M))$, note
$
  vb(R_1)(matbold(tilde(M))) & = vb(C_2)(matbold(M)) times vb(C_3)(matbold(M)) \
  vb(R_2)(matbold(tilde(M))) & = vb(C_3)(matbold(M)) times vb(C_1)(matbold(M)) \
  vb(R_3)(matbold(tilde(M))) & = vb(C_1)(matbold(M)) times vb(C_2)(matbold(M))
$
so that
$
  vb(R_i)(matbold(tilde(M))) dot vb(C_j)(matbold(M)) = matbold(C_1)(matbold(M)) dot (matbold(C_2)(matbold(M)) times matbold(C_3)(matbold(M))) delta_(i j).
$

Thus,
$ (matbold(tilde(M)) matbold(M))_(i j) = (det matbold(M)) delta_(i j). $

And hence $det matbold(M) != 0$ iff ${matbold(M) vb(e_1), matbold(M) vb(e_2), matbold(M) vb(e_3)}$ is #ponder("linear-algebra.linear-independence")[linearly independent]. This is equivalent to saying $im(matbold(M)) = RR^3$, or that $rank(matbold(M)) = 3$.

#remark[
  General $3times 3$ #ponder("linear-algebra.determinant")[determinants] can be expanded in terms of $2times 2$ #ponder("linear-algebra.determinant")[determinants]. For example,
  $
    mat(
      delim: "|", M_(11), M_(12), M_(13);
      M_(21), M_(22), M_(23);
      M_(31), M_(32), M_(33)
    ) = M_(11) mdet(M_(22), M_(23); M_(32), M_(33)) - M_(12) mdet(M_(21), M_(23); M_(31), M_(33)) + M_(13) mdet(M_(21), M_(22); M_(31), M_(32)).
  $
]

=== Permutations

Our goal is to generalise the #ponder("linear-algebra.levi-civita-symbol")[Levi-Civita symbol] to $n$ dimensions to define the #ponder("linear-algebra.determinant")[determinant] of an $n times n$ matrix.

#definition[Permutation][
  A #ponder("algebra.permutation")[*permutation*] of a set $S$ is a #ponder("algebra.bijection")[bijection] $epsilon: S->S$.
]

#notation[
  We write $S_n$ to be the set of all #ponder("algebra.permutation")[permutations] of the set ${1, 2, ..., n}$. Note that $abs(S_n) = n!$.
]

Consider $rho in S_n$ with
$
  mat(
    1, 2, ..., n;
    rho(1), rho(2), ..., rho(n)
  )
$

#definition[Fixed point][
  A #ponder("algebra.fixed-point")[*fixed point*] of a #ponder("algebra.permutation")[permutation] $rho in S_n$ is an element $i in {1, ..., n}$ such that $rho(i) = i$. We normally omit #ponder("algebra.fixed-point")[fixed points] when writing #ponder("algebra.permutation")[permutations].
]

#definition[Disjoint permutations][
  #ponder("algebra.permutation")[Two permutations] are #ponder("algebra.disjoint-cycles")[*disjoint*] if members moved by one #ponder("algebra.permutation")[permutation] are not moved by the other, _i.e._ they have no common elements that are not #ponder("algebra.fixed-point")[fixed points].
]

#example[
  We can write
  $
    rho & = mat(
            1, 2, 3, 4, 5, 6;
            5, 6, 3, 1, 4, 2
          ) \
        & = mat(1, 2, 4, 5, 6; 5, 6, 1, 4, 2) \
        & = mat(1, 4, 5; 5, 1, 4) mat(2, 6; 6, 2) \
        & = mat(5, 4, 1) mat(6, 2)
  $
  where $mat(5, 4, 1)$ and $mat(6, 2)$ are called #ponder("algebra.cycle")[cycles].
]

Note that #ponder("algebra.disjoint-cycles")[disjoint permutations] commute, but in general #ponder("algebra.permutation")[permutations] do not commute.

#definition[Transposition][
  A #ponder("algebra.transposition")[*transposition*] is a 2-cycle.
]

#proposition[
  Any $q$-cycle can be written as a product of 2-cycles.
]

#proof[
  This is because we can write
  $
    mat(1, 2, ..., n) = mat(1, 2) mat(2, 3) ... mat(n-1, n).
  $
]

#definition[Sign of permutation][
  The #ponder("algebra.permutation-parity")[*sign*] of a #ponder("algebra.permutation")[permutation] $rho$ is defined by
  $
    epsilon(rho) = (-1)^r
  $
  where $r$ is the number of #ponder("algebra.transposition")[2-cycles] of $rho$ when written as a product of $2$-cycles.

  In particular, if $epsilon(rho) = 1$, then $rho$ is an #ponder("algebra.permutation-parity")[*even*] #ponder("algebra.permutation")[permutation], and if $epsilon(rho) = -1$, then $rho$ is an #ponder("algebra.permutation-parity")[*odd*] #ponder("algebra.permutation")[permutation].
]

#remark[
  $epsilon(rho sigma) = epsilon(rho) epsilon(sigma)$ and $epsilon(rho^(-1)) = epsilon(rho).$
]

#definition[Levi-Civita symbol][
  The #ponder("linear-algebra.levi-civita-symbol")[*Levi-Civita symbol*] in $n$ dimensions is defined by
  $
    epsilon_(i_1 i_2 ... i_n) = cases(
      +1 quad & "if" (i_1\, i_2\, ...\, i_n) "is an even permutation of" (1\, 2\, ...\, n),
      -1 & "if" (i_1\, i_2\, ...\, i_n) "is an odd permutation of" (1\, 2\, ...\, n),
      0 & "if any two indices are equal"
    )
  $
  It is totally antisymmetric.
]

#lecture-separator(lecture: 14, date: "2025-11-08")

=== Alternating Forms

#definition[Alternating form][
  For vectors $vb(v_1), ..., vb(v_n)$ in $RR^n$ or $CC^n$, the rank $n$ #ponder("linear-algebra.alternating-form")[*alternating form*] is defined by
  $
    [vb(v_1), ..., vb(v_n)] & = epsilon_(j_1, ..., j_n) (v_1)_(j 1) (v_2)_(j 2) ... (v_n)_(j n) \
                                & = sum_rho epsilon(rho) (v_1)_(rho(1)) (v_2)_(rho(2)) ... (v_n)_(rho(n))
  $
] <def-alternating-form>

#proposition[Properties of alternating forms][
  1. $[vb(v_1), ..., vb(v_n)]$ is multilinear in its arguments. _i.e._

    $
      [vb(v_1), ..., alpha vb(v_i) + beta vb(u_i), ..., vb(v_n)] = alpha [vb(v_1), ..., vb(v_i), ..., vb(v_n)] + beta [vb(v_1), ..., vb(u_i), ..., vb(v_n)]
    $

  2. It is #ponder("linear-algebra.alternating-form")[totally antisymmetric]: $[vb(v_1), ..., vb(v_i), ..., vb(v_j), ..., vb(v_n)] = - [vb(v_1), ..., vb(v_j), ..., vb(v_i), ..., vb(v_n)]$ for all $i != j$.

    Alternatively, $[vb(v_(rho(1))), ..., vb(v_(rho(n)))] = epsilon(rho) [vb(v_1), ..., vb(v_n)]$ for any permutation $rho$.
  3. $[vb(e_1), ..., vb(e_n)] = 1$.


  #remark[
    Properties (1) (2) (3) uniquely define the #ponder("linear-algebra.alternating-form")[alternating forms]. Note that exchanging two vectors changes the sign of the #ponder("linear-algebra.alternating-form")[alternating form], so if any two vectors are equal, the #ponder("linear-algebra.alternating-form")[alternating form] is zero.
  ]

  4. If $vb(v_p) = vb(v_q)$ for some $p != q$, then $[vb(v_1), ..., vb(v_n)] = 0$. #fade[[Follows from (2).]]

  5. If $vb(v_p) = sum_(i != p) lambda_i vb(v_i)$ for some scalars $lambda_i$, then $[vb(v_1), ..., vb(v_n)] = 0$.  #fade[[Follows from (1) and (4).]]
] <prop-alternating-form-properties>

#proposition[
  $
    [vb(v_1), ..., vb(v_n)] != 0 <=> {vb(v_1), ..., vb(v_n)} "is linearly independent."
  $
] <prop-alternating-independence>

#proof[

  #fade[[$=>$]] If the vectors are #ponder("linear-algebra.linear-independence")[linearly dependent], then one of them can be written as a #ponder("linear-algebra.linear-combination")[linear combination] of the others. By property (5), the #ponder("linear-algebra.alternating-form")[alternating form] is zero.

  #fade[[$arrow.double.l$]] If the vectors are #ponder("linear-algebra.linear-independence")[linearly independent], then they #ponder("linear-algebra.spanning-set")[span] $RR^n$ or $CC^n$. In particular, for some matrix $matbold(U)$, we can write
  $
    e_j = U_(i j) vb(v_i).
  $
  Hence,
  $
    [vb(e_1), ..., vb(e_n)] &= U_(i_1 1) U_(i_2 2) ... U_(i_n n) [vb(v_(i_1)), ..., vb(v_(i_n))]\
    &= U_(i_1 1) U_(i_2 2) ... U_(i_n n) epsilon_(i_1 i_2 ... i_n) [vb(v_1), ..., vb(v_n)].
  $

  Since $[vb(e_1), ..., vb(e_n)] = 1$, we have
  $
    [vb(v_1), ..., vb(v_n)] != 0.
  $
]

=== Determinants in $RR^n$ and $CC^n$

#definition[Determinant][
  Consider an $n times n$ matrix $matbold(M)$ with  columns given by
  $ vb(C_i) = matbold(M) vb(e_i). $

  The #ponder("linear-algebra.determinant")[*determinant*] of $matbold(M)$ is defined by
  $
    det matbold(M) & = [vb(C_1), vb(C_2), ..., vb(C_n)] \
                   & = [matbold(M) vb(e_1), matbold(M) vb(e_2), ..., matbold(M) vb(e_n)] \
                   & = epsilon_(i_1 i_2 ... i_n) M_(i_1 1) M_(i_2 2) ... M_(i_n n) \
                   & = sum_rho epsilon(rho) M_(rho(1) 1) M_(rho(2) 2) ... M_(rho(n) n)
  $
  where $epsilon(rho)$ is the #ponder("algebra.permutation-parity")[sign] of the #ponder("algebra.permutation")[permutation] $rho in S_n$.
  We can also write
  $
    det matbold(M) & = mat(
                       delim: "|",
                       M_(11), M_(12), ..., M_(1 n);
                       M_(21), M_(22), ..., M_(2 n);
                       dots.v, , , dots.v;
                       M_(n 1), M_(n 2), ..., M_(n n)
                     )
  $
] <def-determinant>

#proposition[Properties of the determinant][
  1. The #ponder("linear-algebra.determinant")[determinant] is multilinear in the columns of the matrix. In particular, $ det (lambda matbold(M)) = lambda^n det(matbold(M)) $ for any scalar $lambda$ and any $n times n$ matrix $matbold(M)$.

  2. The #ponder("linear-algebra.determinant")[determinant] is #ponder("linear-algebra.alternating-form")[totally antisymmetric] in the columns of the matrix. In particular, if we exchange two columns of $matbold(M)$, then the #ponder("linear-algebra.determinant")[determinant] changes sign.

  3. $det(matbold(I)) = 1$ for the identity matrix of any size $n times n$.

  4. If two rows or two columns of $matbold(M)$ are equal, then $det(matbold(M)) = 0$.

  5. If two rows or two columns of $matbold(M)$ are #ponder("linear-algebra.linear-independence")[linearly dependent], then $det(matbold(M)) = 0$.

  6. $det(matbold(M)) != 0$ if and only if the columns of $matbold(M)$ are #ponder("linear-algebra.linear-independence")[linearly independent].


    As a consequence, under a column operation $vb(C_i) |-> vb(C_i) + lambda vb(C_j)$ for some $j != i$, the #ponder("linear-algebra.determinant")[determinant] is unchanged.

  7. $det(matbold(M)) = det(matbold(M)^TT).$

    Hence, all properties above also hold for rows.

  8. For any two $n times n$ matrices $matbold(M)$ and $matbold(N)$,
    $ det(matbold(M) matbold(N)) = det(matbold(M)) det(matbold(N)). $
    In particular, if $matbold(M)$ is #ponder("algebra.matrix-invertibility")[invertible], then
    $ det(matbold(M^(-1))) = (det(matbold(M)))^(-1). $

  9. If $matbold(M)$ is #ponder("algebra.orthogonal-group")[orthogonal], then $det(matbold(M)) = plus.minus 1$.

  10. If $matbold(M)$ is #ponder("linear-algebra.unitary-matrix")[unitary], then $abs(det(matbold(M))) = 1$.
] <prop-determinant-properties>

#proof[
  For (5), Suppose $vb(C_i)(matbold(M)) + lambda matbold(C_j) (matbold(M)) = 0$ for some $i != j$ and scalar $lambda$. Define $matbold(N)$ given by

  $
    N_(r s) = cases(
      M_(r s) & "if" s != i,
      M_(r s) + lambda M_(r j) & "if" s = i
    ).
  $
  Then
  $
    det(matbold(N)) = det(matbold(M)) + underbracket(lambda det("matrix with column" i = "column" j), = 0) = det(matbold(M)).
  $

  Then, the $i$th column of $matbold(N)$ is all zeros. And thus $det(matbold(N)) = 0 = det(matbold(M)).$

  #lecture-separator(lecture: 15, date: "2025-11-11")

  For (7), take a single term $M_(rho(1)1), ..., M_(rho(n) n)$, and a $sigma$ in $S_n$. We have
  $
    M_(rho(1) 1) M_(rho(2) 2) ... M_(rho(n) n) & = M_(rho(sigma(1)) sigma(1)) M_(rho(sigma(2)) sigma(2)) ... M_(rho(sigma(n)) sigma(n)). \
  $
  Take $rho = sigma^(-1)$. Since $epsilon(rho) = epsilon(sigma)$, we have
  $
    det matbold(M) & = sum_(sigma in S_n) epsilon(sigma) M_(1 sigma(1)), ..., M_(n sigma(n)) \
                   & = det(matbold(M)^TT).
  $

  #separator

  For (8), note that swapping columns an even/odd number of times introduces a factor of $plus.minus 1$. Hence,

  $
    det(matbold(M)matbold(N)) &= sum_sigma epsilon(sigma) (matbold(M)matbold(N))_(sigma(1) 1) (matbold(M)matbold(N))_(sigma(2) 2) ... (matbold(M)matbold(N))_(sigma(n) n)\
    &= sum_sigma epsilon(sigma) sum_(k_1 dots.c k_n = 1)^n M_(sigma(1) k_1) N_(k_1 1) ... M_(sigma(n) k_n) N_(k_n n) \
    &= sum_(k_1 dots.c k_n = 1)^n N_(k_1 1) ... N_(k_n n) underbracket([sum_sigma epsilon(sigma) M_(sigma(1) k_1) ... M_(sigma(n) k_n)], S). \
  $
  If in $S$ two indices $k_p = k_q$ for some $p != q$, then $S = 0$ by property (4). Hence, we only need to consider the case where $k_1, ..., k_n$ are all distinct. This means that there exists a #ponder("algebra.permutation")[permutation] $rho$ such that $k_i = rho(i)$ for all $i$. Thus,
  $
    S & = sum_sigma epsilon(sigma) M_(sigma(1) rho(1)) ... M_(sigma(n) rho(n)) \
      & = epsilon(rho) det(matbold(M)). \
  $
  Therefore,
  $
    det(matbold(M) matbold(N)) & = sum_rho N_(rho(1) 1) ... N_(rho(n) n) epsilon(rho) det(matbold(M)) \
                               & = det(matbold(M)) det(matbold(N)). \
  $

  #separator

  For (9), if $matbold(M)$ is #ponder("algebra.orthogonal-group")[orthogonal], then $matbold(M)^TT matbold(M) = matbold(I)$, and thus
  $
    det(matbold(M)^TT) det(matbold(M)) = det(matbold(I)) = 1.
  $
  Hence, $det(matbold(M)) = plus.minus 1$.

  #separator

  For (10), if $matbold(M)$ is #ponder("linear-algebra.unitary-matrix")[unitary], then $matbold(M)^dagger matbold(M) = matbold(I)$, and thus
  $
    det(matbold(M)^dagger) det(matbold(M)) = det(matbold(I)) = 1.
  $
  Hence, $abs(det(matbold(M))) = 1$.
]

=== Minors and Cofactors

We want to find a way to compute #ponder("linear-algebra.determinant")[determinants] of $n times n$ matrices in an efficient way. We do this by defining #ponder("linear-algebra.minor")[minors] and #ponder("linear-algebra.cofactor")[cofactors].

#definition[Minor][
  For an $n times n$ matrix $matbold(M)$, consider the $(n-1) times (n-1)$ matrix in row $i$ and column $j$ obtained by deleting row $i$ and column $j$ from $matbold(M)$. The #ponder("linear-algebra.determinant")[determinant] of this $(n-1) times (n-1)$ matrix is called the #ponder("linear-algebra.minor")[*minor*] of entry $M_(i j)$ and is denoted by $M^(i j)$.
] <def-minor>

#definition[Cofactor][
  For an $n times n$ matrix $matbold(M)$,  the #ponder("linear-algebra.cofactor")[*cofactor*] of entry $M_(i j)$ is defined by
  $ Delta_(i j) = (-1)^(i + j) M^(i j). $

  Consider the columns and rows of $matbold(M)$ given by
  $ vb(C_j) = sum_i M_(i j) vb(e_i), quad vb(R_i) = sum_j M_(i j) vb(e_j). $
  Then, the #ponder("linear-algebra.determinant")[determinant] of $matbold(M)$ can be written as (see proof in @thm-laplace-expansion):
  $ det matbold(M) = [vb(C_1), ..., vb(C_n)] = sum_i M_(i j) Delta_(i j) = sum_j M_(i j) Delta_(i j). $

  We have
  $
    Delta_(i j) & = [vb(C_1), ..., vb(C_(j-1)), vb(e_i), vb(C_(j+1)), ..., vb(C_n)] \
                & = [vb(R_1), ..., vb(R_(i - 1)), vb(e_j), vb(R_(i + 1)), ..., vb(R_n)] \
                & = mat(
                    delim: "|",
                    M_(1 1), dots.c, M_(1 (j-1)), 0, M_(1 (j+1)), dots.c, M_(1 n);
                    dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v;
                    M_((i-1) 1), dots.c, M_((i-1) (j-1)), 0, M_((i-1) (j+1)), dots.c, M_((i-1) n);
                    0, dots.c, 0, 1, 0, dots.c, 0;
                    M_((i+1) 1), dots.c, M_((i+1) (j-1)), 0, M_((i+1) (j+1)), dots.c, M_((i+1) n);
                    dots.v, dots.v, dots.v, dots.v, dots.v, dots.v, dots.v;
                    M_(n 1), dots.c, M_(n (j-1)), 0, M_(n (j+1)), dots.c, M_(n n)
                  ).
  $
  _i.e._ the #ponder("linear-algebra.cofactor")[cofactor] $Delta_(i j)$ is the #ponder("linear-algebra.determinant")[determinant] of the matrix obtained from $matbold(M)$ by replacing the entry $M_(i j)$ with $1$ and all other entries in row $i$ and column $j$ with $0$.
] <def-cofactor>

Hence, we can write the #ponder("linear-algebra.determinant")[determinant] of $matbold(M)$ as
$ det matbold(M) = sum_i M_(i j) Delta_(i j) = sum_i M_(i j) (-1)^(i + j) M^(i j) $
for any fixed column $j$. Alternatively, we can write
$ det matbold(M) = sum_j M_(i j) Delta_(i j) = sum_j M_(i j) (-1)^(i + j) M^(i j) $
for any fixed row $i$.

#theorem[Laplace expansion formula][
  Consider $matbold(M)$ an $n times n$ matrix. Then, for any fixed $j$,
  $ det matbold(M) = sum_(i=1)^n M_(i j) Delta_(i j). $
] <thm-laplace-expansion>

#proof[

  #notation[
    For an object $j$, we write ${1, ..., overline(j), ..., n}$ to be the set of indices ${1, 2, ..., n} \\ {j}$.
  ]

  We have
  $
    det matbold(M) &= sum_(i_1 ... i_n = 1)^n epsilon_(i_1 ... i_n) M_(i_1 1) ... M_(i_n n)\
    &= sum_(i_j = 1)^n M_(i_j j) sum_(i_1 ... overline(i_j) ... i_n = 1)^n epsilon_(i_1 ... i_n) M_(i_1 1) ... overline(M_(i_j j)) ... M_(i_n n). \
  $

  Consider $sigma in S_n$ the #ponder("algebra.permutation")[permutation] that moves $i_j$ to the $j$th position, and leaves everything else in its natural order:

  $
    sigma = mat(
      1, ..., j, j+1, j+2, ..., i_j - 1, i_j, i_j + 1, ..., n;
      1, ..., i_j, j, j+1, ..., i_j-2, i_j-1, i_j+1, ..., n
    )
  $

  Assume $i_j > j$ (we can do a similar argument for $i_j < j$). Since we have to perform $abs(j - i_j)$ #ponder("algebra.transposition")[transpositions] for $sigma$, $epsilon(sigma) = (-1)^(j - i_j)$. Now consider the #ponder("algebra.permutation")[permutation] $rho in S_(n-1)$,

  $
    rho = mat(
      1, ..., overline(i_j), ..., n;
      i_1, ..., overline(i_j), ..., i_n
    )
  $

  Note that $rho sigma$ reorders $(1, ..., n)$ to $(i_1, ..., i_n)$. Thus,
  $
    epsilon(rho sigma) = epsilon_(i_1 ... i_n) & = epsilon(rho) epsilon(sigma) \
                                             & = (-1)^(j - i_j) epsilon_(i_1 ... overline(i_j) ... i_n).
  $
  Hence, we can rewrite
  $
    det matbold(M) &= sum_(i_j = 1)^n M_(i_j j) sum_(i_1 ... overline(i_j) ... i_n = 1)^n (-1)^(j - i_j) epsilon_(i_1 ... overline(i_j) ... i_n) M_(i_1 1) ... overline(M_(i_j j)) ... M_(i_n n)\
    &= sum_(i_j = 1)^n M_(i_j j) (-1)^(j - i_j) M^(i_j j) \
    &= sum_(i_j=1)^n M_(i_j j) Delta_(i_j j)\
    &= sum_(i=1)^n M_(i j) Delta_(i j). \
  $
]



#definition[Adjugate matrix][
  Reasoning as above, if $vb(C_k) = sum_i M_(i k) vb(e_i)$ then
  $
    [vb(C_1), ..., vb(C_(j-1)), vb(C_k), vb(C_(j+1)), ..., vb(C_n)] = sum_i M_(i k) Delta_(i j) = cases(
      det matbold(M) & "if" k = j,
      0 & "if" k != j
    ) .
  $
  Hence $ sum_i M_(i k) Delta_(i j) & = (det matbold(M)) delta_(j k) \
  sum_j M_(l j) Delta_(i j) & = (det matbold(M)) delta_(l i). $

  #lecture-separator(lecture: 16, date: "2025-11-13")

  The #ponder("linear-algebra.adjugate")[*adjugate*] of a matrix is defined to be
  $
    tilde(matbold(M)) = adj (matbold(M)) = matbold(Delta)^TT.
  $
  where $matbold(Delta)$ is the matrix with entries of #ponder("linear-algebra.cofactor")[cofactors] $Delta_(i j)$.
] <def-adjugate>

#remark[
  From the expression above, note that
  $
    tilde(matbold(M)) matbold(M) = matbold(M) tilde(matbold(M)) = (det matbold(M)) matbold(I).
  $
  and if $det matbold(M) != 0$, then
  $ matbold(M^(-1)) = tilde(matbold(M))/(det matbold(M)). $
]

This suggests a way to compute the inverse of a matrix using only #ponder("linear-algebra.determinant")[determinants] of smaller matrices.



#example[
  Consider the matrix
  $
    matbold(M) = mat(1, x, 1; 1, 1, x; x, 1, 1)
  $
  for some arbitrary scalar $x in RR$. We want to compute $det matbold(M)$.

  By the fact that #ponder("linear-algebra.determinant")[determinants] are conserved under  operations of the form $vb(C_i) -> vb(C_i) + lambda vb(C_j)$,

  $
    det matbold(M) & = mdet(1, x, 1; 1, 1, x; x, 1, 1) \
    & = mdet(0, x, 1; 1-x, 1, x; x-1, 1, 1) & "by" vb(C_1) -> vb(C_1) - vb(C_3) \
    & = mdet(0, x, 1; 2-2x, 0, x-1; x-1, 1, 1) & "by" vb(R_2) -> vb(R_2) - vb(R_3) \
    & = mdet(0, x, 1; 2-2x, 0, x-1; x-1, 1-x, 0) & "by" vb(R_3) -> vb(R_3) - vb(R_1) \
    & = (x-1)^2 mdet(0, x, 1; -2, 0, 1; 1, -1, 0) & "by scaling in" vb(R_2) "and" vb(R_3) \
    & = (x-1)^2 mdet(0, x + 2, 0; -2, 0, 1; 1, -1, 0) & "by" vb(R_1) -> vb(R_1) - 2 vb(R_3) - vb(R_2)\
    &= (x-1)^2 (x+2) mdet(0, 1, 0; -2, 0, 1; 1, -1, 0) & "by scaling in" vb(R_1) \
    &= (x-1)^2(x+2) (1) &"by direct computation"\
    &= (x-1)^2 (x+2). \
  $
] <ex-determinant-column-operations>

== Systems of Linear Equations

=== $2 times 2$ Case

Consider the system of equations given by

$
  cases(
    A_(11) x_1 + A_(12) x_2 = b_1 quad (1),
    A_(21) x_1 + A_(22) x_2 = b_2 quad (2)
  )
$

We can write this system in matrix form as
$ matbold(A) vb(x) = vb(b) $
where
$ matbold(A) = mat(A_(11), A_(12); A_(21), A_(22)), quad vb(x) = vec(x_1, x_2), quad vb(b) = vec(b_1, b_2). $

Consider $(1) times A_(22) - (2) times A_(12)$, we have
$
  (A_(11) A_(22)- A_(21) A_(12)) x_1 = b_1 A_(22) - b_2 A_(12).
$
Similarly, consider $(2) times A_(11) - (1) times A_(21)$, we have
$
  (A_(11) A_(22)- A_(21) A_(12)) x_2 = b_2 A_(11) - b_1 A_(21).
$
Note that $det matbold(A)$ is $A_(11) A_(22)- A_(21) A_(12)$. Thus, we can write
$
  vec(x_1, x_2) = (1)/(det matbold(A)) mat(A_(22), -A_(12); -A_(21), A_(11)) vec(b_1, b_2).
$

Equivalently, given $matbold(A) vb(x) = vb(b)$, if $matbold(A)^(-1)$ exists, we can write
$
  matbold(A)^(-1) = (1)/(det matbold(A)) mat(A_(22), -A_(12); -A_(21), A_(11))
$

=== General Case

Consider a system of $n$ linear equations in $n$ unknowns $x_i$ written in matrix form as
$ matbold(A) vb(x) = vb(b) $
where $matbold(A)$ is an $n times n$ matrix, $vb(x), vb(b) in RR^n$.

We shall consider three possible scenarios.

1. If $det matbold(A) != 0$, then $matbold(A)^(-1)$ exists, and therefore there is a unique solution given by
  $
    vb(x) = matbold(A)^(-1) vb(b).
  $

2. If $det matbold(A) = 0$ and $matbold(b) in.not im matbold(A)$, then there is no solution.

3. If $det matbold(A) = 0$ and $matbold(b) in im matbold(A)$, then there are infinitely many solutions. We can find these solutions by considering

  $
    vb(x) = vb(x_0) + vb(u)
  $
  where $vb(x_0)$ is a particular solution to the system, and $vb(u) in ker matbold(A)$.

  In more detail, a solution exists for
  $
    matbold(A) vb(x_0) = vb(b)
  $

  if and only if we can find $matbold(A) vb(x_0) = vb(b)$ for some $vb(x_0) in RR^n$. This is equivalent to saying that $vb(b) in im matbold(A)$. Then, $vb(x)$ is also a solution if and only if
  $
    vb(u) = vb(x) - vb(x_0)
  $
  satisfies
  $
    matbold(A) vb(u) = vb(0).
  $
  Thus, the general solution is given by
  $
    vb(x) = vb(x_0) + vb(u)
  $
  for any $vb(u) in ker matbold(A)$.

#remark[
  In the first case, note that

  $
    det matbold(A) != 0 <=> im matbold(A) = RR^n <=> ker matbold(A) = {vb(0)}.
  $
  In this case, if $matbold(A) vb(u) = vb(0)$ then we must have $vb(u) = vb(0)$. Hence there is a unique solution.

  #separator

  For the other cases,

  $
    det matbold(A) = vb(0) <=> im matbold(A) != RR^n <=> ker matbold(A) != {vb(0)}.
  $

  and thus either
  $
    cases(
      vb(b) in.not im matbold(A) & quad "as in (2)",
      vb(b) in im matbold(A) & quad "as in (3)"
    )
  $
  If ${vb(u_1), ..., vb(u_k)}$ is a #ponder("linear-algebra.basis")[basis] for $ker matbold(A)$, then the general solution for $matbold(A) vb(u) = vb(0)$ is
  $
    vb(u) = sum_(i=1)^k lambda_i vb(u_i)
  $
  for any scalars $lambda_1, ..., lambda_k$, where $k = null matbold(A)$.

]

#example[
  Consider the equation
  $
    matbold(A) vb(x) = vb(b)
  $
  with
  $ matbold(A)=mat(1, x, 1; 1, 1, x; x, 1, 1) $
  and $ vb(b) = vec(1, y, 1). $
  where $x, y in RR$ are some scalars.
  We saw before that $ det matbold(A) = (x-1)^2 (x+2). $

  1. Assume $det matbold(A) != 0 <=> x != 1, -2$. Then $matbold(A)^(-1)$ exists, and we can construct it from the matrix of cofactors.

    $
      matbold(A)^(-1) = matbold(Delta)^TT/(det matbold(A)).
    $

    #fade[[
      It can be computed that
      $matbold(Delta) = mat(
        1 - x, x^2-1, 1 - x;
        1 - x, 1 - x, x^2 - 1;
        x^2 - 1, 1 - x, 1 - x
      ).$
      ]]

    We have
    $
      matbold(Delta)^TT = mat(
        1 - x, 1 - x, x^2 - 1;
        x^2 - 1, 1 - x, 1 - x;
        1 - x, x^2 - 1, 1 - x
      ).
    $
    Note that $x^2 - 1 = (x + 1) (x- 1)$. This indicates that we can simplify our matrix. Hence, the solution to the equation is
    $
      vb(x) & = matbold(A)^(-1) vb(b) = (1)/((1-x)(x+2)) mat(1, 1, -x-1; -x-1, 1, 1; 1, -x-1, 1) vec(1, y, 1) \
              & = (1)/((1-x)(x+2)) vec(y -x, -x + y, 2 - x y - y).
    $
    The solution is a point in $RR^3$.

  2. Assume that $x = 1$, then

    $ matbold(A) = mat(1, 1, 1; 1, 1, 1; 1, 1, 1) $
    and then $im(matbold(A)) = span{vec(1, 1, 1)}$ with $ker matbold(A) = span{vec(1, -1, 0), vec(1, 0, -1)}$.

    The #ponder("linear-algebra.kernel-image")[image] suggests that we must have $y = 1$ to have a solution. In this case, one particular solution is given by $vb(x_0) = vec(1, 0, 0)$. Hence, the general solution is given by
    $
      vb(x) = vb(x_0) + lambda vec(1, -1, 0) + mu vec(1, 0, -1)
    $
    for any scalars $lambda, mu in RR$, _i.e._
    $
      vb(x) = vec(1 + lambda + mu, -lambda, -mu).
    $

    If $y != 1$, then there is no solution.

  3. The case $x = -2$ is similar to case 2.
]

#lecture-separator(lecture: 17, date: "2025-11-15")

=== The Homogeneous Case – Geometrical Interpretation

Consider the equation
$
  matbold(A) vb(u) = vb(0).
$
Then, if $vb(R_1), vb(R_2), vb(R_3)$ are the rows of $matbold(A)$, then
$
  matbold(A) vb(u) = vb(0) & <=> cases(
                                   vb(R_1) dot vb(u) = 0,
                                   vb(R_2) dot vb(u) = 0,
                                   vb(R_3) dot vb(u) = 0
                                 )
$

Each equation represents a plane in $RR^3$ that passes through the origin with normal $vb(R_i)$. The solution to the system, which is $ker matbold(A)$, is the intersection of these planes.

The possible scenarios are as follows:

1. $rank matbold(A) = 3 <=> null matbold(A) = 0$, so $ker matbold(A) = {vb(0)}$. This means that all the normals of the three planes are #ponder("linear-algebra.linear-independence")[linearly independent], and thus the only intersection point is the origin.

2. $rank matbold(A) = 2 <=> null matbold(A) = 1$. The intersection of the three planes is a line through the origin, and the three normals #ponder("linear-algebra.spanning-set")[span] a plane.

3. $rank matbold(A) = 1 <=> null matbold(A) = 2$. The intersection of the three planes is a plane through the origin, so all three planes coincide. In this case, all normals are #ponder("linear-algebra.parallel-vectors")[parallel].

=== The General Case – Geometrical Interpretation

Consider the equation
$ matbold(A) vb(u) = vb(b). $
Then,
$
  matbold(A) vb(u) = vb(b) & <=> cases(
                                   vb(R_1) dot vb(u) = b_1,
                                   vb(R_2) dot vb(u) = b_2,
                                   vb(R_3) dot vb(u) = b_3
                                 )
$
These are three planes in $RR^3$ with normals $vb(R_1), vb(R_2), vb(R_3)$, and in general do not pass through the origin.

The possible scenarios are as follows:

1. $rank matbold(A) = 3 <=> det matbold(A) != 0$. All the normals are #ponder("linear-algebra.linear-independence")[linearly independent], and thus the three planes intersect at a single point. There is a unique solution for any $vb(b) in RR^3$.

2. $rank matbold(A) < 3 <=> det matbold(A) = 0$.

  The existence of solutions depends on $vb(b)$. More specifically, whether $vb(b)$ is in the #ponder("linear-algebra.kernel-image")[image] of $matbold(A)$.

  - if $rank matbold(A) = 2$, then the planes may intersect in a line as in the homogeneous case, or there is no solution.

    #align(center)[
      #dynamic-svg("/part-ia/vectors-and-matrices/media/d6e1.svg", width: 18em)
    ]

  - if $rank matbold(A) = 1$, then either all three planes coincide as in the homogeneous case, or there is no solution.

    #align(center)[
      #dynamic-svg("/part-ia/vectors-and-matrices/media/d6e2.svg", width: 18em)
    ]

=== Gaussian Elimination

Consider a system of $m$ equations in $n$ unknowns:

$
  cases(
    A_(11) x_1 + A_(12) x_2 + ... + A_(1 n) x_n & = b_1,
    A_(21) x_1 + A_(22) x_2 + ... + A_(2 n) x_n & = b_2,
    & dots.v,
    A_(m 1) x_1 + A_(m 2) x_2 + ... + A_(m n) x_n & = b_m
  )
$

WLOG, we can assume that $A_(11) != 0$ (since we can always swap rows).

#notation[
  We will use a superscript $(i)$ to denote the value in the $i$th step of the algorithm.
]

*Step 1.* We subtract multiples of the first equation from all other equations to make the coefficients of $x_1$ zero in all equations except the first one.

$
  cases(
    A_(11)^((1)) x_1 + & A_(12)^((1)) x_2 + ... + A_(1 n)^((1)) x_n & = b_1^((1)),
    & A_(22)^((1)) x_2 + ... + A_(2 n)^((1)) x_n & = b_2^((1)),
    && dots.v,
    & A_(m 2)^((1)) x_2 + ... + A_(m n)^((1)) x_n & = b_m^((1))
  )
$

*Step 2.* Repeat (1) for $A_(22)^(1)$ and coefficients of $x_2$ in all equations except the second one, and so on.

$
  cases(
    A_(11)^((1)) x_1 + & A_(12)^((1)) x_2 + & A_(13)^((1)) x_3 + ... + & A_(1 n)^((1)) x_n & = b_1^((1)),
    & A_(22)^((2)) x_2 + & A_(23)^((2)) x_3 + ... + & A_(2 n)^((2)) x_n & = b_2^((2)),
    && A_(33)^((3)) x_3 + ... + & A_(3 n)^((3)) x_n & = b_3^((3)),
    &&&& dots.v,
    && A_(r r)^((r)) x_r + ... + & A_(r n)^((r)) x_n & = b_r^((r)),
    &&& 0 & = b_(r+1)^((r)),
    &&&& dots.v,
    &&& 0 & = b_(m)^((r))
  )
$

In all these equations, $A_(i i)^(i) != 0$.


The possible cases are as follows.

1. $r = n <= m$ and $b_i^(r) = 0$ for all $i = r + 1, ..., m$. Then, there is a unique solution. To obtain it, we can first find $x_n$ from the $n$th equation, then substitute it into the $(n-1)$th equation to find $x_(n-1)$, and so on.

2. $b_i^(r) !=0$ for some $i = r + 1, ..., m$. Then, there is no solution.

3. $r < n$ and $b_i^(r) = 0$ for all $i = r + 1, ..., m$ (and not necessarily $n = m$). Then $x_(r+1) ... x_n$ are undetermined. So, given any values of $b_1, ..., b_r$, we can solve $x_1, ..., x_r$. Then, there are infinitely many solutions given by varying $x_(r+1), ..., x_n$.

Note that this algorithm can also be written in matrix form by
$
  matbold(A) vb(x) = vb(b)
$
where $matbold(A)$ is an $m times n$ matrix. This algorithm can be reexpressed to obtain
$
  matbold(M) vb(x) = vb(d)
$
with
$
  matbold(M) = mat(
    M_(11), M_(12), ..., M_(1 r), ..., M_(1 n);
    0, M_(22), ..., M_(2 r), ..., M_(2 n);
    dots.v, dots.v, dots.v, dots.v, dots.v, dots.v;
    0, 0, ..., M_(r r), ..., M_(r n);
    0, 0, ..., 0, ..., 0;
    dots.v, dots.v, dots.v, dots.v, dots.v, dots.v;
    0, 0, ..., 0, ..., 0
  )
$
which is called the *row echelon form* of $matbold(A)$. Note that

- the first $r times r$ block is upper triangular with non-zero entries on the diagonal.

- $r = rank matbold(M) = rank matbold(A)$.

- if $n = m$, $det matbold(A) = plus.minus det matbold(M)$, and if $n = m = r$, then $det matbold(A) = plus.minus det matbold(M) = M_(11) M_(22) ... M_(n n) != 0$. Then, both $matbold(A)$ and $matbold(M)$ are #ponder("algebra.matrix-invertibility")[invertible].


