#import "../prelude.typ": *

#lecture-separator(lecture: 3, date: "2025-10-14")

= Vectors

A vector can be specified by a (positive) magnitude and a direction in space.

== Introduction on Vectors

We can represent a vector as a line segment between two points $A$ and $B$, and we write $bold(v)=arrow(A B).$ The vector $bold(v)$ has length $abs(bold(v))$ and direction from $A$ to $B$.

If we choose $O$ as the origin, then point $A$ has position vector $bold(a)=arrow(O A)$.

#definition("Vector space over reals and complex numbers")[
  A #ponder("linear-algebra.vector-space")[*vector space*] $V$ over $CC$ or $RR$ is a set of abstract vectors ${bold(v)}$ equipped with operations of

  - vector addition $plus.o:V times V->V$, and
  - scalar multiplication $times.o:RR times V -> V$

  that satisfy the following axioms:

  _Vector addition axioms_
  1. #ponder("algebra.commutativity-associativity-distributivity")[*Commutivity*]: $bold(u) plus.o bold(v)=bold(v) plus.o bold(u)$.
  2. #ponder("algebra.commutativity-associativity-distributivity")[*Associativity*]: $(bold(u) plus.o bold(v)) plus.o bold(w)=bold(u) plus.o (bold(v) plus.o bold(w))$.
  3. *Additive identity*: $exists bold(0) in V$ such that $0 plus.o bold(v) = bold(v)$ for all $bold(v) in V$.
  4. #ponder("algebra.inverse-element")[*Additive inverse*]: $forall bold(v) in V$, $exists (-bold(v)) in V$ such that $bold(v) plus.o bold((-v))=bold(0)$.

  _Scalar multiplication axioms_
  1. $lambda times.o (bold(u) plus.o bold(v))=(lambda times.o bold(u)) plus.o (lambda times.o bold(v))$.
  2. $(lambda plus.o mu) times.o bold(v)=(lambda times.o bold(v)) plus.o (mu times.o bold(v))$.
  3. $lambda times.o (mu times.o bold(v))=(lambda mu) times.o bold(v)$.
  4. $1 times.o bold(v)=bold(v)$.
] <def-vector-space-over-rr-cc>

#notation[
  Usually, we omit the circles of $plus.o$ and $times.o$, and write then as if they were $+$ and $times$.
]

#remark[
  - Vectors under $+$ form an #ponder("algebra.abelian-group")[Abelian group].
]

#example[
  In $RR^3$, we define the two operations as follows:

  - *Vector addition.* Consider $bold(a)$ and $bold(b)$ the position vectors of two points $A, B$ respectively. We can construct a parallelogram and then do compositions of two vectors, such that $bold(a)+bold(b)=bold(c)$.


    #align(center)[
      #dynamic-svg("/part-ia/vectors-and-matrices/media/d2e1.svg", width: 12em)
    ]

  - *Scalar multiplicaton.* Given $bold(a)$ the position vector of a point $A$, and $lambda in RR$, $lambda bold(a)$ is a position vector of a point on line $O A$, with length $abs(lambda bold(a))=abs(lambda) abs(bold(a))$, in the direction as shown follows.


    #align(center)[
      #dynamic-svg("/part-ia/vectors-and-matrices/media/d2e2.svg", width: 24em)
    ]

]

#definition("Unit vector")[
  A #ponder("linear-algebra.unit-vector")[*unit vector*] is a vector with length $1$. We denote it as $hat(bold(v))$.
] <unit-vector>

#definition("Linear combination")[
  Consider two vectors $bold(a), bold(b)$ and scalars $alpha, beta in RR$. Then

  $ alpha bold(a) + beta bold(b) $

  is a #ponder("linear-algebra.linear-combination")[*linear combination*] of $bold(a)$ and $bold(b)$.
] <linear-combination>

In general, we denote all possible #ponder("linear-algebra.linear-combination")[linear combinations] of two given vectors $bold(a), bold(b)$ by

$ {alpha bold(a) + beta bold(b):alpha beta in RR} = upright(s p a n) {bold(a), bold(b)}. $
This is called that #ponder("linear-algebra.span")[*span*] of ${bold(a), bold(b)}$.

This extends to any number of vectors (possibly more than two).

#definition("Parallel")[
  We say that $bold(a)$ and $bold(b)$ are #ponder("linear-algebra.parallel-vectors")[*parallel*], denoted $bold(a) parallel bold(b)$, if $bold(a)=lambda bold(b)$ (or equivalently $bold(b) = lambda bold(a)$) for some $lambda in RR$. We allow $lambda = 0$, so $bold(0) parallel bold(v)$ for any vector $bold(v)$.
] <parallel-vectors>

#remark[
  If $bold(a) parallel.not bold(b)$, then $upright(s p a n) {bold(a), bold(b)} = upright(s p a n) {bold(a), bold(a)-bold(b)}$ is a plane through $O, A, B$.
]

== #ponder("linear-algebra.dot-product")[Scalar Product] (Dot Product)

#definition([Scalar product in $RR^n$])[
  For two vectors $bold(a), bold(b)$ in $RR^n$, and $theta$ the solid angle between them. Then the #ponder("linear-algebra.dot-product")[*scalar* product] of $bold(a)$ and $bold(b)$ is given by:

  $ bold(a) dot bold(b) = abs(bold(a))abs(bold(b)) cos theta. $

  Intuitively, this is the product of the parts in $bold(a)$ and $bold(b)$ which are parallel.
] <rn-scalar-product>

We have some interesting results on #ponder("linear-algebra.dot-product")[scalar products] in general.

#proposition[
  If $bold(a), bold(b), bold(c)$ are vectors and $lambda in RR$, we have

  - $bold(a) dot bold(b) = bold(b) dot bold(a)$
  - $bold(a) dot bold(a) = abs(bold(a))^2 >= 0$, and $abs(bold(a))=&0$ if and only if $bold(a) = bold(0)$
  - $(lambda bold(a)) dot bold(b) = lambda(bold(a) dot bold(b)) = bold(a) dot (lambda bold(b))$
  - $bold(a) dot (bold(b) + bold(c)) = bold(a) dot bold(b) + bold(a) dot bold(c)$
]

#definition("Perpendicularity")[

  Moreover, we say that $bold(a)$ and $bold(b)$ are #ponder("linear-algebra.orthogonality")[*orthogonal*  or *perpendicular*] and denote it by $bold(a) perp bold(b)$ if
  $ bold(a) dot bold(b) = 0. $

  In this case, we allow for $bold(a)$ or $bold(b)$ to be $bold(0)$.
] <orthogonality>

