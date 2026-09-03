#import "../prelude.typ": *

= Eigenvalues and Eigenvectors

#ponder("linear-algebra.eigenvalue-eigenvector")[Eigenvalues and eigenvectors] can be used to analyse and simplify matrices.

== Introduction

#theorem[Fundamental Theorem of Algebra][
  Let $p(z)$ be a polynomial of degree $m >= 1$. Then
  $
    p(z) = sum_(j=0)^m c_j z^j
  $
  where $c_j in CC$ and $c_m != 0$.

  Then $p(z) = 0$ has precisely $m$ roots in $CC$ (counting with multiplicities).
]

#definition[Multiplicity of a Root][
  A root $z = omega$ has #ponder("algebra.root-multiplicity")[*multiplicity*] $k$ if $(z-omega)^k$ is a factor of $p(z)$ but $(z-omega)^(k+1)$ is not.
] <def-root-multiplicity>

#definition[Eigenvector and Eigenvalue][
  Let $T: V-> V$ (for a #ponder("linear-algebra.vector-space")[real or complex vector space] $V$) be a #ponder("linear-algebra.linear-map")[linear map]. Then, a vector $bold(v) in V$ with $bold(v) != bold(0)$ is an #ponder("linear-algebra.eigenvalue-eigenvector")[*eigenvector*] of $T$ if there exists a scalar $lambda in RR$ (or $CC$) such that
  $ T(bold(v)) = lambda bold(v). $
  The scalar $lambda$ is called the #ponder("linear-algebra.eigenvalue-eigenvector")[*eigenvalue*] corresponding to the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] $bold(v)$.


  If $V in RR^n$ or $CC^n$, and $T$ is given in terms of a $n times n$ matrix $matbold(A)$, then
  $
    matbold(A) bold(v) = lambda bold(v) <=> (matbold(A) - lambda matbold(I)) bold(v) = 0.
  $
  and for a given $lambda$, this holds for some vector $bold(v) != 0$ if and only if $det(matbold(A) - lambda matbold(I)) = 0$. This is called the #ponder("linear-algebra.eigenvalue-eigenvector")[*characteristic equation*] of the matrix $matbold(A)$.

  Furthermore, the polynomial $chi_matbold(A) (lambda) = det(matbold(A) - lambda matbold(I))$ is called the #ponder("linear-algebra.eigenvalue-eigenvector")[*characteristic polynomial*] of degree $n$ of the matrix $matbold(A)$.
] <def-eigenvalue>

#lecture-separator(lecture: 18, date: "2025-11-18")

#remark[
  From the definition of the #ponder("linear-algebra.determinant")[determinant],
  $
    chi_(matbold(A))(t) & = det(matbold(A) - t matbold(I)) \
                        & = epsilon_(j_1,...,j_n) (A_(j_1 1) - t delta_( j_1 1)) ... (A_(j_n n) - t delta_(j_n n)) \
                        & = c_0 + c_1 t + c_2 t^2 + ... + c_n t^n
  $
  for some coefficients $c_0, c_1, ..., c_n$. From here we can conclude

  1. $chi_(matbold(A))(t)$ has degree $n$, and thus $n$ roots by the #ponder("algebra.fundamental-theorem-of-algebra")[fundamental theorem of algebra]. Hence, an $n times n$ matrix has $n$ #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] (#ponder("algebra.root-multiplicity")[counting multiplicities]).

  2. If $matbold(A), matbold(B)$ are real, then the coefficients $c_0, c_1, ..., c_n$ are real, and thus the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] are either real or come in complex conjugate pairs.

  3. $c_n = (-1)^n$ and $c_(n-1) = (-1)^(n-1) (tr matbold(A))$. By Vieta's formulas, the #ponder("linear-algebra.eigenvalue-eigenvector")[sum of the eigenvalues] is equal to the #ponder("linear-algebra.trace")[trace] of the matrix:
    $ sum_(i=1)^n lambda_i = tr matbold(A). $

  4. Finally,
    $
      c_0 = chi_(matbold(A))(0) = det matbold(A).
    $
    By Vieta's formulas, the #ponder("linear-algebra.eigenvalue-eigenvector")[product of the eigenvalues] is equal to the #ponder("linear-algebra.determinant")[determinant] of the matrix:
    $ product_(i=1)^n lambda_i = det matbold(A). $
]

#example[
  1. Consider $V = CC^2$ and $A = mat(0, -1; 1, 0)$ #fade[[representing a 90° #ponder("geometry.rotation")[rotation]]]. Then

    $
      chi_(matbold(A))(t) = det(matbold(A) - t matbold(I)) = det mat(-t, -1; 1, -t) = t^2 + 1.
    $
    Hence the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] are $lambda_1 = ii$ and $lambda_2 = -ii$. To find #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors], for $lambda = ii$, we have

    $
      mat(-ii, -1; 1, -ii) bold(v) = bold(0) => bold(v) = alpha vec(1, -ii).
    $

    For $lambda = -ii$, we have
    $
      mat(ii, -1; 1, ii) bold(v) = bold(0) => bold(v) = beta vec(1, ii).
    $

  2. Consider $V= RR^2$ with $A = mat(1, 1; 0, 1)$. Then

    $
      chi_(matbold(A))(t) = (t-1)^2.
    $
    Hence the only #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] is $lambda = 1$ with #ponder("algebra.root-multiplicity")[multiplicity] 2. To find #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors], we have
    $ mat(0, 1; 0, 0) bold(v) = bold(0) => bold(v) = alpha vec(1, 0) $
    for any $alpha in RR$.

]

== Eigenspaces and Multiplicity

#definition[Eigenspace][
  For an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$ of a matrix $matbold(A)$, we define its #ponder("linear-algebra.eigenspace")[*eigenspace*] as
  $
    E_lambda = {bold(v): matbold(A) bold(v) = lambda bold(v)} = ker (matbold(A) - lambda matbold(I)).
  $
] <def-eigenspace>

#definition[Algebraic multiplicity][
  The #ponder("linear-algebra.algebraic-multiplicity")[*algebraic multiplicity*] of an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$, $M(lambda)$ or $M_lambda$, is its #ponder("algebra.root-multiplicity")[multiplicity] as a root of the #ponder("linear-algebra.eigenvalue-eigenvector")[characteristic polynomial] $chi_(matbold(A))(lambda)$.

  By the #ponder("algebra.fundamental-theorem-of-algebra")[fundamental theorem of algebra], the sum of the #ponder("linear-algebra.algebraic-multiplicity")[algebraic multiplicities] of all #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] of an $n times n$ matrix is $n$.
] <def-algebraic-multiplicity>

#definition[Geometric multiplicity][
  The #ponder("linear-algebra.geometric-multiplicity")[*geometric multiplicity*] of an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$, $m(lambda)$ or $m_lambda$, is the #ponder("linear-algebra.dimension")[dimension] of its #ponder("linear-algebra.eigenspace")[eigenspace] $E_lambda$, _i.e._ the maximum number of #ponder("linear-algebra.linear-independence")[linearly independent] #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] corresponding to $lambda$.
] <def-geometric-multiplicity>

#proposition[
  Consider $matbold(A)$ an $n times n$ matrix, and $lambda$ an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] of $matbold(A)$. Then
  $ m_lambda <= M_lambda <= n. $
] <prop-matrix-algebraic-geometric-mult>

#definition[Defect][
  The #ponder("linear-algebra.defect")[*defect*] of an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$ is defined as
  $
    Delta_lambda = M_lambda - m_lambda.
  $
  By @prop-matrix-algebraic-geometric-mult, $Delta_lambda >= 0$.
] <def-defect>

