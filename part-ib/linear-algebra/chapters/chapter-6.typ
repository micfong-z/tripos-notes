#import "../prelude.typ": *
#show: chapter.with(6)

= Eigenspaces

#definition[
  For a finite-dimensional $FF$-vector space $V$, $alpha in scr(L)(V, V)$, $alpha$ is *triangularisable* (*diagonalisable*) if there exists a basis $B$ for $V$ such that
  $
    [alpha]^B_B = mat(
      delim: "[", lambda_1, , *;
      , dots.down, , ;
      0, , lambda_n
    )
  $
  in upper-triangular form (diagonal form with $* = 0$) for some $lambda_1, ..., lambda_n in FF$.

  The matrix $matbold(A) in MM_(n times n)(FF)$ is triangularisable (diagonalisable) if it is similar to an upper-triangular (diagonal) matrix.
]

#remark[
  $alpha$ is triangularisable (diagonalisable) iff for some (equivalently, any) basis $B$ for $V$, $[alpha]^B_B$ is a triangularisable (diagonalisable) matrix.
]

#remarklike[Motivation][

  + It is easy to compute determinants of triangularisable matrices.

  + It is easier to analyse similarity classes of diagonalisable matrices.
]

#remark[
  If $B = {v_1, ..., v_n}$ is a basis for $V$ such that
  $
    [alpha]^B_B = dmat(delim: "[", lambda_1, dots.down, lambda_n)
  $
  then $alpha(v_i) = lambda_i v_i$ for $1<=i<=n$.
]

#definition[
  Let $V$ be a $FF$-vector space and $alpha in scr(L)(V, V)$.

  - $lambda in FF$ is an *eigenvalue* of $alpha$ if there exists $vb(0) != v in V$ such that $alpha(v) = lambda v$.

  - Such a $vb(0) != v in V$ is a $lambda$-*eigenvector* of $alpha$.

  - $V_lambda := {v in V: alpha(v) = lambda v}$ is the $lambda$-*eigenspace* of $alpha$.
] <def-eigenspace>

#remark[

  + $V_lambda = ker (alpha - lambda id_V) <= V$.

  + For finite-dimensional $V$, $alpha$ is diagonalisable iff $V$ has a basis consisting of eigenvectors of $alpha$. #fade[[See previous remark.]]

  + If $v in V_mu$ and $lambda != mu$ then
    $
      (alpha - lambda id_V) (v) = (mu - lambda) v != vb(0).
    $
    Thus $(alpha - lambda id_V)$ preserves $V_mu$ and $(alpha - lambda id_V)|_(V_mu) : V_mu -> V_mu$ is invertible, with inverse
    $
      v |-> (1)/(mu - lambda) v.
    $
]

#lemma[
  If $lambda_1, ..., lambda_n in FF$ are distinct and $vb(0) != v_i in V_(lambda_i)$, then ${v_1, ..., v_n}$ is linearly independent.
] <lem-distinct-eigenvectors-linear-independence>

#proof[
  Suppose otherwise. Then let
  $
    sum_(i=1)^n mu_i v_i = vb(0)
  $
  with $mu_i in FF$ and WLOG $mu_1 != 0$. Let $beta = product_(i=2)^n (alpha - lambda_i id_V)$. Then by the above remark (3),
  $
    beta(v_j) = (product_(i=2)^n (lambda_j - lambda_i)) v_j != vb(0) quad <=> quad j = 1.
  $
  Thus
  $
    vb(0) = beta(sum_(i=1)^n mu_i v_i) = sum_(i=1)^n mu_i beta(v_i) = mu_1 (product_(i=2)^n (lambda_1 - lambda_i)) v_1 != vb(0),
  $
]

#corollary[
  If $V$ is finite-dimensional and $alpha in scr(L)(V, V)$, then $alpha$ has only finitely many eigenvalues.
] <cor-finite-dimensional-eigenvalues>

@cor-finite-dimensional-eigenvalues does not apply to infinite-dimensional vector spaces.

#example[
  Consider $V = RR^NN$ and define
  $
    alpha: V & -> V \
     (a_n)_n & |-> (a_(n+1))_n.
  $
  Then for every $lambda in RR$, the sequence $(lambda^n)_n$ is a $lambda$-eigenvector of $alpha$. Thus $alpha$ has infinitely many eigenvalues.

]

#proposition[
  Let $V$ be a $FF$-vector space and $alpha in scr(L)(V, V)$. Suppose $lambda_1, ..., lambda_k$ are all the eigenvalues of $alpha$.

  + $span(V_lambda_1 union ... union V_lambda_k) = V_lambda_1 plus.o ... plus.o V_lambda_k$.

  + For $V$ finite-dimensional, $alpha$ is diagonalisable iff $V = V_(lambda_1) plus.o ... plus.o V_(lambda_k)$.
] <prop-eigenspaces-direct-sum>

