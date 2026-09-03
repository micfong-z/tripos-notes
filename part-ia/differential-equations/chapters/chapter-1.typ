#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2025-10-10")

Differential equations appear in almost all branches of science and applied mathematics.

For example, we have the following differential equation,
$ underbracket(m, "mass of particle") (dif^(2) x)/(dif t^(2)) = underbracket(F, "force")(x, t) $
which relates the rate of change of position $x$, the _dependent variable_, with time $t$, the _independent variable_.

The main purpose of this course is to solve such equations.

= #ponder("calculus.derivative")[Differentiation]

== Introduction

#definition("Derivative")[
  The *#ponder("calculus.derivative")[derivative]* of a function $f(x)$ w.r.t. its argument $x$ is the function
  $ (dif f)/(dif x) = lim_(h->0) (f(x+h)-f(x))/(h). $
  #align(center)[
    #dynamic-svg("/part-ia/differential-equations/media/d1e1.svg", width: 24em)
  ]
] <derivative>

#remark[
  For the #ponder("calculus.derivative")[derivative] to exist, we require the left-handed and right-handed limit to exist and be equal. We write
  $ lim_(h->0^-) "and" lim_(h->0^+) $
  for the limits. _e.g._ $|x|$ is *not* #ponder("calculus.derivative")[differentiable] at $x=0$, despite being #ponder("calculus.derivative")[differentiable] at everywhere else.
]

Informally, if $lim_(x->x_0) f(x)=A$, then $f(x)$ can be made arbitrarily close to $A$ by making $x$ sufficiently close to $x_0$. Nonetheless, we do not require $f(x_0)=A$. #fade[[See IA Analysis I for a more formal discussion.]]

#notation[
  We write
  $ (dif f)/(dif x) =f'(x)=underbracket(dot(f)(x)., "usually used for" f(t)) $
]

We can higher #ponder("calculus.derivative")[derivatives] for sufficiently smooth functions. For example,
$ (dif )/(dif x)((dif f)/(dif x)) = (dif^(2) f)/(dif x^(2)) =f''(x) =dot.double(f)(x). $
To refer to the $n$th #ponder("calculus.derivative")[derivative], we write
$ (dif^(n) f)/(dif x^(n)) =f^((n))(x). $

== #ponder("calculus.big-o")[Big O] and #ponder("calculus.little-o")[Little O]

If we wish to compare the behavior of functions close to a limiting point $x_0$, we can use *order parameters*. There are two kinds of them: #ponder("calculus.big-o")[Big O] and #ponder("calculus.little-o")[Little O].

1. *#ponder("calculus.big-o")[Big O]* — "can be bounded by"

  #definition("Big O")[
    - if $x_0$ is finite, then $f(x)$ is $O(g(x))$ as $x->x_0$ if $exists delta > 0$ and $M>0$ such that $forall x$ with $0<|x-x_0|<delta$, we have
      $ |f(x)|<=M|g(x)|. $
      We often write $f(x)underbracket(=, "abuse of notation")O(g(x)).$ It follows that $f(x)g(x))$ is bounded as $x->x_0$.

      _e.g._ if $x_0=0$, then $x!=O(x^2), x^2=O(x)$ and $x=O(sqrt(x) )$.

    #align(center)[
      #dynamic-svg("/part-ia/differential-equations/media/d1e2.svg", width: 18em)
    ]

    _e.g._ $sin 2x = O(x)$ as $x->0$ since $|sin 2x| <=2|x|$.

    - if $x_0 = oo$, then $f(x)$ is $O(g(x))$ as $x->oo$ if $exists x_1 in RR$ and $M>0$ such that $forall x>x_1$, $|f(x)|<=M|g(x)|.$

      _e.g._ $2x^3+2x=O(x^3)$ as $x->oo$ since $forall x > 1$, $abs(2x^3+4x) <=2abs(x^3) +4abs(x) <=6abs(x^3)$
  ] <big-o>

1. *#ponder("calculus.little-o")[Little O]* — "much smaller than"

  #definition("Little O")[
    $f(x)$ is $o(g(x))$ as $x->x_0$ if $forall epsilon > 0 , exists delta>0$ such that $forall|x-x_0|<delta$,
    $ abs(f(x)) <=epsilon abs(g(x)). $

    If $g!=0$ in vicinity of $x_0$ (regardless of the behavior at $x_0$), equivalently
    $ lim_(x->x_0) f(x)/(g(x)) = 0. $
    We often write $f(x)=o(g(x))$.
  ] <little-o>

  _e.g._ $x^2=o(x)$ as $x->0$, since $lim_(x->0)((x^2)/(x))=0$.

  _e.g._ $sqrt(x)=o(x)$ as $x->oo$.

