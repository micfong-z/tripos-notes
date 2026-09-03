#import "../prelude.typ": *

= #ponder("algebra.group-action")[Group Actions]

#ponder("algebra.group-action")[Group actions] turn #ponder("algebra.group")[groups] into #ponder("algebra.group")[groups] of symmetries.

== Introduction

#definition("Group Action")[
  An *#ponder("algebra.group-action")[action]* of a #ponder("algebra.group")[group] $G$ on a set $X$ is a function
  $ G times X -> X $
  with
  $ (g, x) |-> g x, $
  such that

  1. $e_G x = x$ for all $x in X$,
  2. $(g_1 g_2) x = g_1 (g_2 x)$ for all $g_1, g_2 in G$ and $x in X$.
] <group-action>

#notation[
  We write $G arrow.cw.half X$ to indicate that $G$ acts on $X$.
]

#example[
  1. For any #ponder("algebra.group")[group] $G$, there is a *trivial #ponder("algebra.group-action")[action]* of $G$ on any set $X$ defined by $g x = x$ for all $g in G$ and $x in X$.

  2. $sym(X) arrow.cw.half X$ by $f x = f(x)$.

  3. If $G arrow.cw.half X$ and $H<=G$ then $H arrow.cw.half X$ by restriction.

    In particular, $isom(CC) arrow.cw.half CC$ since $sym(CC) <= isom(CC)$.

  4. Similarly, #ponder("algebra.dihedral-group")[dihedral groups] $D_(2n)$ #ponder("algebra.group-action")[acts] on $X_n$ (the regular $n$-gon). It also #ponder("algebra.group-action")[acts] on the set of vertices of the regular $n$-gons.

  5. Every #ponder("algebra.group")[group] $G$ #ponder("algebra.group-action")[acts] on itself by left multiplication: $g gamma = g dot gamma$ for all $g, gamma in G$.

    This is called the *left regular #ponder("algebra.group-action")[action]* of $G$.
]

#theorem[
  An #ponder("algebra.group-action")[action] of a #ponder("algebra.group")[group] $G$ on a set $X$ is the same as a #ponder("algebra.homomorphism")[homomorphism] $phi: G->sym(X)$.
] <action-homomorphism>

#proof[
  We will show the two directions separately.

  #separator

  Suppose $G arrow.cw.half X$. Consider $t_g: X->X$ defined by $x |-> g x$ for all $g in G$. Then
  $
    t_(g^(-1))(t_g (x)) & = t_(g^(-1))(g x) \
                        & = g^(-1)(g(x)) \
                        & = (g^(-1) dot g) (x) \
                        & = x.
  $
  So $t_(g^(-1)) dot t_g = id_X$. Similarly, $t_g dot t_(g^(-1)) = id_X$. Thus $t_g$ is invertible, so $t_g in sym(X)$. Therefore, we can define a #ponder("algebra.homomorphism")[homomorphism] $phi: G-> sym(X)$ by $g |-> t_g$.

  We shall now prove that $phi$ is a #ponder("algebra.homomorphism")[homomorphism]. For any $g, h in G$ and $x in X$, we have
  $
    t_g compose t_h (x) = t_g (h x) = g (h x) = (g dot h) x = t_(g dot h) (x).
  $
  Thus, $t_g compose t_h = t_(g dot h)$, so $phi(g dot h) = phi(g) compose phi(h)$. Hence, $phi$ is a #ponder("algebra.homomorphism")[homomorphism].

  #separator

  Conversely, given a #ponder("algebra.homomorphism")[homomorphism]
  $ phi: G-> sym(X), $
  we may define an #ponder("algebra.group-action")[action] $G arrow.cw.half X$ by
  $ g x := phi(g)(x). $
  Let us check the two properties of an #ponder("algebra.group-action")[action].

  1. For any $x in X$,
  $
    e_G x = phi(e_G)(x) = id_X (x) = x.
  $
  2. For any $g_1, g_2 in G$ and $x in X$,
  $
    (g_1 g_2) x = phi(g_1 g_2)(x) = (phi(g_1) compose phi(g_2))(x) = phi(g_1)(phi(g_2)(x)) = g_1 (g_2 x).
  $
  Thus, the two properties hold, so we have an #ponder("algebra.group-action")[action] of $G$ on $X$.
]

