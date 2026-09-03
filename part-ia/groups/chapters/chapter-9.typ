#import "../prelude.typ": *
#import "@preview/fletcher:0.5.8": edge


= Matrix Groups

Let $M_n (RR)$ be the set of all $n times n$ matrices with real entries.

From IA Vectors and Matrices, we know that #ponder("algebra.binary-operation")[matrix multiplication] is #ponder("algebra.group")[associative] and has an #ponder("algebra.group")[identity element], the identity matrix $matbold(I)_n$, though not all matrices have #ponder("algebra.inverse-element")[inverses] under multiplication.

#lemma[
  $matbold(A) in M_n (RR)$ has an inverse iff $det matbold(A) != 0$.
] <matrix-invertibility>

#definition[#ponder("algebra.general-linear-group")[General linear group]][
  Let $GL_n (RR) = { matbold(A) in M_n (RR) : det matbold(A) != 0 }$. This is a #ponder("algebra.group")[group] under #ponder("algebra.binary-operation")[matrix multiplication].
] <general-linear-group>

Here is another result from IA Vectors and Matrices.

#lemma[
  For $matbold(A), matbold(B) in M_n (RR)$, $det (matbold(A) matbold(B)) = det matbold(A) dot det matbold(B)$.
] <determinant-multiplicativity>

This implies that $det$ is a #ponder("algebra.homomorphism")[homomorphism]
$
  det: GL_n (RR) -> RR^times quad "with" quad matbold(A) |-> det matbold(A).
$

#definition[#ponder("algebra.special-linear-group")[Special linear group]][
  Let $SL_n (RR) = ker det = { matbold(A) in M_n (RR) : det matbold(A) = 1 }$. This is a #ponder("algebra.subgroup")[subgroup] of $GL_n (RR)$ called the #ponder("algebra.special-linear-group")[special linear group].
] <special-linear-group>

By the @isomorphism-theorem[Isomorphism Theorem],
$
               SL_n (RR) & nsub GL_n (RR) \
  GL_n (RR) \/ SL_n (RR) & teq im det.
$
For any $x in RR$,
$
  det mat(x, 0, ..., 0; 0, 1, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., 1) = x.
$
Hence $im det = RR^times$ and so
$
  GL_n (RR) \/ SL_n (RR) teq RR^times.
$

#remark[
  We can replace $RR$ with $CC$ in the above and get similar results. Therefore we have
  $
    GL_n (CC) \/ SL_n (CC) teq CC^times.
  $

]

== #ponder("algebra.matrix-change-of-basis")[Change of Basis]

This is a familiar concept from IA Vectors and Matrices. There is a natural #ponder("algebra.group-action")[action] by #ponder("algebra.conjugation")[conjugation]:
$
  GL_n (RR) arrow.cw.half M_n (RR)\
  matbold(P) (matbold(A)) := matbold(P) matbold(A) matbold(P)^(-1).
$

#proposition[#ponder("algebra.matrix-change-of-basis")[Change of Basis]][
  Let $V$ be an $n$-dimensional vector space over $RR$, and $alpha: V->V$ a linear map. If $matbold(A) in M_n (RR)$ that represents $alpha$ in some basis, then the #ponder("algebra.orbit-stabiliser-definitions")[orbit]
  $
    GL_n (RR) matbold(A) = {matbold(P) matbold(A) matbold(P)^(-1) : matbold(P) in GL_n (RR)}
  $
  consists of all matrices that represent $alpha$ in any basis.
 ] <matrix-change-of-basis>

