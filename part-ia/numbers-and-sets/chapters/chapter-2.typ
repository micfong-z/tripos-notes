#import "../prelude.typ": *

= Sets, Functions and Relations

== #ponder("set-theory.set")[Sets]

=== Introduction on Sets

#definition("Set")[
  A *#ponder("set-theory.set")[set]* is a collection of mathematical objects.

  Examples include $RR, NN, {1, 5, 9}, (-2, 3]$.
] <def-set>

The order of elements in a #ponder("set-theory.set")[set] is immaterial, and elements are counted only once. _e.g._ ${1, 3, 7}={1, 7, 3}$, and ${1, 4, 4, 5, 2} = {1, 2, 5, 4}$.

#definition("Empty set")[
  There is only one #ponder("set-theory.set")[set] with no elements, called the *#ponder("set-theory.empty-set")[empty set]* $emptyset$.
] <def-empty-set>

#definition("Set inclusion, equality, subset and proper subset")[
  We write $x in A$ if $x$ *is an element of* $A$, and $x in.not A$ if not.

  Two #ponder("set-theory.set")[sets] are *equal* if they have the same elements. _i.e._ $A=B$ if and only if $forall x, x in A <=> x in B$.


  A #ponder("set-theory.set")[set] $B$ is a *#ponder("set-theory.subset")[subset]* of $A$, written $B subset.eq A$ or $B subset A$, if every element of $B$ is an element of $A$.

  $B$ is said to be a *#ponder("set-theory.subset")[proper subset]* of $A$ if $B subset.eq A$ and $B != A$. This is also written as $B subset.neq A$.
] <def-subset>
#remark[
  $A=B$ if $A subset.eq B$ and $B subset.eq A$.
]

If $A$ is a #ponder("set-theory.set")[set] and $P$ is a property of some elements of $A$, we can write ${x in A: P(x)}$ for the #ponder("set-theory.subset")[subset] of $A$ comprising those elements for which $P(x)$ holds.

#definition("Set operations")[
  If $A$ and $B$ are #ponder("set-theory.set")[sets], then

  - their *#ponder("set-theory.set-operations")[union]* $A union B={x: x in A "or" x in B}.$
  - their *#ponder("set-theory.set-operations")[intersection]* $A inter B={x: x in A "and" x in B}$.
  - $A$ and $B$ are *#ponder("set-theory.set-operations")[disjoint]* if $A inter B = emptyset$.
  - their *#ponder("set-theory.set-operations")[difference]* $A \\ B = {x in A: x in.not B}$.

] <def-set-operations>

=== Properties of Sets

#proposition[

  We have a few properties about #ponder("set-theory.set-operations")[intersections] and #ponder("set-theory.set-operations")[unions].

  - we can view #ponder("set-theory.set-operations")[intersection] as a special case of #ponder("set-theory.subset")[subset] selection:

    $ A inter B = {x in A: x in B}. $

  - #ponder("set-theory.set-operations")[intersection] and #ponder("set-theory.set-operations")[union] are #ponder("algebra.commutativity-associativity-distributivity")[commutative] and #ponder("algebra.commutativity-associativity-distributivity")[associative]:

    $ A union B = B union A quad "and" quad (A union B) union C=A union (B union C) $

  - #ponder("set-theory.set-operations")[union] is #ponder("algebra.commutativity-associativity-distributivity")[distributive] over #ponder("set-theory.set-operations")[intersection], _i.e._

    $ A union (B inter C)=(A union B) inter (A union C) $

    and #ponder("set-theory.set-operations")[intersection] is #ponder("algebra.commutativity-associativity-distributivity")[distributive] over #ponder("set-theory.set-operations")[union]:

    $ A inter (B union C)=(A inter B) union (A inter C). $
] <inter-union-props>

#lecture-separator(lecture: 3, date: "2025-10-14")

#proposition("De Morgan's law")[
  If $A, B, C$ are #ponder("set-theory.set")[sets], then
  $
    A \\ (B inter C) & = (A \\ B) union (A \\ C), \
    A \\ (B union C) & = (A \\ B) inter (A \\ C). \
  $
] <de-morgans>

