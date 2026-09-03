#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/mannot:0.4.0": markul

#lecture-separator(lecture: 6, date: "2026-05-13")

= Linear Programming and the Simplex Method

#set math.equation(numbering: "· 1")
#definition[Linear Program][
  A *linear program* is a problem of the form
  $
    & "minimise"   && vb(c)^tp vb(x) \
    & "subject to" && vb(a_i)^tp vb(x) >= vb(b_i) quad &  "for" i in M_1 \
    &              && vb(a_i)^tp vb(x) <= vb(b_i) quad &  "for" i in M_2 \
    &              && vb(a_i)^tp vb(x) = vb(b_i) quad  &  "for" i in M_3 \
    &              && x_j >= 0 quad                    &  "for" j in N_1 \
    &              && x_j <= 0 quad                    &  "for" j in N_2 \
    &              && x_j "is not constrained" quad    & "for" j in N_3.
  $ <problem-linear-program>
  we will denote $m = abs(M_1) + abs(M_2) + abs(M_3)$ and $n = abs(N_1) + abs(N_2) + abs(N_3)$.
]
#set math.equation(numbering: none)

Note that we can write
$
  matbold(A) = mat(—, vb(a_1)^tp, —; —, vb(a_2)^tp, —; , dots.v, ; —, vb(a_m)^tp, —) .
$

#theorem[
  The dual of @problem-linear-program[Problem] is given by
  $
    & "maximise"   && vb(b)^tp vb(lambda) \
    & "subject to" && lambda_i >= 0                & "for" i in M_1, \
    &              && lambda_i <= 0                & "for" i in M_2, \
    &              && lambda_i in RR               & "for" i in M_3, \
    &              && vb(lambda)^tp vb(A_j) <= c_j & "for" j in N_1, \
    &              && vb(lambda)^tp vb(A_j) >= c_j & "for" j in N_2, \
    &              && vb(lambda)^tp vb(A_j) = c_j  & "for" j in N_3.
  $
]

#proof[
  Adding slack variables, the lagrangian is given by
  $
    lagr(vb(x), vb(s), vb(lambda)) &= vb(c)^tp vb(x) - sum_(i in M_1) lambda_i (vb(a_i)^tp vb(x) - vb(b_i) - s_i) - sum_(i in M_2) lambda_i (vb(a_i)^tp vb(x) - vb(b_i) + s_i) - sum_(i in M_3) lambda_i (vb(a_i)^tp vb(x) - vb(b_i))\
    &=sum_(j in N_1) (c_j - vb(lambda)^tp vb(A_j)) x_j + sum_(j in N_2) (c_j - vb(lambda)^tp vb(A_j)) x_j + sum_(j in N_3) (c_j - vb(lambda)^tp vb(A_j)) x_j + sum_(i in M_1) lambda_i s_i- sum_(i in M_2) lambda_i s_i + sum_(i) lambda_i b_i
  $
  where $vb(A_j)$ is the $j$-th column of $matbold(A)$. For the lagrangian to be bounded below, we must have
  $
    Lambda = {vb(lambda) in RR^m:
    lambda_i >= 0                & "for" i in M_1, \
                   lambda_i <= 0 & "for" i in M_2, \
                  lambda_i in RR & "for" i in M_3, \
    vb(lambda)^tp vb(A_j) <= c_j & "for" j in N_1, \
    vb(lambda)^tp vb(A_j) >= c_j & "for" j in N_2, \
     vb(lambda)^tp vb(A_j) = c_j & "for" j in N_3
                                   }
  $
  Note that if $vb(lambda) in Lambda$, then
  $
    min_(vb(x) in cal(X)\ vb(s) >= vb(0)) lagr(vb(x), vb(s), vb(lambda)) = vb(b)^tp vb(lambda) = g(vb(lambda)).
  $

]

== Optimality Conditions

#theorem[Optimality Conditions for Linear Programming][
  Let $vb(x)$ and $vb(lambda)$ be feasible solutions to @problem-linear-program[Problem] and its dual. Then these are optimal iff
  $
    lambda_i (vb(a_i)^tp vb(x) - b_i) & = 0 quad "for all" i, \
    (c_j - vb(lambda)^tp vb(A_j)) x_j & = 0 quad "for all" j.
  $

] <thm-optimality-conditions-for-linear-programming>