#example[
  1. Consider $ matbold(A) = mat(4, 1, 0; 0, 4, 1; 0, 0, 4), quad chi_(matbold(A))(t) = (4-t)^3. $

    The #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] is $lambda = 4$ with #ponder("linear-algebra.algebraic-multiplicity")[algebraic multiplicity] $M_4 = 3$. To find the #ponder("linear-algebra.eigenspace")[eigenspace], we solve
    $
      mat(0, 1, 0; 0, 0, 1; 0, 0, 0) bold(v) = bold(0) => bold(v) = alpha vec(1, 0, 0).
    $

    Therefore, #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] is $vec(1, 0, 0)$ with #ponder("linear-algebra.geometric-multiplicity")[geometric multiplicity] $m_4 = 1$.

    #ponder("linear-algebra.eigenspace")[Eigenspace] is $E_4 = span{vec(1, 0, 0)}$ with $dim E_4 = 1$.

  2. Consider a #ponder("geometry.reflection")[reflection matrix] in $RR^3$ in plane through $bold(0)$ with normal $bold(n)$. Then we have
    $
      matbold(H) bold(n) = - bold(n), quad matbold(H) bold(v) = 1 bold(v) quad forall bold(v) perp bold(n).
    $

    Hence the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] are $lambda_1 = -1$ and $lambda_2 = 1$. We have
    $
      E_(-1) & = {alpha bold(n)}                    & quad M_(-1) & = m_(-1) = 1. \
         E_1 & = {bold(x): bold(x) dot bold(n) = 0} &    quad M_1 & = m_1 = 2.
    $

  3. Consider a #ponder("geometry.rotation")[rotation] in $RR^2$

    $
      matbold("Rot")(theta) = mat(cos theta, -sin theta; sin theta, cos theta).
    $

    We have

    $
      chi_(matbold("Rot")(theta))(t) & = t^2 - 2 (cos theta) t + 1 \
                       lambda_(1, 2) & = ee^(plus.minus ii theta) \
                             bold(v) & = alpha vec(1, minus.plus ii).
    $

  4. Consider a #ponder("geometry.rotation")[rotation] by angle $theta$ about $bold(n)$. Then

    $
      matbold("Rot")(theta, bold(n)) bold(n) = bold(n),
    $
    and we have an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda = 1$ with #ponder("linear-algebra.eigenspace")[eigenspace]
    $
      E_1 = span {bold(n)}.
    $
    There are no other #ponder("linear-algebra.eigenvalue-eigenvector")[real eigenvalues unless] $theta = k ppi$ for some integer $k$. A #ponder("geometry.rotation")[rotation] restricted to the plane that is perpendicular to $bold(n)$ has #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] $ee^(plus.minus ii theta)$.

  5. Consider the matrix

    $
      matbold(A) = mat(-3, -1, 1; -1, -3, 1; -2, -2, 0), quad chi_(matbold(A))(t) = -(t+2)^3.
    $
    Then the only #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] is $lambda = -2$ with #ponder("linear-algebra.algebraic-multiplicity")[algebraic multiplicity] $M_(-2) = 3$. To find the #ponder("linear-algebra.eigenspace")[eigenspace], we solve
    $
      mat(-1, -1, 1; -1, -1, 1; -2, -2, 2) bold(v) = bold(0)
    $
    and we have a general solution $vec(x, y, x+y)$. Therefore, the #ponder("linear-algebra.eigenspace")[eigenspace] is
    $
      E_(-2) = span {vec(1, 0, 1), vec(0, 1, 1)}
    $
    with #ponder("linear-algebra.geometric-multiplicity")[geometric multiplicity] $m_(-2) = 2$.

    The #ponder("linear-algebra.defect")[defect] is $Delta_(-2) = 3 - 2 = 1$. The #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] do not form a #ponder("linear-algebra.basis")[basis] for $CC^3$.

]

== Diagonolisation and Similarity

#proposition[
  For an $n times n$ matirx $matbold(A)$ acting on $V = RR^n$ or $CC^n$, the following are equivalent:

  - There exists a #ponder("linear-algebra.basis")[basis] of $V$ consisting of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $matbold(A)$. _i.e._ we have ${bold(v_1), ..., bold(v_n)}$ where $ matbold(A) bold(v_i) = lambda_i bold(v_i) $ for some #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda_i$.

  - $matbold(A)$ is #ponder("linear-algebra.diagonalisable-matrix")[diagonalisable], _i.e._ there exists an $n times n$ #ponder("algebra.matrix-invertibility")[invertible] matrix $matbold(P)$ such that
    $
      matbold(P)^(-1) matbold(A) matbold(P) = matbold(D)
    $
    where $matbold(D)$ is a diagonal matrix, with the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] of $matbold(A)$ on the diagonal:
    $
      matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n).
    $
] <prop-diagonalisable>

#definition[Diagonalisable Matrix][
  An $n times n$ matrix $matbold(A)$ is called #ponder("linear-algebra.diagonalisable-matrix")[*diagonalisable*] if it satisfies the conditions of @prop-diagonalisable.
] <def-diagonalisable>

We will prove @prop-diagonalisable in the following section.

#lecture-separator(lecture: 19, date: "2025-11-20")

=== Linearly Independent Eigenvectors

#theorem[
  Suppose that an $n times n$ matrix $matbold(M)$ has #ponder("linear-algebra.eigenvalue-eigenvector")[distinct eigenvalues] $lambda_1, lambda_2, ..., lambda_r$. Then the corresponding #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $bold(v_1), bold(v_2), ..., bold(v_r)$ are #ponder("linear-algebra.linear-independence")[linearly independent].
] <thm-independent-eigenvectors>

#remark[
  Let $B_lambda$ be a #ponder("linear-algebra.basis")[basis] for #ponder("linear-algebra.eigenspace")[eigenspace] $E_lambda$ associated to $lambda$. If $lambda_1, ..., lambda_r$ are distinct, then $B_(lambda_1) union B_(lambda_2) union ... union B_(lambda_r)$ is #ponder("linear-algebra.linear-independence")[linearly independent].
]

#proof[
  We shall #ponder("set-theory.proof")[prove] this by contradiction. Suppose that ${bold(v_1), ..., bold(v_r)}$ are #ponder("linear-algebra.linear-independence")[linearly dependent], such that
  $
    sum_(j=1)^r alpha_j bold(v_j) = bold(0)
  $
  for some scalars $alpha_j$, not all zero.

  Take the minimal $p$ for which $exists alpha_1, ..., alpha_p != 0$ with #fade[[reordering if necessary]]
  $
    sum_(j=1)^p alpha_j bold(v_j) = bold(0).
  $
  Then, applying $matbold(A) - lambda_1 matbold(I)$ gives

  $
    (matbold(A) - lambda_1 matbold(I)) sum_(j=1)^p alpha_j bold(v_j) = sum_(j > 1) alpha_j (lambda_j - lambda_1) bold(v_j) = bold(0).
  $

  which is a #ponder("linear-algebra.linear-combination")[linear combination] of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] with $p-1$ non-zero coefficients. This contradicts the minimality of $p$. $smash$
]

Now, we can prove @prop-diagonalisable.

#proof[
  #fade[[of @prop-diagonalisable]]

  For any matrix $matbold(P)$,

  - $matbold(A P)$ has columns $matbold(A) bold(C_i)(matbold(P))$
  - $matbold(P D)$ has columns $lambda_i bold(C_i)(matbold(P))$

  where $bold(C_i)(matbold(P))$ is the $i$th column of $matbold(P)$.

  This means that
  $
    matbold(P)^(-1) matbold(A) matbold(P) = matbold(D) <=> matbold(A P) = matbold(P D) <=> matbold(A) bold(v_i) = lambda_i bold(v_i) quad forall i = 1, ..., n
  $
  where $bold(v_i) = bold(C_i)(matbold(P))$.

  #fade[[$=>$]] Given a #ponder("linear-algebra.basis")[basis] of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors], we can construct $matbold(P)$ with these #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] as columns, and the above holds.

  #fade[[$arrow.l.double$]] Given $matbold(P)$ such that the above holds, the columns of $matbold(P)$ are #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $matbold(A)$. Since $matbold(P)$ is #ponder("algebra.matrix-invertibility")[invertible], its columns form a #ponder("linear-algebra.basis")[basis] of $V$.
]

=== Criteria for Diagonalisability

1. #fade[[_Sufficient_ but _not necessary_]] An $n times n$ matrix $matbold(A)$ with $n$ #ponder("linear-algebra.eigenvalue-eigenvector")[distinct eigenvalues] is #ponder("linear-algebra.diagonalisable-matrix")[diagonalisable].

  This implies the existence of $n$ #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] which are #ponder("linear-algebra.linear-independence")[linearly independent], and then this provides a #ponder("linear-algebra.basis")[basis] for $RR^n$ or $CC^n$.


2. #fade[[_Sufficient_ and _necessary_]] For any #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$,
  $
    M_lambda = m_lambda.
  $

  If $lambda_i$ with $i = 1, ..., r$ are all the different #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] of a matrix, then $B_(lambda_1) union ... union B_(lambda_r)$ is a #ponder("linear-algebra.linear-independence")[linearly independent] set, and its number of elements is
  $ sum_(i=1)^r m_(lambda_i) = sum_(i=1)^r M_(lambda_i) = n. $
  Hence, it forms a #ponder("linear-algebra.basis")[basis] of $RR^n$ or $CC^n$.

=== Similarity

#definition[
  We say that two matrices $matbold(A)$ and $matbold(B)$ of size $n times n$ are #ponder("linear-algebra.similar-matrices")[similar] if
  $
    matbold(B) = matbold(P)^(-1) matbold(A) matbold(P).
  $
  for some #ponder("algebra.matrix-invertibility")[invertible] matrix $matbold(P)$.
] <def-similar-matrices>

#proposition[
  If $matbold(A)$ and $matbold(B)$ are #ponder("linear-algebra.similar-matrices")[similar], then,

  1. $tr(matbold(A)) = tr(matbold(B))$
  2. $det(matbold(A)) = det(matbold(B))$
  3. $chi_(matbold(A))(t) = chi_(matbold(B))(t)$

  So #ponder("linear-algebra.similar-matrices")[similar matrices] represent the same #ponder("linear-algebra.linear-map")[linear map] with respect to different #ponder("linear-algebra.basis")[bases].
]

#remark[
  For the particular case of
  $
    matbold(B) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n),
  $
  this means that $matbold(A)$ is #ponder("linear-algebra.diagonalisable-matrix")[diagonalisable], and then
  1. $tr(matbold(A)) = sum_(i=1)^n lambda_i$
  2. $det(matbold(A)) = product_(i=1)^n lambda_i$
  3. $chi_(matbold(A))(t) = product_(i=1)^n (lambda_i - t)$
]

=== Hermitian and Symmetric Matrices

