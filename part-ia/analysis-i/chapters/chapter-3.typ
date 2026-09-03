#import "../prelude.typ": *

= Differentiation

== Introduction

#definition[Differentiability and Derivative][
  Let $f: X subset.eq CC -> CC$ with $a in X$. We say that $f$ is *#ponder("calculus.derivative")[differentiable]* at $a$ if the #ponder("analysis.limit-of-function")[limit]
  $
    lim_(x->a) (f(x)-f(a))/(x-a) = lim_(h->0) (f(a+h)-f(a))/h
  $
  exists. #fade[[We require $a + h in X$.]]

  This #ponder("analysis.limit-of-function")[limit] is called the *#ponder("calculus.derivative")[derivative]* of $f$ at $a$, and is denoted by $f'(a)$ or $(dif f)/(dif x) (a)$.
]

#remark[
  At isolated points, the definition of #ponder("calculus.derivative")[derivative] is meaningless. For #ponder("analysis.accumulation-point")[accumulation points], we can distinguish between

  - interior points, where we can approach $a$ from both sides, and we need the limit to be direction-independent, and

  - non-interior points, where the limit is domain-restricted.
]

#example[
  - $f(z)=z$ is #ponder("calculus.derivative")[differentiable] at every point. This is because we have

    $
      f'(z) = lim_(h->0) (f(z+h) - f(z))/(h) = lim_(h->0) (z+h-z)/h = lim_(h->0) 1 = 1.
    $

  - $f(z) = overline(z)$ is not #ponder("calculus.derivative")[differentiable] at any point. This is because we have

    $
      lim_(h->0) (f(z+h) - f(z))/(h) = lim_(h->0) (overline(z+h) - overline(z))/h = lim_(h->0) overline(h)/h.
    $

    If this #ponder("analysis.limit-of-function")[limit] exists, then it must be the same as the #ponder("analysis.limit-of-function")[limit] along the real axis, which is $1$, and the #ponder("analysis.limit-of-function")[limit] along the imaginary axis, which is $-1$.

  - $f(x) = sin x$ on $RR$ is #ponder("calculus.derivative")[differentiable] at every point. We have

    $
      f'(x) & = lim_(h->0) (f(x+h) - f(x))/h \
            & = lim_(h->0) (sin(x+h) - sin x)/h \
            & = lim_(h->0) (sin x cos h + cos x sin h - sin x)/h \
            & = lim_(h->0) (sin x (cos h - 1) + cos x sin h)/h \
            & = sin x lim_(h->0) (cos h - 1)/h + cos x lim_(h->0) sin h/h.
    $

    We can use results from lectures that  $lim_(h->0) (cos h - 1)/h = 0$ and $lim_(h->0) sin h/h = 1$ to conclude that $f'(x) = cos x$.
]

We can also derive some properties of #ponder("calculus.derivative")[derivatives] from #ponder("analysis.algebra-of-limits")[properties of limits].

#lemma[
  let $f, g : X in CC -> CC$ be #ponder("calculus.derivative")[differentiable] at $a in X$. Then so are $f + g, f g$, and $(1)/(f)$ if $f(z) != 0$ for all $z in X$.

  Moreover, we have

  $
      (f + g)'(a) & = f'(a) + g'(a) \
        (f g)'(a) & = f'(a) g(a) + f(a) g'(a) \
    ((1)/(f))'(a) & = -(f'(a))/([f(a)]^2).
  $
] <algebra-of-derivatives>

#proof[
  These follow from last chapter. The #ponder("calculus.algebra-of-derivatives")[addition rule] is left as an exercise. We have
  $
    (f g)'(a) & = lim_(h->0) (f(a+h) g(a+h) - f(a) g(a))/h \
              & = lim_(h->0) (f(a+h) g(a+h) - f(a) g(a+h) + f(a) g(a+h) - f(a) g(a))/h \
              & = lim_(h->0) ((f(a+h) - f(a)) g(a+h) + f(a) (g(a+h) - g(a)))/h \
              & = lim_(h->0) (f(a+h) - f(a))/h g(a+h) + f(a) lim_(h->0) (g(a+h) - g(a))/h \
              & = lim_(h->0) (f(a+h)-f(a))/h lim_(h->0) g(a+h) + f(a) lim_(h->0) (g(a+h)-g(a))/h \
              & = f'(a) g(a) + f(a) g'(a).
  $
  For the last step, we need to show that a function is #ponder("analysis.continuity")[continuous] at $a$ if it is #ponder("calculus.derivative")[differentiable] at $a$. This will be dealt with later.

  The #ponder("calculus.algebra-of-derivatives")[reciprocal rule] is left as an exercise.
]

