#import "../prelude.typ": *
#show: chapter.with(1)

#lecture-separator(lecture: 1, date: "2026-10-09")

= Vector Spaces

#notation[
  Throughout this course, $FF$ will denote a field #fade[[for now, think of $FF = RR$ or $CC$]].

  $V$ will denote a $FF$-vector space.

  $A^B$ will denote the set of functions from $B$ to $A$.
]

#definition[Vector Space][
  An $FF$-*vector space* is an abelian group $(V, +, vb(0))$ equipped with an operation:
  $
     FF times V & -> V quad ("scalar multiplication") \
    (lambda, v) & |-> lambda v
  $
  satisfying, $forall lambda, mu in FF$, $forall v, w in V$,

  + $lambda(v + w) = lambda v+ lambda w$;

  + $(lambda + mu) v = lambda v + mu v$;

  + $lambda(mu v) = (lambda mu) v$;

  + $1 dot v = v$.
]

#notation[
  We will not use bold face for vectors, except $vb(0)$, the additive identity in $V$. Note that $0$ is the additive identity in $FF$.
]

#example[
  The following are examples of vector spaces:

  + $FF^n$, column vectors of length $n$ with entries in $FF$.

  + $MM_(m times n) (FF)$, matrices with $m$ rows and $n$ columns with entries in $FF$.

  + $CC^n$ is a $CC$-vector space. However, it is also an $RR$-vector space.

  + For any set $X$, define
    $
      FF^X = Set("functions from" X "to" FF) .
    $

    We define, for $f, g in FF^X$, $lambda in FF$,
    $
      (f + g)(x) = f(x) + g(x)quad "and" quad (lambda f)(x) = lambda dot f(x)
    $
    for all $x in X$.
]

#exercise[
  Show that $forall v in V$,
  $
    0 dot v= vb(0), quad (-1) dot v = -v.
  $
]

#definition[Subspace][
  For $U subset.eq V$, $U$ is a *subspace* of $V$ if $U$ is an $FF$-vector space under the same operations as $V$.

  Equivalently, $(U, +, vb(0))$ is a subgroup under $+$ of $(V, +, vb(0))$, and $forall lambda in FF$, $forall u in U$, $lambda u in U$.

  We write $U <= V$.
]

#proposition[Subspace test][
  For $U subset.eq V$, $U <= V$ iff

  + $U$ is non-empty;

  + $forall u, w in U$, $forall lambda in FF$,

    $
      u + lambda w in U.
    $
] <prop-subspace-test>

#proof[
  #fade[[$=>$]] If $U <= V$ then (1), (2) clearly hold.

  #fade[[$arrow.double.l$]] Conversely, set $lambda = -1$ in (2). Then
  $
    u - w in U quad forall u, w in U.
  $
  By the Subgroup Test from IA Groups,
  $
    (U, +, vb(0)) <= (V, +, vb(0)).
  $
  Finally, set $u = vb(0)$ in (2). Then $lambda w in U$ for all $w in U$ and $lambda in FF$. Thus $U <= V$.
]

#warning[
  Do not forget to check for non-emptiness when checking if a subset is a subspace.
]

#example[
  + For $t in RR$,
    $
      Set(vec(x, y, z) in RR^3, x+y+z=t)
    $
    is a subspace of $RR^3$ iff $t=0$.

  + We have the following chain of subspaces of $RR^RR$:
    $
         & RR^RR     & = & Set("functions" RR -> RR) \
      >= & C(RR)     & = & Set("continuous functions" RR -> RR) \
      >= & C^oo (RR) & = & Set("infinitely differentiable functions" RR -> RR) \
      >= & P(RR)     & = & Set("polynomials of the form" x |-> a_n x^n + ... + a_1 x + a_0 "with" a_i in RR) \
    $
]

#proposition[
  For $U, W <= V$, then $U inter W <= V$.
]

#proof[
  Using @prop-subspace-test[Subspace Test],

  + $U <= V => vb(0) in U$, and $W <= V => vb(0) in W$, so $vb(0) in U inter W$. Hence $U inter W != emptyset$.

  + Let $x, y in U inter W, lambda in FF$. Then $x, y in U$ and $x, y in W$.

    Since $U <= V$ and $W <= V$, we have $x + lambda y in U$ and $x + lambda y in W$. Hence $x + lambda y in U inter W$.
]

#warning[
  For $U, W <= V$, $U union W$ is _almost never_ a subspace of $V$. #fade[[See details on Example Sheet 1.]]
]

#definition[Subspace sum][
  For $U, W <= V$, the *sum* of $U$ and $W$ is
  $
    U + W = {u + w: u in U, w in W} subset.eq V.
  $
]

#proposition[
  For any $U, W <= V$, we have $U + W <= V$.
]

#proof[
  Direct from @prop-subspace-test[Subspace Test].
]

#remark[
  $U + W$ is the _smallest_ subspace of $V$ containing both $U$ and $W$.
]

== Linear Maps

#definition[Linear Maps][
  Let $V$ and $W$ be $FF$-vector spaces. A function $alpha: V-> W$ is a *linear map* if $forall u, w in V, lambda in FF$,
  $
         alpha(u+w) & = alpha(u) + alpha(w), "and" \
    alpha(lambda u) & = lambda alpha(u).
  $
  Equivalently, $alpha$ is linear iff $forall u, w in V, lambda in FF$,
  $
    alpha(u + lambda w) = alpha(u) + lambda alpha(w).
  $
]

#remark[
  If $V = W$, $alpha$ is called an *endomorphism* of $V$.
]

#example[
  The following are examples of linear maps:

  + Let $V = FF^n, W = FF^m$, $matbold(A) in MM_(m times n) (FF)$, then
    $
      alpha: V -> W, quad v |-> matbold(A) v
    $
    is a linear map.

  + The differentiation map
    $
      alpha: C^oo (RR) -> C^oo (RR), quad f |-> f'
    $
    is a linear map.

  + The integration map
    $
      alpha: C(RR) -> RR, quad f |-> integral_(0)^(1) f(x) dif x
    $
    is a linear map.

  + Consider a non-empty set $X$. Let $x_0 in X$. Define
    $
      e_(x_0): FF^X & -> FF \
                  f & |-> f(x_0)
    $
    is a linear map #fade[[this is the *evaluation map* at $x_0$]].

  + For any $FF$-vector space $V$, the *identity map*
    $
      id_V: V -> V, quad v |-> v
    $
    is a linear map.

  + For any $FF$-vector spaces $V, W$, the *zero map*
    $
      0: V -> W, quad v |-> vb(0)_W
    $
    is a linear map.

  + Let $alpha: U-> V$, $beta: V->W$ be linear maps. Then the *composition*
    $
      beta compose alpha: U -> W, quad u |-> beta(alpha(u))
    $
    is a linear map.
]

#example[
  The following are examples of non-linear maps:

  Let $alpha, beta: RR -> RR$:

  $
    alpha(x) = x^2, quad beta(x) = x + 1.
  $
]

#exercise[
  Consider $alpha: CC -> CC$ with $z |-> overline(z)$. Is this a linear map?
]

