#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2025-10-09")

= Complex Numbers

We should be fairly familiar with complex numbers already, but here is a recap of what should be well-covered.

== Definition

We construct $CC$ by adding the element $ii$ to $RR$, satisfying $ii^2=-1$. Then, any complex number $z in CC$ has the form

$ z=x+ii y $
where $x, y in RR$.

Each complex number consists of a *real part* $re(z)=x$ and an *imaginary part* $im(z)=y$.

== Properties

1. *Addition.* Given $z_1, z_2 in CC$ where $z_1=x_1+ii y_1$, $z_2=x_2+ii y_2$, we can add or subtract them by $ z_1+z_2=(x_1+x_2)+ii(y_1+y_2). $

2. *Multiplication.* We can multiply $z_1$ and $z_2$ by $ z_1z_2=(x_1+ii y_1)(x_2+ii y_2)=(x_1x_2-y_1y_2)+ii(x_1y_2+x_2y_1). $

  #remark[
    Both addition and multiplication are #ponder("algebra.commutativity-associativity-distributivity")[associative] and #ponder("algebra.commutativity-associativity-distributivity")[commutative].
  ]

3. *Identity.* The identity element for the addition operation is the element 0. #fade[[Thus $(CC, +)$ is an #ponder("algebra.abelian-group")[Abelian group] with identity element 0.]]

4. *Inverse.* For any $z!=0$, the inverse of $z$ is given by $ x^(-1)=(x-ii y)/(x^2+y^2), $ and it satisfies $z dot z^(-1)=1$. #fade[[Thus $(CC^*, dot)$ is an #ponder("algebra.abelian-group")[Abelian group] with identity element 1.]]

  Moreover, #ponder("algebra.commutativity-associativity-distributivity")[distributivity] is satisfied, _i.e._ if $z_1, z_2, z_3 in CC$ Then $ (z_1+z_2)z_3=z_1z_3+z_2z_3. $

5. *Complex conjugate.* For any $z=x+ii y$, the complex conjugate is $overline(z)=x-ii y$. With this, we can write $re(z)=(z+overline(z))/(2), im(z)=(z-overline(z))/(2)$.

  Properties of complex conjugates includes:

  1. $overline((overline(z)))=z.$
  2. $overline(z_1+z_2)=overline(z_1)+overline(z_2).$
  3. $overline(z_1z_2)=overline(z_1) dot overline(z_2).$

6. *Modulus.* For any $z=x+ii y$, we define the modulus in $RR_(>=0)$ to be $ abs(z)^2=x^2+y^2. $

  We will sometimes denote $abs(z)$ by $r$.

7. *Argument.* The argument fo a complex number $z=x+ii y != 0$ is a rela number, denoted by $arg(z) = theta$ such that $ z=r(cos theta + i sin theta). $

  This is called the *polar form* of $z$. We can write
  $ cos theta = (x)/(sqrt(x^2+y^2) ), quad sin theta=(y)/(sqrt(x^2+y^2) ), quad tan theta = (y)/(x). $

  If $theta$ is an argument of $z$, then any $theta + 2 ppi n$ where $n in ZZ$ is also an argument of $z$. Therefore, to make this argument unique, we restrict the range of theta to $(-ppi, ppi]$. We call arguments within this range to be the *principal value*.

  We denote the principal value by $arg(z)$. We also write $upright(A r g)(z)={arg(z) + 2 ppi n | n in ZZ}$.

#remark[
  1. $RR subset.eq CC$, since for any $alpha in RR$, we have $alpha + ii 0 in CC$.
  2. Complex numbers of the form $0 + ii b$ are called *pure imaginary numbers*.
  3. The representation of a complex number in terms of real and imaginary parts is unique.
]

Once we have the properties above, here are a few more properties we can get to.

1. $(CC, +, dot )$ is a field.

2. For the modulus operation, we have
  - $abs(z_1+z_2)<=abs(z_1)+abs(z_2).$
  - $abs(z_1z_2)=abs(z_1)abs(z_2).$
  - $abs(z_1-z_2)>=abs(abs(z_1)-abs(z_2)).$

We can also reach the following theorem, though we will not prove it here.

#theorem("Fundamental Theorem of Algebra")[
  A polynomial of degree $n$ with coefficients in $CC$ can be written as a product of $n$ linear factors:
  $
    p(z) & =c_n z^n + ... + c_0 quad "where" c_i in CC "and" c_n !=0 \
         & = c_n(z-alpha_1)(z-alpha_2)...(z-alpha_n) quad "where" alpha_i in CC. \
  $
  Hence $p(z)=0$ has at least one root in $CC$, and $n$ roots $alpha_i$ connected with multiplicity.
] <fundamental-theorem-of-algebra>

