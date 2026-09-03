The components are related by $M_(i j) = (bold(C_j))_i = (bold(R_i))_j$. If ${bold(e_1), ..., bold(e_n)}$ is the standard basis of $RR^n$, then under $T$,
$ bold(e_i) |-> T(bold(e_i)) = matbold(M) bold(e_i) = bold(C_i), $
so by linearity
$ bold(x) = sum_i x_i bold(e_i) |-> T(bold(x)) = sum_i x_i T(bold(e_i)) = sum_i x_i bold(C_i). $
Thus $im T = im matbold(M) = span {bold(C_1), ..., bold(C_n)}$, the span of the columns.

For the kernel, the components of the image are $x'_i = M_(i j)x_j = (bold(R_i))_j x_j = bold(R_i) dot bold(x)$. If $bold(x') = bold(0)$, then $bold(R_i) dot bold(x) = 0$ for all $i$, so $ker T = ker matbold(M)$ is the set of vectors orthogonal to all the rows of $matbold(M)$.
