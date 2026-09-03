#import "../prelude.typ": *

#lecture-separator(lecture: 20, date: "2025-11-24")

= Multivariate Functions: Applications

In this section we will discuss

- directional derivatives
- extrema
- coupled systems of 1st order #ponder("ode.ordinary-differential-equation")[ODEs]
- partial differential equations

== Directional derivatives

Consider $f(x, y)$ and a vector displacement $dif bold(s) = (dif x, dif y)$.

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d10e1.svg", width: 18em)
]

The infinestimal change in $f$ along $dif bold(s)$ is given by
$
  dif f & = (∂f)/(∂x) dif x + (∂f)/(∂y) dif y quad ("multivariate chain rule") \
        & = (dif x, dif y) dot ( (∂f)/(∂x), (∂f)/(∂y) ) \
        & = dif bold(s) dot bold(nabla) f \
$
where we have defined the #ponder("calculus.gradient")[gradient operator]
$
  bold(nabla) f = ( (∂ f)/(∂x), (∂ f)/(∂y) ).
$

If we write $dif bold(s) = dif s bold(hat(s))$ where $bold(hat(s))$ is a unit vector in the direction of $dif bold(s)$, then we have
$
  dif f & = dif s [ bold(hat(s)) dot bold(nabla) f ].
$

#definition[Directional derivative][
  The #ponder("calculus.directional-derivative")[*directional derivative*] of $f$ in the direction of the unit vector $bold(hat(s))$ is defined as
  $
    (dif f)/(dif s) = bold(hat(s)) dot bold(nabla) f = cos theta abs(bold(nabla) f)
  $
  where $theta$ is the angle between $bold(hat(s))$ and $bold(nabla) f$.

  This is the rate of change of $f(x, y)$ in the direction of $bold(hat(s))$.
] <directional-derivative>

#remark[
  We can define the #ponder("calculus.gradient")[gradient vector] $bold(nabla) f$ geometrically in the other way round, as the vector such that
  $
    (dif f) / (dif s) = bold(hat(s)) dot bold(nabla) f quad forall bold(hat(s)).
  $
]

#proposition[Properties of #ponder("calculus.gradient")[gradient vector]][
  1. The direction of $bold(nabla) f$ is the direction of maximum increase of $f$.

  2. The magnitude of $bold(nabla) f$ is the maximum rate of change of $f$, _i.e._

    $
      abs(bold(nabla) f) = max_(forall theta) (dif f)/(dif s)
    $

  3. If $bold(hat(s))$ is parallel to contours of $f(x, y)$, then
    $ (dif f)/(dif s) = 0 = bold(hat(s)) dot bold(nabla) f. $
    Therefore, $bold(nabla) f$ is perpendicular to the contours of $f(x, y)$.

] <gradient-vector-properties>

== Stationary Points

There is always at least one direction where $(dif f)/(dif s)$ is zero at a given point, namely the direction parallel to the contours of $f(x, y)$ at that point.

So stationary points are the points where
$
  (dif f)/(dif s) = 0 quad forall bold(hat(s)) <=> bold(nabla) f = bold(0).
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
  bold(x)(s) = bold(x_0) + s bold(hat(s)).
$

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d10e5.svg", width: 20em)
]
Along the line, $f(x(s), y(s))$ is a function of $s$, and we can use the usual #ponder("calculus.taylor-series")[Taylor series] for single variable functions:
$
  f(bold(x_0) + s bold(hat(s))) & = f(bold(x_0)) + s eval((dif f)/(dif s))_(bold(x_0)) + (s^2)/(2!) eval((dif^2 f)/(dif s^2))_(bold(x_0)) + ... \
  &= f(bold(x_0)) + underbracket(s bold(hat(s)) dot eval(bold(nabla) f)_(bold(x_0)), (1)) + underbracket((s^2)/(2!) eval((bold(hat(s)) dot bold(nabla))(bold(hat(s)) dot bold(nabla) f))_(bold(x_0)), (2)) + ...
$

We have
$
  (1): & s bold(hat(s)) dot bold(nabla) f & = & delta bold(x) dot bold(nabla) f \
       &                                  & = & delta x (∂ f)/(∂ x) + delta y (∂ f)/(∂ y) \
       & "where" delta bold(x)            & = & s bold(hat(s)) = (delta x, delta y). \
