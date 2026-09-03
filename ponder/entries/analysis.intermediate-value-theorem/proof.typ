If $f$ is constant, or $y = f(a)$ or $y = f(b)$, the claim is immediate. Otherwise assume WLOG $f(a) < y < f(b)$ and let $S = {x in [a, b]: f(x) <= y}$. Then $a in S$, so $S$ is non-empty, and $S$ is bounded above by $b$, so $d = sup S$ exists in $[a, b]$.

- If $f(d) > y$, set $epsilon = f(d) - y > 0$. By continuity of $f$ there is $delta = delta(epsilon) > 0$ such that $abs(x - d) < delta$ with $x in [a, b]$ gives $abs(f(x) - f(d)) < epsilon$, so $f(x) > y$ and $x in.not S$. Thus $(d - delta, d) inter S = emptyset$, contradicting the definition of $d$ as the least upper bound of $S$.

- If $f(d) < y$, set $epsilon = y - f(d) > 0$. The same continuity argument gives $abs(x - d) < delta => f(x) < y$, so in particular $f(d + delta/2) < y$ and hence $d <= d + delta/2 in S$, again contradicting the choice of $d$.

Therefore $f(d) = y$.
