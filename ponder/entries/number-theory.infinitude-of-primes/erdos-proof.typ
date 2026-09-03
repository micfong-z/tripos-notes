Let $p_1, p_2, ..., p_k$ be all the primes. Since any number is uniquely expressed as a product of primes, consider numbers of the form $p_1^(j_1) p_2^(j_2) ... p_k^(j_k)$ with $j_i >= 0$; each can be rewritten as
$ p_1^(j_1) p_2^(j_2) ... p_k^(j_k) = m^2 times p_1^(i_1) p_2^(i_2) ... p_k^(i_k) $
where $i_i in {0, 1}$ for all $1 <= i <= k$, and $m$ is some integer.

Given $N in NN$, a number less than or equal to $N$ of this form has $m <= sqrt(N)$, so there are at most $sqrt(N) 2^k$ such numbers. If $N > sqrt(N) 2^k$, that is $N > 4^k$, some number less than or equal to $N$ is not of this form, and it must have a prime factor outside the list $p_1, p_2, ..., p_k$ — a contradiction.

Euclid's proof bounds the $k$th prime by $2^(2^k)$, while this argument gives $4^k$. In fact the $k$th prime is approximately $k log k$ for large $k$: the prime number theorem.