#example[
  - $f(z) = z^2$ is #ponder("calculus.derivative")[differentiable] with $f'(z) = 2z$. By induction, we can show that $f(z) = z^n$ is #ponder("calculus.derivative")[differentiable] with $f'(z) = n z^(n-1)$ for all $n in NN$.

    Hence polynomials are #ponder("calculus.derivative")[differentiable].

  - $f(z) = (1)/(z)$ is #ponder("calculus.derivative")[differentiable] on $CC \\ {0}$ with $f'(z) = -(1)/(z^2)$. By induction, we can show that $f(z) = z^(-n)$ is #ponder("calculus.derivative")[differentiable] with $f'(z) = -n z^(-n-1)$ for all $n in NN$.

    Hence rational functions are #ponder("calculus.derivative")[differentiable] on their domains.
]

#lecture-separator(lecture: 11, date: "2026-02-17")

#proposition[Chain Rule][
  Let $U, V in CC$ and $f: U -> V$, $g: V -> CC$. Suppose that $f$ is #ponder("calculus.derivative")[differentiable] at $a in U$ and $g$ is #ponder("calculus.derivative")[differentiable] at $f(a) in V$. Then $g compose f : U -> CC$ is #ponder("calculus.chain-rule")[differentiable] at $a in U$, and we have
  $
    (g compose f)' (a) = g'(f(a)) f'(a).
  $
] <prop-chain-rule>

It will be convenient to have an alternative #ponder("calculus.characterization-of-differentiability")[characterization of derivative] to prove this. It is common to see $f'(a)$ as the slope of the tangent line to the graph of $f$ at $a$.

#lemma[
  Let $f: X subset.eq CC -> CC$. Then $f$ is #ponder("calculus.derivative")[differentiable] at $a in X$ iff $exists A in CC$ and function $epsilon : {z: z + a in X} -> CC$ satisfying $epsilon(h) -> 0$ as $h -> 0$ such that
  $
    f(a+h) = f(a) + A h + epsilon(h) abs(h).
  $
] <characterization-of-differentiability>

#remark[
  This means $f(a+h) approx f(a) + A h$ for small $h$, and the function $epsilon(h)$ is to quantify the error of this approximation. We can equivalently write
  $
    f(a+h) = f(a) + A h + o(abs(h) ).
  $

  Moreover, if $f$ is #ponder("calculus.derivative")[differentiable] at $a$, then we must have $A = f'(a)$.
]

#proof[

  #fade[[$arrow.l.double$]] We have
  $
    lim_(h->0) (f(a+h)-f(a))/(h) & = lim_(h->0) (A h + epsilon(h) abs(h))/h \
                                 & = A + lim_(h->0) (epsilon(h) abs(h)/h) \
                                 & = A \
  $
  since $epsilon(h) -> 0$ as $h -> 0$, and $abs(h)/h$ is bounded. Hence $f$ is #ponder("calculus.derivative")[differentiable] at $a$ with $f'(a) = A$.

  #fade[[$=>$]] Choose $A = f'(a)$, so that $lim_(h->0) (f(a+h) - f(a))/(h) = A$, or equivalently,
  $
    lim_(h->0) (f(a+h) - f(a) - A h)/(h) = 0.
  $
  Take
  $
    epsilon (h) = cases(
      (f(a+h) - f(a) - A h)/(abs(h)) quad & "if" h != 0,
      0 quad & "if" h = 0
    )
  $
  Then $epsilon(h) -> 0$ as $h->0$, and the required equality holds.



]

