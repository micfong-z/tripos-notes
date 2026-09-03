Conditioning on the value of $N$,
$
  r(z) = EE[z^(S_N)] & = sum_(n=0)^oo EE[z^(S_n) dot bb(1)(N=n)] \
                     & = sum_(n=0)^oo EE[z^(X_1 + ... + X_n) dot bb(1)(N=n)] \
                     & = sum_(n=0)^oo EE[z^(X_1) z^(X_2) ... z^(X_n)] dot PP(N=n) \
                     & = sum_(n=0)^oo (EE[z^(X_1)])^n dot PP(N=n) \
                     & = sum_(n=0)^oo (p(z))^n dot PP(N=n) \
                     & = q(p(z)) quad "by definition of PGF".
$
Equivalently, with the tower property,
$
  r(z) = EE[z^(S_N)] = EE[EE[z^(S_N) mid(|) N]],
$
and independence of $S_n$ from $N$ gives $EE[z^(S_N) mid(|) N=n] = (p(z))^n$, so $EE[z^(S_N) mid(|) N] = (p(z))^N$ and $r(z) = EE[(p(z))^N] = q(p(z))$.
