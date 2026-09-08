#import "../prelude.typ": *

#lecture-separator(lecture: 3, date: "2025-10-14")

= Vectors

A vector can be specified by a (positive) magnitude and a direction in space.

== Introduction on Vectors

We can represent a vector as a line segment between two points $A$ and $B$, and we write $vb(v)=arrow(A B).$ The vector $vb(v)$ has length $abs(vb(v))$ and direction from $A$ to $B$.

If we choose $O$ as the origin, then point $A$ has position vector $vb(a)=arrow(O A)$.

#definition("Vector space over reals and complex numbers")[
  A #ponder("linear-algebra.vector-space")[*vector space*] $V$ over $CC$ or $RR$ is a set of abstract vectors ${vb(v)}$ equipped with operations of

  - vector addition $plus.o:V times V->V$, and
  - scalar multiplication $times.o:RR times V -> V$

  that satisfy the following axioms:

  _Vector addition axioms_
  1. #ponder("algebra.commutativity-associativity-distributivity")[*Commutativity*]: $vb(u) plus.o vb(v)=vb(v) plus.o vb(u)$.
  2. #ponder("algebra.commutativity-associativity-distributivity")[*Associativity*]: $(vb(u) plus.o vb(v)) plus.o vb(w)=vb(u) plus.o (vb(v) plus.o vb(w))$.
  3. *Additive identity*: $exists vb(0) in V$ such that $vb(0) plus.o vb(v) = vb(v)$ for all $vb(v) in V$.
  4. #ponder("algebra.inverse-element")[*Additive inverse*]: $forall vb(v) in V$, $exists (-vb(v)) in V$ such that $vb(v) plus.o (-vb(v))=vb(0)$.

  _Scalar multiplication axioms_
  1. $lambda times.o (vb(u) plus.o vb(v))=(lambda times.o vb(u)) plus.o (lambda times.o vb(v))$.
  2. $(lambda plus.o mu) times.o vb(v)=(lambda times.o vb(v)) plus.o (mu times.o vb(v))$.
  3. $lambda times.o (mu times.o vb(v))=(lambda mu) times.o vb(v)$.
  4. $1 times.o vb(v)=vb(v)$.
] <def-vector-space-over-rr-cc>

#notation[
  Usually, we omit the circles of $plus.o$ and $times.o$, and write them as if they were $+$ and $times$.
]

#remark[
  - Vectors under $+$ form an #ponder("algebra.abelian-group")[Abelian group].
]

#example[
  In $RR^3$, we define the two operations as follows:

  - *Vector addition.* Consider $vb(a)$ and $vb(b)$ the position vectors of two points $A, B$ respectively. We can construct a parallelogram and then do compositions of two vectors, such that $vb(a)+vb(b)=vb(c)$.


    #align(center)[
      #dynamic-svg("/part-ia/vectors-and-matrices/media/d2e1.svg", width: 12em)
    ]

  - *Scalar multiplication.* Given $vb(a)$ the position vector of a point $A$, and $lambda in RR$, $lambda vb(a)$ is a position vector of a point on line $O A$, with length $abs(lambda vb(a))=abs(lambda) abs(vb(a))$, in the direction as shown follows.


    #align(center)[
      #dynamic-svg("/part-ia/vectors-and-matrices/media/d2e2.svg", width: 24em)
    ]

]

#definition("Unit vector")[
  A #ponder("linear-algebra.unit-vector")[*unit vector*] is a vector with length $1$. We denote it as $vu(v)$.
] <unit-vector>

#definition("Linear combination")[
  Consider two vectors $vb(a), vb(b)$ and scalars $alpha, beta in RR$. Then

  $ alpha vb(a) + beta vb(b) $

  is a #ponder("linear-algebra.linear-combination")[*linear combination*] of $vb(a)$ and $vb(b)$.
] <linear-combination>

In general, we denote all possible #ponder("linear-algebra.linear-combination")[linear combinations] of two given vectors $vb(a), vb(b)$ by

$ {alpha vb(a) + beta vb(b):alpha, beta in RR} = upright(s p a n) {vb(a), vb(b)}. $
This is called that #ponder("linear-algebra.span")[*span*] of ${vb(a), vb(b)}$.

This extends to any number of vectors (possibly more than two).

#definition("Parallel")[
  We say that $vb(a)$ and $vb(b)$ are #ponder("linear-algebra.parallel-vectors")[*parallel*], denoted $vb(a) parallel vb(b)$, if $vb(a)=lambda vb(b)$ (or equivalently $vb(b) = lambda vb(a)$) for some $lambda in RR$. We allow $lambda = 0$, so $vb(0) parallel vb(v)$ for any vector $vb(v)$.
] <parallel-vectors>

#remark[
  If $vb(a) parallel.not vb(b)$, then $upright(s p a n) {vb(a), vb(b)} = upright(s p a n) {vb(a), vb(a)-vb(b)}$ is a plane through $O, A, B$.
]

== #ponder("linear-algebra.dot-product")[Scalar Product] (Dot Product)

#definition([Scalar product in $RR^n$])[
  For two vectors $vb(a), vb(b)$ in $RR^n$, and $theta$ the (plane) angle between them. Then the #ponder("linear-algebra.dot-product")[*scalar* product] of $vb(a)$ and $vb(b)$ is given by:

  $ vb(a) dot vb(b) = abs(vb(a))abs(vb(b)) cos theta. $

  Intuitively, this is the product of the parts in $vb(a)$ and $vb(b)$ which are parallel.
] <rn-scalar-product>

We have some interesting results on #ponder("linear-algebra.dot-product")[scalar products] in general.

#proposition[
  If $vb(a), vb(b), vb(c)$ are vectors and $lambda in RR$, we have

  - $vb(a) dot vb(b) = vb(b) dot vb(a)$
  - $vb(a) dot vb(a) = abs(vb(a))^2 >= 0$, and $abs(vb(a))=0$ if and only if $vb(a) = vb(0)$
  - $(lambda vb(a)) dot vb(b) = lambda(vb(a) dot vb(b)) = vb(a) dot (lambda vb(b))$
  - $vb(a) dot (vb(b) + vb(c)) = vb(a) dot vb(b) + vb(a) dot vb(c)$
]

#definition("Perpendicularity")[

  Moreover, we say that $vb(a)$ and $vb(b)$ are #ponder("linear-algebra.orthogonality")[*orthogonal*  or *perpendicular*] and denote it by $vb(a) perp vb(b)$ if
  $ vb(a) dot vb(b) = 0. $

  In this case, we allow for $vb(a)$ or $vb(b)$ to be $vb(0)$.
] <orthogonality>

Using the dot product we can write the projection of $vb(b)$ onto $vb(a)$ as

$ vu(a) abs(vb(b)) cos theta= (vu(a) dot vb(b)) vu(a). $


