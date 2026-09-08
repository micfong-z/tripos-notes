#import "../prelude.typ": *


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
  A basis ${vb(v_1), ..., vb(v_n)}$ for $V$ defines an #ponder("algebra.isomorphism")[isomorphism] of vector spaces
  $ phi: RR^n -> V quad "with" quad vec(lambda_1, ..., lambda_n) |-> sum_(i=1)^n lambda_i vb(v_i). $
  The claim that $matbold(A)$ represents $alpha$ in this basis means that

  #fletcher-diagram(
    $
      RR^n edge(phi\ teq, ->) edge("d", matbold(A), ->) & V edge("d", alpha, ->, label-side: #left) \
                                RR^n edge(phi\ teq, ->) & V
    $,
  )
  and so $alpha = phi matbold(A) phi^(-1)$.

  #lecture-separator(lecture: 21, date: "2025-11-26")

  Likewise, another basis ${vb(u_1), ..., vb(u_n)}$ for $V$ corresponds to another #ponder("algebra.isomorphism")[isomorphism]
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
    {matbold(u_1) = psi(vb(e_i))}
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
  norm(vb(u)) = sqrt(sum_(i=1)^n u_i^2).
$

#definition[#ponder("algebra.orthogonal-group")[Orthogonal Group]][
  The *$n$-dimensional #ponder("algebra.orthogonal-group")[orthogonal group]* is the #ponder("algebra.subgroup")[subgroup] of $GL_n (RR)$ that preserves distance in $RR^n$:
  $
    O(n) = { matbold(A) in GL_n (RR) : forall vb(v) in RR^n, norm(matbold(A) vb(v)) = norm(vb(v)) }.
  $
] <orthogonal-group>

In fact, the *dot product*
$
  vb(u) dot vb(v) = sum_(i=1)^n u_i v_i
$
is often more convenient to work with.

#lemma[#ponder("algebra.polarisation-identity")[Polarisation Identity]][
  For any $vb(u), vb(v) in RR^n$,
  $
    2 vb(u) dot vb(v) = norm(vb(u))^2 + norm(vb(v))^2 - norm(vb(u) - vb(v))^2.
  $
]
 <polarisation-identity>

#proof[
  $
    norm(vb(u)-vb(v))^2 & = (vb(u)-vb(v)) dot (vb(u) - vb(v)) \
                            & = vb(u) dot vb(u) - 2 vb(u) dot vb(v) + vb(v) dot vb(v) \
                            & = norm(vb(u))^2 - 2 vb(u) dot vb(v) + norm(vb(v))^2.
  $
]

It follows that we can characterise $O(n)$ using the dot product.

#lemma[$O(n)$ and the Dot Product][
  $
    O(n) = { matbold(A) in GL_n (RR) : forall vb(x), vb(y) in RR^n, (matbold(A) vb(x)) dot (matbold(A) vb(y)) = vb(x) dot vb(y) }.
  $
] <on-and-the-dot-product>

#proof[
  If $(matbold(A) vb(x)) dot (matbold(A) vb(y)) = vb(x) dot vb(y)$ for all $vb(x), vb(y) in RR^n$, then for any $vb(v) in RR^n$,
  $
    norm(matbold(A) vb(v))^2 & = (matbold(A) vb(v)) dot (matbold(A) vb(v)) \
                               & = vb(v) dot vb(v) \
                               & = norm(vb(v))^2. \
      norm(matbold(A) vb(v)) & = norm(vb(v)).
  $
  Therefore $matbold(A) in O(n)$.

  Conversely, if $matbold(A) in O(n)$ , then $forall vb(x), vb(y) in RR^n$,
  $
    2 (matbold(A) vb(x) ) dot (matbold(A) vb(y)) & = norm(matbold(A) vb(x))^2 + norm(matbold(A) vb(y))^2 - norm(matbold(A) vb(x) - matbold(A) vb(y))^2 \
    & = norm(matbold(A) vb(x))^2 + norm(matbold(A) vb(y))^2 - norm(matbold(A) (vb(x) - vb(y)))^2 \
    & = norm(vb(x))^2 + norm(vb(y))^2 - norm(vb(x) - vb(y))^2 \
    & = 2 vb(x) dot vb(y).
  $

  Hence $(matbold(A) vb(x)) dot (matbold(A) vb(y)) = vb(x) dot vb(y)$ for all $vb(x), vb(y) in RR^n$ as required.
]

