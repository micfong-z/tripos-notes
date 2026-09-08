For any fixed column $j$,
$ det matbold(M) = sum_i M_(i j) Delta_(i j) = sum_i M_(i j) (-1)^(i + j) M^(i j), $
and for any fixed row $i$,
$ det matbold(M) = sum_j M_(i j) Delta_(i j) = sum_j M_(i j) (-1)^(i + j) M^(i j). $

Equivalently, the cofactor $Delta_(i j)$ is the determinant of the matrix obtained from $matbold(M)$ by replacing the entry $M_(i j)$ with $1$ and all other entries in row $i$ and column $j$ with $0$:
$
  Delta_(i j) = [vb(C_1), ..., vb(C_(j-1)), vb(e_i), vb(C_(j+1)), ..., vb(C_n)] = [vb(R_1), ..., vb(R_(i - 1)), vb(e_j), vb(R_(i + 1)), ..., vb(R_n)].
$
