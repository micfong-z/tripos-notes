#import "../prelude.typ": *

= #ponder("algebra.group-order")[Finite Groups]

We have already seen some nice theorems about #ponder("algebra.group-order")[finite groups], including #ponder("algebra.lagrange-theorem")[Lagrange's], #ponder("algebra.orbit-stabiliser")[orbit-stabilizer], #ponder("algebra.cayley-theorem")[Cayley's], and #ponder("algebra.cauchy-theorem")[Cauchy's] theorems.

#lecture-separator(lecture: 14, date: "2025-11-10")

We will now develop some small examples of #ponder("algebra.group-order")[finite groups]. We shall proceed naively, trying to list examples by #ponder("algebra.group-order")[order].


$
  abs(G) & = 1 quad & => quad G & teq 1 \
  abs(G) & = 2 quad & => quad G & teq C_2 "since 2 is prime" \
  abs(G) & = 3 quad & => quad G & teq C_3 "since 3 is prime"
$

Now, if $abs(G)=4$, we know that $C_4$ is always an option. But is there another?

#definition[#ponder("algebra.direct-product")[Direct Product]][
  If $G, H$ are #ponder("algebra.group")[groups], the *#ponder("algebra.direct-product")[direct product]* is
  $
    G times H = {(g, h): g in G, h in H}
  $
  with #ponder("algebra.binary-operation")[operation]
  $ (g_1, h_1) dot (g_2, h_2) = (g_1 dot g_2, h_1 dot h_2). $
  Note that $(e_G, e_H)$ is a #ponder("algebra.group")[identity], and $(g, h)^(-1) = (g^(-1), h^(-1))$.
] <direct-product>

#example[#ponder("algebra.klein-four-group")[Klein 4-group]][
  The *#ponder("algebra.klein-four-group")[Klein 4-group]* is $K_4 := C_2 times C_2$. It can also be thought of as $D_4$. Note that, for every $(a, b) in K_4$, we have $(a, b)^2 = (e, e)$. So every element has #ponder("algebra.element-order")[order] at most 2. In particular, $K_4 teq.not C_4$.
] <klein-four-group>

#theorem[#ponder("algebra.direct-product-theorem")[Direct Product Theorem]][
  If $H_1, H_2 <= G$ and

  1. $H_1 inter H_2 = {e}$,

  2. $forall h_1 in H_1, h_2 in H_2, h_1 h_2 = h_2 h_1$,

  3. $G = H_1 H_2$, _i.e._ for every $g in G$, there exist $h_1 in H_1, h_2 in H_2$ such that $g = h_1 h_2$,

  then $G teq H_1 times H_2$.
] <direct-product-theorem>

#proof[
  Define $Phi: H_1times H_2 -> G$ with $(h_1, h_2) |-> h_1h_2$. We need to show that $Phi$ is an #ponder("algebra.isomorphism")[isomorphism].

  #boxed-header[$Phi$ is a #ponder("algebra.homomorphism")[homomorphism]]

  For any $h_1, h'_1 in H$, $h_2, h'_2 in H$, by definition,
  $
    Phi(h_1, h_2) Phi(h'_1, h'_2) & = (h_1 h_2)(h'_1 h'_2) \
                                  & = h_1 h'_1 h_2 h'_2 quad "by (2)" \
                                  & = Phi(h_1 h'_1, h_2 h'_2) \
                                  & = Phi((h_1, h_2)(h'_1, h'_2)) quad "as required."
  $

  #boxed-header[$Phi$ is #ponder("algebra.homomorphism-bijectivity")[surjective]]

  This is immediate from (3).

  #boxed-header[$Phi$ is #ponder("algebra.homomorphism-bijectivity")[injective]]

  Recall that we need to show that $ker(Phi) = {(e, e)}$. Suppose that $Phi(h_1, h_2) = e$. Then $h_1 h_2 = e$, so $h_2 = h_1^(-1) in H_1$. But $h_2 in H_2$ also, so by (1), we must have $h_2 = e$ and $h_1 = e$. Thus $(h_1, h_2) = (e, e)$, as required.
]

#remark[
  If $H_1 inter H_2 = {e}$, then $abs(H_1 H_2) = abs(H_1) abs(H_2)$. In particular, if $abs(H_1) abs(H_2) = abs(G)$, we can conclude that (1) implies (3).
]

