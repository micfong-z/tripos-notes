Split the sum over the partition:
$
  EE[X] & = sum_(omega in Omega) X(omega) PP({omega}) \
        & = sum_n sum_(omega in Omega_n) X(omega) PP({omega}) \
        & = sum_n EE[X dot bb(1)(Omega_n)] \
        & = sum_n EE[X mid(|) Omega_n] PP(Omega_n).
$
The last line uses $EE[X mid(|) Omega_n] = EE[X bb(1)(Omega_n)] / PP(Omega_n)$.