#proof[
  A basis ${bold(v_1), ..., bold(v_n)}$ for $V$ defines an #ponder("algebra.isomorphism")[isomorphism] of vector spaces
  $ phi: RR^n -> V quad "with" quad vec(lambda_1, ..., lambda_n) |-> sum_(i=1)^n lambda_i bold(v_i). $
  The claim that $matbold(A)$ represents $alpha$ in this basis means that

  #fletcher-diagram(
    $
      RR^n edge(phi\ teq, ->) edge("d", matbold(A), ->) & V edge("d", alpha, ->, label-side: #left) \
                                RR^n edge(phi\ teq, ->) & V
    $,
  )
  and so $alpha = phi matbold(A) phi^(-1)$.

  #lecture-separator(lecture: 21, date: "2025-11-26")

  Likewise, another basis ${bold(u_1), ..., bold(u_n)}$ for $V$ corresponds to another #ponder("algebra.isomorphism")[isomorphism]
  $
    psi: RR^n -> V,
  $
  and a matrix $matbold(B)$ represents $alpha$ in these coordinates if
  $
    alpha = psi matbold(B) psi^(-1).
  $

  Therefore, $ matbold(B) & = psi^(-1) alpha psi = psi^(-1) phi matbold(A) phi^(-1) psi \
             & = (psi^(-1) phi) matbold(A) (psi^(-1) phi)^(-1) \
             & = matbold(P) matbold(A) matbold(P)^(-1). $
  where $matbold(P) in GL_n (RR)$ #fade[[because its inverse exists, namely the matrix representing $phi^(-1) psi$]] represents the #ponder("algebra.isomorphism")[isomorphism] $psi^(-1) phi: RR^n -> RR^n$ in the standard basis. Thus, the set of all matrices representing $alpha$ in any basis is contained in the #ponder("algebra.orbit-stabiliser-definitions")[orbit] $GL_n (RR) matbold(A)$.

  Conversely, if
  $
    matbold(B) = matbold(P) matbold(A) matbold(P)^(-1)
  $
  for some $matbold(P) in GL_n (RR)$, then setting
  $ psi = phi matbold(P)^(-1): RR^n -> V $
  we get a basis
  $
    {matbold(u_1) = psi(bold(e_i))}
  $
  for $V$. In this basis, $matbold(B)$ represents $alpha$.
]

== #ponder("algebra.mobius-transformation")[Möbius Transformations], Revisited

Recall that multiplication in $cal(M)$ looked similar to multiplication of $2 times 2$ matrices.

#proposition[#ponder("algebra.matrix-mobius-quotient")[Möbius transformations from matrices]][
  Identify
  $
    CC^times = {mat(lambda, 0; 0, lambda) in GL_2(CC): lambda in CC^times}
  $
  then
  $
    CC^times nsub GL_2(CC)
  $
  and
  $
    GL_2(CC) \/ CC^times teq cal(M).
  $
 ] <matrix-mobius-quotient>

#proof[
  We can prove both statements by constructing a #ponder("algebra.homomorphism-bijectivity")[surjective] #ponder("algebra.homomorphism")[homomorphism] from $GL_2(CC)$ onto $cal(M)$ with #ponder("algebra.image-kernel")[kernel] $CC^times$, by the @isomorphism-theorem[Isomorphism Theorem]. Consider the map
  $
    Phi: GL_2(CC) -> cal(M) quad "with" quad mat(a, b; c, d) |-> (z |-> (a z + b) / (c z + d)).
  $
  By our previous computation of multiplication in $cal(M)$, we see that $Phi$ is a #ponder("algebra.homomorphism")[homomorphism]. Also, $Phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective] since for any #ponder("algebra.mobius-transformation")[Möbius transformation] $f(z) = (a z + b) / (c z + d)$ with $a d - b c != 0$, the matrix $mat(a, b; c, d)$ is in $GL_2(CC)$.

  A matrix $mat(a, b; c, d) in ker Phi$ iff its image fixes $0$, $1$ and $oo$ by the @three-point-lemma-mobius[Three Point Lemma for $cal(M)$]. Hence
  $
    b = 0, c = 0, a = d.
  $
  Thus, $ker Phi = { mat(lambda, 0; 0, lambda) : lambda in CC^times }$ which we have identified with $CC^times$.

  Therefore, by the @isomorphism-theorem[Isomorphism Theorem]
  $
    GL_2(CC) \/ CC^times teq cal(M).
  $
]

== Orthogonal Groups

Let us write $norm(dot)$ for the normal notion of length on $RR^n$, _i.e._
$
  norm(bold(u)) = sqrt(sum_(i=1)^n u_i^2).
$

