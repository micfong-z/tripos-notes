Since $n_k < n_(k+1)$ implies $n_(k+1) >= n_k + 1$, induction gives $n_k >= k$ for all $k$.

Given $epsilon > 0$, take $N = N(epsilon)$ with $abs(x_n - x) < epsilon$ for all $n >= N$. Then $k >= N$ forces $n_k >= k >= N$, so $abs(x_(n_k) - x) < epsilon$. Hence $lim_(k->oo) x_(n_k) = x$: every subsequence of a convergent sequence converges to the same limit.

Consequently, a sequence whose odd and even subsequences both converge to the same limit $s$ itself converges to $s$: for $n >= max{2 N_1, 2 N_2 + 1}$, whichever parity $n$ has, the corresponding estimate $abs(x_n - s) < epsilon$ applies.