To #ponder("set-theory.proof")[prove] #ponder("set-theory.statement")[statements] in @inter-union-props and @de-morgans, we can rewrite set notation into a combination of inclusion and logical connectives, and then use a truth table to derive the results. Usually, we need to show that $"LHS" subset.eq "RHS"$ and $"RHS" subset.eq "LHS"$.

#notation[
  If $A_1, A_2, A_3$ are #ponder("set-theory.set")[sets], then
  $
    inter.big_(n=1)^oo A_n & = A_1 inter A_2 inter A_3 inter... \
                           & = {x:x in A_n forall n in NN}. \
  $
  Similarly,

  $
    union.big_(n=1)^oo A_n & = A_1 union A_2 union A_3 union... \
                           & = {x:x in A_n exists n in NN}. \
  $

  #important[
    The $oo$ does *not* mean the _limit_ of anything.
  ]


  More generally, given an index set $I$ and a collection of #ponder("set-theory.set")[sets] $A_i$ indexed by $i in I$, we write
  $
     inter.big_(i in I)A_i & = {x: x in A_i forall i in I}, "and" \
    union.big_(i in I) A_i & = {x:x in A_i exists i in I}. \
  $
]

#definition("Cartesian product")[
  Given #ponder("set-theory.set")[sets] $A$ and $B$, we can form their *#ponder("set-theory.cartesian-product")[Cartesian product]* $A times B = {(a, b): a in A and b in B}$, which is the #ponder("set-theory.set")[set] of ordered pairs $(a, b)$ with $a in A$ and $b in B$.
] <def-cartesian-product>

#remark[
  To formally define an ordered pair, we can define $(a, b)={{a}, {a, b}}$.
]

We can extend @def-cartesian-product to ordered triples and so on, _e.g._ $ RR^3 & = RR times RR times RR \
     & = {(x, y, z): x, y, z in RR}. \ $

#definition("Power set")[
  For any #ponder("set-theory.set")[set] $X$, the *#ponder("set-theory.power-set")[power set]* $cal(P)(X)$ is the #ponder("set-theory.set")[set] consisting of all #ponder("set-theory.subset")[subsets] of $X$, _i.e._
  $ cal(P)(X) = {Y: Y subset.eq X}. $

  For example, if $X = {1, 2}$, then $cal(P)(X) = {emptyset, {1}, {2}, {1, 2}}$.
] <def-power-set>

#important[
  Given a #ponder("set-theory.set")[set] $A$, we can form ${x in A: P(x)}$ for any property $P$. However, we cannot always form ${x : P(x)}$, due to the following paradox.

  Suppose $X = {x : x "is a set" and x in.not x}$ were a #ponder("set-theory.set")[set]. Now, if $X in X$, it implies by definition that $X in.not X$.

  On the other hand, if $X in.not X$, then $X in X$ by our construction. $smash$

  This is known as Russell's Paradox. More generally, this comes from the fact that there is no _universal set_ $cal(U)$ such that $forall x, x in cal(U)$. Otherwise, we could form $X$ above using the subset notation as $X = {x in cal(U): x in.not x}$.
]

#remarklike("Moral")[
  To guarantee that a #ponder("set-theory.set")[set] exists, it should be obtained from known #ponder("set-theory.set")[sets] (_e.g._ $NN, RR$) in one of the ways discussed above.
]

=== #ponder("set-theory.finite-set")[Finite] Sets

#definition("Size of a set")[

  Given $n in ZZ_(>=0)$, we say a #ponder("set-theory.set")[set] $A$ has *#ponder("set-theory.cardinality")[size]* $n$ if we can write $A = {a_1, a_2, ..., a_n}$ with the elemtns $a_i$ distinct.
] <def-size-of-a-set>

#definition("Finite and infinite set")[
  We say $A$ is *#ponder("set-theory.finite-set")[finite]* if $exists n in ZZ_(>=0)$ such that $A$ has #ponder("set-theory.cardinality")[size] $n$, and $A$ is *#ponder("set-theory.finite-set")[infinite]* otherwise.
] <def-finite-infinite-set>

== #ponder("set-theory.function")[Functions]

