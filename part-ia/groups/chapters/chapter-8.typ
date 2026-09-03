#import "../prelude.typ": *
#import "@preview/xarrow:0.4.0": xarrow

= #ponder("algebra.permutation")[Permutations]

== #ponder("algebra.permutation")[Permutations] and Cycle Notation

Recall from @def-permutation that a *#ponder("algebra.permutation")[permutation]* of a set $X$ is a bijection $X->X$, and from @def-symmetric-group that $sym(X)$ is the set of all #ponder("algebra.permutation")[permutations] of $X$.

#example[
  If $X = {1, 2, 3}$, then $sym(X) teq S_3$. So examples of #ponder("algebra.permutation")[permutations] include

  $
    sigma: mat(
      1, 2, 3;
      3, 1, 2
    ) quad
    tau: mat(
      1, 2, 3;
      2, 1, 3
    )
  $
] <ex-permutations>

We can compute by representing #ponder("algebra.permutation")[permutations] as lists.

#example[
  $
    underbracket(
      1 & stretch(|->)^(quad sigma quad) 3 & stretch(|->)^(quad tau quad) 3 \
      2 & stretch(|->)^(quad sigma quad) 1 & stretch(|->)^(quad tau quad) 2 \
      3 & stretch(|->)^(quad sigma quad) 2 & stretch(|->)^(quad tau quad) 1 \
      , \ tau sigma
    )
  $
]

This is nonetheless a bit cumbersome. A more compact notation is to write #ponder("algebra.permutation")[permutations] in *cycle notation*.

#definition[#ponder("algebra.cycle")[Cycle]][
  Any list of distinct elements $ a_1, a_2, ..., a_k in {1, 2, ..., n} $ defines a *#ponder("algebra.cycle")[$k$-cycle]*:
  $
    sigma = mat(a_1, a_2, ..., a_k)
  $
  which sends $ a_1 |-> a_2, a_2 |-> a_3, ..., a_(k-1) |-> a_k, a_k |-> a_1, $and leaves all other elements fixed.
] <cycle>

#example[
  For @ex-permutations, we have
  $
    sigma & = mat(1, 3, 2) = mat(2, 3, 1) = mat(3, 2, 1), \
      tau & = mat(1, 2) = mat(2, 1).
  $
]

The important rule about #ponder("algebra.cycle")[cycle] multiplication is that the rightmost #ponder("algebra.cycle")[cycle] acts first.

#example[
  For @ex-permutations, we have
  $
    tau sigma & = mat(1, 2) mat(1, 3, 2) = mat(1, 3). \
  $
  Another example is
  $
    mat(1, 4, 3, 2) mat(2, 4, 3) = mat(1, 4, 2, 3).
  $

]

#remark[
  $mat(a_1, ..., a_k) = mat(a_2, ..., a_k, a_1)$.
]

#definition[#ponder("algebra.disjoint-cycles")[Disjoint Cycles]][
  #ponder("algebra.cycle")[Cycles] $mat(a_1, ..., a_k)$ and $mat(b_1, ..., b_m)$ are *#ponder("algebra.disjoint-cycles")[disjoint]* if the sets ${a_1, ..., a_k}$ and ${b_1, ..., b_m}$ are disjoint. Note that #ponder("algebra.disjoint-cycles")[disjoint cycles] commute.
] <disjoint-cycles>

#theorem[#ponder("algebra.disjoint-cycle-decomposition")[Disjoint cycles]][
  Every $sigma in S_n$ can be written as a product of #ponder("algebra.disjoint-cycles")[disjoint cycles]. This expression is unique up to

  1. shifting the elements within each #ponder("algebra.cycle")[cycle], and

  2. reordering the #ponder("algebra.cycle")[cycles].
] <disjoint-cycle-decomposition>