Using the dot product we can write the projection of $bold(b)$ onto $bold(a)$ as

$ bold(hat(a)) abs(bold(b)) cos theta= (bold(hat(a)) dot bold(b)) bold(hat(a)). $


We can actually derive @rn-scalar-product.

#proposition[
  For $x, y in RR^3$, define $theta in [0, ppi]$ to be the solid angle between them. Then
  $ bold(x) dot bold(y) = |bold(x)| |bold(y)|cos theta. $
] <lem-2-1>

#proof[
  #set math.equation(numbering: "«1")
  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/dxe1.svg", width: 10em)
  ]
  For any $x, y in RR^3$, we have
  $ |bold(x)-bold(y)|^2 = |bold(x)|^2+|bold(y)|^2-2|bold(x)| |bold(y)| cos theta quad "by cosine rule." $ <eq1>
  But from the definition of #ponder("linear-algebra.dot-product")[scalar product],
  $
    |bold(x) - bold(y)|^2 & = (bold(x) - bold(y)) dot (bold(x) - bold(y)) \
                          & = |bold(x)|^2+|bold(y)|^2-2 bold(x) dot bold(y). \
  $  <eq2>

  #set math.equation(numbering: none)
  By comparing @eq1 and @eq2, we get $bold(x) dot bold(y)=|bold(x)| |bold(y)| cos theta.$
]

#definition("Real inner product")[
  We say, for #ponder("linear-algebra.vector-space")[vector space] $V$, a map $chevron.l dot , dot chevron.r:V times V->RR$ is called an #ponder("linear-algebra.inner-product")[inner product] if

  1. $chevron.l alpha bold(x) + beta bold(y), bold(z) chevron.r = alpha chevron.l bold(x), bold(z) chevron.r+beta chevron.l bold(y), bold(z) chevron.r$.
  2. $chevron.l bold(x), bold(y) chevron.r = chevron.l bold(y), bold(x) chevron.r$.
  3. $chevron.l bold(x), bold(x) chevron.r > 0$ for $bold(x) != bold(0)$.
] <inner-product>

#definition("Norm")[
  Given the #ponder("linear-algebra.inner-product")[inner product] on $V$, we define the #ponder("linear-algebra.norm")[norm] $| dot |:V->[0, oo]$ to be $||bold(x)||=sqrt(chevron.l bold(x)\, bold(x) chevron.r)$.
] <norm>

#lecture-separator(lecture: 4, date: "2025-10-16")

We can now form an inequality that we will encounter various times in various forms in later courses, but here we shall see a simplest formation of it.

#theorem("Cauchy-Schwarz inequality")[
  For all $bold(x), bold(y) in RR^n$, then
  $ abs(bold(x) dot bold(y))<= abs(bold(x))abs(bold(y)). $
] <cauchy-schwarz>

#proof[
  Consider the expression $abs(bold(x)-lambda bold(y))^2$, where $lambda in RR$. Then

  $
    abs(bold(x)-lambda bold(y))^2 &>= 0 \
    (bold(x)-lambda bold(y)) dot (bold(x)-lambda bold(y)) &>=0\
    abs(bold(x))^2 + lambda^2 abs(bold(y))^2 - 2 lambda bold(x) dot bold(y) &>= 0 \
    lambda^2 abs(bold(y))^2- 2 lambda bold(x) dot bold(y) + abs(bold(x))^2 &>= 0 & quad "by rearranging as a quadratic of" lambda\
    4 (bold(x) dot bold(y))^2 - 4 abs(bold(x))^2 abs(bold(y))^2 &<= 0 & quad "by taking discriminant"\
    abs(bold(x) dot bold(y)) &<= abs(bold(x)) abs(bold(y)) .
  $
]

Here are some important observations for the #ponder("linear-algebra.cauchy-schwarz-inequality")[Cauchy-Schwarz inequality].

#remark[

  - This inequality holds for all #ponder("linear-algebra.dot-product")[scalar product] in any #ponder("linear-algebra.vector-space")[real vector space].

  - The equality holds if and only if $bold(x) = lambda bold(y)$ or $bold(y) = lambda bold(x)$ for some $lambda in RR$.

  - @rn-scalar-product is now well-defined since #ponder("linear-algebra.cauchy-schwarz-inequality")[Cauchy-Schwarz] ensures that $-1 <= cos theta <= 1$.
]

#corollary("Triangle inequality")[
  For $bold(x), bold(y) in RR^n$, we have
  $ abs(bold(x) + bold(y)) <= abs(bold(x)) + abs(bold(y)). $
] <triangle-inequality>

#proof[
  We have
  $
    abs(bold(x)+bold(y))^2 & = (bold(x)+bold(y))dot (bold(x)+bold(y)) \
                           & = abs(bold(x))^2+abs(bold(y))^2 + 2bold(x) dot bold(y) \
                           & <= abs(bold(x))^2+abs(bold(y))^2+2abs(bold(x))abs(bold(y)) \
                           & = (abs(bold(x))+abs(bold(y)) )^2 \
  $
  The result then follows.
]

== #ponder("linear-algebra.orthonormal")[Orthonormal] Bases

#definition("Orthonormal")[
  Vectors are said to be #ponder("linear-algebra.orthonormal")[*orthonormal*] if they are #ponder("linear-algebra.orthogonality")[orthogonal] #ponder("linear-algebra.unit-vector")[unit vectors].
] <orthonormal>

Consider $RR^3$, and consider vectors $bold(e_1)$, $bold(e_2)$ , $bold(e_3)$ that are #ponder("linear-algebra.orthonormal")[orthonormal]. Then we have

$
  bold(e_i) dot bold(e_j) =cases(
    1 quad i=j,
    0 quad i !=j
  ) quad "for" i, j = 1, 2, 3.
$

This is equivalent to choosing Cartesian axes along these directions. We need a few extra definitions to describe this.

#definition("Spanning")[
  For a #ponder("linear-algebra.vector-space")[vector space] $V$, we say a subset $S={bold(u_1), ..., bold(u_p)}$ is a #ponder("linear-algebra.spanning-set")[*spanning set*] for $V$ if each of $bold(v) in V$ can be written as a #ponder("linear-algebra.linear-combination")[linear combination] of the vectors in $S$.
] <spanning-set>

