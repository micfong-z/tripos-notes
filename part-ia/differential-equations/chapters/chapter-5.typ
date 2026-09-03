#import "../prelude.typ": *

#lecture-separator(lecture: 8, date: "2025-10-27")

= Nonlinear #ponder("ode.order")[First-Order] #ponder("ode.ordinary-differential-equation")[ODEs]

Recall that a non-linear #ponder("ode.ordinary-differential-equation")[ODE] is one in which the dependent variable #fade[[usually $y$]] and its #ponder("calculus.derivative")[derivatives] appear with exponents other than 1 or are multiplied together.

#set math.equation(numbering: "«1")

The general form of a #ponder("ode.order")[first-order] nonlinear #ponder("ode.ordinary-differential-equation")[ODE] is
$
  Q(x, y) (dif y)/(dif x) +P(x, y)=0.
$ <general-nonlinear-ode>

#fade[[The term in $(dif y)/(dif x)$ could be nonlinear, but it is not considered here.]]

#set math.equation(numbering: none)

We have two special cases of nonlinear #ponder("ode.order")[first-order] #ponder("ode.ordinary-differential-equation")[ODEs] that we can solve: #ponder("ode.separable-equation")[separable equations] and #ponder("ode.exact-equation")[exact equations].

== #ponder("ode.separable-equation")[Separable Equations]

#definition[Separable Equations][
  A #ponder("ode.order")[first-order] #ponder("ode.ordinary-differential-equation")[ODE] is called *#ponder("ode.separable-equation")[separable]* if it can be written in the form
  $ q(y) dif y = p(x) dif x. $
] <separable-equation>

These equations can be solved by integrating both sides.

$ integral q(y) dif y = integral p(x) dif x. $

#example[
  Consider the equation
  $ (x^2y-3y) (dif y)/(dif x) -2 x y^2 = 4 x. $

  Rearranging the equation gives
  $
    y(x^2-3) (dif y)/(dif x) & = 2x(2+y^2) \
           (y)/(2+y^2) dif y & = (2x)/(x^2-3) dif x. \
       (1)/(2) ln abs(2+y^2) & = ln abs(x^2-3) + C \
        abs(2+y^2)^((1)/(2)) & = A abs(x^2-3). \
  $
]

== #ponder("ode.exact-equation")[Exact equations]

#definition[Exact Equations][
  The #ponder("ode.ordinary-differential-equation")[ODE] @general-nonlinear-ode is called *#ponder("ode.exact-equation")[exact]* if $P(x, y) dif x+Q(x, y) dif y$ is an exact differential, _i.e._ there exists a function $f(x, y)$ such that
  $ dif f = P(x, y) dif x + Q(x, y) dif y. $

  In particular, if @general-nonlinear-ode is #ponder("ode.exact-equation")[exact], then $dif f=0$ and $f(x, y)$ being a constant is a solution.
] <exact-equation>

If an #ponder("ode.ordinary-differential-equation")[ODE] is #ponder("ode.exact-equation")[exact], then using the #ponder("calculus.multivariate-chain-rule")[multivariate chain rule], we have

$
  dif f = underbracket((∂f)/(∂x), P) dif x + underbracket((∂f)/(∂y), Q) dif y.
$

So, we can solve #ponder("ode.exact-equation")[exact equations] by finding a function $f(x, y)$ such that $(∂f)/(∂x) = P(x, y)$ and $(∂f)/(∂y) = Q(x, y)$.

Since #ponder("calculus.partial-derivative")[partial derivatives] commute, we have

$ (∂P)/(∂y) = (∂^2f)/(∂y∂x) = (∂^2f)/(∂x∂y) = (∂Q)/(∂x). $

This is a necessary condition but not sufficient for #ponder("ode.exact-equation")[exactness]:

$ (∂P)/(∂y) = (∂Q)/(∂x). $

#theorem[
  If $(∂P)/(∂y) = (∂Q)/(∂x)$ throughout a #ponder("analysis.simply-connected-domain")[simply connected domain] $cal(D)$, then $P dif x + Q dif y$ is an exact differential of a single-valued function $f(x, y)$ on $cal(D)$.
] <exactness-criterion>

#definition[Simply Connected Domain][
  A domain $cal(D)$ is *#ponder("analysis.simply-connected-domain")[simply connected]* if it is #ponder("analysis.path-connectedness")[path connected], any any closed curve can be continuously shrunk to a point within $cal(D)$ without leaving $cal(D)$.
] <simply-connected-domain>