#proof[
  The #ponder("algebra.group-action")[action] of $lr(chevron.l sigma chevron.r)$ on $X = {1, 2, ..., n}$ partitions $X$ into #ponder("algebra.orbit-stabiliser-definitions")[orbits]. Let

  $
    X = lr(chevron.l sigma chevron.r) i_1 union lr(chevron.l sigma chevron.r) i_2 union ... union lr(chevron.l sigma chevron.r) i_k.
  $

  Let $n_j = abs(lr(chevron.l sigma chevron.r) i_j)$. We see that
  $
    sigma = mat(i_1, sigma(i_1), ..., sigma^(n_1 - 1) (i_1)) ... mat(i_k, sigma(i_k), ..., sigma^(n_k - 1) (i_k))
  $
  which proves existence of the decomposition.

  The choices we have made are on the representatives of each #ponder("algebra.orbit-stabiliser-definitions")[orbit], and the order of the #ponder("algebra.orbit-stabiliser-definitions")[orbits], which proves uniqueness up to the stated conditions.
]

#example[
  Consider
  $
    mat(1, 2) mat(3, 4) mat(5, 6) mat(1, 2, 3, 4, 5, 6) = mat(1) mat(2, 4, 6) mat(3) mat(5) = mat(2, 4, 6).
  $
]

#definition[#ponder("algebra.cycle-type")[Cycle type]][
  If $ sigma = mat(a^1_1, ..., a^1_(k_1)) ... mat(a^l_1, ..., a^l_(k_l)) $
  then $sigma$ is called a #ponder("algebra.cycle")[$(k_1, ..., k_l)$-cycle].

  The (multi)set of numbers ${k_1, ..., k_l}$ is called the *#ponder("algebra.cycle-type")[cycle type]* of $sigma$. We often omit singletons from the #ponder("algebra.cycle-type")[cycle type].
] <cycle-type>

#remark[
  If $sigma$ is a #ponder("algebra.cycle")[$k$-cycle], then $o(sigma) = k$. More generally, if $sigma$ is a #ponder("algebra.cycle")[$(k_1, ..., k_l)$-cycle], then $o(sigma) = lcm(k_1, ..., k_l)$.
]

== #ponder("algebra.transposition")[Transpositions] and the #ponder("algebra.sign-homomorphism")[Sign Homomorphism]

#definition[#ponder("algebra.transposition")[Transposition]][
  A *#ponder("algebra.transposition")[transposition]* is a #ponder("algebra.cycle")[$2$-cycle].
] <transposition>

#theorem[#ponder("algebra.transposition-generation")[Transpositions generate]][
  The set of #ponder("algebra.transposition")[transpositions] generates $S_n$ for any finite $n$.
] <transpositions-generate>

#proof[
  We shall prove by induction on $n$.

  *Base case.* Consider $n = 2$. Then $S_2 = {id, mat(1, 2)}$ is generated by the #ponder("algebra.transposition")[transposition] $mat(1, 2)$.

  *Inductive step.* Assume that $S_(n-1)$ is generated by #ponder("algebra.transposition")[transpositions]. Consider $S_n$. Let $sigma in S_n$.

  - If $sigma(n) = n$, then $sigma in S_(n-1) <= S_n$, so by the inductive hypothesis $sigma$ is generated by #ponder("algebra.transposition")[transpositions].

  - Otherwise, let $tau = (n, sigma(n))$. Then

    $
      tau sigma(n) = tau(sigma(n)) = n.
    $

    So $tau sigma in S_(n-1) <= S_n$, so by the inductive hypothesis $tau sigma$ is generated by #ponder("algebra.transposition")[transpositions]. Since
    $ sigma = tau (tau sigma), $ we see that $sigma$ is also generated by #ponder("algebra.transposition")[transpositions].

]

#lecture-separator(lecture: 18, date: "2025-11-19")

#definition[#ponder("algebra.adjacent-transposition")[Adjacent transpositions]][
  A #ponder("algebra.transposition")[transposition] of the form $mat(i, i+1)$ is called *#ponder("algebra.adjacent-transposition")[adjacent]*.
] <adjacent-transposition>

#lemma[
  Any #ponder("algebra.transposition")[transposition] $mat(i, j)$ can be written as #ponder("algebra.adjacent-transposition-factorisation")[a product of an odd number of adjacent transpositions].
] <lem-transposition-adjacent>