We can actually derive @rn-scalar-product.

#proposition[
  For $x, y in RR^3$, define $theta in [0, ppi]$ to be the (plane) angle between them. Then
  $ vb(x) dot vb(y) = |vb(x)| |vb(y)|cos theta. $
] <lem-2-1>

#proof[
  #set math.equation(numbering: "«1")
  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/dxe1.svg", width: 10em)
  ]
  For any $x, y in RR^3$, we have
  $ |vb(x)-vb(y)|^2 = |vb(x)|^2+|vb(y)|^2-2|vb(x)| |vb(y)| cos theta quad "by cosine rule." $ <eq1>
  But from the definition of #ponder("linear-algebra.dot-product")[scalar product],
  $
    |vb(x) - vb(y)|^2 & = (vb(x) - vb(y)) dot (vb(x) - vb(y)) \
                          & = |vb(x)|^2+|vb(y)|^2-2 vb(x) dot vb(y). \
  $  <eq2>

  #set math.equation(numbering: none)
  By comparing @eq1 and @eq2, we get $vb(x) dot vb(y)=|vb(x)| |vb(y)| cos theta.$
]

#definition("Real inner product")[
  We say, for #ponder("linear-algebra.vector-space")[vector space] $V$, a map $iprod(dot, dot):V times V->RR$ is called an #ponder("linear-algebra.inner-product")[inner product] if

  1. $iprod(alpha vb(x) + beta vb(y), vb(z)) = alpha iprod(vb(x), vb(z)) + beta iprod(vb(y), vb(z))$.
  2. $iprod(vb(x), vb(y)) = iprod(vb(y), vb(x))$.
  3. $iprod(vb(x), vb(x)) > 0$ for $vb(x) != vb(0)$.
] <inner-product>

#definition("Norm")[
  Given the #ponder("linear-algebra.inner-product")[inner product] on $V$, we define the #ponder("linear-algebra.norm")[norm] $| dot |:V->[0, oo]$ to be $||vb(x)||=sqrt(iprod(vb(x), vb(x)))$.
] <norm>

#lecture-separator(lecture: 4, date: "2025-10-16")

We can now form an inequality that we will encounter various times in various forms in later courses, but here we shall see a simplest formation of it.

#theorem("Cauchy-Schwarz inequality")[
  For all $vb(x), vb(y) in RR^n$, then
  $ abs(vb(x) dot vb(y))<= abs(vb(x))abs(vb(y)). $
] <cauchy-schwarz>

#proof[
  Consider the expression $abs(vb(x)-lambda vb(y))^2$, where $lambda in RR$. Then

  $
    abs(vb(x)-lambda vb(y))^2 &>= 0 \
    (vb(x)-lambda vb(y)) dot (vb(x)-lambda vb(y)) &>=0\
    abs(vb(x))^2 + lambda^2 abs(vb(y))^2 - 2 lambda vb(x) dot vb(y) &>= 0 \
    lambda^2 abs(vb(y))^2- 2 lambda vb(x) dot vb(y) + abs(vb(x))^2 &>= 0 & quad "by rearranging as a quadratic of" lambda\
    4 (vb(x) dot vb(y))^2 - 4 abs(vb(x))^2 abs(vb(y))^2 &<= 0 & quad "by taking discriminant"\
    abs(vb(x) dot vb(y)) &<= abs(vb(x)) abs(vb(y)) .
  $
]

Here are some important observations for the #ponder("linear-algebra.cauchy-schwarz-inequality")[Cauchy-Schwarz inequality].

#remark[

  - This inequality holds for all #ponder("linear-algebra.dot-product")[scalar product] in any #ponder("linear-algebra.vector-space")[real vector space].

  - The equality holds if and only if $vb(x) = lambda vb(y)$ or $vb(y) = lambda vb(x)$ for some $lambda in RR$.

  - @rn-scalar-product is now well-defined since #ponder("linear-algebra.cauchy-schwarz-inequality")[Cauchy-Schwarz] ensures that $-1 <= cos theta <= 1$.
]

#corollary("Triangle inequality")[
  For $vb(x), vb(y) in RR^n$, we have
  $ abs(vb(x) + vb(y)) <= abs(vb(x)) + abs(vb(y)). $
] <triangle-inequality>

#proof[
  We have
  $
    abs(vb(x)+vb(y))^2 & = (vb(x)+vb(y))dot (vb(x)+vb(y)) \
                           & = abs(vb(x))^2+abs(vb(y))^2 + 2 vb(x) dot vb(y) \
                           & <= abs(vb(x))^2+abs(vb(y))^2+2abs(vb(x))abs(vb(y)) \
                           & = (abs(vb(x))+abs(vb(y)) )^2 \
  $
  The result then follows.
]

== #ponder("linear-algebra.orthonormal")[Orthonormal] Bases

#definition("Orthonormal")[
  Vectors are said to be #ponder("linear-algebra.orthonormal")[*orthonormal*] if they are #ponder("linear-algebra.orthogonality")[orthogonal] #ponder("linear-algebra.unit-vector")[unit vectors].
] <orthonormal>

Consider $RR^3$, and consider vectors $vb(e_1)$, $vb(e_2)$ , $vb(e_3)$ that are #ponder("linear-algebra.orthonormal")[orthonormal]. Then we have

$
  vb(e_i) dot vb(e_j) =cases(
    1 quad i=j,
    0 quad i !=j
  ) quad "for" i, j = 1, 2, 3.
$

This is equivalent to choosing Cartesian axes along these directions. We need a few extra definitions to describe this.

#definition("Spanning")[
  For a #ponder("linear-algebra.vector-space")[vector space] $V$, we say a subset $S={vb(u_1), ..., vb(u_p)}$ is a #ponder("linear-algebra.spanning-set")[*spanning set*] for $V$ if each of $vb(v) in V$ can be written as a #ponder("linear-algebra.linear-combination")[linear combination] of the vectors in $S$.
] <spanning-set>

#definition("Linearly independent")[
  We say the set $T = {vb(v_1), ..., vb(v_q)}$ is #ponder("linear-algebra.linear-independence")[*linearly independent*] if
  $ sum_(i=1)^(q) lambda_i vb(v_i)=0 <=> lambda_i = 0 "for" i = 1, ..., q. $

]

#definition("Basis")[
  A set of vectors $B={vb(u_1), ..., vb(u_n)}$ in $V$ is called a #ponder("linear-algebra.basis")[*basis*] if it is #ponder("linear-algebra.spanning-set")[spanning] and #ponder("linear-algebra.linear-independence")[linearly independent].
]

Hence, ${vb(e_1), vb(e_2), vb(e_3)}$ is an #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis].

We can therefore denote $vb(a)$ in the following ways:

