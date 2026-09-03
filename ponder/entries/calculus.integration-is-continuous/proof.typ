For $h$ with $x + h in [a, b]$,

$
  abs(F(x+h)-F(x)) & = abs(integral_a^(x+h) f(t) dif t - integral_a^x f(t) dif t) \
                   & = abs(integral_x^(x+h) f(t) dif t) \
                   & <= integral_x^(x+h) abs(f(t)) dif t \
                   & <= sup_[a, b] abs(f) underbracket(integral_x^(x+h) dif t, h) -> 0 quad "as" h -> 0,
$

using the algebraic properties of the integral and boundedness of $abs(f)$.
