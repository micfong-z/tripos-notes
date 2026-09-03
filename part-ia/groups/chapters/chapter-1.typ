#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2025-10-10")

= Introduction on #ponder("algebra.group")[Groups]

One can think about #ponder("algebra.group")[groups] in two ways:

- on the one hand, they are related to algebra,

- on the other hand, they are related to symmetry.

== Motivation <chap-1-1>

An equilateral triangle has rotational symmetry, reflective symmetry, and the identity symmetry.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d1e3.svg", width: 16em)
]


Let us list these symmetries:

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d1e4.svg", width: 10em)
]

So an equilateral triangle has exactly 6 symmetries.

#exercise[
  How many symmetries does a square have? What about a regular pentagon? A regular _n_-gon?
]

Things get more interesting when we start to #ponder("algebra.function-composition")[compose] (or multiply) symmetries. Note that, after #ponder("algebra.function-composition")[composition] of symmetries, our result must also be a symmetry. To find out exactly which one is the end result, we can label the vertices on the triangle.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d1e5.svg", width: 28em)
]


Here are some important features of symmetries:
- symmtries can be *#ponder("algebra.function-composition")[composed]*,
- there is an *#ponder("algebra.group")[identity]*,
- every symmetry has an *#ponder("algebra.inverse-element")[inverse]*,
- #ponder("algebra.function-composition")[comoposition] of symmetries is *#ponder("algebra.function-composition")[associative]*,

#important[
  The symmetries may not necessarily #ponder("algebra.abelian-group")[commute].
]

We can extend this method to algebra to handle more complex cases, _e.g._ for a 17-gon.

== Introduction on #ponder("algebra.group")[Groups]

#definition("Binary operation")[
  A *#ponder("algebra.binary-operation")[binary operation]* on a set $X$ is a function $dot: X times X -> X$.
] <binary-operation>

#definition("Group")[
  A #ponder("algebra.group")[group] is a triple $(G, dot, e)$ where
  - $G$ is a set
  - $dot$ is a #ponder("algebra.binary-operation")[binary operation] on $G$,
  - $e in G$

  that satisfies the following four axioms:

  1. *#ponder("algebra.group")[Closure].* For all $a, b in G$, $a dot b in G$. #fade[[This can be deduced by definition of binary operations.]]

  2. *#ponder("algebra.group")[Associativity].* For all $a, b, c in G$, $(a dot b) dot c = a dot (b dot c)$.

  3. *#ponder("algebra.group")[Identity].* For all $a in G$, $a dot e = a$.

  4. *(Right) #ponder("algebra.inverse-element")[Inverse].* For all $a in G$, there exists $b in G$ such that $a dot b = e$.
] <def-group>

#example[
We noticed earlier that the symmetries of an equilateral triangle form a #ponder("algebra.group")[group].
]

We can also think about the definitions as encompassing algebra with one #ponder("algebra.binary-operation")[operation], as shown in the following example.

#exercise[
  Show that $(ZZ, +, 0)$ forms a #ponder("algebra.group")[group].
]

The definition has some important consequences.

#proposition[
  Let $(G, dot, e)$ be a #ponder("algebra.group")[group], and $a, b, b', e' in G$.

  1. If $a dot b = e$, then $b dot a = e$. #fade[[right #ponder("algebra.inverse-element")[inverses] are left #ponder("algebra.inverse-element")[inverses].]]
  2. $e dot a= a$ #fade[[left #ponder("algebra.group")[identities] are right #ponder("algebra.group")[identities].]]
  3. If $a dot b = e = a dot b'$, then $b = b'$.  #fade[[#ponder("algebra.inverse-element")[inverses] are unique.]]
  4. If $a dot e' = a = a dot e$, then $e' = e$. #fade[[the #ponder("algebra.group")[identity] is unique.]]
] <prop-group1>

