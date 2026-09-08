Let the trajectory $C$ go from $vb(x)_1$ at $t_1$ to $vb(x)_2$ at $t_2$. Then
$
  W & = integral_C vb(F) dot dif vb(x) \
    & = integral_(t_1)^(t_2) vb(F) dot dv(x, t) dif t \
    & = m integral_(t_1)^(t_2) vb(dot.double(x)) dot vb(dot(x)) dif t \
    & = (1)/(2) m integral_(t_1)^(t_2) dv(, t) (abs(vb(dot(x)))^2) dif t \
    & = T(t_2) - T(t_1) \
    & = V(t_1) - V(t_2) \
    & = V(vb(x)(t_1)) - V(vb(x)(t_2)) \
    & = V(vb(x)_1) - V(vb(x)_2),
$
using Newton's second law and conservation of energy. Hence $W$ depends only on the endpoints of the trajectory.
