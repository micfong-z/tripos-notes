#import "../prelude.typ": *

#lecture-separator(lecture: 6, date: "2025-10-22")

= #ponder("algebra.homomorphism")[Homomorphism] and #ponder("algebra.isomorphism")[Isomorphism]

== Introduction on #ponder("algebra.homomorphism")[Homomorphisms] and #ponder("algebra.isomorphism")[Isomorphisms]

Some #ponder("algebra.group")[groups] are not set-theoretically _equal_, but nonetheless have the same structure. _e.g._ $sym({"A deck of cards"})$ and $sym({"52 undergraduate mathematicians"})$. We wish to encompass this underlying strucutre.

#definition("Homomorphism")[
  A map between #ponder("algebra.group")[groups]
  $ phi: G->H $
  is called a *#ponder("algebra.homomorphism")[homomorphism]* if

  $ phi (g dot g') = phi (g) dot phi(g') $
  for all $g, g' in G$.
] <homomorphism>

#example[
  1. For any two #ponder("algebra.group")[groups] $G$ and $H$, the map
    $ phi: G->H quad "with" quad g |-> e_H $
    for all $g in G$ is a #ponder("algebra.homomorphism")[homomorphism], called the *trivial #ponder("algebra.homomorphism")[homomorphism]*.

  3. If $H <= G$, then the map

    $ i: H->G quad "with" quad h|->h $

    is the *inclusion #ponder("algebra.homomorphism")[homomorphism]*.

  4. Recall that $C_n = {z in CC: z^n = 1}$.

    #exercise[
      Show that if $n mid(|) m$, then
      $ phi: C_m -> C_n quad "with" quad z |-> z^(m/n) $
      is a #ponder("algebra.homomorphism")[homomorphism].
    ]

  5. Since $det(A B) = det(A) det(B)$, the determinant function

    $ det: G L_2(RR) -> (RR^*, times ) quad "with" quad A |-> det(A) $

    is a #ponder("algebra.homomorphism")[homomorphism].
]

#lemma[
  If $phi: G->H$ is a #ponder("algebra.homomorphism")[homomorphism], then

  1. $phi(e_G) = e_H$.

  2. $phi(g^(-1)) = phi(g)^(-1)$ for all $g in G$.
] <hom-lemma-1>

#proof[

  1. We have

    $
      phi(e_G) dot phi(e_G) & = phi(e_G dot e_G) \
                            & = phi(e_G). \
    $
    Note that $phi(e_G)$, being multiplied by a #ponder("algebra.group")[group] element and yielding itself, must be the #ponder("algebra.group")[identity] element $e_H$. This is by @prop-group1 (4).

  2. We have

    $
      phi(g) dot phi(g^(-1)) & = phi(g dot g^(-1)) \
                             & = phi(e_G) \
                             & = e_H. \
    $
    Thus, by @prop-group1 (3), we have $phi(g^(-1)) = phi(g)^(-1)$.
]

To discuss the notion of two #ponder("algebra.group")[groups] being "structurally the same", we can do this using #ponder("algebra.isomorphism")[isomorphisms].

#definition("Isomorphism")[
  If a #ponder("algebra.homomorphism")[homomorphism]
  $ phi: G->H $
  is a #ponder("algebra.bijection")[bijection], then $phi$ is an *#ponder("algebra.isomorphism")[isomorphism]*. In this case, we write
  $ G teq H. $
  From the perspective of #ponder("algebra.group")[group] theory, #ponder("algebra.isomorphism")[isomorphic groups] are considered _the same_.
] <isomorphism>

