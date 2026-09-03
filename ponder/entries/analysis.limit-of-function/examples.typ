$(sin x)/(x)$ has domain $RR \\ {0}$, and $lim_(x->0) (sin x)/(x) = 1$. A geometric argument on the trigonometric circle gives $cos x < (sin x)/(x) < 1$ for all $x in (0, pi/2)$, hence

$
  abs((sin x)/(x) - 1) < 1 - cos x = 2 sin^2(x/2) < x^2/2.
$

Given $epsilon > 0$, choosing $delta(epsilon) = sqrt(2 epsilon)$ yields $abs(x - 0) < delta => abs((sin x)/(x) - 1) < epsilon$.