Recall that a matrix $matbold(A)$ is called #ponder("linear-algebra.hermitian-matrix")[Hermitian] if $matbold(A) = matbold(A)^dagger$, and #ponder("linear-algebra.symmetric-matrix")[symmetric] if $matbold(A) = matbold(A)^top$.

Recall that the #ponder("linear-algebra.inner-product")[complex inner product] is defined as $bold(v)^dagger bold(w)$. For $bold(v), bold(w) in RR$, this reduces to the #ponder("linear-algebra.dot-product")[dot product] $bold(v) dot bold(w)$.

#remark[
  If $matbold(A)$ is #ponder("linear-algebra.hermitian-matrix")[Hermitian],
  $
    (matbold(A) bold(v))^dagger bold(w) = bold(v)^dagger (matbold(A) bold(w))
  $

]

#theorem[
  For a #ponder("linear-algebra.hermitian-matrix")[Hermitian matrix] $matbold(A)$ of size $n times n$,

  1. Every #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] of $matbold(A)$ is real.

  2. #ponder("linear-algebra.eigenvalue-eigenvector")[Eigenvectors] $bold(v), bold(w)$ corresponding to #ponder("linear-algebra.eigenvalue-eigenvector")[distinct eigenvalues] $lambda, mu$ are #ponder("linear-algebra.orthogonality")[orthogonal].

  3. If $matbold(A)$ is #ponder("linear-algebra.symmetric-matrix")[symmetric], then for each #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$, we can choose a real #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] $bold(v)$ so that (2) becomes
    $
      bold(v)^tp bold(w) = 0.
    $
] <thm-hermitian-eigenvalues>

#proof[

  1. Consider an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] $matbold(v)$ with #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda$. We have

    $
          & bold(v)^dagger (matbold(A) bold(v)) =( matbold(A) bold(v))^dagger bold(v) \
      <=> & lambda bold(v)^dagger bold(v) = (overline(lambda) bold(v))^dagger bold(v). \
    $
    Since $bold(v) != 0$, we have $lambda = overline(lambda)$, so $lambda in RR$.

  2. Let $bold(v), bold(w)$ be #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] with #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] $lambda, mu$. Then

    $
      & bold(v)^dagger (matbold(A) bold(w)) & =& (matbold(A) bold(v))^dagger bold(w) \
      <=> & mu bold(v)^dagger bold(w) & = &overline(mu) bold(v)^dagger bold(w) &= mu bold(v)^dagger bold(w) quad (lambda "real"). \
    $
    Since $lambda != mu$, we have $bold(v)^dagger bold(w) = 0$.

  3. We have $matbold(A) bold(v) = lambda bold(v)$ with $bold(v) in CC^n$ and $matbold(A), lambda$ are real. Let $bold(v) = bold(u) + ii bold(u')$, with $bold(u), bold(u') in RR^n$. Then we have
    $
      cases(
        matbold(A) bold(u) = lambda bold(u),
        matbold(A) bold(u') = lambda bold(u')
      )
    $
    but $matbold(v) != bold(0)$ since it is an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector], so at least one of $bold(u), bold(u')$ is non-zero, and we can choose this as a real #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector].

]

#lecture-separator(lecture: 20, date: "2025-11-22")

=== Gram-Schmidt Orthogonalisation

Given a #ponder("linear-algebra.linear-independence")[linearly independent] set of vectors in $CC^n$, say ${bold(w_1), ..., bold(w_r)}$. We can construct a sequence of sets of the form:

- ${bold(u_1), bold(w'_2), ..., bold(w'_r)}$
- ${bold(u_1), bold(u_2), bold(w''_3), ..., bold(w''_r)}$
- ...
- ${bold(u_1), bold(u_2), ..., bold(u_r)}$

so that each set has the same #ponder("linear-algebra.span")[span], each is #ponder("linear-algebra.linear-independence")[linearly independent], and $bold(u_i)$ are #ponder("linear-algebra.orthonormal")[orthonormal] to each other, and #ponder("linear-algebra.orthogonality")[orthogonal] to the $bold(w)$-vectors.

We construct this as follows:

- *First step.* Let $bold(u_1) = bold(w_1)/abs(bold(w_1))$ and $bold(w'_j) = bold(w_j) - (bold(u_1^dagger) bold(w_j)) bold(u_1)$.

  This guarantees that $abs(bold(u_1)) = 1$ and $bold(u_1^dagger) bold(w'_j) = 0$ for all $j >= 2$.

- *Next step.* Let $bold(u_2) = bold(w'_2)/abs(bold(w'_2))$ and $bold(w''_j) = bold(w'_j) - (bold(u_2^dagger) bold(w'_j)) bold(u_2)$.

  This guarantees that $abs(bold(u_2)) = 1$ and
  $
    cases(
      bold(u_2^dagger) bold(u_1) = 0,
      bold(u_1^dagger) bold(w''_j) = 0,
      bold(u_2^dagger) bold(w''_j) = 0
    )
  $
  for all $j >= 3$.

- *Continue similarly* until we reach $bold(u_r)$.

We then find an #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis] $B_lambda$ for each #ponder("linear-algebra.eigenspace")[eigenspace] $E_lambda$ of a #ponder("linear-algebra.hermitian-matrix")[Hermitian matrix] $matbold(A)$.

Then, if $lambda_1, ..., lambda_r$ are the #ponder("linear-algebra.eigenvalue-eigenvector")[distinct eigenvalues] of $matbold(A)$, we have that
$
  B = B_(lambda_1) union B_(lambda_2) union ... union B_(lambda_r)
$
is an #ponder("linear-algebra.orthonormal")[orthonormal] set of $CC^n$ consisting of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $matbold(A)$.

=== Unitary and Orthogonal Diagonolisation

#theorem[
  Let $matbold(A)$ be a #ponder("linear-algebra.hermitian-matrix")[hermitian matrix] of size $n times n$. Then, $matbold(A)$ is #ponder("linear-algebra.diagonalisable-matrix")[diagonalisable].

  More specifically,

  1. There exists a #ponder("linear-algebra.basis")[basis] of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $bold(u_1), ..., bold(u_n) in CC^n$ with
    $
      matbold(A) bold(u_i) = lambda_i bold(u_i)
    $
    for #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] $lambda_i$;

  and equivalently,

  2. There exists an $n times n$ #ponder("algebra.matrix-invertibility")[invertible] matrix $matbold(P)$ such that
    $
      matbold(P)^(-1) matbold(A) matbold(P) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n).
    $
    with the columns of $matbold(P)$ representing the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $bold(v_i)$.
] <thm-hermitian-diagonalisation>

#remark[
  In addition, the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $matbold(u_i)$ can be chosen to be #ponder("linear-algebra.orthonormal")[orthonormal], so that $bold(u_i^dagger) bold(u_j) = delta_(i j)$.

  Equivalently, the matrix $matbold(P)$ can be chosen to be #ponder("linear-algebra.unitary-matrix")[unitary], so that $matbold(P)^dagger = matbold(P)^(-1)$, and that
  $
    matbold(P^dagger) matbold(A) matbold(P) = matbold(D).
  $
]

#remark[
  For an $n times n$ real #ponder("linear-algebra.symmetric-matrix")[symmetric matrix] $matbold(A)$, the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] can be taken to be $bold(u_1), ..., bold(u_n) in RR^n$, and can be chosen such that
  $
    bold(u_i^tp) bold(u_j) = delta_(i j).
  $
  Equivalently, $matbold(P)$ can be chosen to be #ponder("algebra.orthogonal-group")[orthogonal], so that $matbold(P)^tp = matbold(P)^(-1)$, and that
  $ matbold(P^tp) matbold(A) matbold(P) = matbold(D). $
]

== Change of Basis

Consider $V, W$ to be #ponder("linear-algebra.vector-space")[real or complex vector spaces], with
$
  dim V = n, quad dim W = m, quad T: V-> W quad ("linear map").
$
and

- ${bold(e_1), ..., bold(e_n)}$ to be a #ponder("linear-algebra.basis")[basis] of $V$;
- ${bold(f_1), ..., bold(f_m)}$ to be a #ponder("linear-algebra.basis")[basis] of $W$,

such that $T$ is represented by the $m times n$ matrix $matbold(A)$ with respect to these #ponder("linear-algebra.basis")[bases]. This means that

$
  T(bold(e_i)) = sum_(j=1)^m A_(j i) bold(f_j).
$

Now consider

- ${bold(e'_1), ..., bold(e'_n)}$ to be another basis of $V$;
- ${bold(f'_1), ..., bold(f'_m)}$ to be another basis of $W$.

In this case, $T$ is represented by another $m times n$ matrix $matbold(B)$ with respect to these new #ponder("linear-algebra.basis")[bases], such that

$
  T(bold(e'_i)) = sum_(j=1)^m B_(j i) bold(f'_j).
$

Suppose that the bases are related by
$
  bold(e'_i) = sum_k P_(k i) bold(e_k), quad bold(f'_j) = sum_l Q_(l j) bold(f_l)
$
where $matbold(P)$ of size $n times n$ and $matbold(Q)$ of size $m times m$ are #ponder("algebra.matrix-invertibility")[invertible] matrices.

#proposition[
  With $matbold(A), matbold(B), matbold(P), matbold(Q)$ as above, we have
  $
    matbold(B) = matbold(Q)^(-1) matbold(A) matbold(P).
  $
  This defines the #ponder("algebra.matrix-change-of-basis")[change of basis formula] for matrices representing #ponder("linear-algebra.linear-map")[linear maps].

  $matbold(P)$ and $matbold(Q)$ are called the #ponder("algebra.matrix-change-of-basis")[*change of basis matrices*].
]