#proof[
  Assume $j > i$. Then the proof is by induction on $j - i$.

  *Base case.* If $j - i = 1$, then $mat(i, j) = mat(i, i+1)$ is already an #ponder("algebra.adjacent-transposition")[adjacent transposition].

  *Inductive step.* Assume that we can write $mat(i, j-1)$ as #ponder("algebra.adjacent-transposition-factorisation")[a product of an odd number of adjacent transpositions]. Then
  $
    mat(i, j) = mat(j-1, j) mat(i, j-1) mat(j-1, j)
  $
  and since $(i, j-1)$ can be written as #ponder("algebra.adjacent-transposition-factorisation")[a product of an odd number of adjacent transpositions] by the inductive hypothesis, so can $(i, j)$.
]

In particular, $S_n$ is generated by #ponder("algebra.adjacent-transposition")[adjacent transpositions].

This discussion leads to a notion of #ponder("algebra.permutation-parity")[parity] for #ponder("algebra.permutation")[permutations].

#lemma[
  If $tau_1, ..., tau_k$ are all #ponder("algebra.transposition")[transpositions] and $ sigma = tau_1 ... tau_k = e, $
  then $k$ is even.
] <transposition-parity>

#proof[
  By @lem-transposition-adjacent, we may assume that all $tau_i$ are #ponder("algebra.adjacent-transposition")[adjacent transpositions].

  We say that a pair ${i, j} subset.eq {1, 2, ..., n}$ is called an inversion of a #ponder("algebra.permutation")[permutation] $sigma$ if $i < j$ but $sigma(i) > sigma(j)$.

  #claim[
    For any $sigma = tau_1 ... tau_k$, the number of inversions of $sigma$ has the same #ponder("algebra.permutation-parity")[parity] as $k$.
  ]

  #proof[
    We prove this by induction on $k$.

    *Base case.* If $k = 0$, then $sigma = e$ has $0$ inversions, which is even.

    *Inductive step.* Let

    $
      sigma = underbracket(tau_1, tau) underbracket(tau_2 ... tau_k, sigma') = tau sigma'.
    $
    Since $tau_i$ are all #ponder("algebra.adjacent-transposition")[adjacent transpositions], we have $tau = mat(l, l+1)$ for some $l$. Consider which pairs ${i, j}$ would be inversions of $sigma'$ but not $sigma$, or vice versa.

    The only such pair is ${i, j}$ such that $sigma'(i) = l$ and $sigma'(j) = l+1$. This is because $tau$ only swaps $l$ and $l+1$, so any other pair would remain an inversion or non-inversion in both $sigma'$ and $sigma$.

    For this pair, we have
    $
      sigma'(i) = l < l + 1 = sigma'(j)
    $
    but
    $
      sigma(i) = l + 1 > l = sigma (j).
    $
    Therefore, if $i < j$ and ${i, j}$ is an inversion for $sigma$ but not for $sigma'$, while if $j < i$ and ${i, j}$ is an inversion for $sigma'$ but not for $sigma$.

    In either case,
    $
      hash "inversions of" sigma = hash "inversions of" sigma' plus.minus 1
    $
    as required.
  ]

  By the claim, since $sigma=e$ has $0$ inversions, we see that $k$ must be even.
]

This enables us to define the #ponder("algebra.sign-homomorphism")[sign homomorphism].

#theorem[#ponder("algebra.sign-homomorphism")[Sign homomorphism]][
  The map
  $
          sign: S_n & -> C_2 = {plus.minus 1} \
    tau_1 ... tau_k & mapsto (-1)^k
  $
  is a well-defined #ponder("algebra.homomorphism")[homomorphism].
] <sign-homomorphism>

