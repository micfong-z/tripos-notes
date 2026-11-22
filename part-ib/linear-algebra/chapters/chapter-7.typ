#import "../prelude.typ": *
#show: chapter.with(7)

= Bilinear Forms

In this section, $U, V$ are $FF$-vector spaces.

#definition[Bilinear Form][
  A function $phi: U times V->FF$ is called a bilinear form if, for all $u_0 in U$, $v_0 in V$, the maps

  - $V -> F$ with $v |-> phi(u_0, v)$, and

  - $U -> F$ with $u |-> phi(u, v_0)$

  are linear.

]

#example[
  The following are examples of bilinear forms:

  + For $U = V = FF^n$,
    $
      phi(u, v) = sum_(i=1)^n u_i v_i.
    $

  + For $U = FF^m$, $V = FF^n$ and $matbold(A) in MM_(m times n)(FF)$,
    $
      phi(u, v) = u^T matbold(A) v.
    $

  + For $U = V = C[0, 1]$,
    $
      phi(f, g) = integral_0^1 f(x) g(x) dif x.
    $

  + For any $FF$-vector space $V$,
    $
      phi: V times V^* & -> FF \
         phi(v, theta) & = theta(v).
    $
]

#definition[Bilinear Form Matrix][
  If $U, V$ are finite-dimensional and $B = {b_1, ..., b_m}$, ${C = c_1, ..., c_n}$ are bases of $U, V$ respectively, then the *matrix* of the bilinear form $phi: U times V -> FF$ is
  $
    [phi]_(B, C) = (phi(b_i, c_j))_(i, j) in MM_(m times n)(FF).
  $
]

#proposition[
  For all $u in U$, $v in V$, we have
  $
    ([u]_B)^TT [phi]_(B, C) [v]_C = phi(u, v).
  $
  Moreover, $[phi]_(B, C)$ is the only $m times n$ matrix with this property for all $u in U$, $v in V$.
] <prop-bilinear-form-matrix>

#proof[
  Write $u = sum_(i=1)^m lambda_i b_i$, $v = sum_(j=1)^n mu_j c_j$, so that $[u]_B = vb(lambda)$, $[v]_C = vb(mu)$. Then
  $
    phi(u, v) & = phi(sum_(i=1)^m lambda_i b_i, sum_(j=1)^n mu_j c_j) \
              & = sum_(i=1)^m lambda_i sum_(j=1)^n mu_j phi(b_i, c_j) \
              & = sum_(i, j) lambda_i phi(b_i, c_j) mu_j \
              & = vb(lambda)^T [phi]_(B, C) vb(mu). \
  $
  If $matbold(A) in MM_(m times n)(FF)$ is such that
  $
    [u]_B^T matbold(A) [v]_C = phi(u, v)
  $
  for all $u in U$, $v in V$, then set $u = b_i$, $v = c_j$, so that $[u]_B = e_i in FF^m$, $[v]_C = e_j in FF^n$, and we have
  $
    phi(b_i, c_j) = e_i^TT matbold(A) e_j = a_(i j).
  $
]

#corollary[
  For $B, B'$ bases of $U$ and $C, C'$ bases of $V$, we have
  $
    [phi]_(B', C') = ([id_U]^(B')_B)^TT [phi]_(B, C) [id_V]^(C')_C.
  $
] <cor-change-of-basis-bilinear-form-matrix>

#proof[
  We only need to check that the matrix on the RHS satisfies the property in @prop-bilinear-form-matrix. Let $u in U$, $v in V$. Then
  $
    ([u]_B')^T ([id_U]^(B')_B)^TT [phi]_(B, C) [id_V]^(C')_C [v]_C' & = ([id_U]^(B')_B [u]_B')^T [phi]_(B, C) ([id_V]^(C')_C [v]_C') \
    & = ([u]_B)^T [phi]_(B, C) [v]_C \
    & = phi(u, v). \
  $
]

#definition[Rank of Bilinear Form][
  The *rank* $rank(phi)$ of a bilinear form $phi: U times V -> FF$ is the rank of $[phi]_(B, C)$ for any bases $B$ of $U$ and $C$ of $V$.

]

#remark[

  + Equivalent matrices have the same rank, so by @cor-change-of-basis-bilinear-form-matrix, $rank(phi)$ is well-defined.

  + For $U = V$, $B, B'$ bases of $V$, $exists matbold(P) in "GL"_n (FF)$ such that
    $
      [phi]_(B', B') = matbold(P)^TT [phi]_(B, B) matbold(P).
    $

]

#definition[
  $matbold(A), matbold(A') in MM_(n times n)(FF)$ are congruent if $exists matbold(P) in "GL"_n (FF)$ such that
  $
    matbold(A') = matbold(P)^TT matbold(A) matbold(P).
  $
  It is easy to see that congruence is an equivalence relation on $MM_(n times n)(FF)$.
]

#definition[
  Let $phi: U times V->FF$ be a bilinear form. For $u in U$, $v in V$, let $phi_L (u) in V^*$, $phi_R (v) in U^*$ be given by
  $
    phi_L (u) (v) = phi(u, v)= phi_R (v) (u).
  $
]