#remark[
  - $f(x)=o(g(x))$ is a stronger statement than $f(x)=O(g(x))$. #ponder("calculus.big-o")[Big O] shows that a function is bounded by a *given* multiple, whereas #ponder("calculus.little-o")[Little O] shows that it is bounded by *any* multiple.

    So, $f(x)=o(g(x))=>f(x)=O(g(x))$, but not the converse.

    _e.g._ $2x=O(x)$ but $2x != o(x)$ as $x->0$.

  - Multiplicative constants do not matter for #ponder("calculus.big-o")[Big O]. _i.e._ If $f(x)=O(g(x))$, $a f(x)=O(g(x))$ and $f(x)=O(a g(x))$ for any non-zero constant $a$.
]

#lecture-separator(lecture: 2, date: "2025-10-13")

Order parameters are useful to classify the remainder terms before taking limits. So we can write
$
                   f(x_0+h)-f(x_0) & =h f'(x_0) + underbracket(epsilon(h), "remainder") \
  lim_(h->0) (f(x_0+h)-f(x_0))/(h) & =f'(x_0) + lim_(h->(0)) (epsilon(h))/(h).
$

Therefore $epsilon(g)=o(h)$ as $h->0$.

Hence $ f(x_0+h)-f(x_0) & =h f'(x_0) + o(h) $ as $h->0$. This result extends to @taylors-theorem (#ponder("calculus.taylors-theorem")[Taylor's Theorem]).

== Rules for Differentiation

#theorem("Chain rule")[
  #fade[[#ponder("calculus.derivative")[Differentiating] a function of a function.]] Given $f(x)=F(g(x))$, then
  $ (dif f)/(dif x) =F'(g(x)) (dif g)/(dif x) = (dif F)/(dif g) (dif g)/(dif x) . $
] <chain-rule>

#theorem("Product rule")[
  Given $f(x)=u(x) v(x)$, then
  $ (dif f)/(dif x) =v (dif u)/(dif x) +u (dif v)/(dif x) . $
] <product-rule>

#theorem("Quotient rule")[
  #fade[[Special case of the #ponder("calculus.product-rule")[product rule].]] Given $f(x)=u(x)/(v(x))$, then
  $ (dif f)/(dif x) =(v u' - u v')/(v^2). $
] <quotient-rule>

Consider $f(x)=u(x) v(x).$ By repeated applying the #ponder("calculus.product-rule")[product rule], we have
$
    f' & = u' v + v' u \
   f'' & = u'' v + underbracket(u'v' + v'u', 2u'v') + v'' u \
  f''' & = u'''v + underbracket(u'' v' + 2 u'' v', 3u''v') + underbracket(' v'' + v'' u', 3u'v'') + v''' u. \
$

_c.f._ Pascal's triangle, we can generalize this into #ponder("calculus.leibniz-rule")[Leibniz's Rule].

#theorem("Leibniz's rule")[
  #fade[[Generalization of the #ponder("calculus.product-rule")[product rule].]] Given $f(x)=u(x)v(x)$, we have
  $ f^((n))(x) = sum_(n=0)^(n) binom(n, r) u^((n-r))(x) v^((r))(x). $
] <leibniz-rule>

== #ponder("calculus.taylor-series")[Taylor Series]

#definition("Taylor series")[
  For a function $f(x)$ which is infinitely #ponder("calculus.derivative")[differentiable] at $x=x_0$, the #ponder("calculus.taylor-series")[Taylor series] about $x_0$ is
  $ T_f (x)=f(x_0)+(x-x_0)f'(x_0)+(1)/(2!) (x-x_0)^2f''(x_0) + (1)/(3!) (x-x_0)^3 f'''(x_0) +... $
] <taylor-series>

#definition("Taylor polynomial")[
  For a function $f(x)$ which is infinitely #ponder("calculus.derivative")[differentiable] at $x=x_0$, the *#ponder("calculus.taylor-polynomial")[Taylor polynomial]* of degree $n$ is
  $ P_n (x) = f(x_0)+(x-x_0)f'(x_0) +... + (1)/(n!) (x-x_0)^n f^((n))(x_0). $
] <taylor-polynomial>

Note that $P_n (x)$ are the partial sums of the #ponder("calculus.taylor-series")[Taylor series].

#theorem("Taylor's theorem")[
  For a function $f(x)$ which is #ponder("calculus.derivative")[differentiable] $n$ times at $x=x_0$,
  $
    f(x_0+h)=f(x_0)+h f'(x_0) + (1)/(2!) h^2f''(x_0) + ... + h^(n)/(n!) f^((n))(x_0) + underbracket(E_n, "remainder")
  $
  where $E_n = o(h^n)$ as $h->0$.
] <taylors-theorem>

