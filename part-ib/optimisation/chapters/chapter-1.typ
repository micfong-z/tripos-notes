#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/mannot:0.4.0": markul

#lecture-separator(lecture: 1, date: "2026-05-01")

In this course, we try to solve problems of the form

$
  "minimise functions" markul(f(vb(x)), #<obj-fn>) "subject to contraints" markul(vb(h)(vb(x))=bold(b), #<func-constraint>) "and" markul(vb(x) in cal(X), #<region-constraint>),
  #annot(<obj-fn>, "objective function", pos: bottom + left, dy: 0.5em)
  #annot(<func-constraint>, "functional constraint", pos: bottom + left, dy: 0.5em, dx: -2em)
  #annot(<region-constraint>, "regional constraint", pos: bottom + left, dy: 0.5em)
$
where
$
  vb(h)(vb(x)) = vec(y_1, y_2, dots.v, y_m).
$

We can also have inequality constraints $vb(h)(vb(x)) <= bold(b)$ #fade[[which means $y_i <= b_i$ for all $i$]].

$vb(x)^*$ which solves the problem is called the *optimal solution*, and $f(vb(x)^*)$ is the *optimal value*.
$
  cal(X)(bold(b)) = {vb(x): vb(h)(vb(x)) = bold(b), vb(x) in cal(X)}
$
is called the *feasible set*.

We can always convert an inequality constraint to an equality constraint. Note that $vb(h)(vb(x)) <= bold(b)$ is the same as $vb(h)(vb(x)) + vb(s) = bold(b)$, subject to $s_i >= 0$. The extra variables $vb(s)$ are called *slack variables*.

= Convex Optimisation

== Convex Functions

#definition[Convex Sets][
  A set $S subset.eq RR^n$ is called *convex* if $forall vb(x), vb(y) in S$ and $forall lambda in [0, 1]$, the point $lambda vb(x) + (1 - lambda) vb(y)$ is also in $S$.
]

Intuitively, a set is convex if for any two points in the set, the line segment connecting them is also entirely contained within the set.

#definition[Convex Functions][
  A function $f: S -> RR$ is called a *convex function* if $S$ is convex and $forall vb(x), vb(y) in S$ and $forall lambda in [0, 1]$,
  $
    f(lambda vb(x) + (1-lambda vb(y))) <= lambda f(vb(x)) + (1 - lambda) f(vb(y)).
  $
]
#align(center)[
  #dynamic-svg2("/part-ib/optimisation/media/d1e4.svg", width: 24em)
]

#remark[
  If $-f$ if convex, then $f$ is said to be *concave*.
]

#example[
  The function $f(x) = x^2$ is convex, and the function $f(x) = log x$ is concave.
]

=== First-Order Conditions for Convexity

Intuitively, a function is convex iff the tangent line at any point is below the function everywhere.

#align(center)[
  #dynamic-svg2("/part-ib/optimisation/media/d1e5.svg", width: 16em)
]

#theorem[First-Order Condition for Convexity][
  A differentiable function $f: RR^n -> RR$ is convex iff for all $vb(x), vb(y) in RR^n$,
  $
    f(vb(y)) >= f(vb(x)) + (vb(y)-vb(x))^tp grad f(vb(x))
  $
] <thm-first-order-condition-for-convexity>

#remark[
  If at $vb(x)$, $grad f(vb(x)) = 0$, then $vb(x)$ is the minimiser of $f$.
]

#proof[

  #fade[[$=>$]] When $n = 1$, we have
  $
    f(x + t(y-x)) <= (1-t) f(x) + t f(y)
  $
  for all $t in [0, 1]$. This means that
  $
    f(y) >= (f(x + t(y-x)) - f(x))/(t) + f(x).
  $
  Taking the limit as $t -> 0^+$, we get
  $
    f(y) >= f(x) + (y-x)f'(x).
  $

  To resolve the general case, set $g(t) = f((1-t) vb(x) + t vb(y))$. $g$ is convex, and $g: [0, 1] -> RR$. Using the 1D case, we have
  $
        g(1) & >= g(0) + (1-0) g'(0) \
    f(vb(y)) & >= f(vb(x)) + (vb(y)-vb(x))^tp grad f(vb(x)).
  $

  #fade[[$arrow.double.l$]] Set $vb(x)_t = (1-t) vb(x) + t vb(y)$. First-order conditions imply
  $
    f(vb(x)) & >= f(vb(x)_t) + (vb(x) - vb(x)_t)^tp grad f(vb(x)_t) \
    f(vb(y)) & >= f(vb(x)_t) + (vb(y) - vb(x)_t)^tp grad f(vb(x)_t).
  $
  Multiplying the first inequality by $(1-t)$ and the second by $t$ and adding them gives
  $
    (1-t) f(vb(x)) + t f(vb(y)) & >= f(vb(x)_t) + ((1-t)(vb(x) - vb(x)_t) + t (vb(y) - vb(x)_t))^tp grad f(vb(x)_t) \
                                & = f(vb(x)_t).
  $
]