== Argand Diagram

For $z = x+ ii y in CC$, we can plot $z$ in a 2-dimensional plot.

#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d1e1.svg", width: 18em)
]

We can therefore demonstrate some operations on the diagram.

1. Addition and subtraction
#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d1e2.svg", width: 22em)
]


2. Complex conjugates
#align(center)[
  #dynamic-svg("/part-ia/vectors-and-matrices/media/d1e3.svg", width: 14em)
]

This method immediately leads to some properties:
- $overline(z_1+z_2)=overline(z_1)+overline(z_2).$
- $overline(z_1z_2)=overline(z_1)dot overline(z_2)$.
- $abs(overline(z))=abs(z).$

== #ponder("algebra.de-moivres-theorem")[De Moivre's Theorem]

#theorem("De Moivre's Theorem")[
  For any $theta in RR$,  $n in ZZ$, we have
  $ (cos theta + ii sin theta)^n = cos (n theta) + ii sin (n theta). $
] <de-moivres-theorem>

#proof[
  To prove this, we first need a lemma.
  #lemma[
    Let $z_1=r_1(cos theta_1+ii sin theta_1)$ and $z_2=r_2(cos theta_2 + ii sin theta_2)$. Then
    $ z_1z_2=r_1r_2(cos (theta_1+theta_2) + ii sin(theta_1+theta_2)). $
  ]

  #proof[
    Multiplying $z_1$ and $z_2$,
    $
      z_1z_2=r_1r_2(underbracket(cos theta_1 cos theta_2 - sin theta_1 sin theta_2, cos (theta_1 + theta_2))+ii underbracket((cos theta_1 sin theta_2 + cos theta_2 sin theta_1), sin(theta_1+theta_2))).
    $
  ]

  #lecture-separator(lecture: 2, date: "2025-10-11")

  *For $n=0$*, we have $z^0 = 1$, which is true.

  *For $n in ZZ_(>=0)$*, we shall prove by induction.

  - *Base case*. This statement is true for $n=0$.

  - *Inductive step*. Let us assume $(cos theta + ii sin theta)^n = cos (n theta) + ii sin (n theta)$ for $n$. Then consider the case for $n+1$.

    $
      (cos theta + ii sin theta)^(n+1) & = (cos theta + ii sin theta)^n (cos theta + ii sin theta) \
                                       & = cos (n theta) + ii sin (n theta) (cos theta + ii sin theta) \
                       "by lemma" quad & = cos ((n+1) theta) + ii sin ((n+1) theta). \
    $

  *For $n in ZZ^-$*, we write $n=-m$ with $m > 0$. Thus

  $
    (cos theta + ii sin theta)^n & =(cos theta + ii sin theta)^(-m) \
                                 & = ((cos theta + ii sin theta)^m)^(-1) \
                                 & = (cos (m theta) + ii sin (m theta))^(-1) \
                                 & = overline(cos (m theta) + ii sin (m theta))/(abs(cos (m theta) + ii sin (m theta)) ) \
                                 & = cos (m theta) - ii sin (m theta) \
                                 & = cos (-m theta) + ii sin (-m theta) \
                                 & = cos (n theta) + ii sin (n theta). \
  $
]

== #ponder("calculus.exponential-function")[Exponential] and #ponder("calculus.complex-trigonometric-functions")[Trigonometric Functions]

=== #ponder("calculus.exponential-function")[Exponential Function]

#definition[
  For $z in CC$, we define $ exp(z)=ee^z = sum_(n=0)^(infinity) z^(n)/n!. $
]

This definition converges $forall z in CC$. Some fundamental properties of this function are:

- $forall z, w in CC, ee^z ee^w = ee^(z+w)$

- if $z in RR$, then $ee^z$ reduces to the usual #ponder("calculus.exponential-function")[exponential] for reals

- $ee^0=1$

- $forall z in CC, n in ZZ, (ee^(z))^n=ee^(n z)$

=== #ponder("calculus.complex-trigonometric-functions")[Trigonometric Functions]

#definition("Complex Trigonometric Functions")[
  For all $z in CC$:

  $
    cos z & = (1)/(2)(ee^(ii z) + ee^(-ii z)) \
          & = (1)/(2)(sum_(n=0)^(infinity) (1)/(n!) (ii ee)^n+sum_(n=0)^(infinity) (1)/(n!) (-ii ee)^n) \
          & = sum_(n=0)^(infinity) (-1)^n z^(2n)/(2n)!.
  $

  Analogously,


  $
    sin z & = (1)/(2)(ee^(ii z) - ee^(-ii z)) \
          & = (1)/(2)(sum_(n=0)^(infinity) (1)/(n!) (ii ee)^n-sum_(n=0)^(infinity) (1)/(n!) (-ii ee)^n) \
          & = sum_(n=0)^(infinity) (-1)^n z^(2n+1)/(2n+1)!.
  $
] <complex-trigonometric-functions>