#proof[
  Define $u_i = lambda_i (vb(a_i)^tp vb(x) - b_i)$ and $v_j = (c_j - vb(lambda)^tp vb(A_j)) x_j$. Since $vb(x)$ and $vb(lambda)$ are primal and dual feasible respectively, we have $u_i >= 0$ and $v_j >= 0$. Adding up,
  $
    sum_i u_i & = vb(lambda)^tp matbold(A) vb(x) - vb(lambda)^tp vb(b), \
    sum_j v_j & = vb(c)^tp vb(x) - vb(lambda)^tp matbold(A) vb(x).
  $
  Hence
  $
    sum_i u_i + sum_j v_j = vb(c)^tp vb(x) - vb(lambda)^tp vb(b).
  $
  By @theorem-weak-duality[Weak Duality Theorem], we have $vb(c)^tp vb(x) >= vb(lambda)^tp vb(b)$. Since $vb(c)^tp vb(x) = vb(lambda)^tp vb(b)$ if and only if $vb(x)$ and $vb(lambda)$ are optimal, we have the desired result:

  #fade[[$=>$]] If $vb(c)^tp vb(x) = vb(lambda)^tp vb(b)$, then $sum_i u_i + sum_j v_j = 0$. Since $u_i, v_j >= 0$, we must have $u_i = v_j = 0$ for all $i, j$.

  #fade[[$arrow.double.l$]] If $u_i = v_j = 0$ for all $i, j$, then $sum_i u_i + sum_j v_j = 0$. Hence, $vb(c)^tp vb(x) = vb(lambda)^tp vb(b)$, and $vb(x)$ and $vb(lambda)$ are optimal by @theorem-weak-duality[Weak Duality Theorem].
]

== Standard Form of Linear Programs

Observe that we can always write any linear program as
$
  & "minimise"   && vb(c)^tp vb(x) \
  & "subject to" && matbold(A) vb(x) <= vb(b).
$

#fade[[This is achievable by converting greater than or equal to constraints to less than or equal to constraints by multiplying by $-1$, and converting equality constraints to two inequality constraints.]]

This is called the *general form*. A linear program is in *standard form* if it is of the form
$
  & "minimise"   && vb(c)^tp vb(x) \
  & "subject to" && matbold(A) vb(x) = vb(b) \
  &              && vb(x) >= 0.
$

Since any $x in RR$ can be expressed as $x = x_+ - x_-$ where $x_+, x_- >= 0$, we can convert any linear program in general form to standard form:

$
  & "minimise"   && vb(c)^tp (vb(x)_+ - vb(x)_-) \
  & "subject to" && matbold(A) (vb(x)_+ - vb(x)_-) + vb(s) = vb(b) \
  &              && vb(x)_+, vb(x)_-, vb(s) >= 0.
$

== Solving Linear Programs

Note that minimising $vb(c)^tp vb(x)$ is the same as maximising $-vb(c)^tp vb(x)$. Since $-vb(c)^tp vb(x)$ is a convex function, we are essentially maximising a convex function over a convex set.

#definition[Extreme Point][
  A point $vb(x) in C$ where $C subset.eq RR^n$ is a convex set is an *extreme point* if it cannot be written as a convex combination of two distinct points in $C$. _i.e._ for $vb(y), vb(z) in C$ and $delta in (0, 1)$, if $vb(x) = delta vb(y) + (1 - delta) vb(z)$, then $vb(x) = vb(y) = vb(z)$.

  #fade[[Essentially, an extreme point is a point that is not in the interior of a line segment connecting two points in the convex set.]]

]
#remark[
  Boundary points are not necessarily extreme points, as they may be expressed as a convex combination of two other points on the boundary.
]

#proposition[
  The maximum of a convex function $f$ on a convex set $C$ occurs at an extreme point of $C$.
]

#proof[
  Suppose $vb(x)$ is not an extreme point of $C$. Then there exist $vb(y), vb(z) in C$ and $delta in (0, 1)$ such that $vb(x) = delta vb(y) + (1 - delta) vb(z)$. Since $f$ is convex, we have
  $
    f(vb(x)) = f(delta vb(y) + (1 - delta) vb(z)) <= delta f(vb(y)) + (1 - delta) f(vb(z)) <= max(f(vb(y)), f(vb(z))).
  $
  So $f(vb(x))$ is not the maximum of $f$ on $C$.
]

In linear programs, the constraint set is always a polytope. Hence, all we need to do is check the extreme points of the polytope to find the maximum of a convex function over it.