#proof[

  1. Using @def-group, we have

    $
      b & = b dot e         &      quad "by identity" \
        & = b dot (a dot b) &    quad "by assumption" \
        & = (b dot a) dot b & quad "by associativity"
    $

    By the #ponder("algebra.inverse-element")[inverse] axiom, there is a $c in G$  such that $b dot c = e$. Multiplying both sides on the right by $c$, we get
    $
      b dot c & = ((b dot a) dot b) dot c \
              & = (b dot a) dot (b dot c) & quad "by associativity" \
              & = (b dot a) dot e         &  quad "by construction" \
              & = b dot a.                &      quad "by identity" \
    $

  2. Using @def-group, and the previous part, there exists $b in G$ such that $a dot b = e = b dot a$.

    Now

    $
      e dot a & = (a dot b) dot a \
              & = a dot (b dot a) & quad "by associativity" \
              & = a dot e         &  quad "by construction" \
              & = a.              &      quad "by identity" \
    $

  3. We have

    $
      b' & = e dot b'         &      quad "by part (2)" \
         & = (b dot a) dot b' &      quad "by part (1)" \
         & = b dot (a dot b') & quad "by associativity" \
         & = b dot e          &    quad "by assumption" \
         & = b.               &      quad "by identity" \
    $

  4. Using the #ponder("algebra.inverse-element")[inverse] axiom from @def-group, and part (1), there is a $b in G$ such that $b dot a = e$.

    Multiplying by $b$ on both sides of $a dot e' = a$ gives

    $
      b dot a & = b dot (a dot e') \
              & = (b dot a) dot e' & quad "by associativity" \
              & = e dot e'         &  quad "by construction" \
              & = e'.              &      quad "by part (2)" \
    $

    Since $b dot a = e$, we have $e = e'$.

]

#notation[
  By @prop-group1, #ponder("algebra.inverse-element")[inverses] are unique. Therefore, if $a dot b = e$, we may write
  $ b = a^(-1). $
]

#lecture-separator(lecture: 2, date: "2025-10-13")

Part (1) of @prop-group1 tells us that

$ a dot a^(-1) = e = a^(-1) dot a, $

which tells us the following.

#corollary[
  For $a$ in a #ponder("algebra.group")[group] $(G, dot, e)$, we have
  $ (a^(-1))^(-1)=a. $
] <inverse-inverse>

#notation[
  It makes sense to extend this notation. For any $a in G$,

  - $a^0 = e$
  - $a^n = a^(n-1) dot a$ for any $n in ZZ^+$
  - $a^(-n) = (a^(-1))^n$ for any $n in ZZ^+$
]

#exercise[
  Show that, if $G$ is a #ponder("algebra.group")[group], then for $a in G$ and $m, n in ZZ$,
  $ a^m dot a^n = a^(m+1) quad "and" quad (a^n)^m = a^(n m). $
]

Recall that it is *not* necessarily true that $a dot b = b dot a$ in a #ponder("algebra.group")[group] $G$. Hence, it is also *not* necessarily true that $(a dot b)^(-1) = a^(-1) dot b^(-1).$

#proposition[
  Let $(G, dot, e)$ be a #ponder("algebra.group")[group] and $a, b in G$. Then
  $
    (a dot b)^(-1) = b^(-1) dot a^(-1).
  $
] <inverse-of-product>

#proof[
  We have
  $
    (a dot b)^(-1) dot (b^(-1) dot a^(-1)) & = (a dot (b dot b^(-1))) dot a^(-1) \
                                           & = (a dot e) dot a^(-1) \
                                           & = a dot a^(-1) \
                                           & = e. \
  $

  Since #ponder("algebra.inverse-element")[inverses] are unique, the result follows.
]

#definition("Abelian group")[
  If $(G, dot , e)$ is a #ponder("algebra.group")[group] and $a dot b = b dot a$ for all $a, b in G$, then the #ponder("algebra.group")[group] is called *#ponder("algebra.abelian-group")[abelian]*.
] <abelian-group>

#definition("Trivial group")[
  If $G={e}$ and $e dot e = e$, then $(G, dot, e)$ is called the *#ponder("algebra.trivial-group")[trivial group]*.
] <trivial-group>

== Familar Examples from Arithmetic

