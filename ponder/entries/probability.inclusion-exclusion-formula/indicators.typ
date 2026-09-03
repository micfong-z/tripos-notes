Indicator algebra reduces the formula to expanding a product. For two events,
$
  bb(1)(A^cp) & = 1-1(A) \
  bb(1)(A inter B) & = bb(1)(A) dot bb(1)(B) \
  bb(1)(A union B) & = 1 - bb(1)(A^cp inter B^cp) = 1 - (1 - bb(1)(A)) dot (1 - bb(1)(B)).
$
More generally, for events $A_1, ..., A_n$,
$
  bb(1)(A_1 union ... union A_n) & = 1 - bb(1)(A_1^cp inter ... inter A_n^cp) \
  & = 1 - product_(i=1)^n (1 - bb(1)(A_i))\
  &= sum_(i-1)^n bb(1)(A_i) - sum_(1 <= i < j <= n) bb(1)(A_i) dot bb(1)(A_j) + ... + (-1)^(n-1) bb(1)(A_1) dot ... dot bb(1)(A_n).
$
Taking expectation and using $EE[bb(1)(A)] = PP(A)$ term by term yields
$
  PP(A_1 union ... union A_n) & = sum_(i-1)^n PP(A_i) - sum_(1 <= i < j <= n) PP(A_i inter A_j) + ... + (-1)^(n-1) PP(A_1 inter ... inter A_n). \
$
