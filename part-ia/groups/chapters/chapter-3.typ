#import "../prelude.typ": *

#lecture-separator(lecture: 8, date: "2025-10-27")

= #ponder("algebra.lagrange-theorem")[Lagrange's Theorem]

This very important theorem helps us to think about the #ponder("algebra.group-order")[orders] of #ponder("algebra.group")[groups] and #ponder("algebra.subgroup")[subgroups].

#theorem[Lagrange's Theorem, Weak Version][
  If $H <= G$ and $abs(G)<= oo$, then $abs(H) | abs(G)$.
]

The idea of this theorem is to somehow #ponder("algebra.coset-partition")[partition] the #ponder("algebra.group")[group] $G$ into #ponder("algebra.coset")[cosets] of $H$.

== #ponder("algebra.coset")[Cosets]

#definition[Left Cosets][
  Let $H<= G$ and $g in G$. The corresponding *#ponder("algebra.coset")[left coset]* is
  $ g H eq.def {g h : h in H} subset.eq G $

  The set of all #ponder("algebra.coset")[left cosets] of $H$ in $G$ is denoted by $ G \/ H = {g H : g in G}. $
] <left-cosets>

#remark[
  We may similarly define *#ponder("algebra.coset")[right cosets]*
  $ H g eq.def {h g: h in H} subset.eq G. $
  The set of #ponder("algebra.coset")[right cosets] of $H$ in $G$ is denoted by $ H \\ G = {H g : g in G}. $
]

#lemma[
  If $H <= G$, the #ponder("algebra.coset")[left cosets] *#ponder("algebra.coset-partition")[partition]* $G$. That is,

  1. $G = union.big_(g H in G\/ H) g H$

  2. If $g_1 H inter g_2 H != emptyset$, then $g_1 H = g_2 H$ for any $g_1 H, g_2H in G\/H.$
] <cosets-partition>

#proof[

  1. For any $g in G$, we have $g in g H$ since $e in H$. Thus, $g in union.big_(g H in G\/ H) g H$. Hence, $G subset.eq union.big_(g H in G\/ H) g H$. The reverse inclusion is obvious. Hence the equality holds.

  2. Suppose $g_1 H inter g_2 H != emptyset$, so there is a $k$ in the intersection. Then,
    $ k = g_1 h_1 = g_2 h_2 $
    for some $h_1, h_2 in H$. Thus,
    $ g_1 = g_2 h_2 h_1^(-1). $
    Since $H$ is a #ponder("algebra.group")[group], $h_2 h_1^(-1) in H$. Thus
    $ g_1 in g_2 H. $
    Furthermore, for any $h in H$,

    $ g_1 h = g_2 (h_1 h_1^(-1)) h in g_2 H. $
    Hence $g_1 H subset.eq g_2 H$. By symmetry, we have the reverse inclusion. Thus, the equality holds.
]


A schematic picture of the lemma above is shown below.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d4e1.svg", width: 22em)
]

However, we can say more about the #ponder("algebra.coset-cardinality")[sizes of the cosets].

#lemma[
  Let $H <= G$, then there is a #ponder("algebra.bijection")[bijection]
  $ H -> g H $
  for any $g in G$. In particular, $abs(g H) = abs(H)$.
] <coset-cardinality>

#proof[
  The map $H -> g H$ defined by $h |-> g h$ has inverse $g H -> H$ defined by $g h |-> g^(-1) (g h) = h$. Hence it is a #ponder("algebra.bijection")[bijection].
]

So the schematic picture above can be redrawn, where each #ponder("algebra.coset")[coset] has the #ponder("algebra.coset-cardinality")[same size as] $H$.

#align(center)[
  #dynamic-svg("/part-ia/groups/media/d4e2.svg", width: 22em)
]


#definition[Index of a Subgroup][
  Let $H <= G$. The *#ponder("algebra.subgroup-index")[index]* of $H$ in $G$ is defined as
  $ [G : H] eq.def abs(G \/ H). $
] <subgroup-index>

#theorem[#ponder("algebra.lagrange-theorem")[Lagrange's Theorem]][
  If $H <= G$ and $abs(G) <= oo$, then
  $ abs(G) = [G : H] dot abs(H). $
] <lagranges-theorem>

#proof[
  Since #ponder("algebra.coset")[left cosets] #ponder("algebra.coset-partition")[partition] $G$,
  $ abs(G) = sum_(g H in G\/ H) abs(g H) = sum_(g H in G \/ H) abs(H) = [G : H] dot abs(H) $
]

== Consequences of #ponder("algebra.lagrange-theorem")[Lagrange's Theorem]

#corollary[
  If $abs(G) < oo$ and $g in G$, then
  $ o(g) mid(|) abs(G). $
] <cor-lagrange-1>

#proof[
  Recall that $o(g) = abs(lr(chevron.l g chevron.r))$ and $abs(lr(chevron.l g chevron.r)) mid(|) abs(G)$ by #ponder("algebra.lagrange-theorem")[Lagrange's Theorem].
]

#corollary[
  If $abs(G) < oo$ and $y in G$, then $g^abs(G) = e_G$.
] <cor-lagrange-2>

#proof[
  @cor-lagrange-1 says that $abs(G) = k o(g)$  for some $k in ZZ$, so
  $ g^abs(G) = g^(k o(g)) = (g^(o(g)))^k = e_G^k = e_G. $
]

#corollary[
  If $abs(G)$ is prime, then $G$ is #ponder("algebra.cyclic-group")[cyclic], and any element $g != e$ #ponder("algebra.generated-subgroup")[generates] it.
]
<prime-order-group>

#proof[
  Choose any $g != e$. Then
  $ o(g) mid(|) G. $
  So, since $abs(G)$ is prime, either $o(g) = 1$ or $o(g) = abs(G)$.
  Since $g != e$, we must have $o(g) = abs(G)$. Therefore,
  $ G = lr(chevron.l g chevron.r). $
  So $g$ #ponder("algebra.generated-subgroup")[generates] $G$, and hence $G$ is #ponder("algebra.cyclic-group")[cyclic].
]

== Applications of #ponder("algebra.lagrange-theorem")[Lagrange's Theorem]

@lagranges-theorem[Lagrange's theorem] implies an important result in number theory.

#definition[Euler totient function][
  The *#ponder("algebra.euler-totient-function")[Euler totient function]*
  $ phi(n) = hash {x in Z_n:gcd(x, n) = 1}. $
]
<euler-totient-function>

Let $times_n$ denote #ponder("algebra.binary-operation")[multiplication] modulo $n$ on $ZZ_n$, which is #ponder("algebra.group")[associative] with #ponder("algebra.group")[identity] $1$.

#lecture-separator(lecture: 9, date: "2025-10-29")

Recall that by the division algorithm, $x in ZZ_n$ has a #ponder("algebra.inverse-element")[multiplicative inverse] modulo $n$, iff there are $y , m in ZZ$ such that
$
      & x y + m n &  = 1 \
  <=> & gcd(x, n) & = 1.
$

Hence,

$ ZZ_n^* := {x in ZZ_n : gcd(x, n) = 1} $

is a #ponder("algebra.group")[group] with #ponder("algebra.binary-operation")[operation] $times_n$.

#theorem("Fermat-Euler Theorem")[
  Let $x, n in ZZ$. If $gcd(x, n) = 1$, then
  $ x^(phi(n)) equiv 1 mod n. $
]
<fermat-euler-theorem>

#proof[
  By @cor-lagrange-2, we have
  $ x^(abs(ZZ_n^*)) = 1 mod n. $
  And by definition $ abs(ZZ_n^*) = phi(n). $
]
