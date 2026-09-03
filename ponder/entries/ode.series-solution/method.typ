To find a series solution about $x_0$:

+ Try $y(x) = sum_(n=0)^oo a_n (x - x_0)^n$ and differentiate term by term.
+ Multiply the ODE by a convenient power of $x$ so that every term carries the same power before substituting.
+ Substitute the series and shift indices so that all sums share the same power of $x$.
+ Equate coefficients of $x^n$ to obtain a recurrence relation relating $a_n$ to earlier coefficients. The constants $a_0$ and $a_1$ stay arbitrary, giving the two arbitrary constants of the general solution.

For $(1-x^2) y'' - 2 x y' + 2 y = 0$ about $x = 0$, the recurrence is $a_n = (n-3)/(n-1) a_(n-2)$. The odd branch terminates since $a_3 = 0$, so one solution is $y(x) = a_1 x$. The even branch gives

$
  y(x) = a_0 [1 - x^2 - x^4/3 - x^6/5 - ...] = a_0 [1 - (x)/(2) ln ((1+x)/(1-x))],
$

using $ln (1 plus.minus x) = plus.minus x - (x^2)/(2) plus.minus (x^3)/(3) - dots$, so the general solution closes in closed form. The behavior near $x = plus.minus 1$ reflects the regular singular points there.