#proof[ #fade[[of @prop-chain-rule[Chain Rule]]]

  Since $f, g$ are #ponder("calculus.derivative")[differentiable] at $a, f(a)$ respectively, there exists error functions $epsilon_f, epsilon_g$ such that
  $
    cases(
      epsilon_f (h) -> 0 & quad "as" h -> 0,
      epsilon_g (k) -> 0 & quad "as" k -> 0
    )
  $
  and
  $
       f(a+h) & = f(a) + f'(a) h + epsilon_f (h) abs(h), \
    g(f(a)+k) & = g(f(a)) + g'(f(a)) k + epsilon_g (k) abs(k).
  $
  So we have
  $
    (g compose f)(a + h) - (g compose f) (a) & = g (f(a+h)) - g(f(a)) \
    & = g (f(a) + underbracket(f'(a) h + epsilon_f (h) abs(h), k) ) - g(f(a)) \
    & = cancel(g(f(a))) + g'(f(a)) (f'(a) h + epsilon_f (h) abs(h)) + epsilon_g (k) abs(k) - cancel(g(f(a))) \
    & = g'(f(a)) f'(a) h + underbracket(g'(f(a)) epsilon_f (h) abs(h) + epsilon_g (k) abs(k), epsilon(h) abs(h)).
  $
  So, we just need to show that $epsilon(h) -> 0$ as $h -> 0$. We have
  $
    epsilon(h) = g'(f(a)) epsilon_f (h) + epsilon_g (h f'(a) + epsilon_f (h) abs(h)) abs(f'(a) + epsilon_f (h))
  $
  and since
  $
    lim_(h->0) [g'(f(a)) epsilon_f (h)] &= g'(f(a)) lim_(h->0) epsilon_f (h) = 0\
    lim_(h->0) [epsilon_g (h f'(a) + epsilon_f (h) abs(h)) abs(f'(a) + epsilon_f (h))] &= lim_(k->0) epsilon_g (k) abs(g'(f(a)) + epsilon_f (h)) = 0,
  $
  our conclusion follows.
]

#example[
  Consider the function
  $
    f(x) = cases(
      x sin ((1)/(x)) quad & x!=0,
      0 quad & x=0
    )
  $
  At $x!=0$, we have
  $
    f'(x) = sin ((1)/(x)) + x cos ((1)/(x)) (-1)/(x^2) = sin ((1)/(x)) - (1)/(x) cos ((1)/(x)).
  $
  At $x=0$,
  $
    f'(0) = lim_(h->0) (f(h)-f(0))/h = lim_(h->0) f(h)/h = lim_(h->0) sin(1/h),
  $
  which does not exist. Hence $f$ is only #ponder("calculus.derivative")[differentiable] on $RR \\ {0}$.
]

#lemma[
  If $X subset.eq CC -> CC$ is #ponder("calculus.derivative")[differentiable] at $a in X$, then $f$ is #ponder("analysis.continuity")[continuous] at $a$.
] <differentiability-implies-continuity>

#proof[
  We have
  $
    lim_(x->a) f(x) = lim_(h->0) f(a+h) = lim_(h->0) (f(a) + f'(a) h + epsilon(h) abs(h)) = f(a).
  $
]

== Mean Value Theorems

We have concluded that the #ponder("calculus.derivative")[derivative] of a function is the instantaneous rate of change. We want to relate this to the average rate of change.

#theorem[Mean Value Theorem][
  Let $f: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$. Then $exists c in (a, b)$ such that
  $
    f'(c) = (f(b) - f(a))/(b - a).
  $
] <mean-value-theorem>

We shall consider an easier case first.

#proposition[Rolle's Theorem][
  Let $f: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$. If $f(a) = f(b)$, then $exists c in (a, b)$ such that $f'(c) = 0$.
] <rolles-theorem>

#proof[ #fade[[of @mean-value-theorem[Mean Value Theorem]]]

  #align(center)[
    #dynamic-svg("/part-ia/analysis-i/media/d1e2.svg", width: 28em)
  ]

  Let $phi(x) = f(x) - ell(x)$. Then $phi(a) = phi(b) = 0$ but also $phi'(x) = f'(x) - (f(b)-f(a))/(b-a)$.

  By @rolles-theorem[Rolle's Theorem], there exists $c in (a, b)$ such that $phi'(c) = 0$, so we have $f'(c) = (f(b)-f(a))/(b-a)$.
]

#lecture-separator(lecture: 12, date: "2026-02-19")

#remark[
  @mean-value-theorem[Mean Value Theorem] can be rephrased as the followings.

  Given $h$ such that $a + h in [a, b]$, $exists theta = theta(h) in (0, 1)$ such that $f(a+h) = f(a) + h f'(a + theta h)$.

  Note that there is no error function $epsilon$ in this statement.
]

#proof[
  #fade[[of @rolles-theorem[Rolle's Theorem]]]

  The idea is that we are looking for some $c$ that is a local minimum or a local maximum.

  By @extreme-value-theorem[Extreme Value Theorem], $f$ attains its maximum and its minimum on $[a, b]$, _i.e._ $exists x_(m), x_(M) in [a, b]$ such that
  $
    sup_([a, b]) f = f(x_M), quad inf_([a, b]) f = f(x_m).
  $
  If we can show one of $x_m$, $x_M$ is in $(a, b)$, then by the we have our result:

  - $x_m in (a, b) => "sign"((f(x_m + h) - f(x_m))/(h)) = "sign"(h)$. Hence by taking limits from $h->0^+$ and $h->0^-$, we have $f'(x_m) = 0$.


  - $x_M in (a, b) => "sign"((f(x_M + h) - f(x_M))/(h)) = -"sign"(h)$. Hence by taking limits from $h->0^+$ and $h->0^-$, we have $f'(x_M) = 0$.

  Now, suppose $f$ is not constant (or otherwise the result is trivial). Either $f(a) < f(b)$ or $f(a) > f(b)$, so either $x_M$ or $x_m$ is in $(a, b)$.
]

