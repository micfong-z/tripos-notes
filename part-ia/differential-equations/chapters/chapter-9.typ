#import "../prelude.typ": *

#lecture-separator(lecture: 20, date: "2025-11-24")

= Multivariate Functions: Applications

In this section we will discuss

- directional derivatives
- extrema
- coupled systems of 1st order #ponder("ode.ordinary-differential-equation")[ODEs]
- partial differential equations

== Directional derivatives

Consider $f(x, y)$ and a vector displacement $dif vb(s) = vecrow(dif x, dif y)$.

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d10e1.svg", width: 18em)
]

The infinitesimal change in $f$ along $dif vb(s)$ is given by
$
  dif f & = pdv(f, x) dif x + pdv(f, y) dif y quad ("multivariate chain rule") \
        & = vecrow(dif x, dif y) dot vecrow( pdv(f, x), pdv(f, y) ) \
        & = dif vb(s) dot grad f \
$
where we have defined the #ponder("calculus.gradient")[gradient operator]
$
  grad f = vecrow( pdv(f, x), pdv(f, y) ).
$

If we write $dif vb(s) = dif s vu(s)$ where $vu(s)$ is a unit vector in the direction of $dif vb(s)$, then we have
$
  dif f & = dif s [ vu(s) dot grad f ].
$

#definition[Directional derivative][
  The #ponder("calculus.directional-derivative")[*directional derivative*] of $f$ in the direction of the unit vector $vu(s)$ is defined as
  $
    dv(f, s) = vu(s) dot grad f = cos theta abs(grad f)
  $
  where $theta$ is the angle between $vu(s)$ and $grad f$.

  This is the rate of change of $f(x, y)$ in the direction of $vu(s)$.
] <directional-derivative>

#remark[
  We can define the #ponder("calculus.gradient")[gradient vector] $grad f$ geometrically in the other way round, as the vector such that
  $
    dv(f, s) = vu(s) dot grad f quad forall vu(s).
  $
]

#proposition[Properties of #ponder("calculus.gradient")[gradient vector]][
  1. The direction of $grad f$ is the direction of maximum increase of $f$.

  2. The magnitude of $grad f$ is the maximum rate of change of $f$, _i.e._

    $
      abs(grad f) = max_(forall theta) dv(f, s)
    $

  3. If $vu(s)$ is parallel to contours of $f(x, y)$, then
    $ dv(f, s) = 0 = vu(s) dot grad f. $
    Therefore, $grad f$ is perpendicular to the contours of $f(x, y)$.

] <gradient-vector-properties>

== Stationary Points

There is always at least one direction where $dv(f, s)$ is zero at a given point, namely the direction parallel to the contours of $f(x, y)$ at that point.

So stationary points are the points where
$
  dv(f, s) = 0 quad forall vu(s) <=> grad f = vb(0).
$

=== Types of Stationary Points

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d10e2.svg", width: 40em)

  #dynamic-svg("/part-ia/differential-equations/media/d10e3.svg", width: 40em)

  #dynamic-svg("/part-ia/differential-equations/media/d10e4.svg", width: 40em)
]


Note that contours cross at (and only at) saddle points.

== Classification of Stationary Points

We shall consider how $f$ change in vicinity of a stationary point.

=== #ponder("calculus.taylor-series")[Taylor Series] for Multivariate Functions

Consider how $f(x, y)$ varies along the line
$
  vb(x)(s) = vb(x_0) + s vu(s).
$

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d10e5.svg", width: 20em)
]
Along the line, $f(x(s), y(s))$ is a function of $s$, and we can use the usual #ponder("calculus.taylor-series")[Taylor series] for single variable functions:
$
  f(vb(x_0) + s vu(s)) & = f(vb(x_0)) + s eval(dv(f, s))_(vb(x_0)) + (s^2)/(2!) eval(dv(f, s, 2))_(vb(x_0)) + ... \
  &= f(vb(x_0)) + underbracket(s vu(s) dot eval(grad f)_(vb(x_0)), (1)) + underbracket((s^2)/(2!) eval((vu(s) dot grad)(vu(s) dot grad f))_(vb(x_0)), (2)) + ...
$

We have
$
  (1): & s vu(s) dot grad f & = & delta vb(x) dot grad f \
       &                                  & = & delta x pdv(f, x) + delta y pdv(f, y) \
       & "where" delta vb(x)            & = & s vu(s) = vecrow(delta x, delta y). \
