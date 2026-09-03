Let $x in S_1 union S_2 union ... union S_n$, say $x in S_i$ for $k$ of the sets $S_i$. We want $x$ to be counted exactly once in the RHS.

Indeed, for $A subset.eq {1, 2, ..., n}$ with $abs(A) = r$, the intersections $inter.big_(i in A) S_i$ containing $x$ correspond to choosing $r$ of the $k$ sets that contain $x$, giving $binom(k, r)$ of them when $r <= k$ and $0$ otherwise. Thus the number of times $x$ is counted on the RHS is
$ k - binom(k, 2) + binom(k, 3) - binom(k, 4) + ... + (-1)^(k+1) binom(k, k) = 1 - (1-1)^k = 1 quad "for" k >= 1. $