If $z in RR$, then the definitions produce the analogous results to real numbers.

From these definitions, we can write, for all $z in CC$,

$ ee^(ii z)=cos z + ii sin z. $

In particular, #fade[[Euler's identity]]

$ ee^(ii ppi)=-1. $

If $x in RR$,

$
  re(ee^(ii x)) & = cos x \
  im(ee^(ii x)) & = sin x. \
$


#lemma[
  For all $n in ZZ$, $ee^z = 1 <=> z = 2 ppi n ii$.
] <exponential-periodicity>

#proof[
  Write $z= x + ii y$. Then

  $
    ee^z & = ee^x ee^(ii y) \
         & = ee^x (cos y + ii sin y) \
  $

  #fade[[$=>$]] Assume that $ee^x (cos y + ii sin y) = 1$. Matching real and imaginary parts gives

  $
    cases(
      sin y = 0 => y = n ppi quad "for any" n in ZZ,
      ee^x cos y = 1 => x = 0\, y = 2 n ppi quad "for any" n in ZZ
    )
  $

  Hence $ee^z = ee^(2 n ppi ii)$.

  #fade[[$arrow.l.double$]] Assume that $z = 2 ppi n ii$. Then evaluating $ee^(2 ppi n ii)$ gives $cos (2 ppi n) + ii sin (2 ppi n) = 1$.
]

Finally, if $z = r(cos theta + ii sin theta)= r ee^(ii theta)$ for $r > 0, theta in RR$, then #ponder("algebra.de-moivres-theorem")[de Moivre's Theorem] is immediate from the results above.

== Roots of Unity

Let $r = ee^(ii theta)$. If for some $N in NN$ we have $z^N=1$, then

$ r^N ee^(ii theta N) = r^N (cos theta N + ii sin theta N) = 1. $

Hence $r^N = 1$ leads to $r=1$.

Also, $theta N = 2 ppi n$ for some $n in ZZ$. Therefore $theta = (2 ppi n)/(N)$.

Therefore, we get $ z & =ee^((2 ppi n i)/(N)) quad "where" n=0, 1, ..., N-1 \
  & = omega^n quad "where" omega = ee^((2ppi i) / N). $

We call the roots to be the *roots of unity*.

== Logarithm and Complex Powers

=== Logarithm

#definition("Complex logarithm")[
  We define, for $z in CC$ and $z !=0$,
  $ omega = log z $
  such that
  $ ee^omega = z. $
] <complex-logarithm>

Hence we have

$ ln (r ee^(ii theta))=ln r + i theta. $

Note that #ponder("algebra.complex-logarithm")[complex logarithm] is #ponder("algebra.multivalued-complex-logarithm")[multi-valued].

#definition("Multivalued complex logarithm")[
  We write
  $upright(L o g)(z)={log z + 2 ppi n ii : n in ZZ}$ to represent the multivalued function.
] <multivalued-complex-logarithm>


#remark[
  To make the result unique, we can restrict the argument to $-ppi < theta <= ppi$.
]

=== Complex Powers

We can define, for $z in CC$, $z != 0$, $alpha in CC$ that

$ z^alpha = ee^(alpha ln z). $

Note that this is multi-valued in general. However

$ z^alpha |-> z^alpha ee^(2 ppi ii n alpha) $
gives the same value for $n in ZZ$.

#example[
  Consider $ii = ee^((ii ppi) / 2)$.

  Then $arg(ii)=(ppi)/(2)$ and $upright(A r g)(i)={ppi / 2 + 2 ppi n : n in ZZ}$. Hence $ln ii = ii (ppi / 2 + 2 ppi n)$ for all $n in ZZ$.
]

== Lines and Circles in the Complex Plane

=== Lines

Taking $z in CC$ as a point on the line, and $omega in CC$ as the direction, then a line can be expressed as

$ z = z_0 + lambda omega quad lambda in RR. $

Taking conjugates, $overline(z)=overline(z_0) + lambda overline(omega) => overline(omega)z-omega overline(z) = overline(omega)z_0 - omega overline(z_0)$.

=== Circles

For a center $c in CC$ and radius $rho > 0$, we can describe a circle as

$
  &     &                                   z & = c+rho ee^(ii theta) quad theta in RR \
  & <=> &                            abs(z-c) & =rho \
  & <=> & abs(z)^2-c overline(z)-overline(c)z & =p^2-abs(c)^2.
$