#proof[
  We have
  $
    T(bold(e'_i)) & = T(sum_k P_(k i) bold(e_k)) \
                  & = sum_k P_(k i) T(bold(e_k)) \
                  & = sum_(k, j) bold(f_j) A_(j k) P_(k i) \
  $
  and also
  $
    T(bold(e'_i)) & = sum_j bold(f'_j) B_(j i) \
                  & = sum_(j, l) bold(f_l) Q_(l j) B_(j i) \
                  & = sum_(k, j) bold(f_j) Q_(j k) B_(k i). quad ("exchanging indices") \
  $
  Comparing coefficients of $bold(f_j)$, we have, in summation notation,
  $
    A_(j k) P_(k i) = Q_(j k) B_(k i).
  $
  Therefore,
  $
    matbold(A) matbold(P) = matbold(Q) matbold(B) <=> matbold(B) = matbold(Q)^(-1) matbold(A) matbold(P).
  $
]

#remark[

  - The definition of $matbold(A)$ which represents $T$ with respect to ${bold(e_i)}$ and ${bold(f_j)}$ implies that the column $i$ of $matbold(A)$ consists of the components of $T(bold(e_i))$ in the #ponder("linear-algebra.basis")[basis] ${bold(f_j)}$.

  - Similarly, the column $i$ of $matbold(P)$ consists of the components of $bold(e'_i)$ in the #ponder("linear-algebra.basis")[basis] ${bold(e_j)}$.

  - If we instead change in the other direction, _i.e._ from ${bold(e'_i)}$ to ${bold(e_i)}$ and from ${bold(f'_j)}$ to ${bold(f_j)}$, then $matbold(P') = matbold(P)^(-1)$ and $matbold(Q') = matbold(Q)^(-1)$, such that
    $
      bold(e_i) = sum_k P'_(k i) bold(e'_k), quad bold(f_j) = sum_l Q'_(l j) bold(f'_l).
    $

]

#example[
  Consider $dim V = n = 2$ and $dim W = m = 3$, with
  $
    T(bold(e_1)) & = bold(f_1) + 2 bold(f_2) - bold(f_3) \
    T(bold(e_2)) & = - bold(f_1) + 2 bold(f_2) + bold(f_3).
  $
  Thus, $matbold(A)$ is represented by
  $
    matbold(A) = mat(1, -1; 2, 2; -1, 1).
  $
  Now consider a #ponder("linear-algebra.basis")[basis] for $V$ formed by ${bold(e'_1), bold(e'_2)}$ that relates to ${bold(e_1), bold(e_2)}$ by
  $ bold(e'_1) = bold(e_1) - bold(e_2), quad bold(e'_2) = bold(e_1) + bold(e_2). $
  Hence we have
  $
    matbold(P) = mat(1, 1; -1, 1).
  $
  For $W$, consider a #ponder("linear-algebra.basis")[basis] formed by ${bold(f'_1), bold(f'_2), bold(f'_3)}$ that relates to ${bold(f_1), bold(f_2), bold(f_3)}$ by
  $
    bold(f'_1) = bold(f_1) - bold(f_3), quad bold(f'_2) = bold(f_2), quad bold(f'_3) = bold(f_1) + bold(f_3).
  $
  Hence we have
  $
    matbold(Q) = mat(1, 0, 1; 0, 1, 0; -1, 0, 1).
  $
  Therefore, the matrix $matbold(B)$ representing $T$ with respect to the new
  #ponder("linear-algebra.basis")[bases] is given by
  $
    matbold(B) = matbold(Q)^(-1) matbold(A) matbold(P) = mat(2, 0; 0, 4; 0, 0) => cases(
      T(bold(e'_1)) = 2 bold(f'_1),
      T(bold(e'_2)) = 4 bold(f'_2)
    )
  $
]

#remark[
  #fade[[Special cases]]

  1. If $V = W$ with the same basis change, _i.e._ $bold(e'_i) = bold(e_i)$ and $bold(f'_j) = bold(f_j)$, then $bold(P) = bold(Q)$ and
    $
      matbold(B) = matbold(P)^(-1) matbold(A) matbold(P).
    $
    Therefore, matrices represent the same #ponder("linear-algebra.linear-map")[linear map] $T: V-> V$ iff they are #ponder("linear-algebra.similar-matrices")[similar].

  2. If $V = W = RR^n "or" CC^n$, consider for both the #ponder("linear-algebra.basis")[standard basis] ${bold(e_i)}$, then if there exists a #ponder("linear-algebra.basis")[basis] of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $T$ denoted by ${bold(v_1), ..., bold(v_n)}$, denote ${bold(e'_i) = bold(v_i)}$, and define $matbold(B)$ to be the matrix representing $T$ with respect to this #ponder("linear-algebra.basis")[basis]. Then,
    $
      matbold(B) = matbold(P)^(-1) matbold(A) matbold(P)
    $
    where $matbold(P)$ has columns given by the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $bold(v_i)$. By @prop-diagonalisable, $matbold(B)$ is diagonal, with the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] of $T$ on the diagonal. So
    $
      matbold(B) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n).
    $
    where $T(bold(v_i)) = lambda_i bold(v_i)$ for each $i$, and thus $matbold(D) = matbold(P)^(-1) matbold(A) matbold(P)$ such that

    Since $bold(v_i) = sum_j bold(e_j) P_(j i)$ is the $i$th #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] of $T$, the columns of $matbold(P)$ are the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $T$ expressed in the #ponder("linear-algebra.basis")[standard basis]. Therefore, $matbold(P)$ is the #ponder("algebra.matrix-change-of-basis")[change of basis matrix], and is also the matrix that #ponder("linear-algebra.diagonalisable-matrix")[diagonalises] $matbold(A)$.
]

#lecture-separator(lecture: 21, date: "2025-11-25")

=== Changes in Vector Components Under Change of Basis

Consider $V$ a #ponder("linear-algebra.vector-space")[vector space] and $bold(x) in V$. Assume that ${bold(e_i)}$ and ${bold(e'_i)}$ are two different #ponder("linear-algebra.basis")[bases] of $V$, related by $matbold(P)$ and
$
  bold(x) = x_i bold(e_i) = x'_i bold(e'_i).
$
Then, taking into account that $bold(e'_j) = bold(e_i) P_(i j)$, we have
$
  bold(x) = underbracket(x_i bold(e_i)) = x'_j bold(e_i) P_(i j) = underbracket((P_(i j) x'_j) bold(e_i))
$
and hence
$
  x_i = P_(i j) x'_j.
$
and this is the relation between vector components with respect to #ponder("linear-algebra.basis")[bases] related by $matbold(P)$. We can write

$
  bold(x) = vec(x_1, dots.v, x_n) = mat(P_(1 1), ..., P_(1 n); dots.v, dots.down, dots.v; P_(n 1), ..., P_(n n)) vec(x'_1, dots.v, x'_n) = matbold(P) vec(x'_1, dots.v, x'_n)
$
and thus
$
  bold(x) = matbold(P) bold(x').
$
Similarly, consider #ponder("linear-algebra.vector-space")[vector space] $W$ and $bold(y) in W$. Assume that ${bold(f_j)}$ and ${bold(f'_j)}$ are two different #ponder("linear-algebra.basis")[bases] of $W$ such that
$
  bold(y) = y_j bold(f_j) = y'_j bold(f'_j)
