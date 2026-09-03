#import "../prelude.typ": *

= #ponder("set-theory.countable-set")[Countability]

We will now discuss the #ponder("set-theory.cardinality")[sizes] of #ponder("set-theory.finite-set")[infinite] sets.

#definition[Countable Set][
  We say that a set $X$ is *#ponder("set-theory.countable-set")[countable]* if $X$ is #ponder("set-theory.finite-set")[finite] or there is a #ponder("algebra.bijection")[bijection] from $X$ to $NN$.

  If $X$ is #ponder("set-theory.finite-set")[infinite] and #ponder("set-theory.countable-set")[countable], we say that $X$ is *#ponder("set-theory.countable-set")[countably infinite]*.
] <def-countable-set>

This is to say that $X$ is #ponder("set-theory.countable-set")[countable] if and only if we can list the elements of $X$ as
$
  x_1, x_2, x_3, ...
$
which may or may not terminate.

#example[
  1. Any #ponder("set-theory.finite-set")[finite] set is #ponder("set-theory.countable-set")[countable] by definition.

  2. $NN$ is #ponder("set-theory.countable-set")[countable].

  3. $ZZ$ is #ponder("set-theory.countable-set")[countable]. We can list the integers as
    $ 0, 1, -1, 2, -2, 3, -3, ... $
    so we can define a #ponder("algebra.bijection")[bijection] from $NN$ to $ZZ$ by
    $
      f(n) = cases(
        n/2 & quad n "even",
        -(n-1)/2 & quad n "odd"
      )
    $
]

#lemma[
  Any #ponder("set-theory.subset")[subset] of $NN$ is #ponder("set-theory.countable-set")[countable].
] <lemma-subsets-nn-countable>
#proof[
  If $S subset.eq NN$ is non-empty, by @well-ordering-principle[Well-Ordering Principle] there is a least element $s_1 in S$. Remove $s_1$ from $S$ and repeat the process to get $s_2, s_3, ...$. This process either terminates (if $S$ is #ponder("set-theory.finite-set")[finite]) or continues indefinitely (if $S$ is #ponder("set-theory.finite-set")[infinite]).

  If at some point the process terminates, then we have listed all elements of $S$ and so $S$ is #ponder("set-theory.finite-set")[finite] and hence #ponder("set-theory.countable-set")[countable].

  If the process continues indefinitely, then the #ponder("set-theory.function")[map]
  $
    g: NN->S "with" n |-> s_n
  $
  is well-defined and #ponder("set-theory.injection-surjection")[injective]. It is also #ponder("set-theory.injection-surjection")[surjective] because if $k in S$, then $k in NN$ and there are less than $k$ elements of $S$ less than $k$ (by construction of the natural numbers), so $k = s_n$ for some $n in NN$. Thus $g$ is a #ponder("algebra.bijection")[bijection] and so $S$ is #ponder("set-theory.countable-set")[countably infinite].
]

#lecture-separator(lecture: 22, date: "2025-11-29")

#theorem[
  The following statements are equivalent for a set $X$:

  1. $X$ is #ponder("set-theory.countable-set")[countable]
  2. There is an #ponder("set-theory.injection-surjection")[injection] $X -> NN$
  3. There is a #ponder("set-theory.injection-surjection")[surjection] $NN -> X$, or $X = emptyset$
] <countable-equiv>

#proof[

  #fade[[$(2) => (1)$]] Suppose that there is an #ponder("set-theory.injection-surjection")[injection] $g: X -> NN$. Then $g$ is a #ponder("algebra.bijection")[bijection] from $X$ to $g(X) subset.eq NN$. By the previous lemma, $g(X)$ is #ponder("set-theory.countable-set")[countable], so $X$ is #ponder("set-theory.countable-set")[countable].

  #fade[[$(1) => (3)$]] This is clear if $X = emptyset$. If $X$ is #ponder("set-theory.countable-set")[countably infinite], then there is a #ponder("algebra.bijection")[bijection] $f: X -> NN$. The inverse $f^(-1): NN -> X$ is then a #ponder("set-theory.injection-surjection")[surjection].

  #fade[[$(3) => (2)$]] Suppose $X != emptyset$ and there is a #ponder("set-theory.injection-surjection")[surjection] $f: NN -> X$. We can define an #ponder("set-theory.injection-surjection")[injection] $h: X -> NN$ as follows: for each $x in X$, let
  $ h(x) = min({ n in NN : f(n) = x }). $
  This is well-defined since $f$ is #ponder("set-theory.injection-surjection")[surjective]. To see that $h$ is #ponder("set-theory.injection-surjection")[injective], suppose that $h(x_1) = h(x_2)$ for some $x_1, x_2 in X$. Then by definition of $h$, we have
  $ f(h(x_1)) = x_1 quad "and" quad f(h(x_2)) = x_2, $ so $x_1 = x_2$. Thus $h$ is an #ponder("set-theory.injection-surjection")[injection].
]

