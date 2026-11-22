#import "../prelude.typ": *
#show: chapter.with(1)

#lecture-separator(lecture: 1, date: "2026-10-09")

= Fourier Series

== Motivation

In 1807, J. Fourier studied heat conduction along metal rod. This has led him to investigate $2ppi$-periodic functions, _i.e._ functions for which
$
  f(theta + 2ppi) = f(theta) quad forall theta.
$
Fourier claimed that such functions could be written as
$
  f(theta) = sum_(n in ZZ) hat(f)_n ee^(ii n theta)
$ <eq-intro-dagger>
and the coefficients $Set(hat(f)_n)$ can be recovered from $f$ via
$
  hat(f)_n = (1)/(2ppi) integral_(0)^(2ppi) f(theta) ee^(-ii n theta) dif theta.
$ <eq-intro-double-dagger>

See @sec-1.3 for more details.

== Modern Treatment

Consider a vector space
$
  V = Set("\"nice\" functions" f: RR->CC "such that" f(theta + L) = f(theta) "for all" theta).
$
#fade[[This can be checked via vector space axioms in IB Linear Algebra.]] Note that if $f in V$, then we only need to know values on interval of length $L$, _e.g._ $[0, L)$, $[-(L)/(2), (L)/(2))$.

Equip $V$ with inner product
$
  iprod(dot, dot): V times V&->CC \
  iprod(f, g) & = integral_(0)^(L) f(theta) overline(g(theta)) dif theta quad ("or from" -(L)/(2) "to" (L)/(2)).
$
with an associated norm
$
  norm(f) = sqrt(iprod(f, f)) = sqrt(integral_(0)^(L) abs(f(theta))^2 dif theta).
$
Consider the family of functions
$
  e_n (theta) = ee^((ii 2ppi n)/(L) theta), quad n in ZZ.
$

Certainly $e_n in V$ for each $n$ and
$
  iprod(e_n, e_m) & = integral_0^L ee^(2ppi ii (n-m) (theta)/(L)) dif theta \
                  & = cases(
                      L quad n=m,
                      0 quad n!=m,
                    ) \
                  & = L delta_(n m).
$

So $Set(e_n)$ are orthogonal in $V$ and $norm(e_n)^2 = L$.

Recall from IA Vectors and Matrices, if $V_N$ is $N$-dimensional vector space, and $Set(vb(e)_n)_(n=1)^N$ were orthogonal, and $norm(vb(e)_n)^2 = L$, then for any $vb(x) in V_N$, we can write
$
  vb(x) = sum_(n=1)^N hat(x)_n vb(e)_n.
$
By taking inner products on each side with $vb(e)_m$,
$
  vb(x) dot vb(e)_m & = sum_(n=1)^N hat(x)_n (vb(e)_n dot vb(e)_m) \
                    & = sum_(n=1)^N hat(x)_n L delta_(n m) \
                    & = L hat(x)_m.
$
Hence, for every $vb(x) in V_N$ we have the following:
$
  vb(x) = sum_(n=1)^N hat(x)_n vb(e)_n quad "with" hat(x)_n = (vb(x) dot vb(e)_n)/(norm(vb(e)_n)^2) = (vb(x) dot vb(e)_n)/L.
$

Going back to $V$ (which is infinite-dimensional), can we do the same? #fade[[No finite subset of $Set(e_n)_(n in ZZ)$ spans $V$.]] _We don't actually care._

Suppose an $f in V$ can be written in the form
$
  f(theta) & = sum_(n in ZZ) hat(f)_n ee^(2ppi ii n theta \/ L) \
           & = sum_n hat(f)_n e_n (theta).
$

Then
$
  iprod(f, e_m) & = sum_n hat(f)_n iprod(e_n, e_m) \
                & = sum_n hat(f)_n L delta_(n m) \
                & = L hat(f)_m.
$
_i.e._ we have
$
  hat(f)_n = (1)/(L) iprod(f, e_n) = (1)/(L) integral_(0)^(L) f(theta) ee^(-2ppi ii n theta \/ L) dif theta.
$

This is exactly Fourier's formula in @eq-intro-double-dagger with $L=2ppi$.

#definition[Complex Fourier Series][
  For an $L$-periodic function $f: RR->CC$, define its *complex Fourier series* by
  $
    sum_n hat(f)_n ee^(2ppi ii n theta \/ L)
  $
  where
  $
    hat(f)_n = (1)/(L) integral_(0)^(L) f(theta) ee^(-2ppi ii n theta \/ L) dif theta
  $
  are called the *complex Fourier coefficients* of $f$.
]

