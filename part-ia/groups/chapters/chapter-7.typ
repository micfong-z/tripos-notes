#import "../prelude.typ": *

= #ponder("algebra.quotient-group")[Quotient Groups]

== #ponder("algebra.normal-subgroup")[Normal Subgroups]

Let $phi: G->H$ be a #ponder("algebra.group")[group] #ponder("algebra.homomorphism")[homomorphism].
$
  ker phi <= G
$
is always a special kind of #ponder("algebra.subgroup")[subgroup].

#definition[#ponder("algebra.normal-subgroup")[Normal subgroup]][
  $H <= G$ is called a *#ponder("algebra.normal-subgroup")[normal subgroup]* if for all $h in H, g in G$, we have $g h g^(-1) in H$. If so, we write $H nsub G$.
] <normal-subgroup>

#example[
  1. $1 nsub G$, $G nsub G$ for any #ponder("algebra.group")[group] $G$.
  2. If $G$ is #ponder("algebra.abelian-group")[abelian] and $H <= G$, then $H nsub G$.
  3. $lr(chevron.l r chevron.r) nsub D_(2n)$ since

    $
      s r^k s^(-1) = r^(-k) in lr(chevron.l r chevron.r)
    $
    by the #ponder("algebra.dihedral-relation")[dihedral relation] #fade[[we don't have to check $r$ since it is in $lr(chevron.l r chevron.r)$]]. But $lr(chevron.l s chevron.r)$ is not #ponder("algebra.normal-subgroup")[normal] since
    $
      r s r^(-1) = s r^(-2) != s.
    $

  4. Suppose $phi: G->G'$ is a #ponder("algebra.homomorphism")[homomorphism]. If $h in ker phi$ and $g in G$ then $ phi(g h g^(-1)) = phi(g) phi(h) phi(g)^(-1) = phi(g) phi(g)^(-1) = e, $so $g h g^(-1) in ker phi$. Thus $ker phi nsub G$.
]

#lecture-separator(lecture: 16, date: "2025-11-14")

#lemma[
  Suppose $H <= G$. Then $H nsub G$ iff
  $
    g H = H g
  $
  for all $g in G$.
] <lemma-normal-subgroup-cosets>

#proof[

  #fade[[$=>$]] Let $h in H$ and $g in G$. Since $H nsub G$, we have $g h g^(-1) in H$. Therefore
  $
    g h = (g h g^(-1)) g in H g.
  $
  Therefore $g H subset.eq H g$. Similarly, for any $h' in H$, we have $g^(-1) h' g in H$ so
  $ h' g = g (g^(-1) h' g) in g H. $
  Thus $H g subset.eq g H$, and so $g H = H g$.

  #fade[[$arrow.l.double$]] Suppose $g H = H g$ for all $g in G$. Let $h in H$. Then
  $
    g h in g H = H g
  $
  so there exists $h' in H$ such that $g h = h' g$.
  $
    g h g^(-1) = h' in H.
  $
  Thus $H nsub G$.
]

== #ponder("algebra.quotient-group")[Quotient Groups]

#theorem[#ponder("algebra.quotient-group-theorem")[Quotient group is a group]][
  If $H nsub G$, the set of (left) #ponder("algebra.coset")[cosets] $G \/ H$ is a #ponder("algebra.group")[group] with #ponder("algebra.binary-operation")[operation]
  $
    (g_1 H) (g_2 H) = (g_1 g_2) H.
  $
] <theorem-quotient-group-is-a-group>

