Write $W = y_1 y'_2 - y_2 y'_1$. Differentiating and using $y''_i = -p y'_i - q y_i$ for each solution,

$
  W' &= y_1 y''_2 + y'_1 y'_2 - y'_2 y'_1 - y_2 y''_1 \
     &= y_1 y''_2 - y_2 y''_1 \
     &= -y_1 (p y'_2 + q y_2) + y_2 (p y'_1 + q y_1) \
     &= -p W.
$

This is a separable ODE for $W$:

$
  (dif W)/(W) = -p(x) dif x quad => quad W = W(x_0) exp[-integral_(x_0)^x p(u) dif u],
$

where the exponential factor is never zero. This is Abel's identity. Hence if $W(x_0) = 0$, then $W(x) = 0$ for all $x in I$; otherwise $W(x) != 0$ for all $x in I$.

Geometrically, the solution vectors are either always collinear or never collinear in the phase space.