#lecture-separator(lecture: 7, date: "2026-05-15")

=== Basic Solutions and Basic Feasible Solutions

We are looking at the problem
$
  & "minimise"   && vb(c)^tp vb(x) \
  & "subject to" && matbold(A) vb(x) = vb(b) \
  &              && vb(x) >= 0
$

where $matbold(A)$ is an $m times n$ matrix with $m <= n$, and
$
  matbold(A) = #h(1.25em)
  labelmat(
    mat(
      A_(11), A_(12), dots.c, A_(1n);
      A_(21), A_(22), dots.c, A_(2n);
      dots.v, dots.v, dots.down, dots.v;
      A_(m 1), A_(m 2), dots.c, A_(m n)
    ),
    vb(a)_1^tp, vb(a)_2^tp, dots.v, vb(a)_m^tp,
    vb(A)_1, vb(A)_2, dots.c, vb(A)_n,
    dx: #{ 2em }, dy: #{ 1.2em },
  ).
$

We will make the following assumptions:

1. The rows of $matbold(A)$ are linearly independent.

2. Every set of $m$ columns of $matbold(A)$ is linearly independent.

3. Every basic feasible solution is *non-degenerate*, _i.e._ it has exactly $m$ non-zero entries.

#definition[Basic solution and basic feasible solution][
  A point $vb(x)$ that satisfies $matbold(A)vb(x) = vb(b)$  and has at most $m$ non-zero entries is called a *basic solution*.

  A basic solution that also satisfies $vb(x) >= 0$ is called a *basic feasible solution*.
]

Suppose we choose indices ${B(1), B(2), ..., B(m)}$ such that $x_i = 0$ for all $i in.not {B(1), B(2), ..., B(m)}$. Then we can write
$
  matbold(A)vb(x) = sum_(i=1)^n vb(A)_i x_i = sum_(i=1)^m vb(A)_(B(i)) x_(B(i)) = matbold(B) vb(x)_B
$
where
$
  matbold(B) = mat(
    bar.v, dots.c, bar.v;
    vb(A)_(B(1)), dots.c, vb(A)_(B(m));
    bar.v, dots.c, bar.v
  ), quad vb(x)_B = vec(x_B(1), dots, x_B(m)).
$

Hence,
$
  matbold(A)vb(x) = vb(b) <=> matbold(B) vb(x)_B = vb(b) <=> vb(x)_B = matbold(B)^(-1) vb(b).
$
$x_(B(1)), ..., x_B(m)$ are called the *basic variables*, $matbold(B)$ is called the *basis matrix*, and $vb(A)_B(1), ..., vb(A)_B(m)$ are called the *basic columns*.

Therefore, for every choice of $matbold(B)$ #fade[[there are $binom(n, m)$ such choices]], we get a basic solution.

If $matbold(B)^(-1)vb(b) >= 0$, then that basis gives a basic feasible solution.


#theorem[
  A vector $vb(x)$ is a basic feasible solution if and only if it is an extreme point of the feasible set
  $
    cal(X)(vb(b)) = {vb(x) in RR^n: matbold(A)vb(x) = vb(b), vb(x) >= 0}.
  $
]

#proof[

  #fade[[$=>$]] Suppose $vb(x)$ is a basic feasible solution that can be written as $vb(x) = (1 - delta) vb(y) + delta vb(z)$ for some $vb(y), vb(z) in cal(X)(vb(b))$ and $delta in (0, 1)$.

  If $x_i = 0$, then because
  $
    x_i = (1-delta) y_i + delta z_i,
  $
  we must have $y_i = z_i = 0$ since $vb(y), vb(z) >= 0$. Hence, $vb(y)$ and $vb(z)$ also have at most $m$ non-zero entries. Since $vb(x)$ is a basic feasible solution, we must have $vb(x) = vb(y) = vb(z)$. #fade[[Basic feasible solutions are unique, since the basis matrix is invertible.]] Hence, $vb(x)$ is an extreme point.

  #fade[[$arrow.double.l$]] We will prove the contrapositive. Suppose $vb(x)$ is not a basic feasible solution. If $vb(x) in.not cal(X)vb(b)$, then $vb(x)$ is not an extreme point. Hence instead assume $vb(x) in cal(X)(vb(b))$.

  Because $vb(x)$ is not a basic feasible solution, it must have $r > m$ positive entries. Suppose $x_(i_1), ..., x_(i_r) > 0$. The columns $vb(A)_(i_1), ..., vb(A)_(i_r)$ are linearly dependent, since $r > m$.

  Hence, there exists $w_(i_1), ..., w_(i_r)$ such that
  $
    sum_(i=1)^r w_(i) vb(A)_(i) = 0.
  $
  Construct a vector $vb(w)$ such that $vb(w)$ is 0 everywhere except at locations $i_1, ..., i_r$, where $w(i_1) = w_(i_1), ... w(i_r) = w_(i_r)$. Now observe that $matbold(A)vb(w) = vb(0)$.

  Consider two new points
  $
    vb(y) & = vb(x) + epsilon vb(w) \
    vb(z) & = vb(x) - epsilon vb(w)
  $
  for some small $epsilon > 0$. Then for sufficiently small $epsilon$, $vb(y), vb(z) in cal(X)(vb(b))$. Moreover,
  $
    vb(x) = 1/2 vb(y) + 1/2 vb(z).
  $
  This means that $vb(x)$ is not an extreme point of $cal(X)(vb(b))$.
]

