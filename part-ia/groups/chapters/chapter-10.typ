#import "../prelude.typ": *

#lecture-separator(lecture: 23, date: "2025-12-01")

= #ponder("geometry.platonic-solid")[Platonic Solids]

While there are infinitely many regular 2-dimensional polygons, in three dimensions there are only five regular solids, known as the *#ponder("geometry.platonic-solid")[Platonic solids]*.

#definition[
  A convex polyhedron $X subset.eq RR^3$ is a *#ponder("geometry.platonic-solid")[Platonic solid]* if

  - every face of $X$ is a regular $n$-gon for some $n$,

  - $G = isom(X)$ #ponder("algebra.group-action")[acts] #ponder("algebra.action-properties")[transitively] on the faces.

  - if $x in X$ is the midpoint of a face, then

    $
      stab_G (x) teq D_(2n).
    $

] <platonic-solid>

#proposition[
  There are, up to similarity, #ponder("geometry.platonic-solids-classification")[exactly five Platonic solids]:

  - the tetrahedron, with 4 triangular faces and 4 vertices,
  - the cube, with 6 square faces and 8 vertices,
  - the octahedron, with 8 triangular faces and 6 vertices,
  - the dodecahedron, with 12 pentagonal faces and 20 vertices,
  - the icosahedron, with 20 triangular faces and 12 vertices.
] <platonic-solids-classification>

Two solids $X, Y$ are *dual* if $Y$ can be constructed from $X$ by putting vertices in the centers of each face, and then joining vertices in adjacent faces by edges.

#example[
  The cube and the octahedron are dual.

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d8e1.svg", width: 8em)
  ]

]

#example[
  The tetrahedron is dual to itself.
]

#example[
  The dodecahedron and the icosahedron are dual.
]

In particular, if $X$ and $Y$ are dual, then $isom(X) teq isom(Y)$, so we only have three distinct #ponder("algebra.isometry-group")[isometry groups] of #ponder("geometry.platonic-solid")[Platonic solids] to consider.

#example[Tetrahedron][
  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d8e2.svg", width: 6em)
  ]
  Let $G = isom("tetrahedron")$. By definition, $G$ acts #ponder("algebra.action-properties")[transitively] on the four faces, and the $stab_G (x) teq D_6$ so by the #ponder("algebra.orbit-stabiliser")[orbit-stabilizer theorem],
  $ |G| = 4 dot 6 = 24, $
  where $x$ is the center of a face.

  Furthermore, the #ponder("algebra.group-action")[action] of $G$ on the four vertices defines a #ponder("algebra.homomorphism")[homomorphism] $ theta: G-> S_4. $

  We shall prove that $theta$ is #ponder("algebra.homomorphism-bijectivity")[injective]. Suppose $theta(g) = e$. Then $g$ fixes each vertex of the tetrahedron, which are not coplanar. So $g = id$ by the 4-point lemma. Therefore $theta$ is #ponder("algebra.homomorphism-bijectivity")[injective], and we may identify $G$ with a #ponder("algebra.subgroup")[subgroup] of $S_4$.

  But $|S_4| = 24$ and $|G| = 24$, so in fact $G teq S_4$.

  Let us also identify the #ponder("algebra.group")[group] of #ponder("geometry.rotation")[rotational] symmetries #fade[[which are the ones we can actually realize by rotating the solid in space]]:
  $
    G_0 = G inter SO(3)
  $
  where the tetrahedron is centered at the origin.

  #lemma[Uniqueness of $A_n$][
    If $H <= S_n$ and $[S_n : H] = 2$, then $H teq A_n$.
  ]
  #proof[
    Because $[S_n : H] = 2$, $H nsub S_n$, and $S_n \/ H teq C_2$. We therefore have #ponder("algebra.homomorphism-bijectivity")[surjective] #ponder("algebra.homomorphism")[homomorphism] $theta: S_n -> C_2 = {plus.minus 1}$ with $ker(phi) = H$.

    Since #ponder("algebra.transposition-generation")[transpositions generate] $S_n$, there is a #ponder("algebra.transposition")[transposition] $tau_0 in S_n$ with $theta(tau_0) = -1$. Because all #ponder("algebra.transposition")[transpositions] are #ponder("algebra.conjugation")[conjugate] #fade[[they have the same #ponder("algebra.cycle-type")[cycle type]]], so $tau = sigma tau_0 sigma^(-1)$ for any other #ponder("algebra.transposition")[transposition] $tau$ and some $sigma in S_n$. Thus
    $
      theta(tau) = theta(sigma) theta(tau_0) theta(sigma)^(-1) = -1. quad ("since" C_2 "is abelian")
    $
    Therefore $theta = sign$, so
    $
      H = ker theta = ker sign = A_n.
    $


  ]

  Therefore, since $[S_4 : G_0] = 2$, we have $G_0 teq A_4$.

]

