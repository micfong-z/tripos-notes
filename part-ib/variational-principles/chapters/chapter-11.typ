#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

#lecture-separator(lecture: 11, date: "2026-05-25")

= The Second Variation <sec-second-variation>

For a function $f$,
$
  f(vb(x) + epsilon vb(xi)) &= epsilon vb(xi) dot grad f(vb(x)) + (epsilon^2)/(2) xi_i xi_j (hess f(vb(x)))_(i j) + Order(epsilon^3). \
$

So a stationary point $vb(x) = vb(a)$ is a local minimum if $hess f(vb(a))$ is positive definite, _i.e._ $xi_i xi_j (hess f(vb(a)))_(i j) > 0$ for all $vb(xi) != vb(0)$. Equivalently, all eigenvalues of $hess f(vb(a))$ are positive.

Now, for a functional of usual form
$
  F[y] = integral_(alpha)^(beta) f(y, y', x) dif x,
$
with $y in cal(C) = Set(y\: [alpha, beta] -> bb(R), y in C^2\, y(alpha) = a\, y(beta) = b)$.

Consider $y + epsilon xi in cal(C)$. This implies
#set math.equation(numbering: "(1)")
$
  xi(alpha) = xi(beta) = 0.
$ <eq-11-1>
#set math.equation(numbering: none)

For small $epsilon$, taylor expansion gives
$
  f(y + epsilon xi, y' + epsilon xi', x) &= f(y, y', x) + epsilon xi (pdv(f, y) - dv(, x) pdv(f, y')) + epsilon dv(, x) (xi pdv(f, y')) + (1)/(2) epsilon^2 (xi^2 pdv(f, y, 2) + 2 xi xi' pdv(f, y, y') + (xi')^2 pdv(f, y', 2)) + Order(epsilon^3) \
$
Hence, plugging this into $F[y + epsilon xi]$ gives #fade[[boundary terms vanish by @eq-11-1]]
$
  F[y + epsilon xi] - F[y] = epsilon integral_(alpha)^(beta) xi(x) pdv(F[y], y(x), d: delta) dif x + epsilon delta^2 F[y, xi] + Order(epsilon^3)
$
where
#set math.equation(numbering: "(1)")
$
  delta^2 F[y, xi] &:= (1)/(2) integral_(alpha)^(beta) (xi^2 pdv(f, y, 2) + underbracket(2 xi xi', = (xi^2)') pdv(f, y, y') + (xi')^2 pdv(f, y', 2)) dif x\
  &= (1)/(2) integral_(alpha)^(beta) (xi^2 (pdv(f, y, 2) - dv(, x) pdv(f, y, y')) + (xi')^2 pdv(f, y', 2)) dif x quad "integration by parts"
$ <eq-11-2>
#set math.equation(numbering: none)

Recall that if $hess f(vb(x))$ is positive definite for all $vb(x)$, then $f(vb(x))$ is convex, so any stationary point is guaranteed to be a local minimum. We have a similar result for functionals.

#proposition[
  If $delta^2 F[y, xi] > 0$ for all $y in cal(C)$ and all _allowed_ $xi$, then $y = y_0$ is a global minimum of $F$ in $cal(C)$ if $y_0 in cal(C)$ satisfies the Euler-Lagrange equation.

  #fade[[$xi(x)$ is _allowed_ if $xi$ is $C^2$ and obeys the boundary conditions in @eq-11-1. Note that $cal(C)$ is indeed convex (as required by the definition of convexity), since if $y_1, y_2 in cal(C)$, then $y = t y_1 + (1 - t) y_2 in cal(C)$ for all $t in [0, 1]$.]]
]

#example[Geodesics in Euclidean Plane][
  Consider the functional
  $
    F[y] = integral_(alpha)^(beta) sqrt(1+ (y')^2) dif x.
  $
  By @eq-11-2, we have
  $
    pdv(f, y, 2) = pdv(f, y, y') = 0, quad pdv(f, y', 2) = (1+ (y')^2)^(-(3)/(2)).
  $
  Therefore,
  $
    delta^2 F[y, xi] = (1)/(2) integral_(alpha)^(beta) (xi')^2 (1+ (y')^2)^(-(3)/(2)) dif x >= 0 quad forall y, xi.
  $
  Hence, the solution of the Euler-Lagrange equation of this functional is indeed a global minimum (a straight line) of the distance between two points.
]

#proposition[
  If $y_0 in cal(C)$ satisfies the Euler-Lagrange equation, then $y_0$ is a local minimum of $F$ if $delta^2 F[y, xi] > 0$ for all non-trivial allowed $xi(x)$.

  Conversely, we can say that $y_0$ is not a local minimum if there exists some allowed $xi(x)$ such that $delta^2 F[y, xi] < 0$. #fade[[This is analogous to the case of functions, where a stationary point is not a local minimum if there exists a negative eigenvalue of the Hessian.]]
]

#example[Geodesics on a Sphere][
  A geodesic between points $A$, $B$ on a sphere is a segment of a great circle through the two points.

  #align(center)[
    #dynamic-svg2("/part-ib/variational-principles/media/d1e5.svg", width: 9em)
  ]


  There are two such segments, and the shorter one has indeed $delta^2 F > 0, forall xi != 0$. Hence this segment is a local minimum #fade[[This is actually global.]]

  However, the longer has $delta^2 F < 0$ for some $xi$. Hence this is not a local minimum.

  If $A$ and $B$ are antipodal points, then $delta^2 F >= 0$ for all $xi$.
]

