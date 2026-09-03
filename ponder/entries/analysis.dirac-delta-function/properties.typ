The Dirac delta function has the following properties:

1. $delta(t) = 0$ for all $t != 0$.

2. $integral_(-oo)^(oo) delta(t) dif t = 1$.

3. (Sampling property.) For all functions $g(t)$ that are continuous at $t = 0$,

$
  integral_(-oo)^(oo) g(t) delta(t) dif t &= lim_(epsilon->0) integral_(-oo)^(oo) g(t) D(t; epsilon) dif t \
                                         &= g(0) lim_(epsilon->0) integral_(-oo)^(oo) D(t; epsilon) dif t \
                                         &= g(0).
$

More generally, for a function $g(t)$ continuous at $t = t_0$,

$
  integral_a^b g(t) delta(t-t_0) dif t = cases(
    g(t_0) quad & "if" a < t_0 < b,
    0 quad & "if" t_0 < a "or" t_0 > b,
    "undefined" quad & "otherwise"
  )
$