#definition[Path Connectedness][
  A domain $cal(D)$ is *#ponder("analysis.path-connectedness")[path connected]* if every pair of points in $cal(D)$ can be connected by a path in $cal(D)$.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d5e1.svg", width: 16em)
  ]
] <path-connectedness>

#example[
  Consider the equation
  $ 6y(y-x) (dif y)/(dif x) + 2x - 3 y^2 = 0. $
  Rewriting gives
  $ underbracket((2x-3y^2), P)dif x + underbracket(6y(y-x), Q) dif y & = 0 \ $

  Hence we have
  $ (∂P)/(∂y) = -6y = (∂Q)/(∂x) = -6y. $

  Hence, the equation is #ponder("ode.exact-equation")[exact] in any #ponder("analysis.simply-connected-domain")[simply connected domain].

  Thus $ P=eval((∂f)/(∂x))_y & = 2x - 3y^2 \
              f(x, y) & = x^2-3 x y^2 + h(y) \ $

  and similarly,
  $
        Q=6y^2-6x y & = eval((∂f)/(∂y))_x = -6x y + (dif h)/(dif y) \
    (dif h)/(dif y) & = 6y^2 \
               h(y) & = 2 y^3 + C. \
  $
  Hence $f(x, y) = x^2 - 3 x y^2 + 2 y^3 + C = "constant"$, and we have the implicit solution
  $ x^2 - 3 x y^2 + 2 y^3 = A. $
]

== Solution Curves and #ponder("ode.isocline")[Isoclines]

The general idea is that nonlinear #ponder("ode.ordinary-differential-equation")[ODEs] are often impossible to solve in simple closed forms. We can still analyse the behaviour of solutions using graphical methods.

=== Solution Curves

Consider $ (dif y) / (dif t) = f(t, y). quad (y=y(t)) $

Then, each initial condition (_e.g._ $y(0)=y_0$) generates a distinct solution curve (trajectory).

#align(center)[
  #dynamic-svg("/part-ia/differential-equations/media/d5e2.svg", width: 22em)
]

We can still sketch these solution curves without actually solving the #ponder("ode.ordinary-differential-equation")[ODE].

#example[
  We can solve the following equation to illustrate the ideas:

  $ (dif y)/(dif t) = t(1-y^2). $
  This is a #ponder("ode.separable-equation")[separable equation]:
  $
                        (1)/(1-y^2) dif y & = t dif t \
    (1)/(2) ((1)/(1+y) + (1)/(1-y)) dif y & = t dif t \
              (1)/(2) ln abs((1+y)/(1-y)) & = (1)/(2) t^2 + C \
                                          & dots.v \
                                        y & = (A - ee^(-t^2))/(A + ee^(-t^2)) quad "where" A=cases(
                                              ee^(2C) & "if" abs(y) < 1,
                                              -ee^(2C) & "if" abs(y) > 1,
                                            ). \
  $
  Hence, we have a family of solution curves parameterised by $A$.

  If $y(0)=y_0$, then $A = (1+y_0)/(1-y_0)$. Now, we can sketch the solution curves for various $y_0$.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d5e3.svg", width: 32em)
  ]

  Note that, some general behavior follows directly from the #ponder("ode.ordinary-differential-equation")[ODE]:

  - $dot(y) = 0$ for all $t$ if $y = plus.minus 1$. Hence we have two constant solution curves at $y=1$ and $y=-1$.

  - $dot(y) = 0$ at $t=0$ for any $y$. Hence, all solution curves have a horizontal tangent at $t=0$.
]

#lecture-separator(lecture: 9, date: "2025-10-29")


The equation $(dif y)/(dif t) = f(t, y)$ gives us the gradient of the solution through $(t, y)$.

Note that the solution curves can't cross if $f(t, y)$ is single valued.

#definition("Slope field")[
  The *#ponder("ode.slope-field")[slope field]* represents the gradient field by short _sticks_, one centered on each point. It is tangent to the solution curves.
] <slope-field>

#example[
  Consider
  $ (dif y)/(dif t) = t(1-y^2). $
  Then, for $t > 0$,
  - $dot(y) > 0$ for $abs(y) < 1$ and
  - $dot(y) < 0$ for $abs(y) > 1$.
]

#definition("Isoclines")[
  #ponder("ode.isocline")[Isoclines] are curves along which $dot(y)$ is a constant. This can sometimes be useful when sketching solution curves.
] <isocline>


#example[
  For $ (dif y)/(dif t) = t(1-y^2), $
  we have
  $
    t(1-y^2) & = D \
         y^2 & = 1- (D)/(t)
  $
  for some constant $D$.

  #align(center)[
    #dynamic-svg2("/part-ia/differential-equations/media/dxe2.svg", width: 21em)
  ]
]

