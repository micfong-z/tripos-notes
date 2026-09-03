#import "../prelude.typ": *

= Partial Differentiation

== Functions of Several Variables

We shall now generalize to functions of more than one independent variables, which are also called *multivariate functions*.

#example("Examples of multivarate functions")[
  - Height of terrain, $h(x, y)$
  - Temperature in a room, $T(x, y, z, t)$
  - Pressure of gas as a function of volume and temperature, $p(V, T)$
]

A way of representing these functions is using a *contour plot*.

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/dxe1.svg", width: 20em)
]

The slope of a point $A$ on the plot depends on the direction. Firstly, let us consider what happens along the coodinate directions.

== #ponder("calculus.partial-derivative")[Partial Derivatives]

*#ponder("calculus.partial-derivative")[Partial derivatives]* ar ederivatives of multivariate functions with respect to one variable, while holding the other fixed.

#definition("Partial derivative")[
  Given a function of several variables, _e.g._ $f(x, y)$, the *#ponder("calculus.partial-derivative")[partial derivative]* of $f$ with respect to $x$ at fixed $y$ is
  $ eval((∂ f)/(∂ x))_y = lim_(delta x->0) (f(x + delta x, y) - f(x, y))/(delta x). $

  Roughly speaking, this is the slope of $f$ when moving in the positive $x$ direction.
  $ eval((∂ f)/(∂ y))_x $
  can be defined similarly.
] <partial-derivative>

#example[
  Consider $f(x, y ) = x^2+y^3 + ee^(x y^2)$. Then
  $
    eval((∂ f)/(∂ x))_y & = 2x + 0 + y^2 ee^(x y^2), \
    eval((∂ f)/(∂ y))_x & = 0 + 3y^2 + 2x y ee^(x y^2).
  $

  We can similarly calculate higher #ponder("calculus.derivative")[derivatives].

  $ eval((∂ ^(2) f)/(∂ x^(2)))_y = 2 + y^4 ee^(x y^2). $

  Also, we can do mixed derivatives.

  $
    eval((∂ )/(∂ x) (eval((∂ f)/(∂ y))_x ))_y & = 2 y ee^(x y^2) + 2 x y^3 ee^(x y^2), \
    eval((∂ )/(∂ y) (eval((∂ f)/(∂ x))_y ))_x & = 2 y ee^(x y^2) + 2 x y^3 ee^(x y^2).
  $
] <partial-diff-ex>

#notation[
  The notation is getting somewhat cumbersome. We usually omit $eval(thin)_x$ and use of $∂$ to indicate that _all other_ variables are kept fixed. _i.e._
  $ eval((∂ )/(∂ x) (eval((∂ f)/(∂ y))_x ))_y equiv (∂^2 f) /(∂x ∂y). $
  Alternatively, there is a even more compact notation:
  $ f_x equiv (∂ f)/(∂x), quad f_(x y)equiv (∂^2 f)/(∂ y ∂x). $
]

Note that in @partial-diff-ex, it seems that
$ (∂^2f)/(∂x∂y) = (∂^2f)/(∂y∂x). $
This is indeed the case under certain conditions.

If $f$ is a multivariate function with continuous 2nd derivatives, then
$ (∂^2f)/(∂x∂y) = (∂^2f)/(∂y∂x) $
if  the conditions of Schwarz's theorem is satisfied.

== #ponder("calculus.multivariate-chain-rule")[Multivariate Chain Rule]

Give path $x(t), y(t)$ and a function $f(x, y)$, consider $(dif f)/(dif t)$ along the path.

#theorem[Differential form of #ponder("calculus.multivariate-chain-rule")[chain rule for partial derivatives]][
  Differential $dif f$ of a function $f(x, y)$ is
  $ dif f = (∂ f)/( ∂x) dif x + (∂ f)/(∂ y) dif y. $
] <multivariate-chain-rule>

#proof[
  Consider the change in $f$ under
  $ (x, y) -> (x + delta x, y+ delta y). $
  Then
  $
    delta f & = f(x + delta x, y + delta y)- f(x, y) \
            & = [f(x+ delta x, y + delta y) - f(x + delta x, y)] + [f(x + delta x, y) - f(x, y)].
  $

  Consider the two brackets separately. Then, as $delta x, delta y -> 0$,

  $
                        f(x + delta x, y) - f(x, y) & = f_x (x, y) delta x + o(delta x), quad "by Taylor's theorem" \
    f(x + delta x, y + delta y) - f(x + delta y, y) & = f_y (x + delta x, y) delta y + o(delta y). \
  $

  Note that
  $ f_y (x + delta x, y) = f_y (x, y) + f_(y x) (x, y) delta x + o(delta x). $

  Hence,

  $
    delta f = [f_y (x, y) + f_(y x) (x, y) delta x + o(delta x)] delta y + f_x (x, y) delta x + o(delta y) + o delta(x).
  $

  Taking the limit $lim_(delta x, delta y -> 0)$ gives the required results.

]

