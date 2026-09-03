Let $Y = g(X)$. Then ${Y = y} = {omega : g(X(omega)) = y} = {X in g^(-1)({y})}$, so
$
  EE[Y] & = sum_(y in Omega_Y) y PP(Y = y) \
        & = sum_(y in Omega_Y) y PP(X in g^(-1)({y})) \
        & = sum_(y in Omega_Y) y sum_(x in g^(-1)({y})) PP(X = x) \
        & = sum_(y in Omega_Y) sum_(x in g^(-1)({y})) g(x) PP(X = x) \
        & = sum_(x in Omega_X) g(x) PP(X = x).
$
The last equality regroups terms by the value of $x$ rather than $g(x)$.