== #ponder("ode.equilibrium-point")[Fixed (Equilibrium) Points] and #ponder("ode.equilibrium-stability")[Stability]

These points often reveal important features of #ponder("ode.ordinary-differential-equation")[ODEs].

#definition("Fixed Point")[
  A *#ponder("ode.equilibrium-point")[fixed point]* (or *#ponder("ode.equilibrium-point")[equilibrium point]*) of an #ponder("ode.ordinary-differential-equation")[ODE] $(dif y)/(dif t) = f(t, y)$ is a constant solution $y = c$, such that $(dif y)/(dif t) = 0 space forall t$.
] <equilibrium-point>

#example[
  Consider $ (dif y)/(dif t) = t(1-y^2). $
  The #ponder("ode.equilibrium-point")[fixed points] are $y = plus.minus 1$. They have very different character as seen from the sketchs above. The solution curves $y = +1$ as $t->oo$, while those near $y = -1$ diverge away from it.
]

#definition("Stability of Fixed Points")[
  A #ponder("ode.equilibrium-point")[fixed point] $y=c$ is
  - *#ponder("ode.equilibrium-stability")[stable]* if whenever $y$ deviates slightly from $c$, $y$ converges to $c$ as $t->oo$.
  - *#ponder("ode.equilibrium-stability")[unstable]* if whenever $y$ deviates slightly from $c$, $y$ diverges from $c$ as $t->oo$.
] <equilibrium-stability>

=== Perturbation Analysis and #ponder("ode.equilibrium-stability")[Stability]

Let $y = c$ be a #ponder("ode.equilibrium-point")[fixed point] of $(dif y)/(dif t) = f(t, y)$ #fade[[_i.e._ $f(t, c) = 0$ for all $t$]]. Consider a small perturbation about the #ponder("ode.equilibrium-point")[fixed point]:
$ y(t) = c + epsilon(t), quad abs(epsilon) << 1. $

We want to analyze how $epsilon(t)$ behaves as $t->oo$.

Then

$
  (dif y)/(dif t) = (dif epsilon)/(dif t) & = f(t, c + epsilon) \
  & = underbracket(f(t, c), =0 "at F.P.") + epsilon (∂f)/(∂y)(t, c) + O(epsilon^2)
$

Linearize for small epsilon:
$
  (dif epsilon)/(dif t) & approx epsilon (∂f)/(∂y)(t, c). \
$
Not that this is a #ponder("ode.linear-differential-equation")[linear] #ponder("ode.ordinary-differential-equation")[ODE] in $epsilon$.

Note that if $(∂f)/(∂y)(t, c) = 0$, then we need higher order terms to determine #ponder("ode.equilibrium-stability")[stability].

#example[
  Consider the equation
  $ (dif y)/(dif t) = t(1-y^2). $

  We are aware that the #ponder("ode.equilibrium-point")[fixed points] are $y = plus.minus 1$. We have

  $
    (∂f)/(∂y) = -2t y = cases(
      -2t quad y = +1,
      +2t quad y = -1
    )
  $

  Near $y = 1$: $ (dif epsilon)/(dif t) approx -2 t epsilon => epsilon(t) = epsilon_0 ee^(-t^2). $
  Hence, as $t->oo$, $epsilon(t)->0$ and the #ponder("ode.equilibrium-point")[fixed point] at $y=1$ is #ponder("ode.equilibrium-stability")[stable].

  Near $y = -1$: $ (dif epsilon)/(dif t) approx 2 t epsilon => epsilon(t) = epsilon_0 ee^(t^2). $
  Hence, as $t->oo$, $epsilon(t)->oo$ and the #ponder("ode.equilibrium-point")[fixed point] at $y=-1$ is #ponder("ode.equilibrium-stability")[unstable].
]

#remark[
  This perturbation analysis only work for small $epsilon$. Hence, we only really have the behavior of solutions close to the #ponder("ode.equilibrium-point")[fixed point].
]

=== #ponder("ode.autonomous-system")[Autonomous Systems] and Phase Portraits

#definition("Autonomous system")[
  #ponder("ode.autonomous-system")[Autonomous systems] are #ponder("ode.ordinary-differential-equation")[ODEs] in which the independent variable (_e.g._ $t$) does not appear explicitly in the equation. _e.g._
  $ (dif y)/(dif t) = f(y). $
] <autonomous-system>

First of all, these #ponder("ode.autonomous-system")[autonomous systems] are #ponder("ode.separable-equation")[separable]. We can write

