Suppose $f: X subset.eq CC -> CC$ has a limit at $a$, where $a$ is an accumulation point of $X$. The limit is unique: if $f(z) -> y$ and $f(z) -> x$ as $z -> a$, then

$
  abs(x-y) = abs(x - f(z) + f(z) - y) <= abs(x - f(z)) + abs(f(z) - y).
$

The left side does not depend on $z$ while the right side does, so taking the limit $z -> a$ gives $abs(x-y) <= 0 + 0 = 0$, hence $x = y$.

The definition only constrains points with $0 < |z - a| < delta$, so it applies even when $a in.not X$: what matters is that $a$ is an accumulation point of $X$, so that points of the domain arbitrarily close to $a$ are available.

