#import "../prelude.typ": *

#lecture-separator(lecture: 11, date: "2025-11-03")

= Higher Order #ponder("ode.linear-differential-equation")[Linear] #ponder("ode.ordinary-differential-equation")[ODEs]

We shall focus on #ponder("ode.order")[2nd order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODEs], but many methods are also applicable to higher order #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODEs].

Different to the 1st order case, closed form solutions to #ponder("ode.order")[2nd order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODEs] don't always exist.

== #ponder("ode.order")[2nd Order] #ponder("ode.ordinary-differential-equation")[ODEs] with #ponder("ode.constant-coefficients")[Constant Coefficients]

The general form of a #ponder("ode.order")[2nd order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE] with #ponder("ode.constant-coefficients")[constant coefficients] is
$
  underbracket(a (dif^(2) y)/(dif x^(2)) + b (dif y)/(dif x) + c y, cal(D)(y)) = f(x)
$
where $a, b, c$ are constants and $f(x)$ is a given function, and $cal(D)$ is the differential operator
$
  cal(D) equiv a (dif^(2))/(dif x^(2)) + b (dif)/(dif x) + c
$
which is #ponder("ode.linear-differential-operator")[linear].

#definition[Linear differential operator][
  A differential operator $cal(D)$ is *#ponder("ode.linear-differential-operator")[linear]* if for any functions $y_1(x), y_2(x)$ and constants $alpha, beta in RR$,
  $
    cal(D)(alpha y_1 + beta y_2) = alpha cal(D)y_1 + beta cal(D)y_2,
  $
  which is called the #ponder("ode.linear-differential-operator")[principle of superposition].
] <linear-differential-operator>

We can exploit the #ponder("ode.linear-differential-operator")[linearity] of $cal(D)$ to solve #ponder("ode.order")[2nd order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODEs].

1. Find the #ponder("ode.particular-integral")[complementary functions] that satisfy the #ponder("ode.homogeneous-differential-equation")[homogeneous equation]:

  $
    cal(D)(y_c) = 0.
  $

2. Find a #ponder("ode.particular-integral")[particular integral] $y_p$ that satisfies the non-#ponder("ode.homogeneous-differential-equation")[homogenous] equation:

  $
    cal(D)(y_p) = f(x).
  $

3. A solution of the full equation is then given by

  $
    y = y_c + y_p,
  $
  since by #ponder("ode.linear-differential-operator")[linearity], $cal(D)(y_c + y_p) = cal(D)(y_c) + cal(D)(y_p) = 0 + f(x) = f(x)$.

A #ponder("ode.order")[2nd order] #ponder("ode.ordinary-differential-equation")[ODE] has *two* #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary functions], so the general solution to the full equation is
$
  y(x) = C_1 y_(c_1)(x) + C_2 y_(c_2)(x) + y_p (x),
$

#definition[Linearly dependent functions][
  A set of $N$ functions ${f_i (x)}$ is *#ponder("linear-algebra.linearly-dependent-functions")[linearly dependent]* if there exist $N$ constants $c_i$, not all zero, such that
  $ sum_(i=1)^N c_i f_i (x) = 0 quad forall x. $
] <linearly-dependent-functions>

#definition[Linearly independent functions][
  A set of functions is *#ponder("linear-algebra.linearly-independent-functions")[linearly independent]* if it is not #ponder("linear-algebra.linearly-dependent-functions")[linearly dependent].
] <linearly-independent-functions>

One can compare the two definitions above with the definition of vectors.

#remark[
  Equivalently, if one or more of the functions $f_i (x)$ can be written as a linear combination of the others, then the set is #ponder("linear-algebra.linearly-dependent-functions")[linearly dependent].
]

== #ponder("ode.particular-integral")[Complementary Functions]

Recall that
$
  (dif )/(dif x) ee^(lambda x) = lambda ee^(lambda x)
$
so $ee^(lambda x)$ is also an #ponder("ode.eigenfunction")[eigenfunction] of $cal(D)$, where

$
  cal(D)(ee^(lambda x)) = underbracket((a lambda^(2) + b lambda + c), "eigenvalue") ee^(lambda x).
$

The #ponder("ode.particular-integral")[complementary functions] satisfy $cal(D) y_c = 0$, _i.e._ $y_n$ are #ponder("ode.eigenfunction")[eigenfunctions] of $cal(D)$ with eigenvalue $0$.

#remark[
  We can prove that the #ponder("ode.eigenfunction")[eigenfunctions] of a #ponder("ode.linear-differential-operator")[linear differential operator] with #ponder("ode.constant-coefficients")[constant coefficients] are of the form $ee^(lambda x)$.
]

Therefore, $y_c = A ee^(lambda x)$ with $lambda$ satisfying the *characteristic equation* of $cal(D)$:
$ a lambda^(2) + b lambda + c = 0. $

There are two roots, $lambda_1, lambda_2$, to the characteristic equation, which can be real or complex.

- *Case 1: $lambda_1 != lambda_2$*

  We have two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary functions]:
  $
    y_(c_1) prop ee^(lambda_1 x), quad y_(c_2) prop ee^(lambda_2 x).
  $
  Hence, the most general #ponder("ode.particular-integral")[complementary function] is
  $
    y_c = C_1 y_(c_1)(x) + C_2 y_(c_2)(x).
  $

  In the language of linear algebra, the space of #ponder("ode.particular-integral")[complementary functions] is a 2-dimensional vector space spanned by the basis ${y_(c_1), y_(c_2)}$.

  #remark[
    The roots may be complex, which will lead to oscillations.
  ]

- *Case 2: $lambda_1 = lambda_2$* (degenerate case)

  We only have one #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary function] $y_c prop ee^(lambda_1 x)$. See the following examples to find the second #ponder("ode.particular-integral")[complementary function].

#example[Real, non-degenerate roots][
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    (dif^(2) y)/(dif x^(2)) - 5 (dif y)/(dif x) + 6 y = 0.
  $
  The characteristic equation is
  $
    lambda^(2) - 5 lambda + 6 = 0,
  $
  which has roots $lambda_1 = 2, lambda_2 = 3$.

  Therefore, the general #ponder("ode.particular-integral")[complementary function] is
  $
    y_c (x) = A ee^(2x) + B ee^(3x).
  $
  where $A, B$ are constants.
]

