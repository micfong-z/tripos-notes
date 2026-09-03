Friction damps small oscillations about an equilibrium point, where linear drag dominates. In a 1D system,
$
  dot.double(x) = -omega_0^2 x - 2 alpha dot(x),
$
where $omega_0$ is the natural frequency of oscillations without friction and $alpha$ is the damping coefficient. Solving,
$
  x = ee^(-alpha t) [A_+ ee^(ii Omega t) + A_- ee^(-ii Omega t)], quad Omega = sqrt(omega_0^2 - alpha^2),
$
and taking the real part gives the damped oscillations. The three cases are:

- $omega_0^2 > alpha^2$: underdamped, decaying oscillations.

- $omega_0^2 < alpha^2$: overdamped, exponential decay.

- $omega_0^2 = alpha^2$: critical damping, $x = (A + B t) ee^(-alpha t)$.