#lemma[#ponder("algebra.groups-of-order-4")[Groups of order 4]][
  If $abs(G) = 4$, then $G teq C_4$ or $G teq K_4$.
] <lemma-groups-of-order-4>

#proof[
  By #ponder("algebra.lagrange-theorem")[Lagrange's theorem], every non-trivial element of $G$ has #ponder("algebra.element-order")[order] 2 or 4. If there is a $g in G$ such that $o(g)=4$, then $G teq C_4$.

  Otherwise, every non-trivial element has #ponder("algebra.element-order")[order] 2. Let $a, b in G$ be distinct elements such that $o(a)=o(g) = 2$. Let $H_1 = lr(chevron.l a chevron.r)$ and $H_2 = lr(chevron.l b chevron.r)$. It is immediate that $H_1 inter H_2 = {e}$ #fade[[this can be seen by writing out the elements explicitly]], which gives us (1). Following the remark, (3) holds.

  Finally, since $o(a b) =2$, we have $a b a b = e$, so $a b = b a$, giving us (2) #fade[[this was mentioned in Example Sheet 1, Q11]]. Thus by the #ponder("algebra.direct-product-theorem")[direct product theorem], $G teq H_1 times H_2 teq C_2 times C_2 teq K_4$, as required.
]

Another application of the @direct-product-theorem[direct product theorem] is to find out when a product of two #ponder("algebra.cyclic-group")[cyclic groups] is #ponder("algebra.cyclic-group")[cyclic].

#theorem[#ponder("algebra.chinese-remainder-theorem")[Chinese Remainder Theorem]][
  If $gcd(m, n) = 1$, then $C_m times C_n teq C_(m n)$.
] <chinese-remainder-theorem>

#proof[
  Let $C_(m n ) = lr(chevron.l g chevron.r)$. Set
  $
    H_1 = lr(chevron.l g^n chevron.r), quad H_2 = lr(chevron.l g^m chevron.r).
  $
  We will check against @direct-product-theorem[DPT].

  1. Note that
    $
      g^k in H_1 & <=> k = n p + m n q quad "for some" p, q in ZZ \
                 & <=> n divides k.
    $
    Similarly,
    $ g^k in H_2 & <=> m divides k. $
    Therefore, $g^k in H_1 inter H_2$ iff $m n$ divides $k$. Since $o(g) = m n$, this happens iff $g^k = e$. Thus, $H_1 inter H_2 = {e}$ as required.

  2. Since $C_(m n)$ is #ponder("algebra.abelian-group")[abelian], this is immediate.

  3. This follows from (1) and the remark after DPT.
]

We shall now move on to #ponder("algebra.group")[groups] of #ponder("algebra.group-order")[order] 5 and above.

$
  abs(G) & = 5 quad & => quad G & teq C_5 "since 5 is prime"
$

#lemma[#ponder("algebra.groups-of-order-6")[Groups of order 6]][
  If $abs(G) = 6$, then $G teq C_6$ or $G teq D_6$.
] <groups-of-order-6>

#proof[
  By @cauchys-theorem[Cauchy's theorem], there exist $r, s in G$ such that $o(r) = 3$ and $o(s) = 2$. Since $abs(lr(chevron.l r chevron.r)) =3$, $[G: lr(chevron.l r chevron.r) ] = 2$, and $s in.not lr(chevron.l r chevron.r)$. Therefore,
  $
    s lr(chevron.l r chevron.r) = G \\ lr(chevron.l r chevron.r) = lr(chevron.l r chevron.r) s
  $
  since the other #ponder("algebra.coset")[coset] must be $lr(chevron.l r chevron.r)$. So $s r = r^i s$ for some $i in {0, 1, 2}$.

  - If $i = 0$, then $s r = r^0 s = s$, so $r = e$, a contradiction.

  - If $i = 1$, then $s r = r s$. Then $lr(chevron.l s chevron.r)$ and $lr(chevron.l r chevron.r)$ satisfy the conditions of @direct-product-theorem[DPT], so
    $
      G teq lr(chevron.l r chevron.r) times lr(chevron.l s chevron.r) teq C_3 times C_2 teq C_6.
    $

  - If $i = 2$, then $s r = r^2 s$. In this case, $G = lr(chevron.l r, s chevron.r)$ with relations $r^3 = s^2 = e$, $s r = r^(-1) s$, which is satisfies the @dihedral-relation[dihedral relation]. Thus, $G teq D_6$.
]