#corollary[
  Any #ponder("set-theory.subset")[subset] of a #ponder("set-theory.countable-set")[countable] set is #ponder("set-theory.countable-set")[countable].
] <cor-subsets-countable>

#proof[
  If $Y subset.eq X$ and $X$ is #ponder("set-theory.countable-set")[countable], then take the #ponder("set-theory.injection-surjection")[injection] $X -> NN$ restricted to $Y$.
]

We may thus view _#ponder("set-theory.countable-set")[countable]_ as saying that a set is _at most as big as_ $NN$.

#theorem[
  $NN times NN$ is #ponder("set-theory.countable-set")[countable].
] <thm-nn-times-nn-countable>

#prooflike[Proof 1][
  We can list the elements of $NN times NN$ as follows:
  $
    (1, 1), (1, 2), (2, 1), (1, 3), (2, 2), (3, 1), (1, 4), (2, 3), (3, 2), (4, 1), ...
  $
  which corresponds to the diagonals in the grid of pairs. This gives a #ponder("set-theory.injection-surjection")[surjection] from $NN$ to $NN times NN$, so $NN times NN$ is #ponder("set-theory.countable-set")[countable].

  More precisely, define $a_1 = (1, 1)$ and $a_n$ inductively. For $n >= 1$, given $a_(n-1) = (p, q)$, then writing

  $
    a_n = cases(
      (p-1, q+1) & quad p > 1,
      (q+1, 1) & quad p = 1
    )
  $
  gives a well-defined #ponder("analysis.sequence")[sequence] $(a_n)_(n=1)^oo$ which lists all elements of $NN times NN$. The #ponder("set-theory.function")[map] $f: NN->NN times NN$ defined by $f(n) = a_n$ is then a #ponder("set-theory.injection-surjection")[surjection].
]

#prooflike[Proof 2][
  From @countable-equiv, it suffices to construct an #ponder("set-theory.injection-surjection")[injection] $g: NN times NN -> NN$. Define
  $
    g(p, q) = 2^(p) times 3^(q).
  $
  To see that $g$ is #ponder("set-theory.injection-surjection")[injective], suppose that $g(p_1, q_1) = g(p_2, q_2)$. Then by the @thm-fundamental-arithmetic[Fundamental Theorem of Arithmetic], we must have $p_1 = p_2$ and $q_1 = q_2$. Thus $g$ is an #ponder("set-theory.injection-surjection")[injection].
]

#corollary[
  $ZZ times ZZ$ is #ponder("set-theory.countable-set")[countable].
]

#proof[
  Since $ZZ$ is #ponder("set-theory.countable-set")[countable], there is an #ponder("set-theory.injection-surjection")[injection] $f: ZZ -> NN$. Then the #ponder("set-theory.function")[map]
  $
    h: ZZ times ZZ -> NN "with" (x, y) |-> g(f(x), f(y))
  $
  where $g: NN times NN -> NN$ is the #ponder("set-theory.injection-surjection")[injection] from @thm-nn-times-nn-countable, is an #ponder("set-theory.injection-surjection")[injection]. Thus $ZZ times ZZ$ is #ponder("set-theory.countable-set")[countable].
]

#remark[
  By induction, $ZZ^k$ is #ponder("set-theory.countable-set")[countable] for any $k in NN$.
]

#theorem[
  A #ponder("set-theory.countable-set")[countable] #ponder("set-theory.set-operations")[union] of #ponder("set-theory.countable-set")[countable] sets is #ponder("set-theory.countable-set")[countable].
] <countable-union-countable>

#proof[
  We me assume that our #ponder("set-theory.countable-set")[countable] sets are indexed by $NN$. Given #ponder("set-theory.countable-set")[countable] sets $A_1, A_2, A_3, ...$, we wish to show that $union.big_(n in NN) A_n$ is #ponder("set-theory.countable-set")[countable].

  For each $i in NN$, since $A_i$ is #ponder("set-theory.countable-set")[countable], we can list its elements as
  $ A_i = { a_1^((i)), a_2^((i)), a_3^((i)), ... }. $

  Define $f: union.big_(n in NN) A_n -> NN$ by
  $
    a_j^((i)) |-> 2^(i) times 3^(j).
  $
  Note that we need to take the least $i$ such that $a_j^((i))$ is in $A_i$ to ensure that $f$ is well-defined. #fade[[This is possible since if $a_j^((i))$ is in multiple $A_i$s, we can just take the least such index.]] This is an #ponder("set-theory.injection-surjection")[injection] by the same reasoning as in Proof 2 of @thm-nn-times-nn-countable. Thus $union.big_(n in NN) A_n$ is #ponder("set-theory.countable-set")[countable].
]