#lemma[
  We have
  $
    phi_L: U -> V^* quad "and" quad phi_R: V -> U^*,
  $
  and they are linear maps.
]
#proof[
  Left as an exercise.
]
#definition[
  The *left kernel* of $phi$ is $ker phi_L <= U$, and the *right kernel* of $phi$ is $ker phi_R <= V$.
]

#lecture-separator(lecture: 19, date: "2026-11-20")

#proposition[
  Let $U, V$ be finite-dimensional $FF$-vector spaces, $B, C$ bases of $U, V$ respectively, and $B^*, C^*$ the dual bases of $B, C$. Then

  + $[phi_L]^B_(C^*) = ([phi]_(B, C))^TT$,

  + $[phi_R]^C_(B^*) = [phi]_(B, C)$.
] <prop-bilinear-form-dual-matrix>

#proof[
  + Let $matbold(A) = [phi]_(B, C)$, $matbold(A)' = [phi_L]^B_(C^*)$, $B = {b_1, ..., b_m}$, $C={c_1, ..., c_m}$. Then
    $
      phi_L (b_j) = sum_(k=1)^n a'_(k j) c_k^*,
    $
    and
    $
      a_(j i) & = phi(b_j, c_i) \
              & = phi_L (b_j) (c_i) \
              & = sum_(k=1)^n a'_(k j) c_k^* (c_i) \
              & = a'_(i j).
    $

  + Similar to (1).
]

#corollary[
  For any bilinear form $phi: U times V -> FF$, we have
  $
    rank phi_L = rank phi_R = rank phi.
  $
]
#proof[
  Immediate from @prop-bilinear-form-dual-matrix and $colrank = rowrank$.
]

#definition[
  Let $S subset.eq U$ and $T subset.eq V$. The sets
  $
    rperp(S) & = Set(v in V; phi(s, v) = 0 space forall s in S), \
    lperp(T) & = Set(u in U; phi(u, t) = 0 space forall t in T)
  $
  are the *perpendicular subspaces* to $S$ and $T$ with respect to $phi$.
]

#remark[

  + $rperp(S) <= V$ and $lperp(T) <= U$.

  + If $S_1 subset.eq S_2 subset.eq U$, then $rperp(S_2) <= rperp(S_1) <= V$.

    Similarly, if $T_1 subset.eq T_2 subset.eq V$, then $lperp(T_2) <= lperp(T_1) <= U$.

  + $rperp(U) = ker phi_R$, $lperp(V) = ker phi_L$.
]

#definition[
  $phi$ is *degenerate* if either $rperp(U)$ or $lperp(V)$ is non-trivial.
]

#proposition[
  For $U, V$ finite-dimensional with bases $B, C$, $phi$ is non-degenerate iff $dim U = dim V$ and $[phi]_(B, C)$ is invertible.
]

#proof[
  $
    phi "is non-degenerate" & <=> ker phi_L "and" ker phi_R "are trivial" \
                            & <=> dim U = rank phi_L = rank phi = rank phi_R = dim V \
                            & <=> [phi]_(B, C) "is a square matrix of full rank".
  $
]

Henceforth we will assume that $U = V$, and write $[phi]_(B, B) = [phi]_B$.

#definition[
  A bilinear form $phi: V times V -> FF$ is *symmetric* if $forall u, v in V$, we have $phi(u, v) = phi(v, u)$.
]

#remark[
  + A matrix $matbold(A) in MM_(n times n)(FF)$ is symmetric if $matbold(A)^TT = matbold(A)$. For $V$ finite-dimensional, $phi$ is symmetric iff $[phi]_B$ is symmetric for some (equivalently, any) basis $B$ of $V$.

  + If $phi$ is symmetric, then for any $S subset.eq V$, then $rperp(S) = lperp(S)$.

  + If $phi$ is symmetric, then $ker phi_L = ker phi_R$. Call this the *kernel* of $phi$.
]

#definition[
  A function $Q: V -> FF$ is a *quadratic form* if there exists a bilinear form $phi: V times V -> FF$ such that $Q(v) = phi(v, v)$ for all $v in V$.
] <def-quadratic-form>

#example[
  Consider $V = RR^2$. For $matbold(A) = mat(delim: "[", a, b; c, d) in MM_(2 times 2)(RR)$, let
  $
    Q_matbold(A) (v) = v^T matbold(A) v = a v_1^2 + (b + c) v_1 v_2 + d v_2^2.
  $
  Then the corresponding bilinear form is
  $
    phi_matbold(A) (v, w) = v^T matbold(A) w = a u_1 v_1 + b u_1 v_2 + c u_2 v_1 + d u_2 v_2.
  $
  Note that $Q_matbold(A) = Q_((1)/(2) (matbold(A) + matbold(A)^TT))$
]

