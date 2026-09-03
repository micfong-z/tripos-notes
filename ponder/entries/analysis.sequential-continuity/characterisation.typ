$f$ is continuous at $a in X$ if and only if $f$ is sequentially continuous at $a$.

- If $f$ is continuous at $a$, then for $(z_n)$ on $X$ with $z_n -> a$ and $epsilon > 0$, pick $delta = delta(epsilon)$ from continuity and then $N = N(epsilon)$ with $abs(z_n - a) < delta$ for all $n >= N$; hence $abs(f(z_n) - f(a)) < epsilon$ for all $n >= N$, so $f(z_n) -> f(a)$.

- Conversely, if $f$ is not continuous at $a$, then some $epsilon > 0$ admits, for every $delta > 0$, a point $z in X$ with $abs(z - a) < delta$ but $abs(f(z) - f(a)) >= epsilon$. Taking $delta = 1/n$ builds $(z_n)$ with $abs(z_n - a) < 1/n -> 0$, so $z_n -> a$, while $f(z_n)$ stays at least $epsilon$ away from $f(a)$ and does not converge to it — contradicting sequential continuity.