We shall see some applications about @mean-value-theorem[Mean Value Theorem].

#corollary[
  Let $f: [a, b] ->RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$.
  Then

  1. if $f' >= 0$ on $(a, b)$, then $f$ is #ponder("analysis.monotone-function")[increasing] on $[a, b]$;

  2. if $f' <= 0$ on $(a, b)$, then $f$ is #ponder("analysis.monotone-function")[decreasing] on $[a, b]$;

  3. if $f' = 0$ on $(a, b)$, then $f$ is constant on $[a, b]$.

  The #ponder("analysis.monotone-function")[monotonocity] of $f$ is strict if the inequalities are strict.
] <corollary-mean-value-theorem>

#remark[
  It is not always possible to replace $[a, b]$ with some sets $X subset.eq RR$. For example, consider the function $f: QQ -> RR$ defined by
  $
    f(x) = cases(
      0 quad & x^2 > 2,
      1 quad & x^2 < 2
    )
  $
  Note that by definition, $f$ is #ponder("analysis.continuity")[continuous] and #ponder("calculus.derivative")[differentiable] at every point in $QQ$, and $f' = 0$ on $QQ$. However, $f$ is not constant on $QQ$.
]

Note that we can generalise @corollary-mean-value-theorem[Corollary of Mean Value Theorem] (3) to functions defined on $CC$.

#lemma[
  Let $f: CC -> CC$ be #ponder("calculus.derivative")[differentiable] in $CC$ and $f'(z) = 0$ for all $z in CC$. Then $f$ is constant on $CC$.
] <constant-function-complex>

#proof[
  The idea is to reduce to the $RR$ case. Fix some $z in CC$, take $g(t) = f(t z)$ where $g:[0, 1] -> CC$. Note that $g$ is #ponder("analysis.continuity")[continuous] on $[0, 1]$ and #ponder("calculus.derivative")[differentiable] on $(0, 1)$, so we can apply @mean-value-theorem[Mean Value Theorem] and its corollaries to $re g(t)$ and $im g(t)$ separately. We have
  $
    g'(t) = z f'(t z) = 0 => cases(
      re g'(t) = 0,
      im g'(t) = 0
    )
  $
  Hence $g(t)$ is constant on $[0, 1]$, so we have $f(z) = g(1) = g(0) = f(0)$.

  Since $z$ is arbitrary, we have $f(z) = f(0)$ for all $z in CC$, so $f$ is constant on $CC$.

]

#theorem[Inverse Function Theorem, Version 2][
  Let $f: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$. Assume that $f'(x) > 0$ for all $x in (a, b)$. Then $f: [a, b] -> [f(a), f(b)]$ is #ponder("algebra.bijection")[bijective] with inverse $f^(-1): [f(a), f(b)] -> [a, b]$ #ponder("analysis.continuity")[continuous] and #ponder("calculus.derivative")[differentiable] on $(f(a), f(b))$ with
  $
    (f^(-1))'(y) = 1/(f'(f^(-1)(y))) quad forall y in (f(a), f(b)).
  $
] <inverse-function-theorem-version-2>

#proof[
  By the corollary above, $f$ is strictly #ponder("analysis.monotone-function")[increasing], so @inverse-function-theorem-version-1[Inverse Function Theorem (Version 1)] applies, so $f$ is a #ponder("algebra.bijection")[bijection] to its image and $f^(-1)$ is #ponder("analysis.continuity")[continuous].

  Now for #ponder("calculus.derivative")[differentiability], let $y in (f(a), f(b))$ and $x = f^(-1)(y)$. This $x$ is unique by #ponder("algebra.bijection")[bijectivity]. Given $h$ such that $y + h in (f(a), f(b))$, define $k$ such that $y + h = f(x + k) <=> k = f^(-1)(t+h)-x$. Then
  $
    (f^(-1)(y+h) - f^(-1)(y))/(h) = (x + k - x)/(f(x+k) - y) = (k)/(f(x+k) - f(x)) = (1)/((f(x+k)-f(x))/k).
  $
  So differentiability and the formula holds if we show that $h->0$ implies $k->0$. This is true because
  $
    lim_(h->0) k = lim_(h->0) (f^(-1)(y + h) -f^(-1)(y)) = 0
  $
  by #ponder("analysis.continuity")[continuity] of $f^(-1)$.
]