#theorem[#ponder("algebra.cayley-theorem")[Cayley's theorem]][
  Every #ponder("algebra.group")[group] $G$ is #ponder("algebra.isomorphism")[isomorphic] to a #ponder("algebra.subgroup")[subgroup] of some $sym(X)$.

  Furthermore, if $abs(G) < oo$, we may choose $X$ with $abs(X) < oo$.
] <cayley-theorem>

#proof[
  Let $X = G$. Consider the left regular #ponder("algebra.group-action")[action] of $G$ on itself. By the previous theorem, this corresponds to a #ponder("algebra.homomorphism")[homomorphism]
  $ phi: G-> sym(X). $
  Let $H = im phi <= sym (X)$. We may think of $phi$ as a #ponder("algebra.homomorphism-bijectivity")[surjective] #ponder("algebra.homomorphism")[homomorphism] from $G$ to $H$.

  #claim[
    $ker phi = {e}$.
  ]

  #proof[
    Indeed, if $g in ker phi => phi(g) = id_X <=> g gamma = gamma$ for all $gamma in G$.
    In particular,
    $ g e = e => g = e. $
  ]

  Hence, $phi: G->H$ is #ponder("algebra.bijection")[bijective], and thus an #ponder("algebra.isomorphism")[isomorphism]. So $G teq H <= sym(X)$ so required.

  Automatically, if $abs(G) < oo$, then $abs(X) = abs(G) < oo$.
]

A lot of important results in #ponder("algebra.group")[group] theory come from studying #ponder("algebra.group-action")[group actions].

#definition("Orbits and Stabilisers")[
  Let $G arrow.cw.half X$, and let $x in X$.

  1. The *#ponder("algebra.orbit-stabiliser-definitions")[orbit]* of $x$ is the set
  $ G x = {y in X : exists g in G, y = g x}. $

  2. The *#ponder("algebra.orbit-stabiliser-definitions")[stabiliser]* of $x$ is the set
  $ stab_G (x) = {g in G : g x = x}. $
] <orbit-stabiliser-definitions>

#notation[
  Some sources write $G_x$ for $stab_G (x)$, which we will avoid to prevent confusion with subscript notation.
]

#definition[Action transitivity and faithfulness][
  If $G x = X$, we say that the #ponder("algebra.group-action")[action] is *#ponder("algebra.action-properties")[transitive]*.

  If every element $g in G$ (except $g = e$) has $x in X$ such that $g x != x$, then $G arrow.cw.half X$ is *#ponder("algebra.action-properties")[faithful]*.
] <action-properties>

#lecture-separator(lecture: 10, date: "2025-10-31")

#remark[
  An #ponder("algebra.group-action")[action] $G arrow.cw.half X$ is #ponder("algebra.action-properties")[faithful] if and only if the corresponding #ponder("algebra.homomorphism")[homomorphism] $phi: G-> sym(X)$ is #ponder("algebra.homomorphism-bijectivity")[injective].
]

== #ponder("algebra.orbit-stabiliser")[Orbit-Stabiliser Theorem]

#proposition[
  Suppose $G arrow.cw.half X$. Then

  1. For any $x in X$, $stab_G (x) <= G$.
  2. The #ponder("algebra.orbit-stabiliser-definitions")[orbits] ${G y: y in X}$ form a #ponder("algebra.action-orbit-properties")[partition] of $X$.
] <action-orbit-properties>

#remark[
  (2) means that $G x = X$ iff there is only one #ponder("algebra.orbit-stabiliser-definitions")[orbit]. Therefore, #ponder("algebra.action-properties")[transitivity] is independent of the choice of $x$.
]