#proof[
  + If not, then there exists $v_i in V_(lambda_i)$ (not all zero) such that
    $
      sum_(i=1)^k v_i = vb(0).
    $
    This contradicts @lem-distinct-eigenvectors-linear-independence.

  + #fade[[$=>$]] If $alpha$ is diagonalisable, then $V$ has a basis consisting of eigenvectors of $alpha$. These span $V$ and lie in $V_(lambda_1) union ... union V_(lambda_k)$, so the result follows.

    #fade[[$arrow.l.double$]] Suppose $V = V_(lambda_1) plus.o ... plus.o V_(lambda_k)$. Let $B_i$ be a basis for $V_(lambda_i)$ for $1<=i<=k$, with $abs(B_i) = n_i$. Then
    $
      B = union.big_(i=1)^n B_i
    $
    is a basis for $V$ consisting of eigenvectors of $alpha$ #fade[[Example Sheet 1 Q8]] and
    $
      [alpha]^B_B = dmat(delim: "[", lambda_1 matbold(I)_(n_1), dots.down, lambda_k matbold(I)_(n_k))
    $
    is diagonal.
]

Recall from @cor-invertible-non-singular that for a finite-dimensional $V$, $beta in scr(L)(V,V)$,
$
  det beta = 0 quad <=> quad ker beta != {vb(0)}.
$
Thus $lambda in FF$ is an eigenvalue of $alpha in scr(L) (V, V)$ iff $det (alpha - lambda id_V) = 0$.

#definition[
  For $matbold(A) in MM_(n times n)(FF)$, the *characteristic polynomial* of $matbold(A)$ is
  $
    chi_matbold(A) (t) = det (t matbold(I)_n - matbold(A)) in FF[t].
  $
  Similarly, for a finite-dimensional $V$ and $alpha in scr(L)(V, V)$, we can define
  $
    chi_alpha (t) = chi_([alpha]^B_B) (t) in FF[t]
  $
  for some (equivalently, any) basis $B$ for $V$.

] <def-characteristic-polynomial>

#remark[
  + $chi_matbold(A) (t)$ is monic of degree $n$.

  + We have
    $
      chi_(matbold(P) matbold(A) matbold(P)^(-1)) (t) & = det (t matbold(I)_n - matbold(P) matbold(A) matbold(P)^(-1)) \
                                                      & = det (matbold(P) (t matbold(I)_n - matbold(A)) matbold(P)^(-1)) \
                                                      & = chi_matbold(A) (t). \
    $
    Hence similar matrices have the same characteristic polynomial. In particular, @def-characteristic-polynomial (2) is well-defined.

  + #fade[[Exercise.]] By @def-leibniz-formula-for-determinants[Leibniz Formula], if
    $
      chi_alpha (t) = t^n + c_(n-1) t^(n-1) + ... + c_1 t + c_0,
    $
    then $c_(n-1) = -tr alpha$ and $c_0 = (-1)^n det alpha$.
]

#lemma[
  Since $lambda in FF$ is an eigenvalue of $alpha in scr(L) (V, V)$ iff $det (alpha - lambda id_V) = 0$, we have
  $
    {"eigenvalues of" alpha} = {"roots of" chi_alpha (t)}.
  $
] <lem-eigenvalues-roots-of-characteristic-polynomial>

#theorem[
  Every square complex matrix is triangularisable.
] <thm-square-complex-matrix-triangularisable>

#lecture-separator(lecture: 15, date: "2026-11-11")

#proof[
  #proposition[
    For any $matbold(A) in MM_(n times n) (FF)$, $matbold(A)$ is triangularisable iff $chi_matbold(A) (t)$ is a product of linear factors in $FF[t]$.
  ] <prop-triangularisable-iff-product-of-linear-factors>

  #proof[
    Let $alpha: FF^m -> FF^n$ be given by $alpha(v) = matbold(A) v$, so that $A = [alpha]^(E_n)_E_n$ where $E_n$ is the standard basis.

    #fade[[$=>$]] Suppose that $matbold(A)$ is triangularisable, then $matbold(A)$ is similar to
    $
      matbold(A') = mat(
        delim: "[", lambda_1, , *;
        , dots.down, , ;
        0, , lambda_n
      ).
    $
    Then
    $
      chi_matbold(A)(t) = chi_(matbold(A'))(t) = det mat(
        delim: "[", t - lambda_1, , *;
        , dots.down, , ;
        0, , t - lambda_n
      ) = product_(i=1)^n (t - lambda_i).
    $

    #fade[[$arrow.l.double$]] Let $lambda in FF$ be a root of $chi_matbold(A)(t)$. Then by @lem-eigenvalues-roots-of-characteristic-polynomial, $alpha$ has a $lambda$-eigenvector $vb(0) != v_1 in FF^n$. Extend ${v_1}$ to a basis $B = {v_1, ..., v_n}$ for $FF^n$. Then by base change, $matbold(A)$ is similar to
    $
      [alpha]^B_B = mat(
        delim: "[", lambda, *, dots.c, *;
        0, ;
        dots.v, , matbold(C);
        0,
      ).
    $
    So $chi_matbold(A)(t) = (t-lambda) dot chi_matbold(C) (t)$. By assumption, we conclude that $chi_matbold(C)(t)$ is a product of linear factors in $FF[t]$.

    By induction on $n$, $exists matbold(P) in "GL"_(n-1)(FF)$ such that $matbold(P) matbold(C) matbold(P)^(-1)$ is upper triangular. Let
    $
      overline(matbold(P)) = mat(
        delim: "[", 1, 0, dots.c, 0;
        0, , ;
        dots.v, , matbold(P);
        0;
      ) in "GL"_(n)(FF).
    $
    Then $matbold(A)$ is similar to
    $
      overline(matbold(P)) [alpha]^B_B overline(matbold(P))^(-1) = mat(
        delim: "[", lambda, *, dots.c, *;
        0, ;
        dots.v, , matbold(P) matbold(C) matbold(P)^(-1);
        0,
      )
    $
    which is upper triangular.


  ]

  Then by the Fundamental Theorem of Algebra, $chi_matbold(A) (t)$ is a product of linear factors in $CC[t]$.
]

