#import "../prelude.typ": *

#lecture-separator(lecture: 6, date: "2025-10-22")

= #ponder("ode.order")[First-Order] #ponder("ode.linear-differential-equation")[Linear] Differential Equations

#definition([$n$th Order Differential Equation])[
  A differential equation is of *#ponder("ode.order")[$n$th order]* if the highest #ponder("calculus.derivative")[derivative] in the equation is of order $n$.
] <nth-order-differential-equation>

#definition("Linear Differential Equation")[
  A differential equation is *#ponder("ode.linear-differential-equation")[linear]* if the dependent variable $y$ appears linearly.
] <linear-differential-equation>

#definition("Ordinary Differential Equation")[
  A differential equation is *#ponder("ode.ordinary-differential-equation")[ordinary]* if it contains one independent variable and its #ponder("calculus.derivative")[derivatives].
] <ordinary-differential-equation>

#example[
  $ x^2y + y' = 0 $
  is a #ponder("ode.order")[first-order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ordinary differential equation].
]

== The #ponder("calculus.exponential-function")[Exponential Function]

In order to introduce #ponder("ode.order")[first-order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ordinary differential equations], we first need to explore the #ponder("calculus.exponential-function")[exponential function].

#definition("Exponential Function")[
  The *#ponder("calculus.exponential-function")[exponential function]* is defined the infinite series
  $ exp(x) = sum_(n=0)^(oo) (x^n)/(n!). $
  This can also be written as
  $
    exp(x) & = lim_(k->oo) (1+(x)/(k))^k \
           & = lim_(k->oo) [1+k (x)/(k) + (k (k-1))/(2!) ((x)/(k))^2 + ...] quad "using the binomial theorem".
  $
] <exponential-function>

Differentiaing the #ponder("calculus.exponential-function")[exponential function], we have
$
  (dif )/(dif x) exp(x) & = 1 + (2)/(2!)x + (3)/(3!) x^2 +... \
                        & = exp(x).
$

This allows us to define the #ponder("calculus.exponential-function")[exponential function] in another way. We can define $exp(x)$ to be the solution of

$ (dif f)/(dif x) =f $

with the initial condition $f(0) = 1$.

#proposition[
  The #ponder("calculus.exponential-function")[exponential function] satisfies this key property:
  $ exp(a + b) = exp(a) exp(b). $
] <exponential-addition-formula>

Following this property, it suggests that we should write $exp(x)$ as $ee^x$, where

$ ee = exp(1)=lim_(k->oo) (1+(1)/(k))^k. $

The inverse function $ln x$ is defined as the function where

$ exp(ln x) = x. $

It follows that $a^x = (ee^(ln a))^x = ee^(x ln a)$

Hence

$ (dif a^x)/(dif x) = (dif e^(x ln a))/(dif x) = e^(x ln a) ln a = a^x ln a. $

#definition("Eigenfunction")[
  An *#ponder("ode.eigenfunction")[eigenfunction]* of an operator is a function that is unchanged up to multiplicative scaling by the *eigenvalue*, under action of the operator.

  In case of the differential operator, an #ponder("ode.eigenfunction")[eigenfunction] satisfies

  $ (dif)/(dif x) f(x) = lambda f(x). $
] <eigenfunction>

Hence, the #ponder("ode.eigenfunction")[eigenfunctions] of the differential operator are of the form
$ f(x) = C ee^(lambda x) $

== #ponder("ode.order")[First Order] #ponder("ode.linear-differential-equation")[Linear] #ponder("ode.ordinary-differential-equation")[Ordinary Differential Equations]


#definition("Homogeneous Differential Equation")[
  A differential equation is *#ponder("ode.homogeneous-differential-equation")[homogeneous]* if all terms involve the dependent variable or its #ponder("calculus.derivative")[derivatives]. This implies that $y=0$ is a solution (trivial solution).
] <homogeneous-differential-equation>

#proposition[
  Here are some properties of #ponder("ode.order")[first-order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ordinary differential equations].

  - Any #ponder("ode.order")[$n$th order] #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE] has $n$ independent solutions.
  - For any #ponder("ode.linear-differential-equation")[linear] #ponder("ode.homogeneous-differential-equation")[homogenous] #ponder("ode.ordinary-differential-equation")[ODE], any constant multiple of a solution is also a solution.
]