This quickly leads to a nice characterisations of matrices in $O(n)$.

#lemma[Matrices in $O(n)$][
  Let $matbold(A) in M_n (RR)$. The following are equivalent:

  1. $matbold(A) in O(n)$.

  2. The columns of $matbold(A)$ form an orthonormal basis of $RR^n$.

  3. $matbold(A)^TT matbold(A) = matbold(I)_n$.

]
 <orthogonal-matrix-characterisation>

#proof[
  Let $matbold(A) = (a_(i j))$.

  #fade[[(1) $=>$ (2).]] Let ${vb(e_1), ..., vb(e_n)}$ be the standard basis for $RR^n$. The $i$th column of $matbold(A)$ is $matbold(A) vb(e_i)$. since
  $
    (matbold(A) vb(e_i)) dot (matbold(A) vb(e_j)) & = vb(e_i) dot vb(e_j) \
                                                      & = delta_(i j),
  $
  The columns of $matbold(A)$ form an orthonormal basis.

  #fade[[(2) $=>$ (3).]] As explained above, (2) means that
  $
    matbold(A) vb(e_i) dot matbold(A) vb(e_j) = delta_(i j).
  $
  Since $vb(u) dot vb(v) = vb(u)^TT vb(v)$, this means that
  $
    (matbold(A) vb(e_i))^TT (matbold(A) vb(e_j)) & = delta_(i j) \
     vb(e_i)^TT matbold(A)^TT matbold(A) vb(e_j) & = delta_(i j).
  $
  But $vb(e_i)^TT matbold(M) vb(e_j)$ is the $(i, j)$th entry of the matrix $matbold(M)$, so this shows that the $(i, j)$th entry of $matbold(A)^TT matbold(A)$ is $delta_(i j)$ for all $i, j$. Therefore $matbold(A)^TT matbold(A) = matbold(I_n)$.

  #fade[[(3) $=>$ (1).]]

  Suppose $vb(u), vb(v) in RR^n$. then
  $
    (matbold(A) vb(u)) dot (matbold(A) vb(v)) & = (matbold(A) vb(u))^TT (matbold(A) vb(v)) \
                                                  & = vb(u)^TT matbold(A)^TT matbold(A) vb(v) \
                                                  & = vb(u)^TT matbold(I_n) vb(v) \
                                                  & = vb(u) dot vb(v).
  $

  Hence $matbold(A) in O(n)$ as required.
]

Recall that $det matbold(A)^TT = det matbold(A)$. Therefore,
$
  1 = det(matbold(I_n)) = det(matbold(A)^TT matbold(A)) = det(matbold(A)^TT) dot det(matbold(A)) = (det matbold(A))^2.
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
  Any $vb(v) in RR^n \\ {0}$ defines an orthogonal plane $vb(v)^perp = P_vb(v) = {vb(x) in RR^n: vb(x) dot vb(v) = 0}$.

  The *#ponder("geometry.reflection")[reflection]* in $P_vb(v)$ is defined to be
  $
    S_vb(v) (vb(x)) = vb(x) - (2 (vb(x) dot vb(v))) / norm(vb(v))^2 vb(v).
  $

]
 <reflection>

#remark[

  1. We will sometimes write $S_P$ for the #ponder("geometry.reflection")[reflection] in the plane $P$.

  2. We may replace $vb(v)$ by $vb(v)/norm(vb(v))$ and assume that $norm(vb(v)) = 1$. then

    $
      S_vb(v) (vb(x)) = vb(x) - 2 (vb(x) dot vb(v)) vb(v).
    $
]

#lemma[#ponder("geometry.reflection-properties")[Properties of a reflection]][
  1. $S_vb(v)^2 = id$

  2. $S_vb(v) in O(n)$
]
 <reflection-properties>