#definition[Isomorphism][
  Let $V, W$ be $FF$-vector spaces. A linear map $alpha: V-> W$ is an *isomorphism* if it is a bijection.

  We write $V teq W$ and say that $V$ and $W$ are *isomorphic* if there exists an isomorphism from $V$ to $W$.
]

#example[
  The map
  $
        alpha: FF^4 & -> MM_(2 times 2)(FF) \
    vec(a, b, c, d) & |-> mat(a, b; c, d)
  $
  is an isomorphism.
]

#lecture-separator(lecture: 2, date: "2026-10-12")

#proposition[
  Let $V, W$ be $FF$-vector spaces. If $alpha: V -> W$ is an isomorphism, then so is $alpha^(-1) : W -> V$.
]

#proof[
  Bijection is clear by IA Numbers and Sets.

  For linearity, let $w_1, w_2 in W$, $lambda in FF$. Let $v_i in V$ such that $alpha(v_i) = w_i$. Then
  $
    alpha^(-1)(w_1+lambda w_2) & = alpha^(-1)(alpha(v_1) + lambda alpha(v_2)) \
                               & = alpha^(-1)(alpha(v_1 + lambda v_2)) #eq-note($"by linearity of" alpha$) \
                               & = v_1 + lambda v_2 \
                               & = alpha^(-1)(w_1) + lambda alpha^(-1)(w_2).
  $
]

#remark[
  For any set $X$ of $FF$-vector spaces, the relation $teq$ is an equivalence relation on $X$.
]

#definition[Kernel and Image][
  Let $alpha: V->W$ be a linear map. The *kernel*  of $alpha$ is
  $
    ker alpha:= Set(v in V, alpha(v) = vb(0)_W).
  $
  The *image* of $alpha$ is
  $
    im alpha:= Set(alpha(v), v in V).
  $
]

#lemma[
  1. $ker alpha <= V$, $im alpha <= W$;

  2. $alpha$ is surjective iff $im alpha = W$;

  3. $alpha$ is injective iff $ker alpha = Set(vb(0)_V)$.
] <properties-of-kernel-and-image>

#proof[
  1. This mostly involves @prop-subspace-test.  In particular, we will need to use the fact that
    $
      alpha(vb(0)_V) = alpha(vb(0)_V + vb(0)_V) = alpha(vb(0)_V) + alpha(vb(0)_V)
    $
    and hence $alpha(vb(0)_V) = vb(0)_W$. Thus $vb(0)_V in ker alpha$ and $vb(0)_W in im alpha$.

  2. This is clear from the definition of $im alpha$.

  3. #fade[[$=>$]] Suppose that $alpha$ is injective. Then $alpha(vb(0)_V) = vb(0)_W$. Hence $vb(0)_V in ker alpha$. If $v in ker alpha$, then $alpha(v) = vb(0)_W = alpha(vb(0)_V)$. Since $alpha$ is injective, we have $v = vb(0)_V$. Thus $ker alpha = Set(vb(0)_V)$.

    #fade[[$arrow.l.double$]] Conversely, suppose that $ker alpha = Set(vb(0)_V)$. Let $u, v in V$ with $alpha(u) = alpha(v)$. Then $alpha(u) - alpha(v) = vb(0)_W$. By linearity, $alpha(u - v) = vb(0)_W$. Hence $u - v in ker alpha = Set(vb(0)_V)$, and so $u = v$.
]

#intuition[
  Here $V = RR^2$ and $W = RR$. The vectors with the same image as $v$ form the line $v + ker alpha$.
  #canvas({
    import draw: *
    let kb = rule("blue")
    let dot(p, fill) = circle(p, radius: 0.05, fill: fill, stroke: none)
    // ker alpha, and the line through v parallel to it
    line((-1.4, -0.7), (2.6, 1.3), stroke: kb + 0.8pt)
    line((-1.5, 0.5), (2.5, 2.5))
    content((-1.45, -0.7), anchor: "east", text(fill: ink("blue"), $ker alpha$))
    content((-1.55, 0.5), anchor: "east", $v + ker alpha$)
    content((-1.3, 2.3), $V$)
    // v, u and u - v
    line((0, 0), (-0.9, 0.8), mark: (end: ">"))
    line((0, 0), (2.0, 1.0), stroke: kb + 1.2pt, mark: (end: ">", fill: kb, stroke: kb))
    line((2.0, 1.0), (1.1, 1.8), stroke: (paint: rule("gray"), dash: "dashed"))
    dot((0, 0), ink("blue"))
    dot((1.1, 1.8), colors.text)
    dot((-0.9, 0.8), colors.text)
    content((0.15, -0.12), anchor: "north-west", text(fill: ink("blue"), $vb(0)$))
    content((-1.0, 0.92), anchor: "south-east", $v$)
    content((1.1, 1.95), anchor: "south", $u$)
    content((1.05, 0.32), anchor: "north-west", text(fill: ink("blue"), $u - v$))
    // W, and where the two lines go
    line((4.4, -0.6), (4.4, 2.6))
    content((4.4, 2.7), anchor: "south", $W$)
    dot((4.4, 0.4), ink("blue"))
    dot((4.4, 1.9), colors.text)
    content((4.55, 0.4), anchor: "west", text(fill: ink("blue"), $vb(0)$))
    content((4.55, 1.9), anchor: "west", $alpha(u) = alpha(v)$)
    let gm = (end: ">", fill: rule("gray"), stroke: rule("gray"))
    line((2.85, 1.35), (4.25, 0.45), stroke: rule("gray"), mark: gm)
    line((2.75, 2.55), (4.25, 1.95), stroke: rule("gray"), mark: gm)
    content((3.5, 2.4), anchor: "south", text(fill: ink("gray"), $alpha$))
  })
]

== Quotient Spaces

Let $V$ be a $FF$-vector space and $W <= V$. Let
$
  V \/ W = Set(v + W, v in V)
$
the set of left-cosets of $W$ in $V$.

Recall from IA Groups that for $u, v in V$,
#set math.equation(numbering: "(1)")
$
  u + W = v + W <=> u-v in W.
$ <eq-subspace-coset-equality>
#set math.equation(numbering: none)


#proposition[Quotient Space][
  The set $V \/ W$ is an $FF$-vector space called the *quotient space* of $V$ by $W$, under the operations:

  $
    (u + W) + (v + W) & = (u + v) + W, \
       lambda (v + W) & = (lambda v) + W.
  $
]

#prooflike[Sketch Proof][
  First check that the operations are well-defined, _i.e._ given $u_1, u_2, v_1, v_2 in V$ such that $u_i + W = v_i + W$, using @eq-subspace-coset-equality we have
  $
     (u_1 + u_2) + W & = (v_1 + v_2) + W \
    (lambda u_1) + W & = (lambda v_1) + W.
  $
  By IA Groups, $V \/ W$ is an abelian group under $+$. Vector space axioms are inherited from $V$.
]

