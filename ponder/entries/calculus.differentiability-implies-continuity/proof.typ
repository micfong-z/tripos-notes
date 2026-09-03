Using the affine characterization of differentiability with $A = f'(a)$,
$
  lim_(h->0) f(a+h)
    = lim_(h->0) (f(a) + f'(a) h + epsilon(h) abs(h))
    = f(a),
$
since $epsilon(h) -> 0$ as $h -> 0$. Equivalently $lim_(x->a) f(x) = f(a)$, which is continuity of $f$ at $a$. The converse fails: $f(x) = x sin ((1)/(x))$ for $x != 0$ with $f(0) = 0$ is continuous at $0$ but has no derivative there.