Thus, for the path $x(t), y(t)$, we have
$
  (dif )/(dif t) f(x(t), y(t)) &= lim_(delta x, delta y, delta t -> 0) [(∂ f)/(∂ x) (delta x) / (delta t) + (∂ f)/(∂ y) (delta y) / (delta t) ] \
  &= (∂ f)/(∂ x) (dif x) / (dif t) + (∂ f)/(∂ y) (dif y) / (dif t). \
$


If instead we parameterize path by coordinate $x$, so we are left with $y(x)$, then

$ (dif)/(dif x) f(x, y(x)) = (∂f)/(∂x) + (∂f)/(∂y) (dif y)/(dif x). $

We can also reach the #ponder("calculus.multivariate-chain-rule")[integral form of chain rule]:


#theorem[Integral form of #ponder("calculus.multivariate-chain-rule")[chain rule for partial derivatives]][
  For a function $f(x, y)$, the change in $f$ between two endpoints is
  $ Delta f = integral dif f = integral (∂ f)/( ∂x) dif x + integral (∂ f)/(∂ y) dif y. $
] <multivariate-chain-rule-integral>

For $f(x(t), y(t))$,

$
  Delta f = integral underbracket((∂ f)/(∂ x) (dif x) / (dif t) + (∂ f)/(∂ y) (dif y) / (dif t), (dif f)/(dif t)) dif t,
$
so the final result does not depend on a particular path for given endpoints.

== Applications of #ponder("calculus.multivariate-chain-rule")[Multivariate Chain Rule]

=== Change of Variables

It is often useful to write a differential equation in a different coordinate system.

#lecture-separator(lecture: 5, date: "2025-10-20")

For example, we can change Cartesian $(x, y)$ coordinates to polar $(r, theta)$ coordinates with
$ x=r cos theta, quad y = r sin theta. $

Think of $f(x, y)$ as $f(x(r, theta), y(r, theta))$. From the #ponder("calculus.multivariate-chain-rule")[chain rule],

$
  eval((∂ f)/(∂ r))_theta & = eval((∂ f)/(∂ x))_y eval((∂ x)/(∂ r))_theta +eval((∂ f)/(∂ y))_x eval((∂ y)/(∂ r))_theta \
   eval((∂ f)/(∂ theta))_r & = eval((∂ f)/(∂ x))_y eval((∂ x)/(∂ theta))_r +eval((∂ f)/(∂ y))_x eval((∂ y)/(∂ theta))_r.
$

=== Implicit Differentiation

For $f(x, y, z)$, we have

$ dif f = eval((∂ f)/(∂ x))_(y, z) dif x + eval((∂ f)/(∂ y))_(x, z) dif y +eval((∂ f)/(∂ z))_(x, y) dif z. $

Consider $f(x, y, z) = "constant"$, which represents a surface in 3D space. In this case, it implicitly defines

$ z = z(x, y), quad x = (y, z), quad y = (x, z), $
but we may not be able to find the solutions explicitly.

However, we can still evaluate #ponder("calculus.derivative")[derivatives] like $eval((∂ z)/(∂ x))_y$.

#example[
  In the equation $ x y + y^2 z + z^5 = 1, $ we cannot find $z(x, y)$ explicitly.
  However, we can take the #ponder("calculus.derivative")[derivative] with respect to $x$ holding $y$ fixed only, we get
  $
    "LHS" = y + y^2 eval((∂ z)/(∂ x))_y + 5 z^4 eval((∂ z)/(∂ x))_y & = 0 \
                                                eval((∂ z)/(∂ x))_y & = -(y)/(y^2 + 5 z^4).
  $

  #remark[
    Be aware that $eval((∂ "LHS")/(∂ x))_y != eval((∂ "LHS")/(∂ x))_z$.
  ]
]

#theorem("Cyclical rule")[
  If $f(x, y, z) = "constant"$, then
  $ eval((∂ x)/(∂ y))_z eval((∂ y)/(∂ z))_x eval((∂ z)/(∂ x))_y = -1. $
] <cyclical-rule>

