The components are related by $M_(i j) = (vb(C_j))_i = (vb(R_i))_j$. If ${vb(e_1), ..., vb(e_n)}$ is the standard basis of $RR^n$, then under $T$,
$ vb(e_i) |-> T(vb(e_i)) = matbold(M) vb(e_i) = vb(C_i), $
so by linearity
$ vb(x) = sum_i x_i vb(e_i) |-> T(vb(x)) = sum_i x_i T(vb(e_i)) = sum_i x_i vb(C_i). $
Thus $im T = im matbold(M) = span {vb(C_1), ..., vb(C_n)}$, the span of the columns.

For the kernel, the components of the image are $x'_i = M_(i j)x_j = (vb(R_i))_j x_j = vb(R_i) dot vb(x)$. If $vb(x') = vb(0)$, then $vb(R_i) dot vb(x) = 0$ for all $i$, so $ker T = ker matbold(M)$ is the set of vectors orthogonal to all the rows of $matbold(M)$.
