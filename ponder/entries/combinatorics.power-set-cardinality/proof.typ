We prove by induction on $n$.

*Base case.* For $n = 0$ the empty set has exactly one subset, itself.

*Inductive step.* Suppose the result holds for some $n in NN$, and let $A$ be a set of size $n + 1$. Pick some element $a in A$, and let $B = A \ {a}$. Then $B$ has size $n$, and by the inductive hypothesis $B$ has exactly $2^n$ subsets.

Each subset of $A$ either includes or excludes $a$: taking each subset of $B$ and either adding $a$ or not gives exactly two choices per subset of $B$, leading to $2 times 2^n = 2^(n+1)$ subsets of $A$. Hence, by induction, the result holds for all $n in NN$.
