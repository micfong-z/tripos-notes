Suppose SPI holds and that $P(1)$ holds with $forall n in NN$, $P(n) => P(n+1)$. Iterating: $P(1)$ holds, then $P(1) and P(2)$ holds, and continuing this way $P(1) and P(2) and ... and P(n)$ holds for every $n in NN$. SPI's conclusion then gives $P(n)$ for all $n in NN$, so WPI holds.

Conversely, suppose WPI holds, and let $P$ satisfy SPI's two assumptions. Define a new predicate $Q(n)$ as "$P(k)$ holds for all $k < n$". Applying WPI to $Q(n)$ shows that $Q(n)$ holds for all $n in NN$, which implies that $P(n)$ holds for all $n in NN$. So SPI holds.
