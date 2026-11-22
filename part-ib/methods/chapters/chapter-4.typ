#import "../prelude.typ": *
#show: chapter.with(4)

#lecture-separator(lecture: 12, date: "2026-11-04")

= Inhomogeneous Problems and Green's Functions

== The Dirac Delta Function <sec-dirac-delta-function>

In IA Differential Equations, we have seen $delta(x)$ defined by
$
                                     delta (x) & = 0 quad forall x != 0, \
  integral_(-epsilon)^(epsilon) delta(x) dif x & = 1 quad forall epsilon > 0
$
from which we get things like
$
  integral_(-oo)^(oo) delta(x-a) f(x) dif x = f(a).
$
However, no such function mathematically exists. To discuss such functions, we need to introduce the sequence ${delta_n}_(n=1)^oo$ defined by
$
  delta_n (x) = cases(
    (n)/(alpha) exp(-(1)/(1-(n x)^2)) quad & forall abs(x) < 1/n,
    0 quad & forall abs(x) >= 1/n
  )
$

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p13.svg", width: 33.8em)
]

Properties of $delta_n$ include

+ $x |-> delta_n (x)$ is smooth for $n in ZZ^+$.

+ $delta_n (x) = 0$ outside $(-1/n, 1/n)$.

+ $forall epsilon > 0, exists N: forall n > N, integral_(-epsilon)^(epsilon) delta_n (x) dif x = 1$ as long as we define $alpha = integral_(-1)^(1) exp(-(1)/(1-y^2)) dif y$.

The first two properties are easy to check. For (3), given $epsilon > 0$, take $N > (1)/(epsilon)$. Then for $n > N$,
$
  integral_(-epsilon)^(epsilon) delta_n (x) dif x & = integral_(-(1)/(n))^((1)/(n)) (n)/(alpha) exp(-(1)/(1-(n x)^2)) dif x \
  &= integral_(-1)^(1) (1)/(alpha) exp(-(1)/(1-y^2)) dif y #eq-note[with $y = n x$]\
  &= 1. #eq-note[by definition of $alpha$] \
$

Hence
$
  lim_(n->oo) delta_n (x) = 0 quad "for" x !=0
$
and
$
  lim_(n->oo) integral_(-epsilon)^(epsilon) delta_n (x) dif x = 1.
$

It seems tempting to write
$
  delta(x) stretch(=)^? lim_(n->oo) delta_n (x).
$ <eq-delta-as-limit>

In @eq-delta-as-limit, note that we will get
$
  lim_(n->oo) delta_n (0) = lim_(n->oo) (n)/(alpha ee) = oo.
$
Hence the limit does not exist in a pointwise sense, but it does exist in a weaker sense. Note that delta functions rarely exist in isolation _e.g._ inside integrals
$
  integral_(-oo)^(oo) delta(x - a) f(x) dif x
$
or as a forcing term in an ODE
$
  dot.double(y) + omega^2 y = delta(t).
$

We shall interpret these as _sequences of statements_ of which we will eventually take the limit, _i.e._

$
  integral_(-oo)^(oo) delta(x-a) f(x) dif x = lim_(n->oo) integral_(-oo)^(oo) delta_n (x-a) f(x) dif x
$
and
$
  dot.double(y)_n + omega^2 y_n = delta_n (t)
$
so that
$
  y(t) = lim_(n->oo) y_n (t).
$