#proof[
  We need to check that the #ponder("algebra.binary-operation")[operation] is well-defined and satisfies the #ponder("algebra.group")[group axioms].

  #boxed-header[Well-definedness]

  Suppose $g_1 H = g'_1 H$ and $g_2 H = g'_2 H <=> H g_2 = H g'_2$ since $H nsub G$.

  That is, there are $h_1, h_2 in H$ such that
  $
    g_1 = g'_1 h_1, quad g_2 = h_2 g'_2.
  $

  Therefore,
  $
    g_1g_2 = (g'_1 h_1)(h_2 g'_2) = g'_1 underbracket((h_1 h_2) g'_2, in H g'_2) = g'_1 g'_2 h_3
  $
  by @lemma-normal-subgroup-cosets, for some $h_3 in H$. Thus,
  $ (g_1 g_2) H = (g'_1 g'_2) H $
  so
  $
    (g_1 g_2) H = (g'_1 g'_2) H
  $
  since #ponder("algebra.coset")[cosets] #ponder("algebra.coset-partition")[partition].

  #boxed-header[#ponder("algebra.group")[Group axioms]]

  - *#ponder("algebra.group")[Associativity].* Immediate from #ponder("algebra.group")[associativity] in $G$.

  - *#ponder("algebra.group")[Identity].* The identity is $e H = H$.

  - *#ponder("algebra.group")[Inverses].* The inverse of $g H$ is $g^(-1) H$ since
    $
      (g H)(g^(-1) H) = (g g^(-1)) H = e H.
    $

  - *#ponder("algebra.group")[Closure].* Immediate from the definition of the #ponder("algebra.binary-operation")[operation].

  Therefore $G \/ H$ is a #ponder("algebra.group")[group].
]

#definition[#ponder("algebra.quotient-group")[Quotient group]][
  If $H nsub G$, the group $G \/ H$ provided by @theorem-quotient-group-is-a-group is called the *#ponder("algebra.quotient-group")[quotient]* of $G$ by $H$.
] <quotient-group>

#example[
  1. $G \/ 1 teq G$, $G \/ G teq 1$.

  2. Since $ZZ$ is #ponder("algebra.abelian-group")[abelian], $n ZZ nsub ZZ$ for any $n$. Thus, for any $n in ZZ^*$, we have the #ponder("algebra.quotient-group")[quotient group]
    $
      ZZ \/ n ZZ teq C_n
    $
    with #ponder("algebra.cyclic-group")[generator] $1 + n ZZ$ of order $n$.

  3. Let $G$ be a #ponder("algebra.group")[group], $H <= G$, and suppose $[G : H] = 2$. Then, for any $g in.not H$,
    $
      g H = G \\ H = H g.
    $
    and $e H = H e$. So by @lemma-normal-subgroup-cosets, $H nsub G$. Furthermore, $G \/ H teq C_2$ since its #ponder("algebra.group-order")[order] is 2.

  4. An example of (3) is

    $
      C_n teq lr(chevron.l r chevron.r) nsub D_(2n)
    $
    and hence $D_(2n) \/ C_n teq C_2$.

  #important[
    It is a common error that one might think we can _multiply_ groups using #ponder("algebra.direct-product")[direct products] and get back to the original group.

    5. Note that

      $
        C_4 \/ C_2 teq C_2, quad "and" quad K_4 \/ C_2 teq C_2.
      $
      But $C_4 teq.not K_4$ since $C_4$ is #ponder("algebra.cyclic-group")[cyclic] but $K_4$ is not. This shows that #ponder("algebra.quotient-group")[quotient groups] do not _undo_ #ponder("algebra.direct-product")[direct products]. In particular, for groups $A, B, C$,
      $
        A \/ B equiv C arrow.double.not A equiv B times C.
      $
  ]
]

== The #ponder("algebra.isomorphism-theorem")[Isomorphism Theorem]

#theorem[#ponder("algebra.isomorphism-theorem")[Isomorphism theorem]][
  If $phi: G->H$ is a #ponder("algebra.homomorphism")[homomorphism], then
  $
    G \/ ker phi teq im phi.
  $
] <isomorphism-theorem>

