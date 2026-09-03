For any integer $x$,
$
  x = sum_(k=1)^(oo) bb(1)(x >= k) = sum_(k=0)^(oo) bb(1)(x > k).
$
Applying this to $X(omega)$ pointwise and using the countable additivity of expectation for non-negative summands,
$
  EE[X] & = EE[sum_(k=1)^(oo) bb(1)(X >= k)] = EE[sum_(k=0)^(oo) bb(1)(X > k)] \
        & = sum_(k=1)^(oo) EE[bb(1)(X >= k)] = sum_(k=0)^(oo) EE[bb(1)(X > k)] \
        & = sum_(k=1)^(oo) PP(X >= k) = sum_(k=0)^(oo) PP(X > k).
$