#remark[
  $S_3$ is a #ponder("algebra.abelian-group")[non-abelian] #ponder("algebra.group")[group] of #ponder("algebra.group-order")[order] 6, so by the above lemma, $S_3 teq D_6$.
]

Continuing on,

$
  abs(G) & = 7 quad & => quad G & teq C_7 "since 7 is prime" \
$

#lecture-separator(lecture: 15, date: "2025-11-12")

Consider $abs(G) = 8$.

We have $C_8$ and $C_2 times C_4$ and $C_2 times C_2 times C_2$ as #ponder("algebra.abelian-group")[abelian groups] of #ponder("algebra.group-order")[order] 8.

We also have $D_8$ as a #ponder("algebra.abelian-group")[non-abelian] #ponder("algebra.group")[group] of #ponder("algebra.group-order")[order] 8.

#exercise[
  None of the #ponder("algebra.group")[groups] $D_8$, $C_8$, $C_2 times C_4$, and $C_2 times C_2 times C_2$ are #ponder("algebra.isomorphism")[isomorphic] to each other.
]

#definition[#ponder("algebra.quaternion-group")[Quaternion Group]][
  Let
  $
    Q_8 = { mat(plus.minus 1, 0; 0, plus.minus 1), mat(plus.minus ii, 0; 0, minus.plus ii), mat(0, plus.minus 1; minus.plus 1, 0), mat(0, plus.minus ii; plus.minus ii, 0) }.
  $
  It is easy to check that these form a #ponder("algebra.group")[group]. We usually use Hamilton's notation:
  $
    1 & = mat(1, 0; 0, 1),    & quad & -1 & = & mat(-1, 0; 0, -1), \
    i & = mat(ii, 0; 0, -ii), & quad & -i & = & mat(-ii, 0; 0, ii), \
    j & = mat(0, 1; -1, 0),   & quad & -j & = & mat(0, -1; 1, 0), \
    k & = mat(0, ii; ii, 0),  & quad & -k & = & mat(0, -ii; -ii, 0).
  $

  So the elements of $Q_8$ are ${plus.minus 1, plus.minus i, plus.minus j, plus.minus k}$, with relations

  - $i^2 = j^2 = k^2 = -1$,
  - $(-1) i = - i$, _etc._
  - $i j = k$, $j k = i$, $k i = j$,
  - $-1$ commutes with everything.

  We call this #ponder("algebra.group")[group] the *#ponder("algebra.quaternion-group")[quaternion group]*.
] <quaternion-group>

Since $j i = - k != k = i j$, $Q_8$ is #ponder("algebra.abelian-group")[non-abelian] and so $Q_8 teq.not C_2times C_2times C_2, C_4times C_2, C_8.$

By considering the #ponder("algebra.element-order")[orders] of elements, we can also see that $Q_8 teq.not D_8$. $D_8$ has 5 elements of #ponder("algebra.element-order")[order] 2 (one 180° rotation and the 4 reflections), whereas $Q_8$ has only one (the element $-1$).

It can be shown that these are all the #ponder("algebra.groups-of-order-8")[groups of order 8].

#lemma[#ponder("algebra.groups-of-order-8")[Groups of order 8]][
  If $abs(G) = 8$, then $G$ is #ponder("algebra.isomorphism")[isomorphic] to one of $C_8$, $C_4 times C_2$, $C_2 times C_2 times C_2$, $D_8$, or $Q_8$.
] <groups-of-order-8>