#example[
  - Fix $R > 0$. Define $f: [0, R] -> RR$ with $x |-> x^N$ where $N in NN$. Then $f$ is #ponder("analysis.continuity")[continuous] on $[0, R]$ and #ponder("calculus.derivative")[differentiable] on $(0, R)$ with $f'(x) = N x^(N-1) > 0$ for all $x in (0, R)$. Thus by @inverse-function-theorem-version-2[Inverse Function Theorem (Version 2)], $f$ is a #ponder("algebra.bijection")[bijection] to its image $[0, R^N]$ with inverse $f^(-1): [0, R^N] -> [0, R]$ #ponder("analysis.continuity")[continuous] and #ponder("calculus.derivative")[differentiable] on $(0, R^N)$ with
    $
      (f^(-1))'(y) = 1/(f'(f^(-1)(y))) = 1/(N (f^(-1)(y))^(N-1)).
    $

    We can write $f^(-1)(y) = y^(1/N)$, so we have $(f^(-1))'(y) = (1)/(N y^((N-1)/N)) = (1)/(N) y^((1)/(N) - 1)$.

  - $f(x) = ee^x$ is #ponder("analysis.continuity")[continuous] and #ponder("calculus.derivative")[differentiable] on $RR$ with $f'(x) = ee^x > 0$. Then there exists an inverse
    $
      f^(-1)'(y) = (1)/(ee^(f^(-1)(y))) = (1)/(y).
    $

]

#proposition[Cauchy Mean Value Theorem][
  Let $f, g: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$. Then $exists c in (a, b)$ such that
  $
    [f(b) - f(a)] g'(c) = [g(b) - g(a)] f'(c).
  $
] <cauchy-mean-value-theorem>

#proof[
  We aim to reduce to @rolles-theorem[Rolle's Theorem]. Let
  $
    phi(x) = [g(x) - g(a)] [f(b) - f(a)] - [g(b) - g(a)][f(x) - f(a)]\
    phi'(x) = g'(x) [f(b) - f(a)] - f'(x) [g(b) - g(a)],
  $
  and note that $phi(a) = 0 = phi(b)$, Hence by @rolles-theorem[Rolle's Theorem], there exists $c in (a, b)$ such that $phi'(c) = 0$, so the result follows.
]

#proposition[L'Hôpital's rule][
  Let $f, g: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$. Assume that $g'(x) != 0$ for all $x in (a, b)$ and that $lim_(x->a) f(x) = lim_(x->a) g(x) = 0$. If $lim_(x->a) (f'(x))/(g'(x))$ exists, then $lim_(x->a) (f(x))/(g(x))$ also exists and is equal to $lim_(x->a) (f'(x))/(g'(x))$.
]

#example[
  We have seen that $lim_(x->0) (sin x)/x = 1$. With #ponder("calculus.lhopitals-rule")[L'Hôpital's rule], we can also compute this limit as follows:
  $
    lim_(x->0) (sin x)/x = lim_(x->0) (cos x)/1 = 1.
  $

  Behind the scenes in this computation, we are saying that $exists theta in (0, 1)$ such that
  $
    (sin x)/x = (sin x - sin 0)/(x - 0) = (cos (theta x))/1 & quad "by Cauchy MVT" \
          lim_(x->0) (sin x)/x = lim_(x->0) cos theta x = 1 & quad "by continuity of cosine".
  $
]

#lecture-separator(lecture: 13, date: "2026-02-21")

#corollary[
  Let $f: [a, b] -> RR$ be #ponder("analysis.continuity")[continuous] on $[a, b]$ and #ponder("calculus.derivative")[differentiable] on $(a, b)$. If there exists $x_0 in (a, b)$ such that $f'(x_0) != 0$, then locally around $x_0$, there is an #ponder("set-theory.invertible-function")[inverse function] for $f$ which is #ponder("calculus.derivative")[differentiable]. #fade[[Refer to Example Sheet 3 for further details.]]
]

== Higher Derivatives and Taylor's Theorem