$ vb(a) = vecrow(a_1, a_2, a_3) quad "or" quad vb(a)=vec(a_1, a_2, a_3). $

Now, for $vb(a), vb(b) in RR^3$, we have

$
  vb(a) dot vb(b) &= (a_1 vb(e_1) + a_2 vb(e_2) + a_3 vb(e_3)) dot (b_1 vb(e_1) +b_2 vb(e_2) + b_3 vb(e_3)) \
  &= a_1b_1 + a_2b_2 + a_3b_3. \
$

In particular, we can derive the Pythagorean rule, since
$ vb(a) dot vb(a) = abs(vb(a))^2 = a_1^2 + a_2^2 + a_3^2. $

For the canonical basis of $RR^3$, the one that we use for the representation in terms of row or column vector,
$ vb(e_1)=vecrow(1, 0, 0) quad vb(e_2)=vecrow(0, 1, 0) quad vb(e_3)=vecrow(0, 0, 1), $
we can represent the vectors by
$ vu(i), vu(j), vu(k) $
respectively.

== #ponder("linear-algebra.cross-product")[Vector Product] (Cross Product) in $RR^3$

#definition([Vector Product in $RR^3$])[
  Consider $vb(a), vb(b) in RR^3$. Their #ponder("linear-algebra.cross-product")[vector product] is defined by
  $ vb(a) times vb(b) = abs(vb(a))abs(vb(b)) vu(n) sin theta $
  where $vu(n)$ is a #ponder("linear-algebra.unit-vector")[unit vector] that is #ponder("linear-algebra.orthogonality")[perpendicular] to both $vb(a)$ and $vb(b)$, and $(vb(a), vb(b), vu(n))$ is right-handed.
] <cross-product>

#remark[

  1. If we change $theta$ to $2ppi - theta$, we obtain $-vu(n)$ in the definition of $vb(a) times vb(b)$ instead.

  2. $vu(n)$ is not defined if $vb(a) parallel vb(b)$. However, we immediately have $vb(a) times vb(b) = vb(0)$.

  3. $theta$ is not defined if $abs(vb(a))=0$ or $abs(vb(b)) = 0$.
]

#notation[
  $vb(a) and vb(b) equiv vb(a) times vb(b)$ for #ponder("linear-algebra.cross-product")[vector product].
]

#proposition("Properties of vector product")[
  If $vb(a), vb(b), vb(c)$ are vectors in $RR^3$, then we have

  1. $vb(a) times vb(b) = -vb(b)times vb(a)$.
  2. $vb(a) times vb(a)=vb(0)$.
  3. $vb(a)times vb(b)=vb(0) <=> vb(a) = lambda vb(b)$ for some $lambda in RR$, or either vector is the zero vector.
  4. $(lambda vb(a))times vb(b) = lambda(vb(a) times vb(b)) = vb(a) times (lambda vb(b))$.
  5. $vb(a) times (vb(b) + vb(c)) = vb(a) times vb(b) + vb(a) times vb(c)$.
  6. $vb(a) dot (vb(a) times vb(b)) =vb(b) dot (vb(a) times vb(b)) = 0$.
]

#proposition("Geometric interpretations of vector product")[
  For two vectors $vb(a), vb(b) in RR^3$, then $abs(vb(a) times vb(b))$ is the area of the parallelogram formed by $vb(a)$ and $vb(b)$.

  If $vb(a) = arrow(O A)$ and $vb(b) = arrow(O B)$, then the area of the triangle $O A B$ is given by $(1)/(2) abs(vb(a) times vb(b))$.
]

#lecture-separator(lecture: 5, date: "2025-10-18")

#proposition("Alternative geometric interpretations of vector product")[
  Fix a vector $vb(a)$ and consider $vb(x) perp vb(a)$. Then, computing $vb(a) times vb(x)$ gives a vector that scales $vb(x)$ by $abs(vb(a))$ and rotates it by $(pi)/(2)$ in a plane that is #ponder("linear-algebra.orthogonality")[orthogonal] to $vb(a)$.

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e1.svg", width: 24em)
  ]
]

=== Component Expressions

Let $vb(e_1) = vecrow(1, 0, 0), vb(e_2)=vecrow(0, 1, 0), vb(e_3)=vecrow(0, 0, 1)$. Then

$
  vb(e_1) times vb(e_2) & = vb(e_3)=-vb(e_2)times vb(e_1) \
  vb(e_2) times vb(e_3) & = vb(e_1)=-vb(e_3)times vb(e_2) \
  vb(e_3) times vb(e_1) & = vb(e_2)=-vb(e_1)times vb(e_3) \
$

Consider $vb(a)=vecrow(a_1, a_2, a_3)$ and $vb(b)=vecrow(b_1, b_2, b_3)$. We have

$
  vb(a) times vb(b) = & (a_2b_3-a_3b_2)vb(e_1) \
                          & + (a_3b_1-a_1b_3) vb(e_2) \
                          & + (a_1b_2-a_2b_1) vb(e_3).
$

This is also equivalent to

$
  vb(a)times vb(b) =mdet(vu(i), vu(j), vu(k); a_1, a_2, a_3; b_1, b_2, b_3).
$

== Triple Products

=== #ponder("linear-algebra.scalar-triple-product")[Scalar Triple Product]

#definition("Scalar triple product")[
  Consider $vb(a), vb(b), vb(c) in RR^3$. We write

  $ [vb(a), vb(b), vb(c)] = vb(a) dot (vb(b) times vb(c)) $

  to be the #ponder("linear-algebra.scalar-triple-product")[*scalar triple product*] between $vb(a), vb(b), vb(c)$.
] <scalar-triple-product>

#proposition[
  For $vb(a), vb(b), vb(c) in RR^3$, we have

  $
      & vb(a) dot (vb(b) times vb(c)) = vb(b) dot (vb(c) times vb(a)) = vb(c) dot (vb(a) times vb(b)) \
    = & -vb(a)dot (vb(c) times vb(b)) = -vb(b) dot (vb(a) times vb(c)) = -vb(c) dot (vb(b) times vb(a)).
  $

] <prop-triple-product>

We can interpret @prop-triple-product using a parallelepiped.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e2.svg", width: 42em)
]

Note that $vb(c) dot (vb(a) times vb(b)) = vb(a) dot (vb(b) times vb(c))$ is a signed volume:

- If $vb(a) dot (vb(b) times vb(c)) > 0$ , then $vb(a), vb(b), vb(c)$ constitute a right-handed set.

- $vb(a) dot (vb(b) times vb(c)) = 0$ iff $vb(a), vb(b), vb(c)$ are coplanar. _i.e._ one of the them is a #ponder("linear-algebra.linear-combination")[linear combination] of the other two.

=== #ponder("linear-algebra.vector-triple-product")[Vector Triple Product]


