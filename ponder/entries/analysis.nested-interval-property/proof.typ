Nesting gives $a_n <= a_(n+1)$ and $b_n >= b_(n+1)$, with $a_1 <= a_n <= b_n <= b_1$ throughout. So $(a_n)$ is increasing and bounded above by $b_1$, and $(b_n)$ is decreasing and bounded below by $a_1$; both converge. Let $a = lim a_n in RR$ and $b = lim b_n in RR$. Since limits preserve inequalities, $a <= b$.

Existence: for all $k >= n$, $a_k in [a_k, b_k] subset.eq [a_n, b_n]$, so $a_n <= a_k <= b_n$; letting $k -> oo$ gives $a_n <= a <= b_n$ for every fixed $n$. Hence $a in inter.big_(n in NN) I_n$.

Uniqueness: $b_n - a_n -> b - a$ by construction, while $b_n - a_n = abs(I_n) -> 0$; since limits are unique, $b - a = 0$, so the intersection is the single point $x = a = b$: indeed $x in inter_n I_n$ means $a_n <= x <= b_n$ for all $n$, which forces $x = a$.
