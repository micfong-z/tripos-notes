Let the trajectory $C$ go from $bold(x)_1$ at $t_1$ to $bold(x)_2$ at $t_2$. Then
$
  W & = integral_C bold(F) dot dif bold(x) \
    & = integral_(t_1)^(t_2) bold(F) dot (dif x)/(dif t) dif t \
    & = m integral_(t_1)^(t_2) bold(dot.double(x)) dot bold(dot(x)) dif t \
    & = (1)/(2) m integral_(t_1)^(t_2) (dif)/(dif t) (abs(bold(dot(x)))^2) dif t \
    & = T(t_2) - T(t_1) \
    & = V(t_1) - V(t_2) \
    & = V(bold(x)(t_1)) - V(bold(x)(t_2)) \
    & = V(bold(x)_1) - V(bold(x)_2),
$
using Newton's second law and conservation of energy. Hence $W$ depends only on the endpoints of the trajectory.