#definition("Vector triple product")[
  Consider $vb(a), vb(b), vb(c) in RR^3$. We call

  $ vb(a) times (vb(b) times vb(c)) $

  to be the #ponder("linear-algebra.vector-triple-product")[*vector triple product*] between $vb(a), vb(b), vb(c)$.
] <vector-triple-product>

#proposition[
  For $vb(a), vb(b), vb(c) in RR^3$, we have


  $ vb(a) times (vb(b) times vb(c)) = (vb(a) dot vb(c)) vb(b) - (vb(a) dot vb(b)) vb(c). $
] <prop-vec-triple-product>

Note that the #ponder("linear-algebra.vector-triple-product")[vector triple product] is not #ponder("algebra.commutativity-associativity-distributivity")[associative]. This is because

$ vb(a) times (vb(b) times vb(c)) = (vb(a) dot vb(c)) vb(b) - (vb(a) dot vb(b)) vb(c) $

but

$ (vb(a) times vb(b)) times vb(c) = (vb(a) dot vb(c)) vb(b) - (vb(b) dot vb(c)) vb(a). $

== Lines, Planes and Vector Equations

=== Lines


#proposition("Parametric form of a line")[
  Any point on a line through $vb(a)$ with direction $vb(u) !=0$ has position vector $vb(r)$ given by

  $ vb(r) = vb(a) + lambda vb(u). quad (lambda in RR) $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e3.svg", width: 20em)
  ]

  This form is equivalent to
  $ vb(u) times (vb(r) - vb(a)) = vb(0) <=> vb(u) times vb(r) = vb(b) $ where $vb(b)$ is a constant vector.
] <parametric-line>


=== Planes

#proposition("Parametric form of a plane")[

  Any point on a plane through $vb(a)$ can be described using directions $vb(u)$, $vb(v)$ where $vb(u) parallel.not vb(v)$, with the position vector

  $ vb(r) = vb(a) + lambda vb(u) + mu vb(v). quad (lambda, mu in RR) $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e4.svg", width: 28em)
  ]
] <parametric-plane>

The normal vector to the plane $vb(r) = vb(a) + lambda vb(u) + mu vb(v)$ is

$ vb(n) = vb(u) times vb(v). $

This normal vector is not a #ponder("linear-algebra.unit-vector")[unit vector] in general.

Then, we can write

$ vb(r) dot vb(n) = underbracket(vb(a) dot vb(n), k = "constant") <=> (vb(r)-vb(a)) dot vb(n) = 0 $

The component of $vb(r)$ along $vb(n)$ is

$ vu(n) dot vb(r) = (vb(n) dot vb(r))/(abs(vb(n)) ) = (k)/(abs(vb(n))) $

and $(k)/(|vb(n)|)$ is the perpendicular distance from the origin to the plane.

#remark[
  If $vb(a), vb(b), vb(c)$ lie in the plane, then we can write the equation of the plane by
  $ (vb(r) - vb(a)) dot [(vb(b) - vb(a)) times (vb(c) - vb(a))] = 0 $
]

#example("Intersection of a line and a plane")[
  Consider the point of intersection between
  $
     "Line:" quad & vb(u) times vb(r) = vb(u) times vb(a) quad & vb(a), vb(b) in RR^3 \
    "Plane:" quad & vb(n) dot vb(r) = vb(n) dot vb(b). \
  $

  The line equation can be re-written as $vb(r) times vb(u) = vb(a) times vb(u)$. Taking #ponder("linear-algebra.cross-product")[vector product] of this with $vb(n)$ gives
  $ (vb(r) times vb(u)) times vb(n) = (vb(a) times vb(u)) times vb(n) $
  Applying #ponder("linear-algebra.vector-triple-product")[vector triple product] property in @prop-vec-triple-product gives

  $
    (vb(r) times vb(u)) times vb(n) & = (vb(r) dot vb(n))vb(u) - (vb(u) dot vb(n)) vb(r) \
                                          & = (vb(b) dot vb(n)) vb(u) - (vb(u) dot vb(n)) vb(r). \
  $

  Hence
  $ (vb(u) dot vb(n)) vb(r) = (vb(b) dot vb(n)) vb(u) - (vb(a) times vb(u)) times vb(n). $

  If $vb(u) dot vb(n) != 0$, then we can compute

  $ vb(r) = ((vb(b) dot vb(n)) vb(u) - (vb(a) times vb(u)) times vb(n))/(vb(u) dot vb(n)) $

  as the position vector of the point of intersection.

  Otherwise, if $vb(u) dot vb(n) = 0$, $vb(u)$ is #ponder("linear-algebra.orthogonality")[orthogonal] to $vb(n)$. So either
  - the line is parallel to the plane and never intersects the plane, or
  - the line is contained within the plane.
]

#lecture-separator(lecture: 6, date: "2025-10-21")

#example("Shortest distance between two lines")[
  Consider two lines
  $
    L_1: vb(u_1) times (vb(r) - vb(a_1)) & =vb(0) \
    L_2: vb(u_2) times (vb(r) - vb(a_2)) & =vb(0).
  $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/dxe2.svg", width: 20em)
  ]

  Then, the shortest distance between $L_1$ and $L_2$ is attained at a line #ponder("linear-algebra.orthogonality")[perpendicular] to both lines, with direction $vb(u_1) times vb(u_2).$

  The shortest distance $s$ is then computed by projecting the vector $vb(a_2) - vb(a_1)$ onto the #ponder("linear-algebra.unit-vector")[unit vector] in the direction of $vb(u_1) times vb(u_2)$, giving

  $
    s = abs((vb(a_1) - vb(a_2)) dot (vb(u_1) times vb(u_2))/(abs(vb(u_1) times vb(u_2)))).
  $
]

=== Spheres

A sphere in $RR^3$ with centre $vb(0)$ and radius $r in RR$ is given by

$ Sigma = {vb(x) in RR^3: abs(vb(x)) = r, r>0}. $

In general, in $RR^n$, a hypersphere with center $vb(a) in RR^n$ and radius $r in RR$ is given by

$ Sigma = {vb(x) in RR^n: abs(vb(x) - vb(a)) = r, r>0}. $

=== Vector Equations


Our goal is to solve equations of the form

#set math.equation(numbering: "«1")

$ vb(r) + vb(a) times (vb(b) times vb(r)) = vb(c) $ <vector-eq>

#set math.equation(numbering: none)

for $vb(r)$, where $vb(a), vb(b), vb(c)$ are known vectors.

Using the #ponder("linear-algebra.vector-triple-product")[vector triple product] identity in @prop-vec-triple-product, we have

$ vb(a) times (vb(b) times vb(r)) = (vb(a) dot vb(r)) vb(b) - (vb(a) dot vb(b)) vb(r), $

so that @vector-eq becomes