#example[Complex, non-degenerate roots][
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    (dif^(2) y)/(dif x^(2)) + 4 y = 0.
  $
  The characteristic equation is
  $
    lambda^(2) + 4 = 0,
  $
  which has roots $lambda = plus.minus 2ii$.

  Therefore, the general #ponder("ode.particular-integral")[complementary function] is
  $
    y_c (x) = A ee^(2ii x) + B ee^(-2ii x).
  $

  Note that using Euler's formula, we can rewrite this as
  $
    y_c (x) = alpha cos(2x) + beta sin(2x),
  $
  where $alpha, beta$ are constants ($alpha = A + B$, $beta = ii (A - B)$).
]

#lecture-separator(lecture: 12, date: "2025-11-05")

#example[Degenerate roots and "detuning"][
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    (dif^(2) y)/(dif x^(2)) - 4 (dif y)/(dif x) + 4 y = 0.
  $
  The characteristic equation is
  $
    lambda^(2) - 4 lambda + 4 = 0,
  $
  which has a degenerate root $lambda_1 = lambda_2 = 2$.

  We only have one #ponder("ode.particular-integral")[complementary function] $y_c prop ee^(2x)$.

  To find the second #ponder("ode.particular-integral")[complementary function], we can "detune" the equation slightly to remove the degeneracy, by considering a slightly modified equation:

  $
    (dif^(2) y)/(dif x^(2)) - 4 (dif y)/(dif x) + (4 - epsilon^2) y = 0,
  $
  where $epsilon << 1$.

  Then the characteristic equation is
  $
    lambda^(2) - 4 lambda + (4 - epsilon^2) = 0,
  $
  which has roots $lambda_1 = 2 + epsilon, lambda_2 = 2 - epsilon$.

  Hence, the general #ponder("ode.particular-integral")[complementary function] is
  $
    y_c &= A ee^((2+epsilon) x) + B ee^((2-epsilon) x)\
    &= ee^(2x) (A ee^(epsilon x) + B ee^(-epsilon x)) \
    &= ee^(2x) [(A+B) + epsilon (A-B) x + O(A epsilon^2) + O(B epsilon^2 x^2)] quad "as" epsilon -> 0. quad ("Taylor series") \
  $

  Consider the initial conditions $y(0) = C$, $y'(0) = D$ to both the original and detuned equations. We have

  $
                                              A + B & = C \
    2C+epsilon underbracket((A-B), 2A-C\ "or" C-2B) & =D \
              cases(
                A & = (1)/(2) (C+(D-2C)/(epsilon)),
                B & = (1)/(2) (C-(D-2C)/(epsilon))
              )
  $
  Therefore,
  $ O(A epsilon^2 x^2) = O(epsilon x^2) -> 0 quad "as" epsilon -> 0. $
  We have
  $
    alpha & = A + B        & = & O(1) \
     beta & = epsilon(A-B) & = & O(1).
  $
  Therefore, we can write the general #ponder("ode.particular-integral")[complementary function] as
  $
    y_c (x) = (A + B) ee^(2x) + epsilon (A - B) x ee^(2x) = alpha ee^(2x) + beta x ee^(2x).
  $
]

*General rule.* If $y_(c_1) (x)$ is a degenerate #ponder("ode.particular-integral")[complementary function] of #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE] with #ponder("ode.constant-coefficients")[constant coefficients], then
$ y_(c_2) (x) = x y_(c_1) (x) $
is a second #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary function].

== #ponder("ode.homogeneous-differential-equation")[Homogeneous] #ponder("ode.order")[2nd Order] #ponder("ode.ordinary-differential-equation")[ODEs] with Non-#ponder("ode.constant-coefficients")[Constant Coefficients]

The general form of this kind of #ponder("ode.ordinary-differential-equation")[ODE] is
$
  y'' + p(x) y' + q(x) y = 0.
$

=== Second #ponder("ode.particular-integral")[Complementary Function] – Reduction of Order

We wish to find a 2nd solution $y_2 (x)$ given one solution $y_1 (x)$.

We will try from the form

$ y_2 (x) = v(x) y_1 (x) $

where $v(x)$ is an unknown function to be determined.
We have
$
   y'_2 & = v' y_1 + v y'_1, \
  y''_2 & = v'' y_1 + 2 v' y'_1 + v y''_1.
$

Substituting into the #ponder("ode.ordinary-differential-equation")[ODE], we get
$
  v'' y_1 + (2 y'_1 + p y_1) v' + underbracket((y''_1 + p y'_1 + q y_1), "same ODE for" y_1\ =0) v = 0.
$

Therefore,
$
  v'' y_1 + (2 y'_1 + p y_1) v' = 0.
$

Let $u = v'$, then
$
  u' y_1 + (2 y'_1 + p y_1) u = 0.
$
This is a #ponder("ode.separable-equation")[separable] #ponder("ode.order")[1st order] #ponder("ode.ordinary-differential-equation")[ODE] for $u$:
$
  (dif u)/(u) = - (2 y'_1)/(y_1) - p dif x.
$
Integrating both sides, we get
$
  ln abs(u) & = -2 ln y_1 - integral_0^x p(t) dif t + ln A \
       u(x) & = (A)/(y_1^2) exp[-integral_(0)^x p(t) dif t]. \
$
Hence, we can integrate $u$ to find $v$, and then find $y_2$.

We shall see an example with #ponder("ode.constant-coefficients")[constant coefficients] first.

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    y''-4y'+4y=0
  $
  where we have $p(x)=-4$, $q(x)=4$.

  One solution is $y_1 (x) = ee^(2x)$. Therefore,

  $
    u'/u & = -4+4 = 0 \
       u & = "constant" \
  $
  Hence, $v' = "constant"$, so $v(x) = A x + B$.

  Therefore, the second solution is
  $
    y_2 (x) = v(x) y_1 (x) = (A x + B) ee^(2x).
  $
  Hence $x ee^(2x)$ is a second #ponder("linear-algebra.linearly-independent-functions")[linearly independent] solution.
]

=== Phase Space

For an #ponder("ode.order")[$n$th order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE]

$
  y^(n) + p(x) y^(n-1) + ... + q(x) y = f(x).
$

$y^(n)(x)$ is determined by $y(x), y'(x), ..., y^(n-1)(x)$, and higher derivatives are determined by differentiating the ODE.

Hence, we can construct #ponder("calculus.taylor-series")[Taylor series] about $x_0$ if $y(x_0), ..., y^(n-1)(x_0)$ are specified.

We say that the state of the system at any $x$ is fully specified by an $n$-dimensional solution vector.

$
  bold(Y)(x) = vec(y(x), y'(x), dots.v, y^(n-1)(x)).
$

#remark[

  - At any $x$, $bold(Y)(x)$ defines a point in $n$-dimensional phase space.

  - As $x$ varies, $bold(Y)(x)$ traces out a trajectory in phase space.
]

#example[
  Consider the #ponder("ode.order")[2nd order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE]
  $
    y'' + 4y = 0.
  $
  We know that the solutions are

  $ y_1(x) = cos 2x ,quad y_2(x) = sin 2x. $

  Hence the solution vectors are

  $
    bold(Y_1)(x) & = vec(cos 2x, -2 sin 2x) \
    bold(Y_2)(x) & = vec(sin 2x, 2 cos 2x).
  $
  In this case we have a 2D phase space.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d7e1.svg", width: 20em)
  ]

  Note that $bold(Y)_1 (x)$ and $bold(Y)_2 (x)$ are #ponder("linear-algebra.linearly-independent-functions")[linearly independent] vectors, so we can use them as a basis for the phase space.
]

=== #ponder("linear-algebra.wronskian")[Wronskian] and #ponder("linear-algebra.linearly-dependent-functions")[Linear Dependence]

Recall that ${y_i (x)}$ are #ponder("linear-algebra.linearly-dependent-functions")[linearly dependent] if there exist constants $c_i$, not all zero, such that
$ sum_(i=1)^N c_i y_i (x) = 0 quad forall x. $

Hence, we can differentiate this equation $N-1$ times to get

$
  sum_(i=1)^N c_i bold(Y)_i (x) = bold(0) quad forall x.
$

so ${y_i}$ being linearly dependent implies that ${bold(Y)_i}$ is linearly dependent.

#definition[Fundamental matrix][
  Given $n$ solution vectors ${bold(Y)_i (x)}$ of an #ponder("ode.order")[$n$th order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE],
  the *fundamental matrix* is the $n times n$ matrix whose columns are the solution vectors:

  $
    mat(
      bar, bar, , bar;
      bold(Y_1), bold(Y_2), dots.c, bold(Y_n);
      bar, bar, , bar
    )
  $
] <fundamental-matrix>