#definition[Higher Derivatives][
  Let $f: X subset.eq CC -> CC$ be #ponder("calculus.derivative")[differentiable] on $X$. We say that $f$ is *#ponder("calculus.higher-derivatives")[twice differentiable]* if
  $
    f': X & -> R \
        x & |-> f'(x)
  $
  is #ponder("calculus.derivative")[differentiable]. We similarly define *#ponder("calculus.higher-derivatives")[thrice differentiable]* and *#ponder("calculus.higher-derivatives")[$n$ times differentiable]* for $n in NN$ inductively.

  We say that $f$ is #ponder("calculus.higher-derivatives")[$k$-times continuously differentiable], and write $f in C^k (X)$, if $f$ is #ponder("calculus.higher-derivatives")[$k$ times differentiable] and
  $
    f^(k): X & -> RR \
           x & |-> f^(k)(x)
  $
  is #ponder("analysis.continuity")[continuous].
] <higher-derivatives>

#remark[
  Recall that $f$ being #ponder("calculus.derivative")[differentiable] implies its #ponder("analysis.continuity")[continuity], so if $f$ is #ponder("calculus.higher-derivatives")[$k$-times differentiable], then $f^(i)$ is #ponder("analysis.continuity")[continuous] for all $i < k$.
]

#definition[Smoothness][
  We say $f: X subset.eq CC -> CC$ is #ponder("calculus.smooth-function")[smooth] if $f$ is #ponder("calculus.higher-derivatives")[$k$-times differentiable] for all $k in NN$. We write $f in C^(oo) (X)$.
] <smooth-function>

We saw that $f$ being #ponder("calculus.derivative")[differentiable] implies that it can be #ponder("calculus.characterization-of-differentiability")[well-approximated by a linear function] near $a$:
$
  f(x) approx f(a) + f'(a) (x-a).
$
Meanwhile, if $f$ is #ponder("calculus.higher-derivatives")[twice differentiable], then we can do better:
$
  f(x) approx f(a) + f'(a) (x-a) + (1)/(2) f''(a) (x-a)^2.
$
We want to state a general version of this apprixmation, under appropriate conditions, and also quantify the error of this approximation.

#definition[Taylor polynomial][
  If $f: X -> CC$ is #ponder("calculus.higher-derivatives")[$n$-times differentiable], $x_0 in X$, then we call
  $
    sum_(k=0)^n (f^((k))(x_0))/(k!) (x-x_0)^k
  $
  the *#ponder("calculus.taylor-polynomial")[Taylor polynomial]* of $f$ at $x_0$ of degree $n$. We denote this by $T_(n, f, x_0) (x)$.

  If $f$ is #ponder("calculus.smooth-function")[smooth], we call
  $
    sum_(k=0)^(oo) (f^((k))(x_0))/(k!) (x-x_0)^k
  $
  the *#ponder("calculus.taylor-series")[Taylor series]* of $f$ at $x_0$.
]

#theorem[Taylor's Theorem: Lagrange Remainder][
  Let $f: [a, a+b]$ be #ponder("analysis.continuity")[continuous], and assume its first $n-1$ derivatives are #ponder("analysis.continuity")[continuous] as well, and that it is #ponder("calculus.higher-derivatives")[$n$-times differentiable] on $(a, a+h)$. #fade[[This is all satisfied if $f in C^n ((c, d))$ where $[a, a+h] subset.eq (c, d)$.]]

  Let the #ponder("calculus.lagrange-remainder")[Taylor remainder] be
  $
    R_(n, f, a)(h) & = f(a+h) - T_(n-1, f, a) (h) \
                   & = f(a+h) - sum_(k=0)^(n-1) (f^((k))(a))/(k!) h^k.
  $
  Then there exists $theta in (0, 1)$ such that
  $
    R_(n, f, a)(h) = h^n/(n!) f^((n))(a + theta h).
  $

] <taylor-lagrange-remainder>

#remark[
  For $n=1$, this is just @mean-value-theorem[Mean Value Theorem]. There is nothing special about $h>0$; if $h = -t < 0$ and $f$ and its $n-1$ derivatives are #ponder("analysis.continuity")[continuous] on $[a-t, a]$ and its $n$-th derivative exists on $(a-t, a)$ , then we can apply the above to $g(x) = f(-x)$:
  $
    g(-a + t) & = sum_(k=0)^(n-1) (-1)^k / k! f^(k) (a) t^k + (-1)^n t^n/ n! f^((n))(a - theta t) \
     f(a + h) & = sum_(k=0)^(n-1) (f^((k))(a))/(k!) (-t)^k + (-t)^n/(n!) f^((n))(a + theta h).
  $
]

