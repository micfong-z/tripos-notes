#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/mannot:0.4.0": markul

#lecture-separator(lecture: 4, date: "2026-05-08")

= The Lagrangian Methods

In general, we cannot solve all constrained optimisation problems; however, we can solve some using the Lagrangian multiplier method.

#set math.equation(numbering: "· 1")

Consider the problem
$
  & "minimise"   && f(vb(x)) \
  & "subject to" && vb(h)(vb(x)) = vb(b) "and" vb(x) in cal(X).
$ <problem-a>

#set math.equation(numbering: none)

Consider the Lagrangian function
$
  lagr(vb(x), vb(lambda)) = f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(b)).
$
We can then consider the problem
$
  & "minimise"   && lagr(vb(x), vb(lambda)) \
  & "subject to" && vb(x) in cal(X).
$

== Lagrange Sufficiency and Lagrangian Multiplier Method

#theorem[Lagrange Sufficiency Theorem][
  Let $vb(x)^* in cal(X)$ such that $vb(h)(vb(x)^*) = vb(b)$, and $vb(lambda)^* in RR^m$ such that $lagr(vb(x)^*, vb(lambda)^*) = min_(vb(x) in cal(X)) lagr(vb(x), vb(lambda)^*)$. Then $vb(x)^*$ is a solution to @problem-a[Problem].
] <theorem-lagrange-sufficiency>

#proof[
  Suppose $(vb(x)^*, vb(lambda)^*)$ is a pair as given in the statement. Since $vb(x)^* in cal(X)(vb(b))$,
  $
    min_(vb(x) in cal(X)(vb(b))) f(vb(x)) <= f(vb(x)^*)
  $

  We are left to show the reverse inequality. We have
  $
    min_(vb(x) in cal(X)(vb(b))) f(vb(x)) &= min_(vb(x) in cal(X)(vb(b)))f(vb(x)) - vb(lambda)^*^tp (vb(h)(vb(x)) - vb(b)) quad &"since" vb(h)(vb(x)) = vb(b) "for all" vb(x) in cal(X)(vb(b))\
    &>= min_(vb(x) in cal(X)) underbracket(f(vb(x)) - vb(lambda)^*^tp (vb(h)(vb(x)) - vb(b)), lagr(vb(x), vb(lambda)^*)) quad &"since" cal(X) supset.eq cal(X)(vb(b))\
    &= lagr(vb(x)^*, vb(lambda)^*) quad &"since" (vb(x)^*, vb(lambda)^*) "is a minimiser of" lagr "over" cal(X) times RR^m\
    &= f(vb(x)^*) quad &"since" vb(h)(vb(x)^*) = vb(b).
  $

]

#example[
  Consider the problem
  $
    & "minimise"   && -x_1 - x_2 + x_3 \
    & "subject to" && x_1^2 + x_2^2 = 4 \
    &              && x_1 + x_2 + x_3 = 1.
  $

  We construct the Lagrangian
  $
    lagr(vb(x), vb(lambda)) & = lagr(x_1, x_2, x_3, lambda_1, lambda_2) \
    & = -x_1 - x_2 + x_3 - lambda_1 (x_1^2 + x_2^2 - 4) - lambda_2 (x_1 + x_2 + x_3 - 1)\
    &= [(-1-lambda_2)x_1 - lambda_1 x_1^2] + [(-1-lambda_2)x_2 - lambda_1 x_2^2] + [(1-lambda_2)x_3] + [4 lambda_1 + lambda_2].
  $
  Now we try to solve the problem
  $
    & "minimise"   && lagr(vb(x), vb(lambda)) \
    & "subject to" && italic("no constraints").
  $
  Note that if $1 - lambda_2 != 0$, then $lagr(vb(x), vb(lambda)) -> -oo$ as $x_3 -> oo$. Hence, for this problem to have a solution, we must have $lambda_2 = 1$. Then we have
  $
    lagr(vb(x), vb(lambda)) = (-2 x_1 - lambda_1 x_1^2) + (-2 x_2 - lambda_1 x_2^2) + 4 lambda_1 + 1.
  $
  Again, for a finite solution to exist, we must have $lambda_1 < 0$. Then we have the minimum occurring at $x_1 = x_2 = -1/lambda_1$. So, we have derived, from a given $vb(lambda)$ to a solution $vb(x)$, the following mapping:
  $
    (lambda_1, 1) |-> (-1/lambda_1, -1/lambda_1, x_3) quad "where" lambda_1 < 0, x_3 in RR.
  $

  We now tweak $lambda_1$ so that the constraints are satisfied. We have
  $
    cases(
      1/lambda_1^2 + 1/lambda_1^2 & = 4,
      lambda_1 & < 0,
      -1/lambda_1 - 1/lambda_1 + x_3 & = 1.
    )
  $
  So we have $lambda_1 = -1/sqrt(2)$ and $x_3 = 1 - 2sqrt(2)$. Hence, we have found a solution:
  $
    vb(x)^* = (sqrt(2), sqrt(2), 1 - 2sqrt(2)) quad "and" vb(lambda)^* = (-1/sqrt(2), 1).
  $
  By @theorem-lagrange-sufficiency[Lagrange Sufficiency Theorem],  $vb(x)^*$ is a solution to the original problem.
]