#definition[#ponder("algebra.orthogonal-group")[Orthogonal Group]][
  The *$n$-dimensional #ponder("algebra.orthogonal-group")[orthogonal group]* is the #ponder("algebra.subgroup")[subgroup] of $GL_n (RR)$ that preserves distance in $RR^n$:
  $
    O(n) = { matbold(A) in GL_n (RR) : forall bold(v) in RR^n, norm(matbold(A) bold(v)) = norm(bold(v)) }.
  $
] <orthogonal-group>

In fact, the *dot product*
$
  bold(u) dot bold(v) = sum_(i=1)^n u_i v_i
$
is often more convenient to work with.

#lemma[#ponder("algebra.polarisation-identity")[Polarisation Identity]][
  For any $bold(u), bold(v) in RR^n$,
  $
    2 bold(u) dot bold(v) = norm(bold(u))^2 + norm(bold(v))^2 - norm(bold(u) - bold(v))^2.
  $
]
 <polarisation-identity>

#proof[
  $
    norm(bold(u)-bold(v))^2 & = (bold(u)-bold(v)) dot (bold(u) - bold(v)) \
                            & = bold(u) dot bold(u) - 2 bold(u) dot bold(v) + bold(v) dot bold(v) \
                            & = norm(bold(u))^2 - 2 bold(u) dot bold(v) + norm(bold(v))^2.
  $
]

It follows that we can characterise $O(n)$ using the dot product.

#lemma[$O(n)$ and the Dot Product][
  $
    O(n) = { matbold(A) in GL_n (RR) : forall bold(x), bold(y) in RR^n, (matbold(A) bold(x)) dot (matbold(A) bold(y)) = bold(x) dot bold(y) }.
  $
] <on-and-the-dot-product>

#proof[
  If $(matbold(A) bold(x)) dot (matbold(A) bold(y)) = bold(x) dot bold(y)$ for all $bold(x), bold(y) in RR^n$, then for any $bold(v) in RR^n$,
  $
    norm(matbold(A) bold(v))^2 & = (matbold(A) bold(v)) dot (matbold(A) bold(v)) \
                               & = bold(v) dot bold(v) \
                               & = norm(bold(v))^2. \
      norm(matbold(A) bold(v)) & = norm(bold(v)).
  $
  Therefore $matbold(A) in O(n)$.

  Conversely, if $matbold(A) in O(n)$ , then $forall bold(x), bold(y) in RR^n$,
  $
    2 (matbold(A) bold(x) ) dot (matbold(A) bold(y)) & = norm(matbold(A) bold(x))^2 + norm(matbold(A) bold(y))^2 - norm(matbold(A) bold(x) - matbold(A) bold(y))^2 \
    & = norm(matbold(A) bold(x))^2 + norm(matbold(A) bold(y))^2 - norm(matbold(A) (bold(x) - bold(y)))^2 \
    & = norm(bold(x))^2 + norm(bold(y))^2 - norm(bold(x) - bold(y))^2 \
    & = 2 bold(x) dot bold(y).
  $

  Hence $(matbold(A) bold(x)) dot (matbold(A) bold(y)) = bold(x) dot bold(y)$ for all $bold(x), bold(y) in RR^n$ as required.
]

This quickly leads to a nice characterisations of matrices in $O(n)$.

#lemma[Matrices in $O(n)$][
  Let $matbold(A) in M_n (RR)$. The following are equivalent:

  1. $matbold(A) in O(n)$.

  2. The columns of $matbold(A)$ form an orthonormal basis of $RR^n$.

  3. $matbold(A)^tp matbold(A) = matbold(I)_n$.

]
 <orthogonal-matrix-characterisation>