#intuition[
  Here $V = RR^2$, the cosets of $W$ are the lines parallel to $W$, and $w_i = v_i - u_i in W$.
  #canvas(length: 1.25cm, {
    import draw: *
    let wb = rule("blue")
    let wm = (end: ">", fill: wb, stroke: wb)
    let dot(p) = circle(p, radius: 0.05, fill: colors.text, stroke: none)
    let (x0, x1) = (-1.4, 3.6)
    // W and three of its cosets
    line((x0, 0), (x1, 0), stroke: wb + 0.8pt)
    for y in (-0.9, 1.2, 2.1) { line((x0, y), (x1, y)) }
    content((x1 + 0.05, 0), anchor: "west", text(fill: ink("blue"), $W$))
    content((x1 + 0.05, -0.9), anchor: "west", $u_1 + W$)
    content((x1 + 0.05, 1.2), anchor: "west", $(u_1 + u_2) + W$)
    content((x1 + 0.05, 2.1), anchor: "west", $u_2 + W$)
    // changing the representatives moves each point along its coset
    line((1.2, -0.9), (2.5, -0.9), stroke: wb + 1.2pt, mark: wm)
    line((-0.8, 2.1), (0.6, 2.1), stroke: wb + 1.2pt, mark: wm)
    line((0.4, 1.2), (3.1, 1.2), stroke: wb + 1.2pt, mark: wm)
    for p in ((0, 0), (1.2, -0.9), (2.5, -0.9), (-0.8, 2.1), (0.6, 2.1), (0.4, 1.2), (3.1, 1.2)) { dot(p) }
    content((0, -0.1), anchor: "north", $vb(0)$)
    content((1.2, -1.0), anchor: "north", $u_1$)
    content((1.85, -1.0), anchor: "north", text(fill: ink("blue"), $w_1$))
    content((2.5, -1.0), anchor: "north", $v_1$)
    content((-0.8, 2.2), anchor: "south", $u_2$)
    content((-0.1, 2.2), anchor: "south", text(fill: ink("blue"), $w_2$))
    content((0.6, 2.2), anchor: "south", $v_2$)
    content((0.4, 1.3), anchor: "south", $u_1 + u_2$)
    content((1.75, 1.1), anchor: "north", text(fill: ink("blue"), $w_1 + w_2$))
    content((3.1, 1.3), anchor: "south", $v_1 + v_2$)
  })
]

#proposition[
  There is a surjective linear map
  $
    pi_W: V & -> V \/ W \
          v & |-> v + W
  $
  called the *quotient map*. We have $ker pi_W = W$.
] <prop-quotient-map>

#proof[
  Surjectivity is clear. For linearity, let $u, v in V$ and $lambda in FF$. Then
  $
    pi_W (u + lambda v) & = (u + lambda v) + W \
                        & = (u + W) + (lambda v + W) \
                        & = (u + W) + lambda (v + W) \
                        & = pi_W (u) + lambda pi_W (v). \
  $
  For $v in V$,
  $
    v in ker (pi_W) & <=> v+ W = vb(0)_V + W \
                    & <=> v = v - vb(0)_V in W #eq-note($"by" #ref(<eq-subspace-coset-equality>)$) \
  $
]

#theorem[First Isomorphism Theorem][
  Let $V, W$ be $FF$-vector spaces, and $alpha: V-> W$ be a linear map. Then there is an isomorphism
  $
    overline(alpha): V \/ ker alpha & -> im alpha \
                      v + ker alpha & |-> alpha(v).
  $
] <thm-first-isomorphism-theorem>

#proof[
  We will write $K = ker alpha$. For $u, v in V$,
  $
    u + K = v + K & <=> u - v in K #eq-note($"by" #ref(<eq-subspace-coset-equality>)$) \
                  & <=> alpha(u - v) = vb(0)_W \
                  & <=> alpha(u) = alpha(v) \
                  & <=> overline(alpha)(u + K) = overline(alpha)(v + K).
  $
  Hence, the $=>$ direction shows that $overline(alpha)$ is well-defined, and the $arrow.l.double$ direction shows that $overline(alpha)$ is injective.

  For surjectivity, let $w in im alpha$. Then there exists $v in V$ such that $alpha(v) = w$. Hence $overline(alpha)(v + K) = w$.

  For linearity, given $u, v in V$ and $lambda in FF$,
  $
    overline(alpha)((u + K) + lambda(v + K)) & = overline(alpha) ((u + lambda v) + K) \
                                             & = alpha(u + lambda v) \
                                             & = alpha(u) + lambda alpha(v) \
                                             & = overline(alpha)(u + K) + lambda overline(alpha)(v + K). \
  $
]

== Bases

#definition[Span][
  Let $V$ be a $FF$-vector space, and $S subset.eq V$.

  The *span* of $S$ in $V$ is
  $
    span(S) = Set(sum'_(s in S) lambda_s s, lambda_s in FF)
  $
  where $sum'$ denotes a finite sum, _i.e._ we require that $lambda_s = 0$ for all but finitely many $s in S$.

  Expression of the form $sum'_(s in S) lambda_s s$ is called a *linear combination* of $S$.

  We say that $S$ *spans* (or $S$ is a *spanning set* of) $V$ if $span(S) = V$.

  We say that $V$ is *finite-dimensional* if $V$ has a finite spanning set.
]

#remark[
  Let $S, T subset.eq V$.

  + $span(S) <= V$ by @prop-subspace-test.

  + By convention, $span(emptyset) = {vb(0)_V}$.

  + If $S$ spans $V$ and $S subset.eq span(T)$, then $T$ spans $V$.

  + $span(S union T) = span(S) + span(T)$.
]

#lecture-separator(lecture: 3, date: "2026-10-14")

#example[
  + Consider
    $
      V & = RR^3 \
      S & = Set(vec(1, 0, 0)\, vec(1, 1, 2)) \
      T & = Set(vec(2, 1, 2)\, vec(0, 1, 2)\, vec(-1, 2, 4)) \
    $
    Then $span(S) = span(T) = Set(vec(x, y, 2 y), x\, y in RR) <= RR^3$.

  + Consider
    $
      V & = RR^NN \
      T & = Set(delta_n, n in NN) subset.eq V \
    $
    where $delta_n: NN->RR$ is given by
    $
      delta_n (m) = cases(
        1 quad & "if" m = n,
        0 quad & "otherwise".
      )
    $
    Note that $span(T) != RR^NN$. For instance, if $f in RR^NN$ satisfies $f(n) = 1$ for all $n$, then $f in.not span(T)$ #fade[[there is no finite linear combination of $delta_n$'s that can produce $f$]].

    In fact,
    $
      span(T) = Set(g in V, g(n) = 0 "for all sufficiently large" n).
    $
] <ex-1>

#definition[Linear Independence][
  $S subset.eq V$ is *linearly independent* (L.I.) if, for every linear combination of $S$
  $
    sum'_(s in S) lambda_s s quad "with" lambda_s in FF,
  $
  if $sum'_(s in S) lambda_s s = vb(0)_V$, then $lambda_s = 0$ for all $s in S$.

  If $S$ is not linearly independent, then we say that $S$ is *linearly dependent* (L.D.)
]