#definition("Linearly independent")[
  We say the set $T = {bold(v_1), ..., bold(v_q)}$ is #ponder("linear-algebra.linear-independence")[*linearly independent*] if
  $ sum_(i=1)^(q) lambda_i bold(v_i)=0 <=> lambda_i = 0 "for" i = 1, ..., q. $

]

#definition("Basis")[
  A set of vectors $B={bold(u_1), ..., bold(u_2)}$ in $V$ is called a #ponder("linear-algebra.basis")[*basis*] if it is #ponder("linear-algebra.spanning-set")[spanning] and #ponder("linear-algebra.linear-independence")[linearly independent].
]

Hence, ${bold(e_1), bold(e_2), bold(e_3)}$ is an #ponder("linear-algebra.orthonormal")[orthonormal] #ponder("linear-algebra.basis")[basis].

We can therefore denote $bold(a)$ in the following ways:

$ bold(a) = (a_1, a_2, a_3) quad "or" quad bold(a)=vec(a_1, a_2, a_3). $

Now, for $bold(a), bold(b) in RR^3$, we have

$
  bold(a) dot bold(b) &= (a_1 bold(e_1) + a_2 bold(e_2) + a_3 bold(e_3)) dot (b_1 bold(e_1) +b_2 bold(e_2) + b_3 bold(e_3)) \
  &= a_1b_1 + a_2b_2 + a_3b_3. \
$

In particular, we can derive the Pythagorean rule, since
$ bold(a) dot bold(a) = abs(bold(a))^2 = a_1^2 + a_2^2 + a_3^2. $

For the canonical basis of $RR^3$, the one that we use for the representation in terms of row or column vector,
$ bold(e_1)=(1, 0, 0) quad bold(e_2)=(0, 1, 0) quad bold(e_3)=(0, 0, 1), $
we can represent the vectors by
$ bold(hat(i)), bold(hat(j)), bold(hat(k)) $
respectively.

== #ponder("linear-algebra.cross-product")[Vector Product] (Cross Product) in $RR^3$

#definition([Vector Product in $RR^3$])[
  Consider $bold(a), bold(b) in RR^3$. Their #ponder("linear-algebra.cross-product")[vector product] is defined by
  $ bold(a) times bold(b) = abs(bold(a))abs(bold(b)) bold(hat(n)) sin theta $
  where $bold(hat(n))$ is a #ponder("linear-algebra.unit-vector")[unit vector] that is #ponder("linear-algebra.orthogonality")[perpendicular] to both $bold(a)$ and $bold(b)$, and $(bold(a), bold(b), bold(hat(n)))$ is right-handed.
] <cross-product>

#remark[

  1. If we change $theta$ to $2ppi - theta$, we obtain $-bold(hat(n))$ in the definition of $bold(a) times bold(b)$ instead.

  2. $bold(hat(n))$ is not defined if $bold(a) parallel bold(b)$. However, we immediately have $bold(a) times bold(b) = bold(0)$.

  3. $theta$ is not defined if $abs(bold(a))=0$ or $abs(bold(b)) = 0$.
]

#notation[
  $bold(a) and bold(b) equiv bold(a) times bold(b)$ for #ponder("linear-algebra.cross-product")[vector product].
]

#proposition("Properties of vector product")[
  If $bold(a), bold(b), bold(c)$ are vectors in $RR^3$, then we have

  1. $bold(a) times bold(b) = -bold(b)times bold(a)$.
  2. $bold(a) times bold(a)=bold(0)$.
  3. $bold(a)times bold(b)=bold(0) <=> bold(a) = lambda bold(b)$ for some $lambda in RR$, or either vector is the zero vector.
  4. $(lambda bold(a))times bold(b) = lambda(bold(a) times bold(b)) = bold(a) times (lambda bold(b))$.
  5. $bold(a) times (bold(b) + bold(c)) = bold(a) times bold(b) + bold(a) times bold(c)$.
  6. $bold(a) dot (bold(a) times bold(b)) =bold(b) dot (bold(a) times bold(b)) = 0$.
]

#proposition("Geometric interpretations of vector product")[
  For two vectors $bold(a), bold(b) in RR^3$, then $abs(bold(a) times bold(b))$ is the area of the parallelogram formed by $bold(a)$ and $bold(b)$.

  If $bold(a) = arrow(O A)$ and $bold(b) = arrow(O B)$, then the area of the triangle $O A B$ is given by $(1)/(2) abs(bold(a) times bold(b))$.
]

#lecture-separator(lecture: 5, date: "2025-10-18")

#proposition("Alternative geometric interpretations of vector product")[
  Fix a vector $bold(a)$ and consider $bold(x) perp bold(a)$. Then, computing $bold(a) times bold(x)$ gives a vector that scales $bold(x)$ by $abs(bold(a))$ and rotates it by $(pi)/(2)$ in a plane that is #ponder("linear-algebra.orthogonality")[orthogonal] to $bold(a)$.

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e1.svg", width: 24em)
  ]
]

=== Component Expressions

Let $bold(e_1) = (1, 0, 0), bold(e_2)=(0, 1, 0), bold(e_3)=(0, 0, 1)$. Then

$
  bold(e_1) times bold(e_2) & = bold(e_3)=-bold(e_2)times bold(e_1) \
  bold(e_2) times bold(e_3) & = bold(e_1)=-bold(e_3)times bold(e_2) \
  bold(e_3) times bold(e_1) & = bold(e_2)=-bold(e_1)times bold(e_3) \
$

Consider $bold(a)=(a_1, a_2, a_3)$ and $bold(b)=(b_1, b_2, b_3)$. We have

$
  bold(a) times bold(b) = & (a_2b_3-a_3b_2)bold(e_1) \
                          & + (a_3b_1-a_2b_3) bold(e_2) \
                          & + (a_1b_2-a_2b_1) bold(e_3).
$

This is also equivalent to

$
  bold(a)times bold(b) =mat(delim: "|", bold(hat(i)), bold(hat(j)), bold(hat(k)); a_1, a_2, a_3; b_1, b_2, b_3).
$

== Triple Products

=== #ponder("linear-algebra.scalar-triple-product")[Scalar Triple Product]

#definition("Scalar triple product")[
  Consider $bold(a), bold(b), bold(c) in RR^3$. We write

  $ [bold(a), bold(b), bold(c)] = bold(a) dot (bold(b) times bold(c)) $

  to be the #ponder("linear-algebra.scalar-triple-product")[*scalar triple product*] between $bold(a), bold(b), bold(c)$.
] <scalar-triple-product>