#example[
  Consider
  $
    matbold(A) = mat(cos theta, -sin theta; sin theta, cos theta) in MM_(2 times 2) (RR)
  $
  where $theta in (0, ppi)$. Then $chi_matbold(A) (t) = t^2 - 2 t cos theta + 1$ is irreducible in $RR[t]$, so $matbold(A)$ is not triangularisable over $RR$. #fade[[But by @thm-square-complex-matrix-triangularisable, $matbold(A)$ is triangularisable over $CC$.]]

]

#definition[
  Let $V$ be a $FF$-vector space, $alpha in scr(L)(V, V)$ and
  $
    p(t) = sum_(i=0)^n a_i t^i in FF[t].
  $
  Write
  $
    p(alpha) = sum_(i=0)^n alpha_i dot alpha^i in scr(L)(V, V),
  $
  with $alpha^0 = id_V$. Similarly, for $matbold(A) in MM_(n times n)(FF)$,
  $
    p(matbold(A)) = sum_(i=0)^n a_i matbold(A)^i in MM_(n times n)(FF).
  $
]

We will assume that $V$ is finite-dimensional for the rest of this section.

#remark[
  + For $B$ a basis for $V$,
    $
      p([alpha]^B_B) = [p(alpha)]^B_B.
    $

  + If $dim V = n$, then
    $
      dim (scr(L)(V, V)) = n^2.
    $
    In particular, ${id_V, alpha, ..., alpha^(n^2)}$ #fade[[$n^2+1$ elements]] are linearly dependent. Thus there exists $a_i in FF$ not all zero such that
    $
      vb(0) = sum_(i=0)^(n^2) a_i alpha^i = p(alpha)
    $
    where $p(t) = sum_(i=0)^(n^2) a_i t^i$.
]


#proposition[
  Let $I_alpha = Set(p(t) in FF[t]; p(alpha) = vb(0))$. By the above remark, $I_alpha != {vb(0)}$. Let $m_alpha$ be a non-zero element of $I_alpha$ of minimal degree. By rescaling, assume that $m_alpha$ is monic. Then $m_alpha$ is unique.

  Such an $m_alpha$ is called the *minimal polynomial* of $alpha$.
]

#proof[
  #lemma[
    For any $f in I_alpha$, we have
    $
      m_alpha divides f.
    $
  ] <lem-minimal-polynomial-divides-any-polynomial-in-I-alpha>

  #proof[
    If not, then by the Euclidean algorithm, there exists $q, r in FF[t]$ such that $r != 0$ and $deg r < deg m_alpha$ such that
    $
      f = q m_alpha + r.
    $
    So we have
    $
      vb(0) = underbracket(f(alpha), in I_alpha) = q(alpha) underbracket(m_alpha (alpha), in I_alpha) + r(alpha) = r(alpha),
    $
    and hence $r in I_alpha$ is non-zero of a smaller degree than $m_alpha$, contradicting the minimality of $m_alpha$.
  ]

  Suppose $vb(0) != overline(m)_alpha in I_alpha$ has minimal degree and is monic. Then by @lem-minimal-polynomial-divides-any-polynomial-in-I-alpha, $m_alpha divides overline(m)_alpha$, so
  $
    overline(m)_alpha (t) = m_alpha (t) q(t)
  $
  but $deg m_alpha = deg overline(m)_alpha$. Hence we have $deg q = 0$, _i.e._ $q = lambda in FF$.

  Since both $m_alpha$ and $overline(m)_alpha$ are monic, we have $lambda = 1$, so $overline(m)_alpha = m_alpha$.
]

#theorem[Cayley-Hamilton Theorem][
  For $alpha in scr(L)(V, V)$, then we have $chi_alpha (alpha) = 0$.
] <thm-cayley-hamilton>

#proof[
  We will only prove the case for $FF = CC$.

  By @thm-square-complex-matrix-triangularisable, there exists a basis $B = {v_1, ..., v_n}$ for $V$ such that
  $
    [alpha]^B_B = mat(
      delim: "[",
      lambda_1, , *;
      , dots.down, , ;
      0, , lambda_n
    )
  $
  so that $chi_alpha (t) = product_(i=1)^n (t - lambda_i)$.

  Define $U_i = span(v_1\, ...\, v_j) <= V$, and $U_0 = {vb(0)}$, $U_n = V$. Then for $1 <= j <= n$, #fade[[by inspection of basis vector $v_j$]]
  $
    (alpha - lambda_i id_V) U_j <= U_(j-1)
  $
  so
  $
    chi_alpha (alpha) (V) = (alpha - lambda_1 id_V) compose ... compose (alpha - lambda_n id_V) (U_n) <= U_(n-1) <= ... <= U_0 = {vb(0)}.
  $
]