We can now generalise this method to problems of the form

#listing[Lagrangian Multiplier Method][
  For problems of the form
  $
    & "minimise"   && f(vb(x)) \
    & "subject to" && vb(h)(vb(x)) <= vb(b) "and" vb(x) in cal(X),
  $

  1. Add slack variables to consider the new problem
    $
      & "minimise"   && f(vb(x)) \
      & "subject to" && vb(h)(vb(x)) + vb(s) = vb(b), \
      &              && vb(x) in cal(X) "and" vb(s) >= 0.
    $

    #fade[[For equality constraints, we can simply set $vb(s) = 0$.]]

  2. Construct the Lagrangian
    $
      lagr(vb(x), vb(s), vb(lambda)) = f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) + vb(s) - vb(b)).
    $
  3. Let
    $
      Lambda = {vb(lambda) in RR^m: min_(x in cal(X)\ s >=0) lagr(vb(x), vb(s), vb(lambda)) > -oo}.
    $

  4. For each $vb(lambda) in Lambda$, find $vb(x)^*(vb(lambda))$ and $vb(s)^*(vb(lambda))$ such that
    $
      lagr(vb(x)^*(vb(lambda)), vb(s)^*(vb(lambda)), vb(lambda)) = min_(x in cal(X)\ s >=0) lagr(vb(x), vb(s), vb(lambda)).
    $

  5. Find $vb(lambda)^* in Lambda$ such that $(vb(x)^*(vb(lambda)^*), vb(s)^*(vb(lambda)^*))$ satisfies the constraints of the original problem, _i.e._
    $
      vb(x)^*(vb(lambda)^*) in cal(X) quad "and" quad vb(h)(vb(x)^*(vb(lambda)^*)) + vb(s)^*(vb(lambda)^*) = vb(b) "and" vb(s)^*(vb(lambda)^*) >= 0.
    $


    #remark[
      We can simplify the search by noting *complementary slackness.* With $ lagr(vb(x), vb(s), vb(lambda)) = f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x))- vb(b)) - vb(lambda)^tp vb(s), $ we must have $lambda_i <= 0$ or else we can choose components of $vb(s)$ to be arbitrarily large and hence $lagr(vb(x), vb(s), vb(lambda)) -> -oo$. Moreover, if $lambda_i < 0$, then we must have $s_i = 0$.

      As a result, we must have $vb(lambda)^*^tp vb(s)^* = 0$, which is the complementary slackness condition. _i.e._ given conditions $h(vb(x))_i <= b_i$ and $lambda_i <= 0$, one of the inequalities must be strict.
    ]

    The usual method to do this is as follows:

    1. Consider the equations
      $
                pdv(lagr, x_i) = 0 quad & (n "equations") \
        h(vb(x))_j + s_j - b_j = 0 quad & (m "equations") \
                  lambda_j s_j = 0 quad & (m "equations").
      $

    2. For the $2^m$ cases of $lambda_j = 0$ or $lambda_j < 0$ for each $j$, we get $m$ of the variables set to zero. We can then solve the remaining $n + m$ equations in $n + m$ variables.

    #fade[[This links to the #link("https://en.wikipedia.org/wiki/Karush%E2%80%93Kuhn%E2%80%93Tucker_conditions")[KKT conditions], but is beyond the scope of this course.]]

  6. Then $(vb(x)^*(vb(lambda)^*), vb(s)^*(vb(lambda)^*))$ is a solution to the original problem.
]