$
and also
$
  (2): & s^2 (bold(hat(s)) dot bold(nabla)) (bold(hat(s)) dot bold(nabla) f) &=& s^2 (hat(s)_x ∂/(∂x) + hat(s)_y ∂/(∂y)) (hat(s)_x (∂f)/(∂x) + hat(s)_y (∂f)/(∂y)) \
  & & = & (delta x)^2 (∂^2 f)/(∂ x^2) + 2 (delta x)(delta y) (∂^2 f)/(∂ x ∂ y) + (delta y)^2 (∂^2 f)/(∂ y^2) \
  & & = & mat(delta x, delta y) mat(f_(x x), f_(x y); f_(y x), f_(y y)) vec(delta x, delta y) \
$

#definition[Hessian Matrix][
  The #ponder("calculus.hessian-matrix")[*Hessian matrix*] of $f(x, y)$ is defined as
  $
    matbold(H) = bold(nabla) bold(nabla) f = mat(f_(x x), f_(x y); f_(y x), f_(y y))
  $
  where $f_(x x) = (∂^2 f)/(∂ x^2)$, $f_(x y) = (∂^2 f)/(∂ x ∂ y)$, etc.

  This is a symmetric matrix since $f_(x y) = f_(y x)$.
] <hessian-matrix>

Thus, the multivariate #ponder("calculus.taylor-series")[Taylor series] expansion of $f(x, y)$ about the point $bold(x_0)$ is
$
  f(x_0 + delta x, y_0 + delta y) = f(x_0, y_0) + eval((delta x (∂ f)/(∂ x) + delta y (∂ f)/(∂ y)))_(bold(x_0)) + (1/2) eval([(delta x)^2 (∂^2 f)/(∂ x^2) + 2 (delta x)(delta y) (∂^2 f)/(∂ x ∂ y) + (delta y)^2 (∂^2 f)/(∂ y^2)])_(bold(x_0)) + ... \
$
We can also write this in coordinate-independent form as
$
  f(bold(x_0) + delta bold(x)) = f(bold(x_0)) + delta bold(x) dot eval(bold(nabla) f)_(bold(x_0)) + (1/2) (delta bold(x))^tp eval(matbold(H))_(bold(x_0)) (delta bold(x)) + ... \
$

#lecture-separator(lecture: 21, date: "2025-11-26")

=== Nature of Stationary Points and the #ponder("calculus.hessian-matrix")[Hessian]

Suppose $bold(x_0)$ is a stationary point with
$
  eval(bold(nabla) f)_(bold(x_0)) = bold(0).
$

Around $bold(x_0)$:
$
  f(bold(x)) approx f(bold(x_0)) + (1/2) (delta bold(x))^tp eval(matbold(H))_(bold(x_0)) (delta bold(x))
$
where $delta bold(x) = bold(x) - bold(x_0)$.

#definition[Definiteness of a Matrix][
  A real symmetric matrix $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[*positive definite*] if
  $
    bold(x)^tp matbold(H) bold(x) > 0 quad forall bold(x) != bold(0).
  $
  It is #ponder("linear-algebra.matrix-definiteness")[*negative definite*] if
  $
    bold(x)^tp matbold(H) bold(x) < 0 quad forall bold(x) != bold(0).
  $
  Otherwise, it is #ponder("linear-algebra.matrix-definiteness")[*indefinite*].
] <matrix-definiteness>

- If $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[positive definite] at $bold(x_0)$, then $f(bold(x)) > f(bold(x_0))$ for all $bold(x)$ near $bold(x_0)$, so $bold(x_0)$ is a local minimum.

- If $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[negative definite] at $bold(x_0)$, then $f(bold(x)) < f(bold(x_0))$ for all $bold(x)$ near $bold(x_0)$, so $bold(x_0)$ is a local maximum.

- If $matbold(H)$ is #ponder("linear-algebra.matrix-definiteness")[indefinite] at $bold(x_0)$, then it may be a maximum, minimum or saddle point.

==== #ponder("linear-algebra.matrix-definiteness")[Definiteness] and Eigenvalues