#proof[
  To see that this is well-defined, suppose $tau_i, tau'_j$ are all #ponder("algebra.transposition")[transpositions] such that
  $
    tau_1 ... tau_k = tau'_1 ... tau'_l
  $
  Then
  $
    tau_1 ... tau_k (tau'_l ... tau'_1) = e,
  $
  so by the previous lemma, $k + l$ is even. Therefore, $k equiv l mod 2$, so $(-1)^k = (-1)^l$.

  To see that this is a #ponder("algebra.homomorphism")[homomorphism], note that
  $
    sign(tau_1 ... tau_k tau'_1 ... tau'_l) = (-1)^(k + l) = (-1)^k (-1)^l = sign(tau_1 ... tau_k) sign(tau'_1 ... tau'_l).
  $
]

#definition[#ponder("algebra.permutation-parity")[Parity of a permutation]][
  If $sign(sigma) = 1$, then $sigma$ is called an *#ponder("algebra.permutation-parity")[even permutation]*. Otherwise, it is called an *#ponder("algebra.permutation-parity")[odd permutation]*.
] <permutation-parity>

#definition[#ponder("algebra.alternating-group")[Alternating group]][
  The subgroup
  $
    A_n = ker (sign) nsub S_n
  $
  is called the *#ponder("algebra.alternating-group")[alternating group]* on $n$ elements. _i.e._ it is the set of all #ponder("algebra.permutation-parity")[even permutations] in $S_n$.
] <alternating-group>

#example[
  In $S_3$, the #ponder("algebra.permutation")[permutations] are
  $
    S_3 = {e, mat(1, 2), mat(1, 3), mat(2, 3), mat(1, 2, 3), mat(1, 3, 2)}.
  $
  We have $mat(1, 2, 3) = mat(1, 2) mat(2, 3)$ and $mat(1, 3, 2) = mat(2, 3) mat(1, 2)$, so the #ponder("algebra.permutation-parity")[even permutations] are
  $
    A_3 = {e, mat(1, 2, 3), mat(1, 3, 2)} teq C_3.
  $
]

#remark[
  The #ponder("algebra.cycle-type")[cycle type] makes it easy to determine the sign of a #ponder("algebra.permutation")[permutation].

  Indeed, $ mat(a_1, ..., a_k) = mat(a_1, a_k), (a_1, a_(k-)1), ..., mat(a_1, a_3) mat(a_1, a_2) $
  so $mat(a_1, ..., a_k)$ is #ponder("algebra.permutation-parity")[even] iff $k$ is odd.

  More generally, a #ponder("algebra.cycle")[$(k_1, ..., k_l)$-cycle] is #ponder("algebra.permutation-parity")[even] iff $abs({"even" k_i})$ is even.
]

#example[
  - $mat(1, 2) mat(3, 4)$ is #ponder("algebra.permutation-parity")[even]
  - $mat(1, 2) mat(3, 4) mat(5, 6)$ is #ponder("algebra.permutation-parity")[odd]
]

== #ponder("algebra.conjugation")[Conjugacy] in $S_n$ and $A_n$

We shall apply what we have obtained so far to study #ponder("algebra.conjugation")[conjugacy] in $S_n$ in $A_n$. Recall that since $A_n$ is a #ponder("algebra.normal-subgroup")[normal subgroup] of $S_n$, the #ponder("algebra.conjugacy-class")[conjugacy class] of any element $alpha in A_n$ in $S_n$ is contained in $A_n$.

#theorem[#ponder("algebra.symmetric-group-conjugacy")[Conjugacy] in $S_n$][
  Two #ponder("algebra.permutation")[permutations] $sigma_1, sigma_2 in S_n$ are #ponder("algebra.conjugation")[conjugate] iff they have the same #ponder("algebra.cycle-type")[cycle type].
] <conjugacy-in-sn>

