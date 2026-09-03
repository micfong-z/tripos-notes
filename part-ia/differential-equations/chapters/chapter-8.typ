#import "../prelude.typ": *

= Series Solutions

When we cannot find simple closed form solutions to #ponder("ode.ordinary-differential-equation")[ODEs], #ponder("ode.series-solution")[series solutions] may be useful.

Consider
$
  p(x) y'' + q(x) y' + r(x) y = 0.
$

The feasibility of finding #ponder("ode.series-solution")[series solution] around $x=x_0$ depends on nature of $p(x)$, $q(x)$, and $r(x)$ around $x_0$.

#lecture-separator(lecture: 18, date: "2025-11-19")

== Classification of #ponder("ode.singular-point")[Singular Points]

#definition[Ordinary point and singular point][
  The point $x=x_0$ is an *#ponder("ode.singular-point")[ordinary point]* of the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    p(x) y'' + q(x) y' + r(x) y = 0
  $
  if $q(x)/(p(x))$ and $r(x)/(p(x))$ are both analytic at $x_0$.

  #fade[[For the purpose of this course, a function is analytic at $x_0$ if it have a convergent #ponder("calculus.taylor-series")[Taylor series] about $x=x_0$.]]

  Otherwise, $x=x_0$ is a *#ponder("ode.singular-point")[singular point]*.


  If $x_0$ is a #ponder("ode.singular-point")[singular point], but
  $
    (x-x_0) q(x)/(p(x)) quad "and" quad (x-x_0)^2 r(x)/(p(x))
  $
  are analytic, then $x_0$ is a *#ponder("ode.singular-point")[regular singular point]*; otherwise, it is an *#ponder("ode.singular-point")[irregular singular point]*.
] <singular-point>

Compare this to an #ponder("ode.equidimensional-ode")[equidimensional equation]
$ x^2 y'' + a x y' + b y = 0, $
where $x=0$ is a #ponder("ode.singular-point")[regular singular point]. We can state that #ponder("ode.singular-point")[regular singular points] are no more singular than $x=0$ in #ponder("ode.equidimensional-ode")[equidimensional equations].

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    underbracket((1-x^2), p) y'' underbracket(- 2 x, q) y' underbracket(+ 2, r) y = 0.
  $

  So we have

  $
                          (q)/(p) & = (-2x)/(1-x^2) = (2x)/(x-1)(x+1), \
    lim_(x->plus.minus 1) (q)/(p) & = plus.minus oo.
  $
  and
  $
                          (r)/(p) & = 2/(1-x^2) = -2/((x-1)(x+1)), \
    lim_(x->plus.minus 1) (r)/(p) & = plus.minus oo.
  $
  Therefore, $x=1$ and $x=-1$ are #ponder("ode.singular-point")[singular points].

  Now, consider $x=1$. We have
  $ (x-1) (q)/(p) = (x-1) (-2x)/(1-x^2) = -(2x)/(x+1), $
  which is analytic at $x=1$ with value $-1$. Also,
  $ (x-1)^2 (r)/(p) = (x-1)^2 (2)/(1-x^2) = (2(x-1))/(x+1), $
  which is analytic at $x=1$ with value $0$.

  Hence, $x=1$ is a #ponder("ode.singular-point")[regular singular point]. Similarly, $x=-1$ is also a #ponder("ode.singular-point")[regular singular point].
]

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    (1+sqrt(x) ) y'' - 2 x y' + 2 y = 0.
  $
  So we have
  $
                (q)/(p) & = (-2x)/(1+sqrt(x)), \
    lim_(x->0+) (q)/(p) & = 0
  $

  It may appear that $x=0$ is an #ponder("ode.singular-point")[ordinary point]. However, the 2nd derivative of $(q)/(p)$ is not defined at $x=0$. Therfore, $x=0$ is a #ponder("ode.singular-point")[singular point]. Now, consider

  $ (x-0) (q)/(p) = x (-2x)/(1+sqrt(x)) = (-2x^2)/(1+sqrt(x)). $
  It does not have a #ponder("calculus.taylor-series")[Taylor series] about $x=0$ again. Hence, $x=0$ is an #ponder("ode.singular-point")[irregular singular point].
]

== #ponder("ode.frobenius-method")[Method of Frobenius]