$
and with #ponder("linear-algebra.basis")[bases] related by $matbold(Q)$. Then, we have
$
  bold(y) = matbold(Q) bold(y').
$
Now, if we consider the definition of a #ponder("linear-algebra.linear-map")[linear map] $T: V->W$ in terms of a matrix $matbold(A)$, we have
$
  bold(y) = T(bold(x)) <=> bold(y) = matbold(A) bold(x) quad "and" quad bold(y') = matbold(B) bold(x').
$
Therefore,
$
  bold(y') = matbold(Q)^(-1) bold(y) = matbold(Q)^(-1) matbold(A) bold(x) = matbold(Q)^(-1) matbold(A) matbold(P) bold(x') = matbold(B) bold(x').
$
This recovers the #ponder("algebra.matrix-change-of-basis")[change of basis formula] for matrices representing #ponder("linear-algebra.linear-map")[linear maps]:
$
  matbold(B) = matbold(Q)^(-1) matbold(A) matbold(P).
$

== Cayley-Hamilton Theorem

#theorem[Cayley-Hamilton Theroem][
  Let $matbold(A)$ be an $n times n$ matrix with
  $
    chi_(matbold(A)) (t) = det(matbold(A) - t matbold(I)) = sum_(r = 0)^n c_r t^r.
  $
  Then,
  $
    chi_(matbold(A))(matbold(A)) = sum_(r = 0)^n c_r matbold(A)^r = matbold(0).
  $
] <thm-cayley-hamilton>

#proof[

  1. Consider a general matrix of size $2times 2$. Then
    $
      matbold(A) = mat(A_(11), A_(12); A_(21), A_(22)) => chi_(matbold(A))(t) = t^2 - (A_(11) + A_(22)) t + (A_(11) A_(22) - A_(12) A_(21)).
    $
    Then, checking by direct substitution gives the result.

  2. For a #ponder("linear-algebra.diagonalisable-matrix")[diagonolisable] $n times n$ matrix, consider $matbold(A)$ with #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] $lambda_i$, along with an #ponder("algebra.matrix-invertibility")[invertible] matrix $matbold(P)$ such that
    $
      matbold(P)^(-1) matbold(A) matbold(P) = matbold(D) = mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n).
    $
    Note that we can compute powers of $matbold(D)$ easily:
    $
      matbold(D)^r = mat(lambda_1^r, 0, ..., 0; 0, lambda_2^r, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_n^r).
    $
    Thus
    $
      chi_(matbold(A)) (matbold(D)) = sum_(r=0)^n c_r matbold(D)^r = mat(chi_(matbold(A))(lambda_1), 0, ..., 0; 0, chi_(matbold(A))(lambda_2), ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., chi_(matbold(A))(lambda_n)) = matbold(0).
    $
    But $matbold(A) = matbold(P) matbold(D) matbold(P)^(-1)$, and so $matbold(A^r) = (matbold(P) matbold(D) matbold(P)^(-1))^r = matbold(P) matbold(D)^r matbold(P)^(-1)$. Therefore,
    $
      chi_(matbold(A))(matbold(A)) & = sum_(r=0)^n c_r matbold(A)^r \
                                   & = sum_(r=0)^n c_r (matbold(P) matbold(D)^r matbold(P)^(-1)) \
                                   & = matbold(P) (sum_(r=0)^n c_r matbold(D)^r) matbold(P)^(-1) \
                                   & = matbold(P) matbold(0) matbold(P)^(-1) = matbold(0).
    $

  3. #fade[[Non-examinable.]] In the general case, let $matbold(M) := matbold(A) - t matbold(I)$, and $chi_(matbold(A)) (t) = det matbold(M)$.

    Recall that the #ponder("linear-algebra.adjugate")[adjugate matrix] $tilde(matbold(M))$ is defined such that
    $
      tilde(matbold(M)) matbold(M) = det(matbold(M)) matbold(I).
    $
    We will use
    $
      tilde(matbold(M)) = sum_(r=0)^(n-1) matbold(B_r) t^r.
    $
    Comparing coefficients of $t^n$ on both sides,
    $
      tilde(matbold(M)) matbold(M) &= sum_(r=0)^(n-1) matbold(B_r) t^r (matbold(A) - t matbold(I)) \
      & = matbold(B_0) matbold(A) + (matbold(B_1) matbold(A) - matbold(B_0)) t + ... + (matbold(B_(n-1)) matbold(A) - matbold(B_(n-2))) t^(n-1) - matbold(B_(n-1)) t^n \
    $
    and hence
    $
          c_0 matbold(I) & = matbold(B_0) matbold(A) \
          c_1 matbold(I) & = matbold(B_1) matbold(A) - matbold(B_0) \
                  dots.v & = dots.v \
      c_(n-1) matbold(I) & = matbold(B_(n-1)) matbold(A) - matbold(B_(n-2)) \
          c_n matbold(I) & = - matbold(B_(n-1)). \
    $
    evaluating in $matbold(A)$ gives
    $
                c_0 matbold(I) & = matbold(B_0) matbold(A) \
                c_1 matbold(A) & = matbold(B_1) matbold(A)^2 - matbold(B_0) matbold(A) \
                        dots.v & = dots.v \
      c_(n-1) matbold(A)^(n-1) & = matbold(B_(n-1)) matbold(A)^n - matbold(B_(n-2)) matbold(A)^(n-1) \
              c_n matbold(A)^n & = - matbold(B_(n-1)) matbold(A)^n.
    $
    Adding these equations gives
    $ sum_(r=0)^n c_r matbold(A)^r = matbold(0). $
    This completes the proof.
]

== Quadratic Forms

We wish to study functions of the form $x_1^2 + x_2^2$ or $2 x_1^2 + 2 x_1 x_2 + 5 x_2^2$ in $RR^2$, or more generally, a quadratic homogeneous polynomial of degree 2 in $n$ variables $x_1, ..., x_n$. It turns out that these can be written in matrix form as $bold(x)^tp matbold(A) bold(x)$ for some #ponder("linear-algebra.symmetric-matrix")[symmetric matrix] $matbold(A)$.

#definition[
  A #ponder("linear-algebra.quadratic-form")[*quadratic form*] is a function $cal(F) : RR^n -> RR$ defined by
  $
    cal(F)(bold(x)) = bold(x)^tp matbold(A) bold(x) = x_i A_(i j) x_j
  $
  where $matbold(A)$ is a real #ponder("linear-algebra.symmetric-matrix")[symmetric matrix] of size $n times n$.
] <def-quadratic-form>
We can hence write
$
  matbold(P)^tp matbold(A) matbold(P) = matbold(D)
$
where $matbold(D)$ is diagonal with #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] $lambda_1, ..., lambda_n$ on the diagonal, and $matbold(P)$ is a real #ponder("algebra.orthogonal-group")[orthogonal matrix] of size $n times n$ with columns given by #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $matbold(A)$.

Setting $bold(x') = matbold(P)^tp bold(x) <=> bold(x) = matbold(P) bold(x')$, we can #ponder("linear-algebra.diagonalisable-matrix")[diagonalise] the #ponder("linear-algebra.quadratic-form")[quadratic form]:
$
  cal(F) (bold(x)) & = bold(x)^tp matbold(A) bold(x) \
                   & = (matbold(P) bold(x'))^tp matbold(A) (matbold(P) bold(x')) \
                   & = bold(x')^tp (matbold(P)^tp matbold(A) matbold(P)) bold(x') \
                   & = bold(x')^tp matbold(D) bold(x') \
$
Therefore,
$
  cal(F) (bold(x)) = sum_(i=1)^n lambda_i (x'_i)^2.
$

Note that $bold(x')$ is the representation of $bold(x)$ in the #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis] of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] ${bold(u_1), ..., bold(u_n)}$ of $matbold(A)$, where $bold(u_i)$ is the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] corresponding to #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] $lambda_i$. Indeed, since the columns of $matbold(P)$ are the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $bold(u_i)$, we have
$
  bold(x') & = x'_1 bold(e_1) + ... + x'_n bold(e_n) \
   bold(x) & = x_1 bold(e_1) + ... + x_n bold(e_n) \
           & = x'_1 bold(u_1) + ... + x'_n bold(u_n) quad ("since" bold(x) = matbold(P) bold(x')) \
$
and
$
  x'_i = bold(u_i) dot bold(x)
$
are the components of $bold(x)$ in the #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis] of #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] ${bold(u_1), ..., bold(u_n)}$, with the new axes along these direction called the #ponder("linear-algebra.quadratic-form")[*principal axes*] of the #ponder("linear-algebra.quadratic-form")[quadratic form].

Since these are related to the standard axes by #ponder("algebra.orthogonal-group")[orthogonal] $matbold(P)$, we have
$
  abs(bold(x))^2 = x_i x_i = x'_i x'_i.
$

#example[
  In $RR^2$, consider $cal(F)(bold(x)) = bold(x)^tp matbold(A) bold(x)$ with $matbold(A) = mat(alpha, beta; beta, alpha)$.

  The #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] are $lambda_1 = alpha + beta, lambda_2 =alpha - beta$
  and the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] are
  $ bold(u_1) = (1)/(sqrt(2)) vec(1, 1), quad bold(u_2) = (1)/(sqrt(2)) vec(-1, 1). $
  Then
  $
    cal(F)(bold(x)) = alpha x_1^2 + 2 beta x_1 x_2 + alpha x_2^2 = (alpha + beta) (x'_1)^2 + (alpha - beta) (x'_2)^2
  $
  with
  $
    x'_1 = (1)/(sqrt(2)) (x_1 + x_2), quad x'_2 = (1)/(sqrt(2)) (- x_1 + x_2)\
  $

  _e.g._ take $alpha = (3)/(2)$, $beta = -(1)/(2)$, then $lambda_1 = 1$, $lambda_2 = 2$. Then if we set $cal(F) = 1$,
  $
    cal(F) (bold(x)) = (3)/(2) x_1^2 - x_1 x_2 + (3)/(2) x_2^2 = (x'_1)^2 + 2 (x'_2)^2 = 1.
  $
  defines an ellipse.

  _e.g._ take $alpha = -(1)/(2)$, $beta = (3)/(2)$, then $lambda_1 = 1, lambda_2 = -2$. Then if we set $cal(F) = 1$,
  $
    cal(F) (bold(x)) = -(1)/(2) x_1^2 + 3 x_1 x_2 - (1)/(2) x_2^2 = (x'_1)^2 - 2 (x'_2)^2 = 1.
  $
  defines a hyperbola.
]