#remark[
  Here is a bad algorithm to find the optimal solution to a linear program:

  1. List all $binom(n, m)$ basic solutions.

  2. Filter out the basic feasible solutions.

  3. Evaluate $vb(c)^tp vb(x)$ for each basic feasible solution and choose the one with the minimum value.
]

=== Towards the Simplex Method

When a linear problem is in standard form, the optimality conditions are

1. Primal feasibility: $matbold(A)vb(x) = vb(b)$ and $vb(x) >= 0$.

2. Dual feasibility: $matbold(A)^tp vb(lambda) <= vb(c)$.

3. Complementary slackness: $vb(x)^tp (vb(c) - matbold(A)^tp vb(lambda)) = 0$.

For any basic feasible solution $vb(x)$, the complementary slackness equations reduce to
$
  vb(x)_B^tp (vb(c)_B - matbold(B)^tp vb(lambda)) = 0.
$
Since $vb(x)_B > vb(0)$ #fade[[by the non-degeneracy assumption]], we must have
$
  matbold(B)^tp vb(lambda) & = vb(c)_B \
                vb(lambda) & = (matbold(B)^tp)^(-1) vb(c)_B.
$

Thus, if $matbold(A)^tp ((matbold(B)^tp)^(-1) vb(c)_B) <= vb(c)$, then $vb(lambda)$ is dual feasible, and this implies that $vb(x)$ is optimal.

#remark[
  This gives us a slightly better algorithm to find the optimal solution to a linear program, as we may abort the search early once the optimality conditions are satisfied in step 3.
]

#lecture-separator(lecture: 8, date: "2026-05-18")

#definition[Reduced Cost][
  The vector of *reduced costs* $overline(vb(c))$ is defined as
  $
    overline(vb(c))^tp = vb(c)^tp - vb(c_B)^tp matbold(B)^(-1) matbold(A).
  $
]

If for a basic feasible solution $vb(x)$, we have $overline(vb(c)) >= vb(0)$, then $vb(x)$ must be optimal.

=== The Simplex Algorithm <sec-simplex-algorithm>

Now, suppose $vb(x) = (x_B(1), x_B(2), ..., x_B(m), 0, ..., 0)^tp$ is a basic feasible solution. Suppose there is some $j^*$ such that $overline(c_(j^*)) < 0$. We want to now choose a direction to perturb our $vb(x)$.

Suppose we choose some $j in.not {B(1), ..., B(m)}$ and we make $x_j > 0$, while keeping all non-basic $x_i = 0$, _i.e._ consider
$
  (x_B(1), dots.c, x_B(m), 0, dots.c, underbracket(0, j), 0, dots.c, 0) + t (d_B(1), dots.c, d_B(m), 0, dots.c, underbracket(1, j), 0, dots.c, 0).
$

We need $matbold(A)vb(x) = vb(b)$ to still be satisfied to make sure our perturbed point is still feasible, so
$
            matbold(A)(vb(x) + t (d_B(1), dots.c, d_B(m), 0, dots.c, 1, dots.c, 0)^tp) & = vb(b) \
  matbold(A) vb(x) + t matbold(A) (d_B(1), dots.c, d_B(m), 0, dots.c, 1, dots.c, 0)^tp & = vb(b) \
                       matbold(A) (d_B(1), dots.c, d_B(m), 0, dots.c, 1, dots.c, 0)^tp & = vb(0).
