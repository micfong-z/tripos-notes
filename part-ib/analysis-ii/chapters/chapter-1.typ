#import "../prelude.typ": *
#show: chapter.with(1)

#lecture-separator(lecture: 1, date: "2026-10-08")

The goals for this course are to

+ further develop key concepts and theorems from IA Analysis I #fade[[including convergence and limits, continuity, differentiability and integrability]].

+ investigate the key applications of the theory we  develop, including:

  + inverse function theorem;
  + existence of solutions to systems of ODEs.

= Uniform Convergence

Let $f_n: E -> RR$ for $n in ZZ_(+)$, where $E subset.eq RR$. Consider the meaning of convergence of the sequence $(f_n)$.

The most basic notion of convergence is pointwise convergence.

#definition[Pointwise convergence][

  Let $f_n: E -> RR$ for $n in ZZ_(+)$, where $E subset.eq RR$. If $forall x in E$, $(f_n (x))$ converges to some real number, then this defines a function
  $
    f: E->RR, quad f(x)=lim_(n->oo) f_n (x) quad forall x in E.
  $
  We say that *$(f_n)$ converges to $f$ pointwise* on $E$, or $f$ is the pointwise limit of $(f_n)$. We write
  $
    f_n -> f quad "pointwise on" E.
  $
]

Naturally, we would like to deduce properties such as continuity, differentiability, integrability for the limit $f$, from those properties for $f_n$. However, pointwise convergence is too weak to guarantee that these properties are preserved in the limit.

#example[Continuity is not preserved under pointwise convergence][
  Let
  $ f_n: [-1, 1]-> RR, quad f_n (x) = x^((1)/(2n+1)). $
  Then,
  $
    f_n (x) -> f(x) = cases(
      1 quad & 0 < x <= 1,
      0 quad & x = 0,
      -1 quad & -1 <= x < 0
    )
  $
  Therefore, $f_n$ is continuous but $f$ is not.
]

#example[Integrability is not preserved under pointwise convergence][
  Let $q_1, q_2, ...$ be an enumeration of $QQ inter [0, 1]$. Define
  $
    f_n: [0, 1] -> RR, quad f_n (x) = cases(
      1 quad & "if" x in {q_1, ..., q_n},
      0 quad & "otherwise."
    )
  $
  Hence for all $n in ZZ_+$, $f_n$ is continuous except at finitely many points, and hence Riemann integrable. However,

  $
    f_n (x) -> f(x) = cases(
      1 quad & "if" x in QQ inter [0, 1],
      0 quad & "otherwise."
    )
  $
  This $f$ is not Riemann integrable by IA Analysis I.
]

Now, if $f_n: [0, 1] -> RR$ is a sequence of integrable functions converging pointwise to some $f: [0, 1] -> RR$, and if $f$ is integrable, we may wonder whether it follows that $integral_(0)^1 f_n -> integral_0^1 f$. This is unfortunately also false.

#example[
  Consider #fade[[a triangular spike of height $n$ and width $(2)/(n)$]]
  $
    f_n (x) = cases(
      n^2 x quad & "if" x in [0, (1)/(n)],
      n^2 ((2)/(n) - x) quad & "if" x in [(1)/(n), (2)/(n)],
      0 quad & "otherwise."
    )
  $
  Then $f_n -> f equiv 0$ pointwise on $[0, 1]$. For all $n >= 2$,
  $
    integral_0^1 f_n (x) dif x = 1, quad "but" quad integral_(0)^(1) f(x) dif x = 0.
  $


] <ex-spike>

We need a stronger notion of convergence for continuity and integrability to be preserved. #fade[[But we try not to be too strong, like saying that $f_n -> f$ means $f_n = f$ for all sufficiently large $n$.]]

#definition[Uniform convergence][
  Let $f_n, f: E->RR$, with $n in ZZ_+$. We say $(f_n)$ *converges uniformly* to $f$ on $E$ if
  $
    forall epsilon > 0, exists N = N(epsilon) in ZZ_+ quad "such that" quad forall n >= N, forall x in E, |f_n (x) - f(x)| < epsilon.
  $
]
This is equivalent to
$
  forall epsilon > 0, exists N = N(epsilon) > 0 quad "such that" quad n >= N => sup_(x in E) |f_n (x) - f(x)| < epsilon.
$

Comparing with pointwise convergence, the definition of $f_n -> f$ pointwise is

$
  forall epsilon > 0, forall x in E, exists N = N(epsilon, x) in ZZ_+ quad "such that" quad forall n >= N, |f_n (x) - f(x)| < epsilon.
$

#lecture-separator(lecture: 2, date: "2026-10-10")

#remark[
  Uniform convergence implies pointwise convergence.
]

#example[
  Consider @ex-spike. It converges pointwise to $f equiv 0$ on $[0, 1]$, but does not converge uniformly. To see this, notice that $sup_(x in [0, 1]) abs(f_n (x) - 0) = n -> oo$.
]

#example[
  The function
  $
    f_n : RR & -> RR \
           x & |-> (x)/(n)
  $
  converges pointwise to $f equiv 0$ on $RR$, but does not converge uniformly. To see this, notice that $sup_(x in RR) abs(f_n (x) - 0) = oo$.
]
#example[
  For some $a in (0, oo)$, the function
  $
    f_n : [-a, a] & -> RR \
                x & |-> (x)/(n)
  $
  converges uniformly to $f equiv 0$ on $[-a, a]$, since $sup_(x in [-a, a]) abs(f_n (x) - 0) = (a)/(n) -> 0$.
]