$
and also
$
  (2): & s^2 (vu(s) dot grad) (vu(s) dot grad f) &=& s^2 (hat(s)_x pdv(, x) + hat(s)_y pdv(, y)) (hat(s)_x pdv(f, x) + hat(s)_y pdv(f, y)) \
  & & = & (delta x)^2 pdv(f, x, 2) + 2 (delta x)(delta y) pdv(f, x, y) + (delta y)^2 pdv(f, y, 2) \
  & & = & mat(delta x, delta y) mat(f_(x x), f_(x y); f_(y x), f_(y y)) vec(delta x, delta y) \
$

#definition[Hessian Matrix][
  The #ponder("calculus.hessian-matrix")[*Hessian matrix*] of $f(x, y)$ is defined as
  $
    matbold(H) = grad grad f = mat(f_(x x), f_(x y); f_(y x), f_(y y))
  $
  where $f_(x x) = pdv(f, x, 2)$, $f_(x y) = pdv(f, x, y)$, etc.

  This is a symmetric matrix since $f_(x y) = f_(y x)$.
] <hessian-matrix>

Thus, the multivariate #ponder("calculus.taylor-series")[Taylor series] expansion of $f(x, y)$ about the point $vb(x_0)$ is
$
  f(x_0 + delta x, y_0 + delta y) = f(x_0, y_0) + eval((delta x pdv(f, x) + delta y pdv(f, y)))_(vb(x_0)) + (1/2) eval([(delta x)^2 pdv(f, x, 2) + 2 (delta x)(delta y) pdv(f, x, y) + (delta y)^2 pdv(f, y, 2)])_(vb(x_0)) + ... \
$
We can also write this in coordinate-independent form as
$
  f(vb(x_0) + delta vb(x)) = f(vb(x_0)) + delta vb(x) dot eval(grad f)_(vb(x_0)) + (1/2) (delta vb(x))^TT eval(matbold(H))_(vb(x_0)) (delta vb(x)) + ... \
$

#lecture-separator(lecture: 21, date: "2025-11-26")

=== Nature of Stationary Points and the #ponder("calculus.hessian-matrix")[Hessian]

Suppose $vb(x_0)$ is a stationary point with
$
  eval(grad f)_(vb(x_0)) = vb(0).
$

Around $vb(x_0)$:
$
  f(vb(x)) approx f(vb(x_0)) + (1/2) (delta vb(x))^TT eval(matbold(H))_(vb(x_0)) (delta vb(x))
$
where $delta vb(x) = vb(x) - vb(x_0)$.

#definition[Definiteness of a Matrix][
  A real symmetric matrix $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[*positive definite*] if
  $
    vb(x)^TT matbold(H) vb(x) > 0 quad forall vb(x) != vb(0).
  $
  It is #ponder("linear-algebra.matrix-definiteness")[*negative definite*] if
  $
    vb(x)^TT matbold(H) vb(x) < 0 quad forall vb(x) != vb(0).
  $
  Otherwise, it is #ponder("linear-algebra.matrix-definiteness")[*indefinite*].
] <matrix-definiteness>

- If $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[positive definite] at $vb(x_0)$, then $f(vb(x)) > f(vb(x_0))$ for all $vb(x)$ near $vb(x_0)$, so $vb(x_0)$ is a local minimum.

- If $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[negative definite] at $vb(x_0)$, then $f(vb(x)) < f(vb(x_0))$ for all $vb(x)$ near $vb(x_0)$, so $vb(x_0)$ is a local maximum.

- If $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[indefinite] at $vb(x_0)$, then it may be a maximum, minimum or saddle point.

==== #ponder("linear-algebra.matrix-definiteness")[Definiteness] and Eigenvalues

If $matbold(H)$ is a real symmetric matrix, then we can diagonalise it by an orthogonal transformation (by results in IA Vectors and Matrices). Using coordinates along the principal axes (eigenvectors), in $N$ dimensions:
$
  delta x^TT matbold(H) delta x &= mat(delta x_1, delta x_2, ..., delta x_N) mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_N) vec(delta x_1, delta x_2, dots.v, delta x_N)\
  &= sum_(i=1)^N lambda_i (delta x_i)^2.
$

Hence,

- $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[positive definite] iff all eigenvalues $lambda_i > 0$ (minimum),

- $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[negative definite] iff all eigenvalues $lambda_i < 0$ (maximum),

- If all eigenvalues are non-zero, but are of mixed signs, then this corresponds to a saddle point.

- If any of the eigenvalues are zero, then we need higher order terms in the #ponder("calculus.taylor-series")[Taylor series] to classify the stationary point.