#example[
  Consider
  $
    cal(F)(bold(x)) = bold(x)^tp matbold(A) bold(x) = lambda_1 (x'_1)^2 + lambda_2 (x'_2)^2 + lambda_3 (x'_3)^2.
  $
  1. If $lambda_1, lambda_2, lambda_3 > 0$, then
    $
      cal(F)(bold(x)) = 1
    $
    defines an ellipsoid.

    #align(center)[
      #dynamic-svg2("/part-ia/vectors-and-matrices/media/m1e3.svg", width: 17em)
    ]

  2. If $matbold(A) = mat(0, 1, 1; 1, 0, 1; 1, 1, 0)$, then the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] are $lambda_1 = lambda_2 = -1, lambda_3 = 2$, and the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] are
    $
      bold(u_1) = (1)/(sqrt(2)) vec(1, -1, 0), quad bold(u_2) = (1)/(sqrt(6)) vec(1, 1, -2), quad bold(u_3) = (1)/(sqrt(3)) vec(1, 1, 1).
    $
    Then,
    $
      cal(F)(bold(x)) = 2 (x'_3)^2 - (x'_1)^2 - (x'_2)^2 = 2 x_1x_2 + 2 x_2 x_3 + 2 x_3 x_1.
    $
    If we set $cal(F)(bold(x)) = 1$, it defines a two-sheeted hyperboloid.

    #align(center)[
      #dynamic-svg2("/part-ia/vectors-and-matrices/media/m1e1.svg", width: 17em)
    ]

    If we set $cal(F)(bold(x)) = -1$, it defines a one-sheeted hyperboloid.

    #align(center)[
      #dynamic-svg2("/part-ia/vectors-and-matrices/media/m1e2.svg", width: 17em)
    ]
]

#lecture-separator(lecture: 22, date: "2025-11-27")

#remark[
  Given a matrix $matbold(M)$, $matbold(M)$ can be decomposed as
  $
    matbold(M) = matbold(S) + matbold(A)
  $
  where $matbold(S)$ is #ponder("linear-algebra.symmetric-matrix")[symmetric] and $matbold(A)$ is #ponder("linear-algebra.symmetric-matrix")[antisymmetric]. Note that since $matbold(A)$ is #ponder("linear-algebra.symmetric-matrix")[antisymmetric], $bold(x)^tp matbold(A) bold(x) = 0$ for all $bold(x) in RR^n$. Therefore,
  $
    bold(x)^tp matbold(M) bold(x) = bold(x)^tp matbold(S) bold(x).
  $
  This is why we only consider #ponder("linear-algebra.symmetric-matrix")[symmetric matrices] in the definition of #ponder("linear-algebra.quadratic-form")[quadratic forms].
]

== Quadrics and Conics

=== Quadrics

#definition[Quadric][
  A #ponder("geometry.quadric")[*quadric*] in $RR^n$ is a hypersurface defined by
  $
    Q(bold(x)) = bold(x)^tp matbold(A) bold(x) + 2 bold(b)^tp bold(x) + c = 0
  $
  for some $n times n$ real #ponder("linear-algebra.symmetric-matrix")[symmetric matrix] $matbold(A)$, $bold(b) in RR^n$ and $c in RR$.
] <def-quadric>

Hence,
$
  Q(bold(x)) = A_(i j) x_i x_j + 2 b_i x_i + c = 0.
$

The purpose of this section is to classify the solutions of this kind of equations up to geomtrical equivalence. _i.e._ there is no distinction between solutions related by #ponder("geometry.isometry")[isometries] of $RR^n$, including

- translations,

- #ponder("algebra.orthogonal-group")[orthogonal transformations] about the origin.

If $matbold(A)$ to be #ponder("algebra.matrix-invertibility")[invertible], we can complete the square by setting
$
  bold(y) = bold(x) + (1)/(2) matbold(A)^(-1) bold(b),
$
then
$
  cal(F)(bold(y))= bold(y)^tp matbold(A) bold(y) &= bold(x)^tp matbold(A) bold(x) + bold(b)^tp bold(x) + (1)/(4) bold(b)^tp matbold(A)^(-1) bold(b)\
  &= (bold(x)^tp matbold(A) bold(x) + bold(b)^tp bold(x) + c) + (1)/(4) bold(b)^tp matbold(A)^(-1) bold(b) - c\
  &= Q(bold(x)) + (1)/(4) bold(b)^tp matbold(A)^(-1) bold(b) - c\
  &= Q(bold(x)) + k \
$
where $k = (1)/(4) bold(b)^tp matbold(A)^(-1) bold(b) - c$ is a constant.

Hence we have
$
  cal(F)(bold(y)) = k <=> Q(bold(x)) = 0.
$

Now we #ponder("linear-algebra.diagonalisable-matrix")[diagonolise] $cal(F)$ as for the #ponder("linear-algebra.quadratic-form")[quadratic forms] before. The #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] of $matbold(A)$ define #ponder("linear-algebra.quadratic-form")[principal axes] (the new coordinate axes), and the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] of $matbold(A)$ along with $k$ determine the shape of the #ponder("geometry.quadric")[quadric].

1. If all #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] $>0$ and $k > 0$, then we have an ellipsoid.

2. If #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] are of both signs and $k != 0$, then we have a hyperboloid.

3. If $matbold(A)$ has one or more zero #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues], then our analysis changes. It is simplest in the standard form, where we have linear and quadratic terms to analyse.

=== Conics

#definition[Conic][
  #ponder("geometry.quadric")[Quadrics] in $RR^2$ are curves called #ponder("geometry.conic")[*conics*].
] <def-conic>

- If $det matbold(A) != 0$, we get the form
  $
    lambda_1 (x'_1)^2 + lambda_2 (x'_2)^2 = k
  $
  which represents

  1. if $lambda_1, lambda_2 > 0$, then
    - if $k > 0$, an ellipse;
    - if $k = 0$, a point;
    - if $k < 0$, no solutions.

  2. if $lambda_1$ and $lambda_2$ have opposite signs, then
    - if $k != 0$, a hyperbola;
    - if $k = 0$, a pair of lines.

- If $det matbold(A) = 0$, consider $lambda_1 > 0$ and $lambda_2 = 0$. We can #ponder("linear-algebra.diagonalisable-matrix")[diagnoalise] $matbold(A)$ into the original formula for #ponder("geometry.quadric")[quadrics] to get
  $
    lambda_1 (x'_1)^2 + b'_1 x'_1 + b'_2 x'_2 + c & = 0. \
    lambda_1 (x'_1)^2 + b'_1 x'_1 +1/(4 lambda_1) (b'_1)^2 - 1/(4 lambda_1^2) (b'_1)^2 + b'_2 x'_2 + c & = 0 \
    lambda_1 underbracket((x'_1 + (b'_1)/(2 lambda_1))^2, bold(x''_1)) + b'_2 x'_2 + underbracket((c - (b'_1)^2/(4 lambda_1)), c') & = 0 \
    lambda_1 bold(x''_1)^2 + b'_2 x'_2 + c' & = 0. \
  $

  1. If $b'_2 = 0$, then the equation reduces to $lambda_1 bold(x''_1)^2 + c' = 0$. This represents
    - if $c' < 0$, a pair of lines;
    - if $c' = 0$, a single line;
    - if $c' > 0$, no solutions.

  2. If $b'_2 != 0$, we can write
    $
      lambda_1 (x''_1)^2 + b'_2 + x''_2 = 0
    $
    for $x''_2 = x'_2 + c'/b'_2$. This represents a parabola.

  Note that all changes of coordinates used here are #ponder("geometry.isometry")[isometries] of $RR^2$.

=== Standard Forms for Conics in Cartesian Coordinates

#example[
  Consider
  $
    (x^2)/(a^2) + (y^2)/(b^2) = 1.
  $
  - If #ponder("geometry.eccentricity")[eccentricity] $e < 1$, this is an ellipse, where the semi-major axis is $max(a, b)$ and the semi-minor axis is $min(a, b)$. We can write
    $
      b^2 = a^2 ( 1- e^2 )
    $
    and the foci are at $x = plus.minus a e$.

  - If #ponder("geometry.eccentricity")[eccentricity] $e = 1$, this is a parabola, with focus at $(a/2, 0)$ and
    $
      y^2 = 4 a x.
    $


  - If #ponder("geometry.eccentricity")[eccentricity] $e > 1$, this is a hyperbola, with semi-major axis $a$ and semi-minor axis $b$ related by
    $ b^2 = a^2 ( e^2 - 1 ). $
    The foci are at $x = plus.minus a e$.
]

#lecture-separator(lecture: 23, date: "2025-11-29")


=== Focus-Directrix Property of Conics

The four types of #ponder("geometry.conic")[conics] (ellipse, parabola, hyperbola, circle) are essentially four different types of cross-sections of a cone. They can also be defined in terms of a focus point and a directrix line.

Consider the expression for the conic:
$
  (x^2)/(a^2) + (y^2)/(b^2) = k.
$

#ponder("geometry.conic")[Conic sections] can be defined in terms of the followings.

#definition[Eccentricity][
  The #ponder("geometry.eccentricity")[*eccentricity*] $e$ is a non-negative parameter. The #ponder("geometry.eccentricity")[eccentricity] and scale properties of a #ponder("geometry.conic")[conic section] satisfy

  - the foci of a #ponder("geometry.conic")[conic] are $(plus.minus a e, 0)$;

  - the directrices are the vertical lines $x = plus.minus (a)/(e)$.
] <def-eccentricity>