#definition[Wronskian][
  The *#ponder("linear-algebra.wronskian")[Wronskian]* of the functions ${y_i (x)}$ is defined as the determinant of the #ponder("linear-algebra.fundamental-matrix")[fundamental matrix]:
  $
    W(x) & = det[
             mat(
               bar, bar, , bar;
               bold(Y_1), bold(Y_2), dots.c, bold(Y_n);
               bar, bar, , bar
             )
           ] \
         & = mat(
             delim: "|",
             y_1, y_2, dots.c, y_n;
             y'_1, y'_2, dots.c, y'_n;
             dots.v, dots.v, , dots.v;
             y^(n-1)_1, y^(n-1)_2, dots.c, y^(n-1)_n
           ).
  $
] <wronskian>

From the above, if ${y_i (x)}$ are #ponder("linear-algebra.linearly-dependent-functions")[linearly dependent], then $W(x) = 0$ for all $x$.

It follows that if $W(x_0) != 0$ for some $x_0$, then ${y_i (x)}$ are #ponder("linear-algebra.linearly-independent-functions")[linearly independent].

#important[
  $W(x) = 0$ for all $x$ does not necessarily imply that ${y_i (x)}$ are linearly dependent.
]

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    y'' + 4 y = 0.
  $

  The #ponder("linear-algebra.wronskian")[Wronskian] of the two solutions $y_1 (x) = cos 2x$, $y_2 (x) = sin 2x$ is
  $
    W(x) & = mat(
             delim: "|",
             cos 2x, sin 2x;
             -2 sin 2x, 2 cos 2x
           ) \
         & = 2 (cos^2 2x + sin^2 2x) = 2.
  $
  Hence the two solutions are #ponder("linear-algebra.linearly-independent-functions")[linearly independent].
]

#lecture-separator(lecture: 13, date: "2025-11-07")

=== #ponder("ode.abels-theorem")[Abel's Theorem]

#theorem[Abel's Theorem][
  Given any 2 solutions of
  $ y'' + p(x) y' + q(x) y = 0, $
  if $p(x)$ and $q(x)$ are continuous on an interval $I$, then either the #ponder("linear-algebra.wronskian")[Wronskian] $W(x) = 0$ for all $x in I$ or $W(x) != 0$ for all $x in I$.
] <abels-theorem>

#prooflike("Sketch Proof")[
  We have
  $
     W & =y_1 y'_2 - y_2 y'_1 \
    W' & = y_1 y''_2 + y'_1 y'_2 - y'_2 y'_1 - y_2 y''_1 \
       & = y_1 y''_2 - y_2 y''_1 \
       & = -y_1 (p y_2' + q y_2) + y_2 (p y_1' + q y_1) \
       & = -p W.
  $
  This is a #ponder("ode.separable-equation")[separable] #ponder("ode.ordinary-differential-equation")[ODE] for $W$:
  $
    (dif W)/(W) & = -p(x) dif x \
              W & = W(x_0) underbracket(exp[- integral_(x_0)^x p(u) dif u], "never zero") quad ("Abel's identity").
  $
  Hence, if $W(x_0) = 0$, then $W(x) = 0$ for all $x in I$; otherwise, $W(x) != 0$ for all $x in I$.
]

The geometric interpretation is that the solution vectors are either always collinear or never collinear in the phase space.

#corollary[
  If $p(x) = 0$, then the #ponder("linear-algebra.wronskian")[Wronskian] is constant.
]

We can find $W(x)$ without knowing the solutions explicitly.

#example[Bessel's equation][
  Consider
  $
                                x^2 y''+x y' + (x^2-n^2) y & = 0 \
    y'' + underbracket((1)/(x), p()) y' + (1-(n^2)/(x^2))y & = 0. \
  $
  Then, Abel's identity gives
  $
    W(x) = W(x_0) exp[- integral_(x_0)^x (1)/(t) dif t] = W(x_0) (x_0)/(x).
  $
]

#remarklike[Application][
  Abel's identity can be usde to find a second solution $y_2$ given a known solution $y_1$. Consider that we have
  $ y_1y'_2 - y_2y'_1 = W(x_0) exp[-integral_(x_0)^x p(u) dif u]. $
  Dividing both sides by $y_1^2$, we get
  $
    (dif)/(dif x) (y_2 / y_1) = (W(x_0))/(y_1^2) exp[- integral_(x_0)^x p(u) dif u].
  $
  This is the same as we had using reduction of order.
]

