Assume additionally $sigma^2 = "Var"(X_1) < oo$. For $epsilon > 0$,
$
  PP(abs(S_n \/ n - mu) > epsilon) = PP(abs(S_n - n mu) > n epsilon) <= EE[abs(S_n - n mu)^2]/(n^2 epsilon^2) = ("Var"(S_n))/(n^2 epsilon^2),
$
where the inequality is #ponder("probability.chebyshevs-inequality")[Chebyshev's]. Since the summands are independent, $"Var"(S_n) = n sigma^2$, so
$
  PP(abs(S_n \/ n - mu) > epsilon) <= (sigma^2)/(n epsilon^2) -> 0 quad "as" n -> oo,
$
which is exactly $S_n \/ n -> mu$ in #ponder("probability.convergence-in-probability")[probability].
