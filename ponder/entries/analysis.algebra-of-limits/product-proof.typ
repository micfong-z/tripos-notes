Splitting $abs(x_n y_n - x y) = abs(x_n y_n - x y_n + x y_n - x y) <= abs(x) abs(y_n - y) + abs(y_n) abs(x - x_n)$ reduces the claim to the two component convergences.

Since $x_n -> x$ and $y_n -> y$, for a given $epsilon > 0$ there are $N_1$ and $N_2$ with $abs(x_n - x) < epsilon$ for all $n >= N_1$ and $abs(y_n - y) < epsilon$ for all $n >= N_2$. The sequence $(y_n)$ is bounded, so $abs(y_n) <= M$ for some $M > 0$, giving
$
  abs(x_n y_n - x y) <= epsilon (abs(x) + abs(y_n)) <= epsilon (abs(x) + M)
$
for all $n >= max{N_1, N_2}$. As the threshold can be rescaled, $x_n y_n -> x y$. The sum and reciprocal parts are exercises in the same style.
