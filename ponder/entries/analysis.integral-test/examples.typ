- $sum (1)/(n^p)$ converges if and only if $p > 1$: with $f(t) = t^(-p)$,
$
  integral_1^x (1)/(t^p) dif t = cases(
    ((1-p)x^(-p) + "constant") quad & p != 1,
    log x quad & p = 1
  )
$
which has a finite limit exactly for $p > 1$. This also explains the divergence of the harmonic series ($p = 1$).

- $sum (1)/(n log n)$ diverges, since $integral 1/(t log t) dif t = log(log t) + C$ under the substitution $u = log t$.

- $sum (1)/(n log^2 n)$ converges, since $integral 1/(t log^2 t) dif t = -(1)/(log t) + C$ under the same substitution.