#notation[
  For an $L$-periodic function $f$ we write
  $
    f(theta) ~ sum_n hat(f)_n ee^(2ppi ii n theta \/ L).
  $
  to mean the series on RHS is the Fourier series of $f$. #fade[[We would like to replace $~$ with $=$, but we cannot always do so.]]
]

We can split the sum according to
$
  {n = 0} union {n < 0} union {n > 0}.
$

Then
$
  sum_n hat(f)_n ee^(2ppi ii n theta \/ L) & = hat(f)_0 + sum_(n=1)^oo hat(f)_n (cos (2ppi n theta)/(L) + ii sin (2ppi n theta)/(L)) + sum_(n=1)^oo hat(f)_(-n) (cos (2ppi n theta)/(L) - ii sin (2ppi n theta)/(L)) \
  &= hat(f)_0+sum_(n=1)^oo ((hat(f)_n + hat(f)_(-n)) cos (2ppi n theta)/(L) + ii (hat(f)_n - hat(f)_(-n)) sin (2ppi n theta)/(L)).
$

Hence define, for $n >= 0$,
$
  a_n = hat(f)_n + hat(f)_(-n), quad b_n = ii (hat(f)_n - hat(f)_(-n)).
$
#definition[Fourier Series][
  Given an $L$-periodic function $f: RR ->CC$, define its *Fourier series* by
  $
    (1)/(2) a_0 + sum_(n=1)^oo (a_n cos (2ppi n theta)/(L) + b_n sin (2ppi n theta)/(L))
  $
  where
  $
    a_n = (2)/(L) integral_(0)^(L) f(theta) cos (2ppi n theta)/(L) dif theta, quad b_n = (2)/(L) integral_(0)^(L) f(theta) sin (2ppi n theta)/(L) dif theta
  $
  are called the *Fourier coefficients* of $f$.
]

Note that if $f = f(theta)$ is odd, then
$
  a_n & = (2)/(L) integral_(0)^(L) f(theta) cos (2ppi n theta)/(L) dif theta \
  & = (2)/(L) integral_(-(L)/(2))^((L)/(2)) f(theta) cos (2ppi n theta)/(L) dif theta #eq-note[(the integrand is $L$-periodic)] \
  &= 0. #eq-note[(the integrand is odd)]
$

Similarly, if $f$ was even, then $b_n = 0$.

#warning[
  Always draw graphs of $f$ before computation of Fourier coefficients. This will help you to see which coefficients are zero.

  Also, if a function looks _nice_, its Fourier coefficients should decay quickly.
]

#example[
  Define a $1$-periodic function $f: RR -> RR$ such that
  $
    f(theta) = theta(1-theta) quad forall theta in [0, 1).
  $

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p1.svg", width: 40em)
  ]


  #fade[[It can be seen that it is not a very _nice_ function.]]

  Then $hat(f)_0 = (1)/(6)$ and for $n != 0$, integrating by parts gives
  $
    hat(f)_n &= integral_(0)^(1) theta (1-theta) ee^(-2ppi ii n theta) dif theta\
    &= underbracket([-(1)/(2ppi ii n) theta (1-theta) ee^(-2ppi ii n theta) ]_(0)^(1), 0) + (1)/(2ppi ii n) integral_(0)^(1) (1-2theta) ee^(-2ppi ii n theta) dif theta \
    &=[ -(1)/(2ppi ii n)^2 (1-2theta) ee^(-2ppi ii n theta) ]_(0)^(1) + ("something that integrates to" 0) \
    &= (1)/(2 (ppi ii n)^2).
  $
  Hence
  $
    f(theta) & ~ (1)/(6) - sum_(n!=0) (1)/(2 (ppi n)^2) ee^(2ppi ii n theta) \
             & ~ (1)/(6) - sum_(n=1)^oo (1)/(n ppi)^2 cos (2ppi n theta).
  $
  In fact, this is an equality (see later sections).
]

#lecture-separator(lecture: 2, date: "2026-10-12")

== Convergence of Fourier Series <sec-1.3>

#definition[Partial Fourier Series][
  For an $L$-periodic function $f: RR->CC$, define the *partial* Fourier series
  $
    (S_N f)(theta) = sum_(abs(n) <= N) hat(f)_n ee^(2ppi ii n theta \/ L).
  $
]

We wish to figure out whether $S_N f->f$ as $N->oo$. However, we need a more precise notion of convergence, which we can choose from:

- *Pointwise*: for all $theta in [0, L)$, $ lim_(N->oo) abs(S_N f(theta) - f(theta)) = 0. $