#proposition[Legendre Condition][
  If $y in cal(C)$ satisfies the Euler-Lagrange equation, then a necessary condition for it to be a local minimum is that
  #set math.equation(numbering: "(1)")
  $
    eval(pdv(f, y', 2))_(y = y_0)>= 0 quad forall x in [alpha, beta].
  $ <eq-11-3>
  #set math.equation(numbering: none)
] <prop-legendre-condition>
#prooflike[Sketch proof][
  Assume $eval(pdv(f, y', 2))_(y=y_0) < 0$ at $x = x_0 in [alpha, beta]$. Then we can choose $xi$ such that $xi != 0$ only near $x_0$ and $xi'$ large with $xi$ small to make @eq-11-2 negative. Hence $y_0$ is not a local minimum.
]

#example[
  Consider
  $
    F[y] = integral_(-1)^(1) x sqrt(1 + (y')^2) dif x.
  $
  Then
  $
    pdv(f, y', 2) = x(1 + (y')^2)^(-(3)/(2)).
  $
  This violates @eq-11-3 for $x < 0$. Therefore, any solution of the Euler-Lagrange equation is not a local minimum for violating @prop-legendre-condition.
]

#notation[
  Let $y_0 in cal(C)$ satisfy the Euler-Lagrange equation. Then we write
  #set math.equation(numbering: "(1)")
  $
    delta^2 F[y_0, xi] := (1)/(2) integral_(alpha)^(beta) (rho(x) (xi')^2 + sigma(x) xi^2) dif x
  $ <eq-11-4>
  #set math.equation(numbering: none)
  where
  $
    rho := eval(pdv(f, y', 2))_(y=y_0), quad sigma := eval((pdv(f, y, 2) - dv(, x) pdv(f, y, y')))_(y=y_0).
  $
]

#remark[
  @prop-legendre-condition shows that $rho >= 0$ is necessary for $y_0$ to be a local minimum.
]
#proposition[
  A sufficient condition for $y_0$ to be a local minimum is that $rho > 0$ and $sigma >= 0$ for all $x in [alpha, beta]$.
]
#proof[
  Clearly $delta^2 F >= 0$ for all $xi$. Now we need to show that $delta^2 F[y_0, xi] = 0$ only if $xi = 0$.

  If $delta^2 F[y_0, xi] = 0$, then we must have $xi' = 0$ on $(alpha, beta)$ and hence $xi = 0$ on $[alpha, beta]$.

  Hence $delta^2 F > 0$ if $xi equiv.not 0$. Hence $y_0$ is a local minimum.
]