#remark[
  If $f in C^n ((c, d))$ with $[a, a+b] subset.eq (c, d)$, then $f^((n))$ is #ponder("analysis.continuity")[continuous] and hence bounded on $[a, a+h]$. Hence $exists M_n$ such that
  $
    M_n = sup_(x in [a, a+h]) abs(f^((n))(x)).
  $
  Hence
  $
    abs(R_(n, f, a)(h)) = abs(h^n/(n!) f^((n))(a + theta h)) <= M_n h^n/(n!).
  $
  Therefore $R_(n, f, a)(h)$ is #ponder("calculus.big-o")[$O(h^n)$] as $h -> 0$. Note that this does not tell use that $R_(n, f, a) (h) -> 0$ as $n->oo$, since even if $f in C^(oo)$, we do not know how $M_n$ behaves with $n$.
]

#proof[

  / Proof 1: WLOG take $a = 0$. #fade[[If $a != 0$, apply to $g(x) = f(x+a)$ instead.]] Let $phi$ be a #ponder("analysis.continuity")[continuous] function, with its first $n-1$ derivatives #ponder("analysis.continuity")[continuous] and the $n$-th derivative existing on $(0, h)$, defined by
    $
      phi: [0, h] & -> RR \
                t & |-> f(t) - T_(n-1, f, 0) (t) - t^(n)/(n!) B
    $
    where we pick $B$ such that $phi(h)=0$. Note that $phi(0) = 0$ and also $phi^(k)(0)=0$ for all $k < n$. By #ponder("calculus.rolles-theorem")[Rolle's theorem],
    $
      phi(0) = phi(h) = 0 & => exists theta_1 in (0, 1) "s.t." phi'(theta_1 h) = 0. \
      phi'(0) = phi'(theta_1 h = 0 & => exists theta_2 in (0, 1) "s.t." phi''(theta_2 theta_1 h) = 0. \
      & dots.v\
      phi^((n-1))(0) = phi^((n-1))(theta_(n-1) ... theta_2 theta_1 h) = 0 & => exists theta_n in (0, 1) "s.t." phi^((n))(theta_n ... theta_2 theta_1 h) = 0.
    $
    Now let $theta = theta_n dot... dot theta_1$. Then $theta in (0, 1)$ and we have effective shown that
    $
      exists theta(0, 1) "s.t." f^((n))(theta h) - B = phi^((n))(theta h) = 0
    $
    and hence $B = f^((n))(theta h)$, so we have
    $
      R_(n, f, 0)(h) = f(h) - T_(n-1, f, 0)(h) = h^n/(n!) f^((n))(theta h).
    $

  / Proof 2: WLOG take $a = 0$. Let
    $
      g: [0, h] & -> RR \
              t & |-> f(h) - sum_(k=0)^(n-1) (f^(k)(t))/(k!) (h-t)^k.
    $

    #fade[[Note $g(0) = f(h) - T_(n-1, f, 0)(h).$]]

    Note that $g$ is #ponder("analysis.continuity")[continuous] on $[a,h]$, #ponder("calculus.derivative")[differentiable] on $(a, b)$ with
    $
      g'(t) = - (f^((n))(t))/(n-1)! (h-t)^(n-1)
    $
    For $p = 1, ..., n$, set
    $
      phi_p (t) = g(t) - (h-t)^p/(h^p) g(0).
    $
    Then
    $
      phi_p (h) = phi_p (0) = 0 => exists theta in (0, 1) quad "s.t." quad g'(theta h) + (p(1-theta)^(p-1))/h g(0) = phi'_p (theta h) = 0
    $
    _i.e._ $exists theta in (0, 1)$ such that
    $
          & - (h^(n-1) (1-theta)^(n-1))/(n-1)! f^((n)) (theta h) + p (1-theta)^(p-1)/h g(0) = 0 \
      <=> & f(h) - T_(n-1, f, 0)(h) = (h^n)/(p(n-1)!) (1-theta)^(n-p) f^((n)) (theta h).
    $

    Now, we can choose $p = n$ to get the required result.
]

The second proof leads to an alternative version of #ponder("calculus.taylors-theorem")[Taylor's Theorem].

#theorem[Taylor's Theorem: Cauchy remainder][
  Let $f$ as in @taylor-lagrange-remainder[Taylor's Theorem: Lagrange Remainder] and define $R_(n, f, a)$ similarly. Then there exists $theta in (0, 1)$ such that
  $
    R_(n, f, a) (h) = h^(n)/((n-1)!) (1-theta)^(n-1) f^((n))(a + theta h).
  $
] <taylor-cauchy-remainder>

#lecture-separator(lecture: 14, date: "2026-02-24")