If $matbold(H)$ is a real symmetric matrix, then we can diagonalise it by an orthogonal transformation (by results in IA Vectors and Matrices). Using coordinates along the principal axes (eigenvectors), in $N$ dimensions:
$
  delta x^tp matbold(H) delta x &= mat(delta x_1, delta x_2, ..., delta x_N) mat(lambda_1, 0, ..., 0; 0, lambda_2, ..., 0; dots.v, dots.v, dots.down, dots.v; 0, 0, ..., lambda_N) vec(delta x_1, delta x_2, dots.v, delta x_N)\
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
    bold(nabla) f = (2x, 4y^3), quad matbold(H) = mat(2, 0; 0, 12y^2).
  $

  At the stationary point $(0, 0)$, the #ponder("calculus.hessian-matrix")[Hessian matrix] is
  $ matbold(H) = mat(2, 0; 0, 0). $
  This has eigenvalues $lambda_1 = 2 > 0$ and $lambda_2 = 0$. Therefore, the #ponder("calculus.hessian-matrix")[Hessian] is #ponder("linear-algebra.matrix-definiteness")[positive semi-definite], and we need to consider higher order terms to classify the stationary point.
]

==== #ponder("linear-algebra.matrix-definiteness")[Definiteness] and #ponder("linear-algebra.signature")[Signature]

An alternative method to determine #ponder("linear-algebra.matrix-definiteness")[definiteness] without having to compute eigenvalues is to use #ponder("linear-algebra.signature")[signatures].

#definition[Signature][
  The #ponder("linear-algebra.signature")[*signature*] of $matbold(H)$ is the parttern of signs of the ordered determinants of the leading principal minors of $matbold(H)$.
] <signature>

#example[
  For a function $f(x_1, x_2, ..., x_N)$, the #ponder("linear-algebra.signature")[signature] if given by the signs of
  $
    mat(delim: "|", f_(x_1 x_1)), quad mat(delim: "|", f_(x_1 x_1), f_(x_1 x_2); f_(x_2 x_1), f_(x_2 x_2)), quad ..., quad mat(delim: "|", f_(x_1 x_1), ..., f_(x_1 x_N); dots.v, dots.down, dots.v; f_(x_N x_1), ..., f_(x_N, x_N)).
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

Suppose $f(x, y)$ has a stationary point at $bold(x_0) = (x_0, y_0)$. Using coordinates aligned with the principal axes of the #ponder("calculus.hessian-matrix")[Hessian matrix] at $bold(x_0)$, we have
$
  matbold(H)(bold(x_0)) = mat(lambda_1, 0; 0, lambda_2).
$
Assume that the eigenvalues are non-zero. Then, consider
$
  bold(x) = bold(x_0) + (xi, eta),
$
then around $matbold(x_0)$ we have
$
  f(bold(x)) approx f(bold(x_0)) + (1/2) (lambda_1 xi^2 + lambda_2 eta^2).
$

On contours near $bold(x_0)$, since $f$ is constant, we have
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
  The stationary points are found by solving $f_x = 0$ and $f_y = 0$ simultaenously:
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
    abs(matbold(H_1)) = 24 > 0, quad abs(matbold(H)) = 24 times 2 - (-12)^2 = 96 < 0.
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
  dot(bold(Y)) = matbold(M) bold(Y) + bold(F).
$

where
$
  matbold(M) = mat(a, b; c, d), quad bold(Y) = vec(y_1(t), y_2(t)), quad bold(F) = vec(f_1(t), f_2(t)).
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
    Under some cases, we write higher order #ponder("ode.ordinary-differential-equation")[ODE] as a set of 1st order #ponder("ode.ordinary-differential-equation")[ODEs], esentially reversing the process above.
    #example[
      Consider the equation
      $
        dot.double(y) + a dot(y) + b y = f.
      $
      We can let $y_1 := y$, $y_2 := dot(y)$ and $bold(Y) = vec(y_1, y_2)$. We then have
      $
        dot(y)_1 & = y_2 \
        dot(y)_2 & = -b y_1 - a y_2 + f
      $
      Hence,
      $
        bold(dot(Y)) = mat(0, 1; -b, -a) bold(Y) + vec(0, f).
      $
    ]
  ]