A #ponder("geometry.conic")[conic] is the set of points whose distance from the focus is
$
  e times "distance from the closest directrix",
$
unless $e = 1$, in which we will take the other directrix.

We have the following cases.

1. $e < 1$, the #ponder("geometry.conic")[conic] is an ellipse.

  The equation of the ellipse is
  $
    sqrt((x - a e)^2 + y^2) = e dot ((a)/(e) - x)
  $
  or equivalently,
  $
    (x^2)/(a^2) + (y^2)/(a^2 (1 - e^2)) = 1
  $
  where $b = a sqrt(1 - e^2)$.


  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d7e1.svg", width: 20em)
  ]

  In this case, the semi-major axis is $a$ and the semi-minor axis is $b$. Additionally, if $e = 0$, the ellipse is a circle of radius $a$.

2. If $e > 1$, the #ponder("geometry.conic")[conic] is a hyperbola.

  The equation of the hyperbola is
  $
    sqrt((x - a e)^2 + y^2) = e dot (x - (a)/(e))
  $
  or equivalently,
  $
    (x^2)/(a^2) - (y^2)/(a^2 (e^2 - 1)) = 1
  $
  where $b = a sqrt(e^2 - 1)$.

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d7e2.svg", width: 20em)
  ]

3. If $e = 1$, the #ponder("geometry.conic")[conic] is a parabola.

  The equation of the parabola is
  $
    sqrt((x - a)^2 + y^2) & = (x+ a)
  $
  or equivalently,
  $
    y^2 = 4 a x.
  $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d7e3.svg", width: 20em)
  ]

=== Polar Coordinates

We introduce a new parameter $l$ such that $(l)/(e)$ is the distance from the focus to the directrix. Then,
$
  l = a abs(1 - e^2).
$
We can use polar coordinates $(r, theta)$ centered on a focus, such that the focus-directrix property is:

$
  r = e ((l)/(e) - r cos theta) <=> r = (l)/(1 + e cos theta).
$

#example[
  1. For an ellipse with $e < 1$, we have
    $
      r = (a (1 - e^2))/(1 + e cos theta) quad "where" quad l = a (1 - e^2).
    $


  2. For a hyperbola with $e > 1$, we have
    $
      r = (a (e^2 - 1))/(1 + e cos theta) quad "where" quad l = a (e^2 - 1).
    $

  3. For a parabola with $e = 1$, we have
    $
      r = (2 a)/(1 + cos theta) quad "where" quad l = 2 a.
    $
]

== Jordan Normal Forms

This gives us a classification for $n times n$ complex matrices up to #ponder("linear-algebra.similar-matrices")[similarity].

Consider a matrix $matbold(A)$ of size $n times n$ corresponding to a #ponder("linear-algebra.linear-map")[linear map] $T: CC^n -> CC^n$ and is #ponder("linear-algebra.similar-matrices")[similar] to a matrix $matbold(B)$ after a #ponder("algebra.matrix-change-of-basis")[change of basis].

#proposition[
  Any $2 times 2$ complex matrix $matbold(A)$ is #ponder("linear-algebra.similar-matrices")[similar] to one of the followings:

  1. $matbold(B) = mat(lambda_1, 0; 0, lambda_2)$ with $lambda_1 != lambda_2$, with $chi_matbold(A)(t) = (t - lambda_1)(t - lambda_2)$.

  2. $matbold(B) = mat(lambda, 0; 0, lambda)$, with $chi_matbold(A)(t) = (t - lambda)^2$.

  3. $matbold(B) = mat(lambda, 1; 0, lambda)$, with $chi_matbold(A)(t) = (t - lambda)^2$.
]

#proof[
  $chi_matbold(A) (t)$ has 2 roots, #ponder("algebra.root-multiplicity")[counting multiplicities], in $CC$. We have the following cases.

  1. For distinct roots (#ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues]) $lambda_1, lambda_2$, we have $M_(lambda_1) = m_(lambda_1) = 1 = m_(lambda_2) = M_(lambda_2)$. And thus #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] $bold(v_1), bold(v_2)$ form a #ponder("linear-algebra.basis")[basis] of $matbold(B) = matbold(P)^(-1) matbold(A) matbold(P)$, #ponder("linear-algebra.diagonalisable-matrix")[diagonolised] with the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvectors] as columns of $matbold(P)$.

  2. For #ponder("algebra.root-multiplicity")[repeated root] $lambda_1 = lambda_2 = lambda$, with $M_(lambda) = m_lambda = 2$, then the same argument as above applies, and $matbold(B)$ is #ponder("linear-algebra.diagonalisable-matrix")[diagonolised].

  3. For #ponder("algebra.root-multiplicity")[repeated root] $lambda_1 = lambda_2 = lambda$, with $M_(lambda) = 2$ and $m_(lambda) = 1$. Let $bold(v)$ to be an #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvector] for $lambda$ and extend it to a #ponder("linear-algebra.basis")[basis] ${bold(v), bold(w)}$, where $bold(w)$ is any vector #ponder("linear-algebra.linear-independence")[linearly independent] of $bold(v)$. Hence,
    $
      matbold(A) bold(v) = lambda bold(v), quad matbold(A) bold(w) = alpha bold(v) + beta bold(w).
    $

    Then, the matrix of the #ponder("linear-algebra.linear-map")[linear map] w.r.t. the #ponder("linear-algebra.basis")[basis] ${bold(v), bold(w)}$ is
    $ matbold(B) = mat(lambda, alpha; 0, beta). $
    Note that we will only consider $beta = lambda$, otherwise we will return to case (1). Also, $alpha != 0$, otherwise we will return to case (2).

    Now, defining $bold(u) = alpha bold(v)$. Then we have that, with respect to the #ponder("linear-algebra.basis")[basis] ${bold(u), bold(w)}$, the matrix of the #ponder("linear-algebra.linear-map")[linear map] is
    $
      matbold(B) = mat(lambda, 1; 0, lambda),
    $
    with $matbold(B) = matbold(P)^(-1) matbold(A) matbold(P)$, and the columns of $matbold(P)$ given by $bold(u), bold(w)$.
]

#theorem[General Jordan Normal Form][
  Any $n times n$ complex matrix $matbold(A)$ is #ponder("linear-algebra.similar-matrices")[similar] to a matrix $matbold(B)$ with block form given by
  $
    matbold(B) = mat(
      mat(
        delim: "[",
        , , ;
        , J_n_1 (lambda_1), ;
        , , ;
      ), , , , ;
      , mat(
        delim: "[",
        , , ;
        , J_n_2 (lambda_2), ;
        , , ;
      ), , , ;
      , , , dots.down, ;
      , , , , mat(
        delim: "[",
        , , ;
        , J_n_r (lambda_r), ;
        , , ;
      );
    )
  $
  where each #ponder("linear-algebra.jordan-normal-form")[Jordan block] is a matrix of the form
  $
    J_p (lambda) =
    mat(
      lambda, 1, 0, ..., 0, 0;
      0, lambda, 1, ..., 0, 0;
      dots.v, dots.v, dots.v, dots.down, dots.v, dots.v;
      0, 0, 0, ..., lambda, 1;
      0, 0, 0, ..., 0, lambda
    ) quad "of size" p times p
  $
  with $n_1 + n_2 + ... + n_r = n$, and $lambda_1, lambda_2, ..., lambda_r$ are the #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalues] of $matbold(A)$ and $matbold(B)$ (because they are #ponder("linear-algebra.similar-matrices")[similar]).

  Note that the same #ponder("linear-algebra.eigenvalue-eigenvector")[eigenvalue] may appear in multiple #ponder("linear-algebra.jordan-normal-form")[Jordan blocks].

  $matbold(A)$ is #ponder("linear-algebra.diagonalisable-matrix")[diagonalisable] iff all #ponder("linear-algebra.jordan-normal-form")[Jordan blocks] are of size $1 times 1$.
] <thm-jordan-normal-form>

== Symmetries and Transformation Groups

=== Orthogonal Transformations and Rotations in $RR^n$

#fade[[This topic is discussed in more detail in IA Groups.]]

Recall that $matbold(R)$ is an #ponder("algebra.orthogonal-group")[orthogonal] is equivalent to

- $matbold(R)^tp matbold(R) = matbold(R) matbold(R)^tp = matbold(I)$,

- $(matbold(R) bold(x)) dot (matbold(R) bold(y)) = bold(x) dot bold(y)$ for all $bold(x), bold(y) in RR^n$,

- The columns or rows of $matbold(R)$ form an #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis] of $RR^n$.

#definition[Orthogonal group][
  The set of #ponder("algebra.orthogonal-group")[orthogonal matrices] $RR$ of size $n times n$ is a #ponder("algebra.group")[group], denoted $O(n)$, is called the #ponder("algebra.orthogonal-group")[*orthogonal group*].
]

Recall that $det(matbold(R)) = plus.minus 1$ for any #ponder("algebra.orthogonal-group")[orthogonal matrix] $matbold(R)$.

#definition[Special orthogonal group][
  A #ponder("algebra.subgroup")[subgroup] of $O(n)$ formed by #ponder("algebra.orthogonal-group")[orthogonal matrices] with #ponder("linear-algebra.determinant")[determinant] $1$ is called the #ponder("algebra.special-orthogonal-group")[*special orthogonal group*], denoted $SO(n)$.
]

