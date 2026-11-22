// The largest errors found in the November 2026 audit of the Part IB notes,
// all of them now corrected in the source.
//
//     typst compile --root . --font-path fonts --ignore-system-fonts \
//       part-ib/errata.typ build/part-ib-errata.pdf

#import "/template/lib.typ": *
#import "/template/micfong/lib.typ": article
#import "@preview/physica:0.9.8": *

#let dom = math.op("dom")

#show: article.with(
  title: "Part IB Errata",
  subtitle: "The largest errors found and corrected, November 2026",
  authors: "Zixuan",
  date: datetime(year: 2026, month: 11, day: 7),
)

#let critical = badge("Critical", accent: "red")
#let major = badge("Major", accent: "orange")

/// One row per error: where, its severity, what the notes said, what they say now.
#let errata(..rows) = table(
  columns: (8.2em, 1fr, 1fr),
  table.header[Where][Was][Now],
  ..rows.pos().map(((loc, sev, was, now)) => (stack(spacing: 0.5em, loc, sev), was, now)).flatten(),
)

Every chapter of the seven Part IB courses was read by an auditor that re-derived each proof and recomputed each example, with the reference notes and example sheets at hand. A second auditor per course read all of its chapters together for notation. Each reported error then went to a verifier asked to refute it, and only the errors that survived were corrected.

#table(
  columns: (1fr, auto, auto, auto, auto, auto),
  align: (left, right, right, right, right, right),
  table.header[Course][Reported][Corrected][Critical][Major][Minor],
  [Linear Algebra], [74], [54], [0], [4], [50],
  [Markov Chains], [41], [30], [1], [10], [19],
  [Methods], [77], [56], [0], [7], [49],
  [Quantum Mechanics], [55], [37], [2], [3], [32],
  [Analysis II], [9], [9], [0], [0], [9],
  [Optimisation], [87], [62], [1], [13], [48],
  [Variational Principles], [129], [96], [3], [16], [77],
)

#fade[[Reported counts include duplicates found by several auditors. A *critical* error is a statement or formula that is false as written; a *major* one is a missing hypothesis, a gap in a proof, a wrong example or a reference to the wrong result. Minor errors (typos, notation, rendering) are fixed but not listed.]]

= Variational Principles