$
This can be solved to
$
  matbold(B) vb(d)_B + vb(A)_j & = vb(0) \
                       vb(d)_B & = - matbold(B)^(-1) vb(A)_j.
$

Now, consider the cost $vb(c)^tp vb(x)$ at $vb(x) + t (vb(d)_B, dots.c, 1, dots.c, 0)$.
$
  vb(c)^tp (vb(x) + t vec(vb(d_B), dots.v, 1, dots.v, 0)) &= underbracket(vb(c)^tp vb(x), "old cost") + underbracket(t (vb(c)_B^tp vb(d)_B + c_j), "change of cost")\
  &= vb(c)^tp vb(x) + t(c_j - vb(c)_B^tp matbold(B)^(-1) vb(A)_j)\
  &= vb(c)^tp vb(x) + t overline(c_j).
$

Note that since our $vb(x)$ is suboptimal, we have some $vb(j)^*$ such that $overline(c_(j^*)) < 0$. Hence we can choose $j = j^*$ and use that direction to reduce our cost.

The only problem left is to determine a largest $t$ that we do not leave the feasible set.  We require
$
  x_B(i) + t d_B(i) >= 0 <=> t <= -x_B(i)/(d_B(i)),
$
and noting that only those $B(i)$ where $d_B(i)<0$ can cause problems. Therefore, we can find the smallest positive number among
$
  - (x_B(1))/(d_B(1)), dots.c, -x_B(m)/(d_B(m))
$
to be our $t$. Let it be $t^*$. Let $vb(d) = (vb(d_B), dots.c, 1, dots.c, 0)^tp$. Then
$
  vb(y) = vb(x) + t^* vb(d).
$

#claim[
  $vb(y)$ is a basic feasible solution.
]

#proof[
  Note that we already have $matbold(A) vb(y) = vb(0)$ and $vb(y) >= vb(0)$.

  In the $j^*$-th entry, we introduce an additional non-zero entry. However, since we chose $t^*$ to be maximum possible, exactly one among $y_B(1), ..., y_B(m)$ has become zero. Thus, $vb(y)$ has exactly $m$ non-zero entries, so $vb(y)$ is also a basic feasible solution.
]

The actual algorithm of the simplex method is based on a tableau representation of the linear program, called the *simplex tableau*, given by
$
  mat(
    delim: "[",
    augment: #(hline: 1, vline: 1),
    -vb(c)_B^tp vb(x)_B, overline(c_1), overline(c_2), dots.c, overline(vb(c)_n);
    x_B(1), bar, bar, dots.c, bar;
    dots.v, matbold(B)^(-1)vb(A)_1, matbold(B)^(-1)vb(A)_2, dots.c, matbold(B)^(-1)vb(A)_n;
    x_B(m), bar, bar, dots.c, bar;
  )
$
Recall that $matbold(B)^(-1) vb(A)_1 = -vb(d)_B$, if we drop the added $1$ component.