#example[
  1. $(ZZ, +, 0), (QQ, +, 0), (RR, +, 0), (CC, +, 0)$ are all #ponder("algebra.abelian-group")[abelian groups]. The #ponder("algebra.inverse-element")[inverse] of $x$ is $-x$ in each case.

  2. $(NN, +, 0)$ is not a #ponder("algebra.group")[group] due to a lack of #ponder("algebra.inverse-element")[inverses].

  3. $(QQ^*, times, 1)$ is an #ponder("algebra.abelian-group")[abelian group]. Note that $(QQ, times , 1)$ is not a #ponder("algebra.group")[group] since $0$ has no #ponder("algebra.inverse-element")[inverse].

    Similarly, $(RR^*, times , 1)$ and $(CC^*, times, 1)$ are #ponder("algebra.abelian-group")[abelian groups].
]

== #ponder("algebra.group-order")[Finite Groups]

Most of the #ponder("algebra.group")[groups] above are #ponder("algebra.group-order")[infinite].

#definition("Order of a group")[
  The *order* of a #ponder("algebra.group")[group] $(G, dot , e)$ is the number of elements of $G$, denoted by $abs(G)$.

  If $abs(G) < oo$, then $(G, dot, e)$ is *#ponder("algebra.group-order")[finite]*.
] <group-order>

#example[
  1. For a specific $n in NN$, let

    $ C_n = { z in CC: z^n = 1 } $
    then $(C_n, times , 1)$ is an #ponder("algebra.abelian-group")[abelian group].

  2. Let $ZZ_n = {0, 1, ..., n-1}$. For $a, b in ZZ$, let $a+_n b = (a + b) mod n$. Then $(ZZ_n, +_n, 0)$ is an #ponder("algebra.abelian-group")[abelian group].
]

#lecture-separator(lecture: 3, date: "2025-10-15")

== #ponder("algebra.symmetric-group")[Symmetric Groups]

We need to introduce some definitions before we introduce the notion of a #ponder("algebra.symmetric-group")[symmetric group].

#definition("Bijection")[
  Let $X, Y$ be sets. A *#ponder("algebra.bijection")[bijection]* is a map $f:X->Y$ that has an #ponder("algebra.inverse-element")[inverse] $g:Y->X$ such that
  $ f compose g = "id"_X quad "and" quad g compose f = "id"_Y. $
  _i.e._ $g compose f (x) = x$ for all $x in X$, and $f compose g (y) = y$ for all $y in Y$.
] <bijection>

#definition("Permuation")[
  A #ponder("algebra.bijection")[bijection] $X->X$ is called a *#ponder("algebra.permutation")[permutation]*.
] <def-permutation>

#definition("Symmetric group")[
  $sym(X)$ is defined to be the set of #ponder("algebra.permutation")[permutations] of a set $X$.

  We will prove that this is a #ponder("algebra.group")[group] in @sym-group-is-group.
] <def-symmetric-group>

Recall that $g compose f(x) = g(f(x))$.

#lemma("Composition is associative")[
  Consider the following maps of sets:

  $ W attach(arrow, t: f) X attach(arrow, t: g) Y attach(arrow, t: h) Z. $

  Then $(h compose g)compose f = h compose (g compose f)$.
] <composition-associative>

#proof[
  For any $w in W$,
  $
    ((h compose g) compose f)(w) & = (h compose g)(f(w)) \
                                 & = h(g(f(w))) \
                                 & = h(g compose f(w)) \
                                 & = (h compose (g compose f))(w). \
  $
]

This makes it easy to see that $sym(X)$ is a #ponder("algebra.group")[group].

#proposition[
  For any set $X$, $(sym(X), compose, "id"_x)$ is a #ponder("algebra.group")[group].
] <sym-group-is-group>

#proof[

  - #ponder("algebra.group")[Closure] is automatic, since the composition of two #ponder("algebra.permutation")[permutations] is still a #ponder("algebra.permutation")[permutaion].
  - #ponder("algebra.function-composition")[Associativity] follows from @composition-associative.
  - The #ponder("algebra.group")[identity map] is the #ponder("algebra.group")[identity element].
  - #ponder("algebra.inverse-element")[Inverses] exist by definition of a #ponder("algebra.bijection")[bijection].

  Therefore the result follows.
]

#definition()[
  If $X = {1, ..., n}$, then we write $S_n = sym(X)$
]

#example[
  1. $S_3$ is the #ponder("algebra.group")[group] of ways to rearrange three flower pots on a windowsill.

  2. $S_(52)$ is the #ponder("algebra.group")[group] of ways to shuffle a deck of cards.
]