#definition[Uniformly Cauchy][
  Let $f_n: E-> RR$ be a sequence of functions. We say $(f_n)$ is *uniformly Cauchy* if
  $
    forall epsilon > 0, exists N = N(epsilon) in ZZ_+ quad "such that" quad n, m >= N => sup_(x in E) abs(f_n (x) - f_m (x)) < epsilon.
  $
]

#theorem[Cauchy Criterion for Uniform Convergence][
  Let $f_n: E -> RR$. Then $(f_n)$ converges uniformly on $E$ if and only if $(f_n)$ is uniformly Cauchy on $E$.
] <thm-cauchy-criterion>

#proof[
  #fade[[$=>$]] Suppose $(f_n)$ converges uniformly on $E$ to some function $f: E -> RR$. Let $epsilon > 0$. Then $exists N = N(epsilon) in ZZ_+$ such that
  $
    sup_(x in E) abs(f_n (x) - f(x)) < epsilon quad forall n >= N.
  $
  Then for $n, m >= N$,
  $
    abs(f_n (x) - f_m (x)) & <= abs(f_n (x) - f(x)) + abs(f (x) - f_m (x)) \
                           & <= sup_(x in E) abs(f_n (x) - f(x)) + sup_(x in E) abs(f_m (x) - f(x)) \
                           & < epsilon + epsilon = 2 epsilon.
  $
  Therefore, $sup_(x in E) abs(f_n (x) - f_m (x)) < 2 epsilon$. Hence $(f_n)$ is uniformly Cauchy on $E$.

  #fade[[$arrow.double.l$]] Suppose $(f_n)$ is uniformly Cauchy on $E$. Then for all $x in E$, the sequence of real numbers $(f_n (x))$ is Cauchy. By the completeness of $RR$, $exists f(x) in RR$ such that $f_n (x) -> f(x)$ as $n -> oo$. Hence we have defined a function $f: E -> RR$. Hence $f_n -> f$ pointwise on $E$.

  To check that $f_n -> f$ uniformly, let $epsilon > 0$, by hypothesis, $exists N$ such that
  $
    n, m >= N => sup_(x in E) abs(f_n (x) - f_m (x)) < epsilon.
  $
  Hence for all $n >=N$,
  $
    abs(f_n (x) - f(x)) & <= abs(f_n (x) - f_m (x)) + abs(f_m (x) - f(x)) \
                        & <= sup_(x in E) abs(f_n (x) - f_m (x)) + abs(f_m (x) - f(x)) \
                        & < epsilon + abs(f_m (x) - f(x)) #eq-note[$forall m >= N$] \
                        & < epsilon + epsilon. #eq-note[$"if" m "is sufficiently large"$]
  $
  Hence $sup_(x in E) abs(f_n (x) - f(x)) <= 2 epsilon$. Therefore $(f_n)$ converges uniformly to $f$ on $E$.
]

#theorem[
  Let $f_n, f : [a, b] -> RR$, assume that $f_n -> f$ uniformly. Suppose further that for some $x in [a, b]$, the functions $f_n$ are all continuous at $x$. Then $f$ is continuous at $x$.
]

#proof[
  Let $epsilon > 0$. By assumption, $exists N$ such that $n >= N => sup_(x in [a, b]) abs(f_n (x) - f(x)) < epsilon$. Then for all $y in [a, b]$,
  $
    abs(f(y) - f(x)) & <= abs(f(y) - f_N (y)) + abs(f_N (y) - f_N (x)) + abs(f_N (x) - f(x)) \
                     & < 2 epsilon + abs(f_N (y) - f_N (x)).
  $
  Using the continuity of $f_N$ at $x$, we can choose $delta > 0$ such that $abs(y - x) < delta => abs(f_N (y) - f_N (x)) < epsilon$. Hence for all $y in [a, b]$ with $abs(y - x) < delta$, we have
  $
    abs(f(y) - f(x)) < 3 epsilon.
  $
  Thus $f$ is continuous at $x$.
]

#corollary[Uniform limits of continuous functions are continuous][
  Let $f_n, f: [a, b] -> RR$, assume that $f_n -> f$ uniformly. Suppose further that the functions $f_n$ are all continuous on $[a, b]$. Then $f$ is continuous on $[a, b]$.
] <cor-uniform-limits-of-cts-fn>

#notation[
  $C([a, b]) = Set(f\: [a\, b] -> RR, f "is continuous on" [a, b])$. This is the space of continuous functions on $[a, b]$.
]

#theorem[
  Let $(f_n)$ be a uniformly Cauchy sequence in $C([a, b])$. Then
  $
    exists f in C([a, b]) "such that" f_n -> f "uniformly."
  $
  #fade[[_i.e._ $C([a, b])$ is complete if we measure the distances between elements using supremum.]]
]

#proof[
  By @thm-cauchy-criterion, $exists f: [a, b] -> RR$ such that $f_n -> f$ uniformly. By @cor-uniform-limits-of-cts-fn, $f$ is continuous on $[a, b]$. Hence $f in C([a, b])$.
]