#example[
  $QQ$ is #ponder("set-theory.countable-set")[countable], since we can think of it as $union.big_(n in NN) (1)/(n) ZZ = union.big_(n in NN) {(m)/(n): m in ZZ}$, then apply @countable-union-countable.
]

#theorem[
  The set $AA$ of all #ponder("number-theory.algebraic-number")[algebraic numbers] is #ponder("set-theory.countable-set")[countable].
] <thm-algebraic-countable>

#proof[
  It suffices to show that the set of all polynomials with integer coefficients is #ponder("set-theory.countable-set")[countable], since then $AA$ is a #ponder("set-theory.countable-set")[countable] #ponder("set-theory.set-operations")[union] of #ponder("set-theory.finite-set")[finite] sets.

  In fact, it suffices to show that for each $d in NN$, the set $P_d$ of all polynomials of degree $d$ with integer coefficients is #ponder("set-theory.countable-set")[countable]. This is by @countable-union-countable.

  But the #ponder("set-theory.function")[map] $P_d -> ZZ^(d+1)$ defined by
  $ a_d x^d + a_(d-1) x^(d-1) + ... + a_1 x + a_0 |-> (a_d, a_(d-1), ..., a_1, a_0) $
  is an #ponder("set-theory.injection-surjection")[injection]. Since $ZZ^(d+1)$ is #ponder("set-theory.countable-set")[countable], $P_d$ and hence $AA$ are #ponder("set-theory.countable-set")[countable].
]

#definition[Uncountability][
  A set is *#ponder("set-theory.uncountable-set")[uncountable]* if it is not #ponder("set-theory.countable-set")[countable].
] <def-uncountable>

#theorem[
  $RR$ is #ponder("set-theory.uncountable-set")[uncountable].
] <thm-rr-uncountable>

#lecture-separator(lecture: 23, date: "2025-12-02")

#proof[
  If $RR$ were #ponder("set-theory.countable-set")[countable], we would be able to list all the #ponder("analysis.real-numbers")[reals] as $r_1, r_2, r_3, ...$.

  Write each $r_n$ in decimal form in some way
  $
    r_1 & = n_1.d_(11) d_(12) d_(13) d_(14)... \
    r_2 & = n_2.d_(21) d_(22) d_(23) d_(24)... \
    r_3 & = n_3.d_(31) d_(32) d_(33) d_(34)... \
  $

  Define $r = 0.d_1 d_2 d_3...$ by $d_n = 1$, if $d_(n n) != 1$, and $d_n = 2$, if $d_(n n) = 1$. This $r$ has only one decimal representation, and is not on the list, since it differs from each $r_n$ at the $n$-th decimal place. $smash$

  Thus $RR$ is #ponder("set-theory.uncountable-set")[uncountable].
]

This is known as *Cantor's diagonal argument*. Note that this shows that $(0, 1)$ is #ponder("set-theory.uncountable-set")[uncountable], and hence any interval in $RR$ is #ponder("set-theory.uncountable-set")[uncountable].

#corollary[
  There are uncountably many #ponder("number-theory.transcendental-number")[transcendental numbers].
] <cor-transcendentals-uncountable>

#proof[
  If there were only countably many #ponder("number-theory.transcendental-number")[transcendental numbers], then since the set of #ponder("number-theory.algebraic-number")[algebraic numbers] is #ponder("set-theory.countable-set")[countable], $RR$ would be a #ponder("set-theory.countable-set")[countable] #ponder("set-theory.set-operations")[union] of #ponder("set-theory.countable-set")[countable] sets, and hence #ponder("set-theory.countable-set")[countable] by @countable-union-countable. This contradicts @thm-rr-uncountable.
]