#example[
  Consider $f(x, y) = x^2 + y^4$.

  This function has a (global) minimum at $(0, 0)$ since $f(x, y) >= 0$ for all $(x, y)$. We have

  $
    grad f = vecrow(2x, 4y^3), quad matbold(H) = mat(2, 0; 0, 12y^2).
  $

  At the stationary point $(0, 0)$, the #ponder("calculus.hessian-matrix")[Hessian matrix] is
  $ matbold(H) = mat(2, 0; 0, 0). $
  This has eigenvalues $lambda_1 = 2 > 0$ and $lambda_2 = 0$. Therefore, the #ponder("calculus.hessian-matrix")[Hessian] is #ponder("linear-algebra.matrix-definiteness")[positive semi-definite], and we need to consider higher order terms to classify the stationary point.
]

==== #ponder("linear-algebra.matrix-definiteness")[Definiteness] and #ponder("linear-algebra.signature")[Signature]

An alternative method to determine #ponder("linear-algebra.matrix-definiteness")[definiteness] without having to compute eigenvalues is to use #ponder("linear-algebra.signature")[signatures].

#definition[Signature][
  The #ponder("linear-algebra.signature")[*signature*] of $matbold(H)$ is the pattern of signs of the ordered determinants of the leading principal minors of $matbold(H)$.
] <signature>

#example[
  For a function $f(x_1, x_2, ..., x_N)$, the #ponder("linear-algebra.signature")[signature] if given by the signs of
  $
    mdet(f_(x_1 x_1)), quad mdet(f_(x_1 x_1), f_(x_1 x_2); f_(x_2 x_1), f_(x_2 x_2)), quad ..., quad mdet(f_(x_1 x_1), ..., f_(x_1 x_N); dots.v, dots.down, dots.v; f_(x_N x_1), ..., f_(x_N, x_N)).
  $
  We shall call these determinants $abs(matbold(H_1)), abs(matbold(H_2)), ..., abs(matbold(H_N)) = abs(matbold(H)).$
]

#proposition[Sylvester's Criterion][
  Let $matbold(H)$ be a real symmetric matrix of size $N times N$. Then
  $
    matbold(H) "is a positive definite" & <=> "signature is" +, +, +, +, ..., + \
    matbold(H) "is a negative definite" & <=> "signature is" -, +, -, +, ..., (-1)^N
  $
] <sylvesters-criterion>

=== Contours Near Stationary Points

Suppose $f(x, y)$ has a stationary point at $vb(x_0) = vecrow(x_0, y_0)$. Using coordinates aligned with the principal axes of the #ponder("calculus.hessian-matrix")[Hessian matrix] at $vb(x_0)$, we have
$
  matbold(H)(vb(x_0)) = mat(lambda_1, 0; 0, lambda_2).
$
Assume that the eigenvalues are non-zero. Then, consider
$
  vb(x) = vb(x_0) + (xi, eta),
$
then around $vb(x_0)$ we have
$
  f(vb(x)) approx f(vb(x_0)) + (1/2) (lambda_1 xi^2 + lambda_2 eta^2).
$

On contours near $vb(x_0)$, since $f$ is constant, we have
$
  lambda_1 xi^2 + lambda_2 eta^2 = "constant"
$

- At a maximum or minimum, $lambda_1$ and $lambda_2$ have the same sign, and the contours are ellipses.

- At a saddle point, $lambda_1$ and $lambda_2$ have opposite signs, and the contours are hyperbolae.

