Take $r < R$ and some $s in (r, R)$. Since $s < R$, the terms of $sum c_n s^n$ tend to $0$, so $abs(c_n) s^n < M\/s$ for some $M$ and all $n$. For $abs(x-a) < r$,

$
  abs(n c_n (x-a)^(n-1)) <= M n/s (r/s)^(n-1),
$

and $sum n (r\/s)^(n-1)$ converges because $r\/s < 1$. Hence $g(x) = sum_(n=1)^oo n c_n (x-a)^(n-1)$ has radius of convergence $>= R$ and is continuous on each $[a-r, a+r]$. Integrating $g$ term by term gives

$
  integral_a^x g(t) dif t = sum_(n=1)^oo c_n (x-a)^n = f(x) - c_0,
$

so the Fundamental Theorem of Calculus yields $f'(x) = g(x)$ on $(a-R, a+R)$.