#proof[
  Let $matbold(A) = (a_(i j))$.

  #fade[[(1) $=>$ (2).]] Let ${bold(e_1), ..., bold(e_n)}$ be the standard basis for $RR^n$. The $i$th column of $matbold(A)$ is $matbold(A) bold(e_i)$. since
  $
    (matbold(A) bold(e_i)) dot (matbold(A) bold(e_j)) & = bold(e_i) dot bold(e_j) \
                                                      & = delta_(i j),
  $
  The columns of $matbold(A)$ form an orthonormal basis.

  #fade[[(2) $=>$ (3).]] As explained above, (2) means that
  $
    matbold(A) bold(e_i) dot matbold(A) bold(e_j) = delta_(i j).
  $
  Since $bold(u) dot bold(v) = bold(u)^tp bold(v)$, this means that
  $
    (matbold(A) bold(e_i))^tp (matbold(A) bold(e_j)) & = delta_(i j) \
     bold(e_i^tp) matbold(A)^tp matbold(A) bold(e_j) & = delta_(i j).
  $
  But $bold(e_i^tp) matbold(M) bold(e_j)$ is the $(i, j)$th entry of the matrix $matbold(M)$, so this shows that the $(i, j)$th entry of $matbold(A)^tp matbold(A)$ is $delta_(i j)$ for all $i, j$. Therefore $matbold(A)^tp matbold(A) = matbold(I_n)$.

  #fade[[(3) $=>$ (1).]]

  Suppose $bold(u), bold(v) in RR^n$. then
  $
    (matbold(A) bold(u)) dot (matbold(A) bold(v)) & = (matbold(A) bold(u))^tp (matbold(A) bold(v)) \
                                                  & = bold(u)^tp matbold(A)^tp matbold(A) bold(v) \
                                                  & = bold(u)^tp matbold(I_n) bold(v) \
                                                  & = bold(u) dot bold(v).
  $

  Hence $matbold(A) in O(n)$ as required.
]

Recall that $det matbold(A^tp) = det matbold(A)$. Therefore,
$
  1 = det(matbold(I_n)) = det(matbold(A)^tp matbold(A)) = det(matbold(A)^tp) dot det(matbold(A)) = (det matbold(A))^2.
$
So $det matbold(A) = plus.minus 1$ for any $matbold(A) in O(n)$.

#lecture-separator(lecture: 22, date: "2025-11-28")

#definition[#ponder("algebra.special-orthogonal-group")[Special Orthogonal Group]][
  The *#ponder("algebra.special-orthogonal-group")[special orthogonal group]* is the #ponder("algebra.subgroup")[subgroup]
  $
    SO(n) := O(n) inter SL_n (RR) = { matbold(A) in O(n) : det matbold(A) = 1 }.
  $
]
 <special-orthogonal-group>
Note that
$
  SO(n) = ker (det: O(n) -> {plus.minus 1}) .
$

Thus,

$
  [O(n) : SO(n)] = 2.
$

Examples of elements of $O(n) \\ SO(n)$ are provided by #ponder("geometry.reflection")[reflections].

#definition[#ponder("geometry.reflection")[Reflection]][
  Any $bold(v) in RR^n \\ {0}$ defines an orthogonal plane $bold(v)^perp = P_bold(v) = {bold(x) in RR^n: bold(x) dot bold(v) = 0}$.

  The *#ponder("geometry.reflection")[reflection]* in $P_bold(v)$ is defined to be
  $
    S_bold(v) (bold(x)) = bold(x) - (2 (bold(x) dot bold(v))) / norm(bold(v))^2 bold(v).
  $

]
 <reflection>

#remark[

  1. We will sometimes write $S_P$ for the #ponder("geometry.reflection")[reflection] in the plane $P$.

  2. We may replace $bold(v)$ by $bold(v)/norm(bold(v))$ and assume that $norm(bold(v)) = 1$. then

    $
      S_bold(v) (bold(x)) = bold(x) - 2 (bold(x) dot bold(v)) bold(v).
    $
]

#lemma[#ponder("geometry.reflection-properties")[Properties of a reflection]][
  1. $S_bold(v)^2 = id$

  2. $S_bold(v) in O(n)$
]
 <reflection-properties>