#proposition[
  For $bold(a), bold(b), bold(c) in RR^3$, we have

  $
      & bold(a) dot (bold(b) times bold(c)) = bold(b) dot (bold(c) times bold(a)) = bold(c) dot (bold(a) times bold(b)) \
    = & -bold(a)dot (bold(c) times bold(b)) = -bold(b) dot (bold(a) times bold(c)) = -bold(c) dot (bold(b) times bold(a)).
  $

] <prop-triple-product>

We can interpret @prop-triple-product using a parallelpiped.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e2.svg", width: 42em)
]

Note that $bold(c) dot (bold(a) times bold(b)) = bold(a) dot (bold(b) times bold(c))$ is a signed volume:

- If $bold(a) dot (bold(b) times bold(c)) > 0$ , then $bold(a), bold(b), bold(c)$ constitute a right-handed set.

- $bold(a) dot (bold(b) times bold(c)) = 0$ iff $bold(a), bold(b), bold(c)$ are coplanar. _i.e._ one of the them is a #ponder("linear-algebra.linear-combination")[linear combination] of the other two.

=== #ponder("linear-algebra.vector-triple-product")[Vector Triple Product]


#definition("Vector triple product")[
  Consider $bold(a), bold(b), bold(c) in RR^3$. We call

  $ bold(a) times (bold(b) times bold(c)) $

  to be the #ponder("linear-algebra.vector-triple-product")[*vector triple product*] between $bold(a), bold(b), bold(c)$.
] <vector-triple-product>

#proposition[
  For $bold(a), bold(b), bold(c) in RR^3$, we have


  $ bold(a) times (bold(b) times bold(c)) = (bold(a) dot bold(c)) bold(b) - (bold(a) dot bold(b)) bold(c). $
] <prop-vec-triple-product>

Note that the #ponder("linear-algebra.vector-triple-product")[vector triple product] is not #ponder("algebra.commutativity-associativity-distributivity")[associative]. This is because

$ bold(a) times (bold(b) times bold(c)) = (bold(a) dot bold(c)) bold(b) - (bold(a) dot bold(b)) bold(c) $

but

$ (bold(a) times bold(b)) times bold(c) = (bold(a) dot bold(c)) bold(b) - (bold(b) dot bold(c)) bold(a). $

== Lines, Planes and Vector Equations

=== Lines


#proposition("Parametric form of a line")[
  Any point on a line through $bold(a)$ with direction $bold(u) !=0$ has position vector $bold(r)$ given by

  $ bold(r) = bold(a) + lambda bold(u). quad (lambda in RR) $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e3.svg", width: 20em)
  ]

  This form is equivalent to
  $ bold(u) times (bold(c) - bold(a)) = bold(0) <=> bold(u) times bold(r) = bold(b) $ where $bold(b)$ is a constant vector.
] <parametric-line>


=== Planes

#proposition("Parametric form of a plane")[

  Any point on a plane through $bold(a)$ can be described using directions $bold(u)$, $bold(v)$ where $bold(u) parallel.not bold(v)$, with the position vector

  $ bold(r) = bold(a) + lambda bold(u) + mu bold(v). quad (lambda, mu in RR) $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/d3e4.svg", width: 28em)
  ]
] <parametric-plane>

The normal vector to the plane $bold(r) = bold(a) + lambda bold(u) + mu bold(v)$ is

$ bold(n) = bold(u) times bold(v). $

This normal vector is not a #ponder("linear-algebra.unit-vector")[unit vector] in general.

Then, we can write

$ bold(r) dot bold(n) = underbracket(bold(a) dot bold(n), k = "constant") <=> (bold(r)-bold(a)) dot bold(n) = 0 $

The component of $bold(r)$ along $bold(n)$ is

$ bold(hat(n)) dot bold(r) = (bold(n) dot bold(r))/(abs(bold(n)) ) = (k)/(abs(bold(n))) $

and $(k)/(|bold(n)|)$ is the perpendicular distance from the origin to the plane.

#remark[
  If $bold(a), bold(b), bold(c)$ lie in the plane, then we can write the equation of the plane by
  $ (bold(r) - bold(a)) dot [(bold(b) - bold(a)) times (bold(c) - bold(a))] = 0 $
]

#example("Intersection of a line and a plane")[
  Consider the point of intersection between
  $
     "Line:" quad & bold(u) times bold(r) = bold(u) times bold(a) quad & bold(a), bold(b) in RR^3 \
    "Plane:" quad & bold(n) dot bold(r) = bold(n) dot bold(b). \
  $

  The line equation can be re-written as $bold(r) times bold(u) = bold(a) times bold(u)$. Taking #ponder("linear-algebra.cross-product")[vector product] of this with $bold(n)$ gives
  $ (bold(r) times bold(u)) times bold(n) = (bold(a) times bold(u)) times bold(n) $
  Applying #ponder("linear-algebra.vector-triple-product")[vector triple product] property in @prop-vec-triple-product gives

  $
    (bold(r) times bold(u)) times bold(n) & = (bold(r) dot bold(n))bold(u) - (bold(u) dot bold(b)) bold(r) \
                                          & = (bold(b) dot bold(n)) bold(u) - (bold(u) dot bold(n)) bold(r). \
  $

  Hence
  $ (bold(u) dot bold(n)) bold(r) = (bold(b) dot bold(n)) bold(u) - (bold(a) times bold(u)) times bold(n). $

  If $bold(u) dot bold(n) != 0$, then we can compute

  $ bold(r) = ((bold(b) dot bold(n)) bold(u) - (bold(a) times bold(u)) times bold(n))/(bold(u) dot bold(n)) $

  as the position vector of the point of intersection.

  Otherwise, if $bold(u) dot bold(n) = 0$, $bold(u)$ is #ponder("linear-algebra.orthogonality")[orthogonal] to $bold(n)$. So either
  - the line is parallel to the plane and never intersects the plane, or
  - the line is contained within the plane.
]

#lecture-separator(lecture: 6, date: "2025-10-21")

#example("Shortest distance between two lines")[
  Consider two lines
  $
    L_1: bold(u_1) times (bold(r) - bold(a_1)) & =bold(0) \
    L_2: bold(u_2) times (bold(r) - bold(a_2)) & =bold(0).
  $

  #align(center)[
    #dynamic-svg("/part-ia/vectors-and-matrices/media/dxe2.svg", width: 20em)
  ]

  Then, the shortest distance between $L_1$ and $L_2$ is attained at a line #ponder("linear-algebra.orthogonality")[perpendicular] to both lines, with direction $bold(u_1) times bold(u_2).$

  The shortest distance $s$ is then computed by projecting the vector $bold(a_2) - bold(a_1)$ onto the #ponder("linear-algebra.unit-vector")[unit vector] in the direction of $bold(u_1) times bold(u_2)$, giving

  $
    s = abs((bold(a_1) - bold(a_2)) dot (bold(u_1) times bold(u_2))/(abs(bold(u_1) times bold(u_2)))).
  $
]

