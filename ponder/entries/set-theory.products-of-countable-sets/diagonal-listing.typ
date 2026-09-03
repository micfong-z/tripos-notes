List the pairs $(p, q)$ along the diagonals of the grid:
$
  (1, 1), (1, 2), (2, 1), (1, 3), (2, 2), (3, 1), (1, 4), (2, 3), (3, 2), (4, 1), ...
$
Formally, let $a_1 = (1, 1)$ and, writing $a_(n-1) = (p, q)$,
$
  a_n = cases(
    (p-1, q+1) & quad p > 1,
    (q+1, 1) & quad p = 1
  )
$
which produces a well-defined sequence $(a_n)_(n=1)^oo$ listing every pair. Then $f(n) = a_n$ is a surjection $NN -> NN times NN$.