#definition("Function")[
  Given #ponder("set-theory.set")[sets] $A$ and $B$, a *#ponder("set-theory.function")[function]* $f$ from $A$ to $B$ is a _rule_ that assigns to every $x in A$ uniquely to an element $f(x) in B$.

  More formally, a *#ponder("set-theory.function")[function]* from $A$ to $B$ is a #ponder("set-theory.subset")[subset] $f subset.eq A times B$ such that for all $x in A$, there exists exactly one $y in B$ such that $(x, y) in f$. We usually write
  $ f:A->B $
  and
  $ f(x) = y quad "or" quad x |-> y. $
] <def-function>

#example[
  1. $f: RR->RR$ with $x |-> x^2$ is a #ponder("set-theory.function")[function].
  2. $f: RR->RR$ with $x |-> (1)/(x)$ is not a #ponder("set-theory.function")[funciton] since it is undefined at $x=0$.
  3. $f: RR->RR$ with $x |-> plus.minus sqrt(abs(x))$ is not a #ponder("set-theory.function")[function].
  4. $f: RR->RR$ with $x |-> cases(
      1 quad "if" x in QQ,
      0 quad "otherwise"
    )$ is a #ponder("set-theory.function")[function].
]

#definition("Domain, range, image, preimage")[
  Following @def-function, for $f: A->B$, we say that $A$ is the *#ponder("set-theory.image-preimage")[domain]* of $f$ and $B$ is the *#ponder("set-theory.image-preimage")[range]* (or #ponder("set-theory.image-preimage")[codomain]).

  If $x in A$ and $f(x) in y$, then $y$ is called the *#ponder("set-theory.image-preimage")[image]* of $x$, and $x$ is called a *#ponder("set-theory.image-preimage")[preimage]* of $y$.

  Moreover, if $X subset.eq A$ then the *#ponder("set-theory.image-preimage")[image]* of $X$ under $f$ is
  $
    f(X) & = {f(x): x in X} \
         & = {b in B: exists x in X, f(x)=b}. \
  $

  If $Y subset.eq B$, then the *#ponder("set-theory.image-preimage")[preimage]* of $Y$ under $f$ is
  $ f^(-1)(Y)={a in A: exists y in Y, f(a)=y}. $
] <def-image-preimage>

#example[
  For the #ponder("set-theory.function")[function] $f(x)=x^2$, the #ponder("set-theory.image-preimage")[image] of $6$ is $36$, but the #ponder("set-theory.image-preimage")[preimage] of $36$ is $plus.minus 6$.

  We also have $im(f)={y in RR: y >= 0}$, and $f({x in RR: -1 <= x < 4})=[0, 16)$.

  The #ponder("set-theory.image-preimage")[preimage] $f^(-1)({y in RR: -1 <= y < 4})=(-2, 2)$.
]

#lecture-separator(lecture: 4, date: "2025-10-16")

#notation[
  For $f: A-> B$, we usually denote $f(A)$ as $im(f)$, which is called the #ponder("set-theory.image-preimage")[image] of $f$.
]

#definition("Injection, surjection, bijection")[
  We say $f:A -> B$ is *#ponder("set-theory.injection-surjection")[injective]* if $forall a, a' in A$, we have $a != a' => f(a) != f(a')$. Equivalently, $f$ is #ponder("set-theory.injection-surjection")[injective] if $f(a)=f(a') => a=a'$ by the contrapositive.

  We say $f: A->B$ is *#ponder("set-theory.injection-surjection")[surjective]* if $forall b in B$, $exists a in A$ such that $f(a)=b$.

  We say $f: A->B$ is *#ponder("algebra.bijection")[bijective]* if it is both #ponder("set-theory.injection-surjection")[injective] and #ponder("set-theory.injection-surjection")[surjective].
] <def-injection-surjection>

If $f: A-> B$ is a #ponder("algebra.bijection")[bijection], then everything in $B$ is mapped to exactly once. That is, $f$ _pairs_ elements of $A$ and $B$.

#definition("Permutation")[
  A *#ponder("algebra.permutation")[permutation]* of $A$ is a #ponder("algebra.bijection")[bijection] $f: A->A$.
]

#important[
  When specifying a #ponder("set-theory.function")[function], we must specify its #ponder("set-theory.image-preimage")[domain] and #ponder("set-theory.image-preimage")[range].
]

