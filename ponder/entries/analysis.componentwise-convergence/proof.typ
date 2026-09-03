For $z in CC$, $abs(z) = sqrt(re(z)^2 + im(z)^2)$. If $x_n -> x$ then $abs(re x_n - re x) <= abs(x_n - x)$ and $abs(im x_n - im x) <= abs(x_n - x)$, so both parts converge to the corresponding part of $x$.

Conversely, $abs(z) <= abs(re z) + abs(im z)$, so fixing $epsilon > 0$ and taking $N = max{N_1, N_2}$ with $abs(re x_n - re x) < epsilon$ and $abs(im x_n - im x) < epsilon$ for $n >= N_1, n >= N_2$ respectively gives $abs(x_n - x) <= 2 epsilon$ for all $n >= N$. Since $epsilon$ is arbitrary and can be replaced by $epsilon \/ 2$, the sequence converges.

The Cauchy statement is proved by the same two inequalities applied to $x_n - x_m$ in place of $x_n - x$.