#proof[

  #fade[[$arrow.l.double$]] Suppose
  $
    sigma_1 = mat(a^1_1, ..., a^1_(l_1)) ... mat(a^k_1, ..., a^k_(l_k))
  $
  is a product of #ponder("algebra.disjoint-cycles")[disjoint cycles]. We have
  $
    sigma_1(a^i_j) = a^i_(j+1 mod l_i).
  $
  Since the #ponder("algebra.cycle-type")[cycle types] are the same, $sigma_2$ can be written as
  $
    sigma_2 = mat(b^1_1, ..., b^1_(l_1)) ... mat(b^k_1, ..., b^k_(l_k)).
  $
  Now
  $
    tau(a^i_j) = b^i_j
  $
  defines a #ponder("algebra.permutation")[permutation] of ${1, 2,..., n} = {a^i_j} = {b^i_j}$. We can compute
  $
    tau sigma_1 tau^(-1) (b^i_j) = tau sigma_1 (a^i_j) = tau (a^i_(j+1 mod l_i)) = b^i_(j+1 mod l_i) = sigma_2 (b^i_j).
  $
  Therefore, $sigma_2 = tau sigma_1 tau^(-1)$.

  #lecture-separator(lecture: 19, date: "2025-11-21")

  #fade[[$=>$]] Suppose $sigma_2 = tau sigma_1 tau^(-1)$. The above argument shows that, if
  $
    sigma_1 = mat(a^1_1, ..., a^1_(l_1)) ... mat(a^k_1, ..., a^k_(l_k)),
  $
  then we can define $b^i_j = tau(a^i_j)$ so that
  $
    sigma_2 = mat(b^1_1, ..., b^1_(l_1)) ... mat(b^k_1, ..., b^k_(l_k))
  $
  for all $1 <= i <= k$ and $1 <= j <= l_i$. Therefore, $sigma_1$ and $sigma_2$ have the same #ponder("algebra.cycle-type")[cycle type].
]

This makes it easy to count #ponder("algebra.conjugacy-class")[conjugacy classes] in $S_n$.

#example[
  Consider
  $
    S_3 = lr(chevron.l {e, mat(1, 2), mat(1, 2, 3)} chevron.r) .
  $
  Then we have
  $
       abs(ccl_(S_3) mat(1, 2)) & = binom(3, 2) = 3, \
    abs(ccl_(S_3) mat(1, 2, 3)) & = 2 times 1 = 2.
  $
]

#example[
  Consider $S_4$ without knowing its exact elements.
  Then we have
  $
    abs(ccl_(S_4) (mat(1, 2) mat(3, 4))) & = binom(4, 2) times (1)/(2) = 3. \
  $

]

Recall that @def-conjugacy-class[Conjugation Classes] are essentially orbits under the conjugation action of $S_n$ on itself, and the @def-centraliser[Centraliser] of an element is its stabiliser under this action.

Then, @orbit-stabiliser[Orbit-Stabiliser Theorem] implies that
$
  abs(C_(S_n)(gamma)) = (abs(S_n))/(abs(ccl_(S_n) (gamma)))
$

Therefore, it is also easy to count the sizes of #ponder("algebra.centraliser")[centralisers].

#example[
  In $S_4$, we have

  $
    C_(S_4) (mat(1, 2)mat(3, 4)) = abs(S_4) / abs(ccl_(S_4) (mat(1, 2) mat(3, 4))) = 24 / 3 = 8.
  $

  Indeed, we can make a list:
  $
    C_(S_4) (mat(1, 2) mat(3, 4)) = {e, mat(1, 2) mat(3, 4), mat(1, 2), mat(3, 4), mat(1, 3) mat(2, 4), mat(1, 4) mat(2, 3), mat(1, 4, 2, 3), mat(1, 3, 2, 4)}.
  $
]

#example[#ponder("algebra.conjugation")[Conjugacy] at $S_4$][
  We can list all the #ponder("algebra.conjugacy-class")[conjugacy classes] in $S_4$.

  We can write out a table:
  #table(
    columns: (1fr, 1fr, 1fr),
    [*Typical element* $gamma$], $abs(ccl_(S_4)(gamma))$, $abs(C_(S_4) (gamma))$,
    $e$, $1$, $24$,
    $mat(1, 2)$, $binom(4, 2)=6$, $4$,
    $mat(1, 2)mat(3, 4)$, $(1)/(2) binom(4, 2) = 3$, $8$,
    $mat(1, 2, 3)$, $binom(4, 3) times 2 = 8$, $3$,
    $mat(1, 2, 3, 4)$, $3! = 6$, $4$,
  )

  We should verify that the sizes of the #ponder("algebra.conjugacy-class")[conjugacy classes] add up to $24$.

  Indeed, $1 + 6 + 3 + 8 + 6 = 24$ as expected.
]