#corollary[
  By @lem-minimal-polynomial-divides-any-polynomial-in-I-alpha, $m_alpha divides chi_alpha$.
]

#definition[Algebraic and Geometric Multiplicities][
  Let $lambda in FF$ be an eigenvalue of $alpha$. The *algebraic multiplicity* of $lambda$ is $a_lambda >= 1$, which is the multiplicity of $lambda$ as a root of $chi_alpha (t)$.

  The *geometric multiplicity* of $lambda$ is $g_lambda = dim V_lambda >= 1$.
]

#proposition[The other AM-GM inequality][
  $
    g_lambda <= a_lambda.
  $
] <prop-other-am-gm-inequality>

#proof[
  Let $B_lambda$ be a basis for $V_lambda$. Extend $B_lambda$ to a basis $B$ for $V$. Then
  $
    [alpha]^B_B = mat(
      delim: "[", lambda matbold(I)_(g_lambda), *;
      0, matbold(C);
    ).
  $
  So $chi_alpha (t) = (t-lambda)^(g_lambda) chi_matbold(C)(t)$.
]

#lemma[
  Let $alpha in scr(L)(V, V)$ and $lambda_1, ..., lambda_k in FF$ be distinct eigenvalues of $alpha$. Then

  + $sum_(i=1)^k g_(lambda_i) <= dim V$ with equality iff $alpha$ is diagonalisable.

  + $sum_(i=1)^k a_(lambda_i) <= dim V$, with equality iff $alpha$ is triangularisable.
] <lem-sum-of-multiplicities-less-than-dim-V>

#proof[
  + By @prop-eigenspaces-direct-sum,
    $
      V_lambda_1 plus.o ... plus.o V_lambda_k <= V
    $
    with equality iff $alpha$ is diagonalisable. Taking dimensions gives the result.

  + Write $chi_alpha (t) = g(t) dot product_(i=1)^k (t-lambda_i)^(a_lambda_i)$. Then $dim V = deg chi_alpha = deg g + sum_(i=1)^k a_(lambda_i)$.
    Since every root of $chi_alpha$ is an eigenvalue, _i.e._ one of the $lambda_i$, $g$ has no roots.

    By @prop-triangularisable-iff-product-of-linear-factors, $alpha$  is triangularisable iff $chi_alpha$ is a product of linear factors iff $deg g = 0$.
]


#proposition[
  For $FF = CC$, $alpha$ is diagonalisable iff $g_lambda = a_lambda$ for all eigenvalues $lambda$ of $alpha$.
] <prop-diagonalisable-iff-geometric-multiplicity-equals-algebraic-multiplicity>

#proof[
  By @thm-square-complex-matrix-triangularisable, $alpha$ is triangularisable. By @lem-sum-of-multiplicities-less-than-dim-V (2),
  $
    sum_(i=1)^k a_(lambda_i) = dim V.
  $
  By @prop-other-am-gm-inequality, $g_lambda <= a_lambda$ for all eigenvalues $lambda$ of $alpha$. So
  $
    sum_(i=1)^k g_(lambda_i) <= sum_(i=1)^k a_(lambda_i) = dim V
  $
  with equality iff $g_lambda = a_lambda$ for all eigenvalues $lambda$ of $alpha$. By @lem-sum-of-multiplicities-less-than-dim-V (1), we conclude that $alpha$ is diagonalisable iff $g_lambda = a_lambda$ for all eigenvalues $lambda$ of $alpha$.
]

#lecture-separator(lecture: 16, date: "2026-11-13")

#remark[
  For $p(t) = sum_(i=0)^n mu_i t^i in FF[t]$, $v in V_lambda$,
  $
    p(alpha)(v) = sum_(i=0)^n mu_i alpha^i (v) = sum_(i=0)^n mu_i lambda^i v = p(lambda) v.
  $
]

#lemma[
  For $lambda in FF$, $lambda$ is a root of $m_alpha$ iff $lambda$ is a root of $chi_alpha$.
] <lem-root-of-minimal-polynomial-iff-root-of-characteristic-polynomial>

#proof[
  #fade[[$=>$]] By @thm-cayley-hamilton[Cayley-Hamilton Theorem],
  $
    (t- lambda) divides m_alpha (t) divides chi_alpha (t).
  $
  #fade[[$arrow.l.double$]] If $chi_alpha = 0$ then $lambda$ is an eigenvalue of $alpha$. let $0 != v in V_lambda$. By the above remark,
  $
    m_alpha (alpha)(v) = m_alpha (lambda) v.
  $
  But $m_alpha (alpha) = 0$ so $m_alpha (lambda) dot v = 0$. Since $v != 0$, we conclude that $m_alpha (lambda) = 0$.
]