#proof[
  Since $ker phi nsub G$, the #ponder("algebra.quotient-group")[quotient] $G \/ ker phi$ is a #ponder("algebra.group")[group]. Let us define
  $
    overline(phi): G\/ ker phi & -> im phi \
                     g ker phi & |-> phi(g).
  $

  We first check that $overline(phi)$ is a well-defined #ponder("algebra.isomorphism")[isomorphism].

  #boxed-header[Well-definedness]

  Suppose $g_1 ker phi = g_2 ker phi$. We need to show that $phi(g_1) = phi(g_2)$.

  We have
  $
    g_1 = g_2 k
  $
  for some $k in ker phi$ since $g_1 ker phi = g_2 ker phi$. Then,
  $
    overline(phi)(g_1 ker phi) = phi(g_1) = phi(g_2 k) = phi(g_2) phi(k) = phi(g_2) e = phi(g_2) = overline(phi)(g_2 ker phi).
  $

  #boxed-header[#ponder("algebra.homomorphism")[Homomorphism]]

  For $g_1, g_2 in G$,

  $
    overline(phi)((g_1 ker phi) (g_2 ker phi)) = overline(phi)((g_1 g_2) ker phi) = phi(g_1 g_2) = phi(g_1) phi(g_2) = overline(phi)(g_1 ker phi) overline(phi)(g_2 ker phi).
  $

  #boxed-header[#ponder("algebra.homomorphism-bijectivity")[Injectivity]]

  Recall that a #ponder("algebra.homomorphism")[homomorphism] is #ponder("algebra.homomorphism-bijectivity")[injective] iff its #ponder("algebra.image-kernel")[kernel] is #ponder("algebra.trivial-group")[trivial].

  If $overline(phi) (g ker phi) = e$, then
  $
    phi(g) = overline(phi)(g ker phi) = e,
  $
  so $g in ker phi$, and hence $g ker phi = ker phi$.

  That is, $ker overline(phi) = {ker phi}$, so $overline(phi)$ is #ponder("algebra.homomorphism-bijectivity")[injective].

  #boxed-header[#ponder("algebra.homomorphism-bijectivity")[Surjectivity]]

  A typical element of $im phi$ is $phi(g)$ for some $g in G$. But
  $
    overline(phi)(g ker phi) = phi(g),
  $
  so $overline(phi)$ is #ponder("algebra.homomorphism-bijectivity")[surjective].
]

#example[
  1. Because $phi: ZZ -> CC^*_times$ defined by $phi(k) = ee^((2 ppi ii k) / n)$ is a #ponder("algebra.homomorphism")[homomorphism] with #ponder("algebra.image-kernel")[image] $C_n$ and #ponder("algebra.image-kernel")[kernel] $n ZZ$, by @isomorphism-theorem[ isomorphism theorem], we have
    $
      ZZ \/ n ZZ teq im phi teq C_n.
    $

  2. Similarly, $phi: RR -> CC^*_times$ defined by $phi(t) = ee^(2ppi ii t)$ is a #ponder("algebra.homomorphism")[homomorphism] with
    $
       im phi & = {z in CC: abs(z) = 1} = U(1) \
      ker phi & = ZZ
    $

    so by @isomorphism-theorem[isomorphism theorem], we have
    $ RR \/ ZZ teq U(1). $
]

#lecture-separator(lecture: 17, date: "2025-11-17")

#definition[#ponder("algebra.simple-group")[Simple group]][
  A #ponder("algebra.group")[group] $G$ is *#ponder("algebra.simple-group")[simple]* if the only #ponder("algebra.normal-subgroup")[normal subgroups] are $1$ and $G$ itself. Thus every #ponder("algebra.homomorphism")[homomorphism] $phi: G->H$ is either #ponder("algebra.trivial-group")[trivial] or #ponder("algebra.homomorphism-bijectivity")[injective]. #fade[[Since $ker phi nsub G$, so either $ker phi = 1$ or $ker phi = G$.]]
] <simple-group>

#example[
  $C_p$ is #ponder("algebra.simple-group")[simple] whenever $p$ is a prime.
]

An important question in group theory is to find and understand examples of non-#ponder("algebra.abelian-group")[abelian] #ponder("algebra.simple-group")[simple groups].
