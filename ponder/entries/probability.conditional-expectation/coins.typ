Toss a $p$-coin $n$ times independently, let $X_i = bb(1)(i"-th toss is H")$ and $Y_n = X_1 + ... + X_n$. Two computations give $EE[X_1 mid(|) Y_n] = Y_n / n$.

Directly,
$
  g(y) & = EE[X_1 mid(|) Y_n = y] \
       & = EE[X_1 dot bb(1)(Y_n = y)] / PP(Y_n = y) \
       & = PP(X_1 = 1, Y_n = y) / PP(Y_n = y) \
       & = p dot (binom(n-1, y-1) p^(y-1) (1-p)^(n-y)) / (binom(n, y) p^y (1-p)^(n-y)) \
       & = y / n.
$
Or by symmetry: since all $EE[X_i mid(|) Y_n]$ are equal,
$
  Y_n = EE[Y_n mid(|) Y_n] = EE[X_1 + ... + X_n mid(|) Y_n] = sum_(i=1)^n EE[X_i mid(|) Y_n] = n EE[X_1 mid(|) Y_n],
$
so again $EE[X_1 mid(|) Y_n] = Y_n / n$.
