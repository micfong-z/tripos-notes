For the product formula,
$
  "Cov"(X, Y) & = EE[(X - EE[X]) (Y - EE[Y])] \
              & = EE[X Y - X EE[Y] - Y EE[X] + EE[X] EE[Y]] \
              & = EE[X Y] - EE[X] EE[Y] - EE[Y] EE[X] + EE[X] EE[Y] \
              & = EE[X Y] - EE[X] EE[Y].
$

For the variance of a sum,
$
  "Var"(X + Y) & = EE[((X-EE[X]) + (Y - EE[Y]))^2] \
               & = EE[(X - EE[X])^2] + EE[(Y - EE[Y])^2] + 2 EE[(X - EE[X]) (Y - EE[Y])] \
               & = "Var"(X) + "Var"(Y) + 2 "Cov"(X, Y).
$
By bilinearity, $"Var"(sum_(i=1)^n X_i) = sum_(i=1)^n "Var"(X_i) + sum_(i != j) "Cov"(X_i, X_j)$.
