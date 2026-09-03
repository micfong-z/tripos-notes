#import "../prelude.typ": *

= Integration

We have seen the definition of integration in terms of _area under a curve_ and _inverse of differentiation_. We shall review what these really mean.

== Integrals as Riemann Sums

This section talks about the _area under a curve_ idea.

#definition("Integral as Riemann sum")[
  The *#ponder("calculus.riemann-integral")[integral]* of a suitably well-defined function $f(x)$ is the limit of a sum
  $ integral_(a)^(b) f(x) dif x = lim_(N->oo) sum_(n=0)^(N-1) f(x_(n)) Delta x $
  where $Delta x =(b-a)/(N)$ and $x_(n)=a + n Delta x$.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d2e1.svg", width: 22em)
  ]
] <def-int-riemann>

#definition("Riemann integrable")[
  Following @def-int-riemann, a function $f(x)$ is *#ponder("calculus.riemann-integrable-function")[Riemann integrable]* if the generalized Riemann sum does not depend on exactly how we choose the rectangles in the limit that all $Delta x->0$.

  #fade[[This includes  the cases where $Delta x$ is non-uniform, or we cannot evaluate $f$ on the LHS, _etc_.]]
] <riemann-integrable>

How are we sure this limit evaluates to the _area under a curve_ idea? We shall consider one rectangle at first.

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d2e2.svg", width: 22em)
]

We will need to borrow this following idea from IA Analysis I for now:

#theorem([Mean-value theorem (MRT) #fade[[IA Analysis I content]]])[
  For a continuous function $f(x)$, the area under curve from $x_(n)$ to $x_(n+1)$ is
  $ A_n = (x_(n+1) - x_(n)) f(c_0) $
  for some $c_n$ where $x_(n) <= c_n <= x_n+1$.
] <integral-mean-value-theorem>

Hence, if $f(x)$ is differentiable, then by #ponder("calculus.taylors-theorem")[Taylor's theorem]
$
  f(c_n) & = f(x_n) + O(c_n - x_n) quad "as" c_n - x_n -> 0 \
         & = f(x_n) + O(Delta x) quad "since" Delta x >= c_n - x_n. \
$

Hence,
$ A_n = Delta x f(x_0) + O((Delta x)^2). $

Therefore, the total area under curve from $x=a$ to $x=b$ is

$
  A & = lim_(N->oo) sum_(n=0)^(N-1) A_n \
  & = underbracket(lim_(N->oo) sum_(n=0)^(N-1) f(x_n), "definition of integral") Delta x + lim_(N->oo) underbracket(N dot O(((b-a)/(N))^2), O((1)/(N))) \
  & = integral_(a)^(b) f(x) dif x. \
$

== Fundamental Theorem of Calculus (FTC)

This section talks about the _inverse of differentiation_ idea.

#theorem("Fundamental Theorem of Calculus")[
  Let $F(x)=integral_(a)^(x) f(t) dif t$ for some #ponder("calculus.riemann-integrable-function")[Riemann integrable] function $f(t).$ Then
  $ (dif F)/(dif x) =(dif )/(dif x) [integral_(a)^(x) f(t) dif t ] = f(x), $
] <fundamental-theorem-of-calculus>

#proof[
  By definition,
  $
    (dif F)/(dif x) & = lim_(h->0) (1)/(h) [integral_(a)^(x+h) f(t) dif t - integral_(a)^(x) f(t) dif t ] \
                    & = lim_(h->0) (1)/(h) [integral_(x)^(x+h) f(t) dif t ] quad "by considering the integral as a sum" \
                    & = lim_(h->0) (1)/(h) [f(x) h + O(h^2)] quad "from MVT and Taylor's theorem" \
                    & = lim_(h->0) [f(x)+O(h)] \
                    & = f(x). \
  $
]

#remark[
  $F(x)$ is a solution to the differential equation $ (dif F)/(dif x) =f(x) $ with $F(a)=0$.
]

#corollary[
  Let $F(x)=integral_(a)^(x) f(t) dif t$ for some #ponder("calculus.riemann-integrable-function")[Riemann integrable] function $f(t)$. Then we have

  $
    (dif )/(dif x) integral_(x)^(b) f(t) dif t &= -f(x) \
    (dif )/(dif x) integral_(a)^(g(x)) f(t) dif t &= (dif )/(dif x) F(g(x)) = (dif F)/(dif g) (dif g)/(dif x) =f(g(x)) (dif g)/(dif x).
  $
]

#notation[
  Indefinite integrals are written in the form
  $ integral f(x) dif x quad "or" quad integral^x f(t) dif t. $
  The unspecified lower limit gives an integration constant.
]

== Integration Techniques


=== Integration by Substitution

If the integrand contains a function of a function, it _might_ help to substitute for the inner function.

#example[
  Consider $I = integral (1-2x)/(sqrt(x-x^2) ) dif x$. Then let
  $ u = x-x^2 quad => quad (dif u)/(dif x) =1 - 2x. $
  and
  $ I = integral (dif u )/(sqrt(u) ) = 2 sqrt(u) + C = 2 sqrt(x -x^2) + C. $
]

Another important class of substitutions are trigonometric substitutions. These make use of the following identities:

$
  cos^2 theta + sin^2 theta & = 1 \
            1 + tan^2 theta & = sec^2theta \
           cosh^2u - sinh u & = 1 \
               1 - tanh^2 u & = sech^2 u.
$

We can use the following table as a substitution reference.

#align(center)[#table(
  columns: 2,
  [*Integrand contains*], [*Substitution*],
  [$sqrt(1-x^2)$], [$x = sin theta$],
  $1 + x^2$, $x = tan theta$,
  $sqrt(x^2 + 1)$, $x = sinh u$,
  $sqrt(x^2 - 1)$, $x = cosh u$,
  $1 - x^2$, $x = tanh u$,
)]

#example[
  Consider

  $
    I & = integral sqrt(2x - x^2) dif x \
      & = integral sqrt(1- (x-1)^2). \
  $

  We should try $x-1 = sin theta => dif x = cos theta dif theta$ with $-(pi)/(2) <= theta <= (pi)/(2)$, so $theta$ would be unique for $0<=x<=2$.

  $
    I & = integral sqrt(cos^2 theta) cos theta dif theta \
      & = integral cos^2 theta dif theta \
      & = ... \
      & = (1)/(2) (theta + sin theta cos theta) + C \
      & = (1)/(2) sin^(-1)(x-1) + (1)/(2) (x-1) sqrt(1-(x-1)^2) + C. \
  $
]

#lecture-separator(lecture: 4, date: "2025-10-17")

=== Integration by Parts

Recall the #ponder("calculus.product-rule")[product rule]
$ (u v)' = u''v+u v', $
we can derive the integration by parts technique
$ integral u v' dif x = u v - integral u' v dif x. $

#example[
  Let $ I = integral_(0)^(infinity) underbracket(x, u) underbracket(ee^(-x), v') dif x. $
  Then we have
  $
    I & = [-x ee^(-x)]_0^oo - integral_(0)^(infinity) (-ee^(-x)) dif x \
      & = [- ee^(-x)]_0^oo \
      & = 1. \
  $
]

#example[
  Let $I = integral ln x dif x$. We can let $u = ln x$ and $v' = 1$, and then
  $
    I & = x ln x-integral (x)/(x) dif x \
      & = x ln x - integral 1 dif x \
      & = x ln x - x + C. \
  $
]

This integration by parts method also works for inverse trignometric functions and inverse hyperbolic functions.
