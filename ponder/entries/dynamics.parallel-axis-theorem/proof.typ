Express all positions relative to the centre of mass. Choose an origin on the parallel axis, and let $bold(x_i)$ be the position of particle $i$ relative to this origin. Then
$
  bold(x_i) = bold(R) + bold(y_i),
$
where $bold(R)$ is the position of the centre of mass, and $bold(y_i)$ is the position of particle $i$ relative to the centre of mass, so
$
  sum_i m_i bold(y_i) = bold(0).
$
Then
$
  I & = sum_i m_i underbracket((bold(hat(n)) times bold(x_i))^2, d_i^2) \
    & = sum_i m_i [bold(hat(n)) times [bold(R + bold(y_i))]]^2 \
    &= sum_i m_i [(bold(hat(n)) times bold(R))^2 + 2 (bold(hat(n)) times bold(R)) dot (hat(n) times bold(y_i)) + (bold(hat(n)) times bold(y_i))^2].
$
Since $sum_i m_i bold(y_i) = bold(0)$, the middle term vanishes, and
$
  I = M h^2 + I_"CoM",
$
noting that $h = abs(bold(hat(n)) times bold(R))$ and $I_"CoM" = sum_i m_i (bold(hat(n)) times bold(y_i))^2$.