#remark[

  + If $S subset.eq V$ is linearly independent, then $vb(0) in.not S$ #fade[[otherwise, we can take the linear combination $1 dot vb(0) = vb(0)$]].

  + If $S = {v_1, ..., v_n}$ is finite, then $S$ is linearly independent iff $forall lambda_1, ..., lambda_n$, if
    $
      sum_(i=1)^n lambda_i v_i = vb(0),
    $
    then $lambda_i = 0$ for all $i$.

  + If $S$ is infinite, then $S$ is linearly independent iff every finite subset of $S$ is linearly independent.

  + Every subset of a linearly independent set is linearly independent.
]

Let us visit @ex-1 again.

#example[
  For the examples in @ex-1,

  + note that
    $
      1 dot vec(2, 1, 2) - 5 dot vec(0, 1, 2) + 2 dot vec(-1, 2, 4) = vb(0) in RR^3,
    $
    so $T$ is linearly dependent.

    If we have $lambda, mu in RR$ such that
    $
      lambda vec(1, 0, 0) + mu vec(1, 1, 2) = vb(0),
    $
    then we have $vec(lambda + mu, mu, 2 mu) = vec(0, 0, 0)$, so $mu = 0$ and $lambda = 0$. Hence $S$ is linearly independent.

  + Let $f = sum'_(n in NN) lambda_n delta_n$ where $lambda_n in RR$. If $f equiv 0$, then for all $m in NN$, we have
    $
      0 = f(m) & = (sum'_(n) lambda_n delta_n) (m) \
               & = sum'_n lambda_n delta_n (m) \
               & = lambda_m.
    $
    Hence $lambda_n = 0$ for all $n$, and so $T$ is linearly independent.
]

#definition[Basis][
  $S subset.eq V$ is a *basis* for $V$ if $S$ is linearly independent and $span(S) = V$.
]

#example[
  + Let $e_i = vec(0, dots.v, 0, 1, 0, dots.v, 0) in FF^n$ #fade[[the $i$-th standard basis vector]] for $1 <= i <= n$.

    Then $Set(e_i, 1 <= i <= n)$ is the *standard basis* for $FF^n$.

  + $Set(vec(1, 0, 0)\, vec(1, 1, 0)\, vec(1, 1, 1)) subset.eq FF^3$  is a basis for $FF^3$.

  + Let $P(RR)$ be the space of real polynomial functions. Let $p_n: RR->RR$ be given by $p_n (x) = x^n$ where $n >= 0$. Then $Set(p_n, n >= 0)$ is a basis for $P(RR)$.
]

#proposition[
  Suppose $S subset.eq V$ is a finite spanning set. Then there exists $S' subset.eq S$ such that $S'$ is a basis for $V$.
]

#proof[
  If $S$ is linearly independent, then we are done. Otherwise, write $S = {v_1, ..., v_n}$, and $exists {lambda_i}$, not all zero, such that
  $
    sum_(i=1)^n lambda_i v_i = vb(0)
  $
  and WLOG $lambda_1 != 0$. Then
  $
    v_1 = -(1)/(lambda_1) sum_(i=2)^n lambda_i v_i in span(S \\ {v_1}).
  $
  So $S subset.eq span(S \\ {v_1})$. Hence $S \\ {v_1}$ spans $V$ by the remark earlier in this section.

  Repeating this process #fade[[this process terminates after at most $n$ steps]], we can remove vectors from $S$ until we obtain a linearly independent set $S' subset.eq S$ that spans $V$. Hence $S'$ is a basis for $V$.
]

#corollary[
  If $V$ is a finite-dimensional $FF$-vector space, then $V$ has a finite basis.
] <cor-finite-dimensional-has-finite-basis>

#warning[
  We will not prove that every vector space has a basis. This requires the Axiom of Choice, which is beyond the scope of this course.
]

#theorem[Steinitz Exchange Lemma][
  Let $V$ be a $FF$-vector space, $S, T subset.eq V$ be finite with $S$ linearly independent and $T$ spanning. Then,

  + $abs(S) <= abs(T)$;

  + there exists $T' subset.eq T$ such that $S union T'$ spans $V$, and $abs(T') = abs(T) - abs(S)$.

  #fade[[The idea is that removing (certain) elements of $T$ and replacing them by elements of $S$ still spans $V$.]]
] <thm-steinitz-exchange-lemma>

#proof[
  Let $S = Set(s_1\, ...\, s_m)$ and $T = Set(t_1\, ...\, t_n)$, where $m = abs(S)$ and $n = abs(T)$.

  If $S = emptyset$, then we are done #fade[[take $T' = T$]]. Otherwise, we will follow an iterative process:

  *Step 1.* Since $span(T) = V$, there exist $lambda_i in FF$ such that
  $
    s_1 = sum_(i=1)^n lambda_i t_i.
  $
  Recall that $s_1 != vb(0)$ since $S$ is linearly independent, so WLOG assume $lambda_1 != 0$, and hence
  $
    t_1 = (1)/(lambda_1)( s_1 - sum_(i=2)^n lambda_i t_i).
  $
  So $T subset.eq span(Set(s_1, t_2, ..., t_n;))$, and hence $Set(s_1, t_2, ..., t_n;)$ spans $V$.

  *Step $k + 1$* (where $k < m$)*.* Assume that $Set(s_1, ..., s_k, t_(k+1), ..., t_n;)$ spans $V$. Write
  $
    s_(k+1) = sum_(i=k+1)^n lambda_i t_i + sum_(j=1)^k mu_j s_j
  $
  where $lambda_i, mu_j in FF$. If all $lambda_i = 0$, then $s_(k+1) - sum_(j=1)^k mu_j s_j = vb(0)$, which contradicts the linear independence of $S$. $smash$ In particular, the first sum is non-empty, so $k + 1 <= n$.

  Hence WLOG $lambda_(k+1) != 0$, so we can write
  $
    t_(k+1) = (1)/(lambda_(k+1)) (s_(k+1) - sum_(i=k+2)^n lambda_i t_i - sum_(j=1)^k mu_j s_j).
  $
  Hence $Set(s_1, ..., s_(k+1), t_(k+2), ..., t_n;)$ spans $V$.

  Since step $k + 1$ succeeds for every $k < m$, we have $m <= n$, and $Set(s_1, ..., s_m, t_(m+1), ..., t_n;)$ spans $V$. We can take $T' = Set(t_(m+1), ..., t_n;)$, which has size $n - m$.
]

