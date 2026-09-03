First suppose $EE[X] < oo$. For $0 < z < 1$,
$
  p'(z) = sum_(r=1)^oo r p_r z^(r-1) <= sum_(r=1)^oo r p_r = EE[X],
$
so $p'(z)$ is increasing in $z$ and bounded above by $EE[X]$, giving $lim_(z-> 1^-) p'(z) <= EE[X]$. Conversely, for $epsilon > 0$ choose $N$ with $sum_(r=1)^N r p_r >= EE[X] - epsilon$; then
$
  lim_(z-> 1^-) p'(z) & >= lim_(z-> 1^-) sum_(r=1)^N r p_r z^(r-1) = sum_(r=1)^N r p_r >= EE[X] - epsilon,
$
and since $epsilon$ is arbitrary the two bounds agree.

If $EE[X] = oo$, then for every $M > 0$ there is an $N$ with $sum_(r=1)^N r p_r >= M$, and the same partial-sum bound gives $lim_(z-> 1^-) p'(z) >= M$, so $lim_(z-> 1^-) p'(z) = oo$.
