If $Y subset.eq X$ and $X$ is countable, take the injection $X -> NN$ restricted to $Y$.

In particular any subset $S subset.eq NN$ is countable: by the well-ordering principle there is a least element $s_1 in S$; remove it and repeat to list $s_1, s_2, s_3, ...$. If the process terminates, $S$ is finite and so countable. Otherwise the map $g: NN -> S$ with $n |-> s_n$ is well-defined and injective, and it is also surjective, because every $k in S$ has fewer than $k$ elements of $S$ below it, so $k = s_n$ for some $n$. Thus $g$ is a bijection and $S$ is countably infinite.
