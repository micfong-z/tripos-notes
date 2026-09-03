Since $q_(n+1) = G(q_n)$ and $G$ is continuous with $q_n -> q$, letting $n -> oo$ gives $q = G(q)$.

For $q_(n+1) = G(q_n)$ directly: $q_(n+1) = PP(X_(n+1) = 0) = G_(n+1) (0) = G(G_n (0)) = G(q_n)$.

Alternatively, conditioning on $X_1 = m$ and writing $X_n^((1)), ..., X_n^((m))$ for independent copies of the process started from one individual,
$
  q_(n+1) & = PP(X_(n+1) = 0) \
          & = sum_m PP(X_(n+1) = 0 mid(|) X_1 = m) PP(X_1 = m) \
          & = sum_m PP(sum_(i=1)^m X_n^((i)) = 0 mid(|) X_1 = m) PP(X_1 = m) \
          & = sum_m PP(X_n^((1)) = ... = X_n^((m)) = 0) PP(X_1 = m) \
          & = sum_m (q_n)^m PP(X_1 = m) \
          & = G(q_n).
$
