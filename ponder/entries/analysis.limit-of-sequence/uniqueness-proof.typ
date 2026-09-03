Suppose $a_n -> l$ and $a_n -> k$ with $l != k$, and set $epsilon = (1)/(2) abs(l - k) > 0$. For large $n$ both $abs(a_n - l) < epsilon$ and $abs(a_n - k) < epsilon$ hold, so
$ abs(l - k) = abs(l - a_n + a_n - k) <= abs(l - a_n) + abs(a_n - k) < 2 epsilon = abs(l - k), $
a contradiction. Hence the limit is unique.