#remarklike("Observation")[

  1. $f$ is #ponder("set-theory.injection-surjection")[surjective] if and only $f(A)=B$.

    For #ponder("set-theory.finite-set")[finite] #ponder("set-theory.set")[sets] $A$ and $B$, if $|B|>|A|$, then there cannot be a #ponder("set-theory.injection-surjection")[surjective] #ponder("set-theory.function")[function] from $A$ to $B$.

  2. For #ponder("set-theory.finite-set")[finite] #ponder("set-theory.set")[sets] $A$ and $B$, there is no #ponder("set-theory.injection-surjection")[injection] from $A$ to $B$ if $|A| > |B|$.

  3. For a #ponder("set-theory.finite-set")[finite] #ponder("set-theory.set")[set] $A$, $f:A->A$, then $f$ is #ponder("set-theory.injection-surjection")[injective] if and only if $f$ is #ponder("set-theory.injection-surjection")[surjective].

  4. For a #ponder("set-theory.finite-set")[finite] #ponder("set-theory.set")[set] $A$, There is no #ponder("algebra.bijection")[bijection] from $A$ to any #ponder("set-theory.subset")[proper subset] of it.

  5. A #ponder("set-theory.set")[set] $X$ has #ponder("set-theory.cardinality")[size] $n$ if and only if there is a #ponder("algebra.bijection")[bijection] ${1, 2, ..., n} -> X = {a_1, a_2, ..., a_n}$ where $i |-> a_i$.
]

=== Examples of Functions

#definition("Identity function")[
  For any #ponder("set-theory.set")[set] $X$, the #ponder("set-theory.function")[function] $"id"_X: X->X$ where $x|->x$ is the *#ponder("set-theory.identity-function")[identity function]*.
] <def-identity-function>

#example("Examples of functions")[
  - A sequence of reals $x_1, x_2, ...$ is a #ponder("set-theory.function")[function] $NN->RR$ where $n|->x_(n)$.

  - The operation on $NN$ is a #ponder("set-theory.function")[function] $NN times NN -> NN$ where $(a, b) |-> a+b$.
]

#definition("Indicator function")[
  Given a #ponder("set-theory.set")[set] $X$ and $A subset.eq X$, we have the *#ponder("set-theory.indicator-function")[indicator function]* (or #ponder("set-theory.indicator-function")[characteristic function]) of $A$, defined by

  $
    indicator_A: X-> {0, 1} quad "where" quad x |-> cases(
      1 quad "if" x in A,
      0 quad "if" x in.not A
    )
  $
] <def-indicator-function>

#proposition("Properties of the indicator function")[
  1. $indicator_A = indicator_B <=> A=B$
  2. $indicator_(A inter B)=indicator_A indicator_B$
  3. $indicator_(X \\ A) = 1 - indicator_A$
  4. $indicator_(A union B) = indicator_A + indicator_B - indicator_(A inter B)$
]

#proof[
  #fade[[for property (4)]]

  We have
  $
    indicator_(A union B) & = 1-indicator_(X\\A union B) \
                          & = 1-indicator_(A^(complement)inter B^(complement)) \
                          & = 1-indicator_(A^(complement)) indicator_(B^(complement)) \
                          & = 1-(1- indicator_A)(1-indicator_B) \
                          & = indicator_A + indicator_B - indicator_(A inter B). \
  $
]

#lecture-separator(lecture: 5, date: "2025-10-18")

#definition("Fucntion composition")[
  Given $f: A->B$ and $y: B->C$, the *#ponder("algebra.function-composition")[composition]* is $g compose f: A->C$, where $a |-> g(f(a)).$
]

#proposition("Properties of composition")[
  - In general, $compose$ is not #ponder("algebra.commutativity-associativity-distributivity")[commutative].
  - $compose$ is #ponder("algebra.commutativity-associativity-distributivity")[associative]. _i.e._ if we have $f:A->B, g:B->C, h:C->D$, then $h compose (g compose f) = (h compose g) compose f$.
]

#proof[
  For example, if $f:RR->RR$ with $x |-> 2x$, and $g:RR->RR$ with $x|->x+1$, then
  $
    g compose f & = g(2x)  & = & 2x+1 \
    f compose g & = f(x+1) & = & 2(x+1). \
  $
  Hence, in general, $compose$ is not #ponder("algebra.commutativity-associativity-distributivity")[commutative].

  Now, for every $x in A$, we have
  $
    (h compose (g compose f))(x) & = h((g compose f)(x)) & = h(g(f(x))) & quad "and" \
     ((h compose g)compose f)(x) & = (h compose g)(f(x)) & = h(g(f(x))) & quad "as expected." \
  $
]

