Let $X$ and $Y$ be independent random variables and $f, g: RR -> RR_+$. With $bold(Z) = (X, Y)$ and $h(bold(Z)) = f(X) g(Y)$,
$
  EE[h(bold(Z))] & = sum_(x, y) h(x, y) PP(bold(Z) = (x, y)) \
                 & = sum_(x, y) f(x) g(y) PP(X = x, Y = y) \
                 & = sum_(x, y) f(x) g(y) PP(X = x) PP(Y = y) \
                 & = (sum_x f(x) PP(X = x)) (sum_y g(y) PP(Y = y)) \
                 & = EE[f(X)] EE[g(Y)].
$
Independence enters at the third line, where the joint mass factorises.