- *Uniform*: $ lim_(N->oo) sup_(theta in [0, L)) abs(S_N f(theta) - f(theta)) = 0. $

- *In norm*:
  $
    lim_(N->oo) norm(S_N f - f)^2 & = lim_(N->oo) integral_(0)^(L) abs(S_N f(theta) - f(theta))^2 dif theta = 0. \
  $

Norm is a nice definition of convergence, but for this course we will focus on pointwise convergence.

#proposition[
  Let $f: RR->CC$  be $L$-periodic such that

  + $f$ is continuous on $[0, L)$, except for finitely many jump discontinuities;

  + $re f, im f$ have a finite number of maxima and minima on $[0, L)$.

  Then
  $
    (1)/(2) [f(theta^+) + f(theta^-) ] = lim_(N->oo) (S_N f)(theta) quad forall theta in [0, L).
  $
  where $f(theta^+), f(theta^-)$ are the right and left limits of $f$ at $theta$.

  _i.e._ at points of continuity, we have $S_N f(theta) -> f(theta)$; at jump discontinuities, $S_N f(theta)$ converges to the average of the left and right limits.
] <prop-partial-fourier-convergence>

We will call functions that have properties in @prop-partial-fourier-convergence *Dirichlet functions*. We will deal solely with such functions in this course, and hence write
$
  f(theta) ~ sum_n hat(f)_n ee^(2ppi ii n theta \/ L)
$
to mean the two sides are equal at points of continuity of $f$, and the RHS converges to the average of left and right limits of $f$ at jump discontinuities.

#example[
  Let $f: RR->RR$ be $2ppi$-periodic such that
  $
    f(theta) = cases(
      +1 & quad 0 <= theta < ppi,
      -1 & quad ppi <= theta < 2ppi,
    )
  $


  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p2.svg", width: 40em)
  ]

  Note that $f$ is odd, so $a_n = 0$ for all $n$. We have,
  $
    b_n & = (2)/(2ppi) integral_(-ppi)^ppi f(theta) sin (n theta) dif theta \
        & = (2)/(ppi) integral_0^ppi sin (n theta) dif theta \
        & = (2)/(n ppi) [1 - (-1)^n].
  $
  Hence
  $
    f(theta) ~ (4)/(ppi) sum_(n=1\ n "odd")^oo sin(n theta)/(n)
  $
  Note if $theta = 0$ we get $"RHS" = 0$, and also
  $
    (1)/(2) [f(0^+) + f(0^-)] = (1)/(2) [1 + (-1)] = 0.
  $
]

We will only prove @prop-partial-fourier-convergence in case that $f$ is smooth, _i.e._ $f in C^oo (RR)$.

#proof[
  #fade[[Partial proof of @prop-partial-fourier-convergence]]

  By considering $g(theta) = f(theta + theta_0)$, we can consider WLOG the convergence at $theta = 0$. Also, take $L = 2ppi$ for simplicity of notation.

  Consider
  $
    (S_N f)(0) & = sum_(abs(n) <= N ) hat(f)_n ee^(ii n 0) \
               & = sum_(abs(n) <= N) ((1)/(2ppi) integral_(-ppi)^(ppi) f(theta) ee^(-ii n theta) dif theta) \
               & = (1)/(2ppi) integral_(-ppi)^(ppi) [sum_(abs(n) <= N) ee^(-ii n theta)] f(theta) dif theta \
  $

  Note that if $theta in RR \\ 2ppi ZZ$, then
  $
    sum_(abs(n) <= N) ee^(-ii n theta) & = ee^(ii N theta) sum_(n=0)^(2N) (ee^(-ii theta))^n \
                                       & = sin[(N + (1)/(2)) theta] / sin((theta)/(2)).
  $
  and if $theta in 2 ppi ZZ$, the sum is $2N + 1$.

  Define #fade[[the Dirichlet kernel]]
  $
    D_N (theta) = cases(
      sin[(N + (1)/(2)) theta] / sin((theta)/(2)) & quad theta in RR \\ 2ppi ZZ,
      2N + 1 & quad theta in 2ppi ZZ.
    )
  $
  Note the following:

  1. $D_N$ is smooth and $2ppi$-periodic;

  2. $integral_(-ppi)^(ppi) D_N (theta) dif theta = 2ppi$ for every $N > 0$ #fade[[looking at the sum, only $n=0$ contributes.]]

  So,
  $
    S_N f(0) - f(0) & = (1)/(2ppi) integral_(-ppi)^(ppi) D_N (theta) f(theta) dif theta - f(0) \
    & = (1)/(2ppi) integral_(-ppi)^(ppi) D_N (theta) [f(theta) - f(0)] dif theta #eq-note[$"by" 1 = (1)/(2ppi) integral_(-ppi)^(ppi) D_N (theta) dif theta$]\
    & = (1)/(2ppi) integral_(-ppi)^(ppi) sin [(N + (1)/(2)) theta]F(theta) dif theta \
  $
  where
  $
    F(theta) = theta / sin((theta)/(2)) dot (f(theta) - f(0)) /theta.
  $
  If $f in C^oo (RR)$, it follows that $F in C^oo (RR)$.

  So by integration by parts,
  $
    abs(S_N f(0) - f(0)) & = (1)/(2ppi) (1)/(N + (1)/(2)) abs(integral_(-ppi)^(ppi) cos[(N + (1)/(2)) theta] F'(theta) dif theta) \
    &<= (1)/(2ppi) (1)/(N + (1)/(2)) integral_(-ppi)^(ppi) abs(F'(theta)) dif theta \
    &-> 0 quad "as" N->oo.
  $
]