#example[
  Consider the problem
  $
    & "minimise"   && x_1 - 3 x_2 \
    & "subject to" && x_1^2 + x_2^2 <= 4, \
    &              && x_1 + x_2 <= 2.
  $

  Construct the Lagrangian
  $
    lagr(vb(x), vb(lambda)) &= x_1 - 3 x_2 - lambda_1 (x_1^2 + x_2^2 + s_1 - 4) - lambda_2 (x_1 + x_2 + s_2 - 2)\
    &= (-lambda_1 x_1^2 + (1 - lambda_2)x_1) + (-lambda_1 x_2^2 + (-3 - lambda_2)x_2) + (-lambda_1 s_1) + (- lambda_2 s_2) + (4 lambda_1 + 2 lambda_2).
  $
  Note that $lambda_1, lambda_2 <= 0$. We have four cases to check:
  $
    cases(lambda_1 < 0, lambda_2 < 0) quad cases(lambda_1 < 0, lambda_2 = 0) quad cases(lambda_1 = 0, lambda_2 < 0) quad cases(lambda_1 = 0, lambda_2 = 0).
  $
  Note that by complementary slackness, if $lambda_i < 0$, then $s_i = 0$.

  We will check, for example, the case $lambda_1 < 0, lambda_2 < 0$. Then we have $s_1 = s_2 = 0$. We can then find the minimum of $lagr(vb(x), vb(lambda))$ by taking derivatives and setting them to zero. We have
  $
    (partial lagr)/(partial x_1) = -2 lambda_1 x_1 + 1 - lambda_2 & = 0 \
    (partial lagr)/(partial x_2) = -2 lambda_1 x_2 - 3 - lambda_2 & = 0 \
                                                    x_1^2 + x_2^2 & = 4 \
                                                        x_1 + x_2 & = 2.
  $
  The latter two equations gives $(x_1, x_2) = (0, 2)$ or $(x_1, x_2) = (2, 0)$.

  For $(0, 2)$, we have $lambda_2 = 1$ and $lambda_1 = -1$.

  For $(2, 0)$, we have $lambda_2 = -3$ and $lambda_1 = 1$.

  Neither of these satisfy $lambda_1, lambda_2 < 0$, so this case has no solution. The other cases can be checked similarly to arrive at a final set of solutions.

]

#lecture-separator(lecture: 5, date: "2026-05-11")

== Weak and Strong Duality

The Lagrange multiplier method only works for some problems. Duality allows us to have a better understanding of the solvability of these problems.

#set math.equation(numbering: "· 1")

Consider the problem
$
  & "minimise"   && f(vb(x)) \
  & "subject to" && vb(h)(vb(x)) = vb(b) "and" vb(x) in cal(X).
$ <problem-b>

#set math.equation(numbering: none)

#definition[Dual objective function and dual problem][
  The *dual objective function* $g: Lambda -> RR$ is defined as
  $
    g(vb(lambda)) = min_(vb(x) in cal(X)) lagr(vb(x), vb(lambda)),
  $
  where
  $
    Lambda = {vb(lambda) in RR^m: min_(vb(x) in cal(X)) lagr(vb(x), vb(lambda)) > -oo}.
  $

  The *dual problem* is then
  $
    & "maximise"   && g(vb(lambda)) \
    & "subject to" && vb(lambda) in Lambda.
  $
]