We can now even deal with $delta'(x)$, such as
$
  integral_(-oo)^(oo) delta'(x) f(x) dif x & = lim_(n->oo) integral_(-oo)^(oo) delta'_n (x) f(x) dif x \
                                           & = lim_(n->oo) (-integral_(-oo)^(oo) delta_n (x) f'(x) dif x) \
                                           & = -f'(0). \
$
Therefore,
$
  integral_(-oo)^(oo) delta'(x) f(x) dif x = -f'(0).
$

It is cumbersome to write limits everywhere, so we usually just treat $delta(x)$ as an ordinary function.

=== Fourier Series and $delta(x)$

Let $delta^L (x)$ denote $L$-periodic delta function such that
$
  delta^L (x) = delta(x), quad x in [-L/2, L/2).
$
It has Fourier coefficients
$
  (1)/(L) integral_(-(L)/(2))^(L/2) delta(x) exp(-(2 ppi ii n x) / L) dif x = (1)/(L) exp(0) = (1)/(L).
$
So
$
  delta^L (x) ~sum_(n) (1)/(L) ee^((2 ppi ii n x) / L).
$
Hence we expect, since $delta(x) = delta^L (x)$ on $[-(L)/(2), (L)/(2))$, that
$
  f(0) = integral_(-(L)/(2))^(L/2) delta^L (x) f(x) dif x.
$

Computing,
$
  "RHS" & = integral_(-(L)/(2))^(L/2) delta^L (x) f(x) dif x \
        & = integral_(-(L)/(2))^(L/2) sum_(n) (1)/(L) ee^((2 ppi ii n x) / L) f(x) dif x \
        & = sum_(n) (1)/(L) integral_(-(L)/(2))^(L/2) ee^((2 ppi ii n x) / L) f(x) dif x \
        & = sum_(n) hat(f)_(-n) \
        & = sum_n hat(f)_n. \
$
If $f$ is nice, $f(x) = sum_n hat(f)_n ee^((2 ppi ii n x) / L)$ when $x in (-(L)/(2), (L)/(2))$. Therefore we get
$
  "RHS" = sum_n hat(f)_n = f(0) = "LHS".
$


=== Eigenfunction expansions and $delta(x)$ <sec-eigenfunction-expansions-and-delta-function>

Consider the Sturm-Liouville problem $L y = lambda y$ on vector space
$
  V = Set(y in C^2[a, b]; y "satisfies real, homogeneous b.c. at each non-singular endpoint").
$
Let ${Y_k}_(k=1)^oo$ be the normalised eigenfunctions of $L$. Fix $xi in (a, b)$, consider $x |-> delta_n (x - xi)$.
#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p14.svg", width: 23.7em)
]

Then for $n$ sufficiently large, the function $x|->delta_n (x-xi)$ belongs to $V$. Hence we have an eigenfunction expansion
$
  delta_n (x - xi) & = sum_(k=1)^oo iprod(delta_n (dot - xi), Y_k)_w Y_k (x) \
                   & = sum_(k=1)^oo [integral_(a)^(b) delta_n (t-xi) Y_k (t) w(t) dif t] Y_k (x) \
$
Taking $n -> oo$, we expect
$
  delta(x - xi) = sum_(k=1)^oo w(xi) Y_k (xi) Y_k (x).
$

For $f in V$, we expect
$
  integral_(a)^(b) delta(x- xi) f(xi) dif xi = f(x)
$
Compute
$
  "LHS" & = integral_(a)^(b) delta(x- xi) f(xi) dif xi \
        & = integral_(a)^(b)[ sum_(k=1)^oo w(xi) Y_k (xi) Y_k (x)] f(xi) dif xi \
        & = sum_(k=1)^oo [integral_(a)^(b) w(xi) Y_k (xi) f(xi) dif xi]Y_k (x) \
        & = sum_(k=1)^oo iprod(f, Y_k)_w Y_k (x) \
        & = f(x). \
$

#lecture-separator(lecture: 13, date: "2026-11-06")

== Green's Functions

We want to solve
$
  cases(
    L y = f quad & a < x < b,
    y(a) = 0,
    y(b) = 0
  )
$ <eq-target-greens-function>

_i.e._ solve $L y = f$, where $y in V = Set(y in C^2 [a, b]; y(a) = y(b) = 0)$, where
$
  L = alpha(x) dv(, x, 2) + beta(x) dv(, x) + gamma(x)
$
with $alpha, beta, gamma$ smooth and $alpha(x) !=0$ on $(a, b)$. Fix $xi in (a, b)$. Suppose we can find a  function $x |-> G(x, xi)$ such that
$
  cases(
    L_x G(x, xi) = delta(x - xi) quad & a < x < b,
    G(a, xi) = 0,
    G(b, xi) = 0.
  )
$
Given such a $G$, consider
$
  y(x) = integral_(a)^(b) G(x, xi) f(xi) dif xi.
$
Then $y(a) = y(b) = 0$, and
$
  L_x y = integral_(a)^(b) L_x G(x, xi) f(xi) dif xi = integral_(a)^(b) delta(x - xi) f(xi) dif xi = f(x).
$
_i.e._ $y$ is a solution to @eq-target-greens-function. We call $G(x, xi)$ the Dirichlet Green's function for $L$.

We wonder what properties $G$ should have.

When $x != xi$, $x in (a, b)$ we have #fade[[consider $xi$ as a fixed parameter]]
$
  alpha(x) dv(G, x, 2) + beta(x) dv(G, x) + gamma(x) G = 0.
