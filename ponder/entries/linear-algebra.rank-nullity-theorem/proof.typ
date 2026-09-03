Let $n = dim V$ and $m = null T$; since $dim (ker T) <= dim V$, we have $m <= n$.

If $m = n$, then $ker T = V$, so $T$ is the zero map, $im T = {bold(0)}$ and $rank T = 0$. Therefore $dim V = n = 0 + n = rank T + null T$.

If $m < n$, let ${bold(e_1), ..., bold(e_m)} subset.eq V$ be a basis of $ker T$, so that $T(bold(e_i)) = bold(0)$ for all $i$. Extend it to a basis ${bold(e_1), ..., bold(e_m), bold(e_(m+1)), ..., bold(e_n)}$ of $V$; it suffices to show that ${T(bold(e_(m+1))), ..., T(bold(e_n))}$ is a basis of $im T$.

- *Spanning.* For $y in im T$, pick $bold(x) in V$ with $T(bold(x)) = y$ and write $bold(x) = sum_(i=1)^n alpha_i bold(e_i)$. By linearity,
  $
    y = T(bold(x)) = sum_(i=1)^n alpha_i T(bold(e_i)) = sum_(i=m+1)^n alpha_i T(bold(e_i)),
  $
  so $y$ lies in the span of the images.

- *Linear independence.* Suppose $sum_(i=m+1)^n alpha_i T(bold(e_i)) = bold(0)$. By linearity, $T(bold(x)) = bold(0)$ for $bold(x) = sum_(i=m+1)^n alpha_i bold(e_i)$, so $bold(x) in ker T$. Writing $bold(x) = sum_(i=1)^m beta_i bold(e_i)$ and comparing with the unique representation of $bold(x)$ in the basis of $V$ gives $alpha_(m+1) = ... = alpha_n = 0$.
