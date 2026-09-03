For any fixed column $j$,
$ det matbold(M) = sum_i M_(i j) Delta_(i j) = sum_i M_(i j) (-1)^(i + j) M^(i j), $
and for any fixed row $i$,
$ det matbold(M) = sum_j M_(i j) Delta_(i j) = sum_j M_(i j) (-1)^(i + j) M^(i j). $

Equivalently, the cofactor $Delta_(i j)$ is the determinant of the matrix obtained from $matbold(M)$ by replacing the entry $M_(i j)$ with $1$ and all other entries in row $i$ and column $j$ with $0$:
$
  Delta_(i j) = [bold(C_1), ..., bold(C_(j-1)), bold(e_i), bold(C_(j+1)), ..., bold(C_n)] = [bold(R_1), ..., bold(R_(i - 1)), bold(e_j), bold(R_(i + 1)), ..., bold(R_n)].
$