#set math.equation(numbering: "«1")

$ vb(r) + (vb(a) dot vb(r)) vb(b) - (vb(a) dot vb(b)) vb(r) = vb(c) $ <vector-eq-2>

#set math.equation(numbering: none)

Taking the dot product of both sides of @vector-eq-2 with $vb(a)$ gives

$
  vb(a) dot vb(r) + (vb(a) dot vb(r)) (vb(a) dot vb(b)) - (vb(a) dot vb(b)) (vb(a) dot vb(r)) = vb(a) dot vb(c)
$

so we obtain
$ vb(a) dot vb(r) = vb(a) dot vb(c). $

Hence, substituting back into @vector-eq-2 gives

#set math.equation(numbering: "«1")
$
  vb(r) + (vb(a) dot vb(c)) vb(b) - (vb(a) dot vb(b)) vb(r) & = vb(c) \
                                        vb(r) (1-(vb(a) dot vb(b))) & = vb(c) - (vb(a) dot vb(c)) vb(b).
$ <vector-eq-3>
#set math.equation(numbering: none)

- If $vb(a) dot vb(b) != 1$, the there is a unique solution given by
$
  vb(r) & = (vb(c) - (vb(a) dot vb(c)) vb(b))/(1-(vb(a) dot vb(b))).
$

- If $vb(a) dot vb(b) = 1$, then by @vector-eq-3, either
  - there is no solution if $vb(c) - (vb(a) dot vb(c)) vb(b) != vb(0)$, or
  - there are infinitely many solutions if $vb(c) - (vb(a) dot vb(c)) vb(b) = vb(0)$. The set of solutions is given by our derived condition

    $ vb(a) dot vb(r) = vb(a) dot vb(c), $

    which represents a plane.

== Index Notation & Summation Conventions

Consider an #ponder("linear-algebra.orthonormal")[orthonormal] right-handed #ponder("linear-algebra.basis")[basis] ${vb(e_1), vb(e_2), vb(e_3)}$. We write vectors $vb(a), vb(b),$ _etc._ in terms of coordinates in this basis.

From now on, we will use indices $i, j, k$ that take values $1, 2, 3$.

#definition("Kronecker delta")[
  The #ponder("linear-algebra.kronecker-delta")[*Kronecker delta*] $delta_(i j)$ is defined as

  $
    delta_(i j) = cases(
      1 quad i=j,
      0 quad i != j
    ).
  $
] <kronecker-delta>

#proposition("Properties of Kronecker delta")[
  - It is symmetric: $delta_(i j) = delta_(j i)$. Note that we can write
  $ vb(e_i) dot vb(e_j) = delta_(i j). $

  - For vectors $vb(a), vb(b)$, we can write
  $ vb(a) dot vb(b) = sum_(i = 1)^(3) a_i b_i = sum_(i, j=1)^(3) delta_(i j) a_i b_j. $
]

#definition("Levi-Civita epsilon")[
  The #ponder("linear-algebra.levi-civita-symbol")[*Levi-Civita epsilon*] $epsilon_(i j k)$ is defined as

  $
    epsilon_(i j k) = cases(
      1 quad & (i, j, k) "is an even permutation of" (1, 2, 3),
      -1 quad & (i, j, k) "is an odd permutation of" (1, 2, 3),
      0 quad & "if any two indices are equal."
    ).
  $

  This is to say, that

  $
    epsilon_(1 2 3) & = epsilon_(2 3 1) = epsilon_(3 1 2) = 1 \
    epsilon_(3 2 1) & = epsilon_(1 3 2) = epsilon_(2 1 3) = -1 \
  $
  and all other combinations are zero.
] <def-levi-civita>

#proposition("Properties of Levi-Civita epsilon")[
  - It is antisymmetric. We can write
  $ vb(e_i) times vb(e_j) = sum_(k=1)^3 epsilon_(i j k) vb(e_k). $

  - For vectors $vb(a), vb(b)$, we can write
  $ vb(a) times vb(b) = sum_(i, j, k=1)^3 epsilon_(i j k) a_i b_j vb(e_k). $
]

=== #ponder("linear-algebra.einstein-summation-convention")[Einstein Summation Convention]

Now, we can use a more efficient notation.

#definition("Einstein summation convention")[
  In index notation, an index variable that appears twice in an expression are normally summed. To simplify notation, we omit the summation sign for repeated indices and sum over them. This is called the #ponder("linear-algebra.einstein-summation-convention")[*Einstein summation convention*].

  This notation follows the following rules:

  - If an index appears only once in an expression, it is a free index, so it must appear in every term of the equation, and can take any value. #fade[[We are not summing over it.]]

  - If an index appears twice in a term, it is a contracted index, and we sum over all its possible values. #fade[[We are summing over it.]]

  - No index can appear more than twice in a term.
] <einstein-summation-convention>

#example[
  Using #ponder("linear-algebra.einstein-summation-convention")[Einstein summation convention], we can write

  - $a_i delta_(i j) = a_j$ (which means $sum_(i=1)^(3) a_i delta_(i j) = a_j$)

  - $vb(a) dot vb(b) = delta_(i j) a_i b_j = a_i b_i$

  - $(vb(a) times vb(b))_i = epsilon_(i j k) a_j b_k$

  - $vb(a) dot (vb(b) times vb(c)) = epsilon_(i j k) a_i b_j c_k$

  - $delta_(i i) = 3$
]


#proposition("Important identities involving delta and epsilon")[
  For indices $i, j, k, l$ taking values $1, 2, 3$, we have

  1. $epsilon_(i j k) epsilon_(p q r) = delta_(i p) delta_(j q) delta_(k r) - delta_(j p) delta_(i q) delta_(k r) + delta_(j p) delta_(k q) delta_(i r) - delta_(k p) delta_(j q) delta_(i r) + delta_(k p) delta_(i q) delta_(j r) - delta_(i p) delta_(k q) delta_(j r).$
  2. $epsilon_(i j k) epsilon_(p q k) = delta_(i p) delta_(j q) - delta_(i q) delta_(j p)$
  3. $epsilon_(i j k) epsilon_(p j k) = 2 delta_(i p)$
  4. $epsilon_(i j k) epsilon_(i j k) = 6$
] <prop-ident-delta-epsilon>

=== Proofs Using Index Notation

We can now use index notation to prove the #ponder("linear-algebra.vector-triple-product")[vector triple product] identity.

