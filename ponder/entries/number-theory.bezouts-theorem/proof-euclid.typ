Run Euclid's algorithm on the inputs $a, b$ to obtain an output $r_n$. Then $r_n = x r_(n-1) + y r_(n-2)$ for some $x, y in ZZ$. From step $n-1$, $r_(n-1)$ is itself expressible as a linear combination of $r_(n-2)$ and $r_(n-3)$; substituting expresses $r_n$ as a linear combination of $r_(n-2)$ and $r_(n-3)$. Continuing inductively,
$ r_n = x r_i + y r_(i-1) $
for some $x, y in ZZ$ and all $1 <= i <= n-1$. In particular
$ r_n = x b + y a $
for some $x, y in ZZ$. Since the output satisfies $r_n = gcd(a, b)$, the highest common factor is a linear combination of $a$ and $b$ — and the computation also produces the coefficients.