#example[
  Consider the stationary points of $f(x, y) = 4 x^3 - 12x y + y^2 + 10 y + 6$.

  We have
  $
    f_x = 12x^2-12 y, quad f_y = -12 x + 2y + 10.
  $
  The stationary points are found by solving $f_x = 0$ and $f_y = 0$ simultaneously:
  $
    f_x = 0 & => y = x^2 \
    f_y = 0 & => -12 x + 2y + 10 = 0 \
            & => -12 x + 2x^2 + 10 = 0 \
            & => x^2 - 6 x + 5 = 0 \
            & => (x - 1)(x - 5) = 0 \
            & => x = 1, 5 \
  $
  Thus, the stationary points are at $(1, 1)$ and $(5, 25)$.

  We have
  $
    f_(x, x) = 24 x, quad f_(x, y) = -12, quad f_(y, y) = 2.
  $
  Hence, the #ponder("calculus.hessian-matrix")[Hessian matrix] is
  $
    matbold(H) = mat(24 x, -12; -12, 2).
  $
  At the stationary point $(1, 1)$, we have
  $
    matbold(H) = mat(24, -12; -12, 2).
  $
  The leading principal minors are
  $
    abs(matbold(H_1)) = 24 > 0, quad abs(matbold(H)) = 24 times 2 - (-12)^2 = -96 < 0.
  $
  Thus, the #ponder("linear-algebra.signature")[signature] is $+, -$, so it is #ponder("linear-algebra.matrix-definiteness")[indefinite]. See that $abs(matbold(H)) != 0$, #fade[[so that eigenvalues are all non-zero,]] and hence $(1, 1)$ is a saddle point.

  At the stationary point $(5, 25)$, we have
  $ matbold(H) = mat(120, -12; -12, 2). $
  The leading principal minors are
  $ abs(matbold(H_1)) = 120 > 0, quad abs(matbold(H)) = 120 times 2 - (-12)^2 = 96 > 0. $

  The #ponder("linear-algebra.signature")[signature] is $+, +$, so it is #ponder("linear-algebra.matrix-definiteness")[positive definite], and hence $(5, 25)$ is a local minimum.

  Near the saddle points, the contours satisfy
  $
    24 (delta x)^2 - 24 (delta x)(delta y) + 2 (delta y)^2 = "constant".
  $
  Here are some plots of the function and its contours:

  #align(center)[
    #dynamic-svg2("/part-ia/differential-equations/media/m1e3.svg", width: 28em)
  ]

  #align(center)[
    #dynamic-svg2("/part-ia/differential-equations/media/m1e2.svg", width: 20em)
  ]

]

#lecture-separator(lecture: 22, date: "2025-11-28")

== Systems of #ponder("ode.linear-differential-equation")[Linear ODEs]


Consider $y_1(t)$ and $y_2(t)$ with
$
  dot(y)_1 & = a y_1 + b y_2 + f_1(t) \
  dot(y)_2 & = c y_1 + d y_2 + f_2(t)
$

where $a$, $b$, $c$, $d$ are constants. We can write this in vector form as
$
  dot(vb(Y)) = matbold(M) vb(Y) + vb(F).
$

where
$
  matbold(M) = mat(a, b; c, d), quad vb(Y) = vec(y_1(t), y_2(t)), quad vb(F) = vec(f_1(t), f_2(t)).
$

There are two ways to solve this system:

1. Convert to a single higher order #ponder("ode.ordinary-differential-equation")[ODE] for one variable.

  We have

  $
    dot.double(y)_1 & = a dot(y)_1 + b dot(y)_2 + dot(f)_1 \
    & = a dot(y)_1 + b (c y_1 + d y_2 + f_2) + dot(f)_1 \
    & = a dot(y)_1 + b c y_1 + d (dot(y)_1 - a y_1 - f_1) + b f_2 + dot(f)_1 \
    dot.double(y)_1 - (a + d) dot(y)_1 + (a d - b c) y_1 &= dot(f)_1 - d f_1 + b f_2 \
  $

  Now we have a #ponder("ode.linear-differential-equation")[linear 2nd order ODE] with #ponder("ode.constant-coefficients")[constant coefficients].

2. Solve directly with matrix methods. #fade[[This may be more convenient.]]

  #remark[
    Under some cases, we write higher order #ponder("ode.ordinary-differential-equation")[ODE] as a set of 1st order #ponder("ode.ordinary-differential-equation")[ODEs], essentially reversing the process above.
    #example[
      Consider the equation
      $
        dot.double(y) + a dot(y) + b y = f.
      $
      We can let $y_1 := y$, $y_2 := dot(y)$ and $vb(Y) = vec(y_1, y_2)$. We then have
      $
        dot(y)_1 & = y_2 \
        dot(y)_2 & = -b y_1 - a y_2 + f
      $
      Hence,
      $
        vb(dot(Y)) = mat(0, 1; -b, -a) vb(Y) + vec(0, f).
      $
    ]
  ]


=== Matrix methods

Consider
$
  vb(dot(Y)) = matbold(M) vb(Y) + vb(F)(t)
$

where $matbold(M)$ is a constant matrix.

1. Write $vb(Y) = vb(Y_c) + vb(Y_p)$ where $vb(Y_c)$ is the #ponder("ode.particular-integral")[complementary function] satisfying $vb(dot(Y)_c) = matbold(M) vb(Y_c)$, and $vb(Y_p)$ is a #ponder("ode.particular-integral")[particular integral].