#corollary[Stronger version of #ponder("calculus.taylors-theorem")[Taylor's theorem]][
  Following @taylors-theorem, if $f^((n+1))(x)$ exists $forall x in (x_0, x_0+h)$ and $f^((n+1))(x)$ is continuous in this range, then
  $
    E_n & = O(h^(n+1)) quad "as" n->0 \
        & = f^(n+1)(x_n) h^(n+1)/((n+1)!). \
  $
  for some $x_n$ with $x_0<=x_(n)<=x_0+h$.
] <stronger-taylor-theorem>

#remark[
  Note that $E_n=O(h^(n+1))$ is a stronger statement than $o(h^n)$.

  _e.g._ $h^(n+(1)/(2))$ is $o(h^n)$ but not $O(h^(n+1))$ as $h->0$.
]

With $x=x_0+h$, @taylors-theorem (#ponder("calculus.taylors-theorem")[Taylor's theorem]) gives
$ f(x)=P_n (x)+E_n. $

This is to say, that $P_n (x)$ provides a local approximation to $f(x)$ in the vicinity of $x_0$ with error $o(h^n)$ or $O(h^(n+1))$.

#corollary[
  If $lim_(n->oo) E_n=0$, then the #ponder("calculus.taylor-series")[Taylor series] converges to $f(x)$.
]

#example[
  Consider, about $x_0=0$, the function $f(x)=exp(x)$. Then for $h>0$,
  $ E_n = (h^n+1)/(n+1)! exp(x_n) $
  where $0<=x_n <= h$.

  Then the fractional error
  $
    E_(n)/(exp (h)) & =(h^n+1)/(n+1)! underbracket(exp(x_n-h), <=1 "and" > 0) \
                    & <= h^(n+1)/((n+1)!). \
  $
]

Therefore, for a given target accurarcy at $x=h$, this can be used to specify how large $n$ must be.

== #ponder("calculus.lhopitals-rule")[L'Hôpital’s Rule]

#ponder("calculus.lhopitals-rule")[L'Hôpital's rule] allows us to deal with limits of indeterminate forms.

#theorem("L'Hôpital's rule")[
  Let $f(x)$ and $g(x)$ be #ponder("calculus.derivative")[differentiable] at $x_0$ with continuous first #ponder("calculus.derivative")[derivatives] there, and

  $
    lim_(x->x_0) f(x)=f(x_0) =0\
    lim_(x->x_0) g(x)=g(x_0)=0,
  $

  then if $g'(x_0) != 0$,
  $
    lim_(x->x_0) f(x)/(g(x))=lim_(x -> x_0) (f'(x))/(g'(x))
  $

  provided that the limit on the RHS exists.

] <lhopitals-rule>

#proof[
  From @taylors-theorem (#ponder("calculus.taylors-theorem")[Taylor's theorem]) we have
  $
    f(x) & =f(x_0)+(x-x_0)f'(x_0)+o(x-x_0) \
    g(x) & =g(x_0)+(x-x_0)g'(x_0)+o(x-x_0)
  $
  as $x->x_0$.

  Thus
  $
    lim_(x->x_0) f(x)/(g(x)) &= lim_(x->x_0)(f'(x_0) + (o(x-x_0))/(x-x_0))/(underbracket(g'(x_0), !=0) + (o(x-x_0))/(x-x_0)) \
    &= (lim_(x->x_0)(f'(x_0) + (o(x-x_0))/(x-x_0)))/(lim_(x->x_0)(g'(x_0) + (o(x-x_0))/(x-x_0))) \
    &= (f'(x_0))/(g'(x_0)) quad "by definition of the little O" \
    &= lim_(x->x_0) (f'(x))/(g'(x)) quad "from the continuity of 1st derivatives." \
  $
]

#lecture-separator(lecture: 3, date: "2025-10-15")

#remark[
  #ponder("calculus.lhopitals-rule")[L'Hôpital’s rule] can be generalized. For example, if $f'(x_0)=g'(x_0)=0$, then

  $ lim_(x->x_0) f(x)/(g(x)) = lim_(x->x_0) (f''(x))/(g''(x)). $

  This can be generalized even further to produce a limit on RHS results.
]

#example[
  Let
  $
    f(x) & = 3 sin x- sin 3x, \
    g(x) & = 2x-sin 2x. \
  $
  Then
  $
    f'''(x) & = -3 cos x + 27 cos 3 x, \
    g'''(x) & = 8 cos 2x. \
  $
  Therefore, we can find the limit

  $
    lim_(x->x_0) f(x)/(g(x)) & = lim_(x->x_0) (f'''(x))/(g'''(x)) \
                             & = (24)/(3) \
                             & = 8. \
  $
]