$ integral^y (dif u)/(f(u)) = t - t_0. $

Hence, if $y(t)$ is a solution, then so is $y(t - t_0)$ for any constant $t_0$.

Although this equation is #ponder("ode.separable-equation")[separable], we may not be able to solve it in closed form. Consider, near a #ponder("ode.equilibrium-point")[fixed point] $y= c$, we have

$
  (dif y)/(dif t) = (dif epsilon)/(dif t) = epsilon underbracket((dif f)/(dif y)(c), "constant" k) & = k epsilon \
  epsilon(t) & = epsilon_0 ee^(k t). \
$

#remark[
  $(dif f)/(dif y)(c)$ is a constant since we are evaluating at some #ponder("ode.equilibrium-point")[fixed point].
]

Hence, if

- $k = f'(c) < 0$, then the #ponder("ode.equilibrium-point")[fixed point] is #ponder("ode.equilibrium-stability")[stable].
- $k = f'(c) > 0$, then the #ponder("ode.equilibrium-point")[fixed point] is #ponder("ode.equilibrium-stability")[unstable].

#example("Chemical kinetics")[
  Consider a chemical reaction
  $ A + B -> C + D. $
  The number of molecules of $A, B, C, D$ at time $t$ are $a(t), b(t), c(t), d(t)$ respectively.

  The initial numbers are $a(0) = a_0, b(0) = b_0, c(0) = 0, d(0) = 0$. Hence, we have the conservation laws
  $
    a(t) & = a_0 - c(t) \
    b(t) & = b_0 - c(t) \
    d(t) & = c(t)
  $
  since one of $A$ and $B$ is consumed to produce one of $C$ and $D$. Assume that the rate of reaction is proportional to the product of the numbers of $A$ and $B$ molecules (_e.g._ we considering dilute gases):
  $
    (dif c)/(dif t) = lambda a(t) b(t) = underbracket(lambda (a_0 - c)(b_0 - c), f(c)). \
  $
  Therefore, we have an example of an #ponder("ode.autonomous-system")[autonomous] non-linear #ponder("ode.order")[first-order] #ponder("ode.ordinary-differential-equation")[ODE].

  Note that the #ponder("ode.equilibrium-point")[fixed points] are $c = a_0$ and $c = b_0$ (corresponding to the complete consumption of either $A$ or $B$).

  #lecture-separator(lecture: 10, date: "2025-10-31")

  Now assume $a_0 < b_0$. Then, $c = b_0$ is unphysical. We shall now carry out perturbation analysis to determine the #ponder("ode.equilibrium-stability")[stability] of the #ponder("ode.equilibrium-point")[fixed points].

  $
    (dif f)/(dif c) = lambda(2 c - a_0 - b_0) = cases(
      lambda (a_0 - b_0) & "at" c = a_0,
      lambda (b_0 - a_0) & "at" c = b_0
    )
  $
  For $a_0 < b_0$, $c = a_0$ is a #ponder("ode.equilibrium-stability")[stable] #ponder("ode.equilibrium-point")[fixed point], while $c = b_0$ is an #ponder("ode.equilibrium-stability")[unstable] #ponder("ode.equilibrium-point")[fixed point].

  We can sketch a 1D phase portrait to visualise the behaviour of solutions.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d6e1.svg", width: 14em)
  ]

] <ex-chemical-kinetics>

#example("Population dynamics (logistic equation)")[
  Consider a population of size $y(t)$. We have

  - birth rate: $alpha y$ with $alpha > 0$,

  - death rate: $beta y + gamma y^2$, where
    - $beta y$ models isolated deaths
    - $gamma y^2$ models deaths due to overcrowding.

  Thus we have the #ponder("ode.ordinary-differential-equation")[ODE]
  $ (dif y)/(dif t) = alpha y - beta y - gamma y^2 = underbracket((alpha - beta) y - gamma y^2, f(y)). $
  To make things simpler, let $lambda = alpha - beta$ and $gamma = (lambda)/(Y)$. Then,
  $ (dif y)/(dif t) = lambda y (1 - (y)/(Y)) = f(y). $

  This is called a #ponder("ode.logistic-equation")[differential logistic equation]. It is an example of an #ponder("ode.autonomous-system")[autonomous system]. The #ponder("ode.equilibrium-point")[fixed points] are $y = 0$ and $y = Y$. We can carry out perturbation analysis to determine their #ponder("ode.equilibrium-stability")[stability].

  $
    (dif f)/(dif y) = lambda (1 - (2 y)/(Y)) = cases(
      lambda & "at" y = 0,
      -lambda & "at" y = Y
    )
  $

  For $lambda > 0$ ($alpha > beta$), $y = 0$ is an #ponder("ode.equilibrium-stability")[unstable] #ponder("ode.equilibrium-point")[fixed point], while $y = Y$ is a #ponder("ode.equilibrium-stability")[stable] #ponder("ode.equilibrium-point")[fixed point].

  We can sketch a 1D phase portrait to visualise the behaviour of solutions.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d6e2.svg", width: 14em)
  ]

  This equation can be solved exactly and sketched.

  #align(center)[
    #dynamic-svg2("/part-ia/differential-equations/media/dxe3.svg", width: 22em)
  ]
] <ex-logistic-equation>