#example("Proof of vector triple product identity")[

  We want to show that for $vb(a), vb(b), vb(c) in RR^3$,
  $ vb(a) times (vb(b) times vb(c)) = (vb(a) dot vb(c)) vb(b) - (vb(a) dot vb(b)) vb(c). $


  #proof[
    Using index notation, the $i$th component of the left-hand side is
    $
      (vb(a) times (vb(b) times vb(c)))_i & = epsilon_(i j k) a_j (vb(b) times vb(c))_k \
      & = epsilon_(i j k) a_j epsilon_(k p q) b_p c_q \
      & = (epsilon_(i j k) epsilon_(k p q)) a_j b_p c_q \
      & = (epsilon_(i j k) epsilon_(p q k)) a_j b_p c_q \
      & = (delta_(i p) delta_(j q) - delta_(i q) delta_(j p)) a_j b_p c_q quad "so" i = p "in the first term, and" j = q "in the second"\
      & = a_j c_j b_i - a_j b_j c_i \
      & = (vb(a) dot vb(c)) b_i - (vb(a) dot vb(b)) c_i. \
    $
    This is precisely the $i$th component of the right-hand side.
  ]

]

#lecture-separator(lecture: 7, date: "2025-10-23")

=== Spherical Trigonometry

With index notation, we can also consider *spherical trigonometry*.

#proposition[
  For $vb(a), vb(b), vb(c) in RR^3$, then

  $
    (vb(a) times vb(b)) dot (vb(b) times vb(c)) = (vb(a) dot vb(b))(vb(b) dot vb(c)) - (vb(a) dot vb(c)) abs(vb(b))^2.
  $
] <spherical-cosine-rule>

#proof[
  $
    "LHS" & = (vb(a) times vb(b))_i dot (vb(b) times vb(c))_i \
          & = epsilon_(i j k) a_j b_k epsilon_(i p q) b_p c_q \
          & = (epsilon_(i j k) epsilon_(i p q)) a_j b_k b_p c_q \
          & = (epsilon_(i j k) epsilon_(p q i)) a_j b_k b_p c_q \
          & = (delta_(j p) delta_(k q) - delta_(j q) delta_(k p)) a_j b_k b_p c_q \
          & = a_j b_j b_k c_k - a_j b_k b_k c_j \
          & = (vb(a) dot vb(b))(vb(b) dot vb(c)) - (vb(a) dot vb(c)) abs(vb(b))^2. \
  $
]

Now consider a unit sphere in $RR^3$ with centre $vb(O)$, and points $A, B, C$ on the surface of the sphere with position vectors $vb(a), vb(b), vb(c)$ respectively.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d4e1.svg", width: 16em)
]

The distance from $A$ to $B$, $delta(A, B)$, is an arc length on the sphere.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d4e2.svg", width: 22em)
]

In the same way, $abs(vb(a) times vb(b)) = sin delta(A, B)$.

Hence, we have

$
  cos alpha &= ((vb(a) times vb(b)) dot (vb(a) times vb(c)))/(abs(vb(a)times vb(b)) abs(vb(a) times vb(c)))\
  &= - ((vb(b) times vb(a)) dot (vb(a) times vb(c)))/(abs(vb(a)times vb(b)) abs(vb(a) times vb(c))) \
  &= ((vb(b) dot vb(c))abs(vb(a))^2-(vb(b) dot vb(a))(vb(a) dot vb(c)) )/(abs(vb(a)times vb(b)) abs(vb(a) times vb(c))). \
  cos alpha sin delta(A, B) sin delta(A, C) &= cos delta(B, C) - cos delta(B, A) cos delta(A, C). \
$

Which is the cosine rule for spherical triangles.

== Vectors in $RR^n$

We define the following operations for vectors in $RR^n$.

#definition([Addition and Scalar Multiplication in $RR^n$])[

  *Addition.* For $vb(a), vb(b) in RR^n$, we define
  $ vb(a) + vb(b) = vecrow(a_1 + b_1, a_2 + b_2, ..., a_n + b_n). $

  *Scalar Multiplication.* For $vb(a) in RR^n$ and $lambda in RR$, we define
  $ lambda vb(a) = vecrow(lambda a_1, lambda a_2, ..., lambda a_n). $
]

Any $vb(x) in RR^n$ can be written as
$ vb(x) = sum_(i=1)^(n) x_i vb(e_i) $
where ${vb(e_1), vb(e_2), ..., vb(e_n)}$ is the standard basis for $RR^n$ with $1$ in the $i$th position and $0$ elsewhere for $vb(e_i)$.

#definition([Dot Product in $RR^n$])[
  For $vb(a), vb(b) in RR^n$, we define their #ponder("linear-algebra.dot-product")[dot product] to be
  $ vb(a) dot vb(b) = sum_(i=1)^(n) a_i b_i. $
]

#proposition[
  $
    vb(e_i) dot vb(e_j) = delta_(i j).
  $
]

Hence, the components of $vb(x) = vecrow(x_1, x_2, ..., x_n)$ can be determined by

$ x_i = vb(x) dot vb(e_i). $

#notation[
  If we write vectors in $RR^n$ as columns, then for $vb(x), vb(y) in RR^n$, $vb(x)^TT$ and $vb(y)^TT$ denote their transposes, and that their #ponder("linear-algebra.inner-product")[inner product] can be written as
  $ vb(x) dot vb(y) = vb(x)^TT vb(y). $
]

=== Summation Convention <sec-summation-convention>

We have
$ vb(x) dot vb(y) = delta_(i j) x_i y_j = x_i y_i. $

We define $epsilon_(underbracket(i\, j\, dots\, l, n "indices"))$ to be the extension of the #ponder("linear-algebra.levi-civita-symbol")[Levi-Civita epsilon] (@def-levi-civita) to $n$ dimensions.

In $RR^2$, it can be used to define an additional #ponder("linear-algebra.dot-product")[scalar product]:

$ [vb(a), vb(b)] = epsilon_(i j) a_i b_j = a_1 b_2 - a_2 b_1 $

Geometrically, this represents the signed area of the parallelogram formed by $vb(a)$ and $vb(b)$.

#remark[
  One can compare this to $[vb(a), vb(b), vb(c)]$, which represents the signed volume of the parallelepiped formed by $vb(a), vb(b), vb(c)$ in $RR^3$.
]

== Vectors in $CC^n$

We define the following operations for vectors in $CC^n$.

#definition([Addition and Scalar Multiplication in $CC^n$])[

  *Addition.* For $vb(z), vb(w) in CC^n$, we define
  $ vb(z) + vb(w) = vecrow(z_1 + w_1, z_2 + w_2, ..., z_n + w_n). $

  *Scalar Multiplication.* For $vb(z) in CC^n$ and $lambda in CC$, we define
  $ lambda vb(z) = vecrow(lambda z_1, lambda z_2, ..., lambda z_n). $
  - If $lambda in RR$, then $CC^n$ is a #ponder("linear-algebra.vector-space")[real vector space].
  - If $lambda in CC$, then $CC^n$ is a #ponder("linear-algebra.vector-space")[complex vector space].
]

For any $vb(z) in CC^n$, we have

$ z_j = x_j + ii y_j. $