=== Matrix methods

Consider
$
  bold(dot(Y)) = matbold(M) bold(Y) + bold(F)(t)
$

where $matbold(M)$ is a constant matrix.

1. Write $bold(Y) = bold(Y_c) + bold(Y_p)$ where $bold(Y_c)$ is the #ponder("ode.particular-integral")[complementary function] satisfying $bold(dot(Y)_c) = matbold(M) bold(Y_c)$, and $bold(Y_p)$ is a #ponder("ode.particular-integral")[particular integral].

2. Look for $bold(Y_c)$ of the form $bold(Y_c) = bold(v) ee^(lambda t)$ where $bold(v)$ is a constant vector. Then,

  $
    bold(dot(Y)_c) & = lambda bold(v) ee^(lambda t) = lambda bold(Y_c) = matbold(M) bold(Y_c) \
  $
  Since $lambda bold(Y_c) = matbold(M) bold(Y_c)$ holds for all $t$, taking $t=0$ we have
  $
    matbold(M) bold(v) = lambda bold(v).
  $
  Hence $lambda$ is an eigenvalue of $matbold(M)$, and $bold(v)$ is the corresponding eigenvector.

  For a system of $n$ equations, we have $n$ such complementary functions if eigenvalues are distinct.

3. Find a $bold(Y_p)$ that satisfies $bold(dot(Y)_p) = matbold(M) bold(Y_p) + bold(F)(t)$ by trying an appropriate form.

#example[
  Consider
  $
    bold(dot(Y)) = underbracket(mat(-4, 24; 1, -2), matbold(M)) bold(Y) + underbracket(vec(4, 1) ee^t, bold(F)).
  $
  Write $bold(Y) = bold(Y_c) + bold(Y_p)$, and for $bold(Y_c)$ consider $bold(Y_c) = bold(v) ee^(lambda t)$.

  Then,
  $ matbold(M) bold(v) = lambda bold(v) => abs(matbold(M) - lambda matbold(I)) = 0. $
  We have
  $
    (-4 - lambda)(-2 - lambda) - 24 = lambda^2 + 6 lambda - 16 = 0\
    lambda_1 = 2, quad lambda_2 = -8. \
  $
  The corresponding eigenvectors are
  $
    bold(v)_1 = vec(4, 1), quad bold(v)_2 = vec(-6, 1).
  $
  Hence,
  $
    bold(Y)_c = A vec(4, 1) ee^(2 t) + B vec(-6, 1) ee^(-8 t).
  $
  Try $bold(Y_p) = bold(u) ee^t$. Then,
  $
                              bold(u) & = matbold(M) bold(u) + vec(4, 1) \
    (matbold(I) - matbold(M)) bold(u) & = vec(4, 1) \
                              bold(u) & = (matbold(I) - matbold(M))^(-1) vec(4, 1). \
  $
  Note that an inverse exists since $abs(matbold(I) - matbold(M)) != 0$ ($1$ is not an eigenvalue of $matbold(M)$). We have
  ƒ
  $
    bold(u) = vec(-4, -1).
  $
  Thus, the general solution is
  $
    bold(Y) = A vec(4, 1) ee^(2 t) + B vec(-6, 1) ee^(-8 t) + vec(-4, -1) ee^t.
  $
]

#remark[
  Note, if $bold(F) prop ee^(lambda t)$ with $lambda$ an eigenvalue of $matbold(M)$, then we try $bold(Y_p) = (bold(a) + bold(b) t) ee^(lambda t)$ instead.
]

=== Non-Degenerate #ponder("ode.phase-portrait")[Phase portraits]

#definition[Phase space][
  For $n$ first-order #ponder("ode.ordinary-differential-equation")[ODEs], the #ponder("ode.phase-space")[*phase space*] is an $n$-dimensional space with coordinates given by
  $
    bold(Y) = vec(y_1, y_2, dots.v, y_n).
  $
] <phase-space>

#definition[Phase portrait][
  #ponder("ode.phase-portrait")[*Phase portraits*] are solution trajectories in #ponder("ode.phase-space")[phase space].
] <phase-portrait>

