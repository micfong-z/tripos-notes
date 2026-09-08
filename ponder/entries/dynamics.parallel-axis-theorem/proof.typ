Express all positions relative to the centre of mass. Choose an origin on the parallel axis, and let $vb(x_i)$ be the position of particle $i$ relative to this origin. Then
$
  vb(x_i) = vb(R) + vb(y_i),
$
where $vb(R)$ is the position of the centre of mass, and $vb(y_i)$ is the position of particle $i$ relative to the centre of mass, so
$
  sum_i m_i vb(y_i) = vb(0).
$
Then
$
  I & = sum_i m_i underbracket((vu(n) times vb(x_i))^2, d_i^2) \
    & = sum_i m_i [vu(n) times [vb(R) + vb(y_i)]]^2 \
    &= sum_i m_i [(vu(n) times vb(R))^2 + 2 (vu(n) times vb(R)) dot (hat(n) times vb(y_i)) + (vu(n) times vb(y_i))^2].
$
Since $sum_i m_i vb(y_i) = vb(0)$, the middle term vanishes, and
$
  I = M h^2 + I_"CoM",
$
noting that $h = abs(vu(n) times vb(R))$ and $I_"CoM" = sum_i m_i (vu(n) times vb(y_i))^2$.