#theorem[
  $cal(P)(NN)$ is #ponder("set-theory.uncountable-set")[uncountable].
] <thm-pnn-uncountable>
#prooflike[Proof 1][
  If $cal(P)(NN)$ were #ponder("set-theory.countable-set")[countable], we could list it as $S_1, S_2, ...$
  Let $S = {n in NN: n in.not S_n}$. Then $S$ is not on our list, since $forall n in NN, S != S_n$. Thus $cal(P)(NN)$ is #ponder("set-theory.uncountable-set")[uncountable].
]
Note that this is a variant of Cantor's diagonal argument.
#prooflike[Proof 2][
  Note that there is an #ponder("set-theory.injection-surjection")[injection] from $(0, 1)$ into $cal(P)(NN)$: write $x in (0, 1)$ in binary decimal expansion as
  $
    x = 0.x_1 x_2 x_3 ...
  $
  with $x_(i) in {0, 1}$. #fade[[Assume that we do not end with an infinite string of $1$s.]] Then define $f: (0, 1) -> cal(NN)$ by
  $
    f(x) = { n in NN: x_n = 1 }.
  $
  This is an #ponder("set-theory.injection-surjection")[injection]. Since $(0, 1)$ is #ponder("set-theory.uncountable-set")[uncountable] by @thm-rr-uncountable, $cal(P)(NN)$ is #ponder("set-theory.uncountable-set")[uncountable] by @countable-equiv.
]

In fact, Proof 1 shows the following:

#theorem[
  For any set $X$, there is no #ponder("algebra.bijection")[bijection] from $X$ to $cal(P)(X)$.
] <cantors-theorem>

#proof[
  Given any #ponder("set-theory.function")[map] $f:X -> cal(P)(X)$,we will show that $f$ is not #ponder("set-theory.injection-surjection")[surjective].

  Indeed, let $S = {x in X: x in.not f(x)}$. Then $S in cal(P)(X)$  but $S$ does not belong to the #ponder("set-theory.image-preimage")[image] of $f$, since $forall x in X$, the sets $S$ and $f(x)$ differ in the element $x$, so $S != f(x)$ for all $x$.
]

#remark[

  1. This is reminiscent of Russell's paradox.

  2. This gives another proof that there is no universal set. For suppose there were a universal set $V$. Then $cal(P)(V) subset.eq V$, in which case we would have a #ponder("set-theory.injection-surjection")[surjection] $V -> cal(P)(V)$, contradicting the above theorem.
]

#example[
  Let ${A_i: i in I}$ be a family of open pairwise #ponder("set-theory.set-operations")[disjoint] intervals in $RR$. We shall consider whether this family must be #ponder("set-theory.countable-set")[countable].

  #claim[
    The family ${A_i: i in I}$ is #ponder("set-theory.countable-set")[countable].
  ]

  #prooflike[Proof 1][
    Each interval $A_i$ contains a rational since @proposition-rationals-dense[$QQ$ is Dense in $RR$], and $QQ$ is #ponder("set-theory.countable-set")[countable]. Hence since the intervals are #ponder("set-theory.set-operations")[disjoint], we have an #ponder("set-theory.injection-surjection")[injection] #fade[[by picking a rational from each interval]] from $I$ to $QQ$. Thus $I$ is #ponder("set-theory.countable-set")[countable].
  ]

  #prooflike[Proof 2][
    The set ${i in I: A_i "has length" >= 1}$ is #ponder("set-theory.countable-set")[countable], because each such interval contains at least one integer, and the integers are #ponder("set-theory.countable-set")[countable].

    Similarly, the set ${i in I: A_i "has length" >= (1)/(2)}$ is #ponder("set-theory.countable-set")[countable] as it injects into the set of half-integers, which is #ponder("set-theory.countable-set")[countable].

    More generally, for each $n in NN$, the set ${i in I: A_i "has length" >= (1)/(n)}$ is #ponder("set-theory.countable-set")[countable] as it injects into the set of integer multiples of $(1)/(n)$, which is #ponder("set-theory.countable-set")[countable].

    Thus $I = union.big_(n in NN) {i in I: A_i "has length" >= (1)/(n)}$ is a #ponder("set-theory.countable-set")[countable] #ponder("set-theory.set-operations")[union] of countable sets, and hence #ponder("set-theory.countable-set")[countable] by @countable-union-countable.
  ]
]

#lecture-separator(lecture: 24, date: "2025-12-04")

#remarklike[Summary][
  To show that a set $X$ is #ponder("set-theory.countable-set")[countable], we can do one of the following:

  1. list its elements
  2. inject it into $NN$
  3. use @countable-union-countable[Countable Union of Countable Sets is Countable]
  4. if $X$ is near $RR$, consider $QQ$

  To show that a set $X$ is #ponder("set-theory.uncountable-set")[uncountable], we can do one of the following:

  1. use a diagonal argument
  2. inject any #ponder("set-theory.uncountable-set")[uncountable] set into $X$
]