2. Look for $vb(Y_c)$ of the form $vb(Y_c) = vb(v) ee^(lambda t)$ where $vb(v)$ is a constant vector. Then,

  $
    vb(dot(Y)_c) & = lambda vb(v) ee^(lambda t) = lambda vb(Y_c) = matbold(M) vb(Y_c) \
  $
  Since $lambda vb(Y_c) = matbold(M) vb(Y_c)$ holds for all $t$, taking $t=0$ we have
  $
    matbold(M) vb(v) = lambda vb(v).
  $
  Hence $lambda$ is an eigenvalue of $matbold(M)$, and $vb(v)$ is the corresponding eigenvector.

  For a system of $n$ equations, we have $n$ such complementary functions if eigenvalues are distinct.

3. Find a $vb(Y_p)$ that satisfies $vb(dot(Y)_p) = matbold(M) vb(Y_p) + vb(F)(t)$ by trying an appropriate form.

#example[
  Consider
  $
    vb(dot(Y)) = underbracket(mat(-4, 24; 1, -2), matbold(M)) vb(Y) + underbracket(vec(4, 1) ee^t, vb(F)).
  $
  Write $vb(Y) = vb(Y_c) + vb(Y_p)$, and for $vb(Y_c)$ consider $vb(Y_c) = vb(v) ee^(lambda t)$.

  Then,
  $ matbold(M) vb(v) = lambda vb(v) => abs(matbold(M) - lambda matbold(I)) = 0. $
  We have
  $
    (-4 - lambda)(-2 - lambda) - 24 = lambda^2 + 6 lambda - 16 = 0\
    lambda_1 = 2, quad lambda_2 = -8. \
  $
  The corresponding eigenvectors are
  $
    vb(v)_1 = vec(4, 1), quad vb(v)_2 = vec(-6, 1).
  $
  Hence,
  $
    vb(Y)_c = A vec(4, 1) ee^(2 t) + B vec(-6, 1) ee^(-8 t).
  $
  Try $vb(Y_p) = vb(u) ee^t$. Then,
  $
                              vb(u) & = matbold(M) vb(u) + vec(4, 1) \
    (matbold(I) - matbold(M)) vb(u) & = vec(4, 1) \
                              vb(u) & = (matbold(I) - matbold(M))^(-1) vec(4, 1). \
  $
  Note that an inverse exists since $abs(matbold(I) - matbold(M)) != 0$ ($1$ is not an eigenvalue of $matbold(M)$). We have
  $
    vb(u) = vec(-4, -1).
  $
  Thus, the general solution is
  $
    vb(Y) = A vec(4, 1) ee^(2 t) + B vec(-6, 1) ee^(-8 t) + vec(-4, -1) ee^t.
  $
]

#remark[
  Note, if $vb(F) prop ee^(lambda t)$ with $lambda$ an eigenvalue of $matbold(M)$, then we try $vb(Y_p) = (vb(a) + vb(b) t) ee^(lambda t)$ instead.
]

=== Non-Degenerate #ponder("ode.phase-portrait")[Phase portraits]

#definition[Phase space][
  For $n$ first-order #ponder("ode.ordinary-differential-equation")[ODEs], the #ponder("ode.phase-space")[*phase space*] is an $n$-dimensional space with coordinates given by
  $
    vb(Y) = vec(y_1, y_2, dots.v, y_n).
  $
] <phase-space>

#definition[Phase portrait][
  #ponder("ode.phase-portrait")[*Phase portraits*] are solution trajectories in #ponder("ode.phase-space")[phase space].
] <phase-portrait>

For #ponder("ode.autonomous-system")[autonomous systems], there is one trajectory through each point in #ponder("ode.phase-space")[phase space], except at #ponder("ode.equilibrium-point")[fixed points].

Consider the #ponder("ode.homogeneous-differential-equation")[homogeneous equation]
$
  vb(dot(Y)) = matbold(M) vb(Y).
$

There is a #ponder("ode.equilibrium-point")[fixed point] at $vb(Y) = vb(0)$. For $n = 2$, the general solution for $lambda_1 != lambda_2$ (non-degenerate case) is
$
  vb(Y)(t) & = A vb(v)_1 ee^(lambda_1 t) + B vb(v)_2 ee^(lambda_2 t).
$
where $A, B$ are constants.

For $lambda_1 != 0, lambda_2 != 0$ and $lambda_1 != lambda_2$, we have the following cases:

1. $lambda_1$ and $lambda_2$ are real and of opposite signs. WLOG suppose $lambda_1 > 0 > lambda_2$. In this case, $vb(v_1), vb(v_2)$ can be chosen to be real. The #ponder("ode.equilibrium-point")[fixed point] is a saddle point.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e1.svg", width: 16em)
  ]