#proposition[
  The order of $S_n$ is $n!$.
] <symmetric-group-order>

#notation[
  Writing $(G, dot, e)$ is cumbersome. Henceforth, we will just write $G$.

  If we want to emphasize that $e$ is the #ponder("algebra.group")[identity element] of $G$, we will write $e_(G)$ for $e$. Likewise, we can also write $dot_G$ for the #ponder("algebra.binary-operation")[operation] on $G$.
]

== #ponder("algebra.subgroup")[Subgroups]

Sometimes, we want to restrict our attention to smaller #ponder("algebra.group")[groups]. For instance, $ZZ$ inside $RR$, the rotations of a triangle instead of all symmetries.

#definition("Subgroup")[
  Let $G$ be a #ponder("algebra.group")[group] and $H subset.eq G$. If we have

  1. $e in H$,
  2. $a dot b in H$ for all $a, b in H$,
  3. $a^(-1) in H$ for all $a in H$.

  Then we say that $H$ is a *#ponder("algebra.subgroup")[subgroup]* of $G$. We write $H <= G$.
] <def-subgroup>

#remark[
  If $G$ is a #ponder("algebra.group")[group], and $H <= G$, then $H$ is also a #ponder("algebra.group")[group].
]

#example("Example of subgroups")[
  1. Every #ponder("algebra.group")[group] $G$ is a #ponder("algebra.subgroup")[subgroup] of itself.

  2. For any #ponder("algebra.group")[group] $G$, $1_G = {e_G}$ is the #ponder("algebra.subgroup")[trivial subgroup] of $G$.

  3. $ZZ <= QQ <= RR <= CC$.

  4. For $n = 0, 1, 2, 3, ...$, let $n ZZ eq.def {n k : k in ZZ} = {..., -2n, -n, 0, n, 2n, ...}$.

    Now we have

    - $0 in n ZZ$
    - Let $x = n k, y = n l in n ZZ$. Then $x + y = n(k + l) in n ZZ$
    - Let $x = n k in n ZZ$. Then $-x = -n k = n (-k) in n ZZ$

    Therefore, $n ZZ <= ZZ$. In fact, these are all of the #ponder("algebra.subgroup")[subgroups] $ZZ$.
]

#definition("Proper subgroup")[
  Let $G$ be a #ponder("algebra.group")[group]. Then $H$ is a *#ponder("algebra.proper-subgroup")[proper subgroup]* of $G$ if $H <= G$, $H != G$ and $H!= 1_G$.
] <proper-subgroup>

#proposition()[
  If $H <= ZZ$, then $H = n ZZ$ for some $n = ZZ_(>=0)$.
] <subgroups-of-integers>

#proof[
  For the trivial case $H={0}$, we can construct it by $H = 0ZZ$.

  Otherwise, if $H != {0}$, we may choose $n in H \\ {0}$ to be the smallest positive $n in H$. #fade[[Note that, if $x in H$ and $x <0$, then $-x in H$ and $-x > 0$. Therefore, unless $H={0}$, $H$ contains a positive element.]]

  By induction, we see that $n k in H$ for all $k = ZZ^+$. By the #ponder("algebra.group")[closure] of #ponder("algebra.inverse-element")[inverses], we conclude that $n k in H$ for all $k in ZZ$. Hence $n ZZ <= H$.

  It remains to prove that $n ZZ = H$. We shall prove this by contradiction. Suppose that $n ZZ != H$, so there exists some $x in H$ such that $x in.not n ZZ$. Dividing by $n$ and taking remainders, we get
  $ x = n q + r $
  for some $q in ZZ$ and $0 < r < n$.

  But now $r = x - n q$, so $r in H$. However, we have $0 < r < n$ which contradicts with our construction of $n$. $smash$
]

#lecture-separator(lecture: 4, date: "2025-10-17")

#proposition[
  If $H, K <= G$, then
  $ H inter K <= G. $

  Similarly, for any family of #ponder("algebra.subgroup")[subgroups]
  $H_i <= G$ , we have
  $ inter.big_i H_i = {a in G : forall i, a in H_i} <= G. $
] <subgroup-intersection>