#proof[
  We may assume that $norm(vb(v)) = 1$. From the definition, $S_vb(v)$ is linear in $vb(x)$. So we can think of $S_vb(v)$ as a matrix $matbold(S)_vb(v) in M_n (RR)$. Now,
  $
    (S_vb(v)(vb(x)) dot vb(v)) & = (vb(x) dot vb(v)) - 2 (vb(x) dot vb(v))( vb(v) dot vb(v)) \
                                     & = (vb(x) dot vb(v)) - 2 (vb(x) dot vb(v)) \
                                     & = - (vb(x) dot vb(v)).
  $
  So,
  $
    S_vb(v)^2(vb(x)) & = S_vb(v)(vb(x)) - 2 (S_vb(v)(vb(x)) dot vb(v)) vb(v) \
                         & = vb(x) - 2 (vb(x) dot vb(v)) vb(v) - 2 (- (vb(x) dot vb(v))) vb(v) \
                         & = vb(x).
  $
  So indeed $S_vb(v)^2 = id$. In particular, $S_vb(v)$ is invertible with #ponder("algebra.inverse-element")[inverse] $S_vb(v)$, So
  $
    matbold(S)_vb(v) in GL_n (RR).
  $
  Finally, for any $vb(x) in RR^n$,
  $
    norm(S_vb(v)(vb(x)))^2 & = (S_vb(v)(vb(x))) dot (S_vb(v)(vb(x))) \
    & = (vb(x) - 2 (vb(x) dot vb(v)) vb(v)) dot (vb(x) - 2 (vb(x) dot vb(v)) vb(v)) \
    & = vb(x) dot vb(x) - 4 (vb(x) dot vb(v)) (vb(x) dot vb(v)) + 4 (vb(x) dot vb(v))^2 (vb(v) dot vb(v)) \
    & = norm(vb(x))^2.
  $
  Hence $S_vb(v) in O(n)$ as required.
]

#remark[
  Let $norm(vb(v)) =1$, and pick an orthonormal basis ${vb(v_1), ..., vb(v)_(n-1)}$ for $P_vb(v)$. In the basis ${vb(v_1), ..., vb(v)_(n-1), vb(v)}$ for $RR^n$, $S_vb(v)$ has matrix
  $
    matbold(S)_vb(v) = mat(1, 0, ..., 0, 0; 0, 1, ..., 0, 0; dots.v, dots.v, dots.down, dots.v, dots.v; 0, 0, ..., 1, 0; 0, 0, ..., 0, -1)
  $
  so $det matbold(S)_vb(v) = -1$ and hence $S_vb(v) in O(n) \\ SO(n)$.
]

#theorem[#ponder("algebra.reflections-generate")[Reflections Generate $O(n)$]][
  Every $matbold(A) in O(n)$ is a product of at most $n$ #ponder("geometry.reflection")[reflections].
] <reflections-generate-on>

#proof[
  We will prove this by induction on $n$.

  *Base case.* When $n = 1$, $O(1) = {plus.minus 1} = lr(chevron.l S_vb(1) chevron.r) teq C_2$. The matrix $mat(-1)$ is the #ponder("geometry.reflection")[reflection] in the origin, so the result holds.

  *Inductive step.* Let ${vb(e_1), ..., vb(e_n)}$ be the standard basis for $RR^n$. Let $vb(v) = vb(e_n) - matbold(A) vb(e_n)$. #fade[[If $matbold(A) vb(e_n) = vb(e_n)$ then $vb(v) = vb(0)$ and $matbold(S)_vb(v)$ is undefined; but in that case $matbold(A)$ already preserves $P_(vb(e_n))$, and the induction below applied to $matbold(A)$ itself writes $matbold(A)$ as a product of at most $n-1$ #ponder("geometry.reflection")[reflections]. So we may assume $vb(v) != vb(0)$.]]

  Then $matbold(S)_vb(v) (matbold(A) vb(e_n)) = vb(e_n)$, #fade[[and since $matbold(S)_vb(v) matbold(A)$ is an #ponder("algebra.orthogonal-group")[orthogonal transformation], by @on-and-the-dot-product, dot products are preserved, and hence vectors that are orthogonal to $vb(e_n)$ are sent to some vector that is still orthogonal to $vb(e_n)$,]] so $matbold(S)_vb(v) matbold(A)$ preserves $P_(vb(e_n)) = RR^(n-1)times {0}$.

  By induction, there are $vb(v_1), ..., vb(v_(n-1)) in RR^(n-1)$ such that
  $
    matbold(S)_vb(v) matbold(A) = matbold(S)_vb(v_1) ... matbold(S)_vb(v_(n-1)) quad "on" RR^(n-1).
  $
  Since both sides also fix $vb(e_n)$, they also agree on $RR^n$. Therefore,
  $
    matbold(A) = matbold(S)_vb(v) matbold(S)_vb(v_1) ... matbold(S)_vb(v)_(n-1).
  $
]