#theorem[Fuch's Theorem][
  1. If $x=x_0$ is an #ponder("ode.singular-point")[ordinary point] of the #ponder("ode.ordinary-differential-equation")[ODE]
    $ p(x) y'' + q(x) y' + r(x) y = 0, $
    then there are two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] solutions of the form
    $
      y(x) = sum_(n=0)^oo a_n (x - x_0)^n,
    $
    which converge for some neighborhood of $x_0$. _i.e._ there is a #ponder("calculus.taylor-series")[Taylor series] solution about $x_0$.

  2. If $x=x_0$ is a #ponder("ode.singular-point")[regular singular point] of the #ponder("ode.ordinary-differential-equation")[ODE], then there is at least one solution of the form
    $
      y(x) = sum_(n=0)^oo a_n (x - x_0)^(n+sigma) = (x - x_0)^sigma sum_(n=0)^oo a_n (x - x_0)^n,
    $
    where $sigma$ can be real or complex, and $a_0 != 0$ #fade[[so that $sigma$ is unique]]. The series converges for some neighborhood of $x_0$.

    This is called a *#ponder("ode.frobenius-method")[Frobenius series]*.

    Note that there is no guarantee of two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] solutions in this case.

] <fuchs-theorem>

The #ponder("ode.series-solution")[series solution] method may fail completely at #ponder("ode.singular-point")[irregular singular points].

#example[#ponder("ode.series-solution")[Series solutions] about #ponder("ode.singular-point")[ordinary point]][
  Suppose we want to find a #ponder("ode.series-solution")[series solution] about $x=0$ to the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    (1-x^2) y'' - 2 x y' + 2 y = 0.
  $

  Since $x=0$ is an #ponder("ode.singular-point")[ordinary point], we expect two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.series-solution")[series solutions].

  We shall try
  $
    y(x) = sum_(n=0)^oo a_n x^n.
  $
  So we have
  $
    y'(x) = sum_(n=1)^oo n a_n x^(n-1)
  $
  and
  $ y''(x) = sum_(n=2)^oo n (n-1) a_n x^(n-2). $
  For convenience, we shall multiply the ODE by $x^2$ to get
  $
    x^2 (1-x^2) y'' - 2 x^3 y' + 2 x^2 y = 0.
  $
  Substituting the series into the ODE gives
  $
    sum_(n=2)^oo a_n [(1-x^2) n (n-1)] x^n - 2 sum_(n=1)^oo a_n x^(2) n x^n + 2 sum_(n=0)^oo a_n x^(n+2) & = 0 \
    sum_(n=2)^oo n (n-1) a_n x^n - sum_(cancel(n=4)\ n=2)^oo (n-2) (n-3) a_(n-2) x^(n) - 2 sum_(cancel(n=3)\ n=2)^oo (n-2) a_(n-2) x^(n) + 2 sum_(n=2)^oo a_(n-2) x^(n) & = 0. \
  $
  Equating coefficients of $x^n$ for $n >= 2$ gives
  $
    n (n-1) a_n - (n-2)(n-3) a_(n-2) - 2 (n-2) a_(n-2) + 2 a_(n-2) & = 0 \
                n (n-1) a_n - (n^2 - 5 n + 6 + 2n - 4 - 2) a_(n-2) & = 0 \
                                                        n(n-1) a_n & = n(n-3) a_(n-2) \
                                                               a_n & = (n-3)/(n-1) a_(n-2). \
  $
  Hence we have a recurrence relation for $n>=2$. Therefore, $a_0$ and $a_1$ are arbitrary constants in the general solution.

  Consider the odd terms. Note that $n_3=0$. Hence, all odd terms are zero. Therefore, one solution is
  $ y(x) = a_(1) x. quad ("odd function of" x) $

  Consider the even terms. We have
  $
    a_n = (n-3)/(n-1) a_(n-2)
    = ((n-3)(n-5))/((n-1)(n-3)) a_(n-4)
    = (n-5)/(n-1) a_(n-4).
  $
  Therefore
  $
    a_n = -1/(n-1) a_0.
  $
  Hence, the other solution is
  $
    y(x) = a_0 [1 - x^2 - x^4/3 - x^6/5 - ... ]. quad ("even function of" x)
  $
  Note that
  $
    ln (1plus.minus x) = plus.minus x - (x^2)/(2) plus.minus (x^3)/(3) - (x^4)/(4) plus.minus (x^5)/(5) +...
  $
  Therefore, we can write the even solution as
  $ y(x) = a_0 [1 - (x)/(2) ln ((1+x)/(1-x)) ]. $

  Hence, we can write the general solution as
  $ y(x) = a_0 [1 - (x)/(2) ln ((1+x)/(1-x)) ] + a_1 x $
  which is a closed form solution as well.

  Note the behavior near $x = plus.minus 1$, near the #ponder("ode.singular-point")[regular singular points].
] <ex-series-solutions-about-ordinary-point>