#proposition[Polarisation Identity][
  Suppose $1 + 1 != 0$ in $FF$. Let $V$ be any $FF$-vector space, $Q: V->FF$ be a quadratic form. Then there is a unique symmetric bilinear form $psi: V times V -> FF$ such that
  $
    Q(v) = psi(v, v) quad forall v in V.
  $
  $psi$ is given by
  $
    psi(u, v) = (1)/(2) (Q(u + v) - Q(u) - Q(v)).
  $
] <prop-polarisation-identity>

#proof[


  *Existence.* Let $phi: V times V->FF$ be as in @def-quadratic-form. Set
  $
    psi(u, v) = (1)/(2) (phi(u, v) + phi(v, u)).
  $
  Then $psi$ is symmetric.

  *Uniqueness.* For any symmetric bilinear form $psi$ such that $Q(v) = psi(v, v)$, we have

  $
    Q(u + v) & = psi(u+v, u+v) \
             & = psi(u, u) + psi(u, v) + psi(v, u) + psi(v, v) \
             & = Q(u) + 2 psi(u, v) + Q(v) \
  $

  and thus $psi(u, v) = (1)/(2) (Q(u + v) - Q(u) - Q(v))$ uniquely.
]

#theorem[
  Suppose $1 + 1 != 0$ in $FF$, and let $V$ be a finite-dimensional $FF$-vector space, $phi: V times V->FF$ be a symmetric bilinear form. Then there is a basis $B$ for $V$ such that $[phi]_B$ is diagonal.
] <thm-symmetric-bilinear-form-diagonal>
#remark[
  The assumption that $phi$ is symmetric is necessary. If $matbold(A) in MM_(n times n)(FF)$ with $matbold(P)^TT matbold(A) matbold(P) = matbold(D)$ is diagonal for some $matbold(P) in "GL"_n (FF)$, then
  $
    matbold(P)^TT matbold(A) matbold(P) = matbold(D) = matbold(D)^TT = matbold(P)^TT matbold(A)^TT matbold(P),
  $
  so $matbold(A) = matbold(A)^TT$.
]

#corollary[
  For $1+1!=0$ in $FF$, every symmetric matrix are congruent to a diagonal matrix.
]

#example[
  Take $FF = ZZ \/ 2 ZZ$. Then $mat(delim: "[", 0, 1; 1, 0)$ is symmetric, but not congruent to a diagonal matrix.
]

#proof[
  #fade[[of @thm-symmetric-bilinear-form-diagonal]]

  Induct on $dim V = n$. The bases cases $n = 0, 1$ are trivial.

  If $phi(v, v) = 0$ for all $v in V$, then by @prop-polarisation-identity, $phi equiv 0$.

  Otherwise, let $v_1 in V$ with $phi(v_1, v_1) != 0$. Let $U = rperp({v_1}) = ker (phi_L (v_1): V -> FF)$. Note that $v_1 in.not U$, so by @thm-rank-nullity[Rank-Nullity Theorem], $dim U = n-1$ and $V = span(v_1) plus.o U$. Then $eval(phi)_U: U times U -> FF$ is a symmetric bilinear form, and by induction there exists a basis $B_U = {v_2, ..., v_n}$ such that $[eval(phi)_U]_B_(U)$ is diagonal.

  Set $B = {v_1, ..., v_n}$. Then
  $
    [phi]_B = dmat(delim: "[", phi(v_1, v_1), phi(v_2, v_2), dots.down, phi(v_n, v_n)) in MM_(n times n)(FF)
  $
]

#remark[
  The proof yields an algorithm for constructing a diagonal basis. In practice, shortcuts are often available.
]

#example[
  Consider $x in RR^3$, and
  $
    Q(x) & = x_1^2 - 4 x_2 x_3 + x_3^2 \
         & = x_1^2 + (x_3-2x_2)^2 -(2x_2)^2 \
         & = z_1^2 + z_2^2 - z_3^2 \
  $
  where
  $
    z = underbracket(mat(delim: "[", 1, 0, 0; 0, -2, 1; 0, 2, 0), matbold(P)^(-1)) x.
  $
  We also have $Q(x) = psi(x, x)$, where
  $
    psi(x, y) = x_1y_1 - 2(x_2y_3 + x_3y_2) + x_3y_3.
  $
  With respect to the standard basis, $matbold(A)= [psi]_B = mat(delim: "[", 1, 0, 0; 0, 0, -2; 0, -2, 1)$. Then for some $matbold(P) in "GL"_3 (RR)$, we have
  $
    matbold(P)^TT matbold(A) matbold(P) = mat(delim: "[", 1, 0, 0; 0, 1, 0; 0, 0, 1) in MM_(3 times 3)(RR)
  $
]