#example[
  1. Recall that $C_n = {z in CC: z^n = 1}$ with operation $times$, and $ZZ_n = {0, 1, ..., n-1}$ with operation $+_n$.

    Let $ phi: ZZ_n -> C_n quad "with" quad k|->ee^((2 ppi ii k)/(n)). $

    Clearly, $phi$ is #ponder("algebra.bijection")[bijective]. Further more, for any $k, l in ZZ$,

    $ k + l = n p + (k +_n l) $
    for some $p in ZZ$, so
    $
      phi(k +_n l) & = ee^((2 ppi ii)/(n) (k +_n l)) quad                           &       "by the definition of" phi \
                   & = ee^((2 ppi ii)/(n) (n p)) ee^((2 ppi ii)/(n) (k +_n l)) quad & "multiply by" 1 "in a fancy way" \
                   & = ee^((2 ppi ii)/(n) (n p + k +_n l)) \
                   & = ee^((2 ppi ii)/(n) ( k + l)) \
                   & = ee^((2 ppi ii)/(n) ( k)) ee^((2 ppi ii)/(n) ( l)) \
                   & = phi(k) dot phi(l). quad                                      &       "by the definition of" phi \
    $
    Therefore, $phi$ is indeed an #ponder("algebra.homomorphism")[homomorphism], and hence an #ponder("algebra.isomorphism")[isomorphism]. That is,
    $ ZZ_n teq C_n $
    for all $n$.

  2. The exponential map
    $ exp: (RR, +, 0) -> (RR^+, times, 1) quad "with" quad x |-> ee^x $

    is a #ponder("algebra.homomorphism")[homomorphism], because

    $
      exp(x + y) & = ee^(x + y) \
                 & = ee^x ee^y \
                 & = exp(x) times exp(y). \
    $

    Since $exp^(-1) equiv log$, $exp$ is also a #ponder("algebra.bijection")[bijection]. Hence $exp$ is an #ponder("algebra.isomorphism")[isomorphism].

]

The following lemma justifies the claim that we may think of #ponder("algebra.isomorphism")[isomorphic groups] as "the same".

#lemma[
  1. If $phi: G->H$ is an #ponder("algebra.isomorphism")[isomorphism], so is $phi^(-1)$.
  2. If $G attach(->, t: phi) H attach(->, t: psi) K,$ are #ponder("algebra.homomorphism")[homomorphisms], so is $psi compose phi$.
  3. $teq$ is an equivalence relation.
]

#exercise[
  Prove this lemma.
]

We have seen that every #ponder("algebra.subgroup")[subgroup] leads to an inclusion #ponder("algebra.homomorphism")[homomorphism]. This is conversely true, that a #ponder("algebra.homomorphism")[homomorphism] leads to #ponder("algebra.subgroup")[subgroups].

#definition("Image and Kernel")[
  Let $phi: G->H$ be a #ponder("algebra.homomorphism")[homomorphism].

  1. The *#ponder("algebra.image-kernel")[image]* of $phi$ is $im phi = { h in H:exists g in G, h = phi(g) }.$

  2. The *#ponder("algebra.image-kernel")[kernel]* of $phi$ is $ker phi = { g in G: phi(g) = e_H }.$

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d3e1.svg", width: 16em)
  ]
] <image-kernel>

#proposition[
  If $phi: G->H$ is a #ponder("algebra.homomorphism")[homomorphism], then

  1. $im phi <= H$, and
  2. $ker phi <= G$.
] <image-kernel-subgroups>

#proof[
  1. - In @hom-lemma-1, we showed that $e_H = phi(e_G) in im phi$.

    - For $phi(g_1), phi(g_2) in im phi$, we have
      $ phi(g_1) dot phi(g_2) = phi(g_1 dot g_2) in im phi. $

    - For $g in G$,
      $ phi(g)^(-1) = phi(g^(-1)) in im phi. $

    Therefore $im phi <= H$.

  2. - $phi(e_G) = e_H => e_G in ker phi.$
    - For $g_1, g_2 in ker phi$,
      $
        phi(g_1 dot g_2) & = phi(g_1) dot phi(g_2) \
                         & = e_H dot e_H \
                         & = e_H.
      $
      So $g_1 dot g_2 in ker phi$.

    - For $g in ker phi$,
      we have
      $
        phi(g^(-1))=phi(g)^(-1)=e_H^(-1)=e_H.
      $
      So $g^(-1) in ker phi$.

    Therefore $ker phi <= G$.
]

#proposition[
  Let $phi : G->H$ be a #ponder("algebra.homomorphism")[homomorphism].

  1. $phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective] if and only if $im phi = H$.

  2. $phi$ is #ponder("algebra.homomorphism-bijectivity")[injective] if and only if $ker phi = 1_G$.
] <hom-prop-2>

#lecture-separator(lecture: 7, date: "2025-10-24")

