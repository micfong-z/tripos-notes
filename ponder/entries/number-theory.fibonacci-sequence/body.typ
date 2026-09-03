Rewriting the recurrence as $y_(n+2) - y_(n+1) - y_n = 0$ and trying $y_n prop k^n$
gives the characteristic equation
$ k^(2) - k - 1 = 0 $
with roots
$ phi_1 = (1 + sqrt(5))/2, quad phi_2 = (1 - sqrt(5))/2 = -(1)/(phi_1). $
Hence the complementary function is $y_n^((c)) = A phi_1^n + B phi_2^n$, and the
conditions $y_0 = 1$, $y_1 = 1$ give
$ A + B = 1, quad A phi_1 + B phi_2 = 1, $
so $A = phi_1/(sqrt(5))$ and $B = -phi_2/(sqrt(5))$. Therefore
$ y_n = (phi_1^(n+1) - phi_2^(n+1))/(sqrt(5)) = (phi_1^(n+1) - (-(1)/(phi_1))^(n+1))/(sqrt(5)): $
an integer sequence expressed in terms of irrational numbers.