#remark[
  We may therefore drop the brackets in #ponder("set-theory.function")[function] #ponder("algebra.function-composition")[composition] without ambiguity.
]

#definition("Invertible function")[
  We say $f:A->B$ is *#ponder("set-theory.invertible-function")[invertible]* if $exists g: B->A$ such that $g compose f = id_A$ and $f compose g = id_B$.
] <def-invertible-function>

#example[
  Consider $f: RR->RR$ with $x|->2x+1$ and $g:RR->RR$ with $x|-> (x-1)/(2)$.

  Indeed, $forall x in RR$, $(g compose f)(x)=g(2x+1)=(2x+1-1)/2=x$, so $g compose f = id_RR$.

  Similarly, $forall x in RR$, $(f compose g)(x)=f((x-1)2)) = 2((x-1)/2)+1 = x$, so $f compose g = id_RR$.

  Hence $f$ is #ponder("set-theory.invertible-function")[invertible] with inverse $g$.
]

#important[
  Consider $f: NN->NN$ with $x|->x+1$, $g: NN->NN$ with $x|->cases(
    x-1 quad &x!=1,
    1 quad &x=1
  )$.

  We have $g compose f = id_NN$ but $f compose g != id_NN$ since $f compose g(1)=2$.
]

#proposition[
  $f:A->B$ is #ponder("set-theory.invertible-function")[invertible] if and only if $f$ is #ponder("algebra.bijection")[bijective]. We write $f^(-1):B->A$ for the inverse of $f$.
]

#proof[

  1. We shall first consider the necessary condition that, given $f: A ->B$, there is a map $g: B->A$ such that $g compose f = id_A$.

    *Necessary condition.* If such a $g$ were to exist, and $a, overline(a) in A$ such that $f(a)=f(overline(a))$, then $g(f(a))=g(f(overline(a)))$. Hence $a = overline(a)$. Thus $f$ must be #ponder("set-theory.injection-surjection")[injective].

    *Sufficient condition.* Now let us consider the sufficient conditions. Conversely, if $f$ is #ponder("set-theory.injection-surjection")[injective], we want to show that we can find $g$ such that $g compose f = id_A$. Consider some $b in B$.

    - If $b in f(A)$. let $g(b)=a$, where $a$ the unique element of $A$ with $f(a)=b$.

    - If $b in.not f(a)$, then let $g(b)$ be anything in the #ponder("set-theory.set")[set] $A$.

    So we have constructed the required #ponder("set-theory.function")[function] $g$ such that $g compose f = id_A$, and the condition of $f$ being #ponder("set-theory.injection-surjection")[injective] is sufficient.

  2. We can take a step further to consider the conditions for $f$ to be #ponder("set-theory.invertible-function")[invertible], _i.e._ $f compose g = id_B$ as well.

    *Necessary condition.* We need $f(g(B))=B$, so $f$ must be #ponder("set-theory.injection-surjection")[surjective].

    *Sufficient condition.* Conversely, if $f$ is #ponder("set-theory.injection-surjection")[surjective], we want to find $g: B->A$ with $f compose g=id_B$. For each $b in B$, pick some $a in A$ with $f(a)=b$. This always exists due to #ponder("set-theory.injection-surjection")[surjectivity] of $f$, and choose $g(b)=a$.

  Note that our construction of $g$ in the two parts are consistent. Hence, the result follows.
]

#remark[
  The #ponder("set-theory.image-preimage")[preimage] of a #ponder("set-theory.function")[function] always exists, but the inverse may not.
]

== #ponder("set-theory.relation")[Relations]

#definition("Relation")[
  A *#ponder("set-theory.relation")[relation]* on a #ponder("set-theory.set")[set] $X$ is a #ponder("set-theory.subset")[subset] $R subset.eq X times X$.

  We write $a R b$ if $(a, b) in RR$. We say that $a$ and $b$ are related by $R$.
] <def-relation>