#remark[
  If $f in C^n ([c, d])$ with $[a, a+h] subset.eq (c, d)$, then as in the previous remark, we can set
  $
    M_n = sup_(x in [a, a+h]) abs(f^(n) (x))
  $
  Then by @taylor-cauchy-remainder[Taylor's Theorem: Cauchy remainder], we have
  $
    abs(R_(n, f, a)(h)) <= M_n abs(h)^n/((n-1)!)
  $
  It appears that this is not better than the bound in @taylor-lagrange-remainder[Taylor's Theorem: Lagrange Remainder]. However, the following example shows that the #ponder("calculus.cauchy-remainder")[Cauchy remainder] can be better than the #ponder("calculus.lagrange-remainder")[Lagrange remainder].
]
#example[
  Consider $f(x) = x^q$ where $q in QQ$, which is #ponder("calculus.smooth-function")[smooth] on $(0, oo)$. Clearly
  $
    f^(k) (x) = q (q-1) ... (q-k+1) x^(q-k).
  $

  #remark[
    If $q in ZZ$, then $f$ is exactly its #ponder("calculus.taylor-polynomial")[Taylor polynomial] of some degree.
  ]

  Then
  $
    T_(n-1, f, 1) (x) & = sum_(k=0)^(n-1) underbracket((q (q-1) ... (q-k+1))/(k!), binom(q, k)) x^k \
                      & = sum_(k=0)^(n-1) binom(q, k) x^k. \
  $

  We now look at the remainder
  $
    R_(n, f, 1)(x) = (1+x)^q - sum_(k=0)^(n-1) binom(q, k) x^k quad "in" (-1, 1).
  $
  There are two ways to estimate this remainder:

  - #ponder("calculus.lagrange-remainder")[Lagrange remainder]: $exists theta in (0, 1)$ such that
    $
      R_(n, f, 1)(x) = binom(q, n) (1 + theta x)^(q-n) x^n.
    $

    If $n >= q$, then $(1 + theta x)^(q - n) <= 1$ for $x in (0, 1)$, so for any $x in (0, 1)$, we have
    $
      abs(R_(n, f, 1)(x)) <= abs(binom(q, n) x)^n -> 0 quad "as" quad n -> oo.
    $
    Note that argument fails for $x in (-1, 0)$.

  - #ponder("calculus.cauchy-remainder")[Cauchy remainder]: $exists theta in (0, 1)$ such that
    $
      R_(n, f, 1)(x) & = (1-theta)^(n-1) n binom(q, n) (1 + theta x)^(q-n) x^n \
                     & = (1-theta)^(n-1) q binom(q-1, n-1) (1 + theta x)^(q-n) x^n \
                     & = q binom(q-1, n-1) ((1-theta)/(1+theta x))^(n-1) (1 + theta x)^(q-1) x^n.
    $
    Now $(1 + theta x) = (1-theta) + theta (x + 1) >= 1 - theta$, so $((1-theta)/(1+theta x))^(n-1) <= 1$ as long as $n >= 1$. Hence
    $
      abs(R_(n, f, 1)(x)) &<= abs(q x) abs(binom(q - 1, n-1) x^(n-1)) underbracket(abs(1+theta x)^(q-1), "no dependence"\ "on" n)\
      &<= C abs(binom(q - 1, n-1) x^(n-1)) quad &"for some constant" C > 0\
      &-> 0 quad &"as" n -> oo "for every" x in (-1, 1).
    $

  Hence, we can see that the #ponder("calculus.cauchy-remainder")[Cauchy remainder] estimate gives us that the remainder is exponentially small as $n->oo$ for all $x in (-1, 1)$, while the Lagrange could only guarantee it for $x in (0, 1)$.
]

#definition[Analytic Functions][
  We say $f in C^oo ((c, d))$ if for every $a in (c, d)$, there exists $r > 0$ such that $forall abs(h) < r$, we have
  $
    f(a+h) = sum_(k=0)^oo (f^((k))(a))/(k!) h^k = lim_(n->oo) T_(n, f, a)(h),
  $
  which is equivalent to saying that
  $
    lim_(n->oo) R_(n, f, a)(h) = 0.
  $
] <analytic-function>

#example[
  $x^q$ is an #ponder("calculus.analytic-function")[analytic function] in $(0, 2)$, _i.e._ $(1+x)^q$ is #ponder("calculus.analytic-function")[analytic] in $(-1, 1)$, such that $R_(n, f, a)(h) -> 0$ for every $abs(h) < 1= r$.
]

#remark[
  If $R_(n, f, a)(h) arrow.not 0$ as $n->oo$, it does not necessarily mean that the #ponder("calculus.taylor-series")[Taylor series] of $f$ at $a$ does not converge. It instead implies that the #ponder("calculus.taylor-series")[Taylor series] does not represent $f$ near $a$.
]
