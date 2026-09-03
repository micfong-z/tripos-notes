Induction on $n$. The base case $n = 2$ is clear. Writing
$
  PP(union.big_(i=1)^n A_i) = PP(union.big_(i=1)^(n-1) A_i) + PP(A_n) - PP(union.big_(i=1)^(n-1) (A_i inter A_n)),
$
and applying the induction hypothesis to the two unions of $n - 1$ events gives the bound for odd $r$; the case of even $r$ is similar.
