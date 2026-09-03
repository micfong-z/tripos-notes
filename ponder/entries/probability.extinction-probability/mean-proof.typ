By induction: $EE[X_0] = 1 = (EE[X_1])^0$, and assuming $EE[X_n] = (EE[X_1])^n$,
$
  EE[X_(n+1) mid(|)X_n = m] & = EE[Y_(1, n) + ... + Y_(m, n) mid(|) X_n = m] \
                            & = EE[Y_(1, n) + ... + Y_(m, n)] quad "by independence" \
                            & = m EE[X_1],
$
so $EE[X_(n+1) mid(|) X_n] = X_n EE[X_1]$ and taking expectation gives $EE[X_(n+1)] = EE[X_n] EE[X_1] = (EE[X_1])^(n+1)$.