#intuition[
  Take $V = RR^3$, $T = {e_1, e_2, e_3}$, $s_1 = e_1 + e_2$ and $s_2 = e_1 + e_3$. Each set below spans $V$.
  #fletcher-diagram(
    spacing: (1.5em, 2.4em),
    node((0, 0), text(fill: ink("gray"))[Start]),
    node((0, 1), text(fill: ink("gray"))[Step 1]),
    node((0, 2), move(dy: -0.45em, text(fill: ink("gray"))[Step 2])),
    node((1, 0), ${cred(e_1), e_2, e_3}$),
    node((1, 1), ${cblue(s_1), cred(e_2), e_3}$),
    node((1, 2), $\{underbrace(cblue(s_1)\, cblue(s_2), S), underbrace(e_3, T')\}$),
    edge((1, 0), (1, 1), "->", label: $cblue(s_1) = cred(e_1) + e_2$, label-side: left),
    edge((1, 1), (1, 2), "->", label: $cblue(s_2) = cblue(s_1) - cred(e_2) + e_3$, label-side: left),
  )
]

There are several significant consequences of @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma].

#corollary[
  Let $V$ be a finite-dimensional $FF$-vector space. Then,

  + every basis for $V$ is finite;

  + if $B_1$, $B_2$ are (finite) bases for $V$, then $abs(B_1) = abs(B_2)$.
] <cor-basis-same-dim>

#proof[

  + By @cor-finite-dimensional-has-finite-basis, $V$ has a finite basis $B$. Suppose $B'$ is an infinite basis. Let $B'' subset.eq B'$ with $abs(B'') = abs(B) + 1$. Then $S = B''$ is linearly independent and $T = B$ spans $V$, contradicting @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma].

  + Let $B_1$, $B_2$ be finite bases for $V$. Using @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma] with $S = B_1$ and $T = B_2$, we have $abs(B_1) <= abs(B_2)$. Similarly, using $S = B_2$ and $T = B_1$, we have $abs(B_2) <= abs(B_1)$. Hence $abs(B_1) = abs(B_2)$.
]

#definition[Dimension][
  Let $V$ be a finite-dimensional $FF$-vector space. Then, the *dimension* $dim V$ of $V$ is the common size of any basis for $V$.
]

#lecture-separator(lecture: 4, date: "2026-10-16")

#example[
  $dim FF^n = n$ using the standard basis.
]

#corollary[
  Suppose that $V$ is a finite-dimensional $FF$-vector space. Take $S, T$ as in @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma]. Then,
  $
    abs(S) underbracket(<=, (1)) dim V underbracket(<=, (2)) abs(T),
  $
  with equality in $(1)$ iff $S$ is a basis for $V$, and equality in $(2)$ iff $T$ is a basis for $V$.
] <cor-inequality-dimensions>

#proof[
  The inequality follows immediately from @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma].

  If $S$ is a basis for $V$, then $abs(S) = dim V$ by @cor-basis-same-dim.

  Conversely, let $B$ be a basis for $V$, and suppose $abs(S) = dim V = abs(B)$. Applying @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma] with $S$ and $B$, we get some $B' subset.eq B$ such that $S union B'$ spans $V$. Note that $abs(B') = abs(B) - abs(S) = 0$, so $B' = emptyset$ and $S$ is a basis for $V$.

  The argument for $(2)$ is similar.
]

#proposition[
  Suppose that $V$ is a finite-dimensional $FF$-vector space. Let $U <= V$. Then $U$ is finite-dimensional and $dim U <= dim V$ with equality iff $U = V$.
]

#proof[

  If $U = {vb(0)}$ then there is nothing to prove. If not, then follow the following procedure:

  *Step 1*. Let $vb(0) != u_1 in U$.  Then ${u_1}$ is linearly independent.

  After *Step $k$*, we have a linearly independent set
  $
    S_k = {u_1, ..., u_k} subset.eq U.
  $
  By @cor-inequality-dimensions, $k <= dim V$. If $span(S_k) = U$, then we are done. If not, let $u_(k+1) in U \\ span(S_k)$ and set $S_(k+1) = {u_1, ..., u_k, u_(k+1)}$. We claim that $S_(k+1)$ is linearly independent.

  Suppose not, then $exists lambda_i in FF$ not all zero such that
  $
    vb(0) = sum_(i=1)^(k+1) lambda_i u_i.
  $
  If $lambda_(k+1) = 0$, then $S_k$ is not linearly independent. $smash$ So we can write
  $
    u_(k+1) = -(1)/(lambda_(k+1)) sum_(i=1)^k lambda_i u_i in span(S_k),
  $
  which contradicts the choice of $u_(k+1)$. $smash$

  Hence $S_(k+1)$ is linearly independent.

  Since $k <= dim V$ at every step, this terminates in at most $dim V$ steps, with some $S_k$ that is linearly independent and spans $U$. So $S_k$ is a basis for $U$, and hence $U$ is finite-dimensional and $dim U = k <= dim V$.

  Clearly $U = V$ implies $dim U = dim V$. Conversely, if $dim U = dim V$, apply @cor-inequality-dimensions with $S'$ a basis for $U$, and the result follows.
]

#intuition[#block(width: 100%, breakable: false)[
  Here $dim U = 3$ and $dim V = 4$.
  #canvas({
    import draw: *
    import cetz.decorations: flat-brace
    let (w, h, pitch) = (0.95, 0.52, 0.85)
    let x(i) = i * w
    let notes = ($u_1 != vb(0)$, $u_2 in.not span(S_1)$, $u_3 in.not span(S_2)$)
    for k in (1, 2, 3) {
      let y = -(k - 1) * pitch
      content((x(0) - 0.25, y), anchor: "east", $S_#k$)
      for i in range(4) {
        let (a, b) = ((x(i) + 0.05, y - h / 2), (x(i + 1) - 0.05, y + h / 2))
        if i < k {
          rect(a, b, radius: 0.06, fill: tint("blue"), stroke: none)
          content((x(i + 0.5), y), $u_#(i + 1)$)
        } else {
          rect(a, b, radius: 0.06, stroke: (paint: rule("gray"), thickness: 0.5pt, dash: "dashed"))
        }
      }
      content((x(4) + 0.35, y), anchor: "west", text(fill: ink("gray"), notes.at(k - 1)))
    }
    flat-brace((x(0), h / 2 + 0.12), (x(4), h / 2 + 0.12), amplitude: 0.18)
    content((x(2), h / 2 + 0.58), $dim V$)
    let yb = -2 * pitch - h / 2 - 0.12
    flat-brace((x(3), yb), (x(0), yb), amplitude: 0.18, stroke: rule("blue"))
    content((x(1.5), yb - 0.56), text(fill: ink("blue"))[$span(S_3) = U$, so $S_3$ is a basis of $U$])
  })
]]

#proposition[Extending a basis][
  Let $V$ be a finite-dimensional $FF$-vector space and $U <= V$. If $B_U$ is a basis for $U$, then there exists a basis $B_V$ for $V$ such that $B_U subset.eq B_V$.
] <prop-extending-a-basis>

#proof[
  Apply @thm-steinitz-exchange-lemma[Steinitz Exchange Lemma] with $S = B_U$ and $T$ a basis for $V$. We can hence obtain $T' subset.eq T$ and $B_V = B_U union T'$. Hence $B_V$ spans $V$, and
  $
    abs(T') = abs(T) - abs(S) = dim V - dim U.
  $
  Thus $abs(B_V) <= abs(B_U) + abs(T') = dim V$. Since $B_V$ also spans $V$, by @cor-inequality-dimensions, $abs(B_V) = dim V$, and hence $B_V$ is a basis for $V$.
]

== Interaction Between Bases and Linear Maps

#definition[Rank and Nullity][
  Let $V, W$ be $FF$-vector spaces, where $V$ is finite-dimensional, and let $alpha: V-> W$ be a linear map.

  The *rank* of $alpha$ is $rank alpha = dim im alpha$, and the *nullity* of $alpha$ is $null alpha = dim ker alpha$.
]