#ponder("ode.abels-theorem")[Abel's theorem] can be generalised.

#theorem[Generalisation of #ponder("ode.abels-theorem")[Abel's Theorem]][
  #ponder("ode.abels-theorem")[Abel's theorem] holds for solutions of #ponder("ode.order")[$n$th order] #ponder("ode.homogeneous-differential-equation")[homogeneous] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODEs].
]

== Linear #ponder("ode.equidimensional-ode")[Equidimensional ODEs]

These #ponder("ode.ordinary-differential-equation")[ODEs] are related to #ponder("ode.ordinary-differential-equation")[ODEs] with #ponder("ode.constant-coefficients")[constant coefficients].

#definition[Linear 2nd order equidimensional ODE][
  A #ponder("ode.linear-differential-equation")[linear] #ponder("ode.order")[2nd order] #ponder("ode.ordinary-differential-equation")[ODE] is *#ponder("ode.equidimensional-ode")[equidimensional]* if it is of the form
  $
    a x^2 y'' + b x y' + c y = f(x),
  $
  where $a, b, c$ are constants.
] <equidimensional-ode>

#proposition[Scaling property of solutions of the #ponder("ode.homogeneous-differential-equation")[homogeneous] equation][
  If $g(x)$ is a solution of the #ponder("ode.homogeneous-differential-equation")[homogeneous] #ponder("ode.equidimensional-ode")[equidimensional ODE] with $f(x)=0$, then so is $y = g( alpha x)$ for any constant $alpha$.
]

#proof[
  We have

  $
       (dif g(alpha x))/(dif x) & = (dif g (alpha x))/(dif (alpha x) dif(alpha x)/(dif x)) = g'(alpha x) alpha \
              x (dif y)/(dif x) & = (alpha x) g'(alpha x) \
    x^2 (dif^(2) y)/(dif x^(2)) & = (alpha x)^2 g''(alpha x).
  $
  Therefore,

  $
    a x^2 (dif^(2) y)/(dif x^(2)) + b x (dif y)/(dif x) + c y & = a (alpha x)^2 g''(alpha x) + b (alpha x) g'(alpha x) + c g(alpha x) \
    & = a u^2 g''(u) + b u g'(u) + c g(u).\
    &= 0 quad "(since" g "is a solution of the homogeneous equation)" \
  $
]

=== Solving by #ponder("ode.eigenfunction")[Eigenfunctions]

$ x (dif )/(dif x) (x^k) & = k x^k \ $
so $x^k$ is an #ponder("ode.eigenfunction")[eigenfunction] of the operator $x (dif )/(dif x)$ with eigenvalue $k$.

It suggests that we should look for #ponder("ode.particular-integral")[complementary functions] of the form $y = x^k$. Substituting into the #ponder("ode.homogeneous-differential-equation")[homogeneous equation], we get

$
  x^k [a k (k-1) + b k + c] & = 0 quad "for all" x \
        a k (k-1) + b k + c & = 0 \
      a k^2 + (b - a) k + c & = 0.
$
Let the solutions be $k_1, k_2$. Then the #ponder("ode.particular-integral")[complementary functions] are
$ y_c (x) = C_1 x^(k_1) + C_2 x^(k_2). $
if $k_1 != k_2$.

=== Solving by Substitution <sec-equidimensional-substitution>

Substitute $z = ln x$, then
$
  (dif y)/(dif z) & = (dif x)/(dif z) (dif y)/(dif x) \
  (dif^(2) y)/(dif z^(2)) & = underbracket(e^z (dif y)/(dif x), x (dif y)/(dif x)) + underbracket(e^(2z) (dif^(2) y)/(dif x^(2)), x^2 (dif^2 y)/(dif x^2)).
$
Substituting into the #ponder("ode.ordinary-differential-equation")[ODE], we get
$
  a ((dif^(2) y)/(dif z^(2)) - (dif y)/(dif z) ) + b (dif y)/(dif z) + c y & = f(e^z) \
                 a (dif^(2) y)/(dif z^(2)) + (b - a) (dif y)/(dif z) + c y & = f(e^z).
$

Now we have a #ponder("ode.linear-differential-equation")[linear ODE] with #ponder("ode.constant-coefficients")[constant coefficients] in the variable $z$, which we can solve using the methods discussed earlier. The characteristic equation is
$
  a lambda^2 + (b - a) lambda + c = 0.
$

This is the same characteristic equation as before when we tried the #ponder("ode.eigenfunction")[eigenfunction] method. The #ponder("ode.particular-integral")[complementary functions] are therefore, if $k_1 != k_2$,

$
  y_c (x) = C_1 ee^(k_1 z) + C_2 ee^(k_2 z)\
  y_c (x) = C_1 x^(k_1) + C_2 x^(k_2).
$

We can now deal with the degenerate case $k_1 = k_2$ similarly as before.

$
  y_c(x) = A ee^(k_1 z) + B z ee^(k_1 z) \
  y_c(x) = A x^(k_1) + B (ln x) x^(k_1).
$

== In#ponder("ode.homogeneous-differential-equation")[homogeneous] (Forced) #ponder("ode.order")[2nd Order] #ponder("ode.ordinary-differential-equation")[ODEs]

We will discuss the methods to find #ponder("ode.particular-integral")[particular integrals].

=== #ponder("ode.constant-coefficients")[Constant Coefficient] #ponder("ode.ordinary-differential-equation")[ODEs]

We have the form
$
  a (dif^(2) y)/(dif x^(2)) + b (dif y)/(dif x) + c y = f(x).
$

Now, use the following ansatz for $y_p$ depending on the form of $f(x)$:

#table(
  columns: (1fr, 1fr),
  [*$f(x)$*], [*Try $y_p$ of the form*],
  $ee^(m x)$, $A ee^(m x)$,
  [$cos(m x)$ or $sin(m x)$], $A cos(m x) + B sin(m x)$,
  [Polynomial of degree $n$], [$a_n x^n + a_(n-1) x^(n-1) + ... + a_1 x + a_0$],
)

We can determine the constants by substituting into the ODE. Since the #ponder("ode.ordinary-differential-equation")[ODE] is #ponder("ode.linear-differential-equation")[linear], we can superpose terms.

