Induction on $n$. The case $n = 2$ is $PP(A union B) = PP(A) + PP(B) - PP(A inter B)$. Assume the formula holds for $n - 1$ events. Then
$
  PP(union.big_(i=1)^n A_i) & = PP(union.big_(i=1)^(n-1) A_i union A_n) \
                            & = PP(union.big_(i=1)^(n-1) A_i) + PP(A_n) - PP(union.big_(i=1)^(n-1) (A_i inter A_n)).
$
Applying the induction hypothesis to both unions of $n - 1$ events and collecting terms gives the formula for $n$ events.