=== #ponder("ode.homogeneous-differential-equation")[Homogeneous] #ponder("ode.linear-differential-equation")[Linear] #ponder("ode.ordinary-differential-equation")[ODEs] with #ponder("ode.constant-coefficients")[Constant Coefficients]

#definition("Constant Coefficients")[
  A differential equation has *#ponder("ode.constant-coefficients")[constant coefficients]* if the independent variable does not appear explicitly.
] <constant-coefficients>

#proposition[
  Solutions of #ponder("ode.linear-differential-equation")[linear] #ponder("ode.homogeneous-differential-equation")[homogeneous] #ponder("ode.ordinary-differential-equation")[ODEs] with #ponder("ode.constant-coefficients")[constant coefficients] (for any order) are of the form $ee^(lambda x)$
] <constant-coefficient-homogeneous-solutions>

#example[
  Consider the equation
  $ 5 (dif y)/(dif x) - 3 y = 0. $

  We should try $y = A ee^(lambda x)$. Then
  $ 5 lambda A ee^(lambda x) - 3 A ee^(lambda x) = 0. $
  Which leads to (given that $A != 0$)
  $ 5 lambda -3=0 quad "(characteristic equation)" $
  So $lambda = (3)/(5) => y = A ee^((3x)/(5))$.

  This is the general solution, as it contains an arbitrary constant $A$.
] <ex-homo-ode>

To specify unique solutions, it requires us to apply suitable initial conditions. #fade[[$n$ conditions are needed for a $n$th order ODE.]]

For example, in @ex-homo-ode, if we have $y(0)=y_0$, then $A=y_0$.

=== Discrete Equations

It is sometimes useful to consider functions evaluated at discrete points.

Consider again $5y' - 3y = 0$ with $y(0)=y_0$.

We can approximate this equation by discrete form at ${x_n}$ with $x_n = n h$ and $x_0 = 0$. With $y_(n) = y(x_(n))$, we have

$ eval((dif y)/(dif x))_x_0 approx (y_(n+1)-y_(n))/(h). $

#fade[[This is called the Forward Euler scheme, which is not a great approximation numerically.]]

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d4e1.svg", width: 18em)
]

Substituting this approximation into the original equation gives

$
  5 (y_(n+1) - y_(n))/(h) - 3 y_(n) & = 0 \
                            y_(n+1) & = (1+(3)/(5) h) y_(n) quad ("recurrence relation")
$

Hence we have

$
  y_(n) & = (1+(3)/(5) h) y_(n-1) \
        & = (1+(3)/(5) h)^2 y_(n-2) \
        & = ... \
        & = (1+(3)/(5) h)^n y_0 \
        & = (1+(3 x)/(5 n))^n y_0 quad "by taking" h = (x)/(n). \
$

Now take $x_(n) = x$ #fade[[this represents $n$ steps from $x=0$ to $x$]] as $n->oo$. Then
$ lim_(n->oo) y_n = lim_(n->oo) y_0 (1+(3x)/(5n))^n = y_0 exp((3)/(5) x) $

which, thankfully, agrees with the continuous case.

=== Series Solutions

This is a powerful way to solve ODEs. Essentially, we are looking for soluions in the form of a power series,

$ y(x)=sum_(n=0)^(infinity) a_n x^n $

where we will determine $a_n$ by substituting into the ODE.