#definition("Generated subgroup and generated set")[
  Let $G$ be a #ponder("algebra.group")[group], and $X$ be a subset of $G$. Then
  $ lr(chevron.l X chevron.r) = inter.big_(X subset.eq H <= G) H $
  which is the #ponder("algebra.subgroup-intersection")[intersection] of all the #ponder("algebra.subgroup")[subgroups] of $G$ that contain $X$, and is called the *#ponder("algebra.generated-subgroup")[subgroup generated by]* $X$.

  If $G = lr(chevron.l X chevron.r)$, we say $X$ *#ponder("algebra.generated-subgroup")[generates]* $G$, or $X$ is a *#ponder("algebra.generated-subgroup")[generating set]* for $G$.
] <generated-subgroup>

Intuitively, $lr(chevron.l X chevron.r)$ is the _smallest_ #ponder("algebra.subgroup")[subgroup] containing $X$. If $X$ #ponder("algebra.generated-subgroup")[generates] $G$, it means that every $g in G$ can be written as
$ g = x_1^(plus.minus 1) x_2^(plus.minus 1) x_3^(plus.minus 1) ... x_n^(plus.minus 1) $
for some $n >= 0$, where all $x_i in X$. #fade[[Note that $x_(i)$ and $x_(j)$ can be repetitive elements from $X$.]]

== Geometric Examples of #ponder("algebra.subgroup")[Subgroups]

Let $CC$ be the plane, equipped with the usual notion of distance.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d2e2.svg", width: 30em)
]

#definition("Isometry")[
  For any $X subset.eq CC$ an *#ponder("geometry.isometry")[isometry]* of $X$ is a #ponder("algebra.bijection")[bijection]
  $ f: X->X $
  that preserves distance:

  $ abs(f(x)-f(y)) = abs(x- y). $
] <isometry>

#proposition([Isometry groups in $CC$])[
  Let $X subset.eq CC$. The set of #ponder("geometry.isometry")[isometries] of $X$, $isom(X)$, is a #ponder("algebra.subgroup")[subgroup] of $sym(X)$. In particular, $isom(X)$ is a #ponder("algebra.group")[group].
] <isometry-group>

#proof[
  Let us check @def-subgroup.  Let $f, g in isom(X)$ and $x, y in X$.

  - Clearly, $id_X in isom(X)$.

  - Since $f$ and $g$ are #ponder("geometry.isometry")[isometries],

    $abs(f(g(x))-f(g(y))) & =abs(g(x)-g(y)) \
    & = |x-y|.$

    So $f compose g in isom(X)$.

  - Let $x' = f^(-1)(x), y' = f^(-1)(y)$. Then

    $ abs(x'y') = abs(f(x')-f(y')) $

    because $f$ is an #ponder("geometry.isometry")[isometry]. So

    $ abs(f^(-1)(x)f^(-1)(y)) = abs(f(f^(-1)(x))-f(f^(-1)(y))) = |x-y| $

    and $f^(-1) in isom(X)$ as required.
]

#definition("Dihedral groups")[
  Let $X_n in CC$ be the $n$-gon with vertices ${ee^((2 ppi i k)/(n)):k = 0, ..., n-1}$ for $n >= 3$.


  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d2e3.svg", width: 16em)
  ]

  Define the *$n$th #ponder("algebra.dihedral-group")[dihedral group]* to be

  $ D_(2n) = isom(X_n). $
] <dihedral-group>

#example[
  $D_6$ is the symmetry #ponder("algebra.group")[group] of an equilateral triangle, as seen in @chap-1-1.
]

We can fast-forward to take a look at @order-of-dihedral-group:

#align(center)[
  _For a #ponder("algebra.dihedral-group")[dihedral group], we have $abs(D_(2n))=2n$ for $n>=3$._
]

The proof will also give us a good desciption of all the elements. But first, we need some geometric lemmas.

#lemma("Kite lemma")[
  Let $x_1, x_2, y_1, y_2 in CC$. If
  $ abs(y_1-x_1)=abs(y_2-x_1) quad "and" quad abs(y_1-x_2)=abs(y_2-x_2), $
  then $(x_2-x_1)$ is perpendicular to $(y_2-y_1)$.

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d2e4.svg", width: 22em)
  ]
] <kite-lemma>

#proof[
  By symmetry,

  $ angle x_1 z y_1 = angle x_1 z y_2. $

  But $y_1 y_2$ is a straight line, so $y_1 y 2 perp x_1 x_2$.
]