=== Spheres

A sphere in $RR^3$ with centre $bold(0)$ and radius $r in RR$ is given by

$ Sigma = {bold(x) in RR^3: abs(bold(x)) = r, r>0}. $

In general, in $RR^n$, a hypersphere with center $bold(a) in RR^n$ and radius $r in RR$ is given by

$ Sigma = {bold(x) in RR^n: abs(bold(x) - bold(a)) = r, r>0}. $

=== Vector Equations


Our goal is to solve equations of the form

#set math.equation(numbering: "«1")

$ bold(r) + bold(a) times (bold(b) times bold(r)) = bold(c) $ <vector-eq>

#set math.equation(numbering: none)

for $bold(r)$, where $bold(a), bold(b), bold(c)$ are known vectors.

Using the #ponder("linear-algebra.vector-triple-product")[vector triple product] identity in @prop-vec-triple-product, we have

$ bold(a) times (bold(b) times bold(r)) = (bold(a) dot bold(r)) bold(b) - (bold(a) dot bold(b)) bold(r), $

so that @vector-eq becomes

#set math.equation(numbering: "«1")

$ bold(r) + (bold(a) dot bold(r)) bold(b) - (bold(a) dot bold(b)) bold(r) = bold(c) $ <vector-eq-2>

#set math.equation(numbering: none)

Taking the dot product of both sides of @vector-eq-2 with $bold(a)$ gives

$
  bold(a) dot bold(r) + (bold(a) dot bold(r)) (bold(a) dot bold(b)) - (bold(a) dot bold(b)) (bold(a) dot bold(r)) = bold(a) dot bold(c)
$

so we obtain
$ bold(a) dot bold(r) = bold(a) dot bold(c). $

Hence, substituting back into @vector-eq-2 gives

#set math.equation(numbering: "«1")
$
  bold(r) + (bold(a) dot bold(c)) bold(b) - (bold(a) dot bold(b)) bold(r) & = bold(c) \
                                        bold(r) (1-(bold(a) dot bold(b))) & = bold(c) - (bold(a) dot bold(c)) bold(b).
$ <vector-eq-3>
#set math.equation(numbering: none)

- If $bold(a) dot bold(b) != 1$, the there is a unique solution given by
$
  bold(r) & = (bold(c) - (bold(a) dot bold(c)) bold(b))/(1-(bold(a) dot bold(b))).
$

- If $bold(a) dot bold(b) = 1$, then by @vector-eq-3, either
  - there is no solution if $bold(c) - (bold(a) dot bold(c)) bold(b) != bold(0)$, or
  - there are infinitely many solutions if $bold(c) - (bold(a) dot bold(c)) bold(b) = bold(0)$. The set of solutions is given by our derived condition

    $ bold(a) dot bold(r) = bold(a) dot bold(c), $

    which represents a plane.

== Index Notation & Summation Conventions

Consider an #ponder("linear-algebra.orthonormal")[orthonormal] right-handed #ponder("linear-algebra.basis")[basis] ${bold(e_1), bold(e_2), bold(e_3)}$. We write vectors $bold(a), bold(b),$ _etc._ in terms of coordinates in this basis.

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
  $ bold(e_i) dot bold(e_j) = delta_(i j). $

  - For vectors $bold(a), bold(b)$, we can write
  $ bold(a) dot bold(b) = sum_(i = 1)^(3) a_i b_i = sum_(i, j=1)^(3) delta_(i j) a_i b_j. $
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
  $ bold(e_i) times bold(e_j) = sum_(k=1)^3 epsilon_(i j k) bold(e_k). $

  - For vectors $bold(a), bold(b)$, we can write
  $ bold(a) times bold(b) = sum_(i, j, k=1)^3 epsilon_(i j k) a_i b_j bold(e_k). $
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

  - $bold(a) dot bold(b) = delta_(i j) a_i b_j = a_i b_i$

  - $(bold(a) times bold(b))_i = epsilon_(i j k) a_j b_k$

  - $bold(a) dot (bold(b) times bold(c)) = epsilon_(i j k) a_i b_j c_k$

  - $delta_(i i) = 3$
]


#proposition("Important identities involving delta and epsilon")[
  For indices $i, j, k, l$ taking values $1, 2, 3$, we have

  1. $epsilon_(i j k) epsilon_(p q r) = delta_(i p) delta_(j q) delta_(k r) - delta_(j p) delta_(i q) delta_(k r) + delta_(j i) delta_(k q) delta_(i r) - delta_(k p) delta_(j q) delta_(i r) + delta_(k p) delta_(i q) delta_(j r) - delta_(i p) delta_(k q) delta_(j k).$
  2. $epsilon_(i j k) epsilon_(p q k) = delta_(i p) delta_(j q) - delta_(i q) delta_(j p)$
  3. $epsilon_(i j k) epsilon_(p j k) = 2 delta_(i p)$
  4. $epsilon_(i j k) epsilon_(i j k) = 6$
] <prop-ident-delta-epsilon>

=== Proofs Using Index Notation

We can now use index notation to prove the #ponder("linear-algebra.vector-triple-product")[vector triple product] identity.

#example("Proof of vector triple product identity")[

  We want to show that for $bold(a), bold(b), bold(c) in RR^3$,
  $ bold(a) times (bold(b) times bold(c)) = (bold(a) dot bold(c)) bold(b) - (bold(a) dot bold(b)) bold(c). $


  #proof[
    Using index notation, the $i$th component of the left-hand side is
    $
      (bold(a) times (bold(b) times bold(c)))_i & = epsilon_(i j k) a_j (bold(b) times bold(c))_k \
      & = epsilon_(i j k) a_j epsilon_(k p q) b_p c_q \
      & = (epsilon_(i j k) epsilon_(k p q)) a_j b_p c_q \
      & = (epsilon_(i j k) epsilon_(p q k)) a_j b_p c_q \
      & = (delta_(i p) delta_(j q) - delta_(i q) delta_(j p)) a_j b_p c_q quad "so" i = p "in the first term, and" j = q "in the second"\
      & = a_j c_j b_i - a_j b_j c_i \
      & = (bold(a) dot bold(c)) b_i - (bold(a) dot bold(b)) c_i. \
    $
    This is precisely the $i$th component of the right-hand side.
  ]

]