#proof[
  1. We need to check $stab_G (x)$ satisfies the definition of a #ponder("algebra.subgroup")[subgroup].

    - If $g, h in stab_G(x)$, then
      $
        (g dot h) x = g (h x) = g x = x,
      $
      so $g dot h in stab_G (x)$.

    - $e_G in stab_G (x)$ since $e_G x = x$.

    - If $g in stab_G(x)$, then
      $
        g^(-1) x = g^(-1)(g x) = (g^(-1) dot g) x = e_G x = x,
      $
      so $g^(-1) in stab_G (x)$.

    So all #ponder("algebra.subgroup")[subgroup] criteria are satisfied.

  2. Similarly to the proof of @cosets-partition,

    - $x = e x in G x$ so #ponder("algebra.orbit-stabiliser-definitions")[orbits] cover $x$.

    - If $G x_1 inter G x_2 != emptyset$, then $exists y = g_1 x_1 = g_2 x_2$ for some $g_1 in G, g_2 in G$. Hence,

      $
        x_1 & = g_1^(-1) (g_1 x_1) \
            & = g_1^(-1) (g_2 x_2) \
            & = (g_1^(-1) g_2) x_2 \
            & in G x_2
      $
      Moreover, any $g x_1$ can now be written as

      $
        g x_1 = g(g_1^(-1) g_2) x_2 in G x_2.
      $

      Hence $G x_1 subset.eq G x_2$. By symmetry, we have the reverse inclusion. Thus, the equality holds.
]

#example[
  Consider $D_(2n) arrow.cw.half X_n$, where $X_n$ is the set of the regular $n$-gon.

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d2e5.svg", width: 15em)
  ]

  For any $j$,

  $ r^j s(x) = r^j (x) = ee^((2 ppi i j) / n). $

  Therefore, $D_(2n) x = {ee^((2 ppi i j) / n) : 0 <= j < n} = {"nth roots of unity"}.$

  The above calculation also shows that $g x = x => g = {e, s}$. Hence, $stab_(D_(2n)) (x) = {e, s}.$
]

#theorem[#ponder("algebra.orbit-stabiliser")[Orbit-stabiliser theorem]][
  Suppose $G$ acts on a set $X$. Then for any $x in X$, the formula
  $ g stab_G (x) attach(|->, t: Phi) g x $
  defines a well-defined bijection
  $ G \/ stab_G (x) -> G x. $
] <orbit-stabiliser>

#corollary[
  If $G arrow.cw.half X$ and $x in X$, then
  $ abs(G) = (abs(G x) (abs(stab_G (x))) $
]

#proof[
  @orbit-stabiliser gives

  $ abs(G x) = abs(G \/ stab_G (x)) = abs(G) / abs(stab_G (x)). quad "by Lagrange's theorem" $
]

#example[
  Consider again $D_(2n) arrow.cw.half X_n$ as in the previous example. We saw that, if $x in X_n$ is a vertex, then
  $ abs(D_(2n) x) = n quad "and" abs(stab_(D_(2n)) (x)) = 2. $
  This gives us an easy (but circular for now) proof that
  $ abs(D_(2n)) = 2 n. $
]

#proof[
  #fade[[For @orbit-stabiliser]]

  For notational convenience, let $S = stab_G (x)$, and define
  $ Phi(g S) = g x. $
  We have to check several things about $Phi$.

  - *$Phi$ well-defined.* That is, for any $g_1, g_2 in G$  such that $g_1 S = g_2 S$, we have $Phi(g_1 S) = Phi(g_2 S)$, _i.e._ $g_1 x = g_2 x$.

    Now, $g_1 S = g_2 S$ means that there is $s in S$ such that $g_1 = g_2 s$. Then,
    $
      g_1 x & = (g_2 s) x \
            & = g_2 (s x) \
            & = g_2 x quad "since" s x=x. \
    $
    Thus, $Phi$ is well-defined.

  - *$Phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective].* For any $g x in G x$, we have
    $ Phi(g S) = g x. $
    Thus, $Phi$ is surjective.

  - *$Phi$ is #ponder("algebra.homomorphism-bijectivity")[injective].* Suppose $Phi(g_1 S) = Phi(g_2 S)$ for some $g_1, g_2 in G$. By definition, this means that
    $ g_1 x = g_2 x. $
    We need to show that $g_1 S = g_2 S$. Let $s = g_2^(-1) g_1$. Now,
    $
      s x & = (g_2^(-1) g_1) x \
          & = g_2^(-1) (g_1 x) \
          & = g_2^(-1) (g_2 x) \
          & = (g_2^(-1) g_2) x \
          & = e_G x = x.
    $
    Thus, $s in S$, so
    $ g_1 = g_2 g_2^(-1) g_1 = g_2 (g_2^(-1) g_1) = g_2 s in g_2 S. $
    Since #ponder("algebra.coset")[cosets] #ponder("algebra.coset-partition")[paritition], it follows that $g_1 S = g_2 S$. Hence, $Phi$ is #ponder("algebra.homomorphism-bijectivity")[injective].
]