For #ponder("ode.autonomous-system")[autonomous systems], there is one trajectory through each point in #ponder("ode.phase-space")[phase space], except at #ponder("ode.equilibrium-point")[fixed points].

Consider the #ponder("ode.homogeneous-differential-equation")[homogeneous equation]
$
  bold(dot(Y)) = matbold(M) bold(Y).
$

There is a #ponder("ode.equilibrium-point")[fixed point] at $bold(Y) = bold(0)$. For $n = 2$, the general solution for $lambda_1 != lambda_2$ (non-degenerate case) is
$
  bold(Y)(t) & = A bold(v)_1 ee^(lambda_1 t) + B bold(v)_2 ee^(lambda_2 t).
$
where $A, B$ are constants.

For $lambda_1 != 0, lambda_2 != 0$ and $lambda_1 != lambda_2$, we have the following cases:

1. $lambda_1$ and $lambda_2$ are real and of opposite signs. WLOG suppose $lambda_1 > 0 > lambda_2$. In this case, $bold(v_1), bold(v_2)$ can be chosen to be real. The #ponder("ode.equilibrium-point")[fixed point] is a saddle node.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e1.svg", width: 16em)
  ]

2. $lambda_2$ and $lambda_2$ are real and have the same sign. WLOG suppose $abs(lambda_1) > abs(lambda_2)$.

  - If both are positive, then the #ponder("ode.equilibrium-point")[fixed point] is an unstable node.
  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e2.svg", width: 16em)
  ]

  - If both are negative, then the #ponder("ode.equilibrium-point")[fixed point] is a stable node.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d11e3.svg", width: 16em)
  ]
3. $lambda_1$ and $lambda_2$ are complex conjugates, then $lambda_2 = overline(lambda_1)$ and $bold(v_2) = overline(bold(v_1))$. Then,

  $
    bold(Y)(t) & = C bold(v_1) ee^(re(lambda_1) t) ee^(ii im(lambda_1) t) + overline(C) overline(bold(v_1)) ee^(re(lambda_1) t) ee^(-ii im(lambda_1) t) \
    &= 2ee^(re(lambda_1) t) [[c_1 re(bold(v_1)) - c_2 im(bold(v_1))] cos(im(lambda_1) t) - [c_1 im(bold(v_1)) + c_2 re(bold(v_1))] sin(im(lambda_1) t) ]\
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

In order to determine the direction of motion along the trajectories, we can evaluate $bold(dot(Y))$ at some points on the trajectory.

For example, if $dot(y)_2 > 0$ at $matbold(Y) = vec(1, 0)$, then motion is upwards at that point, so the direction of motion is counter-clockwise.

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
  dot(x) &= dot(xi) &= f(x_0 + xi, y_0 + eta) &approx underbracket(f(x_0, y_0), = 0 "at fixed point") + xi eval((∂ f)/(∂ x))_(x_0, y_0) + eta eval((∂ f)/(∂ y))_(x_0, y_0) \
  dot(y) &= dot(eta) &= g(x_0 + xi, y_0 + eta) &approx underbracket(g(x_0, y_0), = 0 "at fixed point") + xi eval((∂ g)/(∂ x))_(x_0, y_0) + eta eval((∂ g)/(∂ y))_(x_0, y_0) \
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
    The eigenvalues are $lambda_1 = 8 > 0$ and $lambda_2 = -1 < 0$, with eigenvectors $bold(v)_1 = vec(1, 0)$ and $bold(v)_2 = vec(0, 1)$.

    Thus, it is a saddle point.

    #align(center)[
      #dynamic-svg("/part-ia/differential-equations/media/d11e7.svg", width: 8em)
    ]

  - At $(4, 0)$, we have

    $
      matbold(M) = mat(-8, -8; 0, 3).
    $
    The eigenvalues are $lambda_1 = -8 < 0$ and $lambda_2 = 3 > 0$, with eigenvectors $bold(v)_1 = vec(1, 0)$ and $bold(v)_2 = vec(8, -11)$.

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
  (∂ psi)/(∂ t) - c (∂ psi)/(∂ x) = 0
$

where $c$ is a constant with dimensions of velocity.