#lecture-separator(lecture: 14, date: "2025-11-10")

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    y''-5y'+6y=2x+ee^(4 x).
  $

  We shall try a #ponder("ode.particular-integral")[particular integral] of the form
  $
    y_p (x) = underbracket(A x + B, "for" 2x)+ underbracket(C ee^(4 x), "for" ee^(4 x)).
  $
  Substituting into the #ponder("ode.ordinary-differential-equation")[ODE], we get
  $
    y''_p - 5 y'_p + 6 y_p & = 2x + ee^(4 x) \
                           & = 6 (A x + B) - 5 A + 6 C ee^(4 x) - 20 C ee^(4 x) + 16 C ee^(4 x) \
                           & = 6 A x + (6 B - 5 A) + 2 C ee^(4 x). \
  $
  Equating coefficients, we have
  $
          6 A & = 2 \
    6 B - 5 A & = 0 \
          2 C & = 1. \
  $
  Therefore, $A = 1/3$, $B = 5/18$, $C = 1/2$.

  The #ponder("ode.particular-integral")[complmentary function], as discussed earlier, is
  $ y_c (x) = alpha ee^(2 x) + beta ee^(3 x). $

  Hence, the general solution is
  $ y (x) = alpha ee^(2 x) + beta ee^(3 x) + (1/3) x + (5/18) + (1/2) ee^(4 x) $
  where $alpha, beta$ are constants.
]

If the forcing term $f(x)$ involves a term that is in a #ponder("ode.particular-integral")[complementary function], a #ponder("ode.resonance")[resonance] case occurs. In this case, we carry out detuning.

#example[Resonance][
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    dot.double(y) + omega_0^2 y = sin(omega_0 x)
  $
  which represents a simple harmonic oscillator driven at its natural frequency $omega_0$. We say that this oscillator is driven #ponder("ode.resonance")[resonantly]. We have the comcomplementary functions
  $
    y_c (x) = A cos(omega_0 x) + B sin(omega_0 x).
  $
  Since $sin(omega_0 x)$ is already in the #ponder("ode.particular-integral")[complementary function], we consider detuning by looking at the slightly modified equation
  $
    dot.double(y) + omega_0^2 y = sin(omega x)
  $
  with $omega != omega_0$.

  We try a #ponder("ode.particular-integral")[particular integral] of the form
  $
    y_p (x) = C sin(omega x) + D cos(omega x).
  $
  We can see that $D$ must be zero since there is no $cos(omega x)$ term on the RHS. Substituting into the #ponder("ode.ordinary-differential-equation")[ODE], we get
  $
    -C omega^2 sin(omega x) + omega_0^2 C sin(omega x) & = sin(omega x) \
                               C (omega_0^2 - omega^2) & = 1 \
                                                     C & = (1)/(omega_0^2 - omega^2).
  $
  Note that the limit $omega -> omega_0$ does not exist since $C$ diverges. We can add in a #ponder("ode.particular-integral")[complementary function] to regularise the limit:
  $
    y_p (t) = (1)/(omega_0^2 - omega^2) (sin(omega t) - sin(omega_0 t)).
  $
  We know that this satisfies the detuned equation. Now, taking the limit $omega -> omega_0$, we have
  $
    lim_(omega -> omega_0) y_p (t) & = lim_(omega -> omega_0) (sin(omega t) - sin(omega_0 t))/(omega_0^2 - omega^2) \
                                   & = lim_(omega -> omega_0) (t cos(omega t))/(-2 omega) \
                                   & = - (t)/(2 omega_0) cos(omega_0 t).
  $
  Therefore, a #ponder("ode.particular-integral")[particular integral] for the #ponder("ode.resonance")[resonant] case is
  $ y_p (x) = - (x)/(2 omega_0) cos(omega_0 x). $
] <ex-resonance>

The general rule is that if the forcing term is a linear combination of #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary functions], the #ponder("ode.particular-integral")[particular integral] is of the form
$
  y_p (t) = t times ("non-resonant particular integrals").
$

#remark[
  If the #ponder("ode.homogeneous-differential-equation")[homogeneous equation] is degenerate, we may need to multiply by higher powers of $t$ to find a #ponder("ode.particular-integral")[particular integral], in the form
  $
    y_p (t) = t^2 times ("non-resonant particular integrals")
  $
  for a 2nd order degenerate case.
]

=== #ponder("ode.equidimensional-ode")[Equidimensional ODEs]

Consider the #ponder("ode.equidimensional-ode")[equidimensional ODE]
$
  a x^2 y'' + b x y' + c y = f(x).
$
We have seen that the #ponder("ode.particular-integral")[complementary functions] are of the form
$
  y_c (x) = A x^(k_1) + B x^(k_2)
$
assuming $k_1 != k_2$.

If $f(x) prop x^m$, we try a #ponder("ode.particular-integral")[particular integral] of the form
$ y_p (x) = C x^m $
for $m != k_1$ and $m != k_2$.

For the #ponder("ode.resonance")[resonance] cases $m = k_1$ or $m = k_2$, then the #ponder("ode.particular-integral")[particular integral] is of the form
$ y_p (x) = (ln x) x^(k_1) $
which follows from @sec-equidimensional-substitution.

#remark[
  If the #ponder("ode.homogeneous-differential-equation")[homogeneous equation] is degenerate, we may need to multiply by higher powers of $ln x$ to find a #ponder("ode.particular-integral")[particular integral], in the form
  $ y_p (x) = (ln x)^2 x^(k_1) $ for a 2nd order degenerate case.
]

== Variation of Parameters

This is a systematic method to find #ponder("ode.particular-integral")[particular integrals] given two #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary functions].

Consider
$ y'' + p(x) y' + q(x) y = f(x) $

with #ponder("linear-algebra.linearly-independent-functions")[linearly independent] #ponder("ode.particular-integral")[complementary functions] $y_1$ and $y_2$.

We will use solution vectors $bold(Y)_1 (x)$ and $bold(Y)_2 (x)$ as a basis in phase space at any $x$ to write the solution vector for the particular integral.

We have
$
  bold(Y_p)(x) = u (x) bold(Y)_1 (x) + v (x) bold(Y)_2 (x).
$
The components are
$
   y_p (x) & = u(x) y_1 (x) + v(x) y_2 (x) \
  y'_p (x) & = u(x) y'_1 (x) + v(x) y'_2 (x) \
$
If we differentiate again, we get
$
  y''_p = u y''_1 + u' y'_1 + v y''_2 + v' y'_2.