#ponder("algebra.orthogonal-group")[Orthogonal transformations] are especially easy to analyse in low dimensions.

#lemma[Elements of $O(2)$][
  Let $matbold(A) in O(2)$.

  1. If $matbold(A) in.not SO(2)$ then $matbold(A)$ is a #ponder("geometry.reflection")[reflection].
  2. If $matbold(A) in SO(2)$ then $matbold(A)$ is a #ponder("geometry.rotation")[rotation] about $O$.
]  <elements-of-o2>

#proof[
  Recall that $det matbold(S)_vb(v) = -1$, so
  $det(matbold(S)_vb(v_1) matbold(S)_vb(v_2) ... matbold(S)_vb(v_k)) = (-1)^k$. By @reflections-generate-on, we may take $k <= 2$.

  1. If $matbold(A) in.not SO(2)$, then $k$ is odd and hence $k = 1$. So $matbold(A) = matbold(S)_vb(v_1)$ is a #ponder("geometry.reflection")[reflection].

  2. If $matbold(A) in SO(2)$, then $k$ is even, so unless $matbold(A) = matbold(I)$, we can write $matbold(A) = matbold(S)_vb(u) matbold(S)_vb(v)$ for some $vb(u), vb(v) in RR^2$ that are not parallel.

    We claim that $matbold(A) = matbold(S)_vb(u) matbold(S)_vb(v)$ only fixes the origin. #fade[[Here, we define a #ponder("geometry.rotation")[rotation] to be an #ponder("algebra.orthogonal-group")[orthogonal transformation] that only fixes the origin.]] Indeed, for $vb(x) !=0$, suppose
    $
      matbold(S)_vb(u) matbold(S)_vb(v) (vb(x)) = vb(x) <=> matbold(S)_vb(v) vb(x) = matbold(S)_vb(u) vb(x).
    $
    If $vb(x) - matbold(S)_vb(v) vb(x) != vb(0)$, then $vb(v)$ is parallel to $vb(x) - matbold(S)_vb(v) vb(x)$ and $vb(u)$ is parallel to $vb(x) - matbold(S)_vb(u) vb(x)$, so this implies that $vb(u)$ is parallel to $vb(v)$. #fade[[Otherwise $vb(x) - matbold(S)_vb(v) vb(x) = vb(0)$, so $vb(x) != vb(0)$ is fixed by $matbold(S)_vb(v)$ and hence also by $matbold(S)_vb(u)$; then the lines $P_vb(v)$ and $P_vb(u)$ in $RR^2$ both contain $vb(x)$ and so coincide, and again $vb(u)$ is parallel to $vb(v)$.]] $smash$

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
  By @reflections-generate-on, $matbold(A)$ is a product of at most $3$ #ponder("geometry.reflection")[reflections]. Since $det matbold(A) = 1$, either $matbold(A) = matbold(I)$ or $matbold(A) = matbold(S)_vb(u) matbold(S)_vb(v)$ for some $vb(u), vb(v) in RR^3$ that are not parallel. Since $n=3$, $ P_vb(u) inter P_vb(v) = l $
  where $l$ is a line through the origin. Since $P_vb(u)$ fixes $l$ pointwise and $P_vb(v)$ also fixes $l$ pointwise, their composition $matbold(A)$ also fixes $l$ pointwise. #fade[[We shall define a #ponder("geometry.rotation")[rotation] in $RR^3$ to be an #ponder("algebra.orthogonal-group")[orthogonal transformation] that fixes a line pointwise.]]

  Also $matbold(S)_vb(u) matbold(S)_vb(v) vb(x) = vb(x) => matbold(S)_vb(u) vb(x)= matbold(S)_vb(v) vb(x)$, similar to @elements-of-o2, either

  1. $vb(x) in l$, in which case $vb(x)$ is fixed by $matbold(A)$, or
  2. $vb(u)$ is parallel to $vb(v)$. $smash$

  Thus, $matbold(A)$ only fixes the line $l$ pointwise, and is therefore a #ponder("geometry.rotation")[rotation].
]
