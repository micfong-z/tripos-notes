The proof uses two facts. *Fact A:* a polynomial $p$ satisfies $abs(p(x) - p(y)) <= K abs(x - y)$ on $[0, 1]$ for some constant $K$, obtained by factoring each difference of powers $x^j - y^j$. *Fact B:* a non-zero polynomial of degree $d$ has at most $d$ real roots.

Write $L_n = sum_(k=1)^n (1)/(10^(k!))$, so that $abs(L - L_n) <= 2 dot (1)/(10^((n+1)!))$ and $L_n = s \/ (10^(n!))$ for some natural $s$. If $p(L) = 0$ for a polynomial of degree $d$ with integer coefficients, then for all large $n$ we have $p(L_n) != 0$ (Fact B), and $p(L_n) = t \/ (10^(d n!))$ for some non-zero integer $t$, so
$ (1)/(10^(d n!)) <= abs(p(L_n)) = abs(p(L_n) - p(L)) <= K abs(L_n - L) <= (2K)/(10^((n+1)!)). $
Since $(n+1)!$ grows faster than $d n!$, this fails for large $n$: contradiction.