#remark[
  For every fixed $vb(x)$, the Lagrangian is linear in $vb(lambda)$:
  $
    lagr(vb(x), lambda) = f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(b)).
  $

  #exercise[
    Show that the minimum of linear functions is concave. Hence, $g$ is concave.
  ]

  Since $g$ is concave, the dual problem is a concave maximisation problem. This is easier to solve than the original problem, which is an arbitrary minimisation problem.
]

#theorem[Weak Duality Theorem][
  If $vb(x) in cal(X)(vb(b))$ and $lambda in Lambda$, then $f(vb(x)) >= g(vb(lambda))$. In particular,
  $
    min_(vb(x) in cal(X)(vb(b))) f(vb(x)) >= max_(vb(lambda) in Lambda) g(vb(lambda)).
  $
] <theorem-weak-duality>

#proof[
  For any $vb(lambda) in Lambda$ and $vb(x) in cal(X)(vb(b))$,
  $
    f(vb(x)) &>= min_(vb(x) in cal(X)(vb(b))) f(vb(x))\
    &= min_(vb(x) in cal(X)(vb(b))) f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(b)) quad &"since" vb(h)(vb(x)) = vb(b) "for all" vb(x) in cal(X)(vb(b))\
    &>= min_(vb(x) in cal(X)) f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(b)) quad &"since" cal(X) supset.eq cal(X)(vb(b))\
    &= min_(vb(x) in cal(X)) lagr(vb(x), vb(lambda))\
    &= g(vb(lambda)).
  $
  Taking minimum over $vb(x) in cal(X)(vb(b))$ and maximum over $vb(lambda) in Lambda$ gives the desired result.
]

#definition[Duality gap and strong duality][
  The gap between $min_(vb(x) in cal(X)(vb(b))) f(vb(x))$ and $max_(vb(lambda) in Lambda) g(vb(lambda))$ is called the *duality gap*. If the duality gap is zero, then *strong duality* holds.
]

#proposition[
  The Lagrangian multiplier method can be used to solve the original problem if and only if strong duality holds. #fade[[_i.e._ there exists $(vb(x)^*, vb(lambda)^*)$ such that $vb(x)^* = argmin_(vb(x) in cal(X)) f(vb(x))$, and $vb(h)(vb(x)^*) = vb(b).$]]


  Note that
  $
    g(vb(lambda)^*) &= min_(vb(x) in cal(X)) (f(vb((x))) - vb(lambda)^*^tp (vb(h)(vb(x)) - vb(b)))\
    &= f(vb(x)^*) - vb(lambda)^*^tp (vb(h)(vb(x)^*) - vb(b)) quad &"since" vb(x)^* = argmin_(vb(x) in cal(X)) f(vb(x))\
    &= f(vb(x)^*) quad &"since" vb(h)(vb(x)^*) = vb(b).
  $
]

#proof[

  #fade[[$=>$]] This follows from @theorem-lagrange-sufficiency[Lagrange Sufficiency Theorem].

  #fade[[$arrow.l.double$]] Suppose $exists vb(x) in cal(X)(vb(b)), vb(lambda) in Lambda$ such that $f(vb(x)) = g(vb(lambda))$. Then using this $vb(lambda)$, we can find $vb(x)^* in cal(X)$ such that $vb(x)^* = argmin_(vb(x) in cal(X)) lagr(vb(x), vb(lambda))$. Then by @theorem-lagrange-sufficiency[Lagrange Sufficiency Theorem], $vb(x)^*$ is a solution to the original problem.
]

#definition[Supporting hyperplane][
  A function $phi: RR^m -> RR$ is said to have a *supporting hyperplane* at a point $vb(b) in RR^m$ if there exists $vb(lambda) in RR^m$ such that for all $vb(c) in RR^m$,
  $
    phi(vb(c)) >= phi(vb(b)) + vb(lambda)^tp (vb(c) - vb(b)).
  $

  #fade[[This is analogous to @thm-first-order-condition-for-convexity[First Order Condition for Convexity]. We are effectively saying that the function $phi$ has a tangent that is below the function at the point $vb(b)$.]]
]