#proof[
  We may assume that $norm(bold(v)) = 1$. From the definition, $S_bold(v)$ is linear in $bold(x)$. So we can think of $S_bold(v)$ as a matrix $matbold(S)_bold(v) in M_n (RR)$. Now,
  $
    (S_bold(v)(bold(x)) dot bold(v)) & = (bold(x) dot bold(v)) - 2 (bold(x) dot bold(v))( bold(v) dot bold(v)) \
                                     & = (bold(x) dot bold(v)) - 2 (bold(x) dot bold(v)) \
                                     & = - (bold(x) dot bold(v)).
  $
  So,
  $
    S_bold(v)^2(bold(x)) & = S_bold(v)(bold(x)) - 2 (S_bold(v)(bold(x)) dot bold(v)) bold(v) \
                         & = bold(x) - 2 (bold(x) dot bold(v)) bold(v) - 2 (- (bold(x) dot bold(v))) bold(v) \
                         & = bold(x).
  $
  So indeed $S_bold(v)^2 = id$. In particular, $S_bold(v)$ is invertible with #ponder("algebra.inverse-element")[inverse] $S_bold(v)$, So
  $
    matbold(S)_bold(v) in GL_n (RR).
  $
  Finally, for any $bold(x) in RR^n$,
  $
    norm(S_bold(v)(bold(x)))^2 & = (S_bold(v)(bold(x))) dot (S_bold(v)(bold(x))) \
    & = (bold(x) - 2 (bold(x) dot bold(v)) bold(v)) dot (bold(x) - 2 (bold(x) dot bold(v)) bold(v)) \
    & = bold(x) dot bold(x) - 4 (bold(x) dot bold(v)) (bold(x) dot bold(v)) + 4 (bold(x) dot bold(v))^2 (bold(v) dot bold(v)) \
    & = norm(bold(x))^2.
  $
  Hence $S_bold(v) in O(n)$ as required.
]

#remark[
  Let $norm(bold(v)) =1$, and pick an orthonormal basis ${bold(v_1), ..., bold(v)_(n-1)}$ for $P_bold(v)$. In the basis ${bold(v_1), ..., bold(v)_(n-1), bold(v)}$ for $RR^n$, $S_bold(v)$ has matrix
  $
    matbold(S)_bold(v) = mat(1, 0, ..., 0, 0; 0, 1, ..., 0, 0; dots.v, dots.v, dots.down, dots.v, dots.v; 0, 0, ..., 1, 0; 0, 0, ..., 0, -1)
  $
  so $det matbold(S)_bold(v) = -1$ and hence $S_bold(v) in O(n) \\ SO(n)$.
]

#theorem[#ponder("algebra.reflections-generate")[Reflections Generate $O(n)$]][
  Every $matbold(A) in O(n)$ is a product of at most $n$ #ponder("geometry.reflection")[reflections].
] <reflections-generate-on>

#proof[
  We will prove this by induction on $n$.

  *Base case.* When $n = 1$, $O(1) = {plus.minus 1} = lr(chevron.l S_1 chevron.r) teq C_2$. The matrix $mat(-1)$ is the #ponder("geometry.reflection")[reflection] in the origin, so the result holds.

  *Inductive step.* Let ${bold(e_1), ..., bold(e_n)}$ be the standard basis for $RR^n$. Let $bold(v) = bold(e_n) - matbold(A) bold(e_n)$.

  Then $matbold(S)_bold(v) (matbold(A) bold(e_n)) = bold(e_n)$, #fade[[and since $matbold(S)_bold(v) matbold(A)$ is an #ponder("algebra.orthogonal-group")[orthogonal transformation], by @on-and-the-dot-product, dot products are preserved, and hence vectors that are orthogonal to $bold(e_n)$ are sent to some vector that is still orthogonal to $bold(e_n)$,]] so $matbold(S)_bold(v) matbold(A)$ preserves $P_(bold(e_n)) = RR^(n-1)times {0}$.

  By induction, there are $bold(v_1), ..., bold(v_n) in RR^(n-1)$ such that
  $
    matbold(S)_bold(v) matbold(A) = matbold(S)_bold(v_1) ... matbold(S)_bold(v_(n-1)) quad "on" RR^(n-1).
  $
  Since both sides also fix $bold(e_n)$, they also agree on $RR^n$. Therefore,
  $
    matbold(A) = matbold(S)_bold(v) matbold(S)_bold(v_1) ... matbold(S)_bold(v)_(n-1).
  $
]

#ponder("algebra.orthogonal-group")[Orthogonal transformations] are especially easy to analyse in low dimensions.