#example([Examples of relations on $NN$])[
  1. $a R b$ if $a, b$ share the same final digit
  2. $a R b$ if $a < b$
  3. $a R b$ if $a != b$
  4. $a R b$ if $a = b = 1$
  5. $a R b$ if $abs(a-b)<=3$
] <ex-relations>

There are three properties of a #ponder("set-theory.relation")[relation] that are of special interest.

#definition("Relation reflexitivity, symmetry and transitivity")[
  A #ponder("set-theory.relation")[relation] $R$ on $X$ is...
  - *#ponder("set-theory.reflexivity-symmetry-transitivity")[reflexive]* if $forall x in X$, $x R x$.
  - *#ponder("set-theory.reflexivity-symmetry-transitivity")[symmetric]* if $forall x, y in X$, $x R y => y R x$.
  - *#ponder("set-theory.reflexivity-symmetry-transitivity")[transitive]* if $forall x, y, z in X$, $x R y and y R z => x R z$.
] <def-relation-props>

#example[
  Let us do a property check over @def-relation-props on the examples in @ex-relations.
  #align(center)[
    #table(
      columns: 6,
      [*Example \#*], [1], [2], [3], [4], [5],
      [*Reflexive*], [$checkmark$], [$crossmark$], [$crossmark$], [$crossmark$], [$checkmark$],
      [*Symmetric*], [$checkmark$], [$crossmark$], [$checkmark$], [$checkmark$], [$checkmark$],
      [*Transitive*], [$checkmark$], [$checkmark$], [$crossmark$], [$checkmark$], [$crossmark$],
    )
  ]
]

#definition("Equivalence relation")[
  A #ponder("set-theory.relation")[relation] $R$ is an *#ponder("set-theory.equivalence-relation")[equivalence relation]* if it is #ponder("set-theory.reflexivity-symmetry-transitivity")[reflexive], #ponder("set-theory.reflexivity-symmetry-transitivity")[symmetric] and #ponder("set-theory.reflexivity-symmetry-transitivity")[transitive].

  We usually write $a ~ b$ for the case where $a R b$ and $R$ is an #ponder("set-theory.equivalence-relation")[equivalence relation].
] <def-equivalence-relation>

In @ex-relations, only (1) is an #ponder("set-theory.equivalence-relation")[equivalence relation].

#example[
  Let $X = {"IA students"}$.

  Let $a R b$ if two students are born in the same month. Then $R$ is an #ponder("set-theory.equivalence-relation")[equivalence relation].

  Note that, in the example above, the #ponder("set-theory.set")[set] $X$ is divided into #ponder("set-theory.subset")[subsets] consisting of related elements.
]

#lecture-separator(lecture: 6, date: "2025-10-21")

#definition("Equivalence class")[
  If $~$ is an #ponder("set-theory.equivalence-relation")[equivalence relation] on $X_1$, then the *equivalence class* of $x in X$ is denoted by
  $ [x] = {y in X: y ~ x}. $
] <def-equivalence-class>

#definition("Partition")[
  Given a #ponder("set-theory.set")[set] $X$, a *#ponder("set-theory.partition")[partition]* of $X$ is a collection of pairwise #ponder("set-theory.set-operations")[disjoint] #ponder("set-theory.subset")[subsets] whose #ponder("set-theory.set-operations")[union] is $X$.
] <def-partition>

#theorem[
  Let $~$ be an #ponder("set-theory.equivalence-relation")[equivalence relation] on $X$. Then, the #ponder("set-theory.equivalence-class")[equivalence classes] from a #ponder("set-theory.partition")[partition] of $X$.
] <thm-equivalence-partition>

