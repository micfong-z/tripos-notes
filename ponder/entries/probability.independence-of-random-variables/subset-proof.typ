Suppose $X_1, X_2, X_3$ are independent. To show $X_1$ is independent of $X_2$, check that for all $x_1, x_2$,
$
  PP(X_1 = x_1, X_2 = x_2) & = sum_(x_3) PP(X_1 = x_1, X_2 = x_2, X_3 = x_3) \
                           & = sum_(x_3) PP(X_1 = x_1) PP(X_2 = x_2) PP(X_3 = x_3) \
                           & = PP(X_1 = x_1) PP(X_2 = x_2) underbracket(sum_(x_3) PP(X_3 = x_3), 1).
$
The same argument applies to any subcollection.
