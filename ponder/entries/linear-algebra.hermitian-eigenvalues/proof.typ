1. For an eigenvector $matbold(v)$ with eigenvalue $lambda$, Hermiticity gives $(matbold(A) vb(v))^dagger vb(v) = vb(v)^dagger (matbold(A) vb(v))$, hence $lambda vb(v)^dagger vb(v) = overline(lambda) vb(v)^dagger vb(v)$. Since $vb(v) != vb(0)$, $lambda = overline(lambda)$ and $lambda in RR$.

2. Let $vb(v), vb(w)$ be eigenvectors with eigenvalues $lambda, mu$. Then $mu vb(v)^dagger vb(w) = vb(v)^dagger (matbold(A) vb(w)) = (matbold(A) vb(v))^dagger vb(w) = lambda vb(v)^dagger vb(w)$, where part (1) makes both eigenvalues real. Since $lambda != mu$, $vb(v)^dagger vb(w) = 0$.

3. For real symmetric $matbold(A)$ with real $lambda$, write $vb(v) = vb(u) + ii vb(u')$ with $vb(u), vb(u') in RR^n$. Then $matbold(A) vb(u) = lambda vb(u)$ and $matbold(A) vb(u') = lambda vb(u')$ separately. At least one of $vb(u), vb(u')$ is non-zero because $vb(v)$ is an eigenvector, and that vector is a real eigenvector.