#lecture-separator(lecture: 3, date: "2026-10-14")

== Even and Odd Extensions

Given $f: [0, L) -> CC$, introduce $2L$-periodic functions defined by
$
  f_"even" (theta) & = cases(
                       f(theta) quad & theta in [0, L),
                       f(-theta) quad & theta in (-L, 0),
                     ) \
   f_"odd" (theta) & = cases(
                       f(theta) quad & theta in [0, L),
                       -f(-theta) quad & theta in (-L, 0).
                     )
$

Then
$
  f_"even" (theta) & ~ (1)/(2) A_0 + sum_(n=1)^oo A_n cos (2ppi n theta)/(2L), \
   f_"odd" (theta) & ~ sum_(n=1)^oo B_n sin (2ppi n theta)/(2L),
$
where
$
  A_n &= (2)/(2L) integral_(-L)^(L) f_"even" (theta) cos (2ppi n theta)/(2L) dif theta &= (2)/(L) integral_(0)^(L) f(theta) cos ((ppi n theta)/(L)) dif theta, \
  B_n &= (2)/(2L) integral_(-L)^(L) f_"odd" (theta) sin (2ppi n theta)/(2L) dif theta &= (2)/(L) integral_(0)^(L) f(theta) sin ((ppi n theta)/(L)) dif theta.
$ <eq-A-B>
Note $f(theta) = f_"even" (theta) = f_"odd" (theta)$ when $theta in [0, L)$.

#definition[
  Given $f: [0, L) -> CC$, define its *cosine* and *sine* series
  $
    (1)/(2) A_0 + sum_(n=1)^oo A_n cos ((n ppi theta)/(L)), quad sum_(n=1)^oo B_n sin ((n ppi theta)/(L))
  $
  where $A_n$ and $B_n$ are given by @eq-A-B.
] <def-cosine-sine-series>

#example[
  Let $f: [0, 1) -> RR$ with $f(theta) = 1$.

  The sine series is evaluated on

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p3.svg", width: 40em)
  ]

  with
  $
    B_n= (2)/(1) integral_(0)^(1) sin(n ppi theta) dif theta = (2)/(n ppi) [1 - (-1)^n].
  $
  So for $theta in (0, 1)$,
  $
    1 = (4)/(ppi) sum_(n "odd") sin(n ppi theta)/(n).
  $

  The cosine series is evaluated on

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p4.svg", width: 40em)
  ]
  
  with
  $
    A_0 = 2, quad A_n = 0 quad "for" n > 0.
  $
  So for $theta in (0, 1)$,
  $
    1 = (1)/(2) dot 2 + 0.
  $
]

== Regularity and Decay of Fourier Coefficients

Fourier series are infinite sums, so we would hope that their terms tend to zero.

#fade[[Non-examinable: this is a true fact, that if $integral_(0)^(L) abs(f(theta)) dif theta < oo$, then
  $
    integral_(0)^(L) f(theta) ee^(- ii lambda theta) dif theta -> 0 quad "as" abs(lambda)->oo.
  $
  which is called the Riemann-Lebesgue lemma.]]

However, we would like to know how fast the Fourier coefficients decay. This relates to the regularity of such functions.