#notation[
  Write $C_lambda$ for the multiplicity of $lambda$ as a root of $m_alpha$.
]

#remark[
  By @lem-root-of-minimal-polynomial-iff-root-of-characteristic-polynomial, for any eigenvalue $lambda$ of $alpha$ we have
  $
    1 <= C_lambda <= a_lambda.
  $
]

#example[
  + Let $matbold(A) = lambda matbold(I)_n$. Then $chi_matbold(A) (t) = (t-lambda)^n$ and $V_lambda = FF^n$. Also, $m_matbold(A) (t) = ( t-lambda)$. Hence $C_lambda = 1$ and $a_lambda = g_lambda = n$.

  + Let $matbold(A) = mat(
      delim: "[", lambda, 1, , , ; , lambda, 1, , ;
      , , dots.down, dots.down, ;
      , , , lambda, 1, ;
      , , , , lambda
    )$. Then $chi_matbold(A)(t) = (t-lambda)^n$ with $V_lambda = span(e_1)$.

    However, $(matbold(A) - lambda matbold(I)_n)^(n-1) !=0$, so $m_matbold(A)(t) = (t-lambda)^n$. Hence $C_lambda = a_lambda = n$ and $g_lambda = 1$.
] <ex-minimal-polynomial-and-characteristic-polynomial>

#theorem[
  If $p(alpha) = 0$ for some $0 != p in FF[t]$, and $p$ is a product of distinct linear factors, then $alpha$ is diagonalisable.
] <thm-diagonalisable-product-of-distinct-linear-factors>

#proof[
  WLOG assume that $p$ is monic. Write $p = product_(i=1)^k (t-mu_i)$, where $mu_i in FF$ are distinct.

  Let $p_i (t) = product_(j!=i) (t-mu_j)$. Then ${p_i}$ has no common factor of degree at least 1. By @cor-bezout-lemma, there exists $q_i in FF[t]$ such that
  $
    1 = sum_(i=1)^k p_i (t) q_i (t).
  $
  Set $pi_i = p_i (alpha) compose q_i (alpha) in scr(L)(V, V)$.
  $
    id_V = sum_(i=1)^n pi_i.
  $
  So for $v in V$, we can write
  $
    v = sum_(i=1)^n pi_i (v).
  $
  Hence $V = im pi_1 + dots.c + im pi_k$. Moreover, $(t-mu_i)p_i (t) = p(t)$, so
  $
    (alpha - mu_i id_V) compose pi_i = p_i (alpha) compose q_i (alpha) = 0.
  $
  Hence $im pi_i <= ker (alpha - mu_i id_V) = V_mu_i$. Thus, $V = im pi_1 + dots.c + im pi_k <= V_(mu_1) plus.o dots.c plus.o V_(mu_k) <= V$.

  Hence
  $
    V = V_(mu_1) plus.o dots.c plus.o V_(mu_k),
  $
  and $alpha$ is diagonalisable.
]

#example[
  For $FF = CC$, every $matbold(A) in "GL"_n (CC)$ of finite order is diagonalisable.

  Suppose $matbold(A)^d = matbold(I)_n$. Set $p(t) = t^d - 1 in CC[t]$. Then
  $
    p(t) = product_(i=1)^d (t-omega^i)
  $
  where $omega = ee^((2 ppi i)/d)$ is the primitive $d$-th root of unity. We have $p(matbold(A)) = 0$, so by @thm-diagonalisable-product-of-distinct-linear-factors, $matbold(A)$ is diagonalisable.

]

In summary, we can list everything we know about diagonalisability.

#theorem[
  The followings are equivalent for $alpha in scr(L)(V, V)$, where $V$ is a finite-dimensional $FF$-vector space.

  1. $alpha$ is diagonalisable.

  2. $V$ has a basis of eigenvectors of $alpha$.

  3. $exists 0 != p(t) in FF[t]$ which is a product of distinct linear factors such that $p(alpha) = 0$.

  4. $m_alpha (t)$ is a product of distinct linear factors.

  In addition, if $FF = CC$, then these are equivalent to

  5. For all $lambda in CC$, $g_lambda = a_lambda$.
] <thm-equivalence-of-diagonalisability>

#proof[

  #fade[[$(1) <=> (2)$]] By the remark after @def-eigenspace.

  #fade[[$(1) <=> (5)$]] By @prop-diagonalisable-iff-geometric-multiplicity-equals-algebraic-multiplicity.

  #fade[[$(3) => (4)$]] By $m_alpha divides p$.

  #fade[[$(4) => (3)$]] Take $p = m_alpha$.

  #fade[[$(3) => (1)$]] By @thm-diagonalisable-product-of-distinct-linear-factors.

  #fade[[$(1) => (3)$]] Let $B$ be a basis for $V$ such that $[alpha]^B_B$ is diagonal. Rearranging $B$, we can assume
  $
    [alpha]^B_B = mat(
      delim: "[", lambda_1 matbold(I)_(n_1), , 0;
      , dots.down, , ;
      0, , lambda_k matbold(I)_(n_k)
    )
  $
  where $lambda_i in FF$ are distinct. THen $p(t) = product_(i=1)^k (t- lambda_i)$ is a product of distinct linear factors and
  $
    [p(alpha)]^B_B = p([alpha]^B_B) = 0,
  $
  so $p(alpha) = 0$.
]