#lecture-separator(lecture: 19, date: "2025-11-21")

#example[#ponder("ode.series-solution")[Series solutions] about #ponder("ode.singular-point")[regular singular point]][
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    4 x y'' + 2(1-x^2) y' - x y = 0.
  $
  We know that $x=0$ is a #ponder("ode.singular-point")[regular singular point]. For convenience, multiply the #ponder("ode.ordinary-differential-equation")[ODE] by $x$ to get
  $
    4 x^2 y'' + 2 (1-x^2) (x y') - x^2 y = 0.
  $
  We shall try a #ponder("ode.frobenius-method")[Frobenius series] solution of the form
  $ y(x) = sum_(n=0)^oo a_n x^(n+sigma) quad (a_0 != 0). $
  Since the #ponder("ode.ordinary-differential-equation")[ODE] now looks like an #ponder("ode.equidimensional-ode")[equidimensional equation], we expect to be able to extract a sum when we substitute it in. So we have
  $
    sum_(n=0)^oo a_n x^(n + sigma) [4 (n + sigma) ( n+sigma - 1) + 2 (1-x^2)(n+sigma) - x^2] & = 0.
  $

  - We shall look at the lowest power of $x$ to determine $sigma$. In this case, it is $x^(sigma)$ with $n = 0$.
    $
      a_0 [4 sigma (sigma - 1) + 2 sigma] & = 0 \
                2 a_0 sigma (2 sigma - 1) & = 0 quad ("indicial equation") \
    $
    Since $a_0 != 0$, we have $sigma = 0$ or $sigma = 1/2$.

  - The next lowerest power is $x^(sigma + 1)$ with $n = 1$.

    $
      a_1 [4(sigma + 1) sigma + 2 (sigma + 1)] & = 0 \
               2 a_1 (sigma + 1) (2 sigma + 1) & = 0. \
    $

    Since $sigma = 0 "or" (1)/(2)$, we must have $a_1 = 0$ in both cases.

  - For more generality, consider $x^(n + sigma)$ with $n >= 2$.

    $
      a_n 4 (n+sigma)(n+sigma - 1) + 2 a_n (n + sigma) - 2 a_(n-2) (n - 2 + sigma) - a_(n-2) & = 0 \
                                                            2(n+sigma)(2n + 2 sigma - 1) a_n & = (2 n + 2 sigma - 3)a_(n-2). \
    $

    Now we should consider the two cases for $sigma$ separately.

    - For $sigma = 0$, we have
      $
        a_n = (2 n - 3)/(2 n (2 n - 1)) a_(n-2).
      $
      Since $a_1 = 0$, all odd terms are zero. Now, for the even terms, we have
      $
        a_2 = (1)/(4times 3) a_0, quad a_4 = (5)/(8times 7) a_2 = (5)/(8times 7times 4times 3) a_0, ...
      $
      Therefore, the even terms give one (#ponder("calculus.taylor-series")[Taylor series]) solution
      $
        y_1(x) = a_0 [1 + (x^2)/(4times 3) + (5 x^4)/(8times 7times 4times 3) + ... ].
      $

    - For $sigma = (1)/(2)$, we have

      $
        a_n = (cancel(2) (n-1))/(cancel(2) (2n + 1) n) a_(n-2).
      $

      Therefore, for the even terms,
      $
        a_2 = (1)/(2 times 5) a_0, quad a_4 = (3)/(4times 9) a_2 = (3times 1)/(4times 9times 2times 5) a_0, ...
      $
      Again, all odd terms are zero. Therefore, the even terms give another solution (relabelling constant to $b_0$):
      $
        y_2(x) = b_0 x^((1)/(2)) [1 + (x^2)/(2 times 5) + (3 x^4)/(4times 9times 2times 5) + ... ].
      $
      Note that this is not a #ponder("calculus.taylor-series")[Taylor series] but a #ponder("ode.frobenius-method")[Frobenius series] solution.


  Therefore, there are two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] solutions at this #ponder("ode.singular-point")[regular singular point].
] <ex-series-solutions-about-regular-singular-point>

