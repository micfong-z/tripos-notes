By definition,
$
  (dif I)/(dif c)
    = lim_(delta c -> 0) (1)/(delta c)
      [
        integral_(a(c + delta c))^(b(c + delta c)) f(x; c + delta c) dif x
        - integral_(a(c))^(b(c)) f(x; c) dif x
      ].
$
Split the first integral as an integral over $[a(c), b(c)]$, plus an increment at the upper limit, minus an increment at the lower limit. The difference of integrands over the original interval yields
$ integral_(a(c))^(b(c)) (∂ f)/(∂ c) (x; c) dif x. $
The upper-limit increment is $[b(c + delta c) - b(c)] f(overline(x); c + delta c)$ by the mean-value theorem, so its contribution is $f(b(c); c) (dif b)/(dif c)$. The lower-limit increment contributes $- f(a(c); c) (dif a)/(dif c)$.
