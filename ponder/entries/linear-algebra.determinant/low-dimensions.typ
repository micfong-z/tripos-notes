In $RR^2$ with $matbold(M) = mat(M_(11), M_(12); M_(21), M_(22))$, let $matbold(tilde(M)) = mat(M_(22), -M_(12); -M_(21), M_(11))$. Then
$
  vb(x') = matbold(M) vb(x)
  quad => quad
  matbold(tilde(M)) vb(x') = matbold(M) matbold(tilde(M)) vb(x) = det(matbold(M)) vb(x),
$
with $det matbold(M) = M_(11) M_(22) - M_(12) M_(21)$ and $det matbold(M) = [matbold(M) vb(e_1), matbold(M) vb(e_2)]$. Therefore, if $det matbold(M) != 0$, then $matbold(M^(-1)) = (1)/(det matbold(M)) matbold(tilde(M))$.

In $RR^3$, one seeks a matrix $matbold(tilde(M))$ and a scalar $det matbold(M)$ such that $matbold(tilde(M)) matbold(M) = (det matbold(M)) matbold(I)$. Under the action of $matbold(M)$, volumes are scaled by the factor
$
  det matbold(M) &= [vb(C_1)(matbold(M)), vb(C_2)(matbold(M)), vb(C_3)(matbold(M))] \
                 &= epsilon_(i j k) M_(i 1) M_(j 2) M_(k 3),
$
the scalar triple product of the columns. General $3 times 3$ determinants expand in terms of $2 times 2$ determinants:
$
  det matbold(M) = M_(11) mdet(M_(22), M_(23); M_(32), M_(33)) - M_(12) mdet(M_(21), M_(23); M_(31), M_(33)) + M_(13) mdet(M_(21), M_(22); M_(31), M_(32)).
$