#example[Simplex Method][

  #let pivot(content) = mark(content, colors.yellow.shade700)
  #let important(content) = mark(content, colors.blue.shade700)

  Consider the linear program
  $
    & "minimise"   && -x_1 -x_2 -x_3 \
    & "subject to" && x_1 + 2x_2 + 2x_3 <= 10 \
    &              && 2x_1 + x_2 + 2x_3 <= 10 \
    &              && 2x_1 + 2x_2 + x_3 <= 20 \
    &              && x_1, x_2, x_3 >= 0.
  $

  1. We first convert this to standard form by adding slack variables $x_4, x_5, x_6$:
    $
      & "minimise"   && vb(c)^tp vb(x) \
      & "subject to" && matbold(A) vb(x) = vb(b) \
      &              && vb(x) >= 0,
    $
    where
    $
      vb(c) = vec(-1, -1, -1, 0, 0, 0), quad
      vb(x) = vec(x_1, x_2, x_3, x_4, x_5, x_6), quad
      vb(b) = vec(10, 10, 20), quad
      matbold(A) = mat(
        1, 2, 2, 1, 0, 0;
        2, 1, 2, 0, 1, 0;
        2, 2, 1, 0, 0, 1
      ).
    $

  2. Find an initial basic feasible solution. We can take $vb(x) = (0, 0, 0, 10, 10, 20)^tp$, with basis matrix
    $
      matbold(B) = mat(
        1, 0, 0;
        0, 1, 0;
        0, 0, 1
      ).
    $

  3. Calculate the reduced costs with $vb(c_B) = (0, 0, 0)^tp$:
    $
      overline(vb(c)) = vb(c) - (matbold(B)^(-1) matbold(A))^tp vb(c_B) = (-1, -1, -1, 0, 0, 0).
    $

  4. Calculate the initial cost $vb(c)^tp vb(x) = 0$.

  5. Construct the initial simplex tableau:
    $
      mat(
        delim: "[",
        augment: #(hline: 1, vline: 1),
        -vb(c)_B^tp vb(x)_B, overline(c_1), overline(c_2), overline(c_3), overline(c_4), overline(c_5), overline(c_6);
        x_B(1), bar, bar, bar, bar, bar, bar;
        x_B(2), matbold(B)^(-1)vb(A)_1, matbold(B)^(-1)vb(A)_2, matbold(B)^(-1)vb(A)_3, matbold(B)^(-1)vb(A)_4, matbold(B)^(-1)vb(A)_5, matbold(B)^(-1)vb(A)_6;
        x_B(3), bar, bar, bar, bar, bar, bar;
      )
      =
      mat(
        delim: "[",
        augment: #(hline: 1, vline: 1),
        0, -1, -1, -1, 0, 0, 0;
        fade(x_4) thick 10, 1, 2, 2, 1, 0, 0;
        fade(x_5) thick 10, 2, 1, 2, 0, 1, 0;
        fade(x_6) thick 20, 2, 2, 1, 0, 0, 1
      ).
    $

  6. Note that there are negative reduced costs, so

    - We can choose $j = 1$ to make $x_1$ enter the basis.

    - Find the pivot row such that $-x_B(i)/d_B(i)$ is minimum among all $i$ such that $d_B(i) < 0$. Note that $vb(d)_B = -matbold(B)^(-1) vb(A)_j$, and this is equivalent to the initial column of $(x_4, x_5, x_6)^tp$ divided by the entries in pivot column $j = 1$, which is $(1, 2, 2)^tp$. Hence, we have
      $
        -x_B(1)/d_B(1) = 10/1 = 10, quad
        -x_B(2)/d_B(2) = 10/2 = 5, quad
        -x_B(3)/d_B(3) = 20/2 = 10.
      $
      The minimum is $5$, so $x_5$ leaves the basis.

      $
        mat(
          delim: "[",
          augment: #(hline: 1, vline: 1),
          0, pivot(-1), -1, -1, 0, 0, 0;
          fade(x_4) thick 10, pivot(1), 2, 2, 1, 0, 0;
          important(x_5) thick pivot(10), important(2), pivot(1), pivot(2), pivot(0), pivot(1), pivot(0);
          fade(x_6) thick 20, pivot(2), 2, 1, 0, 0, 1
        ) ->
        mat(
          delim: "[",
          augment: #(hline: 1, vline: 1),
          0, pivot(-1), -1, -1, 0, 0, 0;
          fade(x_4) thick 10, pivot(1), 2, 2, 1, 0, 0;
          important(x_1) thick pivot(10), important(2), pivot(1), pivot(2), pivot(0), pivot(1), pivot(0);
          fade(x_6) thick 20, pivot(2), 2, 1, 0, 0, 1
        )
      $

    - Carry out row operations to make the pivot column have $0$ everywhere except for the pivot entry, which is $1$.

      $
        mat(
          delim: "[",
          augment: #(hline: 1, vline: 1),
          0, pivot(-1), -1, -1, 0, 0, 0;
          fade(x_4) thick 10, pivot(1), 2, 2, 1, 0, 0;
          fade(x_1) thick pivot(10), important(2), pivot(1), pivot(2), pivot(0), pivot(1), pivot(0);
          fade(x_6) thick 20, pivot(2), 2, 1, 0, 0, 1
        ) & stretch(->)^(R_2 <- 1/2 R_2)    && mat(
                                                 delim: "[",
                                                 augment: #(hline: 1, vline: 1),
                                                 0, pivot(-1), -1, -1, 0, 0, 0;
                                                 fade(x_4) thick 10, pivot(1), 2, 2, 1, 0, 0;
                                                 fade(x_1) thick pivot(5), important(1), pivot(1 slash 2), pivot(1), pivot(0), pivot(1 slash 2), pivot(0);
                                                 fade(x_6) thick 20, pivot(2), 2, 1, 0, 0, 1
                                               ) \
          & stretch(->)^(R_0 <- R_0 + R_2)  && mat(
                                                 delim: "[",
                                                 augment: #(hline: 1, vline: 1),
                                                 5, pivot(0), -1 slash 2, 0, 0, 1 slash 2, 0;
                                                 fade(x_4) thick 10, pivot(1), 2, 2, 1, 0, 0;
                                                 fade(x_1) thick pivot(5), important(1), pivot(1 slash 2), pivot(1), pivot(0), pivot(1 slash 2), pivot(0);
                                                 fade(x_6) thick 20, pivot(2), 2, 1, 0, 0, 1
                                               ) \
          & stretch(->)^(R_1 <- R_1 - R_2)  && mat(
                                                 delim: "[",
                                                 augment: #(hline: 1, vline: 1),
                                                 5, pivot(0), -1 slash 2, 0, 0, 1 slash 2, 0;
                                                 fade(x_4) thick 5, pivot(0), 3 slash 2, 1, 1, -1 slash 2, 0;
                                                 fade(x_1) thick pivot(5), important(1), pivot(1 slash 2), pivot(1), pivot(0), pivot(1 slash 2), pivot(0);
                                                 fade(x_6) thick 20, pivot(2), 2, 1, 0, 0, 1
                                               ) \
          & stretch(->)^(R_3 <- R_3 - 2R_2) && mat(
                                                 delim: "[",
                                                 augment: #(hline: 1, vline: 1),
                                                 5, pivot(0), -1 slash 2, 0, 0, 1 slash 2, 0;
                                                 fade(x_4) thick 5, pivot(0), 3 slash 2, 1, 1, -1 slash 2, 0;
                                                 fade(x_1) thick pivot(5), important(1), pivot(1 slash 2), pivot(1), pivot(0), pivot(1 slash 2), pivot(0);
                                                 fade(x_6) thick 10, pivot(0), 1, 0, 0, -1, 1
                                               )
      $

  7. Repeat the process until all reduced costs are non-negative. The final tableau is
    $
      mat(
        delim: "[",
        augment: #(hline: 1, vline: 1),
        20 slash 3, 0, 0, 1 slash 3, 1 slash 3, 1 slash 3, 1;
        fade(x_2) thick 10 slash 3, 0, 1, 2 slash 3, 2 slash 3, -1 slash 3, 0;
        fade(x_1) thick 10 slash 3, 1, 0, 2 slash 3, -1 slash 3, 2 slash 3, 0;
        fade(x_6) thick 20 slash 3, 0, 0, -5 slash 3, -2 slash 3, -2 slash 3, 1
      ).
    $

  This gives a final solution of $vb(x) = (10/3, 10/3, 0, 0, 0, 20/3)^tp$ with optimal cost $vb(c)^tp vb(x) = -20/3$.

  Hence the solution to the original problem is $vb(x) = (10/3, 10/3, 0)^tp$ with optimal cost $-20/3$.
]