#example("Symmetries of a cube")[
  Let $G$ be the #ponder("algebra.group")[group] of #ponder("geometry.isometry")[isometries] of a cube, and let $x$ be the centre of a face. Then, $ abs(G x) = 6 $ since it is just the number of faces of the cube.

  Now, the face is essentially a square, so $stab_G (x) teq D_8$ since the #ponder("algebra.orbit-stabiliser-definitions")[stabiliser] must permute the four edges of the face. Thus,
  $ abs(stab_G (x)) = 8. $

  Therefore, by the #ponder("algebra.orbit-stabiliser")[orbit-stabiliser theorem],
  $ abs(G) = abs(G x) times abs(stab_G (x)) = 6 times 8 = 48. $
]

#lecture-separator(lecture: 11, date: "2025-11-03")

The next theorem is a different kind of application of the #ponder("algebra.orbit-stabiliser")[orbit-stabiliser theorem].

#theorem[#ponder("algebra.cauchy-theorem")[Cauchy's Theorem]][
  If $abs(G) < oo$ and $p$ is a prime that divides $abs(G)$, then there is $g in G$ such that $o(g)=p$.
] <cauchys-theorem>

#proof[
  Consider the set $X$ of $p$-tuples (distinct entries not required)
  $ {(g_1, ..., g_p) : g_i in G "for all" i "and" g_1 dot g_2 dot ... dot g_p = e}. $

  Define an #ponder("algebra.group-action")[action] of $C_p$ on $X$ as follows.

  If $C_p = {1, t, t^2, ..., t^(p-1)}$, let $t^k (g_1, ..., g_p) = (g_(k+1), ..., g_p, g_1, ..., g_k)$, which is just a cyclic rotation of the $p$-tuple. We need check that this is a well-defined #ponder("algebra.group-action")[action].

  It is easy to see that $t^k t^l (g_1, ..., g_p) = t^(k+l)(g_1, ..., g_p).$

  We also need to check that
  $
    (g_(k+1), ..., g_p, g_1, ..., g_k) in X.
  $
  Suppose, therefore, that $ (g_1, ..., g_p) in X. $ For convenience, let $a = g_1 dot ... dot g_k$ and $b = g_(k+1) dot ... dot g_p$. Then, we know that $a dot b = e$. So, $b = a^(-1)$ and therefore $b dot a = e$. Hence,
  $
    g_(k+1) dot ... dot g_p dot g_1 dot ... dot g_k = b dot a = e.
  $
  Thus, the #ponder("algebra.group-action")[action] is well-defined.


  #separator

  Now compute $abs(X)$. For any choices of $g_1, ..., g_(p-1)$, there is a unique choice of $g_p$ such that
  $ g_1 dot g_2 dot ... dot g_p = e $
  as #ponder("algebra.inverse-element")[inverses] are unique.
  Thus, there are $abs(G)^(p-1)$ choices for $(g_1, ..., g_p)$, so
  $ abs(X) = abs(G)^(p-1). $
  The $C_p$ #ponder("algebra.group-action")[action] on $X$ partitions $X$ into #ponder("algebra.orbit-stabiliser-definitions")[orbits]. So let
  $ X = C_p x_1 union C_p x_2 union ... union C_p x_k. $
  By #ponder("algebra.orbit-stabiliser")[orbit-stabiliser], for each $j$,
  $ abs(C_p x_j) divides abs(C_p) = p, $
  so either $abs(C_p x_j) = 1$ or $abs(C_p x_j) = p$.
  Let $l$ be the number of #ponder("algebra.orbit-stabiliser-definitions")[orbits] with size $1$. After renumbering, we may assume that
  $
    abs(C_p x_j) = 1 quad & "if" (1 <= j <= l) \
    abs(C_p x_j) = p quad & "if" (l+1 <= j <= k).
  $
  Since the #ponder("algebra.orbit-stabiliser-definitions")[orbits] partition $X$, we have
  $
    abs(G)^(p-1) & = abs(X) \
                 & = sum_(j=1)^k abs(C_p x_j) \
                 & = sum_(j=1)^l 1 + sum_(j=l+1)^k p \
                 & = l + p (k - l). \
  $
  Since, by our assumption, $p$ divides $abs(G)^(p-1)$, it follows that $p$ divides $l$.

  Now, note that $x = (g_1, ..., g_p)$ has an #ponder("algebra.orbit-stabiliser-definitions")[orbit] of size $1$ if and only if $g_1 = g_2 = ... = g_p$. In particular, $(e, e, ..., e) in X$ has an #ponder("algebra.orbit-stabiliser-definitions")[orbit] of size $1$. Thus, $l >= 1$. Since $p$ divides $l$ and $l >= 1$, we must have
  $ l >= p > 1, $
  so there is at least one more #ponder("algebra.orbit-stabiliser-definitions")[orbit] $(g, g, ..., g) in X$ with $g != e$.

  The definition of $X$ implies that $g^p = e$, so $o(g) divides p$, whence $o(g)=p$ as required.
]

