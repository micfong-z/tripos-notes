If $X$ has probability density function $f$, then:

+ $f(x) >= 0$ for all $x in RR$;

+ $integral_(-oo)^(oo) f(x) dif x = 1$;

+ $F(x) = integral_(-oo)^x f(t) dif t$ for all $x$, and more generally $PP(X in A) = integral_A f(x) dif x$ for every $A subset.eq RR$.

If $X$ is discrete, $PP(X in A) = sum_(x in A) PP(X = x)$, so the integral formula is the continuous analogue of the discrete sum. For small $Delta x$,
$
  PP(x < X <= x + Delta x) = integral_x^(x + Delta x) f(t) dif t approx f(x) Delta x,
$
so $f(x)$ is proportional to the probability that $X$ takes values around $x$.
