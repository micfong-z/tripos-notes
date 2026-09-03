A sequence on $CC$ is Cauchy or convergent exactly when its real and imaginary parts are, so it suffices to prove the theorem for real sequences.

A Cauchy sequence $(x_n)$ is bounded. By Bolzano-Weierstrass it has a convergent subsequence $(x_(n_k))$ with limit $x in RR$. For $epsilon > 0$, choose $N_1$ with $abs(x_n - x_m) < epsilon$ for all $m, n >= N_1$ and $N_2$ with $abs(x_(n_k) - x) < epsilon$ for all $k >= N_2$. Picking $k >= N_2$ with $n_k >= N_1$ gives
$
  abs(x_n - x) <= abs(x_n - x_(n_k)) + abs(x_(n_k) - x) < 2 epsilon quad forall n >= N_1,
$
so $x_n -> x$.