#proof[

  1. This is immediate from the definition of #ponder("algebra.homomorphism-bijectivity")[surjectivity] and #ponder("algebra.image-kernel")[image].

  2. Indeed, if $phi$ is #ponder("algebra.homomorphism-bijectivity")[injective], then $ ker phi = phi^(-1)(e_H). $
    This has at most one element, and since $e_G in ker phi$, we have $ker phi = { e_G } = 1_G$.

    Conversely, suppose $ker phi = 1_G$. If $phi(g_1) = phi(g_2)$, then

    $
      phi(g_1 g_2^(-1)) = phi(g_1) phi(g_2)^(-1) = e_H.
    $

    This calculation shows that $g_1 g_2^(-1) in ker phi$, so $g_1 g_2^(-1) = e_G$ by assumption, and hence $g_1 = g_2$. Thus $phi$ is #ponder("algebra.homomorphism-bijectivity")[injective].
]

#proposition[
  By @hom-prop-2, a #ponder("algebra.homomorphism")[homomorphism] $phi: G->H$ is an #ponder("algebra.isomorphism")[isomorphism] if and only if $im phi = H$ and $ker phi = 1_G$.
] <isomorphism-criterion>

== #ponder("algebra.cyclic-group")[Cyclic Groups]

The #ponder("algebra.group")[groups] $C_n teq ZZ_n$ that we have seen are examples of _#ponder("algebra.cyclic-group")[cyclic groups]_.

#definition("Cyclic Group")[
  A #ponder("algebra.group")[group] $G$ is *#ponder("algebra.cyclic-group")[cyclic]* if there exists an element $g in G$ such that

  $ G = lr(chevron.l g chevron.r) = { g^n: n in ZZ }. $

  Such an element $g$ is called a *#ponder("algebra.cyclic-group")[generator]* of $G$.
] <cyclic-group>

#example[
  1. $C_n = {z in CC: z^n = 1}$ is #ponder("algebra.cyclic-group")[cyclic], with #ponder("algebra.cyclic-group")[generator] $ee^((2 ppi ii) / n)$.

  2. $(ZZ, +)$ is #ponder("algebra.cyclic-group")[cyclic], with #ponder("algebra.cyclic-group")[generator] $1$.

  3. $ZZ_n$ is #ponder("algebra.cyclic-group")[cyclic], since $ZZ_n teq C_n$.
]

#theorem[
  If $G$ is #ponder("algebra.cyclic-group")[cyclic], then either

  - $G teq C_n$ for some $n in ZZ$, or
  - $G teq ZZ$.
] <cyclic-group-classification>

#proof[
  Let $G$ be a #ponder("algebra.cyclic-group")[cyclic group] with #ponder("algebra.cyclic-group")[generator] $g$. Let
  $ S = {k in ZZ^+: g^k = e}, $
  and let $ n = cases(min S quad& "if" S != emptyset, oo quad & "if" S = emptyset). $

  #separator

  *Case 1.* If $n = oo$, Define
  $ phi: ZZ->G quad "with" quad k |-> g^abs(k) $
  We need to show that $phi$ is an #ponder("algebra.isomorphism")[isomorphism]. Since
  $ phi(k+l) = g^(k+l) = g^k g^l = phi(k)phi(l), $
  $phi$ is certainly a #ponder("algebra.homomorphism")[homomorphism].

  By the definition of #ponder("algebra.cyclic-group")[cyclic groups], $phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective].

  To prove that $phi$ is #ponder("algebra.homomorphism-bijectivity")[injective], for the purpose of contradiction, suppose that $0 != k in ker phi$. Since $ker phi <= ZZ$, we may replace $k$ by $-k$ if necessary, and assume $k > 0$. Then $k in S => S != emptyset$, which is a contradiction because $n in oo$. $smash$

  Therefore, $ker phi = {0}$ so $phi$ is #ponder("algebra.homomorphism-bijectivity")[injective]. Hence, $phi$ is an #ponder("algebra.isomorphism")[isomorphism] and $G teq ZZ$.


  #separator

  *Case 2.* If $n < oo$, define
  $ phi: ZZ_n -> G quad "with" quad k |-> g^k. $

  Since $k + l = q n + (k +_n l)$ for some $q in ZZ$, we have

  $
    phi(k) phi(l) & = g^k g^l \
                  & = g^(k+l) \
                  & = g^(q n + (k +_n l)) \
                  & = g^(k +_n l) \
                  & = phi(k +_n l). \
  $

  Thus, $phi$ is a #ponder("algebra.homomorphism")[homomorphism].

  To prove that $phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective], since $G$ is #ponder("algebra.cyclic-group")[cyclic], every element can be written as $g^k$ for some $k in ZZ$. By the division algorithm, we can write $k = q n + r$ for some $q in ZZ$ and $r in ZZ_n$. Therefore,

  $ g^k = g^(n q + r) = (g^(n))^q g^r = g^r = phi(r). $

  This proves that $phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective].

  To prove #ponder("algebra.homomorphism-bijectivity")[injectivity], suppose that $phi(k) = e$ for some $k in ZZ_n$ #fade[[this is equivalent to saying $k in ker phi$]]. Then $k in S$ or $k = 0$. Since $n$ is minimal in $S$, and that $n > 0$ and $phi(n) = e$, it follows that $k = 0$, because $k < n$. Therefore, $ker phi = {0}$ and $phi$ is #ponder("algebra.homomorphism-bijectivity")[injective].

  Therefore,
  $ G teq ZZ_n teq C_n. $
]