=== Second-Order Conditions for Convexity

#notation[
  In this course, we will denote the Hessian of a function $f$ at $vb(x)$ as
  $
    [hess f(vb(x))]_(i j) = pdv(f(vb(x)), x_i, x_j).
  $

]

The 1D Taylor expansion of $f$ at $y$ is

$
  f(y) = f(x) + (y-x)f'(x) + ((y-x)^2)/2 f''(z) + ...
$

In $n$ dimensions, we have
$
  f(vb(y)) = f(vb(x)) + (vb(y)-vb(x))^tp grad f(vb(x)) + ((vb(y)-vb(x))^tp hess f(vb(x)) (vb(y)-vb(x)))/2 + ...
$

#fade[[We can derive this by applying the 1D Taylor expansion to the function $g(t) = f((1-t) vb(x) + t vb(y))$.]]

#theorem[Second-Order Condition for Convexity][
  A twice-differentiable function $f: RR^n -> RR$ is convex iff $hess f(vb(x)) succ.eq 0$ for all $vb(x) in RR^n$.
]

#remark[
  We say a symmetric matrix $matbold(A)$ is positive semidefinite, _i.e._ $matbold(A) succ.eq 0$, if $vb(x)^tp matbold(A) vb(x) >= 0$ for all $vb(x)$. Equivalently, all eigenvalues of $matbold(A)$ are non-negative.
]

#proof[
  We will only prove one side. For any $vb(x)$ and $vb(y)$ we have, by intermediate value theorem, a point $vb(z)$ such that
  $
    f(vb(y)) &= f(vb(x)) + grad f(vb(x))^tp (vb(y)-vb(x)) + underbracket(((vb(y)-vb(x))^tp hess f(vb(z)) (vb(y)-vb(x)))/2, >=0 "since" hess f(vb(z)) succ.eq 0)\
    &>= f(vb(x)) + grad f(vb(x))^tp (vb(y)-vb(x)).
  $

  This means the first-order condition for convexity is satisfied, so $f$ is convex.

]

#lecture-separator(lecture: 2, date: "2026-05-04")

== Gradient Descent

Observe that
$
  f(vb(y)) approx f(vb(x)) + grad f(vb(x))^tp (vb(y)-vb(x)) .
$
If we have $vb(y) - vb(x) = -grad f(vb(x)) times epsilon$, where $epsilon > 0$ is a small step size, then this gives us an update rule
$
  f(vb(y)) approx f(vb(x)) - epsilon norm(grad f(vb(x)))^2.
$

Therefore, we have the *gradient descent* algorithm as follows:

#listing[Gradient Descent Algorithm][
  1. Start from some $vb(x_0)$, set $t=0$.

  2. Repeat:

    1. Find a descent direction $vb(v_t)$, such as $-grad f(vb(x)_t)$
    2. Choose a step size $eta_t > 0$.
    3. Update $vb(x)_(t+1) = vb(x)_t + eta_t vb(v_t)$.

  3. Stop when some stopping critera are satisfied.
]

#remark[
  If our step size is too large, we may never converge.

  #align(center)[
    #dynamic-svg2("/part-ib/optimisation/media/d1e6.svg", width: 14em)
  ]

  If our step size is too small, we may end up taking a very long time to converge.

  #align(center)[
    #dynamic-svg2("/part-ib/optimisation/media/d1e7.svg", width: 14em)
  ]

  There are some conditions under which we can guarantee convergence, which we will discuss in the next section.
]

=== Smoothness and Strong Convexity