Now, counting #ponder("algebra.conjugacy-class")[conjugacy classes] in $A_n$ is slightly more subtle. Recall that $C_G (g)$ is the set of elements of $G$ that commute with $g$.

#lemma[#ponder("algebra.alternating-group-conjugacy-splitting")[Conjugacy classes in $A_n$]][
  Let $gamma in A_n nsub S_n$.

  1. If some #ponder("algebra.permutation-parity")[odd] element of $S_n$ commutes with $gamma$, then
    $
      ccl_(A_n) (gamma) = ccl_(S_n) (gamma).
    $
  2. Otherwise, if every element of $S_n$ that commutes with $gamma$ is #ponder("algebra.permutation-parity")[even], then
    $ccl_(S_n)(gamma)$ splits into two:
    $
      ccl_(A_n) (gamma) union ccl_(A_n) (tau gamma tau^(-1)) = ccl_(S_n) (gamma)
    $
    where $tau$ is any #ponder("algebra.transposition")[transposition] (or any #ponder("algebra.permutation-parity")[odd permutation]).
] <lemma-conjugacy-classes-an-sn>

#proof[
  @orbit-stabiliser[Orbit-Stabiliser Theorem] gives
  $
    abs(S_n) & = abs(ccl_(S_n) (gamma)) dot abs(C_(S_n) (gamma)) \
    abs(A_n) & = abs(ccl_(A_n) (gamma)) dot abs(C_(A_n) (gamma)) \
  $
  Since $abs(S_n) = 2abs(A_n)$, this gives
  #set math.equation(numbering: "(*)")
  $
    abs(ccl_(S_n) (gamma)) & = 2 abs(C_(A_n) (gamma))/(abs(C_(S_n) (gamma)) ) dot abs(ccl_(A_n) (gamma)).
  $ <eq-conjugacy-classes-an-sn>
  #set math.equation(numbering: none)

  $C_(A_n)(gamma)$ is the #ponder("algebra.permutation-parity")[even permutations] that commute with $gamma$, and $C_(S_n)(gamma)$ is all #ponder("algebra.permutation")[permutations] that commute with $gamma$. #fade[[So $C_(A_n)(gamma)$ is the #ponder("algebra.permutation-parity")[even] _bits_ of $C_(S_n)(gamma)$.]] Therefore, we can write $C_(A_n)(gamma)$ as the kernel of the #ponder("algebra.sign-homomorphism")[sign homomorphism] restricted to $C_(S_n)(gamma)$:

  $ C_(A_n)(gamma) = ker (sign bar_(C_(S_n) (gamma)) : C_(S_n) (gamma) -> C_2). $
  The image of $sign bar_(C_(S_n) (gamma))$ has size $1$ or $2$ #fade[[since it is a subgroup of $C_2$]], so by the @isomorphism-theorem[Isomorphism Theorem], we have
  $
    [C_(S_n)(gamma): C_(A_n)(gamma)] = 1 "or" 2.
  $
  1. If there is an #ponder("algebra.permutation-parity")[odd] element of $S_n$ that commutes with $gamma$#fade[[, then this element is in $C_(S_n)(gamma)$ but not in $C_(A_n)(gamma)$]], so
    $
      [C_(S_n (gamma)) : C_(A_n) (gamma)] = 2.
    $
    Using @lagranges-theorem[Lagrange's theorem], #fade[[we have $abs(C_(S_n)(gamma)) = 2 abs(C_(A_n) (gamma))$ , and]] @eq-conjugacy-classes-an-sn then becomes
    $
      abs(ccl_(S_n)(gamma)) = cancel(2 abs(C_(A_n)(gamma)))/cancel(2 abs(C_(A_n)(gamma))) dot abs(ccl_(A_n)(gamma)) = abs(ccl_(A_n)(gamma)).
    $
    Since $ccl_(A_n) (gamma) subset.eq ccl_(S_n)(gamma)$,  $ccl_(A_n)(gamma) = ccl_(S_n)(gamma)$ as required.

  2. The hypothesis means that
    $
      C_(S_n)(gamma) = C_(A_n)(gamma)
    $
    so @eq-conjugacy-classes-an-sn becomes
    $
      abs(ccl_(S_n)(gamma)) = 2 abs(ccl_(A_n)(gamma)).
    $
    So $ccl_(A_n)(gamma)$ is half as big as $ccl_(S_n)(gamma)$.

    Now consider a #ponder("algebra.transposition")[transposition] $tau in S_n$. Note that $tau gamma tau^(-1) in ccl_(S_n) (gamma)$.

    For the sake of contradiction, suppose $tau gamma tau^(-1) in ccl_(A_n)(gamma)$. Then there exists $alpha in A_n$ such that
    $ tau gamma tau^(-1) = alpha gamma alpha^(-1). $
    But then, by rearranging, we have
    $
      (tau alpha) gamma (tau alpha)^(-1) = gamma,
    $
    which means that $tau alpha$ commutes with $gamma$. So $tau alpha in C_(S_n)(gamma)$. But $tau alpha$ is #ponder("algebra.permutation-parity")[odd]#fade[[, so some #ponder("algebra.permutation-parity")[odd permutation] now commutes with $gamma$]]. $smash$

    Therefore, $tau gamma tau^(-1) in.not ccl_(A_n)(gamma)$, as required.

]