Because of this theorem, we will write $C_n$ for any #ponder("algebra.cyclic-group")[cyclic group] of #ponder("algebra.group-order")[order] $n$, and $C_oo teq ZZ$.

#definition("Order of an element of a group")[
  For any #ponder("algebra.group")[group] $G$, and element $g in G$, let

  $ lr(chevron.l g chevron.r) = { g^n: n in ZZ } <= G. $

  Note that $lr(chevron.l g chevron.r)$ is #ponder("algebra.cyclic-group")[cyclic], so $lr(chevron.l g chevron.r) teq C_n$ for some $n in ZZ^+ union {oo}$. This number $n$ is called the *#ponder("algebra.element-order")[order]* of $g$, denoted by $o(g)$.
] <element-order>

== #ponder("algebra.dihedral-group")[Dihedral Groups], Revisited

#remark[
  Whenever $x, y in G$ satisfy the #ponder("algebra.dihedral-relation")[dihedral relation]

  $
    x y = y x^(-1),
  $

  Then, for any $l > 0$, we have

  $ y x^(-l) = (y x) x^(1 - l) = x y x^(1-l) = ... = x^l y $

  by induction on $l$.

  If $y^2 = e$, we also have

  $ y x^l = y (x^l y) y = y ( y x^(-l)) y = x^(-l) y. $

  In summary, we have shown that
  $ y x^l = x^(-l) y $
  for all $l in ZZ$.
]

#lemma[
  Let $G$ be a #ponder("algebra.group")[group], that for some $a, b in G$, the following relations hold:

  1. $a^n = e$ for some $n >= 3$
  2. $b^2 = e$
  3. $a b = b a^(-1)$


  Then $phi(r^k) = a^k$ and $phi(r^k s)=a^k b$ defines a #ponder("algebra.homomorphism")[homomorphism] $phi: D_(2n) -> G$ that sends the #ponder("algebra.generated-subgroup")[generators] $r, s$ of $D_(2n)$ to $a, b$ respectively.
] <hom-lemma-2>

#proof[
  There are 4 cases to check:

  1. $phi(r^k) phi(r^l) = a_k a^l = a^(k + l) = a^(k +_n l) = phi(r^(k + l))$
  2. $phi(r^k) phi(r^l s) = a^k a^l b = a^(k + l) b = a^(k +_n l) b = phi(r^(k + l) s)$
  3. $phi(r^k s) phi(r^l) = a^k b a^l = a^k a^(-l) b = a^(k - l) b = phi(r^(k - l) s) = phi(r^k s r^l)$
  4. $phi(r^k s) phi(r^l s) = a^k b a^l b = a^k a^(-l) b^2 = a^(k - l) = phi(r^(k - l)) = phi(r^(k-l) s s) = phi(r^k s r^l s)$
]

#proposition[
  Suppose $G$ has #ponder("algebra.generated-subgroup")[generating set] $ { a, b } $ satisfying:

  1. $a^n = e$ for some $n >= 3$
  2. $b^2 = e$
  3. $a b = b a^(-1)$
  4. $abs(G) = 2n $

  Then $G teq D_(2n).$
] <prop-groups-of-dihderal-type>

#proof[
  By @hom-lemma-2, there is a #ponder("algebra.homomorphism")[homomorphism]
  $ phi: D_(2n) -> G $
  sending $r |-> a$ and $s |-> b$. Since $a$ and $b$ #ponder("algebra.generated-subgroup")[generate] $G$, $phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective]. Also, since $abs(D_(2n)) = abs(G) = 2n$, $phi$ is #ponder("algebra.bijection")[bijective]. Therefore, $phi$ is an #ponder("algebra.isomorphism")[isomorphism], and $G teq D_(2n).$
]