$ <eq-target-greens-function-away-from-xi>

This is a nice second-order ODE, so we expect $x |-> G(x, xi)$ to be nice away from $x = xi$.

Now, for $x$ near $x= xi$, we need to get $delta(x - xi)$ on the RHS. Clearly the second-order derivative is least regular, so we expect
$
  alpha(x) dv(, x) [dv(G(x, xi), x)] = delta(x - xi) + "more regular terms".
$
Hence we want to find $dv(G(x, xi), x)$ such that
$
  dv(, x) dv(G(x, xi), x) ~ delta(x - xi).
$

Recall that the rigorous treatment of $delta(x)$ involves a sequence ${delta_n (x)}_(n=1)^oo$ such that
$
                                      lim_(n->oo) delta_n (x) & = 0 quad "for" x !=0, \
  lim_(n->oo) integral_(-epsilon)^(epsilon) delta_n (x) dif x & = 1 quad forall epsilon > 0.
$
Hence it makes sense to look for a function $H_n (x)$ such that
$
  dv(H_n (x), x) = delta_n (x).
$
Clearly
$
  H_n (x) = integral_(-oo)^(x)delta_n (t) dif t
$
looks like a good candidate.

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p15.svg", width: 28.8em)
]

Fix $x > 0$, then for $n$ sufficiently large we get $H_n (x) = 1$. Fix $x < 0$, then for $n$ sufficiently large we get $H_n (x) = 0$, _i.e._
$
  lim_(n->oo) H_n (x) = H(x) = cases(
    1 quad & forall x > 0,
    0 quad & forall x < 0
  )
$

_i.e._ $H'(x) = delta (x)$, and so $dv(H(x - xi), x) = delta(x - xi)$. So we want $dv(G(x, xi), x)$ to resemble $H(x - xi)$ near $x = xi$.

#align(center)[
  #dynamic-svg2("/part-ib/methods/media/p16.svg", width: 23.7em)
]

So we expect $dv(G(x, xi), x)$ to have a jump discontinuity at $x = xi$. Using
$
  G(x, xi) = integral_(a)^(x) dv(G(t, xi), t) dif t,
$
and
$
  underbracket(integral_(a)^(x) H(t - xi) dif t, "continuous at"\ x = xi) = cases(
    x - xi quad & forall x > xi,
    0 quad & forall x < xi
  )
$
_i.e._ we expect $x |-> G(x, xi)$ to be continuous at $x = xi$. It remains to find the exact amount of the jump.

Divide $L_x [G(x, xi)] = delta(x - xi)$ by $alpha(x) != 0$, and integrate $x$ over $(xi - epsilon, xi + epsilon)$, we get
$
  eval(dv(G, x))^(x = xi + epsilon)_(x = xi - epsilon) + integral_(xi - epsilon)^(xi + epsilon) [(beta(x))/(alpha(x)) dv(G, x) + (gamma(x))/(alpha(x)) G ]dif x = integral_(xi - epsilon)^(xi + epsilon) (delta(x - xi))/(alpha(x)) dif x = (1)/(alpha(xi)).
$
Taking $epsilon -> 0^+$, note that the second term on the LHS goes to $0$ since $x |-> G(x, xi)$ is continuous at $x = xi$, we get
$
  eval(dv(G, x))^(x = xi^+)_(x = xi^-) = (1)/(alpha(xi)).
$
In summary, if $L_x (G(x, xi)) = delta(x - xi)$, then $G$ will have the following properties:

+ $x |-> G(x, xi)$ to be continuous at $x = xi$,

+ $x |-> dv(G, x)$ to have a jump discontinuity at $x = xi$, with
  $
    dv(G, x) (xi^+, xi) - dv(G, x) (xi^-, xi) = (1)/(alpha(xi)).
  $