#definition[$beta$-smoothness, $alpha$-strong convexity][
  A twice-differentiable function $f: RR^n -> RR$ is $beta$-smooth if $hess f(x) prec.eq beta matbold(I)$ for all $x in RR^n$. It is $alpha$-strongly convex if $hess f(x) succ.eq alpha matbold(I)$ for all $x in RR^n$, where $alpha, beta > 0$.

  #fade[[This is saying that the eigenvalues of $hess f(x)$ are bounded above by $beta$ and below by $alpha$.]]
]

#remark[
  $matbold(A) prec.eq matbold(B)$ iff $matbold(B) - matbold(A) succ.eq 0$, _i.e._ $matbold(B) - matbold(A)$ is positive semidefinite.
]

#theorem[
  If $f$ is $beta$-smooth, then
  $
    f(vb(y)) <= f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + (beta)/(2) norm(vb(y) - vb(x))^2.
  $

  If $f$ is $alpha$-strongly convex, then
  $
    f(vb(y)) >= f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + (alpha)/(2) norm(vb(y) - vb(x))^2.
  $
] <thm-beta-smoothness-strong-convexity>

Intuitively, this means that $f$ is upper-bounded and lower-bounded by a quadratic function, respectively.

#align(center)[
  #dynamic-svg2("/part-ib/optimisation/media/d1e8.svg", width: 34em)
]

#proof[
  Using Taylor series expansion,
  $
    f(vb(y)) = f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + (1)/(2) (vb(y) - vb(x))^tp hess f(vb(z)) (vb(y) - vb(x)),
  $
  where $vb(z)$ is some point on the line segment between $vb(x)$ and $vb(y)$. Observe that

  $
    (1)/(2) (vb(y) - vb(x))^tp alpha matbold(I) (vb(y) - vb(x)) <=
    (1)/(2) (vb(y) - vb(x))^tp hess f(vb(z)) (vb(y) - vb(x)) <=
    (1)/(2) (vb(y) - vb(x))^tp beta matbold(I) (vb(y) - vb(x))\
    (alpha)/(2) norm(vb(y) - vb(x))^2 <=
    (1)/(2) (vb(y) - vb(x))^tp hess f(vb(z)) (vb(y) - vb(x)) <=
    (beta)/(2) norm(vb(y) - vb(x))^2.
  $
  Hence the result follows.
]

#corollary[
  If $f$ is $beta$-smooth, then
  $
    f(vb(x) - (1)/(beta) grad f(vb(x))) <= f(vb(x)) - (1)/(2 beta) norm(grad f(vb(x)))^2.
  $
  #fade[[This means that there is a guaranteed decrease in the function value.]]
] <cor-beta-smoothness>


#proof[
  Substituting $vb(y) = vb(x) - (1)/(beta) grad f(vb(x))$ into the first inequality of @thm-beta-smoothness-strong-convexity gives the result.
]

#rule[
  This gives us a gradient descent update rule,
  $
    vb(x)_(t+1) = vb(x)_t - (1)/(beta) grad f(vb(x)_t).
  $

]

#corollary[
  Let $f(vb(x^*))$ be the minimum value of $f$, where $f$ is $alpha$-strongly convex . Then for any $vb(x)$, we have
  $
    f(vb(x^*)) >= f(vb(x)) - (1)/(2 alpha) norm(grad f(vb(x)))^2.
  $
  Or equivalently,
  $
    0 <= f(vb(x)) - f(vb(x^*)) <= (1)/(2 alpha) norm(grad f(vb(x)))^2.
  $
] <cor-strong-convexity>

#remark[
  If $norm(grad f(vb(x)))^2 <= 2 alpha epsilon$, then $vb(x)$ is optimal up to an additive error of $epsilon$. #fade[[This gives us a stopping criterion for gradient descent.]]
]

#proof[
  By @thm-beta-smoothness-strong-convexity,
  $
    min_vb(y) f(vb(y)) & >= min_vb(y) (f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + (alpha)/(2) norm(vb(y) - vb(x))^2) \
            f(vb(x^*)) & >= min_vb(y) (f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + (alpha)/(2) norm(vb(y) - vb(x))^2).
  $
  To find the minimum on the RHS, differentiating w.r.t. $vb(y)$ gives,
  $
    grad_y (f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + (alpha)/(2) norm(vb(y) - vb(x))^2) = grad f(vb(x)) + alpha (vb(y) - vb(x)).
  $
  Setting this to zero gives $vb(y) = vb(x) - (1)/(alpha) grad f(vb(x))$. Substituting this back gives the result.
]