$
Subsituting into the #ponder("ode.ordinary-differential-equation")[ODE], we have
$
  (u y''_1 + u' y'_1 + v y''_2 + v' y'_2) + p(u y'_1 + v y'_2) + q (u y_1 + v y_2) & = f(x).
$

Since $y_1, y_2$ are #ponder("ode.particular-integral")[complementary functions], we have
$
  y''_1 + p y'_1 + q y_1 & = 0 \
  y''_2 + p y'_2 + q y_2 & = 0.
$

Therefore,
$ u' y'_1 + v' y'_2 & = f(x). $

Note that the second component of $bold(Y_p)$ must be consistent with the derivative of the first component. Therefore, we have the additional constraint
$
  u'y_1 + u y'_1 + v'y_2 + v y'_2 & = y'_p = u y'_1 + v y'_2 \
                  u' y_1 + v' y_2 & = 0.
$
We now have two equations for $u'$ and $v'$:
$
  u' y'_1 + v' y'_2 & = f(x) \
    u' y_1 + v' y_2 & = 0.
$
We can solve for $u'$ and $v'$:
$
  underbracket(mat(y_1, y_2; y'_1, y'_2), "fundamental matrix") vec(u', v') = vec(0, f).
$

We can therefore invert the #ponder("linear-algebra.fundamental-matrix")[fundamental matrix] to get
$
  vec(u', v') = (1)/(W) mat(y'_2, -y_2; -y'_1, y_1) vec(0, f)
$
$
  u' & = - (y_2 f)/(W) \
  v' & = (y_1 f)/(W).
$
Hence, we can integrate to find $u$ and $v$:
$
  u(x) & = - integral^x (y_2 (t) f(t))/(W(t)) dif t \
  v(x) & = integral^x (y_1 (t) f(t))/(W(t)) dif t.
$
The #ponder("ode.particular-integral")[particular integral] is therefore
$
  y_p (x) = - y_1 (x) integral^x (y_2 (t) f(t))/(W(t)) dif t + y_2 (x) integral^x ( y_1 (t) f(t))/(W(t)) dif t.
$
Note that changing the lower limits of the integrals only adds multiples of #ponder("ode.particular-integral")[complementary functions] to $y_p$.


#lecture-separator(lecture: 15, date: "2025-11-12")

#example[
  Consider
  $ y''+4y=underbracket(sin 2x, f(x)) $
  The #ponder("ode.particular-integral")[complementary functions] are, as we have seen before
  $ y_1 = sin 2x, quad y_2 = cos 2x $

  The #ponder("linear-algebra.wronskian")[Wronskian] is
  $
    W(x) & = mat(
             delim: "|",
             sin 2x, cos 2x;
             2 cos 2x, -2 sin 2x
           ) \
         & = -2 (sin^2 2x + cos^2 2x) = -2.
  $
  Note that the forcing term is #ponder("ode.resonance")[resonant].

  $
    y_p &= -1/2 cos 2x integral^x underbracket(sin 2u sin 2u, (1)/(2 )(1-cos 4u)) dif u -(- 1/2) sin 2x integral^x underbracket(cos 2u sin 2u, (1)/(2) sin 4u) dif u\
    &= -(1)/(4) cos 2x [x - (1)/(4)underbracket(sin 4 x, 2 sin 2x cos 2x)] + (1)/(4) sin 2x [-(1)/(4) underbracket(cos 4 x, 2 cos^2 2x -1)]\
    &= -(1)/(4) underbracket(x cos 2x, x dot "C.F.") + underbracket((1)/(16) sin 2x, "C.F."). \
  $
]

== Forced #ponder("ode.ordinary-differential-equation")[ODEs], Transients and Damping

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d8e1.svg", width: 22em)
]

In the diagram above, by Newton's 2nd Law we have
$
  m dot.double(y) & = sum "forces" \
                  & = -k y - b dot(y) + F(t).
$
Rearranging, we get
$
  m dot.double(y) + b dot(y) + k y = F(t).
$
where $m, b, k$ are positive constants.

For $b = 0$ and $F(t) = 0$, we have simple harmonic motion at angular frequency $omega_0 = sqrt((k)/(m)).$

For convenience, we will add in a dimensionless time coordinate $tau = omega_0 t$. Then we have $(dif y)/(dif t) = omega_0 (dif y)/(dif tau)$. Therefore,
$
  y'' + 2 kappa y' + y = f(tau)
$
where
$ kappa = (b omega_0)/(2k) = (b)/(2 m omega_0), quad f(tau) = (F(tau))/(k). $

=== Free (Unforced) Response

The behavior is described by one dimensionless parameter $kappa$. We have
$
  y'' + 2 kappa y' + y = 0.
$
The characteristic equation is
$
  lambda^2 + 2 kappa lambda + 1 = 0.
$
The roots are
$
  lambda = -kappa plus.minus sqrt(kappa^2 - 1).
$

Depending on the value of $kappa$, we have three cases:

1. *Light damping* (underdamping) when $kappa < 1$.

  In this case, the roots are complex, so we can write
  $ lambda = -kappa plus.minus ii sqrt(1-k^2). $
  So the general solution is
  $
    y(tau) = ee^(-kappa tau) [A sin(sqrt(1-kappa^2) tau) + B cos(sqrt(1-kappa^2) tau)]
  $
  where $A, B$ are constants.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d8e2.svg", width: 18em)
  ]

  This is a oscillation at $omega_"free" = sqrt(1-kappa^2) omega_0$, which tends to $omega_0$ as $kappa -> 0$, with an exponentially decaying amplitude.

  The period is
  $
    T = (2 pi)/(omega_"free") = (2 pi)/(omega_0 sqrt(1-kappa^2)).
  $

2. *Critical damping* when $kappa = 1$.

  We have a degenerate root $lambda = -kappa$.

  The general solution is
  $
    y(tau) = (A + B tau) ee^(-kappa tau)
  $
  where $A, B$ are constants.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d8e3.svg", width: 18em)
  ]

3. *Heavy damping* when $kappa > 1$.

  The roots are real and negative. WLOG take $abs(lambda_1) < abs(lambda_2)$. Then
  $ lambda_1 = -kappa + sqrt(kappa^2 - 1), quad lambda_2 = -kappa - sqrt(kappa^2 - 1). $
  The general solution is
  $
    y(tau) = A ee^(-abs(lambda_1) tau) + B ee^(-abs(lambda_2) tau)
  $
  where $A, B$ are constants. #fade[[$-abs(lambda)$ indicates that the exponentials decay to zero as $tau -> oo$.]] Note that $abs(lambda_1) < abs(lambda_2)$, so the first term dominates the long-term behavior if present.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d8e4.svg", width: 18em)
  ]