If we are only allowing real scalars, then we can write
$ vb(z) = sum_j (x_j + ii y_j) vb(e_j) = sum_j x_j vb(e_j) + sum_j y_j vb(f_j) = vb(x) + ii vb(y). $

where $vb(f_j)$ is defined to be the vector with $ii$ in the $j$th position of the imaginary part and $0$ elsewhere.

Note that ${vb(e_1), vb(e_2), ..., vb(e_n), vb(f_1), vb(f_2), ..., vb(f_n)}$ forms a basis for $CC^n$ as a #ponder("linear-algebra.vector-space")[real vector space], with #ponder("linear-algebra.dimension")[dimension] $2n$.


If we allow complex scalars, then we can define

$ vb(f_j) = ii vb(e_j), $

and thus $vb(z) = sum_j z_j vb(e_j)$. Hence $CC^n$ is a #ponder("linear-algebra.vector-space")[complex vector space] with #ponder("linear-algebra.dimension")[dimension] $n$. Note that ${vb(e_1), vb(e_2), ..., vb(e_n)}$ forms a basis for $CC^n$ as a #ponder("linear-algebra.vector-space")[complex vector space], with #ponder("linear-algebra.dimension")[dimension] $n$.

=== #ponder("linear-algebra.inner-product")[Inner Product] in $CC^n$

#definition([Inner Product in $CC^n$])[
  For $vb(z), vb(w) in CC^n$, we define their #ponder("linear-algebra.inner-product")[inner product] to be
  $ iprod(vb(z), vb(w)) = sum_(i=1)^(n) overline(z_i) w_i. $
]

#lecture-separator(lecture: 8, date: "2025-10-25")

#remark[
  This definition, including a complex conjugate, allows us to proceed with a definition for the #ponder("linear-algebra.norm")[norm].
]

==== Properties of the #ponder("linear-algebra.inner-product")[Inner Product]

#proposition([Properties of the inner product in $CC^n$])[
  1. *Hermitianity.* $iprod(vb(z), vb(w)) = overline(iprod(vb(w), vb(z)))$.

  2. *Linearity and anti-linearity.* $forall vb(z), vb(w) in CC^n, forall mu, mu', lambda, lambda' in CC$,

    - $iprod(vb(z), lambda vb(w') + lambda' vb(w)) = lambda iprod(vb(z), vb(w')) + lambda' iprod(vb(z), vb(w))$
    - $iprod(mu vb(z) + mu' vb(z'), vb(w)) = overline(mu) iprod(vb(z), vb(w)) + overline(mu') iprod(vb(z'), vb(w))$

  3. *Positive definite.* $iprod(vb(z), vb(z)) = sum_j abs(z_j)^2 >= 0$. Equality holds iff $vb(z) = vb(0)$.
]

#definition([Norm in $CC^n$])[
  For $vb(z) in CC^n$, we define its #ponder("linear-algebra.norm")[norm] to be
  $ abs(vb(z))^2 = iprod(vb(z), vb(z)) = sum_(i=1)^(n) abs(z_i)^2. $
]

#definition([Orthogonality in $CC^n$])[
  We say that $vb(z), vb(w) in CC^n$ are #ponder("linear-algebra.orthogonality")[*orthogonal*] if
  $ iprod(vb(z), vb(w)) = 0. $
]

#remark[
  The standard basis for $CC^n$ is #ponder("linear-algebra.orthonormal")[orthonormal], and
  $ iprod(vb(e_i), vb(e_j)) = delta_(i j). $
]

==== From Complex to Real #ponder("linear-algebra.inner-product")[Inner Products]

For $n = 1$, take $z, w in CC$, then

$
  (z, w) & = overline(z) w. \
$

Now, write $z = a_1 + ii a_2$ and $w = b_1 + ii b_2$ where $a_1, a_2, b_1, b_2 in RR$. Then we can identify $z$ and $w$ as vectors in $RR^2$, with $vb(a) = vecrow(a_1, a_2)$ and $vb(b) = vecrow(b_1, b_2)$ respectively.

Then,
$ overline(z) w = vb(a) dot vb(b) + ii [vb(a), vb(b)] $
where $[vb(a), vb(b)] = a_1 b_2 - a_2 b_1$ is product defined in @sec-summation-convention, recovers both #ponder("linear-algebra.dot-product")[scalar products] in $RR^2$.

== General Vector Spaces

#definition("Vector space")[
  A #ponder("linear-algebra.vector-space")[vector space] $V$ is a collection of vectors with two operations defined on them: vector addition and scalar multiplication, which satisfies the axioms in @def-vector-space-over-rr-cc.
]

- If the scalar field is $RR$, then $V$ is a #ponder("linear-algebra.vector-space")[*real vector space*].
- If the scalar field is $CC$, then $V$ is a #ponder("linear-algebra.vector-space")[*complex vector space*].

Consider a #ponder("linear-algebra.vector-space")[real vector space] $V$, and consider $vb(v_1), vb(v_2), ..., vb(v_r) in V$, we can write a #ponder("linear-algebra.linear-combination")[linear combination]:

$ lambda_1 vb(v_1) + lambda_2 vb(v_2) + ... + lambda_r vb(v_r) in V $ for any $lambda_1, lambda_2, ..., lambda_r in RR$.

#definition("Span")[
  The #ponder("linear-algebra.span")[*span*] of ${vb(v_1), ... vb(v_r)}$  is defined as

  $ span{vb(v_1), ..., vb(v_r)} = {sum_(i=1)^(r) lambda_i vb(v_i): lambda_i in RR}. $
] <span>

#definition("Subspace")[
  A #ponder("linear-algebra.subspace")[*subspace*] $U$ of a #ponder("linear-algebra.vector-space")[vector space] $V$ is a subset of $V$ that is also a #ponder("linear-algebra.vector-space")[vector space] under the same operations of addition and scalar multiplication defined on $V$.
] <subspace>

Equivalently, a non-empty subset $U subset.eq V$ is a #ponder("linear-algebra.subspace")[subspace] if it satisfies that for every $vb(u), vb(v) in U$ and $lambda, mu in RR$, we have $lambda vb(v) + mu vb(u) in U$.

In particular, for any $vb(v_1), vb(v_2), ..., vb(v_r) in V$, $ span{vb(v_1), ..., vb(v_r)} $ is a #ponder("linear-algebra.subspace")[subspace] of $V$.

#remark[
  The two trivial #ponder("linear-algebra.subspace")[subspaces] of any #ponder("linear-algebra.vector-space")[vector space] $V$ are ${vb(0)}$ and $V$ itself.
]

=== #ponder("linear-algebra.linear-independence")[Linear Independence and Dependence]

