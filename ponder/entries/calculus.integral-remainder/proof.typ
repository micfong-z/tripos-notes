Using integration by parts repeatedly,

$
  R_(n, f, a)(h) & = (1)/(n-1)! integral_0^h (h-u)^(n-1) f^((n)) (a+u) dif u \
                 & = - h^(n-1) (f^((n-1))(a))/(n-1)! + (1)/((n-2)!) integral_0^h (h-u)^(n-2) f^((n-1)) (a+u) dif u \
                 & = ... \
                 & = -sum_(k=1)^(n-1)( f^((k))(a))/(k!)h^k + integral_0^h f'(a+u) dif u \
                 & = f(a+h) - f(a) - sum_(k=1)^(n-1) (f^((k))(a))/(k!) h^k,
$

which is exactly the Taylor remainder.