#example[
  Take $L = dv(, x, 2) + omega^2$, with $(a, b) = (0, 1)$ where $omega in RR$ is constant with $sin omega != 0$.

  Fix $xi in (a, b)$. We have $L [ G(x, xi)] = 0$ in $0 < x < xi$ and $xi < x < 1$. So
  $
    G(x, xi) = cases(
      A(xi) sin (omega x) + B (xi) cos (omega x) quad & forall 0 < x < xi,
      C(xi) sin (omega (x-1)) + D (xi) cos (omega (x-1)) quad & forall xi < x < 1.
    )
  $
  #fade[[We used $x-1$ to make matching boundary conditions easier.]] We need $G(0, xi) = G(1, xi) = 0$, so
  $
    B(xi) = 0 = D(xi).
  $
  And we have
  $
    G(x, xi) = cases(
      A (xi) sin (omega x) quad & forall 0 < x < xi,
      C (xi) sin (omega (x-1)) quad & forall xi < x < 1.
    )
  $
  By continuity of $G$ at $x = xi$, we have
  $
    A(xi) = C(xi) (sin (omega (xi - 1)))/(sin (omega xi) ).
  $
  The jump discontinuity of $dv(G, x)$ at $x = xi$ gives
  $
    (omega C(xi))/(sin (omega xi))underbracket([cos (omega (xi - 1)) sin(omega xi) - cos (omega xi) sin(omega (xi - 1))], sin(omega xi - omega(xi - 1)) = sin omega) = 1.
  $
  So
  $
    C(xi) = (sin (omega xi))/(omega sin omega) , quad A(xi) = (sin (omega (xi - 1)))/(omega sin omega)
  $
  and hence
  $
    G(x, xi) = (1)/(omega sin omega) cases(
      sin (omega (xi - 1)) sin (omega x) quad & forall 0 < x < xi,
      sin (omega xi) sin (omega (x-1)) quad & forall xi < x < 1.
    )
  $

  Note that we have the form
  $
    G = "const" times cases(
      y_1 (x) y_2(xi) quad & forall 0 < x < xi,
      y_1(xi) y_2 (x) quad & forall xi < x < 1
    ),
  $
  and $L y_1 = L y_2 = 0$, $y_1(0) = 0, y_2 (1) = 0$. This will be further generalised in the next section.
] <ex-green-function-1>

#lecture-separator(lecture: 14, date: "2026-11-09")


== A General Result

We wanted to solve
$
  cases(
    L y = f quad & a < x < b,
    y(a) = 0,
    y(b) = 0
  )
$ <eq-target-greens-function-2>
where
$
  L = alpha(x) dv(, x, 2) + beta(x) dv(, x) + gamma(x)
$
and $alpha != 0$ on $(a, b)$.

#proposition[
  Let $y_1, y_2$ be such that $L y_1 = 0$, $L y_2 = 0$, $y_1(a) =0$, $y_2(b) = 0$ and $y_1, y_2$ are linearly independent. Consider
  $
    G(x, xi) = (1)/(alpha(xi) underbracket(W(y_1, y_2)(xi), "Wronskian")) cases(
      y_1 (x) y_2(xi) quad & forall a < x < xi,
      y_1(xi) y_2 (x) quad & forall xi < x < b.
    )
  $
  Then
  $
    L_x [G(x, xi)] & = delta(x - xi), \
          G(a, xi) & = 0 = G(b, xi).
  $
]

#proof[
  Certainly if $x != xi$, we have
  $
    L_x [G(x, xi)] & = 0, \
          G(a, xi) & = G(b, xi) = 0.
  $
  Moreover, $x |-> G(x, xi)$ is continuous at $x = xi$. Moreover,
  $
    eval(dv(G, x))_(x = xi^+) - eval(dv(G, x))_(x = xi^-) & = (y_1(xi) y'_2(xi) - y_2(xi) y'_1(xi))/(alpha(xi) W(y_1, y_2)(xi))\
    &= (1)/(alpha(xi)). \
  $
  Thus $G(x, xi)$ is the Dirichlet Green's function for $L$.
]

Hence, the solution to @eq-target-greens-function-2 is
$
  y(x) & = integral_(a)^(b) G(x, xi) f(xi) dif xi \
  & =underbracket(integral_(a)^(x) (y_2(x) y_1(xi))/(alpha(xi) W(y_1, y_2) (xi)) f(xi) dif xi, x > xi) + underbracket(integral_(x)^(b) (y_1(x) y_2(xi))/(alpha(xi) W(y_1, y_2)(xi)) f(xi) dif xi, x < xi).
$

#example[
  Take $L = dv(, x, 2) + omega^2$, where $omega in RR$ is a constant and $(a, b) = (0, 1)$. So $alpha = 1$. Take
  $
    y_1(x) & = sin(omega x) \
    y_2(x) & = sin(omega (x - 1)).
  $
  Then
  $
    W(y_1, y_2) (xi) = omega[sin(omega xi) cos(omega (xi - 1)) - cos(omega xi) sin(omega (xi - 1))] = omega sin omega.
  $
  Therefore
  $
    G(x, xi) = (1)/(omega sin omega) cases(
      sin(omega (xi - 1)) sin(omega x) quad & forall 0 < x < xi,
      sin(omega xi) sin(omega (x - 1)) quad & forall xi < x < 1
    )
  $

  and we recover the result in @ex-green-function-1.
]