== #ponder("algebra.conjugation")[Conjugation]

#definition[Conjugation][
  Let $G$ be a #ponder("algebra.group")[group] and $g in G$. For any $h in G$, the element $h dot g dot h^(-1) in G$ is called the *#ponder("algebra.conjugation")[conjugate]* of $g$ by $h$.
] <conjugation>

#remarklike("Intuition")[
  One way to think about #ponder("algebra.conjugation")[conjugation] is that $h g h^(-1)$ has _the same shape_ as $g$.

  Another way is to think about it is that $h g h^(-1)$ corresponds to _changing the coordinates_ of $g$.
]

#example[
  If $G$ is an #ponder("algebra.abelian-group")[abelian group], then $h g h^(-1) = g$ for all $g, h in G$. So the only #ponder("algebra.conjugation")[conjugate] of any element is itself.
]

#definition[Conjugacy class][
  The *#ponder("algebra.conjugacy-class")[conjugacy class]* of an element $g in G$ is the set
  $ ccl(g) = {h g h^(-1) : h in G}. $
] <def-conjugacy-class>

#exercise[
  $G$ acts on itself by #ponder("algebra.conjugation")[conjugation]:
  $ g * gamma = g gamma g^(-1) $
  defines $G arrow.cw.half G$. This is very different from the left regular #ponder("algebra.group-action")[action].
  Then $ccl(g)$ is just the #ponder("algebra.orbit-stabiliser-definitions")[orbit] of $g$ under this #ponder("algebra.group-action")[action].
]

#example[
  In Example Sheet 2 Q6, it is proven that $D_(2n)$ has 1 #ponder("algebra.conjugacy-class")[conjugacy class] of reflections if $n$ is odd, and 2 #ponder("algebra.conjugacy-class")[conjugacy classes] if $n$ is even.

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d6e1.svg", width: 28em)
  ]

  Note that the red reflections cannot be obtained by #ponder("algebra.conjugation")[conjugating] the blue reflections, and vice versa.
]

#definition[Centraliser][
  The *#ponder("algebra.centraliser")[centraliser]* of $g$ is defined to be
  $ C_G (g) = {h in G : h g h^(-1) = g}, $
  which is just the #ponder("algebra.orbit-stabiliser-definitions")[stabiliser] of $g$ under the #ponder("algebra.conjugation")[conjugation] #ponder("algebra.group-action")[action].
] <def-centraliser>

#remark[
  Note that
  $ h g h^(-1) = g <=> h g = g h $  so the #ponder("algebra.centraliser")[centraliser] $C_G (g)$ is the set of elements that commutes with $g$.
]

#definition[Centre][
  The *#ponder("algebra.centre")[centre]* of $G$ is defined to be
  $ Z(G) = {g in G : h g h^(-1) = g space forall h in G} = inter.big_(g in G) C_G (g). $

  This is exactly the set of elements that commutes with every element of $G$.
] <centre>
