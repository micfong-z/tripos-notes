*$(2) => (1)$.* An injection $g: X -> NN$ bijects $X$ with its image $g(X) subset.eq NN$. Any subset of $NN$ is countable, so $X$ is countable.

*$(1) => (3)$.* This is clear if $X = emptyset$. If $X$ is countably infinite, take a bijection $f: X -> NN$; its inverse $f^(-1): NN -> X$ is a surjection.

*$(3) => (2)$.* Suppose $X != emptyset$ and let $f: NN -> X$ be a surjection. Define $h: X -> NN$ by
$ h(x) = min({n in NN : f(n) = x}). $
which is well-defined since $f$ is surjective. If $h(x_1) = h(x_2)$ then
$ f(h(x_1)) = x_1 quad "and" quad f(h(x_2)) = x_2, $
so $x_1 = x_2$; hence $h$ is an injection.