This makes it possible to determine the #ponder("algebra.conjugacy-class")[conjugacy classes] in $A_n$.

#example[#ponder("algebra.conjugation")[Conjugacy] in $A_4$][
  Consider $A_4 nsub S_4$. The #ponder("algebra.permutation-parity")[even] elements of $S_4$ are $e$, $(2, 2)$-cycles and $3$-cycles. Note that $e$ commutes with every element, so its #ponder("algebra.conjugacy-class")[conjugacy class] in $A_4$ is the same as in $S_4$.

  Since there is an odd number of $(2, 2)$-cycles in $S_4$, the #ponder("algebra.conjugacy-class")[conjugacy class] of $mat(1, 2) mat(3, 4)$ remains intact in $A_4$ #fade[[we cannot split it into two equal parts]].

  Finally, consider a #ponder("algebra.cycle")[$3$-cycle], say $sigma = mat(1, 2, 3)$. We have
  $
    abs(C_(S_4) mat(1, 2, 3)) = 3
  $
  and since we know that the #ponder("algebra.cyclic-group")[cyclic group] generated by $sigma$ definitely commutes with $sigma$, we have
  $
    C_(S_4) mat(1, 2, 3) = lr(chevron.l mat(1, 2, 3) chevron.r) <= A_4
  $
  and the #ponder("algebra.conjugacy-class")[conjugacy class] of $sigma$ splits into two in $A_4$. In summary,
  #table(
    columns: (1fr, 1fr),
    [*Typical element* $gamma$], $abs(ccl_(A_4)(gamma))$,
    $e$, $1$,
    $mat(1, 2) mat(3, 4)$, $3$,
    $mat(1, 2, 3)$, $4$,
    $mat(3, 2, 1)$, $4$,
  )
]

#lecture-separator(lecture: 20, date: "2025-11-24")

Finally, let us look at #ponder("algebra.conjugation")[conjugacy] in $S_5$ and $A_5$.