- $matbold(R) in O(n)$ preserves lengths and $n$-dimensional (absolute) volumes.

- $matbold(R) in SO(n)$ preserves orientations, given by the signs of the volumes.

Geometrically, $SO(n)$ consists of all #ponder("geometry.rotation")[rotations] in $RR^n$, and #ponder("geometry.reflection")[reflections] belong to $O(n)$ but not to $SO(n)$.

Any element of $O(n)$ is of the form:

- $matbold(R) in SO(n)$,
- $matbold(R) matbold(H)$ where $matbold(R) in SO(n)$ and $matbold(H) in O(n) \\ SO(n)$.

#lecture-separator(lecture: 24, date: "2025-12-02")

For a #ponder("geometry.rotation")[rotation matrix] $matbold(R)$, consider
$
  x'_i = R_(i j) x_j.
$

We can view this in two ways:

- transformation of vectors (active point of view)

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d8e1.svg", width: 12em)
  ]

  We have $abs(bold(x')) = abs(bold(x))$ where $x'_i$ are component sof the new vector $bold(x')$ after $bold(x') = matbold(R) bold(x)$ with respect to the #ponder("linear-algebra.basis")[standard basis].

- #ponder("algebra.matrix-change-of-basis")[change of basis] (passive point of view)

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d8e2.svg", width: 12em)
  ]

  Now $x'_i$ are components of the same vector $bold(x)$ but with respect to a new #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis] ${bold(u_1), bold(u_2)}$ where

  $
    bold(u_i) = sum_(j) R_(i j) bold(e_j) = sum_(j) e_j (bold(R)^(-1))_(j i)
  $

#remark[
  Compare this to the standard notation for the matrix of #ponder("algebra.matrix-change-of-basis")[change of basis], with $matbold(P) = matbold(R)^(-1)$.
]

=== 2D Minkowski Space and Lorentz Transformations

Consider the #ponder("relativity.minkowski-space")[_inner product_] on $RR^2$ given by $(bold(x), bold(y)) = bold(x)^tp matbold(J) bold(y)$ where $matbold(J) = mat(1, 0; 0, -1)$.

If $bold(x) = vec(x_1, x_2)$ and $bold(y) = vec(y_1, y_2)$, then
$
  (bold(x), bold(y)) = x_1 y_1 - x_2 y_2.
$

This #ponder("relativity.minkowski-space")[_inner product_] is not #ponder("linear-algebra.matrix-definiteness")[positive definite], since
$
  (bold(x), bold(x)) = x_1^2 - x_2^2
$
which is not always positive. Nonetheless, it is still bilinear and symmetric.

Now let us consider how the #ponder("linear-algebra.basis")[standard basis] vectors behave under this #ponder("relativity.minkowski-space")[inner product]. Consider $bold(e_0) = vec(1, 0)$ amd $bold(e_1) = vec(0, 1)$. They are #ponder("linear-algebra.orthonormal")[_orthonormal_] with respect to this #ponder("relativity.minkowski-space")[inner product], in the sense that
$
  (bold(e_0), bold(e_0)) = 1, quad (bold(e_1), bold(e_1)) = -1, quad (bold(e_0), bold(e_1)) = 0.
$

#definition[Minkowski metric and Minkowski space][
  The #ponder("linear-algebra.inner-product")[inner product] defined $forall bold(x), bold(y) in RR^2$ by
  $
    (bold(x), bold(y)) = bold(x)^tp matbold(J) bold(y)
  $
  where $matbold(J) = mat(1, 0; 0, -1)$ is called the #ponder("relativity.minkowski-space")[*Minkowski metric*].

  $RR^2$ equipped with the #ponder("relativity.minkowski-space")[Minkowski metric] is called a #ponder("relativity.minkowski-space")[*Minkowski space*].
] <def-minkowski-space>

Consider $matbold(M) = mat(M_(00), M_(01); M_(10), M_(11))$ associated to a #ponder("linear-algebra.linear-map")[linear map] $T: RR^2 -> RR^2$. This preserves the #ponder("relativity.minkowski-space")[Minkowski metric] iff
$
  &(matbold(M) bold(x), matbold(M) bold(y)) &=& (bold(x), bold(y)) quad &forall bold(x), bold(y) in RR^2\
  <=> &(matbold(M) bold(x))^tp matbold(J) (matbold(M) bold(y)) &=&bold(x)^tp matbold(J) bold(y) quad &forall bold(x), bold(y) in RR^2\
  <=> &bold(x)^tp (matbold(M)^tp matbold(J) matbold(M)) bold(y) &=& bold(x)^tp matbold(J) bold(y) quad &forall bold(x), bold(y) in RR^2\
  <=> &matbold(M)^tp matbold(J) matbold(M) &=& matbold(J).
$

The matrices $matbold(M)$ satisfying this condition form a #ponder("algebra.group")[group], with
$
  (det matbold(M)^tp) (det matbold(J)) (det matbold(M)) = det matbold(J) => (det matbold(M))^2 = 1 => det matbold(M) = plus.minus 1.
$
#definition[Lorentz group][
  The #ponder("relativity.lorentz-group")[Lorentz group] is the #ponder("algebra.subgroup")[subgroup]  of the group above that satisfies $det matbold(M) = 1$ and $M_(00) > 0$.
] <def-lorentz-group>

==== General Form of Lorentz Transformations

We shall determine a general form for matrices in the #ponder("relativity.lorentz-group")[Lorentz group] given the conditions above.

A similar argument as for #ponder("algebra.orthogonal-group")[orthogonal matrices] will be followed.

Using

- $(bold(e_0), bold(e_0)) = 1$, which gives $(matbold(M) bold(e_0), matbold(M) bold(e_0)) = 1$.

  We have
  $
    mat(1, 0) mat(M_(00), M_(10); M_(01), M_(11)) mat(1, 0; 0, -1) mat(M_(00), M_(01); M_(10), M_(11)) vec(1, 0) = M_(00)^2 - M_(10)^2 = 1.
  $

- $(bold(e_1), bold(e_1)) = -1$, which gives $(matbold(M) bold(e_1), matbold(M) bold(e_1)) = -1$.

  We have
  $
    mat(0, 1) mat(M_(00), M_(10); M_(01), M_(11)) mat(1, 0; 0, -1) mat(M_(00), M_(01); M_(10), M_(11)) vec(0, 1) = M_(01)^2 - M_(11)^2 = -1.
  $

- $(bold(e_0), bold(e_1)) = 0$, which gives $(matbold(M) bold(e_0), matbold(M) bold(e_1)) = 0$.

  This similarly gives $M_(00) M_(01) - M_(10) M_(11) = 0$.

- $M_(00) > 0$

Combining these equations, we can derive a general form
$
  matbold(M) = mat(cosh theta, sinh theta; sinh theta, cosh theta) quad "for some" theta in RR.
$

For elements of the #ponder("relativity.lorentz-group")[Lorentz group], we have
$
  matbold(M)(theta_1) matbold(M)(theta_2) = matbold(M)(theta_1 + theta_2)
$
using hyperbolic trigonometric identities.

==== Physical Interpretation of Lorentz Transformations

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d8e3.svg", width: 22em)
  ]

Fix $(bold(x), bold(x)) = k$ to be constant. Any #ponder("relativity.lorentz-group")[Lorentz transformation] over $bold(x)$ maps it to other vector $bold(x')$ on a same curve.

Note that $bold(x)$ and $bold(x')$ must lie on the same branch of the curve, since $M_(00) > 0$.

We have
$
  matbold(M)(theta) = (1)/(sqrt(1-(tanh theta)^2) ) mat(1, tanh theta; tanh theta, 1)
$
since $cosh^2 theta - sinh^2 theta = 1$ and $tanh theta = (sinh theta)/(cosh theta)$.

Now, for a physical interpretation, define $v := tanh theta$ with $-1 < v < 1$. #fade[[With the speed of light $c = 1$.]]

Rename $x_0 -> t$ #fade[[time coordinate]] and $x_1 -> x$ #fade[[space coordinate]]. Then, we can interpret
$
  bold(x') = matbold(M) bold(x) "with" cases(
    t' = (1)/(sqrt(1-v^2) ) (t + v x),
    x' = (1)/(sqrt(1-v^2) ) (x + v t)
  )
$
so #ponder("relativity.lorentz-group")[Lorentz transformations] boost the time and space coordinates for an observer moving at speed $v$ relative to another observer. More details on this topic will be covered in IA Dynamics and Relativity.

The factor $(1)/(sqrt(1-v^2) )$ in #ponder("relativity.lorentz-group")[Lorentz transformations] gives rise to time dilation and length contraction.

For composition of velocities,

$
  matbold(M)(theta_1) matbold(M)(theta_2) = matbold(M)underbracket((theta_1 + theta_2), theta_3)
$
where $v_i := tanh theta_i$, we get
$
  v_3 = tanh(theta_3) = tanh(theta_1 + theta_2) = (tanh theta_1 + tanh theta_2)/(1 + tanh theta_1 tanh theta_2) = (v_1 + v_2)/(1 + v_1 v_2).
$
This is the relativistic velocity addition formula.