#example[
  We shall get back to the example
  $ 5y'-3y=0. $
  Then, we have
  $ (dif y)/(dif x) sum_(n=0)^(infinity) a_n n x^(n-1) = sum_(n=1)^(infinity) a_n n x^(n-1). $
  Thus,

  $
    x (dif y)/(dif x) & = sum_(n=1)^(infinity) a_n n x^n. \
  $
  Also, by multiplying our original series by $x$,
  $
    x y & = sum_(n=0)^(infinity) a_n x^(n+1) \
        & = sum_(n=1)^(infinity) a_(n-1) x^n. \
  $

  #lecture-separator(lecture: 7, date: "2025-10-24")

  Therefore, substituting into the ODE gives
  $
    sum_(n=1)^(infinity) underbracket((5 a_n n - 3 a_(n-1)), "must vanish for all" n>=1) x^n & = 0. \
  $
  Hence we can derive the recurrence relation
  $ a_n = (3)/(5 n) a_(n-1) $
  Therefore
  $
    a_n & = (3)/(5 n) a_(n-1) \
        & = (3)/(5 n) (3)/(5 (n-1)) a_(n-2) \
        & = ... \
        & = (3^n)/(5^n n!) a_0. \
  $
  and $ y(x) = a_0 sum_(n=0)^(oo) (1)/(n!) ((3x)/5)^n = a_0 exp((3x)/(5)) $
]

== Forced (non-#ponder("ode.homogeneous-differential-equation")[homogeneous]) #ponder("ode.ordinary-differential-equation")[ODEs]

In a forced #ponder("ode.ordinary-differential-equation")[ODE], there are terms not involving the dependent variable or its #ponder("calculus.derivative")[derivatives]. In this case, in general, $y=0$ is no longer a solution. To solve these equations, we should do the followings.

1. Find *any* solution of the forced equation, called a #ponder("ode.particular-integral")[particular integral] (PI) $y_p (x)$.

2. Write the general solution as $y(x) = y_p (x) + y_c (x)$, and find the #ponder("ode.particular-integral")[complementary function] (CF) $y_c (x)$ that satisfies the corresponding #ponder("ode.homogeneous-differential-equation")[homogeneous] equation.

3. Combine $y_p$ and $y_c$ to get the general solution.

This method is general for *#ponder("ode.linear-differential-equation")[linear]* #ponder("ode.ordinary-differential-equation")[ODEs].

=== Constant Forcing

#example("Constant forcing")[

  Consider

  $ 5y' - 3y = underbracket(10, "constant forcing term"). $

  A #ponder("ode.particular-integral")[particular integral] is $y_p(x) = - (10)/(3)$, since substituting it gives

  $ 5 (dif y_p)/(dif x) - 3 y_p = 0 - 10 = 10. $

  Then the #ponder("ode.particular-integral")[complementary function] is the solution of the #ponder("ode.homogeneous-differential-equation")[homogeneous] equation $5 y' - 3 y = 0$, which we have already solved as $y_c (x) = A exp((3x)/(5))$.

  Hence, the general solution is
  $ y(x) = A exp((3x)/(5)) - (10)/(3). $
] <ex-constant-forcing>

=== #ponder("ode.eigenfunction")[Eigenfunction] Forcing

The forcing term may also be an #ponder("ode.eigenfunction")[eigenfunction] of the differential operator.

#example("Radioactive Decay")[
  Consider the decay between three isotopes $"A", "B", "C"$, with decay constants $k_a, k_b$ for $"A"$ and $"B"$ respectively.

  $
    underbracket("A", a(t)) attach(->, t: k_a a) underbracket("B", b(t)) attach(->, t: k_b b) underbracket("C", c(t))
  $

  Thus we have

  $
    (dif a)/(dif t) & = - k_a a \
                  a & = a_0 exp(-k_a t) \
  $

  and also

  $
            (dif b)/(dif t) & = k_a a - k_b b \
    (dif b)/(dif t) + k_b b & = underbracket(k_a a_0 exp(-k_a t), "forcing term is an eigenfunction"). \
  $

  We shall try the #ponder("ode.particular-integral")[particular integral] of the form $b_p (t) = beta exp(-k_a t)$. Substituting it gives

  $
    - k_a beta exp(-k_a t) + k_b beta exp(-k_a t) & = k_a a_0 exp(-k_a t) \
                                 (k_b - k_a) beta & = k_a a_0 \
                                             beta & = (k_a a_0)/(k_b - k_a) quad (k_a != k_b). \
  $

  #remark[
    If $k_a = k_B$, we need another #ponder("ode.particular-integral")[particular integral]. See @ex-radioactive-decay-revisited.
  ]

  Hence $b_c (t)$ is the solution of the #ponder("ode.homogeneous-differential-equation")[homogeneous] equation $(dif b_c)/(dif t) + k_b b_c = 0$. Thus

  $ b_c (t) = D exp(-k_b t). $

  Thus, the general solution is
  $ b(t) = (k_a a_0)/(k_b - k_a) exp(-k_a t) + D exp(-k_b t). $

  #separator

  Now, if we were given the initial conditions $b(0) = 0$, then
  $
    b(0) & = (k_a a_0)/(k_b - k_a) + D = 0 \
       D & = - (k_a a_0)/(k_b - k_a). \
  $

  Hence,

  $ b(t) = (k_a a_0)/(k_b - k_a) [exp(-k_a t) - exp(-k_b t)]. $

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d4e2.svg", width: 22em)
  ]

] <ex-radioactive-decay>