2. $lambda_1$ and $lambda_2$ are real and have the same sign. WLOG suppose $abs(lambda_1) > abs(lambda_2)$.

  - If both are positive, then the #ponder("ode.equilibrium-point")[fixed point] is an unstable node.
  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e2.svg", width: 16em)
  ]

  - If both are negative, then the #ponder("ode.equilibrium-point")[fixed point] is a stable node.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e3.svg", width: 16em)
  ]
3. $lambda_1$ and $lambda_2$ are complex conjugates, then $lambda_2 = overline(lambda_1)$ and $vb(v_2) = overline(vb(v_1))$. Then,

  $
    vb(Y)(t) & = C vb(v_1) ee^(re(lambda_1) t) ee^(ii im(lambda_1) t) + overline(C) overline(vb(v_1)) ee^(re(lambda_1) t) ee^(-ii im(lambda_1) t) \
    &= 2ee^(re(lambda_1) t) [[c_1 re(vb(v_1)) - c_2 im(vb(v_1))] cos(im(lambda_1) t) - [c_1 im(vb(v_1)) + c_2 re(vb(v_1))] sin(im(lambda_1) t) ]\
  $
  where $C = c_1 + ii c_2$.

  - If $re(lambda_1) > 0$, then we have a unstable spiral.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e4.svg", width: 16em)
  ]
  - If $re(lambda_1) < 0$, then we have a stable spiral.
  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e5.svg", width: 16em)
  ]

  - If $re(lambda_1) = 0$, then we have a centre, with closed elliptical trajectories.
  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e6.svg", width: 16em)
  ]

#lecture-separator(lecture: 23, date: "2025-12-01")

In order to determine the direction of motion along the trajectories, we can evaluate $vb(dot(Y))$ at some points on the trajectory.

For example, if $dot(y)_2 > 0$ at $vb(Y) = vec(1, 0)$, then motion is upwards at that point, so the direction of motion is counter-clockwise.

== Non-Linear Dynamical Systems

We aim to use techniques for linear systems to investigate the nature of #ponder("ode.equilibrium-point")[equilibrium points].

Consider an #ponder("ode.autonomous-system")[autonomous system] of 2 non-linear first-order #ponder("ode.ordinary-differential-equation")[ODEs]:

$
  dot(x) & = f(x, y) \
  dot(y) & = g(x, y)
$
where $f$ and $g$ are general non-linear functions of $x$ and $y$. #fade[[They do not depend explicitly on $t$.]]

An #ponder("ode.equilibrium-point")[equilibrium (fixed) point] $(x_0, y_0)$ of the system is a point at which $dot(x) = 0$ and $dot(y) = 0$, _i.e._
$
  f(x_0, y_0) = 0 = g(x_0, y_0).
$
We need to solve simultaneously to determine the #ponder("ode.equilibrium-point")[fixed points].

Stabilities of the #ponder("ode.equilibrium-point")[fixed points] can be deduced from perturbation analysis:
$
  (x(t), y(t)) = (x_0 + xi(t), y_0 + eta(t))
$
where $xi(t)$ and $eta(t)$ are small perturbations. We have
$
  dot(x) &= dot(xi) &= f(x_0 + xi, y_0 + eta) &approx underbracket(f(x_0, y_0), = 0 "at fixed point") + xi eval(pdv(f, x))_(x_0, y_0) + eta eval(pdv(f, y))_(x_0, y_0) \
  dot(y) &= dot(eta) &= g(x_0 + xi, y_0 + eta) &approx underbracket(g(x_0, y_0), = 0 "at fixed point") + xi eval(pdv(g, x))_(x_0, y_0) + eta eval(pdv(g, y))_(x_0, y_0) \
$
We can write this in matrix form as
$
  vec(dot(xi), dot(eta)) = underbracket(eval(mat(f_x, f_y; g_x, g_y))_(x_0, y_0), matbold(M)) vec(xi, eta).
$
This is a linear system of #ponder("ode.homogeneous-differential-equation")[homogenous ODEs], and hence the eigenvalues of $matbold(M)$ determine the #ponder("ode.equilibrium-stability")[stability] of the #ponder("ode.equilibrium-point")[fixed point].