#definition[
  $alpha, beta in scr(L)(V, V)$ are *simultaneously diagonalisable* if there exists a basis $B$ for $V$ such that both $[alpha]^B_B$ and $[beta]^B_B$ are diagonal.
]

#theorem[
  Suppose $alpha$ and $beta$ are diagonalisable. Then $alpha$ and $beta$ are simultaneously diagonalisable iff $alpha beta = beta alpha$.
]

#proof[

  #fade[[$=>$]] Direct by commutativity of diagonal matrices.

  #fade[[$arrow.l.double$]] We will need the following lemma.

  #lemma[
    If $alpha, beta$ commute, and let $V_lambda$ be the $lambda$-eigenspace of $alpha$, then $beta(V_lambda) <= V_lambda$.
  ] <lem-commuting-operators-preserve-eigenspaces>

  #proof[
    For $v in V_lambda$,
    $
      alpha(beta(v)) = beta(alpha(v)) = beta (lambda v) = lambda beta(v)
    $
    so $beta(v) in V_lambda$.
  ]

  Since $alpha$ is diagonalisable, let $V = plus.o.big_(i=1)^k V_lambda_i$, where $V_lambda_i$ is the $lambda_i$-eigenspace of $alpha$ and $lambda_i$ are distinct. Let $p(t) in FF[t]$ be a product of distinct linear factors such that $p(beta) = 0$.

  By @lem-commuting-operators-preserve-eigenspaces, we can define $eval(beta)_V_lambda_i : V_lambda_i -> V_lambda_i$. Then $p(eval(B)_V_lambda_i) = eval(p(beta))_V_lambda_i = 0$. So by @thm-equivalence-of-diagonalisability, $eval(beta)_V_lambda_i$ is diagonalisable.

  Let $B_i$ be a basis for $V_lambda_i$ consisting of eigenvectors of $beta$. Then $U_(i=1) B_i = B$ is a basis for $V$, and the elements of $B$ are eigenvectors of both $alpha$ and $beta$. Hence $alpha$ and $beta$ are simultaneously diagonalisable.
]

#definition[Jordan Block][
  For $lambda in CC$, the $n times n$ *$lambda$-Jordan block* is
  $
    matbold(J)_n (lambda) = mat(
      delim: "[", lambda, 1, , , ; , lambda, 1, , ;
      , , dots.down, dots.down, ;
      , , , lambda, 1, ;
      , , , , lambda
    ) in MM_(n times n) (CC).
  $
]

By @ex-minimal-polynomial-and-characteristic-polynomial (2), $chi_(matbold(J)_n (lambda)) (t) = (t - lambda)^n = m_(matbold(J)_n (lambda)) (t)$, and the $lambda$-eigenspace of $matbold(J)_n (lambda)$ is $V_lambda = span(e_1)$.

#definition[Jordan Normal Form][
  $matbold(A) in MM_(n times n) (CC)$ is in *Jordan normal form* if
  $
    matbold(A) = dmat(delim: "[", matbold(J)_(n_1)(lambda_1), dots.down, matbold(J)_(n_k)(lambda_k))
  $
  for some $n_i >0$ and some $lambda_i in CC$ (not necessarily distinct) such that $sum_(i=1)^k n_i = n$.

  The $matbold(J)_(n_i) (lambda_i)$ are called the *Jordan blocks* of $matbold(A)$.
]

#lecture-separator(lecture: 17, date: "2026-11-16")

#theorem[
  Every $matbold(A) in MM_(n times n) (CC)$ is similar to a matrix $"JNF"(matbold(A))$ in Jordan normal form. $"JNF"(matbold(A))$ is unique up to reordering of the Jordan blocks.
] <thm-jordan-normal-form>

#example[Possible Forms of $2 times 2$ and $3 times 3$ Jordan Normal Forms][
  For a $2 times 2$ matrix, the possible Jordan normal forms and their minimal polynomials are
  $
    mat(delim: "[", lambda, 0; 0, lambda), quad & (t-lambda) \
    mat(delim: "[", lambda, 1; 0, lambda), quad & (t-lambda)^2 \
        mat(delim: "[", lambda, 0; 0, mu), quad & (t-lambda)(t-mu). \
  $

  For a $3 times 3$ matrix, the possible Jordan normal forms and their minimal polynomials are
  $
    mat(delim: "[", lambda, 0, 0; 0, lambda, 0; 0, 0, lambda), quad & (t-lambda) \
        mat(delim: "[", lambda, 0, 0; 0, lambda, 0; 0, 0, mu), quad & (t-lambda)(t-mu) \
            mat(delim: "[", lambda, 0, 0; 0, mu, 0; 0, 0, nu), quad & (t-lambda)(t-mu)(t-nu) \
    mat(delim: "[", lambda, 1, 0; 0, lambda, 0; 0, 0, lambda), quad & (t-lambda)^2 \
        mat(delim: "[", lambda, 1, 0; 0, lambda, 0; 0, 0, mu), quad & (t-lambda)^2(t-mu) \
    mat(delim: "[", lambda, 1, 0; 0, lambda, 1; 0, 0, lambda), quad & (t-lambda)^3
  $

]