== Non-constant Coefficients

The general form of such equations is

$
  a(x) (dif y)/(dif x) + b(x) y = c(x).
$

We can get the standard form by dividing both sides by $a(x)$ (assuming $a(x) != 0$):

$
  (dif y)/(dif x) + P(x) y = f(x).
$

To solve these equations, we use an #ponder("ode.integrating-factor")[integrating factor] (IF) $mu(x)$. Multiplying our standard form by $mu(x)$ gives

$
  mu y' + mu P y = mu f.
$

We want the left-hand side to be $(mu y)'$, so we require $mu' = mu P$ by the #ponder("calculus.product-rule")[product rule]. This is a separable equation, so

$
  mu'/mu = P => integral P dif x = integral mu'/mu dif x = ln u. quad ("up to constant")
$

Therefore,
$ mu(x) = exp(integral^x P(u) dif u), $

which is unique up to an irrelevant constant factor. Hence, the original equation becomes

$
  (dif )/(dif x) (mu y) & = mu f \
                => mu y & = integral mu f dif x. \
$

#example[
  Consider the equation
  $
                             x y' + (1-x)y & = 1 \
    y' + underbracket((1 - x)/(x), P(x)) y & = underbracket((1)/(x), f(x)). \
  $
  The #ponder("ode.integrating-factor")[integrating factor] is
  $
    mu(x) & = exp(integral (1 - x)/(x) dif x) \
          & = exp(
              integral (1)/(x) dif x - integral 1
              dif x
            ) \
          & = exp(ln x - x) = x ee^(-x). \
  $

  Therefore,

  $
    (dif )/(dif x) (x ee^(-x) y) & = ee^(-x) \
                     x ee^(-x) y & = - ee^(-x) + C \
                               y & = (C ee^(x) - 1)/(x). \
  $

  #remark[
    We require $c = 1$ if we want $y$ to be finite as $x->0$.
  ]
] <ex-integrating-factor>

Let us get back to @ex-radioactive-decay.

#example("Radioactive Decay, Revisited")[
  We have
  $
    (dif b)/(dif t) + k_b b & = k_a a_0 exp(-k_a t). \
  $
  We can identify $P(t) = k_b$ and $f(t) = k_a a_0 exp(-k_a t)$. Thus, the #ponder("ode.integrating-factor")[integrating factor] is
  $
    mu(t) & = exp(integral k_b dif t) \
          & = exp(k_b t). \
  $
  Hence,

  $
    dif /(dif t) (exp(k_b t) b) = k_a a_0 exp((k_b - k_a) t).
  $

  Let us consider two cases.

  - If $k_b != k_a$, then

    $
      exp(k_b t) b & = (k_a a_0)/(k_b - k_a) exp((k_b - k_a) t) + C \
                 b & = (k_a a_0)/(k_b - k_a) exp(-k_a t) + C exp(-k_b t). \
    $

    This is exactly the solution we arrived at in @ex-radioactive-decay, using the PI and CF method.

  - If $k_b = k_a$, then

    $
      dif /(dif t) (exp(k_a t) b) & = k_a a_0 \
    $
    Thus,
    $
      exp(k_a t) b & = k_a a_0 t + C \
                 b & = k_a a_0 t exp(-k_a t) + C exp(-k_a t). \
    $

    Note that the #ponder("ode.particular-integral")[particular integral] is now proportional to $t exp(-k_a t)$, which is different from the previous case. This is called the _resonance case_.

] <ex-radioactive-decay-revisited>