#example[Brachistochrone Problem][
  Consider the time functional
  $
    T = integral_0^(x_b) f dif x, quad "where" f = sqrt((1 + (y')^2)/(- y)).
  $

  #fade[[Adding condition $y < 0$ to the definition of $cal(C)$ here.]]

  Assume that $y$ satisfies the Euler-Lagrange equation. #fade[[It is a cycloid.]] Then
  $
    pdv(f, y') = y'/sqrt(-y(1+(y')^2)), quad pdv(f, y) = (f)/(-2 y).
  $
  Hence
  $
    rho = pdv(f, y', 2) = (1)/(sqrt((-y)(1+(y')^2)^3)) > 0.
  $
  Now, for $sigma$, #fade[[we can rearrange our expression to take advantage that the Euler-Lagrange equation is satisfied with our solution]]
  $
    pdv(f, y, y') = (1)/(-2 y) pdv(f, y'), quad pdv(f, y, 2) = (3f)/(4y^2).
  $
  Then
  $
    sigma & = pdv(f, y^2) - dv(, x) ((1)/(-2y) pdv(f, y')) \
          & = pdv(f, y, 2)- y'/(2y^2) pdv(f, y') + (1)/(2y) + underbracket((1)/(2y) pdv(f, y), "By E-L eqn.") \
          & = (3f)/(4y^2) - (y')^2/(2y^2 sqrt((-y)(1+(y')^2))) - (f)/(4y^2) \
          & =(1)/(2 sqrt((-y)(1+(y')^2))) >0.
  $
  Therefore, the cycloid is indeed a local minimum of the time functional $T$.
]

In general, integrating by parts in @eq-11-4 gives #fade[[_c.f._ @sec-sturm-liouville]],

#set math.equation(numbering: "(1)")
$
  delta^2F[y_0, xi] & = (1)/(2)integral_(alpha)^(beta) xi(x) cal(L) xi(x) dif x + (1)/(2) underbracket([rho xi xi']_(alpha)^(beta), = 0 "by" xi(alpha) = xi(beta) = 0) \
$ <eq-11-5>
#set math.equation(numbering: none)

where $cal(L) xi := - dv(, x)(rho dv(, x)) + sigma xi$ is a linear differential operator.

#proposition[
  Consider the Sturm-Liouville problem

  #set math.equation(numbering: "(1)")
  $
    cal(L) eta = lambda w(x) eta.
  $ <eq-11-6>
  #set math.equation(numbering: none)

  where $eta(alpha) = eta(beta) = 0$ and $w(x) > 0$ on $(alpha, beta)$.

  If this problem admits a negative eigenvalue $lambda$, then $y_0$ is not a local minimum of $F$.
]

#lecture-separator(lecture: 12, date: "2026-05-27")

#proof[
  Let $eta$ be an eigenfunction. Set $xi = eta$ in @eq-11-5. Then
  $
    delta^2 F[y_0, eta] = (1)/(2) integral_(alpha)^(beta) eta cal(L) eta dif x = (lambda)/(2)integral_(alpha)^(beta) w(x) eta^2 dif x < 0.
  $
  Hence $y_0$ is not a local minimum of $F$.
]

We may wonder if we can say something about the converse.

#proposition[
  If all the eigenvalues of the Sturm-Liouville problem in @eq-11-6 are positive, then $y_0$ is a local minimum of $F$.
]
#proof[
  #fade[[Non-examinable.]] Let $lambda_n$ be the $n$-th eigenvalue, and $y_n$ the $n$-th eigenfunction of @eq-11-6.

  By IB Methods, the set of eigenfunctions $Set(y_n)$ for a complete set for the space of allowed $eta$. Thus, for any allowed $eta$,
  $
    eta(x) = sum_(i=1)^n a_i y_i (x) quad "for some" {a_i}.
  $
  We can also choose ${y_n}$ to be orthogonal:
  $
    integral_(alpha)^(beta) w y_m y_n dif x = 0 quad "for" m != n.
  $
  Hence,
  $
    delta^2F[y_0, eta] &= sum_(m, n) a_m a_n lambda_n integral_(alpha)^(beta) w y_m y_n dif x\
    &= (1)/(2) sum_m underbracket(lambda_m, >0) underbracket(a_m^2, >=0) underbracket(integral_(alpha)^(beta) w y_m^2 dif x, >0) >=0.
  $

  Note that $delta^2 F[y_0, eta] = 0$ iff $a_m = 0$ for all $m$, which implies $eta equiv 0$. Hence $y_0$ is a local minimum of $F$.
]

#example[
  Consider
  $
    F[y] = (1)/(2)integral_0^a ((y')^2 -y^2) dif x, quad y(0) =y_0, y(a) = y_1.
  $
  The Euler-Lagrange equation gives
  $
    -y-dv(, x)(y') = 0 <=> y'' + y =0.
  $
  Expand around a solution $y_0$ of the above equation, we get
  $
    delta^2 F = (1)/(2) integral_0^a ((xi')^2 - xi^2) dif x.
  $
  In this case, $rho = 1$ and $sigma = -1$. Hence the Sturm-Liouville problem is
  $
    - dv(eta, x, 2) - eta = lambda w eta, quad eta(0) = eta(a) = 0.
  $
  Choose $w equiv 1$. Then
  $
    eta'' + (lambda + 1) eta = 0.
  $
  Hence,
  $
    eta = A sin (sqrt(lambda + 1) x) + B cos(sqrt(lambda + 1) x).
  $
  With the boundary conditions, we have $B = 0$ and $A sin (sqrt(lambda + 1) a) = 0$. For a non-trivial solution, we need
  $
    sqrt(lambda + 1) a = n ppi, quad n in bb(Z).
  $
  Hence,
  $
    eta = A sin ((n ppi x) / a).
  $
  Note WLOG we can take $n in ZZ_+$ #fade[[since $n=0$ is trivial, and for $n<0$ we can just flip the sign of $A$]]. Then the eigenvalues are
  $
    lambda = (n^2 ppi^2)/(a^2) - 1 := lambda_n, quad n in ZZ_+.
  $
  Notice that $lambda_n >0$ for all $n$ iff $a < ppi$.

  Therefore, if $a < ppi$, then $y_0$ is a local minimum of $F$. If $a > ppi$, then $y_0$ is not a local minimum of $F$.
] <ex-sl-example>
