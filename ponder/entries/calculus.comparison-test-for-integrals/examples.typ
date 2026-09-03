For $x >= 1$ we have $x^2 >= x$, hence $ee^(-x^2) <= ee^(-x)$. Therefore

$
  integral_1^oo ee^(-x^2) dif x <= integral_1^oo ee^(-x) dif x = [-(1)/(ee^x)]_1^oo = (1)/(ee),
$

and

$
  integral_(-oo)^oo ee^(-x^2) dif x = 2 integral_0^oo ee^(-x^2) dif x = underbracket(2 integral_1^oo ee^(-x^2) dif x, (2)/(ee)) + underbracket(2 integral_0^1 ee^(-x^2) dif x, "finite since" ee^(-x^2)\ "is integrable"),
$

so $integral_(-oo)^oo ee^(-x^2) dif x$ converges.