#lecture-separator(lecture: 9, date: "2026-05-20")

#listing[Simplex Method][
  For problems of the form
  $
    & "minimise"   && vb(c)^tp vb(x) \
    & "subject to" && matbold(A) vb(x) <= vb(b) \
    &              && vb(x) >= vb(0),
  $
  1. Start with a basic feasible solution $vb(x)$. This is often easy to find in the case of $vb(b) >= vb(0)$, since we have $matbold(A)vb(x) <= vb(b) => matbold(A)vb(x) + vb(s) = vb(b)$ for some $vb(s) >= vb(0)$, so we can take $vb(x) = vb(0)$ and $vb(s) = vb(b)$.

    #fade[[If $vb(b) gt.eq.not vb(0)$, then we can use the two-phase simplex method to find a basic feasible solution. This is beyond the scope of this course.]]

  2. Construct the initial simplex tableau, then

    1. Find the pivot column $i$ such that $overline(c_i) < 0$.

    2. Find the pivot row $j$ such that $-x_B(j)/d_B(j)$ is minimum among all $j$ such that $d_B(j) < 0$. #fade[[Recall that $vb(d)_B = -matbold(B)^(-1) vb(A)_i$.]]

    3. Find the pivot entry, and then perform row operations to make all other entries in the pivot column zero, and the pivot entry one.

    #remark[
      When doing the row operations, it is only valid to use the pivot row to eliminate other entries in the pivot column.
    ]

  3. Repeat Step 2 until $overline(vb(c)) >= vb(0)$.
]
