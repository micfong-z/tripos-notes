- Both $sum (1)/(n)$ (divergent) and $sum (1)/(n^2)$ (convergent) have ratio limit $1$, so the test is inconclusive for both.

- $sum (n)/(2^n)$ converges, since
$
  lim_(n->oo) ((n+1)/(2^(n+1))) / (n/(2^n)) = lim_(n->oo) (n+1)/(2n) = (1)/(2) < 1.
$
The same conclusion follows from the root test, because $((n)/(2^n))^((1)/(n)) = n^((1)/(n)) \/ 2 -> (1)/(2)$, where $n^((1)/(n)) = ee^((log n)/n) -> 1$ by L'Hospital's rule.

If the ratio test is inconclusive then so is the root test, but not conversely: for
$
  a_n = cases(
    2^(-n) quad & n "even",
    2^(-(n+1)) quad & n "odd"
  )
$
the ratio limit does not exist while the root limit equals $(1)/(2)$.