#example[Predator-prey model][
  Consider a population of prey $x(t)$ and predators $y(t)$ with the equations
  $
    & "Prey:" quad & dot(x) & = underbracket(alpha, "excess births"\ "over natural deaths") x - underbracket(beta, "competition"\ "over scarce"\ "resources") x^2 - underbracket(gamma x y, "deaths due to"\ "predation")\
    & "Predators:" quad & dot(y) & = underbracket(epsilon x y, "births rate"\ "increases with"\ "predation") - underbracket(delta, "natural"\ "death rate") y \
  $
  where $alpha, beta, gamma, delta, epsilon$ are positive constants.

  Consider a specific case with
  $
    dot(x) & = 8x-2x^2-2x y & = f(x, y) \
    dot(y) & = x y - y      & = g(x, y) \
  $
  The #ponder("ode.equilibrium-point")[fixed points] satisfy
  $
    2 x (4 - x - y) = 0, quad y (x - 1) = 0. \
  $
  There are three #ponder("ode.equilibrium-point")[fixed points]: $(0, 0)$, $(4, 0)$ and $(1, 3)$.

  We have
  $
    matbold(M) = mat(f_x, f_y; g_x, g_y) = mat(8 - 4 x - 2 y, -2 x; y, x - 1).
  $

  - At $(0, 0)$, we have

    $
      matbold(M) = mat(8, 0; 0, -1).
    $
    The eigenvalues are $lambda_1 = 8 > 0$ and $lambda_2 = -1 < 0$, with eigenvectors $vb(v)_1 = vec(1, 0)$ and $vb(v)_2 = vec(0, 1)$.

    Thus, it is a saddle point.

    #align(center)[
      #dynamic-svg("/part-ia/differential-equations/media/d11e7.svg", width: 8em)
    ]

  - At $(4, 0)$, we have

    $
      matbold(M) = mat(-8, -8; 0, 3).
    $
    The eigenvalues are $lambda_1 = -8 < 0$ and $lambda_2 = 3 > 0$, with eigenvectors $vb(v)_1 = vec(1, 0)$ and $vb(v)_2 = vec(8, -11)$.

    Thus, it is a saddle point.

    #align(center)[
      #dynamic-svg("/part-ia/differential-equations/media/d11e8.svg", width: 8em)
    ]

  - At $(1, 3)$, we have

    $
      matbold(M) = mat(-2, -2; 3, 0).
    $
    The eigenvalues are found by solving
    $
      abs(matbold(M) - lambda matbold(I)) = lambda^2 + 2 lambda + 6 = 0 \
      lambda = -1 ± ii sqrt(5). \
    $
    Since $re(lambda) = -1 < 0$, the #ponder("ode.equilibrium-point")[fixed point] is a stable spiral.

    At $(xi, eta) = (1, 0)$, we have $(dot(xi), dot(eta)) = (-2, 3)$, so the motion is counter-clockwise.

    #align(center)[
      #dynamic-svg("/part-ia/differential-equations/media/d11e9.svg", width: 8em)
    ]

  Now, we can sketch the overall #ponder("ode.phase-portrait")[phase portrait].

  #align(center)[
    #dynamic-svg2("/part-ia/differential-equations/media/m1e4.svg", width: 22em)
  ]
] <predator-prey-model>

== Partial Differential Equations

Partial differential equations (PDEs) involve several independent variables. We will illustrate some ideas with wave equations.

=== First-Order Wave Equation

Consider $psi(x, t)$, where $x$ is the spatial coordinate and $t$ is time, with
#set math.equation(numbering: "(*)")

$
  pdv(psi, t) - c pdv(psi, x) = 0
$

where $c$ is a constant with dimensions of velocity.

#set math.equation(numbering: none)

We can solve this by the method of characteristics. We consider how $psi$ vary along a path $x(t)$, so that we consider $psi(x(t), t)$. We have
$
  dv(psi, t) & = pdv(psi, t) + pdv(psi, x) dv(x, t) quad & ("multivariate chain rule") \
                    & = pdv(psi, x) (c + dv(x, t)) quad           &               ("using (*)") \
$

If we choose $x(t)$ such that $dv(x, t) = -c$, then $x(t) = x_0 - c t$ where $x_0$ is a constant, and we have
$
  dv(psi, t) = 0 => psi(x(t), t) = psi(x_0, 0) = "constant along path".
$
Paths $x(t)$ where $x(t) = x_0 - c t$ are called characteristics of $(*)$.

Since $psi$ is constant along characteristics, the general solution of $(*)$ is
$
  psi(x, t) = f(x_0) = f(x + c t)
$
where $f$ is an arbitrary function.

#lecture-separator(lecture: 24, date: "2025-12-03")

This expression translates the $x$-dependence of $psi$ at $t=0$ to the left by $c t$ at time $t$.

#align(center)[
  #dynamic-svg2("/part-ia/differential-equations/media/m1e6.svg", width: 28em)
]