#errata(
  (
    [Ch. 8, §8.1, central force],
    critical,
    [$V_"eff" (r) = V(r) + (m h^2)/(2 r^2) + V(r)$, counting $V$ twice.],
    [$V_"eff" (r) = V(r) + (m h^2)/(2 r^2)$.],
  ),
  (
    [Ch. 11, opening, second variation],
    critical,
    [$F[y + epsilon xi] - F[y] = epsilon integral (dots.c) dif x + epsilon delta^2 F[y, xi] + O(epsilon^3)$, with the second variation at the same order as the first. The Taylor expansion of $f(vb(x) + epsilon vb(xi))$ above it also lacked the term $f(vb(x))$.],
    [$dots.c + epsilon^2 delta^2 F[y, xi] + O(epsilon^3)$, and the expansion starts with $f(vb(x))$.],
  ),
  (
    [Ch. 12, Example 12.1, Jacobi equation],
    critical,
    [A solution with $u = 0$ on $[0, a]$ exists iff $a < ppi$; but $u equiv 0$ always solves it.],
    [A solution with $u != 0$ on $[0, a]$ exists iff $a < ppi$.],
  ),
  (
    [Ch. 11, Prop. 11.1, convexity],
    major,
    [Assumed $delta^2 F[y, xi] > 0$ for all allowed $xi$, which fails for $xi equiv 0$, so the result never applied.],
    [Assumes $delta^2 F[y, xi] >= 0$, as Example 11.2 checks.],
  ),
  (
    [Ch. 11, Example 11.8, brachistochrone],
    major,
    [A stray $+ 1 \/ (2y)$ in the expansion of $sigma$, and $sigma = 1 \/ (2 sqrt(-y (1 + y'^2)))$ dropped a factor.],
    [$sigma = 1 \/ (2 y^2 sqrt(-y (1 + y'^2))) > 0$.],
  ),
  (
    [Ch. 11, Prop. 11.10, proof],
    major,
    [$eta = sum_(i = 1)^n a_i y_i$: a finite sum would put every variation in an $n$-dimensional span.],
    [$xi = sum_(n = 1)^oo a_n eta_n$, by completeness.],
  ),
  (
    [Ch. 9, Noether's theorem, both proofs],
    major,
    [Version 1: $dv(, t)$ also acted on $pdv(L, dot(q)_i)$. Version 2: expanding in the time argument gave $dv(L, t)$.],
    [$s dv(, t)(pdv(Q_i, s)|_(s = 0)) pdv(L, dot(q)_i)$, and $pdv(L, t)$.],
  ),
  (
    [Ch. 9, Example 9.7, Galilean boost],
    major,
    [The $O(s)$ term of $L$ was $+ s vu(n) dot sum_i m_i dot(vb(x))_i$, and $K = -vu(n) dot sum_i m_i vb(x)_i = vu(n) dot (M vb(R))$ contradicted itself.],
    [$- s vu(n) dot sum_i m_i dot(vb(x))_i$, and $K = -vu(n) dot (M vb(R))$.],
  ),
  (
    [Ch. 7, §7.2, geodesics on a surface],
    major,
    [$lambda(t)$ had a minus sign that $(dagger)$ does not give, and the geodesic equation had the index $i$ three times and $sqrt(dot(vb(x))^2)$ for $dot(vb(x))^2$.],
    [$lambda = (dot(x)_i dot(x)_j ∂_i ∂_j g) / (sqrt(dot(vb(x))^2) (grad g)^2)$, and the term is $(dot(x)_j dot(x)_k ∂_j ∂_k g ∂_i g) / (dot(vb(x))^2 (grad g)^2)$.],
  ),
  (
    [Ch. 2, Theorems 2.4, 2.7, convexity conditions],
    major,
    [The first- and second-order conditions were stated without a convex domain; $x^2$ on $(-2, -1) union (1, 2)$ is a counterexample.],
    [Both assume $dom f$ open and convex, and the Hessian condition holds everywhere in $dom f$.],
  ),
  (
    [Ch. 4, Lagrange multipliers],
    major,
    [$grad f = lambda grad g$ at an extremum, with no condition on $grad g$.],
    [Assumes $grad g(vb(x)_0) != vb(0)$ (linearly independent $grad g_k$ for several constraints).],
  ),
  (
    [Ch. 4, Example 4.2],
    major,
    [The quadratic form $vb(x)^TT matbold(A) vb(x)$ on the sphere uses real eigenvalues and $2 A_(i j) x_j$, but $matbold(A)$ was never said to be symmetric.],
    [$matbold(A)$ is real symmetric.],
  ),
)

= Quantum Mechanics

#errata(
  (
    [Ch. 3, §3.1.3, harmonic oscillator ground state],
    critical,
    [$chi_0(x) = A ee^(-m omega x^2 \/ hbar)$, which is the ground state for frequency $2 omega$.],
    [$chi_0(x) = A ee^(-m omega x^2 \/ (2 hbar))$, from $ee^(-xi^2 \/ 2)$ with $xi = sqrt(m omega \/ hbar) thin x$.],
  ),
  (
    [Ch. 3, Prop. 3.2, proof],
    critical,
    [The Taylor coefficients of $ee^(xi^2)$ were $b_m = 1 \/ m!$ ($m$ even), which sum to $cosh xi$.],
    [$b_m = 1 \/ (m\/2)!$ for $m$ even, since $ee^(xi^2) = sum_n xi^(2n) \/ n!$.],
  ),
  (
    [Ch. 3, §3.2.1, Gaussian wavepacket],
    major,
    [$nu$ was defined as $ii Im(beta \/ alpha)$, so the shifted contour from $-oo - ii nu$ to $oo - ii nu$ was the real line.],
    [$nu = Im(beta \/ alpha)$, and $tilde(k) = k - beta \/ alpha$ is the complex variable on the shifted contour.],
  ),
  (
    [Ch. 2, §2.5.2, completeness theorem],
    major,
    [The discrete _or_ the continuous eigenfunctions of a Hermitian operator form a complete orthonormal basis.],
    [The discrete and continuous eigenfunctions _together_ form a complete orthogonal basis, once an orthogonal basis is chosen in each degenerate eigenspace.],
  ),
  (
    [Ch. 2, §2.5.3, Copenhagen postulates (3), (5)],
    major,
    [${psi_j}_(j in J)$ was _a_ subset of the eigenfunctions with eigenvalue $lambda$, which undercounts $PP(O = lambda)$ and gives the wrong collapsed state.],
    [${psi_j}_(j in J)$ is the set of _all_ basis eigenfunctions with eigenvalue $lambda$.],
  ),
)

= Markov Chains

#errata(
  (
    [Ch. 3, Thm 3.13 (SSRW), proof, $d = 3$],
    critical,
    [$P_(00)(2n) = sum binom(n, i, i, j, j, k, k) (1/6)^(2n)$: the walk takes $2n$ steps, so the top entry is wrong, and the next line already used $binom(2n, n)$. The bound after "Hence" was also written for $P_(00)(n)$.],
    [$binom(2n, i, i, j, j, k, k)$, and the bound is for $P_(00)(2n)$, as the step to $P_(00)(6m)$ needs.],
  ),
  (
    [Ch. 4, Thm 4.6, proof of part 2],
    major,
    [Four slips: invariance written $vb(nu)_k = matbold(P) vb(nu)_k$; $(vb(nu)_k matbold(P)^n)_i = sum_j nu_k (j) P_(k i)(n)$; the vector $vb(nu)_k$ in a scalar bound; and $sum_j nu_k (i) P_(j k)(m)$.],
    [$vb(nu)_k = vb(nu)_k matbold(P)$; $sum_j nu_k (j) P_(j i)(n)$; $nu_k (i) >= nu_k (k) P_(k i)(n) = P_(k i)(n)$; and $sum_j nu_k (j) P_(j k)(m)$.],
  ),
  (
    [Ch. 4, Thm 4.9, (2) $=>$ (3)],
    major,
    [Theorem 4.6 was applied knowing only that the state $k$ is recurrent.],
    [Irreducibility and Theorem 3.7 first make every state recurrent, so $matbold(P)$ is recurrent.],
  ),
  (
    [Ch. 4, Example 4.4, two-state chain],
    major,
    [$P_(00)(n) -> beta \/ (alpha + beta)$ with no condition on $alpha, beta$. It fails for $alpha = beta = 1$ (periodic) and is undefined for $alpha = beta = 0$.],
    [Stated for $0 < alpha + beta < 2$.],
  ),
  (
    [Ch. 3, Thm 3.6, proof of part 2],
    major,
    [$EE_i [V_i] < oo$ was inferred from $V_i < oo$ almost surely, but a finite random variable can have infinite mean.],
    [$EE_i [V_i] = sum_(r >= 0) PP_i (V_i > r) = sum_(r >= 0) f_i^r = 1 \/ (1 - f_i) < oo$.],
  ),
  (
    [Ch. 3, Thm 3.10, a finite closed class is recurrent],
    major,
    [Some $y in C$ is visited infinitely often with positive probability "since $C$ is closed". Closedness alone does not give this (SSRW on $ZZ^3$).],
    [The chain stays in the _finite_ set $C$, so by the pigeonhole principle some $y in C$ is visited infinitely often.],
  ),
  (
    [Ch. 2, §2.2.1, birth and death chain],
    major,
    [The derivation divides by $p_i$, but nothing ruled out $p_i = 0$.],
    [Assumes $p_1, p_2, ... in (0, 1)$.],
  ),
)

= Optimisation

#errata(
  (
    [Ch. 3, maximum of a convex function],
    critical,
    ["The maximum of a convex $f$ on a convex set $C$ occurs at an extreme point", false for, _e.g._, a half-plane, which has none; the proof also concluded more than its inequality gave.],
    [Stated for a polytope $C$: every point is a convex combination of the extreme points $vb(v)_i$, so $f(vb(x)) <= max_i f(vb(v)_i)$.],
  ),
  (
    [Ch. 3, simplex example, final tableau],
    major,
    [The reduced cost of the basic variable $x_6$ was $1$.],
    [It is $0$; the top row is $20\/3 | 0, 0, 1\/3, 1\/3, 1\/3, 0$.],
  ),
  (
    [Ch. 3, BFS iff extreme point, converse],
    major,
    [The linear dependence lacked "not all zero", and the sum ran over columns $1, ..., r$.],
    [$sum_(k = 1)^r w_(i_k) vb(A)_(i_k) = vb(0)$ with the $w_(i_k)$ not all zero.],
  ),
  (
    [Ch. 3, LP optimality conditions, proof],
    major,
    [Used "$vb(c)^TT vb(x) = vb(lambda)^TT vb(b)$ iff both optimal", which is strong duality, citing only weak duality.],
    [Cites strong duality for feasible bounded LPs.],
  ),
  (
    [Ch. 2, Thm 2.1, Lagrange sufficiency, proof],
    major,
    [Justified a step by "$(vb(x)^*, vb(lambda)^*)$ minimises $cal(L)$ over $cal(X) times RR^m$", false as $cal(L)$ is unbounded in $vb(lambda)$.],
    [$vb(x)^*$ minimises $cal(L)(dot, vb(lambda)^*)$ over $cal(X)$, the actual hypothesis.],
  ),
  (
    [Ch. 2, Prop. 2.8, $arrow.l.double$],
    major,
    [Applied Lagrange sufficiency to an arbitrary minimiser of $cal(L)(dot, vb(lambda))$, which need not be feasible.],
    [Shows the given feasible $vb(x)$ minimises $cal(L)(dot, vb(lambda))$ and applies the theorem to it.],
  ),
  (
    [Ch. 4, §4.3, augmenting paths and Ford–Fulkerson],
    major,
    [Forward edges were raised by $min{c_(i j) - x_(i j)}$ and reverse edges lowered by $min{x_(j i)}$, two different amounts, which breaks conservation. The closing remark certified optimality by a cut with $c(S) = delta^*$, which every flow passes.],
    [One $epsilon = min(min{c_(i j) - x_(i j)}, min{x_(j i)})$ on every edge of the path; the certificate is a cut with $c(S) = delta$, the current flow's value.],
  ),
  (
    [Ch. 4, §4.3, max-flow problem],
    major,
    [The constraints counted only outflow at the source and inflow at the sink, allowing values above the minimum cut.],
    [Both use net flow.],
  ),
  (
    [Ch. 4, §4.2, transport remark],
    major,
    [The capacity bound $sum_k abs(b_k)$ was claimed for any lower bounds, and can make a feasible problem infeasible.],
    [Assumes lower bounds $underline(matbold(M)) = matbold(0)$, the case the proof reduces to.],
  ),
  (
    [Ch. 1, figures],
    major,
    [The barrier figure drew the indicator $phi$ below the axis for $x < 0$; the Newton figure labelled the tangent $(y - x) g'(x_t) + g(x_t)$.],
    [$phi = 0$ for $x < 0$; the tangent is $(x - x_t) g'(x_t) + g(x_t)$.],
  ),
  (
    [Ch. 1, second-order condition, proof],
    major,
    [The point $vb(z)$ with the Hessian remainder was attributed to the intermediate value theorem.],
    [Taylor's theorem with the Lagrange remainder.],
  ),
)

= Methods

#errata(
  (
    [Ch. 3, §3.4.3, uniqueness for the heat equation],
    major,
    [The Tychonoff non-uniqueness example used $f(t) = ee^(-1\/t)$, for which the series does not tend to $0$ as $t -> 0^+$ when $abs(x) > 2$.],
    [$f(t) = ee^(-1\/t^2)$, Tychonoff's choice.],
  ),
  (
    [Ch. 3, §3.4.1, heat on a square sheet],
    major,
    [$Y'' + (m - lambda) Y = 0$, with the mode index $m$ in place of the eigenvalue.],
    [$Y'' + (mu - lambda) Y = 0$.],
  ),
  (
    [Ch. 3, §3.4.2, heat on a cylinder],
    major,
    [The double sums started at $k, n = 0$, which brings in an undefined $j_(0 0)$.],
    [The sums start at $k, n = 1$.],
  ),
  (
    [Ch. 2, §2.5, Legendre's equation],
    major,
    [The series is saved if $a_(2n + 2) = 0$, which gives $lambda = 2n(2n + 1)$, not the stated $n(n + 1)$.],
    [The series is saved if it terminates, _i.e._ $a_(n + 2) = 0$ for some $n$, which gives $lambda = n(n + 1)$.],
  ),
  (
    [Ch. 2, §2.7, eigenfunction expansion for $L y = f$],
    major,
    [$A_k = B_k \/ lambda_k$ "if $lambda_k != 0$", but the solution divides by every $lambda_k$.],
    [Requires $lambda_k != 0$ for every $k$.],
  ),
  (
    [Ch. 4, Example 4.1, $L = dv(, x, 2) + omega^2$ on $(0, 1)$],
    major,
    [Any constant $omega in RR$; the Green's function divides by $omega sin omega$, and none exists for $omega in ppi ZZ$.],
    [Requires $sin omega != 0$.],
  ),
  (
    [Ch. 1, §1.7, Parseval's theorem],
    major,
    [Stated for continuous $f, g$, but then applied to the sawtooth, which jumps at $ppi$.],
    [Stated for $L$-periodic Dirichlet functions, which covers the $zeta(2)$ example.],
  ),
)

= Linear Algebra

#errata(
  (
    [Ch. 1, §1.5.2, a basis of $U + W$],
    major,
    [Only $abs(B_U union B_W) <= abs(B_U) + abs(B_W) - abs(B)$ was shown, yet the chain ended with $dim(U + W) = dots.c = abs(B_U union B_W)$.],
    [The bound equals $dim(U + W)$ by the Sum-Intersection Formula; as $B_U union B_W$ spans $U + W$, Corollary 1.32 gives equality, so it is a basis.],
  ),
  (
    [Ch. 3, Prop. 3.7, $det(matbold(A) matbold(B))$],
    major,
    [Corollary 3.5 was cited for "$rank matbold(A) < n$ or $rank matbold(B) < n$ $=>$ $rank matbold(A) matbold(B) < n$", which it does not give.],
    [The step uses $rank matbold(A) matbold(B) <= min(rank matbold(A), rank matbold(B))$; Corollary 3.5 then makes both sides $0$.],
  ),
  (
    [Ch. 4, kernel and image of $alpha^*$, part (3)],
    major,
    [The proof named $im alpha^* = (ker alpha)^0$ as what was left, but its matrix argument proves $rank alpha^* = rank alpha$.],
    [Equal dimensions and (2) give $im alpha^* = (ker alpha)^0$, leaving $rank alpha^* = rank alpha$ to show.],
  ),
  (
    [Ch. 4, lecture 13, alternative proof of (3)],
    major,
    [Only ruled out $rank alpha^* < rank alpha$, and the chain stopped at "$= dim W$" without a conclusion.],
    [$rank alpha^* <= rank alpha$ by (2); the chain is a contradiction, so the ranks are equal and $im alpha^* = (ker alpha)^0$.],
  ),
)

= Analysis II

Only minor corrections (typos and notation), nine in all.