#proof[
  By #ponder("algebra.lagrange-theorem")[Lagrange's theorem], the possible #ponder("algebra.element-order")[orders] of elements in $G$ are 1, 2, 4, or 8. We have the following cases:

  - If there is an element of #ponder("algebra.element-order")[order] 8, then $G teq C_8$.

  - If every non-trivial element has #ponder("algebra.element-order")[order] 2, then $G teq C_2 times C_2 times C_2$ by a similar argument as in @lemma-groups-of-order-4. We will start by choosing non-trivial elements $a, b, c in G$ with $a != b$ and $c!=a, b, a b$. We can see that
    $
      G teq lr(chevron.l a chevron.r) times lr(chevron.l b chevron.r) times lr(chevron.l c chevron.r) teq C_2times C_2times C_2
    $
    by using @direct-product-theorem twice. #fade[[Check Example Sheet 1, Q11 for related details.]]


  - If there is an element of #ponder("algebra.element-order")[order] 4, but no element of #ponder("algebra.element-order")[order] 8, let $a in G$ with $o(a) = 4$. Let $b in G \\ lr(chevron.l a chevron.r)$. By #ponder("algebra.lagrange-theorem")[Lagrange's theorem],

    $
      [G: lr(chevron.l a chevron.r) = 2]
    $
    so
    $
      b lr(chevron.l a chevron.r) = G \\ lr(chevron.l a chevron.r) = lr(chevron.l a chevron.r) b.
    $
    In particular, $b a = a^i b$ for some $i in {0, 1, 2, 3}$.

    - If $i = 0$, then $b a = a^0 b = b$, so $a = e$. $smash$
    - If $i = 1$, then $b a = a b$, so $b a^j = a^j b$ for all $j$, then $G$ is #ponder("algebra.abelian-group")[abelian]. *[Case A.]*
    - If $i = 2$, then $b a = a^2 b$, so $b a b^(-1) = a^2.$ But $o(b a b^(-1)) = o(a) = 4$ by Example Sheet 2, Q1. However, $o(a^2) = 2$. $smash$
    - If $i = 3$, then $b a = a^3 b = a^(-1) b$, which looks similar to the #ponder("algebra.dihedral-relation")[dihedral relation]. *[Case B.]*

    Next, note that if $b^2 = b a^i$, then $b = a^j$ and so $b in lr(chevron.l a chevron.r)$. $smash$

    Thus $b^2 in lr(chevron.l a chevron.r)$. We have several more cases:

    - $b^2 = e$, which we will handle later. *[Case I.]*
    - If $b^2 = a$, then $o(b) = 8$, so $G teq C_8$. $smash$
    - $b^2 = a^2$, which we will handle later. *[Case II.]*
    - If $b^2 = a^3 = a^(-1)$, then $o(b) = 8$, so $G teq C_8$. $smash$

    There are now four subcases to consider:
    - *[Case A, I.]* If $G$ is #ponder("algebra.abelian-group")[abelian] and $lr(chevron.l b chevron.r) teq C_2$, then $lr(chevron.l a chevron.r) inter lr(chevron.l b chevron.r) = {e}$, so by @direct-product-theorem,
      $
        G teq lr(chevron.l a chevron.r) times lr(chevron.l b chevron.r) teq C_4 times C_2.
      $

    - *[Case A, II.]* If $G$ is #ponder("algebra.abelian-group")[abelian], $b^2 = a^2$, so
      $
        (a b^(-1))^2 = e => o(a b^(-1)) = 2.
      $
      Again, $G equiv C_2 times C_2$ by @direct-product-theorem.

    - *[Case B, I.]* We have $o(a) = 4$ and $o(b) = 2$ with #ponder("algebra.dihedral-relation")[relation] $b a = a^(-1) b$. These are exactly the #ponder("algebra.dihedral-relation")[relations] for $D_8$ (using @prop-groups-of-dihderal-type), so $G teq D_8$.

    - *[Case B, II.]* We have $b^2 = a^2$ and $o(a) = 4$ with $b a = a^(-1) b$.

      Let $i = a$, $j = b$, $k = a b$, $-1 = a^2 = b^2$.

      Then, the elements of $G$ are ${e, a, a^2, a^3, b, a b, a^2 b, a^3 b}$
      which are ${plus.minus 1, plus.minus i, plus.minus j, plus.minus k}$ in Hamilton's notation.

      It is easy to check that the relations in $G$ match those in $Q_8$. This defines an #ponder("algebra.isomorphism")[isomorphism] between $G$ and $Q_8$.

      Therefore $G teq Q_8$, as required.
]

In summary, the #ponder("algebra.group")[groups] of #ponder("algebra.group-order")[order] up to 8 are as follows:

1. $1$
2. $C_2$
3. $C_3$
4. $C_4$, $C_2 times C_2$
5. $C_5$
6. $C_6$, $D_6$
7. $C_7$
8. $C_8$, $C_4 times C_2$, $C_2 times C_2 times C_2$, $D_8$, $Q_8$