Recall from @properties-of-kernel-and-image that $ker alpha <= V$ and $im alpha <= W$.

#theorem[Rank-Nullity Theorem][
  Let $V, W$ be $FF$-vector spaces, where $V$ is finite-dimensional, and let $alpha: V-> W$ be a linear map. Then $im alpha$ is finite-dimensional and
  $
    dim V = rank alpha + null alpha.
  $
] <thm-rank-nullity>

#proof[
  Let ${v_1, ..., v_k}$ be a basis for $ker alpha$. Extend to a basis ${v_1, ..., v_k, v_(k+1), ..., v_n}$ for $V$ using @prop-extending-a-basis[Extending a Basis].

  #claim[
    ${alpha(v_(k+1)), ..., alpha(v_n)}$ is a basis for $im alpha$.
  ]

  #proof[

    *Spanning.* Let $w = alpha(v)$ for some $v in V$. We can write
    $
      v = sum_(i=1)^n lambda_i v_i quad "for some" lambda_i in FF.
    $
    Then
    $
      w = alpha(v) & = alpha(sum_(i=1)^n lambda_i v_i) \
                   & = sum_(i=1)^n lambda_i alpha(v_i) \
                   & = sum_(i=k+1)^n lambda_i alpha(v_i). #eq-note[$"since" alpha(v_i) = vb(0) "for" 1 <= i <= k$] \
    $
    Hence $w in span({alpha(v_(k+1)), ..., alpha(v_n)})$.

    *Linear independence.* Suppose that
    $
      vb(0) & = sum_(i=k+1)^n lambda_i alpha(v_i) quad "for some" lambda_i in FF \
            & = alpha(sum_(i=k+1)^n lambda_i v_i),
    $
    so $sum_(i=k+1)^n lambda_i v_i in ker alpha$. Since ${v_1, ..., v_k}$ spans $ker alpha$, we can write
    $
      sum_(i=k+1)^n lambda_i v_i = - sum_(i=1)^k lambda_i v_i quad "for some" lambda_i in FF.
    $
    Hence
    $
      sum_(i=1)^n lambda_i v_i = vb(0)
    $
    and thus $lambda_i = 0$ for all $1 <= i <= n$ since ${v_1, ..., v_n}$ is a basis for $V$. In particular, $lambda_i = 0$ for all $k+1 <= i <= n$.
  ]
  Therefore the result follows.
]

#intuition[
  #canvas({
    import draw: *
    import cetz.decorations: flat-brace
    let (xl, xr, yt, yb) = (0, 3.2, 0, -1.5)
    content((-1.6, yt), text(fill: ink("gray"), $V$))
    content((-1.6, yb), text(fill: ink("gray"), $W$))
    content((xl, yt), text(fill: ink("blue"), $v_1, ..., v_k$))
    content((xr, yt), $v_(k+1), ..., v_n$)
    content((xl, yb), $vb(0)$)
    content((xr, yb), text(fill: ink("red"), $alpha(v_(k+1)), ..., alpha(v_n)$))
    for x in (xl, xr) {
      line((x, yt - 0.3), (x, yb + 0.3), mark: (start: "|", end: ">"))
      content((x + 0.12, (yt + yb) / 2), anchor: "west", $alpha$)
    }
    flat-brace((xl - 0.75, yt + 0.32), (xl + 0.75, yt + 0.32), amplitude: 0.18, stroke: rule("blue"))
    content((xl, yt + 0.8), text(fill: ink("blue"))[basis of $ker alpha$])
    flat-brace((xr + 1.25, yb - 0.32), (xr - 1.25, yb - 0.32), amplitude: 0.18, stroke: rule("red"))
    content((xr, yb - 0.8), text(fill: ink("red"))[basis of $im alpha$])
  })
]

#proposition[
  Let $U <= V$ where $V$ is a finite-dimensional $FF$-vector space. Then $V \/ U$ is finite-dimensional and
  $
    dim (V \/ U) = dim V - dim U.
  $
] <prop-quotient-dimension>

#proof[
  Recall from @prop-quotient-map that there is a surjective linear map
  $
    pi_U: V & -> V \/ U \
          v & |-> v + U
  $
  with $ker pi_U = U$. By @thm-rank-nullity[Rank-Nullity Theorem], we have the result.
]

#remark[
  We could prove @prop-quotient-dimension directly by extending from a basis of $U$ to a basis for $V$. Given basis $B_U$ for $U$, a basis $B_V$ for $V$ with $B_U subset.eq B_V$, we get the basis
  $
    Set(b + U; b in B_V \\ B_U)
  $
  and then we can deduce @thm-rank-nullity[Rank-Nullity Theorem] from @thm-first-isomorphism-theorem[First Isomorphism Theorem] as
  $
    im alpha teq V \/ ker alpha.
  $
]

#corollary[Linear Pigeonhole Principle][
  If $V, W$ are finite-dimensional $FF$-vector spaces with $dim V = dim W$ and $alpha: V->W$ is a linear map, then the following are equivalent:

  + $alpha$ is injective;

  + $alpha$ is surjective;

  + $alpha$ is an isomorphism.
]

#proof[
  By @properties-of-kernel-and-image, $(1) <=> null alpha = 0$, and that $(2) <=> rank alpha = dim V = dim W$. By @thm-rank-nullity[Rank-Nullity Theorem], we have $dim V = rank alpha + null alpha$, and hence $(1) <=> (2) <=> (3)$.
]

#proposition[
  Let $V, W$ be $FF$-vector spaces, not necessarily finite-dimensional. Suppose $B$ is a basis for $V$.

  For any function $f: B-> W$, there exists a unique linear map $F:V->W$ extending $f$, _i.e._ $(F|_B = f)$.

  #fade[[Linear maps are determined by their action on bases.]]
] <prop-linear-map-determined-by-basis>