Suppose $f: RR->CC$ is $L$-periodic and $k$-times continuously differentiable, _i.e._ $f^((r)) : RR -> CC$  is continuous for $r = 0,1, ..., k$. Then, by integration by parts,
$
  hat(f)_n & = (1)/(L) integral_(0)^(L) f(theta) ee^(-2ppi ii n theta \/ L) dif theta \
  & = [(-(L)/(2ppi ii n)) f(theta)/(L) ee^(-2ppi ii n theta \/ L)]_(0)^(L) + ((L)/(2ppi ii n)) (1)/(L) integral_(0)^(L) f'(theta) ee^(-2ppi ii n theta \/ L) dif theta. \
$
Since $f$ is continuous, $f(L^-) = f(0^-) = f(0^+)$, so the boundary term is zero. Hence continuing $k$ times, we have
$
  hat(f)_n = ((L)/(2ppi ii n))^k (1)/(L) underbracket(integral_(0)^(L) f^((k))(theta) ee^(-2ppi ii n theta \/ L) dif theta, o(1) "by Riemann-Lebesgue").
$
Hence $hat(f)_n = o((1)/(n^k))$. _i.e._ more regularity gives more decay of Fourier coefficients. If it is true that
$
  integral_(0)^(L) abs(f^((k+1))(theta)) dif theta < oo,
$
then we get $hat(f)_n = o((1)/(n^(k+1)))$


== Term-wise Differentiation

Let $f: RR->CC$ be $L$-periodic function, and assume that $f$ is continuously differentiable on $(0, L)$ with $f'$ bounded.

Let $g = f'$. Then
$
  hat(g)_n &= (1)/(L) integral_(0)^(L) f'(theta) ee^(-2ppi ii n theta \/ L) dif theta \
  &= [(1)/(L) f(theta) ee^(-2ppi ii n theta \/ L) ]_(0^+)^(L^-) + ((2ppi ii n)/(L)) (1)/(L) integral_(0)^(L) f(theta) ee^(-2ppi ii n theta \/ L) dif theta \
  &= (f(L^-) - f(0^+))/(L) + ((2ppi ii n)/(L)) hat(f)_n.
$
If $f$, _in addition_, is continuous on $RR$, then $f(L^-) = f(0^-) = f(0^+)$, and hence
$
  hat(g)_n = ((2ppi ii n)/(L)) hat(f)_n.
$
Hence
$
  f'(theta) = g(theta) ~ sum_n ((2ppi ii n)/(L)) hat(f)_n ee^(2ppi ii n theta \/ L) equiv sum_n dv(, theta) [hat(f)_n ee^(2ppi ii n theta \/ L)].
$
Thus, differentiation term-wise is acceptable in this case.

== Parseval's Theorem

#theorem[Parseval's Theorem][
  Let $f, g: RR->CC$ be $L$-periodic Dirichlet functions, and let $hat(f)_n, hat(g)_n$ be their Fourier coefficients. Then
  $
    (1)/(L) integral_(0)^(L) f(theta) overline(g(theta)) dif theta = sum_n hat(f)_n overline(hat(g)_n)\
    (1)/(L) integral_(0)^(L) abs(f(theta))^2 dif theta = sum_n abs(hat(f)_n)^2.
  $
] <thm-parseval>

#proof[
  Denote $e_n (theta) = ee^(2ppi ii n theta \/ L)$, then
  $
    f(theta) & ~ sum_n hat(f)_n e_n (theta) \
    g(theta) & ~ sum_n hat(g)_n e_n (theta).
  $
  Then
  $
    iprod(f, g) & = sum_(n, m) hat(f)_n overline(hat(g)_m) underbracket(iprod(e_n, e_m), L delta_(n m)) \
                & = L sum_n hat(f)_n overline(hat(g)_n).
  $
]

#example[
  Let $f: RR->RR$ be $2ppi$-periodic with $f(theta) = theta$ on $[-ppi, ppi)$. We have
  $
    f(theta) ~ sum_(n!= 0) (ii(-1)^n)/(n) ee^(ii n theta).
  $
  And hence,
  $
    (ppi^2)/(3) = (1)/(2ppi) integral_(-ppi)^(ppi) theta^2 dif theta = sum_(n != 0) (1)/(n^2) = 2 sum_(n=1)^oo (1)/(n^2).
  $
  Therefore, we have the famous result
  $
    zeta(2) = sum_(n=1)^oo (1)/(n^2) = (ppi^2)/(6).
  $
  Similarly, we can compute $zeta(2 k)$ by taking $f(theta) = theta^k$ using the method above.
]

#exercise[
  Find positive integers $a, b$ such that $zeta(3) = sum_(n=1)^oo (1)/(n^3) = (a)/(b) ppi^3$. #fade[[This is an open problem.]]
]