== Dirichlet Green's Functions for Sturm-Liouville Operators

Take $L$ to be a Sturm-Liouville operator
$
  L = (1)/(w) (-dv(, x) (p dv(, x) + q))
$
under
$
  cases(
    L y = f quad & a < x < b,
    y(a) = 0,
    y(b) = 0.
  )
$
WLOG we can take $w = 1$ by absorbing it into $f$, _i.e._ $alpha = -p$, $beta = -p'$, $gamma= q$.

#proposition[
  With $L$ as defined above, if $L y_1 = 0$, $L y_2 = 0$, then
  $
    dv(, x) (p (x) W(y_1, y_2) (x)) = 0.
  $
  _i.e._ $p W = "constant"$.
]

#proof[
  For $y_1, y_2 in C^2[alpha, beta]$,
  $
    y_2 L y_1 - y_1 L y_2 & = -y_2 [(p y'_1)' - q y_1] + y_1 [(p y'_2)' - q y_2] \
                          & = y_1 (p y'_2)' - y_2 (p y'_1)' \
                          & = dv(, x) [p(x) (y_1 y'_2 - y'_1 y_2)] \
                          & = dv(, x) [p(x) W(y_1, y_2)(x)]. \
  $
  So if $L y_1 = L y_2$, then $dv(, x) (p(x) W(y_1, y_2)(x)) = 0$.
]

Hence the formula for $G(x, xi)$ becomes
$
  G(x, xi) = underbracket("constant", -(1)/(p (c) W(y_1, y_2)(c))\ "for any" c in (a, b)) dot cases(
    y_1(x) y_2(xi) quad & forall a < x < xi,
    y_1(xi) y_2 (x) quad & forall xi < x < b
  ) \
$

== Return to Eigenfunction Expansions

Let $L$ be a Sturm-Liouville operator with $w = 1$. Let ${Y_k}_(k=1)^oo$ be the normalised eigenfunctions with eigenvalues $lambda_k$ of $L$, _i.e._
$
  L Y_k = lambda_k Y_k, quad iprod(Y_k, Y_l) = delta_(k l).
$
Take $V = Set(y in C^2 [a, b]; y(a)=y(b) = 0)$. We know that for $f in V$, we can write
$
  f(x) = sum_(k=1)^oo hat(f)_k Y_k (x)
$
where
$
  hat(f)_k = iprod(f, Y_k) = integral_(a)^(b) f(x) Y_k (x) dif x.
$
Note that if $x |-> G(x, xi)$ denotes Dirichlet Green's function for $L$, then it has the correct B.C. for $V$, _i.e._ $G(a, xi) = G(b, xi) = 0$.

But $G(dot, xi) in.not C^2[a, b]$, so it is not in $V$. Consider  ${G_n (x, xi)}_(n=1)^oo$ defined by
$
  L_x [G_n (x, xi)] = cases(
    delta_n (x - xi) quad & a < x < b,
    G_n (a, xi) = 0,
    G_n (b, xi) = 0
  )
$
where ${delta_n}_(n=1)^oo$ is discussed in @sec-dirac-delta-function. Then for each $xi in (a, b)$, we have $G_n (dot, xi) in V$. We could now use the eigenfunction expansions for each $n$, then take the limit as $n -> oo$.

We will just pretend that $G(dot, xi) in V$, which gives us a lot easier notation.

#proposition[
  For $L$, $(Y_k, lambda_k)_(k=1)^oo$ as defined above, the Dirichlet Green's function for $L$ is
  $
    G(x, xi) = sum_(k=1)^oo (Y_k (xi) Y_k (x))/(lambda_k),
  $
  for $lambda_k != 0$.
]

#proof[
  By eigenfunction expansion, we have
  $
    G(x, xi) & = sum_(k=1)^oo hat(G)_k (xi) Y_k (x) \
  $
  where
  $
    hat(G)_k (xi) & = iprod(G(dot, xi), Y_k) \
                  & = (1)/(lambda_k) iprod(G(dot, xi), L Y_k) \
                  & = (1)/(lambda_k) iprod(L G(dot, xi), Y_k) #eq-note[by self-adjointness of $L$] \
                  & = (1)/(lambda_k) iprod(delta(dot, xi), Y_k) \
                  & = (1)/(lambda_k) integral_(0)^(b) delta(x - xi) Y_k (x) dif x \
                  & = (Y_k (xi))/(lambda_k) \
  $
  _i.e._
  $
    G(x, xi) = sum_(k=1)^oo (Y_k (xi) Y_k (x))/(lambda_k).
  $
]


#example[
  Take $L = -dv(, x, 2)$ and $(a, b) = (0, 1)$, Then
  $
    Y_k (x) = sqrt(2) sin(k ppi x), quad lambda_k = k^2 ppi^2.
  $
  So Dirichlet Green's function is
  $
    G(x, xi) = 2 sum_(k=1)^oo (sin(k ppi x)sin(k ppi xi) )/(k^2 ppi^2)
  $
]
Note that
$
  delta(x, xi) & = L_x [G(x, xi)] \
               & = sum_(k=1)^oo (L[Y_k (x)] Y_k (xi))/(lambda_k) & = sum_(k=1)^oo (lambda_k Y_k (x) Y_k (xi))/(lambda_k) \
               & = sum_(k=1)^oo Y_k (x) Y_k (xi) \