#lecture-separator(lecture: 5, date: "2025-10-20")

#lemma("3 point lemma")[
  Let $X subset.eq CC$ and $f in isom(X)$. If there are non-collinear points $x_1, x_2, x_3 in X$ such that $f(x_(i))=x_(i)$ for $i = 1, 2, 3$, then $f=id_x$.
] <3-point-lemma>

#proof[
  The proof is by contradiction. Suppose that $f(y) != y$ for some $y in X$. Then
  $
    abs(f(y)-x_(i)) & = abs(f(y)-f(x_(i))) quad &      "by hypothesis" \
                    & = abs(y-x_(i)) quad       & "since" f in isom(X) \
  $
  for $i = 1, 2, 3$.


  Now apply @kite-lemma, with $y_1 = y$, $y_2 = f(y)$, then we get
  $ x_2 - x_1 perp y_2-y_1 = f(y)-y. $
  Similarly,
  $ x_3 - x_1 perp f(y)-y. $

  Hence, $x_1, x_2, x_3$ are collinear, contradicting the hypothesis.
]

#remark[
  There is equally an $n+1$-point lemma valid in $RR^n$.
]

Now, to prove the theorem we stated above, we define two elements of $D_(2n)$:

$
  r(z) & = e^(2ppi ii)/(n) z quad &   "(a rotation)" \
  s(z) & = overline(z) quad       & "(a reflection)" \
$


#theorem[
  For a #ponder("algebra.dihedral-group")[dihedral group], we have $abs(D_(2n))=2n$ for $n>=3$, and we have
  $ D_(2n) = {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}. $

  In particular, ${r, s}$ #ponder("algebra.generated-subgroup")[generates] $D_(2n)$.

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d2e5.svg", width: 18em)
  ]
] <order-of-dihedral-group>