=== Convergence of Gradient Descent

#theorem[
  Let $f$ be $alpha$-strongly convex and $beta$-smooth, and let $vb(x^*)$ be the optimal solution. Then gradient descent with step size $eta_t =(1)/(beta)$ satisfies

  $
    f(vb(x)_t) - f(vb(x^*)) <= (1 - (alpha)/(beta))^T (f(vb(x_0)) - f(vb(x^*))) <= ee^(-(alpha T)/(beta)) (f(vb(x_0)) - f(vb(x^*))).
  $
]

#remark[
  Taking $T >= (beta)/(alpha) log((f(vb(x_0)) - f(vb(x^*)))/(epsilon))$ gives us $f(vb(x)_t) - f(vb(x^*)) <= epsilon$, so the relationship between the number of iterations and the error is logarithmic, _i.e._ we need $O(log (1/epsilon))$ iterations to get an error of at most $epsilon$.
]

#proof[
  By @cor-beta-smoothness and @cor-strong-convexity, we have
  $
    f(vb(x)_(t+1)) - f(vb(x^*)) & <= f(vb(x)_t) - (1)/(2 beta) norm(grad f(vb(x)_t))^2 - f(vb(x^*)) \
                                & <= f(vb(x)_t) - f(vb(x^*)) - (alpha)/(beta) (f(vb(x)_t) - f(vb(x^*))) \
                                & = (1 - (alpha)/(beta)) (f(vb(x)_t) - f(vb(x^*))).
  $
  By telescoping, we have
  $
    f(vb(x)_t) - f(vb(x^*)) <= (1 - (alpha)/(beta))^T (f(vb(x_0)) - f(vb(x^*))).
  $

]

Nonetheless, this algorithm can be too conservative, as illustrated in the following example.

#example[
  Let $f(vb(x)) = (1)/(2) (x_1^2 + 100x_2^2)$. Then
  $
    hess f(vb(x)) = mat(1, 0; 0, 100) quad forall vb(x).
  $
  Then since
  $
    mat(1, 0; 0, 1) prec.eq mat(1, 0; 0, 100) prec.eq mat(100, 0; 0, 100),
  $
  we have $alpha = 1$ and $beta = 100$, so the convergence rate is $1 - (alpha)/(beta) = 0.99$, which is quite slow.
]

Hence, we may want to consider scaling the step size in different directions.

Moreover, we are effectively minimising the upper bound #fade[[quadratic given by $beta$-smoothness]] of $f$ given by our step size, which may not be a good approximation of $f$ itself.

Therefore, for the two reasons above, we may consider approximating $f$ directly using a quadratic function instead, which gives us the *Newton's method*.

#lecture-separator(lecture: 3, date: "2026-05-06")

== Newton's Method

The second-order Taylor expansion of $f$ at $vb(x)$ is
$
  f(vb(y)) approx f(vb(x)) + grad f(vb(x))^tp (vb(y) - vb(x)) + ((vb(y) - vb(x))^tp hess f(vb(x)) (vb(y) - vb(x)))/2.
$
Suppose that we change the update rule to
$
  vb(x)_(t+1) = argmin_vb(y) [f(vb(x)_t) + grad f(vb(x)_t)^tp (vb(y) - vb(x)_t) + ((vb(y) - vb(x)_t)^tp hess f(vb(x)_t) (vb(y) - vb(x)_t))/2].
$
Differentiating the expression inside the brackets w.r.t. $vb(y)$ gives
$
  grad f(vb(x)_t) + hess f(vb(x)_t) (vb(y) - vb(x)_t) & = vb(0) \
                                                vb(y) & = vb(x)_t - (hess f(vb(x)_t))^(-1) grad f(vb(x)_t).
$
#rule[
  The update rule for Newton's method is
  $ vb(x)_(t+1) = vb(x)_t - (hess f(vb(x)_t))^(-1) grad f(vb(x)_t). $
]

#remark[
  In 1D this is a root-finding method for $f'(x)$, since suppose $f'(x) = g(x)$, then we are setting
  $
    x_(t+1) = x_t - (g(x_t))/(g'(x_t)).
  $
  #align(center)[
    #dynamic-svg2("/part-ib/optimisation/media/d1e1.svg", width: 22em)
  ]
]