#remark[
  In @ex-series-solutions-about-regular-singular-point we have found 2 independent solutions, but it is not generally the case.
]

== Second Solutions


Note that we are guaranteed to get one #ponder("ode.series-solution")[series solution] about a #ponder("ode.singular-point")[regular singular point], but whether we get a second #ponder("linear-algebra.linearly-independent-functions")[linearly independent] such solution depends on the roots of the indicial equation, $sigma_1$ and $sigma_2$.

1. If $sigma_1 - sigma_2$ is not an integer, then we get two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.series-solution")[series solutions], in the form
  $
    y_1 & = (x - x_0)^(sigma_1) sum_(n=0)^oo a_n (x - x_0)^n, \
    y_2 & = (x - x_0)^(sigma_2) sum_(n=0)^oo b_n (x - x_0)^n.
  $

2. If $sigma_2 - sigma_1$ is a non-zero integer, then we get one #ponder("ode.series-solution")[series solution] involving the larger root, say $sigma_2$.
  $
    y_1 = (x - x_0)^(sigma_2) sum_(n=0)^oo a_n (x - x_0)^n.
  $
  The second solution has the form:
  $
    y_2 = (x-x_0)^(sigma_1) sum_(n=0)^oo b_n (x - x_0)^n + C y_1 ln (x - x_0),
  $
  where $C$ may or may not be zero. $C$ is a constant determined in terms of $a_0$ and $b_0$, so that we have two arbitrary constants as required.

3. If $sigma_1 = sigma_2 = sigma$, our solutions is similar to case (2), but the logarithmic term is always present.

#example[#ponder("ode.series-solution")[Series solution] as in case (2)][
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    x^2 y'' - x y = 0.
  $
  We know that $x=0$ is a #ponder("ode.singular-point")[regular singular point]. We shall try a #ponder("ode.frobenius-method")[Frobenius series] solution of the form
  $ y(x) = sum_(n=0)^oo a_n x^(n+sigma) quad (a_0 != 0). $
  Substituting into the #ponder("ode.ordinary-differential-equation")[ODE] gives
  $
    sum_(n=0)^oo [a_n (n+sigma) (n + sigma - 1) x^(n + sigma) - a_n x^(n + sigma + 1)] & = 0.
  $

  - The lowest power is $x^(sigma)$ with $n = 0$.
    $
      a_0 sigma (sigma - 1) & = 0 \
          sigma (sigma - 1) & = 0 quad ("indicial equation") \
    $
    Therefore, $sigma_1 = 0$ and $sigma_2 = 1$. Since $sigma_2 - sigma_1 = 1$ is a non-zero integer, we are in case (2).

  - For $n >= 1$, we get

    $
      a_n (n + sigma) ( n + sigma -1) - a_(n-1) & = 0 \
    $

    - For $sigma_2 = 1$, we have
      $
        a_n = (a_(n-1))/(n (n + 1)) = (a_0)/(n! (n + 1)!).
      $
      Therefore,
      $
        y_1 = a_0 x (1 + (x)/(2) + (x^2)/(12) +...)
      $
      which is a #ponder("calculus.taylor-series")[Taylor series] solution.

    - For $sigma_1 = 0$, we have
      $
        (n (n - 1)) a_n = a_(n-1).
      $
      Note that when $n=1$, we have $0 = a_0$, which is a contradiction. Therefore, we cannot find a #ponder("ode.series-solution")[series solution] for $sigma = 0$. Hence consider the form

      $
        y_2 = sum_(n=0)^oo b_n x^(n) + C y_1 ln (x).
      $
      We can determine ${b_n}$ and $C$ by direct substitution into the #ponder("ode.ordinary-differential-equation")[ODE], or we can use the reduction of order method discussed earlier.



]