#set math.equation(numbering: none)

We can solve this by the method of characteristics. We consider how $psi$ vary along a path $x(t)$, so that we consider $psi(x(t), t)$. We have
$
  (dif psi)/(dif t) & = (∂ psi)/(∂ t) + (∂ psi)/(∂ x) (dif x)/(dif t) quad & ("multivariate chain rule") \
                    & = (∂ psi)/(∂ x) (c + (dif x)/(dif t)) quad           &               ("using (*)") \
$

If we choose $x(t)$ such that $(dif x)/(dif t) = -c$, then $x(t) = x_0 - c t$ where $x_0$ is a constant, and we have
$
  (dif psi)/(dif t) = 0 => psi(x(t), t) = psi(x_0, 0) = "constant along path".
$
Paths $x(t)$ where $x(t) = x_0 - c t$ are called characteristics of $(*)$.

Since $psi$ is constant along characteristics, the general solution of $(*)$ is
$
  psi(x, y) = f(x_0) = f(x + c t)
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
    (∂ psi)/(∂ t) - c (∂ psi)/(∂ x) = 0
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
    (∂ psi)/(∂ t) + 5 (∂ psi)/(∂ x) = ee^(-t)
  $
  with $psi(x, 0) = ee^(-x^2)$.

  The characteristics are of the form $x(t) = x_0 + 5 t$.

  Along these characteristics, we have
  $
    (dif psi)/(dif t) & = (∂psi)/(∂t) + (∂psi)/(∂t) (dif x)/(dif t) \
                      & = ee^(-t) - 5 (∂ psi)/(∂ x) + 5 (∂ psi)/(∂ x) \
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
  (∂^2psi)/(∂ t^2) - c^2 (∂^2 psi)/(∂ x^2) = 0
$
where $c$ is a constant with dimensions of velocity.

Since the differential operator can be factorised as
$
  (∂^2)/(∂ t^2) - c^2 (∂^2)/(∂ x^2) = ((∂)/(∂ t) - c (∂)/(∂ x)) ((∂)/(∂ t) + c (∂)/(∂ x)),
$
we can write the wave equation as
$ ((∂)/(∂ t) - c (∂)/(∂ x)) ((∂)/(∂ t) + c (∂)/(∂ x)) psi = 0. $
These two operators commute, so both $f(x + c t)$ and $g(x - c t)$ are solutions, where $f$ and $g$ are arbitrary functions.

This suggests that the general solution is
$
  psi(x, t) = f(x + c t) + g(x - c t)
$
where $f$ and $g$ are arbitrary functions.

#remark[
  We can show that this is indeed the most general solution. Let $xi = x + c t$ and $eta = x - c t$.
  $
    eval(∂/(∂x))_t & = underbracket(eval((∂xi)/(∂x))_t, 1) eval(∂/(∂xi))_eta + underbracket(eval((∂ eta)/(∂x))_t, 1) eval(∂/(∂ eta))_xi \
    eval(∂/(∂t))_x & = underbracket(eval((∂xi)/(∂t))_x, c) eval(∂/(∂xi))_eta + underbracket(eval((∂ eta)/(∂t))_x, -c) eval(∂/(∂ eta))_xi \
  $
  so, we have
  $
     ∂/(∂t) -c (∂)/(∂x) & = -2c ∂/(∂ eta) \
    ∂/(∂t) + c (∂)/(∂x) & = 2c ∂/(∂ xi). \
  $
  So the wave equation becomes

  $
    -4c^2 (∂^2 psi)/(∂ xi ∂ eta) = 0 \
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
    (∂^2psi)/(∂ t^2) - c^2 (∂^2 psi)/(∂ x^2) = 0
  $
  with $psi(x, 0) = (1)/(1+x^2)$ and $(∂psi)/(∂t)(x, 0) = 0$.
  The general solution is
  $
    psi(x, t) = f(x + c t) + g(x - c t).
  $
  Using the initial conditions, we have
  $
            psi(x, 0) & = f(x) + g(x) = (1)/(1 + x^2) \
    (∂psi)/(∂t)(x, 0) & = c f'(x) - c g'(x) = 0 => f(x) - g(x) = A \
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
