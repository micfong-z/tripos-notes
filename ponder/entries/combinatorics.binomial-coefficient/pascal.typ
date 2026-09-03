Moreover,
$ binom(n, k) = binom(n - 1, k - 1) + binom(n - 1, k) quad forall n in ZZ^+, 1 <= k <= n - 1. $

Committee counting explains the rule. To form a committee from a group of $n$ people, either you are in the committee — in which case the remaining $k - 1$ members come from the other $n - 1$ people — or you are not, in which case all $k$ members come from the other $n - 1$. For instance, $binom(8, 3) = binom(7, 2) + binom(7, 3)$.

Iterating the rule builds Pascal's triangle, where each row starts and ends with a $1$, and the remaining entries are the sum of the $2$ terms immediately above.