#example[#ponder("algebra.conjugation")[Conjugacy] in $S_5$][
  We can write out the #ponder("algebra.conjugacy-class")[conjugacy classes] in $S_5$ as follows:
  #table(
    columns: (auto, 1fr, 1fr, 1fr),
    [*Even*], [*Typical element* $gamma$], $abs(ccl_(S_5)(gamma))$, $abs(C_(S_5) (gamma))$,
    $checkmark$, $e$, $1$, $120$,
    $crossmark$, $mat(1, 2)$, $binom(5, 2) = 10$, $12$,

    $checkmark$, $mat(1, 2, 3)$, $binom(5, 3) times 2 = 20$, $6$,

    $checkmark$, $mat(1, 2)mat(3, 4)$, $(1)/(2) binom(5, 2) binom(3, 2) = 15$, $8$,
    $crossmark$, $mat(1, 2, 3)mat(4, 5)$, $binom(5, 3) times 2 = 20$, $6$,
    $crossmark$, $mat(1, 2, 3, 4)$, $binom(5, 4) times 3! = 30$, $4$,
    $checkmark$, $mat(1, 2, 3, 4, 5)$, $4! = 24$, $5$,
  )
  The sizes of the #ponder("algebra.conjugacy-class")[conjugacy classes] add up to $120$ as expected.
]

#example[#ponder("algebra.conjugation")[Conjugacy] in $A_5$][
  Consider $A_5 nsub S_5$. The #ponder("algebra.permutation-parity")[even] elements of $S_5$ are $e$, $(3)$-cycles, $(2, 2)$-cycles and $(5)$-cycles.

  Note that
  - $e$ commutes with every element, so its #ponder("algebra.conjugacy-class")[conjugacy class] in $A_5$ is the same as in $S_5$.

  - $mat(4, 5) <= C_(S_5) mat(1, 2, 3)$, so the #ponder("algebra.conjugacy-class")[conjugacy class] of $mat(1, 2, 3)$ remains intact in $A_5$.

  - Since $15$ is odd, the #ponder("algebra.conjugacy-class")[conjugacy class] of $mat(1, 2) mat(3, 4)$ remains intact in $A_5$.

  - $abs(C_(S_5) mat(1, 2, 3, 4, 5)) = 5$, so $C_(S_5) mat(1, 2, 3, 4, 5) = lr(chevron.l mat(1, 2, 3, 4, 5) chevron.r) <= A_5$. Therefore, the #ponder("algebra.conjugacy-class")[conjugacy class] of $mat(1, 2, 3, 4, 5)$ splits into two in $A_5$.

  #table(
    columns: (1fr, 1fr),
    [*Typical element* $gamma$], $abs(ccl_(A_5)(gamma))$,
    $e$, $1$,
    $mat(1, 2, 3)$, $20$,
    $mat(1, 2) mat(3, 4)$, $15$,
    $mat(1, 2, 3, 4, 5)$, $12$,
    $mat(5, 4, 3, 2, 1)$, $12$,
  )
  The sizes of the #ponder("algebra.conjugacy-class")[conjugacy classes] add up to $60$ as expected.
]

#theorem[
  #ponder("algebra.a5-simplicity")[$A_5$ is simple.]
] <a5-simplicity>
#proof[
  Suppose $N nsub A_5$. By Example Sheet 3 Q5, $N$ is a union of #ponder("algebra.conjugacy-class")[conjugacy classes] in $A_5$. At this point, we can list the possible union sizes of #ponder("algebra.conjugacy-class")[conjugacy classes] in $A_5$ and see if they divide $60$ (by @lagranges-theorem[Lagrange's Theorem]).

  The possible union sizes are #fade[[note that $e$ must be included]]:
  $
                1 & = 1  & quad checkmark \
             1+20 & = 21 &      crossmark \
          1+20+15 & = 36 &      crossmark \
          1+20+12 & = 33 &      crossmark \
       1+20+15+12 & = 48 &      crossmark \
    1+20+15+12+12 & = 60 &      checkmark \
       1+20+12+12 & = 45 &      crossmark \
             1+15 & = 16 &      crossmark \
          1+15+12 & = 28 &      crossmark \
       1+15+12+12 & = 40 &      crossmark \
             1+12 & = 13 &      crossmark \
          1+12+12 & = 25 &      crossmark \
  $
  Therefore, the only possible sizes for $N$ are $1$ and $60$, so $N = {e}$ or $N = A_5$. Hence, #ponder("algebra.a5-simplicity")[$A_5$ is simple].
]
