The integrability proof: given $epsilon > 0$, pick $N in NN$ with $N > (1)/(epsilon)$ and set

$
  X_N & = {x in [0, 1]: f(x) >= (1)/(N)} \
      & subset.eq {(p)/(q): 1 <= q <= N, 0 <= p <= q} \
      & = {y_1, ..., y_M}
$

for some finite $M$. Choose a partition in which each $y_k$ lies in a subinterval of length $< (epsilon)/(M)$, giving the bad points little weight. Then

$
  U(f, cal(P)) &<= M dot (epsilon)/(M) + (1)/(N) dot 1 < 2 epsilon,
$

while always $L(f, cal(P)) = 0$.

Compared with the Dirichlet function, the values of the Thomae function at its bad points decay to $0$: both functions have infinitely many discontinuities, but their integrability properties are fundamentally different.