#lemma[Elements of $O(2)$][
  Let $matbold(A) in O(2)$.

  1. If $matbold(A) in.not SO(2)$ then $matbold(A)$ is a #ponder("geometry.reflection")[reflection].
  2. If $matbold(A) in SO(2)$ then $matbold(A)$ is a #ponder("geometry.rotation")[rotation] about $O$.
]  <elements-of-o2>

#proof[
  Recall that $det matbold(S)_bold(v) = -1$, so
  $det(matbold(S)_bold(v_1) matbold(S)_bold(v_2) ... matbold(S)_bold(v_k)) = (-1)^k$. By @reflections-generate-on, we may take $k <= 2$.

  1. If $matbold(A) in.not SO(2)$, then $k$ is odd and hence $k = 1$. So $matbold(A) = matbold(S)_bold(v_1)$ is a #ponder("geometry.reflection")[reflection].

  2. If $matbold(A) in SO(2)$, then $k$ is even, so unless $matbold(A) = matbold(I)$, we can write $matbold(A) = matbold(S)_bold(u) matbold(S)_bold(v)$ for some $bold(u), bold(v) in RR^2$ that are not parallel.

    We claim that $matbold(A) = matbold(S)_bold(u) matbold(S)_bold(v)$ only fixes the origin. #fade[[Here, we define a #ponder("geometry.rotation")[rotation] to be an #ponder("algebra.orthogonal-group")[orthogonal transformation] that only fixes the origin.]] Indeed, for $bold(x) !=0$, suppose
    $
      matbold(S)_bold(u) matbold(S)_bold(v) (bold(x)) = bold(x) <=> matbold(S)_bold(v) bold(x) = matbold(S)_bold(u) bold(x).
    $
    But $bold(v)$ is parallel to $bold(x) - matbold(S)_bold(v) bold(x)$ and $bold(u)$ is parallel to $bold(x) - matbold(S)_bold(u) bold(x)$, so this implies that $bold(u)$ is parallel to $bold(v)$. $smash$

    Hence $matbold(A)$ only fixes the origin, and is therefore a #ponder("geometry.rotation")[rotation] about $O$.

]

#remark[
  Let $matbold(A) in SO(2)$. We have seen that the columns form an orthonormal basis of $RR^2$, so we may write
  $
    matbold(A) = mat(a, b; -b, a)
  $
  with $a^2 + b^2 = 1$. Thus, there exists $theta in RR$ such that $a = cos theta$ and $b = sin theta$, so
  $ matbold(A) = mat(cos theta, sin theta; -sin theta, cos theta). $
]

#lemma[Elements of $SO(3)$][
  If $matbold(A) in SO(3)$, the $matbold(A)$ is a #ponder("geometry.rotation")[rotation].
] <orthogonal-group-so3>
#proof[
  By @reflections-generate-on, $matbold(A)$ is a product of at most $3$ #ponder("geometry.reflection")[reflections]. Since $det matbold(A) = 1$, either $matbold(A) = matbold(I)$ or $matbold(A) = matbold(S)_bold(u) matbold(S)_bold(v)$ for some $bold(u), bold(v) in RR^3$ that are not parallel. Since $n=3$, $ P_bold(u) inter P_bold(v) = l $
  where $l$ is a line through the origin. Since $P_bold(u)$ fixes $l$ pointwise and $P_bold(v)$ also fixes $l$ pointwise, their composition $matbold(A)$ also fixes $l$ pointwise. #fade[[We shall define a #ponder("geometry.rotation")[rotation] in $RR^3$ to be an #ponder("algebra.orthogonal-group")[orthogonal transformation] that fixes a line pointwise.]]

  Also $matbold(S)_bold(u) matbold(S)_bold(v) bold(x) = bold(x) => matbold(S)_bold(u) bold(x)= matbold(S)_bold(v) bold(x)$, similar to @elements-of-o2, either

  1. $bold(x) in l$, in which case $bold(x)$ is fixed by $matbold(A)$, or
  2. $bold(u)$ is parallel to $bold(v)$. $smash$

  Thus, $matbold(A)$ only fixes the line $l$ pointwise, and is therefore a #ponder("geometry.rotation")[rotation].
]
