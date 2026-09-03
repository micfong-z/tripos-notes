#import "../prelude.typ": *

= Higher Order Discrete Equations

Consider a linear, discrete, 2nd order equation with constant coefficients of the form
$
  a y_(n+2) + b y_(n+1) + c y_n = f_n
$
where $a$, $b$, $c$ are constants.

#example[
  This may arise when #ponder("calculus.finite-difference")[discretising] a #ponder("ode.order")[2nd order] #ponder("ode.ordinary-differential-equation")[ODE]:
  $
    eval((dif^(2) y)/(dif x^(2)))_(x_n) & approx (y(x_n + h) - 2 y(x_n) + y(x_n - h))/(h^(2))
  $
  which we can correspond to
  $ eval((dif^(2) y)/(dif x^(2)))_(x_n) & approx (y_(n+1) - 2 y_n + y_(n-1))/(h^(2)). $
] <ex-finite-difference>

We can solve this using similar methods to solving #ponder("ode.order")[2nd order] #ponder("ode.ordinary-differential-equation")[ODEs], with general solution
$
  y = y_n^((c)) + y_n^((p))
$
where $y_n^((c))$ is the #ponder("ode.particular-integral")[complementary function], and $y_n^((p))$ is a #ponder("ode.particular-integral")[particular integral].

== #ponder("ode.particular-integral")[Complementary Functions]

The #ponder("ode.particular-integral")[complementary function] must satisfy
$ a y_(n+2) + b y_(n+1) + c y_n = 0. $

We can try $y_n^((c)) prop k^n$, since $k^n$ is an #ponder("ode.eigenfunction")[eigenfunction]. This gives the characteristic equation
$ a k^(2) + b k + c = 0. $

The general #ponder("ode.particular-integral")[complementary function] is
$
  y_n^((c)) = cases(
    A k_1^n + B k_2^n quad & "if" k_1 != k_2,
    (A + B n) k_1^n quad & "if" k_1 = k_2,
  )
$
where $k_1$, $k_2$ are the roots of the characteristic equation, and $A$, $B$ are arbitrary constants.

== #ponder("ode.particular-integral")[Particular integrals]

We can find #ponder("ode.particular-integral")[particular integrals] based on the form of $f_n$:

#table(
  columns: (1fr, 1fr),
  [*$f_n$*], [*$y_n^((p))$*],
  $k^n$, $A k^n quad ("if" k != k_1 "or" k_2)$,
  $k_1^n$, $A n k_1^n$,
  $n^p quad (p in ZZ_(>=0))$, $A n^p + B n^(p-1) + ... + C_n + D$,
)

#example[Fibbonacci Sequence][
  Consider the sequence with conditions
  $
    y_(n) = y_(n-1) + y_(n-2), quad
    y_0 = 1, quad
    y_1 = 1.
  $
  #fade[[The sequence starts with $1, 1, 2, 3, 5, 8, 13, ...$]]

  We can rewrite this as
  $ y_(n+2) - y_(n+1) - y_n = 0. $
  The characteristic equation is
  $ k^(2) - k - 1 = 0, $
  with roots
  $ k_1 = (1 + sqrt(5))/2, quad k_2 = (1 - sqrt(5))/2. $
  Note that the roots are golden ratios:
  $ phi_1 = (1 + sqrt(5))/2, quad phi_2 = (1 - sqrt(5))/2 = -(1)/(phi_1). $
  Thus the #ponder("ode.particular-integral")[complementary function] is
  $ y_n^((c)) = A phi_1^n + B phi_2^n. $
  To find $A$ and $B$, we use the initial conditions:
  $ y_0 = A + B = 1, $
  $ y_1 = A phi_1 + B phi_2 = 1. $
  Solving this system gives
  $ A = phi_1/(sqrt(5)), quad B = -phi_2/(sqrt(5)). $
  Therefore the closed form solution is
  $
    y_n & = (phi_1^(n+1) - phi_2^(n+1))/(sqrt(5)) \
        & = (phi_1^(n+1) - (-(1)/(phi_1))^(n+1))/(sqrt(5) ).
  $
  Interestingly, an integer sequence can be expressed in terms of irrational numbers.


  Since $phi_1 > 1$, $y_n ->(phi_1)^(n+1)/(sqrt(5) )$ as $n -> oo$.
  Therefore,
  $
    lim_(n->oo) (y_(n+1))/(y_n) = phi_1 = (1 + sqrt(5))/2.
  $

] <ex-fibonacci-sequence>