#proof[

  *Existence.* Given $v in V$, we can write
  $
    v = sum'_(b in B) lambda_b b quad "for some" lambda_b in FF.
  $
  Define $F: V -> W$ by
  $
    F(v) = sum'_(b in B) lambda_b f(b).
  $
  Then $F$ is a linear map and $F|_B = f$.

  *Well-definedness.* If $v = sum'_(b in B) mu_b b$, then
  $
    vb(0) = sum'_(b in B) (lambda_b - mu_b) b,
  $
  hence $lambda_b = mu_b$ for all $b in B$ by its linear independence. Thus $F(v)$ is well-defined.

  *Uniqueness.* If $overline(F): V->W$ is linear with $overline(F)|_B = f$, then for any $v in V$,
  $
    overline(F)(v) = overline(F)(sum'_(b in B) lambda_b b) = sum'_(b in B) lambda_b overline(F)(b) = sum'_(b in B) lambda_b f(b) = F(v).
  $

  *Linearity.* Given
  $
    v & = sum'_b lambda_b b \
    u & = sum'_b mu_b b,
  $
  we have, for any $lambda in FF$,
  $
    F(u + lambda v) & = F(sum'_b (mu_b + lambda lambda_b) b) \
                    & = sum'_b (mu_b + lambda lambda_b) f(b) \
                    & = sum'_b mu_b f(b) + lambda sum'_b lambda_b f(b) \
                    & = F(u) + lambda F(v). \
  $
]

#intuition[#block(width: 100%, breakable: false)[
  Here $V = W = RR^2$, $B = {b_1, b_2}$ and $v = 2 b_1 + b_2$.
  #canvas(length: 1.25cm, {
    import draw: *
    let path = (paint: rule("gray"), thickness: 0.6pt, dash: "dashed")
    let add(p, q, s: 1) = (p.at(0) + s * q.at(0), p.at(1) + s * q.at(1))
    // v from its coordinates: twice the first vector, then the second
    let picture(o, p, q, hue, lp, lq, lv) = {
      let arrow = (end: ">", fill: rule(hue), stroke: rule(hue))
      let (p2, v) = (add(o, p, s: 2), add(add(o, p, s: 2), q))
      line(add(o, p), p2, stroke: path)
      line(p2, v, stroke: path)
      line(o, v, mark: (end: ">"))
      line(o, add(o, p), stroke: rule(hue) + 1.2pt, mark: arrow)
      line(o, add(o, q), stroke: rule(hue) + 1.2pt, mark: arrow)
      circle(o, radius: 0.04, fill: colors.text, stroke: none)
      content(add(o, p, s: 0.7), anchor: "north", padding: 0.15, text(fill: ink(hue), lp))
      content(add(o, q), anchor: "south", padding: 0.12, text(fill: ink(hue), lq))
      content(v, anchor: "south", padding: 0.12, lv)
    }
    picture((0, 0), (1.0, 0), (0.4, 0.75), "blue", $b_1$, $b_2$, $v$)
    picture((5.0, -0.1), (0.9, 0.2), (-0.4, 0.8), "red", $f(b_1)$, $f(b_2)$, $F(v) = 2 f(b_1) + f(b_2)$)
    let gm = (end: ">", fill: rule("gray"), stroke: rule("gray"))
    line((2.9, 0.3), (4.1, 0.3), stroke: rule("gray"), mark: gm)
    content((3.5, 0.35), anchor: "south", text(fill: ink("gray"), $F$))
  })
]]

#lecture-separator(lecture: 5, date: "2026-10-19")

#corollary[
  Suppose $V$ is $n$-dimensional. Let $B = {v_1, ..., v_n}$ be a basis for $V$.
  Then there is an isomorphism
  $
    F_B: V-> FF^n
  $
  given by
  $
    F_B (sum_(i=1)^n lambda_i v_i) = vec(lambda_1, dots.v, lambda_n).
  $
] <cor-coordinate-map-isomorphism>

#proof[
  There is a bijection
  $
    f: B & -> {e_1, ..., e_n} #eq-note[$"standard basis for" FF^n$] \
     v_i & |-> e_i.
  $

  By @prop-linear-map-determined-by-basis, $f$ and $f^(-1)$ have linear extensions
  $
    F_B: V & ->FF^n, quad overline(F)_B: FF^n & -> V
  $
  respectively.

  #claim[
    $F_B$ and $overline(F)_B$ are inverses of each other.
  ]
  #proof[
    Note that
    $
      overline(F)_B compose F_B (v_i) = overline(F)_B (e_i) = v_i
    $
    and as a composition of linear maps, $overline(F)_B compose F_B$ is linear. But $id_V: V-> V$ is linear and $v_i |-> v_i$. By @prop-linear-map-determined-by-basis, we have $overline(F)_B compose F_B = id_V$. Similarly, $F_B compose overline(F)_B = id_(FF^n)$.
  ]

  Therefore $F_B$ is an isomorphism.
]

#definition[Coordinate Vector][
  Suppose $V$ is $n$-dimensional. Let $B = {v_1, ..., v_n}$ be a basis for $V$. Writing
  $
    v = sum_(i=1)^n lambda_i v_i, quad lambda_i in FF,
  $
  we denote
  $
    F_B (v) := vec(lambda_1, dots.v, lambda_n) in FF^n quad "by" quad [v]_B in FF^n.
  $
  $[v]_B$ is called the *coordinate vector* of $v$ with respect to the basis $B$.
] <def-coordinate-vector>

#corollary[
  Let $V, W$ be finite-dimensional $FF$-vector spaces. Then
  $
    V teq W <=> dim V = dim W.
  $
]

#proof[
  If $dim V = dim W = n$, then by @cor-coordinate-map-isomorphism, $V teq FF^n teq W$. Conversely, the image of a basis for $V$ under an isomorphism $V -> W$ is a basis for $W$.
]

#example[
  If $V teq FF^n$ and $W <= V$ with $W teq FF^m$, then by @prop-quotient-dimension,
  $
    V \/ W teq FF^(n-m).
  $
]

== Direct Sums

=== External Direct Sum

#definition[External Direct Sum][
  The *external direct sum* of two $FF$-vector spaces $V$ and $W$, denoted by $V plus.o W$, has underlying set $V times W$ and operations
  $
    (v_1, w_1) + (v_2, w_2) & = (v_1 + v_2, w_1 + w_2), \
              lambda (v, w) & = (lambda v, lambda w).
  $

  Similarly, we can define $V_1 plus.o ... plus.o V_n$.
]

#lemma[
  If $V, W$ are finite-dimensional, then $V plus.o W$ is finite-dimensional and
  $
    dim (V plus.o W) = dim V + dim W.
  $
] <lem-direct-sum-dimension>
#prooflike[Proof Sketch 1][
  Let $B_V$ and $B_W$ be bases for $V$ and $W$, respectively. Then we can check
  $
    (B_V times {vb(0)_W}) union ({vb(0)_V} times B_W)
  $
  is a basis for $V plus.o W$.
]
#prooflike[Proof Sketch 2][
  If $V teq FF^n$ and $W teq FF^m$, then clearly
  $
    V plus.o W teq FF^(n+m).
  $
]

#proposition[
  Let $V$ be a $FF$-vector space, and $U, W <= V$. There is a surjective linear map
  $
    phi: U plus.o W & -> U + W \
             (u, w) & |-> u + w
  $
  with
  $
    ker phi teq U inter W.
  $
] <prop-direct-sum-map>

#proof[
  Surjectivity follows from definition. The linearity of $phi$ is clear.

  For $(u, w) in U plus.o W$,
  $
    (u, w) in ker phi <=> w = -u in U inter W.
  $
  Thus
  $
    ker phi = Set((x, -x); x in U inter W).
  $
  The function $x |-> (x, -x)$ is an isomorphism $U inter W -> ker phi$.
]

