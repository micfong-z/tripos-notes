By induction on the number of added points. It suffices to insert a single point: let $cal(P) = {x_0, x_1, ..., x_n}$ and choose $y in (x_(k-1), x_k)$ for some $k$, and set $cal(P') = {y} union cal(P)$. Then

$
  sup_([x_(k-1), y]) f(x), sup_([y, x_k]) f(x) &<= sup_([x_(k-1), x_k]) f(x)\
  (y-x_(k-1)) sup_([x_(k-1), y]) f(x) + (x_k - y) sup_([y, x_k]) f(x) &<= (x_k - x_(k-1)) sup_([x_(k-1), x_k]) f(x)\
  U(f, cal(P')) &<= U(f, cal(P)).
$

The same argument with $inf$ in place of $sup$ gives $L(f, cal(P)) <= L(f, cal(P'))$. Repeating for every point of $cal(P') \\ cal(P) = {y_1, y_2, ..., y_m}$ and chaining the inequalities proves the result.
