Let $gcd(a, n) = d$. The congruence $a x equiv b mod n$ has no solution if $d divides.not b$: any solution satisfies $n$ divides $a x - b$, so $d$ divides $a x - b$, and since $d divides a$ we must have $d divides b$.

If $d divides b$, write $n = d dot n'$, $a = d dot a'$, and $b = d dot b'$. Then
$ a x equiv b mod n &<=> a x - b = k n quad "for some" k in ZZ \
                     &<=> d a' x - d b' = k d n' \
                     &<=> a' x - b' = k n' \
                     &<=> a' x equiv b' mod n'. $
Note that $gcd(a', n') = 1$, so by the unit criterion the reduced congruence has a unique solution modulo $n'$.
