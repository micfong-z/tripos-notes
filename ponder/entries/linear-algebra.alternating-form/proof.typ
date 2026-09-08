If the vectors are linearly dependent, then one of them can be written as a linear combination of the others, so the alternating form vanishes by multilinearity and antisymmetry.

Conversely, suppose $vb(v_1), ..., vb(v_n)$ are linearly independent. Then they span $RR^n$ or $CC^n$, so for some matrix $matbold(U)$ we can write $vb(e_j) = U_(i j) vb(v_i)$. Hence, using antisymmetry,
$
  [vb(e_1), ..., vb(e_n)] &= U_(i_1 1) U_(i_2 2) ... U_(i_n n) [vb(v_(i_1)), ..., vb(v_(i_n))] \
                             &= U_(i_1 1) ... U_(i_n n) epsilon_(i_1 i_2 ... i_n) [vb(v_1), ..., vb(v_n)].
$
Since $[vb(e_1), ..., vb(e_n)] = 1$, it follows that $[vb(v_1), ..., vb(v_n)] != 0$.