Unforced response decays eventually in all cases.

=== Forced Response

Initially, the behavior is determined by $"C.F." + "P.I."$, which is called the *transient response*.

Over time, $"C.F."$ decays, and the behavior is dominated by the $"P.I."$, called the *steady-state response*.

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $ dot.double(y) + mu dot(y) + omega_0^2 y = (F_0)/(m) sin omega t. $
  #fade[[We can relate this back with $mu = (b)/(m)$ and $kappa = (mu)/(2omega_0)$.]]

  Assume light damping with $mu < 2 omega_0$. Then the complementary functions are
  $ y_c (t) = ee^(- (mu)/(2) t) [A sin(omega_"free" t) + B cos(omega_"free" t)] $
  where $omega_"free" = sqrt(omega_0^2 - (mu^2)/(4))$.

  For the #ponder("ode.particular-integral")[particular integral], we try
  $ y_p (t) = (F_0)/(m) (C sin(omega t) + D cos(omega t)). $
  Substituting into the #ponder("ode.ordinary-differential-equation")[ODE], we get
  $
    [-C omega^2 - mu D omega + omega_0^2 C] sin(omega t) + [-D omega^2 + mu C omega + omega_0^2 D] cos(omega t) = sin(omega t).
  $
  Equating coefficients, we have
  $
    D(omega_0^2 - omega^2) & = mu C omega , \
    C(omega_0^2 - omega^2) & = 1 + mu D omega. \
  $
  Eliminating $C$, we have
  $
       - (D(omega_0^2 - omega^2)^2)/(mu omega) & = 1 + mu D omega \
    D [mu^2 omega^2 + (omega_0^2 - omega^2)^2] & = - mu omega \
                                             D & = - (mu omega)/[ (omega_0^2 - omega^2)^2 + mu^2 omega^2 ]. \
  $
  Therefore,
  $
    C & = (omega_0^2 - omega^2)/[ (omega_0^2 - omega^2)^2 + mu^2 omega^2 ].
  $

  Hence,
  $
    y_p (t) = (F_0)/(m) [ (omega_0^2 - omega^2) sin(omega t) - mu omega cos(omega t) ] / [ (omega_0^2 - omega^2)^2 + mu^2 omega^2 ].
  $

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d8e5.svg", width: 18em)
  ]
]

#lecture-separator(lecture: 16, date: "2025-11-14")

== Impulses and Point Forces

Conside a system that experiences a sudden force between time $t = T-epsilon$ and $T+epsilon$.

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d8e6.svg", width: 22em)
]

_e.g._ striking a mass on a spring, or a car going over a curb.

The equation can be in the form
$
  m dot.double(y) + b dot(y) + k y = F(t)
$
which is a forced, damped oscillator.

It is mathamatically convienient to consider the limit of a sudden impluse, as $epsilon -> 0$.

We can integrate the #ponder("ode.ordinary-differential-equation")[ODE] from $T-epsilon$ to $T+epsilon$, and take the limit $epsilon -> 0$.

$
  lim_(epsilon -> 0+) ( m [dot(y)]^(T+epsilon)_(T-epsilon) + b underbracket([y]^(T+epsilon)_(T-epsilon), -> 0 "if" y\ "is continuous") + k underbracket(integral_(T-epsilon)^(T+epsilon) y dif t, ->0 "if" y\ "remains finite") ) = underbracket(lim_(epsilon -> 0+) integral_(T-epsilon)^(T+epsilon) F(t) dif t, "impulse") = I.
$

So we see that
$
  lim_(epsilon->0^+) (m [dot(y)]^(T+epsilon)_(T-epsilon)) = I,
$
and the velocity $dot(y)$ is discontinuous.

As $epsilon ->0$ only impluse $I$ matters for subsequent motion.


#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d8e7.svg", width: 22em)
]

=== #ponder("analysis.dirac-delta-function")[Dirac Delta Function]

We shall formalise the idea of an impulsive force.

Consider a family of functions $D(t; epsilon)$ such that

$
  lim_(epsilon -> 0) D(t;epsilon) = 0 quad forall t != 0
$

and
$
  integral_(-oo)^(oo) D(t; epsilon) dif t = 1. quad ("unit impulse")
$


So the impulsive force we considered earlier is:
$
  F(t) = I D(t- T; epsilon).
$

One example of such a family is
$
  D(t; epsilon) = ee^(-(t^2)/(epsilon^2))/(epsilon sqrt(pi) ).
$
#fade[[See Example Sheet 1, Q14 for normalisation.]]

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d8e8.svg", width: 20em)
]

Note that the family of such functions is not unique, but for any family, $lim_epsilon->0$ yields the #ponder("analysis.dirac-delta-function")[Dirac delta function].

#definition[Dirac delta function][
  The *Dirac delta function* is defined by
  $
    delta(t) -> lim_(epsilon->0) D(t; epsilon).
  $
  It is technically _not_ a function, but a distribution. It only makes sense under an integral.
] <dirac-delta-function>

#proposition[Properties of the #ponder("analysis.dirac-delta-function")[Dirac delta function]][
  The #ponder("analysis.dirac-delta-function")[Dirac delta function] has the following properties:

  1. $delta(t) = 0 quad forall t != 0.$

  2. $integral_(-oo)^(oo) delta(t) dif t = 1.$

  3. (Sampling property.) For all functions $g(t)$ that are continuous at $t= 0$,

    $
      integral_(-oo)^(oo) g(t) delta(t) dif t & = lim_(epsilon->0) integral_(-oo)^(oo) g(t) D(t; epsilon) dif t \
                                         & = g(0) lim_(epsilon->0) integral_(-oo)^(oo) D(t; epsilon) dif t \
                                         & = g(0).
    $



  More generally, for a function $g(t)$ that is continuous at $t = t_0$,

  $
    integral_a^b g(t) delta(t-t_0) dif t = cases(
      g(t_0) quad & "if" a < t_0 < b,
      0 quad & "if" t_0 < a "or" t_0 > b,
      "undefined" quad & "otherwise"
    )
  $
]

=== Delta Function Forcing

Consider the #ponder("ode.ordinary-differential-equation")[ODE]

#set math.equation(numbering: "(*)")
$
  y'' + p(x) y' + q(x) y = delta(x)
$

#set math.equation(numbering: none)

