Suppose the criterion holds. For every $epsilon > 0$,

$
  0 <= I^* (f) - I_* (f) <= U(f, cal(P)) - L(f, cal(P)) < epsilon,
$

so $I^* (f) = I_* (f)$ and $f$ is integrable.

Conversely, suppose $I^*(f) = I_*(f)$. From the definition of $sup$ and $inf$, there are partitions $cal(P), cal(P')$ with

$
   U(f, cal(P)) & <= I^*(f) + epsilon / 2 \
  L(f, cal(P')) & >= I_*(f) - epsilon / 2.
$

Since $I^*(f) = I_*(f)$, $U(f, cal(P)) - L(f, cal(P')) <= epsilon$. Take $cal(P'') = cal(P) union cal(P')$; refining can only shrink the gap, so

$
  U(f, cal(P'')) - L(f, cal(P'')) <= U(f, cal(P)) - L(f, cal(P')) <= epsilon.
$