#definition("Linear independence and dependence")[
  Consider a #ponder("linear-algebra.vector-space")[vector space] $V$, and vectors $vb(v_1), vb(v_2), ..., vb(v_r) in V$. Consider a #ponder("linear-algebra.linear-combination")[linear combination] of these vectors:
  $ lambda_1 vb(v_1) + lambda_2 vb(v_2) + ... + lambda_r vb(v_r) quad lambda_1, ..., lambda_r in RR "or" CC. $

  If $lambda_1 vb(v_1) + lambda_2 vb(v_2) + ... + lambda_r vb(v_r) = vb(0)$ implies $lambda_1 = lambda_2 = ... = lambda_r = 0$, then the vectors are #ponder("linear-algebra.linear-independence")[*linearly independent*].

  If there exists $lambda_1, lambda_2, ..., lambda_r$, not all zero, such that $lambda_1 vb(v_1) + lambda_2 vb(v_2) + ... + lambda_r vb(v_r) = vb(0)$, then the vectors are #ponder("linear-algebra.linear-independence")[*linearly dependent*].
] <linear-independence>

#remark[

  - A set of vectors ${vb(v_1), vb(v_2), ..., vb(v_r)}$ is #ponder("linear-algebra.linear-independence")[linearly dependent] iff one of the vectors can be expressed as a #ponder("linear-algebra.linear-combination")[linear combination] of the others.

  - In $RR^3$, $vb(a), vb(b), vb(c)$ are #ponder("linear-algebra.linear-independence")[linearly independent] iff

    $ vb(a) dot (vb(b) times vb(c)) != 0. $

    This can be geometrically interpreted as the vectors not being coplanar #fade[[the LHS represents the volume of the parallelepiped spanned by the vectors]].
]

#example[
  1. ${vec(1, 0), vec(0, 1), vec(0, 2)}$ in $RR^2$ is #ponder("linear-algebra.linear-independence")[linearly dependent], noting that $2 vec(0, 1) = vec(0, 2)$.

  2. ${vec(1, 0), vec(0, 1)}$ in $RR^2$ is #ponder("linear-algebra.linear-independence")[linearly independent].

  3. Any set containing $vb(0)$ is #ponder("linear-algebra.linear-independence")[linearly dependent].
]

=== #ponder("linear-algebra.inner-product")[Inner Products]

#definition("Inner product")[
  An #ponder("linear-algebra.inner-product")[*inner product*] on a #ponder("linear-algebra.vector-space")[vector space] $V$ is a function that assigns to each pair of vectors $vb(v), vb(w) in V$ a scalar $iprod(vb(v), vb(w)) in RR "or" CC$, satisfying

  // TODO: how do you deal with the complement beyond RR and CC?

  1. *Hermitianity*: $iprod(vb(v), vb(w)) = overline(iprod(vb(w), vb(v)))$.

  2. *Linearity and anti-linearity*: $forall vb(u), vb(v), vb(w) in V, forall mu, mu', lambda, lambda' in CC "or" RR$,

    - $iprod(vb(v), lambda vb(w) + lambda' vb(w')) = lambda iprod(vb(v), vb(w)) + lambda' iprod(vb(v), vb(w'))$
    - $iprod(mu vb(v) + mu' vb(v'), vb(w)) = overline(mu) iprod(vb(v), vb(w)) + overline(mu') iprod(vb(v'), vb(w))$

  3. *Positive definiteness*: $iprod(vb(v), vb(v)) >= 0$ with equality iff $vb(v) = vb(0)$.
]

#definition("Orthogonality")[
  We say that $vb(v), vb(w) in V$ are #ponder("linear-algebra.orthogonality")[*orthogonal*] if
  $ iprod(vb(v), vb(w)) = 0. $
]

#proposition[
  If vectors $vb(v_1), vb(v_2), ..., vb(v_n) in V$ are non-zero and #ponder("linear-algebra.orthogonality")[orthogonal], then they are #ponder("linear-algebra.linear-independence")[linearly independent].
]

#proof[
  Suppose for contradiction that the vectors are #ponder("linear-algebra.linear-independence")[linearly dependent]. Then there exist scalars $alpha_1, alpha_2, ..., alpha_n in RR "or" CC$, not all zero, such that

  $ sum_i alpha_i vb(v_i) & = vb(0). $

  Then

  $
    0 = iprod(vb(v_j), sum_i alpha_i vb(v_i)) & = sum_i alpha_i iprod(vb(v_j), vb(v_i)) quad "by linearity" \
                                             & = alpha_j iprod(vb(v_j), vb(v_j)) quad "by orthogonality" \
                                             & = alpha_j abs(vb(v_j))^2.
  $

  By positive definiteness, $abs(vb(v_j))^2 > 0$, so we must have $alpha_j = 0$. This holds for all $j$, contradicting our assumption that not all $alpha_i$ are zero.
]

=== #ponder("linear-algebra.basis")[Basis] and #ponder("linear-algebra.dimension")[Dimension]

#definition("Basis")[
  A #ponder("linear-algebra.basis")[*basis*] of a #ponder("linear-algebra.vector-space")[vector space] $V$ is a set of vectors $B={vb(v_1), vb(v_2), ..., vb(v_r)}$ in $V$ that

  1. $B$ #ponder("linear-algebra.spanning-set")[spans] $V$,

  2. the vectors in $B$ are #ponder("linear-algebra.linear-independence")[linearly independent].

  #remark[
    This implies that the coefficients in the #ponder("linear-algebra.linear-combination")[linear combination] $lambda_1 vb(v_1) + lambda_2 vb(v_2) + ... + lambda_r vb(v_r)$ are unique for any vector in $V$. The set of coefficients are called the *components* of the vector with respect to the #ponder("linear-algebra.basis")[basis] $B$.
  ]
] <basis>

#theorem[
  If ${vb(e_1), vb(e_2) ,..., vb(e_n)}$ and ${vb(f_1), vb(f_2), ..., vb(f_m)}$ are #ponder("linear-algebra.basis")[bases] for the same #ponder("linear-algebra.vector-space")[vector space] $V$, then $n = m$. The number $n$ is called the #ponder("linear-algebra.dimension")[*dimension*] of $V$.
] <dimension>

#proposition[
  If $V$ is a #ponder("linear-algebra.vector-space")[vector space] of #ponder("linear-algebra.dimension")[dimension] $n$. Then,

  1. if $Y = {vb(w_1), ..., vb(w_m)}$ #ponder("linear-algebra.spanning-set")[spans] $V$, and that $m > n$, we can remove vectors from $Y$ to get a #ponder("linear-algebra.basis")[basis].

  2. If $Z = {vb(u_1), ..., vb(u_k)}$ is a #ponder("linear-algebra.linear-independence")[linearly independent] set in $V$ with $k < n$, we can add vectors to $Z$ to get a #ponder("linear-algebra.basis")[basis].
]