The solutions are left-moving wave solutions.

#example[Unforced wave equation][
  We have
  $
    pdv(psi, t) - c pdv(psi, x) = 0
  $
  with $psi(x, 0) = x^2-3$.

  The general solution is
  $
    psi(x, t) = f(x + c t).
  $
  Using the initial condition, we have
  $
    psi(x, 0) = f(x) = x^2 - 3.
  $
  Therefore, the specific solution is
  $
    psi(x, t) = (x + c t)^2 - 3.
  $
]

#example[Forced wave equation][
  Consider
  $
    pdv(psi, t) + 5 pdv(psi, x) = ee^(-t)
  $
  with $psi(x, 0) = ee^(-x^2)$.

  The characteristics are of the form $x(t) = x_0 + 5 t$.

  Along these characteristics, we have
  $
    dv(psi, t) & = pdv(psi, t) + pdv(psi, x) dv(x, t) \
                      & = ee^(-t) - 5 pdv(psi, x) + 5 pdv(psi, x) \
                      & = ee^(-t). \
  $
  So this gives
  $
    psi = f(x_0) - ee^(-t)
  $
  where $f(x_0)$ is an arbitrary function.

  Using the initial condition at $t=0$, we have
  $
    psi(x, 0) = f(x) - 1 = ee^(-x^2) => f(x) = ee^(-x^2) + 1.
  $
  Thus, the specific solution is
  $ psi(x, t) = ee^(-(x - 5 t)^2) + 1 - ee^(-t). $


]

=== Second-Order Wave Equation

A lot of physical systems allow waves to propagate in both directions. This is modelled by second-order wave equations.

Consider
$
  pdv(psi, t, 2) - c^2 pdv(psi, x, 2) = 0
$
where $c$ is a constant with dimensions of velocity.

Since the differential operator can be factorised as
$
  pdv(, t, 2) - c^2 pdv(, x, 2) = (pdv(, t) - c pdv(, x)) (pdv(, t) + c pdv(, x)),
$
we can write the wave equation as
$ (pdv(, t) - c pdv(, x)) (pdv(, t) + c pdv(, x)) psi = 0. $
These two operators commute, so both $f(x + c t)$ and $g(x - c t)$ are solutions, where $f$ and $g$ are arbitrary functions.

This suggests that the general solution is
$
  psi(x, t) = f(x + c t) + g(x - c t)
$
where $f$ and $g$ are arbitrary functions.

#remark[
  We can show that this is indeed the most general solution. Let $xi = x + c t$ and $eta = x - c t$.
  $
    eval(pdv(, x))_t & = underbracket(eval(pdv(xi, x))_t, 1) eval(pdv(, xi))_eta + underbracket(eval(pdv(eta, x))_t, 1) eval(pdv(, eta))_xi \
    eval(pdv(, t))_x & = underbracket(eval(pdv(xi, t))_x, c) eval(pdv(, xi))_eta + underbracket(eval(pdv(eta, t))_x, -c) eval(pdv(, eta))_xi \
  $
  so, we have
  $
     pdv(, t) -c pdv(, x) & = -2c pdv(, eta) \
    pdv(, t) + c pdv(, x) & = 2c pdv(, xi). \
  $
  So the wave equation becomes

  $
    -4c^2 pdv(psi, xi, eta) = 0 \
  $
  Therefore,
  $
    psi(xi, eta) = f(xi) + g(eta) \
  $
  for arbitrary functions $f$ and $g$.
]

#example[
  Consider
  $
    pdv(psi, t, 2) - c^2 pdv(psi, x, 2) = 0
  $
  with $psi(x, 0) = (1)/(1+x^2)$ and $pdv(psi, t)(x, 0) = 0$.
  The general solution is
  $
    psi(x, t) = f(x + c t) + g(x - c t).
  $
  Using the initial conditions, we have
  $
            psi(x, 0) & = f(x) + g(x) = (1)/(1 + x^2) \
    pdv(psi, t)(x, 0) & = c f'(x) - c g'(x) = 0 => f(x) - g(x) = A \
  $
  where $A$ is a constant. Solving these two equations gives
  $
    f(x) = (1)/(2(1 + x^2)) + (A)/(2), quad g(x) = (1)/(2(1 + x^2)) - (A)/(2).
  $
  Thus, the specific solution is
  $ psi(x, t) = (1)/(2) [1/(1+(x+c t)^2) + 1/(1+(x-c t)^2)] $

  #align(center)[
    #dynamic-svg2("/part-ia/differential-equations/media/m1e5.svg", width: 28em)
  ]
]