#lecture-separator(lecture: 7, date: "2025-10-23")

=== Spherical Trigonometry

With index notation, we can also consider *spherical trigonometry*.

#proposition[
  For $bold(a), bold(b), bold(c) in RR^3$, then

  $
    (bold(a) times bold(b)) dot (bold(b) times bold(c)) = (bold(a) dot bold(b))(bold(b) dot bold(c)) - (bold(a) dot bold(c)) abs(bold(b))^2.
  $
] <spherical-cosine-rule>

#proof[
  $
    "LHS" & = (bold(a) times bold(b))_i dot (bold(b) times bold(c))_i \
          & = epsilon_(i j k) a_j b_k epsilon_(i p q) b_p c_q \
          & = (epsilon_(i j k) epsilon_(i p q)) a_j b_k b_p c_q \
          & = (epsilon_(i j k) epsilon_(p q i)) a_j b_k b_p c_q \
          & = (delta_(j p) delta_(k q) - delta_(j q) delta_(k p)) a_j b_k b_p c_q \
          & = a_j b_j b_k c_k - a_j b_k b_k c_j \
          & = (bold(a) dot bold(b))(bold(b) dot bold(c)) - (bold(a) dot bold(c)) abs(bold(b))^2. \
  $
]

Now consider a unit sphere in $RR^3$ with centre $bold(O)$, and points $A, B, C$ on the surface of the sphere with position vectors $bold(a), bold(b), bold(c)$ respectively.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d4e1.svg", width: 16em)
]

The distance from $A$ to $B$, $delta(A, B)$, is an arc length on the sphere.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d4e2.svg", width: 22em)
]

In the same way, $abs(bold(a) times bold(b)) = sin delta(A, B)$.

Hence, we have

$
  cos alpha &= ((bold(a) times bold(b)) dot (bold(a) times bold(c)))/(abs(bold(a)times bold(b)) abs(bold(a) times bold(c)))\
  &= - ((bold(b) times bold(a)) dot (bold(a) times bold(c)))/(abs(bold(a)times bold(b)) abs(bold(a) times bold(c))) \
  &= ((bold(b) dot bold(c))abs(bold(a))^2-(bold(b) dot bold(a))(bold(a) dot bold(c)) )/(abs(bold(a)times bold(b)) abs(bold(a) times bold(c))). \
  cos alpha sin delta(A, B) sin delta(A, C) &= cos delta(B, A) - cos delta(B, A) cos delta(A, C). \
$

Which is the cosine rule for spherical triangles.

== Vectors in $RR^n$

We define the following operations for vectors in $RR^n$.

#definition([Addition and Scalar Multiplication in $RR^n$])[

  *Addition.* For $bold(a), bold(b) in RR^n$, we define
  $ bold(a) + bold(b) = (a_1 + b_1, a_2 + b_2, ..., a_n + b_n). $

  *Scalar Multiplication.* For $bold(a) in RR^n$ and $lambda in RR$, we define
  $ lambda bold(a) = (lambda a_1, lambda a_2, ..., lambda a_n). $
]

Any $bold(x) in RR^n$ can be written as
$ bold(x) = sum_(i=1)^(n) x_i bold(e_i) $
where ${bold(e_1), bold(e_2), ..., bold(e_n)}$ is the standard basis for $RR^n$ with $1$ in the $i$th position and $0$ elsewhere for $bold(e_i)$.

#definition([Dot Product in $RR^n$])[
  For $bold(a), bold(b) in RR^n$, we define their #ponder("linear-algebra.dot-product")[dot product] to be
  $ bold(a) dot bold(b) = sum_(i=1)^(n) a_i b_i. $
]

#proposition[
  $
    bold(e_i) dot bold(e_j) = delta_(i j).
  $
]

Hence, the components of $bold(x) = (x_1, x_2, ..., x_n)$ can be determined by

$ x_i = bold(x) dot bold(e_i). $

#notation[
  If we write vectors in $RR^n$ as columns, then for $bold(x), bold(y) in RR^n$, $bold(x)^tp$ and $bold(y)^tp$ denote their transposes, and that their #ponder("linear-algebra.inner-product")[inner product] can be written as
  $ bold(x) dot bold(y) = bold(x)^tp bold(y). $
]

=== Summation Convention <sec-summation-convention>

We have
$ bold(x) dot bold(y) = delta_(i j) x_i y_j = x_i y_i. $

We define $epsilon_(underbracket(i\, j\, dots\, l, n "indices"))$ to be the extension of the #ponder("linear-algebra.levi-civita-symbol")[Levi-Civita epsilon] (@def-levi-civita) to $n$ dimensions.

In $RR^2$, it can be used to define an additional #ponder("linear-algebra.dot-product")[scalar product]:

$ [bold(a), bold(b)] = epsilon_(i j) a_i b_j = a_1 b_2 - a_2 b_1 $

Geometrically, this represents the signed area of the parallelogram formed by $bold(a)$ and $bold(b)$.

#remark[
  One can compare this to $[bold(a), bold(b), bold(c)]$, which represents the signed volume of the parallelepiped formed by $bold(a), bold(b), bold(c)$ in $RR^3$.
]

== Vectors in $CC^n$

We define the following operations for vectors in $CC^n$.

#definition([Addition and Scalar Multiplication in $CC^n$])[

  *Addition.* For $bold(z), bold(w) in CC^n$, we define
  $ bold(z) + bold(w) = (z_1 + w_1, z_2 + w_2, ..., z_n + w_n). $

  *Scalar Multiplication.* For $bold(z) in CC^n$ and $lambda in CC$, we define
  $ lambda bold(z) = (lambda z_1, lambda z_2, ..., lambda z_n). $
  - If $lambda in RR$, then $CC_n$ is a #ponder("linear-algebra.vector-space")[real vector space].
  - If $lambda in CC$, then $CC_n$ is a #ponder("linear-algebra.vector-space")[complex vector space].
]

For any $bold(z) in CC^n$, we have

$ z_j = x_j + ii y_j. $


If we are only allowing real scalars, then we can write
$ bold(z) = sum_j (x_j + ii y_j) bold(e_j) = sum_j x_j bold(e_j) + sum_j y_j bold(f_j) = bold(x) + ii bold(y). $

where $bold(f_j)$ is defined to be the vector with $ii$ in the $j$th position of the imaginary part and $0$ elsewhere.