#definition[$ell^2$ Norm][
  For $vb(x) in RR^n$, $norm(vb(x))_2 = sqrt(sum_(i=1)^n x_i^2)$. This is called the *$ell^2$ norm* of $vb(x)$.
]

#definition[Matrix Norm][
  For $matbold(A) in RR^(n times n)$, $norm(matbold(A))$ is the smallest $a > 0$ such that $norm(matbold(A)vb(z))_2 <= a norm(vb(z))_2$ for all $vb(z) in RR^n$. In particular, for positive semidefinite matrices, $norm(matbold(A))$ is the largest eigenvalue of $matbold(A)$.

  #fade[[Intuitively, this is the largest scaling factor of $matbold(A)$ among all possible vectors.]]
]

#theorem[
  If $f$ is a twice-differentiable $alpha$-strongly convex function that has an $ell$-Lipschitz Hessian, _i.e._
  $ norm(hess f(vb(x)) - hess f(vb(y))) <= ell norm(vb(x) - vb(y))_2 $ for all $vb(x), vb(y) in RR^n$ #fade[[_i.e._ if two points are close, then the Hessian doesn't change too rapidly]], then Newton's method satisfies
  $
    f(vb(x_k)) - f(vb(x^*)) <= (2 alpha^3)/(ell^2)((ell)/(2alpha^2) norm(grad f(vb(x_0)))_2)^(2^(k+1)).
  $
]

#remark[

  1. If $norm(grad f(vb(x_0)))_2 < (2 alpha^2)/(ell)$, then the error decreases doubly-exponentially, so we only need $O(log log (1/epsilon))$ iterations to get an error of at most $epsilon$.

  2. For this method, we will need to compute the inverse of the Hessian, which can be computationally expensive for many parameters.

  3. In theory, we can continue to approximate $f$ using higher-order Taylor expansions, but these are even more computationally expensive. Also, for third-order terms, the minimum does not have a closed form solution.

]

== Barrier Method

Suppose we want to solve the following problem:
$
  "minimise" f(vb(x)) "subject to" vb(a_i)^tp vb(x) <= vb(b_i) "for all" 1<=i<=m.
$

#align(center)[
  #dynamic-svg2("/part-ib/optimisation/media/d1e2.svg", width: 16em)
]

This can be re-worded as an unconstrained optimisation problem as follows:

$
  & "minimise"   && f(vb(x)) + sum_(i=1)^m phi(vb(a_i)^tp vb(x) - vb(b_i)) \
  & "subject to" && vb(x) in RR^n \
  & "where"      && phi(x) = cases(
                      x & "if" x <= 0,
                      +oo & "if" x > 0.
                    )
$

However, this function is badly behaved at the boundaries, so we can approximate it using a smooth function instead, such as $phi(x) = -log(-x)$, called the *logarithmic barrier function*.

#align(center)[
  #dynamic-svg2("/part-ib/optimisation/media/d1e3.svg", width: 26em)
]

#fade[[Our example of $phi(x) = x$ for $x <= 0$ is, in fact, not a good barrier function, since it has problematic limits as $x -> -oo$. Nevertheless, $phi(x) = -log(-x)$ is much better behaved using the methods described below.]]

However, since we wish to minimise $f(vb(x))$ without the extra term, we can consider a parameter $t > 0$ and the following problem instead:
$
  & "minimise"   && t f(vb(x)) - sum_(i=1)^m log(-vb(a_i)^tp vb(x) + vb(b_i)) \
  & "subject to" && vb(x) in RR^n.
$

#listing[Barrier Method][
  1. Find a strictly feasible point $vb(x)$ such that $vb(a_i)^tp vb(x) < vb(b_i)$ for all $i$ and set $t>0, alpha > 1$.

  2. Repeat the following:

    1. Compute $vb(x^*)(t)$ by minimising
      $
        t f(x) - sum_(i=1)^m log(-(vb(a_i)^tp vb(x) - vb(b_i)))
      $
      using Newton's method with initial point $vb(x)$.
    2. Update $vb(x) := vb(x^*)(t)$ and $t := alpha t$.

    3. Stop when $t$ is large enough.

]