Intuitively, we think of
- _"$A$ bijects with $B$"_ as _"$A$ and $B$ are of the same #ponder("set-theory.cardinality")[size]"_,
- _"$A$ injects into $B$"_ as _"$A$ is at most as big as $B$"_,
- _"$A$ surjects onto $B$"_ as _"$A$ is at least as big as $B$"_.

For these interpretations to make sense, we need to establish, if _"$A$ is at most as big as $B$"_, then _"$B$ is at least as big as $A$"_, _etc._

#lemma[
  Given non-empty sets $A$ and $B$.
  $
    exists "injection" f:A->B <=> exists "surjection" g: B->A.
  $
]
#proof[

  #fade[[$=>$]] Suppose $f: A->B$ is #ponder("set-theory.injection-surjection")[injective]. Fix $a_0 in A$. Define $g: B->A$ by
  $
    b |-> cases(
      f^(-1)(b) & quad b in im(f),
      a_0 & quad b in.not im(f)
    ).
  $
  Then $g$ is a #ponder("set-theory.injection-surjection")[surjection].

  #fade[[$arrow.l.double$]] Suppose $g: B->A$ is a #ponder("set-theory.injection-surjection")[surjection]. For each $a in A$, pick any $b_a in g^(-1)({a})$ (this is possible since $g$ is #ponder("set-theory.injection-surjection")[surjective]). Define $f: A->B$ by
  $
    a |-> b_a.
  $
  Then $f$ is an #ponder("set-theory.injection-surjection")[injection].
]

We also need that, if _"$A$ is at most as big as $B$"_ and _"$B$ is at most as big as $A$"_, then _"$A$ and $B$ are of the same #ponder("set-theory.cardinality")[size]"_.

#theorem[Schröder-Bernstein Theorem][
  Given sets $A$ and $B$.
  $
    (exists "injection" f:A->B) and (exists "injection" g:B->A) => (exists "bijection" h:A->B).
  $
] <schroeder-bernstein>

#proof[
  For $a in A$, write $g^(-1)(a)$ for the $b in B$ (if it exists) such that $g(b)=a$.

  Similarly, for $b in B$, write $f^(-1)(b)$ for the $a in A$ (if it exists) such that $f(a)=b$.

  We call $g^(-1)(a), f^(-1)(g^(-1)(a)), g^(-1)(f^(-1)(g^(-1)(a))), ...$ the (possibly finite) ancestor sequence of $a in A$.

  Similarly, define the ancestor sequence of $b in B$.

  Let
  $
     A_0 & = {a in A: "the ancestor sequence of" a "terminates after an even number of steps"} \
     A_1 & = {a in A: "the ancestor sequence of" a "terminates after an odd number of steps"} \
    A_oo & = {a in A: "the ancestor sequence of" a "does not terminate"} \
  $
  and similarly for $B_0, B_1, B_oo$.

  Note that $f$ bijects $A_0$ with $B_1$ #fade[[observing that every $b in B_1$ has at least one anscestor, so is equal to $f(a)$ for some $a in A_0$]]. Similarly, $g$ bijects $B_0$ with $A_1$. Also, $f$ (or $g$) bijects $A_oo$ with $B_oo$.

  Then the #ponder("set-theory.function")[function] $h: A->B$ defined by
  $
    a |-> cases(
      f(a) & quad a in A_0,
      g^(-1)(a) & quad a in A_1,
      f(a) & quad a in A_oo
    )
  $
  is a #ponder("algebra.bijection")[bijection].
]

#example[
  Consider whether there is #ponder("algebra.bijection")[bijection] from $[0, 1]$ to $[0,1] union[2, 3]$.

  Observe that there is an #ponder("set-theory.injection-surjection")[injection] from $[0, 1]$ to $[0,1] union[2, 3]$ given by the inclusion #ponder("set-theory.function")[map], and there is an #ponder("set-theory.injection-surjection")[injection] from $[0,1] union[2, 3]$ to $[0, 1]$ given by
  $
    x |-> (x)/(3).
  $

  Thus, by @schroeder-bernstein[Schröder-Bernstein Theorem], there is a #ponder("algebra.bijection")[bijection] from $[0, 1]$ to $[0,1] union[2, 3]$.

]

#remark[
  1. It seems natural to say that for any two sets $A$ and $B$, either $A$ injects into $B$, or $B$ injects into $A$. This is true but its proof is beyond the scope of this course.

  2. *Continuum Hypothesis*. $exists.not$ a set $X$ whose #ponder("set-theory.cardinality")[size] lies between $NN$ and $RR$. _i.e._ any #ponder("set-theory.subset")[subset] of $RR$ is either #ponder("set-theory.countable-set")[countable] or bijects with $RR$.
]