Note that ${bold(e_1), bold(e_2), ..., bold(e_n), bold(f_1), bold(f_2), ..., bold(f_n)}$ forms a basis for $CC^n$ as a #ponder("linear-algebra.vector-space")[real vector space], with #ponder("linear-algebra.dimension")[dimension] $2n$.


If we allow complex scalars, then we can define

$ bold(f_j) = ii bold(e_j), $

and thus $bold(z) = sum_j z_j bold(e_j)$. Hence $CC^n$ is a #ponder("linear-algebra.vector-space")[complex vector space] with #ponder("linear-algebra.dimension")[dimension] $n$. Note that ${bold(e_1), bold(e_2), ..., bold(e_n)}$ forms a basis for $CC^n$ as a #ponder("linear-algebra.vector-space")[complex vector space], with #ponder("linear-algebra.dimension")[dimension] $n$.

=== #ponder("linear-algebra.inner-product")[Inner Product] in $CC^n$

#definition([Inner Product in $CC^n$])[
  For $bold(z), bold(w) in CC^n$, we define their #ponder("linear-algebra.inner-product")[inner product] to be
  $ (bold(z), bold(w)) = sum_(i=1)^(n) overline(z_i) w_i. $
]

#lecture-separator(lecture: 8, date: "2025-10-25")

#remark[
  This definition, including a complex conjugate, allows us to proceed with a definition for the #ponder("linear-algebra.norm")[norm].
]

==== Properties of the #ponder("linear-algebra.inner-product")[Inner Product]

#proposition([Properties of the inner product in $CC^n$])[
  1. *Hermitianity.* $(bold(z), bold(w)) = overline((bold(w), bold(z)))$.

  2. *Linearity and anti-linearity.* $forall bold(z), bold(w) in CC^n, forall mu, mu', lambda, lambda' in CC$,

    - $(bold(z), lambda bold(w') + lambda' bold(w)) = lambda (bold(z), bold(w)) + lambda' (bold(z), bold(w'))$
    - $(mu bold(z) + mu' bold(z'), bold(w)) = overline(mu) (bold(z), bold(w)) + overline(mu') (bold(z'), bold(w))$

  3. *Positive definite.* $(bold(z), bold(z)) = sum_j abs(z_j)^2 >= 0$. Equality holds iff $bold(z) = bold(0)$.
]

#definition([Norm in $CC^n$])[
  For $bold(z) in CC^n$, we define its #ponder("linear-algebra.norm")[norm] to be
  $ abs(bold(z))^2 = (bold(z), bold(z)) = sum_(i=1)^(n) abs(z_i)^2. $
]

#definition([Orthogonality in $CC^n$])[
  We say that $bold(z), bold(w) in CC^n$ are #ponder("linear-algebra.orthogonality")[*orthogonal*] if
  $ (bold(z), bold(w)) = 0. $
]

#remark[
  The standard basis for $CC^n$ is #ponder("linear-algebra.orthonormal")[orthonormal], and
  $ (bold(e_i), bold(e_j)) = delta_(i j). $
]

==== From Complex to Real #ponder("linear-algebra.inner-product")[Inner Products]

For $n = 1$, take $z, w in CC$, then

$
  (z, w) & = overline(z) w. \
$

Now, write $z = a_1 + ii a_2$ and $w = b_1 + ii b_2$ where $a_1, a_2, b_1, b_2 in RR$. Then we can identify $z$ and $w$ as vectors in $RR^2$, with $bold(a) = (a_1, a_2)$ and $bold(b) = (b_1, b_2)$ respectively.

Then,
$ overline(z) w = bold(a) dot bold(b) + ii [bold(a), bold(b)] $
where $[bold(a), bold(b)] = a_1 b_2 - a_2 b_1$ is product defined in @sec-summation-convention, recovers both #ponder("linear-algebra.dot-product")[scalar products] in $RR^2$.

== General Vector Spaces

#definition("Vector space")[
  A #ponder("linear-algebra.vector-space")[vector space] $V$ is a collection of vectors with two operations defined on them: vector addition and scalar multiplication, which satisfies the axioms in @def-vector-space-over-rr-cc.
]

- If the scalar field is $RR$, then $V$ is a #ponder("linear-algebra.vector-space")[*real vector space*].
- If the scalar field is $CC$, then $V$ is a #ponder("linear-algebra.vector-space")[*complex vector space*].

Consider a #ponder("linear-algebra.vector-space")[real vector space] $V$, and consider $bold(v_1), bold(v_2), ..., bold(v_r) in V$, we can write a #ponder("linear-algebra.linear-combination")[linear combination]:

$ lambda_1 bold(v_1) + lambda_2 bold(v_2) + ... + lambda_r bold(v_r) in V $ for any $lambda_1, lambda_2, ..., lambda_r in RR$.

#definition("Span")[
  The #ponder("linear-algebra.span")[*span*] of ${bold(v_1), ... bold(v_r)}$  is defined as

  $ span{bold(v_1), ..., bold(v_r)} = {sum_(i=1)^(r) lambda_i bold(v_i): lambda_i in RR}. $
] <span>

#definition("Subspace")[
  A #ponder("linear-algebra.subspace")[*subspace*] $U$ of a #ponder("linear-algebra.vector-space")[vector space] $V$ is a subset of $V$ that is also a #ponder("linear-algebra.vector-space")[vector space] under the same operations of addition and scalar multiplication defined on $V$.
] <subspace>

Equivalently, a non-empty subset $U subset.eq V$ is a #ponder("linear-algebra.subspace")[subspace] if it satisfies that for every $bold(u), bold(v) in U$ and $lambda in RR$, we have $lambda bold(v) + mu bold(u) in U$.

In particular, for any $bold(v_1), bold(v_2), ..., bold(v_r) in V$, $ span{bold(v_1), ..., bold(v_r)} $ is a #ponder("linear-algebra.subspace")[subspace] of $V$.

#remark[
  The two trivial #ponder("linear-algebra.subspace")[subspaces] of any #ponder("linear-algebra.vector-space")[vector space] $V$ are ${bold(0)}$ and $V$ itself.
]

=== #ponder("linear-algebra.linear-independence")[Linear Independence and Dependence]