#intuition[#block(width: 100%, breakable: false)[
  Here $U$ and $W$ are planes in $RR^3$, and $(x, -x) in ker phi$.
  #canvas(length: 1.3cm, {
    import draw: *
    // e_1 towards the viewer, e_2 to the right, e_3 up
    let P(a, b, c) = (-0.5 * a + b, -0.35 * a + c)
    let (bw, bu, a0) = (1.7, 2.1, 1.6)
    // W, the plane spanned by e_2 and e_3
    line(P(0, -bw, -1.0), P(0, bw, -1.0), P(0, bw, 1.1), P(0, -bw, 1.1), close: true, stroke: rule("red") + 0.8pt)
    // U, the plane spanned by e_1 and e_2
    line(P(-a0, -bu, 0), P(-a0, bu, 0), P(a0, bu, 0), P(a0, -bu, 0), close: true, stroke: rule("blue") + 0.8pt)
    // their intersection, the line through e_2, drawn past both patches
    line(P(0, -bu - 0.6, 0), P(0, bu + 0.6, 0), stroke: colors.text + 0.8pt)
    line(P(0, 0, 0), P(0, 1.1, 0), stroke: rule("blue") + 1.3pt, mark: (end: ">", fill: rule("blue"), stroke: rule("blue")))
    line(P(0, 0, 0), P(0, -1.1, 0), stroke: rule("red") + 1.3pt, mark: (end: ">", fill: rule("red"), stroke: rule("red")))
    circle(P(0, 0, 0), radius: 0.045, fill: colors.text, stroke: none)
    content(P(0, 0.55, 0), anchor: "south", padding: 0.1, text(fill: ink("blue"), $x in U$))
    content(P(0, -0.55, 0), anchor: "north", padding: 0.1, text(fill: ink("red"), $-x in W$))
    content(P(0, bu + 0.6, 0), anchor: "west", padding: 0.1, $U inter W$)
    content(P(a0, -bu, 0), anchor: "east", padding: 0.12, text(fill: ink("blue"), $U$))
    content(P(0, bw, 1.1), anchor: "south-west", padding: 0.08, text(fill: ink("red"), $W$))
  })
]]

#corollary[Sum-Intersection Formula][
  If $U, W <= V$ are finite-dimensional, then
  $
    dim (U + W) = dim U + dim W - dim (U inter W).
  $
] <cor-sum-intersection-formula>

#proof[
  Apply @thm-rank-nullity[Rank-Nullity Theorem] to the map defined in @prop-direct-sum-map,
  $
    phi: U plus.o W & -> U + W \
             (u, w) & |-> u + w.
  $
  We obtain
  $
    dim (U plus.o W) & = rank phi + null phi \
                     & = dim(U + W) + dim(U inter W).
  $
  By @lem-direct-sum-dimension, we have
  $
    dim U + dim W = dim(U + W) + dim(U inter W).
  $
]

=== Explicit Basis

Let $B$ be a basis for $U inter W$. Extend $B$ to a basis $B_U$ for $U$ and a basis $B_W$ for $W$.

Then $B_U union B_W$ spans $U + W$, and

$
  abs(B_U union B_W) <= abs(B_U) + abs(B_W) - abs(B) = dim U + dim W - dim (U inter W) = dim (U + W)
$
by @cor-sum-intersection-formula[Sum-Intersection Formula]. Since $B_U union B_W$ spans $U + W$, @cor-inequality-dimensions gives equality, so $B_U union B_W$ is a basis for $U + W$.

#intuition[
  Here $dim U = 4$, $dim W = 5$ and $B = {b_1, b_2}$ #fade[[shaded]] lies in both bases, so $abs(B_U union B_W) = 4 + 5 - 2$.
  #canvas({
    import draw: *
    import cetz.decorations: flat-brace
    let names = ($u_1$, $u_2$, $b_1$, $b_2$, $w_1$, $w_2$, $w_3$)
    let x(i) = i * 0.95
    rect((x(2) - 0.4, -0.3), (x(3) + 0.4, 0.3), radius: 0.08, fill: tint("purple"), stroke: none)
    for (i, n) in names.enumerate() { content((x(i), 0), n) }
    flat-brace((x(0) - 0.4, 0.45), (x(3) + 0.4, 0.45), amplitude: 0.18, stroke: rule("blue"))
    content((x(1.5), 0.93), text(fill: ink("blue"))[$B_U$, basis of $U$])
    flat-brace((x(6) + 0.4, -0.45), (x(2) - 0.4, -0.45), amplitude: 0.18, stroke: rule("red"))
    content((x(4), -0.93), text(fill: ink("red"))[$B_W$, basis of $W$])
  })
]

#remark[
  We could also check directly that $B_U union B_W$ is linearly independent of size $abs(B_U) + abs(B_W) - abs(B)$, and hence a basis for $U + W$. This gives an alternative proof of @cor-sum-intersection-formula[Sum-Intersection Formula].
]

=== Internal Direct Sum

#definition[Internal Direct Sum][
  If every element of $U + W$ is uniquely expressible as $u + w$ for some $u in U, w in W$, then the map $phi$ from @prop-direct-sum-map is an isomorphism. In this case, we say that $U + W$ is the *internal direct sum* of $U$ and $W$, and we write
  $
    U + W = U plus.o W.
  $
]

#proposition[
  For $U, W <= V$, we have $V = U plus.o W$ iff

  + $V = U + W$;

  + $U inter W = {vb(0)_V}$.
]

#definition[
  For $U <= V$, $W <= V$ is a direct complement to $U$ in $V$ if $V = U plus.o W$.
]

#proposition[
  If $V$ is finite-dimensional, then every subspace $U <= V$ has a direct complement in $V$.
] <prop-finite-dimensional-subspace-has-direct-complement>

#proof[
  Let $B_U$ be a basis for $U$. Extend $B_U$ to a basis $B_V$ for $V$. Set $W = span(B_V \\ B_U)$. Then
  $
    V = span(B_V) & = span(B_U union (B_V \\ B_U)) \
                  & = span(B_U) + span(B_V \\ B_U) \
                  & = U + W.
  $
  Since $B_V$ is linearly independent, we have $U inter W = {vb(0)_V}$. #fade[[Alternatively, $dim U + dim W = dim V$ so by @cor-sum-intersection-formula, $U inter W = {vb(0)_V}$.]]
]

#definition[Internal direct sum of many subspaces][
  More generally, given $U_1, ..., U_n <= V$, write
  $
    V = plus.o.big_(i=1)^n U_i
  $
  if the map
  $
    underbracket(U_1 plus.o ... plus.o U_n, "external d.s.") & -> V \
                                             (u_1, ..., u_n) & |-> u_1 + ... + u_n
  $
  is an isomorphism.
]

#warning[

  + $U_1 + ... + U_n = V$

  + For all $j != i$, $U_i inter U_j = {vb(0)_V}$

  Together, (1) and (2) are _not_ sufficient to conclude that $V = plus.o.big_(i=1)^n U_i$.
]

