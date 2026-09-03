For a disjoint sequence $(A_n)$ in $cal(F)$ and $B in cal(F)$ with $PP(B) > 0$,
$
  PP(union.big_n A_n mid(|) B) & = PP((union.big_n A_n) inter B) \/ PP(B) \
                               & = PP(union.big_n (A_n inter B)) \/ PP(B) \
                               & = (sum_n PP(A_n inter B)) \/ PP(B) \
                               & = sum_n PP(A_n mid(|) B),
$
using countable additivity of $PP$.