#proof[
  This will be a long proof.

  #prooflike("Outline")[
    1. We show that $r, s in D_(2n)$.
    2. We show that $D_(2n) = {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}$ by showing
      - that ${e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s} subset.eq D_(2n)$, and
      - that $D_(2n) subset.eq {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}$.
    3. We show that there are no duplicate elements in ${e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}$.
  ]

  #boxed-header[Step 1: $r, s in D_(2n)$]

  Let the polygon be $X_n$. First, we show that $r, s in D_(2n)$.

  - *For $r$:*

    Indeed, For any $x, y in CC$, then
    $
      abs(r(x)-r(y)) & = abs(ee^((2ppi ii)/(n)) x - ee^((2ppi ii)/(n)) y) \
                     & = abs(ee^((2ppi ii)/(n)))abs(x-y) \
                     & = abs(x-y). \
    $
    so $r$ is indeed an #ponder("geometry.isometry")[isometry]. Also,

    $ r ee^((2 ppi ii k)/(n)) & = ee^((2 ppi ii (k+1))/(n)) \ $

    so $r$ sends vertices of $X_n$ to vertices, and hence preserves $X_n$.

  - *For $s$*:

    Similarly for any $x, y in CC$,  we have

    $
      abs(s(x)-s(y)) & = abs(overline(x)-overline(y)) \
                     & = abs(overline(x-y)) \
                     & = abs(x-y). \
    $

    so $s$ is indeed an #ponder("geometry.isometry")[isometry]. Also,

    $ s ee^((2 ppi ii k)/(n)) & = ee^(-(2 ppi ii k)/(n)) \ $

    so $s$ sends vertices of $X_n$ to vertices, and hence preserves $X_n$.

  #boxed-header[Step 2: $D_(2n) = {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}$]

  We have shown that ${r, s} in D_(2n)$. Therefore, by induction,
  $ {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s} subset.eq D_(2n). $

  To see that this is all the elements, let $f in D_(2n)$. We aim to prove that $f in {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}$. We shall apply @3-point-lemma to complete this proof.

  Consider $x = 1$, $y = ee^((2ppi ii)/(n))$ and $z = ee^(-(2ppi ii)/(n))$.

  - *For $x$*:

    Since $f in D_(2n)$, $f(x)$ is a vertex of $X_(n)$. So
    $ f(x) = ee^((2ppi ii k)/(n)) $
    for some $k in {0, 1, ..., n-1}$. We will try to _undo_ $f$ using $r$ and $s$.

    Therefore,

    $ r^(-k) compose f(x) = 1 = x. $


  - *For $y$ and $z$*:

    Now, $r^(-k) compose f subset.eq D_(2n)$, so

    $
      abs(r^(-k) compose f(y) - x) & = abs(r^(-k) compose f(y) - r^(-k) compose f(x)) \
                                   & = abs(y-x) \
    $

    and hence $r^(-k) compose f(y) = y "or" z$.

    For the same reasons, $r^(-k) compose f(z) = y "or" z$. Therefore, there are two cases:

    1. $r^(-k) compose f(y) = y$ and $r^(-k) compose f(z) = z$,
    2. $r^(-k) compose f(y) = z$ and $r^(-k) compose f(z) = y$.

    - *Case 1.* $r^(-k) compose f$ forms $x, y, z$.

      Since $x, y, z$ are not collinear,
      $ r^(-k) compose f = id_X $
      by @3-point-lemma. Hence, $f=r^k$.


    - *Case 2.* We have

      $
        r^(-k) compose f(x) & = x & = s(x), \
        r^(-k) compose f(y) & = z & = s(y), \
        r^(-k) compose f(z) & = y & = s(z). \
      $

      Therefore,
      $
        s^(-1) compose r^(-k) compose f (x) & = s^(-1) compose s(x) & = x, \
        s^(-1) compose r^(-k) compose f (y) & = s^(-1) compose s(y) & = y, \
        s^(-1) compose r^(-k) compose f (z) & = s^(-1) compose s(z) & = z. \
      $

      Simiarly to *Case 1*, by the @3-point-lemma, we get
      $ s^(-1) compose r^(-k) compose f = id_X. $
      Hence, $f=r^k s$ as required.

  This proves that
  $ D_(2n) = {e, r, ..., r^(n-1), s, r s, ..., r^(n-1)s}. $

  #boxed-header[Step 3: Duplicate check]


  Now, we need to check that this list does not contain duplicate elements, so that $abs(D_(2n))=2n.$


  First, if $0 <= k, l <= n$ such that

  $ r^k = r^l, $

  then

  $ ee^((2ppi ii k)/(n)) = r^k (1) = r^l (1) = ee^((2 ppi i l)/(n)), $

  so $k = l$.

  Now, if $r^k = s$ then

  $ ee^(2ppi i k / n) = r^k(1) = s(1) = 1, $
  so $k = 0$ and $s= r^0 = id_X$.

  But then $z = s(y) = id_X(y) = y$, which is a contradiction. Therefore, $s != r^k$ for any $k$.

  Now, if $r^k = r^l s$, then $s=r^k-l$, contradicting the previous case.

  Finally, if there exists $0<=k, l < n$ such that $r^k s = r^l s$, then multiplying by #ponder("algebra.inverse-element")[inverses] to the right by $s^(-1)$ gives

  $ r^k = r^l => k = l $

  as above.
]

To understand the #ponder("algebra.group")[group] operations on $D_(2n)$, we need to understand the different ways to multiply $r$ and $s$.

#lemma("Dihedral Relation")[
  For $r, s in D_(2n)$ where $r$ represents the #ponder("algebra.dihedral-group")[rotation] and $s$ represents the #ponder("algebra.dihedral-group")[reflection], we have
  $ s r = r^(-1) s. $
] <dihedral-relation>

#proof[
  By @3-point-lemma, it suffices to check that the two expressions do the same thing to $x, y, z$. Indeed,   with $x = 1$, $y = ee^((2ppi ii)/(n))$ and $z = ee^(-(2ppi ii)/(n))$,
  $
    s r (z) & = overline(ee^(-(2 ppi i k)/(n))) & = & ee^((2ppi i k)/(n))  & = & r^(-1)(y) & = & r^(-1) s(z), \
    s r (y) & = overline(ee^((2 ppi i k)/(n)))  & = & ee^(-(2ppi i k)/(n)) & = & r^(-1)(z) & = & r^(-1) s(y), \
    s r (x) & = overline(1)                     & = & ee^(1)               & = & r^(-1)(x) & = & r^(-1) s(x). \
  $
]
