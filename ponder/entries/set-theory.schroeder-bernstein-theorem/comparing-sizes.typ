Bijection plays the role of _equal size_, injection the role of _at most as big_, and surjection the role of _at least as big_. For non-empty sets these agree: an injection $A -> B$ exists exactly when a surjection $B -> A$ does. Indeed, given injective $f: A -> B$, fix $a_0 in A$ and define
$
  b |-> cases(
    f^(-1)(b) & quad b in im(f),
    a_0 & quad b in.not im(f)
  )
$
which is a surjection; conversely, from a surjection $g: B -> A$ pick for each $a in A$ some $b_a in g^(-1)({a})$, and $a |-> b_a$ is an injection. Schröder–Bernstein adds that injections both ways give equal size. It is true, though far from elementary to prove, that any two sets are comparable by injection. The Continuum Hypothesis asserts that no set has size strictly between $NN$ and $RR$: every subset of $RR$ is either countable or bijects with $RR$.