assuming that $p(x)$ and $q(x)$ are continuous.

For $x < 0$ and $x > 0$, we have the #ponder("ode.homogeneous-differential-equation")[homogeneous equation]
$ y'' + p(x) y' + q(x) y = 0. $

But there is a discontinuity in $y'$ at $x = 0$:

$
  lim_(epsilon -> 0^+) integral_(-epsilon)^(epsilon) (*) dif x
  = lim_(epsilon -> 0^+) [y']^(epsilon)_(-epsilon) + p(0) underbracket(lim_(epsilon->0^+) [y]^(epsilon)_(-epsilon), -> 0 "if" y\ "is continuous") + underbracket(lim_(epsilon->0^+) integral_(-epsilon)^(epsilon) q y dif x, -> 0 "if" y "remains finite") = 1.
$
Therefore,
$
  lim_(epsilon -> 0^+) [y']^(epsilon)_(-epsilon) = 1.
$
which is referred to as a *jump condition*.

#remark[
  The continuity of $y$ at $x = 0$ is required, since otherwise $y'$ is undefined at $x = 0$, and $y''$ is even worse-behaved.
]

The general rule for higher order #ponder("ode.ordinary-differential-equation")[ODEs] is that the highest-order term in #ponder("ode.ordinary-differential-equation")[ODE] _addresses_ the delta-function forcing.

#example[
  Consider the #ponder("ode.ordinary-differential-equation")[ODE]
  $
    y'' - y = 3 delta(x - (ppi)/(2))
  $
  with $y = 0$ at $x = 0$ and $x = ppi$. We wish to find $y(x)$ for $0 <= x <= ppi$.

  Note that we will need to solve the two regions $0 <= x < (ppi)/(2)$ and $(ppi)/(2) < x <= ppi$ separately, and match them at $x = (ppi)/(2)$ using the jump condition.

  For $0 <= x < (ppi)/(2)$, we have $y'' - y = 0$, which solves to $y = A sinh x$.

  For $(ppi)/(2) < x <= ppi$, we have $y'' - y = 0$, which solves to $y = C sinh (ppi - x)$.

  We shall now join the two solutions at $x = (ppi)/(2)$.

  - $y$ is continuous, so
    $
      A sinh((ppi)/(2)) = C sinh((ppi)/(2)) \
      A = C.
    $

  - The jump condition gives

    $
      lim_(epsilon -> 0^+) [y']^((ppi)/(2)+epsilon)_((ppi)/(2)-epsilon) & = 3 \
      -A cosh ((ppi)/(2)) - A cosh((ppi)/(2)) & = 3 quad ("by using our two solutions on either side") \
      -2 A cosh((ppi)/(2)) & = 3 \
      A & = - (3)/(2 cosh((ppi)/(2))). \
    $

  Therefore, the solution is
  $
    y(x) = cases(
      - (3 sinh x)/(2 cosh((ppi)/(2))) quad & "for" 0 <= x < (ppi)/(2),
      - (3 sinh(ppi - x))/(2 cosh((ppi)/(2))) quad & "for" (ppi)/(2) < x <= ppi
    ).
  $
]

=== #ponder("analysis.heaviside-step-function")[Heaviside Step Function] $H(x)$

#definition[Heaviside step function][
  The *Heaviside step function* is defined as
  $
       H(x) & = integral_(-oo)^(x) delta(x') dif x' \
    => H(x) & = cases(
                0 quad & "if" x < 0,
                1 quad & "if" x > 0,
                "undefined" quad & "if" x = 0
              )
  $

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d9e1.svg", width: 20em)
  ]
] <heaviside-step-function>

#lecture-separator(lecture: 17, date: "2025-11-17")


By the #ponder("calculus.fundamental-theorem-of-calculus")[fundamental theorem of calculus], we have

$
  (dif H(x))/(dif x) = delta(x).
$

#definition[Ramp function][
  The *ramp function* is defined as
  $
    r(x) = integral_0^(x) H(x') dif x' = cases(
      0 quad & "if" x < 0,
      x quad & "if" x >= 0.
    )
  $

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d9e2.svg", width: 20em)
  ]
]

Note that functions get _smoother_ as we integrate them.

=== Forcing with $H(x)$

Consider the #ponder("ode.ordinary-differential-equation")[ODE]
$
  y'' + p(x) y' + q(x) y = H(x)
$
assuming that $p(x)$ and $q(x)$ are continuous at $x = 0$.

So, we have
$
  y'' + p(x) y' + q(x) y &= cases(
    0 quad & "if" x < 0,
    1 quad & "if" x > 0
  )\
  lim_(epsilon->0^+) integral_(-epsilon)^(epsilon) (y'' + p(x) y' + q(x) y) dif x & = lim_(epsilon->0^+) integral_(-epsilon)^(epsilon) H(x) dif x \
  lim_(epsilon->0^+) [y']^(epsilon)_(-epsilon) + p(0) underbracket(lim_(epsilon->0^+) [y]^(epsilon)_(-epsilon), -> 0 "if" y\ "is continuous") + underbracket(lim_(epsilon->0^+) integral_(-epsilon)^(epsilon) q(x) y dif x, -> 0 "if" y "remains finite") & = 0 \
  lim_(epsilon->0^+) [y']^(epsilon)_(-epsilon) & = 0.
$
Therefore, $y'$ and $y$ is continuous at $x = 0$. We have $y'' ~ H(x)$ around $x = 0$. So, evaluating both sides around $x = 0$,
$
  lim_(epsilon -> 0^+) ( [y'']^(epsilon)_(-epsilon) + p(0) [y']^(epsilon)_(-epsilon) + q(0) [y]^(epsilon)_(-epsilon) ) & = lim_(epsilon->0^+) [H(x)]^(epsilon)_(-epsilon) \
  lim_(epsilon -> 0^+) [y'']^(epsilon)_(-epsilon) & = 1.
$
The jump conditions for #ponder("analysis.heaviside-step-function")[Heaviside function] are
$
   lim_(epsilon->0^+) [y]^(epsilon)_(-epsilon) & = 0 \
  lim_(epsilon->0^+) [y']^(epsilon)_(-epsilon) & = 0.
$

A typical situation is that $y = 0$ for $x < 0$, and we are asked to find $y$ for $x > 0$. This leads to two arbitrary constants, and we can determine them using the two jump conditions.

Or alternatively, we can solve the ODE for $x > 0$ and $x< 0$ by matching at $x = 0$ using the jump conditions.