#definition[Value function][
  The *value function* $phi: RR^m -> RR$ is defined as
  $
    phi(vb(c)) = min_(vb(x) in cal(X)(vb(c))) f(vb(x)),
  $
  where $cal(X)(vb(c)) = {vb(x) in cal(X): vb(h)(vb(x)) = vb(c)}$.
]

#theorem[
  @problem-b[Problem] satisfies strong duality if the value function $phi$ has a supporting hyperplane at $vb(b)$.

  Conversely, if strong duality holds for a suitable $vb(lambda)$ #fade[[$g(vb(lambda)) = phi(vb(b))$]], then $vb(lambda)$ is the supporting hyperplane to $phi$ at $vb(b)$.

  In conclusion, we have the following relationship:
  $
    "Lagrange multiplier method works" <=> "Strong duality" <=> phi "has a supporting hyperplane at" vb(b).
  $

] <thm-supporting-hyperplane-strong-duality>

#proposition[
  The following problem has a convex value function $phi$:
  $
    & "minimise"   && f(vb(x)) \
    & "subject to" && vb(h)(vb(x)) <= vb(b) "and" vb(x) in cal(X),
  $
  where $f: RR^n -> RR$ is convex, $cal(X)$ is convex, and $h_i : RR^n -> RR$ is convex.
]

#remark[
  This gives a large class of problems for which strong duality holds, and hence the Lagrangian multiplier method can be used to solve the problem.
]

#proof[ #fade[[for @thm-supporting-hyperplane-strong-duality]]

  #fade[[$arrow.double.l$]] Suppose $phi$ has a supporting hyperplane $vb(lambda)$ at $vb(b)$. This means
  $
    phi(vb(c)) >= phi(vb(b)) + vb(lambda)^tp (vb(c) - vb(b)) quad "for all" vb(c) in RR^m.
  $
  Then we have
  $
    g(vb(lambda)) & =min_(vb(x) in cal(X)) lagr(vb(x), vb(lambda)) \
    & = min_(vb(x) in cal(X)) (f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(b))) \
    & = min_(vb(c) in RR^m) (min_(vb(x) in cal(X)(vb(c))) (f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(c))- vb(lambda)^tp (vb(c) - vb(b)))) \.
  $
  Note that
  $
    min_(vb(x) in cal(X)(vb(c))) (f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(c))) = min_(vb(x) in cal(X)(vb(c))) f(vb(x)) = phi(vb(c)).
  $
  So
  $
    g(vb(lambda)) = min_(vb(c) in RR^m) (phi(vb(c)) - vb(lambda)^tp (vb(c) - vb(b))) >= phi(vb(b)).
  $
  By @theorem-weak-duality[Weak Duality Theorem], we have $phi(vb(b)) = g(vb(lambda))$. Hence, strong duality holds.

  #fade[[$=>$]] Suppose $g(vb(lambda)) = phi(vb(b))$ for some $vb(lambda)$. Then
  $
    phi(vb(b)) &= g(vb(lambda))\
    &= min_(vb(x) in cal(X)) (f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(b)))\
    & = min_(vb(c) in RR^m) (min_(vb(x) in cal(X)(vb(c))) (f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(c))- vb(lambda)^tp (vb(c) - vb(b)))).
  $
  Note that
  $
    min_(vb(x) in cal(X)(vb(c))) (f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(c))) <= min_(vb(x) in cal(X)(vb(c))) f(vb(x)) - vb(lambda)^tp (vb(h)(vb(x)) - vb(c)) = phi(vb(c)).
  $
  Hence we have
  $
    phi(vb(b)) <= phi(vb(c)) - vb(lambda)^tp (vb(c) - vb(b)) quad "for all" vb(c) in RR^m.
  $
]