#proof[
  Since $~$ is #ponder("set-theory.reflexivity-symmetry-transitivity")[reflexive], we have $x in [x]$ for all $x in X$. Thus $union.big_(x in X) [x] = X$.

  It remains to #ponder("set-theory.proof")[prove] that $forall x, y in X$, either $[x] inter [y] = emptyset$ or $[x] = [y]$

  #align(center)[
    #dynamic-svg("/part-ia/numbers-and-sets/media/d1e1.svg", width: 20em)
  ]

  Suppose that $[x] inter [y] != emptyset$, and let $z in [x] inter [y]$. Then $z ~ x$, and so by #ponder("set-theory.reflexivity-symmetry-transitivity")[symmetry], $x ~ z$, and $z ~ y$. By #ponder("set-theory.reflexivity-symmetry-transitivity")[transitivity], $x ~ y$.

  Let now $w in [y]$, so $y ~ w$. Since $x ~ y$, by #ponder("set-theory.reflexivity-symmetry-transitivity")[transitivity], $x ~ w$. Thus $w in [x]$.

  Hence if $[x] inter[y] != emptyset$ then $[y] subset.eq [x]$. By #ponder("set-theory.reflexivity-symmetry-transitivity")[symmetry], we have $[x] subset.eq [y]$. Therefore, $[x] = [y]$.
]

Conversely, given any #ponder("set-theory.partition")[partition] of $X$, there is an #ponder("set-theory.equivalence-relation")[equivalence relation] $R$ whose #ponder("set-theory.equivalence-class")[equivalence classes] are precisely the parts of the #ponder("set-theory.partition")[partition]: just define $a R b$ if $a$ and $b$ lie in the same part.

#align(center)[
  #dynamic-svg("/part-ia/numbers-and-sets/media/d1e2.svg", width: 20em)
]

#definition[
  Given an #ponder("set-theory.equivalence-relation")[equivalence relation] $R$ on a #ponder("set-theory.set")[set] $X$, the *#ponder("set-theory.quotient")[quotient]* $X$ by $R$ is
  $ X \/ R = {[x]:x in X} $

  _e.g._ in @ex-relations (1), $X \/ R = {[0], [1], ..., [9]}$ with #ponder("set-theory.cardinality")[size] $10$.
] <def-quotient>

#definition[
  The map $q: X->X\/R$ with $x|->[x]$ is the *#ponder("set-theory.quotient-map")[quotient map]* or the *#ponder("set-theory.quotient-map")[projection map]*.

  #align(center)[
    #dynamic-svg("/part-ia/numbers-and-sets/media/d1e3.svg", width: 16em)
  ]
] <def-quotient-map>

#example[
  On $ZZ times NN$ define $(a, b) R (c, d)$ if $a d = b c$. This is an #ponder("set-theory.equivalence-relation")[equivalence relation], and note that
  $ [(1, 2)] = {(1, 2), (2, 4), (3, 6), ...}, $
  so we could regard $ZZ times NN \/ R$ as a copy of $QQ$ by identifying $[(a, b)]$ with $(a)/(b) in QQ$.

  The #ponder("set-theory.quotient-map")[quotient map] is $q: ZZ times NN -> ZZ times NN \/ R$ where $(a, b) |-> (a)/(b)$.
]

#definition("Binary operation")[
  A *#ponder("algebra.binary-operation")[binary operation]* $*$ on a #ponder("set-theory.set")[set] $A$ is a #ponder("set-theory.function")[function] $*: A times A -> A$.
]

#example("Examples of binary operations")[
  1. $+$, $times$ on $NN, ZZ, ...$
  2. $-$ on $ZZ,RR, ...$
  3. $div$ on $QQ^*, RR^*, ...$
]

#definition("Commutativity, associativity and distributivity of binary operations")[
  We say a #ponder("algebra.binary-operation")[binary operation] $*$ on $A$ is
  - *#ponder("algebra.commutativity-associativity-distributivity")[commutative]* if $forall x, y in A$, $x * y = y * x$.

    _e.g._ #ponder("set-theory.set")[set] #ponder("set-theory.set-operations")[intersection] is #ponder("algebra.commutativity-associativity-distributivity")[commutative]

  - *#ponder("algebra.commutativity-associativity-distributivity")[associative]* if $forall x, y, z in A$, $x * (y * z) = (x * y) * z$.

  - *#ponder("algebra.commutativity-associativity-distributivity")[distributive]* over $dot.o$ if for another #ponder("algebra.binary-operation")[binary operation] $dot.o$, $forall x, y, z in A$, we have $ x * (y dot.o z ) & = (x * y) dot.o (x * z) \
     (y dot.o z) * x & = (y * x) dot.o (z * x). $

    _e.g._ $times$ is #ponder("algebra.commutativity-associativity-distributivity")[distributive] over $+$ on $RR$.
] <def-binop-properties>
