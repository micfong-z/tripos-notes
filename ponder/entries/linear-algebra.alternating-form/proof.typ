If the vectors are linearly dependent, then one of them can be written as a linear combination of the others, so the alternating form vanishes by multilinearity and antisymmetry.

Conversely, suppose $bold(v_1), ..., bold(v_n)$ are linearly independent. Then they span $RR^n$ or $CC^n$, so for some matrix $matbold(U)$ we can write $bold(e_j) = U_(i j) bold(v_i)$. Hence, using antisymmetry,
$
  [bold(e_1), ..., bold(e_n)] &= U_(i_1 1) U_(i_2 2) ... U_(i_n n) [bold(v_(i_1)), ..., bold(v_(i_n))] \
                             &= U_(i_1 1) ... U_(i_n n) epsilon_(i_1 i_2 ... i_n) [bold(v_1), ..., bold(v_n)].
$
Since $[bold(e_1), ..., bold(e_n)] = 1$, it follows that $[bold(v_1), ..., bold(v_n)] != 0$.