#example[Cube and Octahedron][
  Let $G = isom("cube")$. By definition, $G$ #ponder("algebra.group-action")[acts] #ponder("algebra.action-properties")[transitively] on the six faces, and the $stab_G (x) teq D_8$ so by the #ponder("algebra.orbit-stabiliser")[orbit-stabiliser theorem],
  $ |G| = 6 dot 8 = 48, $
  where $x$ is the center of a face.

  In particular, the #ponder("algebra.subgroup-index")[index-two] #ponder("geometry.rotation")[rotational] #ponder("algebra.subgroup")[subgroup] $G_0$ has order 24.

  In Example Sheet 2 Q7, we saw that $G$ #ponder("algebra.group-action")[acts] on the set of the four long diagonals of the cube, giving a #ponder("algebra.homomorphism")[homomorphism] $ theta: G_0-> S_4. $

  Since both $G_0$ and $S_4$ have order 24, to show that $theta$ is #ponder("algebra.homomorphism-bijectivity")[injective] it suffices to show that it is #ponder("algebra.homomorphism-bijectivity")[surjective].

  #claim[
    $theta$ is #ponder("algebra.homomorphism-bijectivity")[surjective].
  ]
  #proof[
    Since @transpositions-generate[Transpositions Generate], it suffices to show that all transpositions are contained in $im theta$. Indeed,
    #align(center)[
      #dynamic-svg("/part-ia/groups/media/d8e3.svg", width: 12em)
    ]
    #ponder("geometry.rotation")[rotation] about the axis through the midpoints of an edge maps to a #ponder("algebra.transposition")[transposition] under $theta$.

    We get $(12)/(2) = 6$ different #ponder("algebra.transposition")[transpositions] this way, which is all of them #fade[[because it happens that $binom(4, 2) = 6$]]. Therefore $im theta = S_4$.
  ]

  Hence comparing orders, we have $G_0 teq S_4$.

  Now, since $-matbold(I) in.not G_0$ commutes with everything in $G_0$, by @direct-product-theorem[Direct Product Theorem] we have
  $
    G teq G_0 times C_2 teq S_4 times C_2.
  $
]

#lecture-separator(lecture: 24, date: "2025-12-03")

#remark[
  We have $G <= O(3)$ and $G_0 = G inter SO(3) = ker(det|_G: G-> C_2)$, so
  $
    [G: G_0] = abs(im(det|_G)) <= 2
  $
  Since cubes have #ponder("geometry.reflection")[reflectional] symmetries, we have $[G: G_0] = 2$ in that case. The same applies to the other #ponder("geometry.platonic-solid")[Platonic solids] as well.
]

Now, for the final two #ponder("geometry.platonic-solid")[Platonic solids].

#example[Dodecahedron and Icosahedron #fade[[Non-Examinable]]][
  Let $G = isom("dodecahedron")$ and $G_0$ the #ponder("geometry.rotation")[rotational] #ponder("algebra.subgroup")[subgourp] of #ponder("algebra.subgroup-index")[index two].

  By definition, $G$ #ponder("algebra.group-action")[acts] #ponder("algebra.action-properties")[transitively] on the twelve faces, and the $stab_G (x) teq D_(10)$ so by the #ponder("algebra.orbit-stabiliser")[orbit-stabiliser theorem],
  $ |G| = 12 dot 10 = 120, $
  where $x$ is the center of a face. And so $|G_0| = 60$.

  By drawing diagonoals on faces, we may inscribe 5 cubes into the dodecahedron.

  #align(center)[
    #dynamic-svg("/part-ia/groups/media/d8e4.svg", width: 28em)
  ]

  Since the 5 cubes are built symmetrically from the geometry of the dodecahedron, $G_0$ #ponder("algebra.group-action")[acts] on the set of these 5 cubes, giving a #ponder("algebra.homomorphism")[homomorphism]
  $ theta: G_0-> S_5. $
  #ponder("geometry.rotation")[Rotation] around the axes through an opposite pair of vertices leads to a #ponder("algebra.cycle")[3-cycle]. There are 10 diagonals between opposite pairs of vertices, so we get 10 inverse pairs of #ponder("algebra.cycle")[3-cycles]. So, we get all 10 #ponder("algebra.cycle")[3-cycles] in $S_5$.

  #claim[
    Let $X subset.eq A_5$ be the set of 3-cycles. Then
    $
      lr(chevron.l X chevron.r) = A_5.
    $
  ]
  #proof[
    By Example Sheet 4 Q2,
    $
      lr(chevron.l X chevron.r) nsub A_5.
    $
    Since $A_5$ is #ponder("algebra.simple-group")[simple], either $lr(chevron.l X chevron.r) = {e}$ or $lr(chevron.l X chevron.r) = A_5$. Since $X != {e}$, we must have $lr(chevron.l X chevron.r) = A_5$.
  ]

  In summary, if $X$ is the set of 3-cycles, we have seen that
  $
    X subset.eq im theta quad "and"quad lr(chevron.l X chevron.r) = A_5 <= im theta.
  $

  Therefore we have
  $
    60 = abs(G_0) >= im theta >= abs(A_5) = 60,
  $
  so $theta$ is #ponder("algebra.homomorphism-bijectivity")[surjective] and hence an #ponder("algebra.isomorphism")[isomorphism]. Therefore $G_0 teq A_5$.

  Finally, since $-matbold(I) in.not G_0$ commutes with everything in $G_0$, by @direct-product-theorem[Direct Product Theorem] we have
  $
    G teq G_0 times C_2 teq A_5 times C_2.
  $

]