#proof[
  In general, if $f(x, y, z) = "constant"$, then
  $ 0 = dif f = eval((∂ f)/(∂ x))_(y, z) dif x + eval((∂ f)/(∂ y))_(x, z) dif y +eval((∂ f)/(∂ z))_(x, y) dif z. $

  Therefore, we can't vary $x, y, z$ independently and stay on the surface.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d3e1.svg", width: 28em)
  ]

  Thus (be aware that $z$ is not fixed),

  $
    0 = eval((∂ f)/(∂ x))_y &= eval((∂ f)/(∂ x))_(y, z) eval((∂ x)/(∂ x))_y + eval((∂ f)/(∂ y))_(x, z) eval((∂ y)/(∂ x))_y +eval((∂ f)/(∂ z))_(x, y) eval((∂ z)/(∂ x))_y\
    0 = eval((∂ f)/(∂ x))_y &= eval((∂ f)/(∂ x))_(y, z) dot 1 + eval((∂ f)/(∂ y))_(x, z) dot 0 +eval((∂ f)/(∂ z))_(x, y) eval((∂ z)/(∂ x))_y\
    0 = eval((∂ f)/(∂ x))_y &= eval((∂ f)/(∂ x))_(y, z) +eval((∂ f)/(∂ z))_(x, y) eval((∂ z)/(∂ x))_y\
    eval((∂ z)/(∂ x))_y &= -eval((∂ f)/(∂ x))_(y, z) / eval((∂ f)/(∂ z))_(x, y).
  $

  We can similarly find $eval((∂ x)/(∂ y))_z$ and $eval((∂ y)/(∂ z))_x$.

  Therefore, we can conclude

  $ eval((∂ x)/(∂ y))_z eval((∂ y)/(∂ z))_x eval((∂ z)/(∂ x))_y = -1. $
]

The *reciprocal rule* applies if the same variables are held fixed:

$ eval((∂ x)/(∂ z))_y = - eval((∂ f)/(∂ z))_(x, y) / eval((∂ f)/(∂ x))_(y, z). $

Therefore,

$ eval((∂ x)/(∂ z))_y = (1)/(eval((∂ z)/(∂ x))_y ). $

#important[
  For the change in variables $(r, theta) -> (x, y)$, we have
  $ eval((∂ r)/(∂ x))_(y) = (1)/(eval((∂ x)/(∂ r))_(y)) $
  but
  $ eval((∂ r)/(∂ x))_(y) != (1)/(eval((∂ x)/(∂ r))_(theta)). $
]

== #ponder("calculus.leibniz-integral-rule")[Differentiation of an Integral w.r.t. a Parameter]

#theorem[
  For a family of functions $f(x; c)$ where $c$ is a parameter, define

  $ I(c) = integral_a(c)^b(c) f(x; c) dif x. $

  Then

  $
    (dif I)/(dif c) = integral_a(c)^b(c) (∂)/(∂ c) f(x; c) dif x + f(b(c);c) (dif b)/(dif c) - f(a(c); c) (dif a)/(dif c).
  $
] <diff-integral-param>

#proof[
  By definition,
  $
    (dif I)/(dif c) &= lim_(delta c->0) (1)/(delta c) [integral_(a(c+delta c))^(b(c+delta c)) f(x; c + delta c) dif x underbracket(- integral_(a(c))^(b(c)) f(x; c) dif x, (4))]. \
  $

  Now let us consider the parts of the expression separately.

  $
    integral_(a(c+delta c))^(b(c+delta c)) f(x; c + delta c) dif x &= underbracket(integral_a(c)^b(c), (1)) + underbracket(integral_(b(c))^(b(c+delta c)), (2)) -underbracket(integral_a(c)^a(c+delta c), (3)) \
  $

  Hence

  $
    (1)+(4): & lim_(delta c-> 0) (1)/(delta c)[integral_a(c)^b(c) (f(x;c+delta c) - f(x; c)) dif x] \
    = & integral_a(c)^b(c) (∂ f)/(∂ c) (x; c) dif x. \
    (2): &lim_(delta c->0) (1)/(delta c) [underbracket(integral_b(c)^b(c+delta c) f(x; c+delta c) dif x, [b(c+delta c) - b(c)]f(overline(x); c+delta c) "by MVT") ] \
    =&(dif b)/(dif c) f(b(c); c)\
    (3): &"follows the same trick, and the result can be claimed."
  $
]

#example[
  Consider $ I(lambda)=integral_0^lambda ee^(-lambda x^2) dif x. $
  Then

  $
    ( dif I)/(dif lambda) = integral_(0)^(lambda) -x^2ee^(-lambda x^2) dif x + ee^(-lambda^3) (dif lambda)/(dif lambda).
  $
]

#example[
  Suppose that we want to evaluate
  $ J_n = integral_0^oo x^n ee^(-x) dif x. $

  Then, let $ I(lambda) = integral_0^oo e^(-lambda x) dif x = (1)/(lambda) $ with $lambda > 0$. Hence

  $ (dif^(n) I)/(dif lambda^(n)) = integral_0^oo (-x)^n ee^(-lambda x) dif x = ((-1)^n n!)/(lambda^(n+1)). $

  #important[
    Note that in this step we are still using @diff-integral-param, it is just that the limits are now $0$ and $oo$, which are independent of $lambda$, so the last two terms vanish.
  ]

  Setting $lambda = 1$, we get $J_n = n!$.
]