== #ponder("ode.discrete-fixed-point")[Fixed Points] in Discrete Equations

#definition("First order discrete equation")[
  A *#ponder("ode.first-order-discrete-equation")[first-order discrete equation]* is a recurrence relation of the form
  $ x_(n+1) = f(x_n), quad n = 0, 1, 2, ... $
] <first-order-discrete-equation>

Note that the RHS is independent of $n$, which is like an #ponder("ode.autonomous-system")[autonomous system] in continuous #ponder("ode.ordinary-differential-equation")[ODEs].

#definition("Fixed point of 1st order discrete equation")[
  A *#ponder("ode.discrete-fixed-point")[fixed point]* of a #ponder("ode.first-order-discrete-equation")[1st order discrete equation] is a value of $x_n$ such that $x_(n+1) = x_n$, _i.e._ $x_n = f(x_n)$.
] <discrete-fixed-point>

We can also analyse the stability of #ponder("ode.discrete-fixed-point")[fixed points] in discrete equations using perturbation analysis. Let $x_f$ be a #ponder("ode.discrete-fixed-point")[fixed point], and write $x_n = x_f + epsilon_n$, where $abs(epsilon_n) << 1$.

Then,

$
        x_(n+1) & = x_f + epsilon_(n+1) \
         f(x_n) & = f(x_f + epsilon_n) \
                & = underbracket(f(x_f), = x_f "at F.P.") + epsilon_n f'(x_f) + O(epsilon_n^2) \
  epsilon_(n+1) & approx epsilon_n f'(x_f). \
$

Therefore, $x_f$ is

- *stable* if $abs(f'(x_f)) < 1$,

- *unstable* if $abs(f'(x_f)) > 1$.

#example[
  Consider the discrete equation
  $ x_(n+1) = underbracket(r x_n (1 - x_n), f(x_n)). $

  This is called a #ponder("ode.logistic-map")[discrete logistic equation], or the #ponder("ode.logistic-map")[logistic map]. We can compare this with the continuous #ponder("ode.logistic-equation")[logistic equation] in @ex-logistic-equation.

  #fade[[This is useful to model population dynamics when we consider births at discrete time intervals only.]]

  We are only interested in $x_n >= 0$. We can sketch the graph of $f(x)$ against $x$.

  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d6e3.svg", width: 16em)
  ]

  From the graph, if $0<= r <= 4$, then ${x_n}$ stay within $[0, 1]$.

  The #ponder("ode.discrete-fixed-point")[fixed points] satisfy $x_n = f(x_n) = r x_n (1- x_n)$. Hence, the #ponder("ode.discrete-fixed-point")[fixed points] are
  $ x_n = 0 quad "and" quad x_n = 1 - 1/r. $
  However, be aware that the second #ponder("ode.discrete-fixed-point")[fixed point] only makes sense for $r > 1$ (in order to be non-negative).

  We can carry out perturbation analysis to determine their stability.

  $
    f'(x_n) = r - 2 r x_n = cases(
      r & "at" x_n = 0,
      2 - r & "at" x_n = 1 - 1/r
    )
  $

  Therefore,

  - For the #ponder("ode.discrete-fixed-point")[fixed point] at $x_n = 0$:
    - stable if $0 < r < 1$,
    - unstable if $r > 1$.

  - For the #ponder("ode.discrete-fixed-point")[fixed point] at $x_n = 1 - 1/r$:
    - stable if $1 < r < 3$,
    - unstable if $r > 3$.

  We can illustrate the behaviour of solutions using cobweb diagrams.

  - Consider $0 < r < 1$.

    #align(center)[
      #dynamic-svg2("/part-ia/differential-equations/media/dxe4.svg", width: 16em)
    ]

    This shows that $x=0$ is a stable #ponder("ode.discrete-fixed-point")[fixed point]: solutions for any initial condition in $(0, 1)$ will converge to $0$.
] <logistic-map>
