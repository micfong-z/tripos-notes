#import "../prelude.typ": *

#lecture-separator(lecture: 1, date: "2025-10-09")

= Introduction to Number Systems and Logic

As an introduction to university-level mathematics, we will look at precise definitions, rigorous #ponder("set-theory.proof")[proofs], and fundamental theorems. To begin with, let us look at the definitions of a #ponder("set-theory.statement")[statement] and a #ponder("set-theory.proof")[proof].

#definition("Statement")[
  A *#ponder("set-theory.statement")[statement]* is a sentence that can have a true or false value.
] <def-statement>

If were to #ponder("set-theory.proof")[prove] a #ponder("set-theory.statement")[statement], we need a #ponder("set-theory.proof")[proof].

#definition("Proof")[
  A *#ponder("set-theory.proof")[proof]* is a sequence of true #ponder("set-theory.statement")[statements] without logical gaps, that establishes some conclusions.
] <def-proof>

We want to prove things because
- we want to know if they are true;
- we want to gain insights into why they are true;
- the #ponder("set-theory.proof")[proof] itself might be cool.

== Number Systems

#notation[ These number systems should be fairly familiar:
  #table(
    columns: (2em, 1fr),
    row-gutter: 0.5em,
    [$NN$], [the set of natural numbers (positive integers)],
    [$ZZ$], [the set of integers],
    [$QQ$], [the set of rational numbers, _i.e._ all fractions of the form $(a)/(b)$ where $a, b in ZZ$ and $b!=0$],
  )
]

Conside the length $x$ of the hypotenuse in a right-angled isosceles triangle with side lengths 1. The Pythagorean realized that $x in.not QQ$. To show that $x=sqrt(2)$ exists, we need to construct a new number system $RR$, where $exists x in RR$ such that $x^2=2$.

#definition("Algebraic number")[
  A real number is *#ponder("number-theory.algebraic-number")[algebraic]* if it is the root of some polynomial with integer coefficients. _e.g._ $sqrt(2)$.
] <def-algebraic-number>

#definition("Transcendental number")[
  A real non-algebraic number is *#ponder("number-theory.transcendental-number")[transcendental]*. _e.g._ $ppi$. #fade[[Existence of such #ponder("number-theory.transcendental-number")[transcendental numbers] was only shown as late as 1844.]]
] <def-transcendental-number>

== #ponder("set-theory.proof")[Proofs] and Non-proofs

Let us take a look at a few examples of #ponder("set-theory.proof")[proofs] (and non-proofs).

#claim[
  For all positive integers $n$, $n^3-n$ is always a multiple of 3.
]
#proof[
  For any $n in ZZ^+$, we have
  $
    n^3-n & = n(n^2-1) \
          & = (n-1)n(n+1). \
  $
  One of the 3 consecutive integers $n-1, n, n+1$ must be a multiple of 3, and hence the product.
]

Here is an example of a false #ponder("set-theory.proof")[proof].

#claim[
  For any positive integer $n$, if $n^2$ is even, then so is $n$.
]

#prooflike("Non-proof")[
  Given a positive integer $n$, which is even, we can write $n=2k$ for some $k in ZZ$.

  Then we have $n^2=4k^2=2(2k^2)$, which is even.
]

Note that we have falsely #ponder("set-theory.proof")[proven] the converse above. Here is a corrected version of the #ponder("set-theory.proof")[proof]:

#proof[
  Assume that $n^2$ is even but $n$ is odd. Then $n=2k+1$ where $k in ZZ$, and $n^2=4k^2+4k+1=2(2k^2+2k)+1$, which is odd. $smash$
]

We have used the technique of _proof by contradiction_, where we assume the contrary and deduce a contradiction (so the assumption would be false).

We can also #ponder("set-theory.proof")[prove] that something is false, usually by a counterexample.

#claim[
  For any positive integer $n$, if $n^2$ is a multiple of 9, then so is $n$.
]

#prooflike("Disproof")[
  A counterexample is $n=3$.
]

#lecture-separator(lecture: 2, date: "2025-10-11")

We write $A=> B$ for the #ponder("set-theory.statement")[statement] "if A then B".

#claim[
  The solution to $x^2-5x+6=0$ is $x=2$ or $x=3$.
]

This is in fact 2 #ponder("set-theory.statement")[assertions]:

1. $x=2$ and $x=3$ are solutions
2. there are no other solutions

#proof[
  1. If $x=2$ or $x=3$, we have $x-2=0$ or $x-3=0$. Hence $(x-2)(x-3)=0$.

    Thus, we have $x^2-5x+6=0$.

  2. If $x^2-5x+6=0$, then $(x-2)(x-3)=0$. So $x=2$ or $x=3$.

    Hence the only solutions are $x=2$ and $x=3$.

  Alternatively, we could write the following:

  $
    &     &     x=2 "or" x & =3 \
    & <=> & x-2=0 "or" x-3 & =0 \
    & <=> &     (x-2)(x-3) & =0 \
    & <=> &       x^2-5x+6 & =0.
  $
]

It is vital that every step is using $<=>$.

#claim[
  Every positive real number is greater than or equal to 1.
]

#prooflike("Non-proof")[
  Let $r$ be the least positive real number.

  Either $r=1$ or $r<1$ or $r>1$. #fade[[This is a trichotony.]]

  If $r<1$, then $0<r^2 <r$. However, $r$ is the least positive real number. $smash$

  If $r>1$, then $0<sqrt(r)<r$. $smash$

  Hence $r=1$.
]

We assumed a false claim in the #ponder("set-theory.proof")[proof]: there is no least positive real number.

#remarklike("Moral")[
  Every claim must be justified.
]

== Basic Logic

If $A$ and $B$ are #ponder("set-theory.statement")[assertions], we can write:
- $A and B$ for "$A "AND" B$",
- $A or B$ for "$A "OR" B$",
- $not A$ for "$"NOT" A$".

=== Truth Tables

The truth of these #ponder("set-theory.statement")[assertions] depends on the truth of $A$ and $B$, and can be summerized in a *truth table*.

#align(center)[
  #table(
    columns: 6,
    $A$, $B$, $A and B$, $A or B$, $not A$, $A=>B$,
    [F], [F], [F], [F], [T], [T],
    [F], [T], [F], [T], [T], [T],
    [T], [F], [F], [T], [F], [F],
    [T], [T], [T], [T], [F], [T],
  )
]

Note, _e.g._, that $not (A and B)$ is equivalent to $(not A) or not B)$, by comparing truth tables.

Also, $A=>B$ is equivalent to $(not A) or B$, and hence $B or (not A)$, and so to $(not B) => (not A)$. This is called the *contrapositive*.

A claim may include *quantifiers*, especially $forall$ "for all" and $exists$ "there exists".

=== Negating Quantifiers

We have

$
  not(forall x, A(x)) & <=> exists x, not A(x) \
    not (exists B(x)) & <=> forall x, not B(x).
$

#remark[
  The order of quantifiers matters.
]