$
which is consistent with the result in @sec-eigenfunction-expansions-and-delta-function.

#lecture-separator(lecture: 15, date: "2026-11-11")

== Initial Value Problems

Consider the initial value problem
$
  cases(
    L y = f & quad t > 0,
    y(0) = 0,
    dot(y)(0) = 0
  )
$ <eq-target-initial-value-problem>
with
$
  L = alpha(t) dv(, t, 2) + beta(t) dv(, t) + gamma(t) quad "and" quad alpha(t) != 0.
$
Suppose that for each $tau > 0$ we can find a $G = G(t, tau)$ such that
$
   L_t [G(t,tau)] & = delta(t - tau) quad "for" t > 0, \
        G(0, tau) & = 0, \
  dot(G) (0, tau) & = 0.
$
Then consider the function $y(t) = integral_(0)^(oo) G(t,tau) f(tau) dif tau$. We have $y(0) = dot(y)(0) = 0$, and
$
  L_t [y(t)] = integral_(0)^(oo) L_t [G(t,tau)] f(tau) dif tau = integral_(0)^(oo) delta(t - tau) f(tau) dif tau = f(t).
$
So $G$ is the Green's function for the initial value problem. We know that $G$ will need to be continuous at $t = tau$ and $dot(G)(t,tau)$ will have a jump discontinuity of $1/(alpha(tau))$ at $t = tau$.

#proposition[
  The Green's function for @eq-target-initial-value-problem is determined by

  + $G(t, tau) = 0$ for $t < tau$,

  + $L_t [G(t, tau)] = 0$ for $t> tau$ with $G(tau^+, tau) = 0$ and $dot(G)(tau^+, tau) = 1/(alpha(tau))$.
]

#proof[
  (1) gives $L_t [G(t, tau)] = 0$ for $t < tau$. (2) gives $L_t [G(t, tau)] = delta(t - tau)$ for $t > tau$ because of the conditions of $G$ at $t = tau^+$ and $t > tau$.
]

Since $G(t, tau) = 0$ for $t < tau$ the solution to the initial value problem is of the form
$
  y(t) = integral_(0)^(t) G(t, tau) f(tau) dif tau
$
which is reassuring, since we expect the response $y = y(t)$ at time $t$ only depend on the forcing $f = f(tau)$ for $tau < t$, _i.e._ causality is preserved.

#example[
  Let $L = dv(, t, 2)$. Then $G(t, tau) = 0$ for $t < tau$, $L_t [G(t, tau)] = 0$ for $t > tau$ so
  $
    G(t, tau) = A(t-tau) + B quad forall t > tau.
  $
  Conditions at $t = tau^+$ give $B = 0$ and $A = 1$. Hence
  $
    y(t) = integral_(0)^(t) G(t, tau) f(tau) dif tau = integral_(0)^(t) (t - tau) f(tau) dif tau.
  $
  Note that this is consistent with Taylor's theorem, that
  $
    y(t) = y(0) + t dot(y)(0) + integral_(0)^(t) (t - tau) dot.double(y)(tau) dif tau.
  $



]
