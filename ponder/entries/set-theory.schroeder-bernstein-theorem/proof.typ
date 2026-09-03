For $a in A$, write $g^(-1)(a)$ for the $b in B$ (if it exists) such that $g(b)=a$; similarly write $f^(-1)(b)$ for $b in B$. Call
$
  g^(-1)(a), f^(-1)(g^(-1)(a)), g^(-1)(f^(-1)(g^(-1)(a))), ...
$
the (possibly finite) ancestor sequence of $a in A$, and define ancestor sequences of elements of $B$ similarly. Partition
$
  A_0 & = {a in A : "the ancestor sequence of" a "terminates after an even number of steps"}   A_1 & = {a in A : "the ancestor sequence of" a "terminates after an odd number of steps"}   A_oo & = {a in A : "the ancestor sequence of" a "does not terminate"}
$
and define $B_0, B_1, B_oo$ similarly. Every $b in B_1$ has an ancestor, so $f$ bijects $A_0$ with $B_1$; similarly $g$ bijects $B_0$ with $A_1$; and $f$ (or $g$) bijects $A_oo$ with $B_oo$. Therefore
$
  h(a) = cases(
    f(a) & quad a in A_0,
    g^(-1)(a) & quad a in A_1,
    f(a) & quad a in A_oo
  )
$
defines a bijection $h: A -> B$.
