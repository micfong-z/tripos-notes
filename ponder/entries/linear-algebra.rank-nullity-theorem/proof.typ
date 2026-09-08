Let $n = dim V$ and $m = null T$; since $dim (ker T) <= dim V$, we have $m <= n$.

If $m = n$, then $ker T = V$, so $T$ is the zero map, $im T = {vb(0)}$ and $rank T = 0$. Therefore $dim V = n = 0 + n = rank T + null T$.

If $m < n$, let ${vb(e_1), ..., vb(e_m)} subset.eq V$ be a basis of $ker T$, so that $T(vb(e_i)) = vb(0)$ for all $i$. Extend it to a basis ${vb(e_1), ..., vb(e_m), vb(e_(m+1)), ..., vb(e_n)}$ of $V$; it suffices to show that ${T(vb(e_(m+1))), ..., T(vb(e_n))}$ is a basis of $im T$.

- *Spanning.* For $y in im T$, pick $vb(x) in V$ with $T(vb(x)) = y$ and write $vb(x) = sum_(i=1)^n alpha_i vb(e_i)$. By linearity,
  $
    y = T(vb(x)) = sum_(i=1)^n alpha_i T(vb(e_i)) = sum_(i=m+1)^n alpha_i T(vb(e_i)),
  $
  so $y$ lies in the span of the images.

- *Linear independence.* Suppose $sum_(i=m+1)^n alpha_i T(vb(e_i)) = vb(0)$. By linearity, $T(vb(x)) = vb(0)$ for $vb(x) = sum_(i=m+1)^n alpha_i vb(e_i)$, so $vb(x) in ker T$. Writing $vb(x) = sum_(i=1)^m beta_i vb(e_i)$ and comparing with the unique representation of $vb(x)$ in the basis of $V$ gives $alpha_(m+1) = ... = alpha_n = 0$.