#definition("Linear independence and dependence")[
  Consider a #ponder("linear-algebra.vector-space")[vector space] $V$, and vectors $bold(v_1), bold(v_2), ..., bold(v_r) in V$. Consider a #ponder("linear-algebra.linear-combination")[linear combination] of these vectors:
  $ lambda_1 bold(v_1) + lambda_2 bold(v_2) + ... + lambda_r bold(v_r) quad lambda_1, ..., lambda_r in RR "or" CC. $

  If $lambda_1 bold(v_1) + lambda_2 bold(v_2) + ... + lambda_r bold(v_r) = bold(0)$ implies $lambda_1 = lambda_2 = ... = lambda_r = 0$, then the vectors are #ponder("linear-algebra.linear-independence")[*linearly independent*].

  If there exists $lambda_1, lambda_2, ..., lambda_r$, not all zero, such that $lambda_1 bold(v_1) + lambda_2 bold(v_2) + ... + lambda_r bold(v_r) = bold(0)$, then the vectors are #ponder("linear-algebra.linear-independence")[*linearly dependent*].
] <linear-independence>

#remark[

  - A set of vectors ${bold(v_1), bold(v_2), ..., bold(v_r)}$ is #ponder("linear-algebra.linear-independence")[linearly dependent] iff one of the vectors can be expressed as a #ponder("linear-algebra.linear-combination")[linear combination] of the others.

  - In $RR^3$, $bold(a), bold(b), bold(c)$ are #ponder("linear-algebra.linear-independence")[linearly independent] iff

    $ bold(a) dot (bold(b) times bold(c)) != 0. $

    This can be geomtrically interpreted as the vectors not being coplanar #fade[[the LHS represents the volume of the parallelepiped spanned by the vectors]].
]

#example[
  1. ${vec(1, 0), vec(0, 1), vec(0, 2)}$ in $RR^2$ is #ponder("linear-algebra.linear-independence")[linearly dependent], noting that $2 vec(0, 1) = vec(0, 2)$.

  2. ${vec(1, 0), vec(0, 1)}$ in $RR^2$ is #ponder("linear-algebra.linear-independence")[linearly independent].

  3. Any set containing $bold(0)$ is #ponder("linear-algebra.linear-independence")[linearly dependent].
]

=== #ponder("linear-algebra.inner-product")[Inner Products]

#definition("Inner product")[
  An #ponder("linear-algebra.inner-product")[*inner product*] on a #ponder("linear-algebra.vector-space")[vector space] $V$ is a function that assigns to each pair of vectors $bold(v), bold(w) in V$ a scalar $(bold(v), bold(w)) in RR "or" CC$, satisfying

  // TODO: how do you deal with the complement beyond RR and CC?

  1. *Hermitianity*: $(bold(v), bold(w)) = overline((bold(w), bold(v)))$.

  2. *Linearity and anti-linearity*: $forall bold(u), bold(v), bold(w) in V, forall mu, mu', lambda, lambda' in CC "or" RR$,

    - $(bold(v), lambda bold(w) + lambda' bold(w')) = lambda (bold(v), bold(w)) + lambda' (bold(v), bold(w'))$
    - $(mu bold(v) + mu' bold(v'), bold(w)) = overline(mu) (bold(v), bold(w)) + overline(mu') (bold(v'), bold(w))$

  3. *Positive definiteness*: $(bold(v), bold(v)) >= 0$ with equality iff $bold(v) = bold(0)$.
]

#definition("Orthogonality")[
  We say that $bold(v), bold(w) in V$ are #ponder("linear-algebra.orthogonality")[*orthogonal*] if
  $ (bold(v), bold(w)) = 0. $
]

#proposition[
  If vectors $bold(v_1), bold(v_2), ..., bold(v_n) in V$ are non-zero and #ponder("linear-algebra.orthogonality")[orthogonal], then they are #ponder("linear-algebra.linear-independence")[linearly independent].
]

#proof[
  Suppose for contradiction that the vectors are #ponder("linear-algebra.linear-independence")[linearly dependent]. Then there exist scalars $alpha_1, alpha_2, ..., alpha_n in RR "or" CC$, not all zero, such that

  $ sum_i alpha_i bold(v_i) & = bold(0). $

  Then

  $
    0 = (bold(v_j), sum_i alpha_i bold(v_i)) & = sum_i alpha_i (bold(v_j), bold(v_i)) quad "by linearity" \
                                             & = alpha_j (bold(v_j), bold(v_j)) quad "by orthogonality" \
                                             & = alpha_j abs(bold(v_j))^2.
  $

  By positive definiteness, $abs(bold(v_j))^2 > 0$, so we must have $alpha_j = 0$. This holds for all $j$, contradicting our assumption that not all $alpha_i$ are zero.
]

=== #ponder("linear-algebra.basis")[Basis] and #ponder("linear-algebra.dimension")[Dimension]

#definition("Basis")[
  A #ponder("linear-algebra.basis")[*basis*] of a #ponder("linear-algebra.vector-space")[vector space] $V$ is a set of vectors $B={bold(v_1), bold(v_2), ..., bold(v_r)}$ in $V$ that

  1. $B$ #ponder("linear-algebra.spanning-set")[spans] $V$,

  2. the vectors in $B$ are #ponder("linear-algebra.linear-independence")[linearly independent].

  #remark[
    This implies that the coefficients in the #ponder("linear-algebra.linear-combination")[linear combination] $lambda_1 bold(v_1) + lambda_2 bold(v_2) + ... + lambda_r bold(v_r)$ are unique for any vector in $V$. The set of coefficients are called the *components* of the vector with respect to the #ponder("linear-algebra.basis")[basis] $B$.
  ]
] <basis>

#theorem[
  If ${bold(e_1), bold(e_2) ,..., bold(e_n)}$ and ${bold(f_1), bold(f_2), ..., bold(f_m)}$ are #ponder("linear-algebra.basis")[bases] for the same #ponder("linear-algebra.vector-space")[vector space] $V$, then $n = m$. The number $n$ is called the #ponder("linear-algebra.dimension")[*dimension*] of $V$.
] <dimension>

#proposition[
  If $V$ is a #ponder("linear-algebra.vector-space")[vector space] of #ponder("linear-algebra.dimension")[dimension] $n$. Then,

  1. if $Y = {bold(w_1), ..., bold(w_m)}$ #ponder("linear-algebra.spanning-set")[spans] $V$, and that $m > n$, we can remove vectors from $Y$ to get a #ponder("linear-algebra.basis")[basis].

  2. If $Z = {bold(u_1), ..., bold(u_k)}$ is a #ponder("linear-algebra.linear-independence")[linearly independent] set in $V$ with $k < n$, we can add vectors to $Z$ to get a #ponder("linear-algebra.basis")[basis].
]