#remark[
  For $n<=3$, the Jordan normal form of an $n times n$ matrix $matbold(A)$ is determined by $chi_matbold(A)$, $m_matbold(A)$. This is false for $4 times 4$ matrices.
]

Recall that for $matbold(A) = matbold(J)_n (lambda)$, we have
$
  a_n (lambda) = n, quad g_n (lambda) = 1, quad C_n (lambda) = n.
$
#remark[
  For $matbold(A) = dmat(delim: "[", matbold(A)_1, dots.down, matbold(A)_k) in MM_(n times n) (CC)$ with $matbold(A)_i in MM_(n_i times n_i) (CC)$, and $p(t) in CC[t]$, we have
  $
    p(matbold(A)) = dmat(delim: "[", p(matbold(A)_1), dots.down, p(matbold(A)_k)).
  $
  Thus, $m_matbold(A) (t) = lcm(m_matbold(A)_1 (t), dots, m_matbold(A)_k (t))$. So $C_lambda (matbold(A)) = max(C_lambda (matbold(A)_1), dots, C_lambda (matbold(A)_k))$.

  For $lambda in CC$,
  $
    matbold(A) - lambda matbold(I)_n = dmat(delim: "[", matbold(A)_1 - lambda matbold(I)_(n_1), dots.down, matbold(A)_k - lambda matbold(I)_(n_k)).
  $
  Then we have
  $
    chi_matbold(A)(t) = product_(i=1)^k chi_matbold(A)_i (t), quad a_lambda (matbold(A)) = sum_(i=1)^k a_lambda (matbold(A)_i).
  $
  Also $rank matbold(A) = sum_(i=1)^k rank(matbold(A)_i)$, so
  $
    g_lambda (matbold(A)) & = n- rank (matbold(A)- lambda matbold(I)_n) \
                          & = sum_(i=1)^k (n_i- rank (matbold(A)_i- lambda matbold(I)_(n_i))) \
                          & = sum_(i=1)^k g_lambda (matbold(A)_i). \
  $
]

#proposition[
  For $matbold(A) in MM_(n times n)(CC)$ in Jordan normal form,

  + $C_lambda (matbold(A)) = "size of largest Jordan block of" matbold(A) "corresponding to" lambda$.

  + $a_lambda (matbold(A)) = "sum of sizes of all Jordan blocks of" matbold(A) "corresponding to" lambda$.

  + $g_lambda (matbold(A)) = "number of Jordan blocks of" matbold(A) "corresponding to" lambda$.
]

#proof[
  Follows from the previous remark.
]

#example[
  Consider
  $
    matbold(A) = mat(
      delim: "[",
      3, -2, 0;
      1, 0, 0;
      1, 0, 1
    )
  $
  and we seek $matbold(P) in "GL"_3(CC)$ such that $matbold(P) matbold(A) matbold(P)^(-1)$ is in Jordan normal form. We have
  $
    chi_matbold(A) (t) = (t-1)^2 (t-2)
  $
  so the Jordan normal form is
  $
    mat(delim: "[", 2, 0, 0; 0, 1, 0; 0, 0, 1) quad "or" quad mat(delim: "[", 2, 0, 0; 0, 1, 1; 0, 0, 1).
  $
  But $matbold(A) - matbold(I)_3 = mat(delim: "[", 2, -2, 0; 1, -1, 0; 1, 0, 0)$, which has rank 2
  , with
  $
    ker (matbold(A) - matbold(I)_3) = span(vec(delim: "[", 0, 0, 1)).
  $
  Hence the Jordan normal form is
  $
    mat(delim: "[", 2, 0, 0; 0, 1, 1; 0, 0, 1).
  $
  Write $v_2 = vec(delim: "[", 0, 0, 1)$. Similarly compute $ker (matbold(A) - 2 matbold(I)_3) = span(v_1)$ where $v_1 = vec(delim: "[", 2, 1, 2)$. Finally solve
  $
    matbold(A) v_3 = v_2 + v_3
  $
  for $v_3$. We find $v_3 = vec(delim: "[", 1, 1, 0)$ works, so
  $
    matbold(P) = mat(delim: "[", v_1, v_2, v_3) = mat(delim: "[", 2, 0, 1; 1, 0, 1; 2, 1, 0) in "GL"_3(CC)
  $




]


