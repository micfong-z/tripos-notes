Write $I_L = [a, c]$, $I_R = [c, b]$, $f_L = eval(f)_(I_L)$ and $f_R = eval(f)_(I_R)$.

Suppose $f$ is integrable and let $epsilon > 0$. There is a partition $cal(P)$ of $[a, b]$ with $U(f, cal(P)) - L(f, cal(P)) < epsilon$; WLOG $c = x_ell$ for some $ell$ (otherwise add $c$ to $cal(P)$, which can only make the gap smaller). Then $cal(P) = cal(P)_L union cal(P)_R$ with $cal(P)_L = {x_0, ..., x_ell}$ and $cal(P)_R = {x_ell, ..., x_n}$ partitions of $[a, c]$ and $[c, b]$, and

$
  U(f, cal(P)) = U(f_L, cal(P)_L) + U(f_R, cal(P)_R), quad L(f, cal(P)) = L(f_L, cal(P)_L) + L(f_R, cal(P)_R).
$

Hence

$
  underbracket(U(f_L, cal(P)_L) - L(f_L, cal(P)_L), >=0) + underbracket(U(f_R, cal(P)_R) - L(f_R, cal(P)_R), >=0) < epsilon,
$

so both restrictions are integrable.

Conversely, given partitions of $I_L$ and $I_R$ whose gaps are each $< epsilon$, the same equalities give $U(f, cal(P)) - L(f, cal(P)) < 2 epsilon$ with $cal(P) = cal(P)_L union cal(P)_R$, so $f$ is integrable on $[a, b]$. Finally,

$
  integral_a^b f & >= L(f_L, cal(P)_L) + L(f_R, cal(P)_R) >= integral_a^c f_L + integral_c^b f_R - 2 epsilon, \
  integral_a^b f & <= integral_a^c f_L + integral_c^b f_R + 2 epsilon,
$

and since $epsilon$ is arbitrary, $abs(integral_a^b f - (integral_a^c f_L + integral_c^b f_R)) < 2 epsilon$ forces equality.
