Assume additionally $E[X_1^4] < oo$ and set $Y_i = X_i - mu$, so $EE[Y_i] = 0$. Since $sum_(n=1)^oo (S_n \/ n)^4 < oo$ forces $S_n \/ n -> 0$ almost surely, it suffices to show $EE[sum_(n=1)^oo (S_n \/ n)^4] < oo$.

Expanding $(Y_1 + ... + Y_n)^4$, all terms containing a factor $Y_i$ to the first power vanish in expectation by #ponder("probability.independence-of-random-variables")[independence] and $EE[Y_i] = 0$, while $EE[Y_i^2 Y_j^2] = (EE[Y_i^2])^2 <= EE[Y_i^4] < oo$. Hence
$
  EE[S_n^4] = n EE[Y_1^4] + (6 n (n - 1))/2 EE[Y_1^4] <= 3 n^2 EE[Y_1^4].
$
Therefore
$
  sum_(n=1)^oo (EE[S_n^4])/(n^4) <= sum_(n=1)^oo (3 EE[Y_1^4])/(n^2) < oo,
$
so $PP(sum_(n=1)^oo (S_n \/ n)^4 < oo) = 1$ and $S_n \/ n -> 0$ #ponder("probability.convergence-almost-surely")[almost surely], that is, $S_n \/ n -> mu$.
