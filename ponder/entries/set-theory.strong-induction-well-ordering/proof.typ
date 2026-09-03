Assume $P(n)$ holds for $n in A subset.eq NN$ with $A != emptyset$, and suppose, for contradiction, that there is no least $n in NN$ such that $P(n)$ holds. Consider $Q(n) = not P(n)$.

Certainly $P(1)$ is false, because otherwise $1$ would be our minimal element; so $Q(1)$ holds. Now, given $n in NN$, suppose $Q(k)$ is true for all $k < n$. Then $P(k)$ must be false for all $k < n$, and so $P(n)$ must also be false — otherwise $n$ would be our minimal element. Hence $Q(n)$ holds.

Hence by SPI, $Q(n)$ holds for all $n in NN$, and $P(n)$ is false for all $n in NN$, contradicting the assumption that $P(n)$ holds for some $n$.