#proof[ #fade[[of @thm-jordan-normal-form]]

  We will prove uniqueness only. The existence proof is outside the scope of this course #fade[[See IB Groups, Rings and Modules]], and we will just make a sketch proof later.

  Let $matbold(A), overline(matbold(A)) in MM_(n times n)(CC)$ with $matbold(A)~overline(matbold(A))$ and $overline(matbold(A))$ is in Jordan normal form.

  For $lambda in CC$ and $r in NN$ define
  $
    R_(lambda, r) (overline(matbold(A))) := \# {lambda"- Jordan blocks for" overline(matbold(A)) "of size" >= r}.
  $
  Then the $R_(lambda, r) (overline(matbold(A)))$ determine $overline(matbold(A))$, up to rearranging blocks.

  #lemma[
    The following is another equivalent definition of $R_(lambda, r) (overline(matbold(A)))$:
    $
      R_(lambda, r) (matbold(A)) = rank (matbold(A) - lambda matbold(I)_n)^(r-1) - rank (matbold(A) - lambda matbold(I)_n)^r
    $
    #fade[[note that RHS only depend on $matbold(A)$]].
  ] <lem-rank-formula-for-jordan-blocks>

  #proof[
    For $matbold(P) in "GL"_m (CC)$,
    $
      matbold(P) (matbold(A) - lambda matbold(I)_n)^k matbold(P)^(-1) &= (matbold(P) (matbold(A) - lambda matbold(I)_n) matbold(P)^(-1))^k \
      &= (matbold(P) matbold(A) matbold(P)^(-1) - lambda matbold(I)_n)^k \
    $
    Thus $rank (matbold(overline(A)) - lambda matbold(I)_n)^k = rank (matbold(A) - lambda matbold(I)_n)^k$. Hence we can assume $matbold(A) = overline(matbold(A))$ where $overline(matbold(A))$ is in Jordan normal form.

    - For $l in NN$ we have
      $
        matbold(J)_l (lambda) - lambda matbold(I)_l = mat(
          delim: "[", 0, 1, , , ; , 0, 1, , ;
          , , dots.down, dots.down, ;
          , , , 0, 1;
          , , , , 0
        ) quad "and" quad (matbold(J)_l (lambda) - lambda matbold(I)_l)^2 = mat(
          delim: "[", 0, 0, 1, , , ; , 0, 0, 1, , ;
          , , dots.down, dots.down, ;
          , , , 0, 0, 1;
          , , , , 0, 0;
          , , , , , 0
        ).
      $

      Thus
      $
        rank (matbold(J)_l (lambda) - lambda matbold(I)_l)^k = cases(
          l-k quad & "if" l >= k,
          0 quad & "if" l < k
        )
      $

    - For $mu != lambda$, $matbold(J)_l (mu) - lambda matbold(I)_l$ is invertible.

    Hence,
    $
      rank (matbold(A) - lambda matbold(I)_n)^k = n - k dot \# {lambda"-Jordan blocks of size" >= k} - sum ("sizes of" lambda"-Jordan blocks of size" < k).
    $
  ]


  By @lem-rank-formula-for-jordan-blocks, $matbold(A)$ alone determines $R_(lambda, r) (overline(matbold(A)))$ for any $lambda in CC$ and $r in NN$ and any $overline(matbold(A))$ in Jordan normal form similar to $matbold(A)$. Hence $overline(matbold(A))$ is unique up to rearranging blocks.

]

#definition[
  Let $V$ be a finite-dimensional $CC$-vector space, $alpha in scr(L)(V, V)$. Write
  $
    m_alpha (t) = (t-lambda_1)^(C_1) dots.c dots.c (t-lambda_k)^(C_k)
  $
  where $lambda_i in CC$ are distinct and $C_i >= 1$.

  The *generalised $lambda_i$-eigenspace* of $alpha$ is
  $
    V_i = ker((alpha - lambda_i id_V)^(C_i)) <= V.
  $
]

#theorem[Generalised Eigenspace Decomposition][
  Let $V$ be a finite-dimensional $CC$-vector space, $alpha in scr(L)(V, V)$ and $m_alpha (t) = product_(i=1)^k (t-lambda_i)^(C_i)$ where $lambda_i in CC$ are distinct and $C_i >= 1$. Then
  $
    V = V_1 plus.o dots.c plus.o V_k.
  $
]

#proof[
  #fade[[See full proof on Example Sheet 3.]] Adapt criteria for diagonalisability from @thm-equivalence-of-diagonalisability, and use the following lemma.

  #lemma[
    If $vb(0) != v_i in V_i$, then ${v_1, ..., v_(k)}$ are linearly independent.
  ]

  #lecture-separator(lecture: 18, date: "2026-11-18")

  #proof[
    Let $0 <= d_i < c_i$ be maximal such that
    $
      w_i = (d - lambda_i id_v)^(d_i) (v_i) != 0.
    $
    Then $w_i$ is a $lambda_i$-eigenvector of $alpha$. Set $beta = product_(i=1)^k (alpha-lambda_i id_V)^(d_i)$. Then $(alpha-lambda_i id_V)$ commute, so
    $
      beta(v_i) & =product_(j!=i) (alpha-lambda_j id_V)^(d_j) (w_i) \
                & = (product_(j!=i) (lambda_i -lambda_j)^(d_j)) (w_i) \
                & = mu_i w_i \
    $
    where $0 != mu_i in CC$.

    Suppose $sum_(i=1)^k nu_i v_i =vb(0)$. Apply $beta$ to both sides to get
    $
      sum_i nu_i mu_i w_i = vb(0).
    $
    By @lem-distinct-eigenvectors-linear-independence, $nu_i = 0$ for all $i$. Hence ${v_1, ..., v_k}$ are linearly independent.
  ]
]
