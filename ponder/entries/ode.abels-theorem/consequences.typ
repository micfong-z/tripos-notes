If $p(x) = 0$, then $W' = -p W = 0$, so the Wronskian is constant.

Abel's identity also finds $W(x)$ without knowing the solutions explicitly. For Bessel's equation $x^2 y'' + x y' + (x^2 - n^2) y = 0$, rewritten as $y'' + (1/x) y' + (1 - n^2 \/ x^2) y = 0$,

$
  W(x) = W(x_0) exp[-integral_(x_0)^x (1)/(t) dif t] = W(x_0) (x_0)/(x).
$

The identity extends to solutions of $n$th order homogeneous linear ODEs.

Given one solution $y_1$, Abel's identity gives a second: from

$
  y_1 y'_2 - y_2 y'_1 = W(x_0) exp[-integral_(x_0)^x p(u) dif u],
$

dividing both sides by $y_1^2$,

$
  (dif)/(dif x) (y_2 / y_1) = (W(x_0))/(y_1^2) exp[-integral_(x_0)^x p(u) dif u].
$
