// A short reading guide to IB Quantum Mechanics, lectures 1-9.
//
//     typst compile --root . --font-path fonts --ignore-system-fonts \
//       part-ib/qm-reading-guide.typ build/part-ib-qm-reading-guide.pdf

#import "/template/lib.typ": *
#import "/template/micfong/lib.typ": article
#import "/template/illustrate.typ": edge, fletcher-diagram, node
#import "@preview/physica:0.9.8": *

#show: article.with(
  title: "Quantum Mechanics So Far",
  subtitle: "A reading guide to lectures 1–9",
  authors: "Zixuan",
  date: datetime(year: 2026, month: 11, day: 7),
)

#let hilb = $cal(H)$
#let expt(content) = $lr(chevron.l #content chevron.r)$
#set table(inset: (x: 0.5em, y: 0.45em))

= The Picture

Classical mechanics describes a particle by $vb(x)(t)$ and $vb(p)(t)$. Quantum mechanics replaces both by one complex function $psi(vb(x), t)$, the *state*, and so far the course answers three questions about it:

+ *what it is*: a unit vector in the Hilbert space $hilb = L^2(RR^3)$;
+ *how it changes*: by the TDSE;
+ *what a measurement gives*: an eigenvalue of a Hermitian operator, with a probability read off from $psi$.

= Where We Are

#table(
  columns: (auto, auto, 1fr),
  table.header[Chapter][Lectures][Content and role],
  [1 Historical Introduction], [1–2], [_why_ classical mechanics fails: light comes in quanta $E = hbar omega$, matter has waves with $p = hbar k$],
  [2 Foundations], [2–6], [_the rules_: states, $hilb$, TDSE, observables, Copenhagen rules, TISE],
  [3 1D Solutions of the TISE], [7–9], [_the rules applied_: wells, oscillator, free particle, scattering],
  [Still to come], [10–16], [the step and barrier (tunnelling); operators, $[hat(x), hat(p)] = ii hbar$ and the uncertainty principle; the hydrogen atom and angular momentum],
)

= The Rules, as Linear Algebra

Chapter 2 is IB Linear Algebra in infinite dimensions #fade[[which is why some eigenfunctions, such as plane waves, are not in $hilb$ at all]].

#table(
  columns: (1fr, 1fr),
  table.header[Quantum mechanics][Linear algebra],
  [state $psi in hilb$ with $norm(psi) = 1$], [unit vector $v in CC^n$],
  [$iprod(psi, phi) = integral psi^* phi dif^3 vb(x)$], [$iprod(v, w) = sum_j v_j^* w_j$],
  [Born's rule: $abs(psi(vb(x), t))^2$ is the density of position], [$abs(v_j)^2$, coordinates in the standard basis],
  [observable: Hermitian $hat(O)$; outcomes: its eigenvalues, all real], [Hermitian $matbold(A)$, with real eigenvalues],
  [eigenfunctions of $hat(O)$: a complete orthogonal basis], [an orthonormal eigenbasis of $matbold(A)$],
  [$PP(O = lambda_i) = abs(iprod(psi_i, psi))^2$], [squared coordinate of $v$ in the eigenbasis],
  [after the outcome $lambda_i$, $psi$ collapses to $psi_i$], [orthogonal projection onto the eigenspace],
  [$expt(O)_psi = iprod(psi, hat(O) psi)$], [$v^dagger matbold(A) v$],
)

#pagebreak(weak: true)

= From the TDSE to an Eigenvalue Problem

#grid(
  columns: (auto, 1fr),
  column-gutter: 1.6em,
  align: horizon,
  fletcher-diagram(
    spacing: (1em, 1.5em),
    node-stroke: 0.6pt + colors.text,
    node-inset: 0.45em,
    node((0, 0), [TDSE: $ii hbar pdv(psi, t) = hat(H) psi$], corner-radius: 2pt),
    node((0, 1), [TISE: $hat(H) chi = E chi$], corner-radius: 2pt),
    node((0, 2), [stationary state $chi(x) ee^(-ii E t \/ hbar)$], corner-radius: 2pt),
    node((0, 3), [every solution $sum_E c_E chi_E (x) ee^(-ii E t \/ hbar)$], corner-radius: 2pt),
    edge((0, 0), (0, 1), text(size: 0.8em)[try $psi = T(t) chi(x)$], "->", label-side: left),
    edge((0, 1), (0, 2), text(size: 0.8em)[$T = ee^(-ii E t \/ hbar)$], "->", label-side: left),
    edge((0, 2), (0, 3), text(size: 0.8em)[completeness], "->", label-side: left),
  ),
  [
    Here $hat(H) = -hbar^2 / (2m) laplacian + U$. So to solve the TDSE for a given $U$, it is enough to find the eigenvalues $E$ and eigenfunctions $chi$ of $hat(H)$, which is what Chapter 3 does.

    Along the way, note that the TDSE preserves normalisation, and that the possible energies are the eigenvalues of $hat(H)$.
  ],
)

= The Recipe of Chapter 3

+ Split the $x$-axis where $U$ is constant, and write the TISE as $chi'' = (2m) / hbar^2 (U - E) chi$.
+ Where $E > U$, $chi$ oscillates ($ee^(plus.minus ii k x)$); where $E < U$, it grows or decays ($ee^(plus.minus kappa x)$).
+ Impose: $chi$ continuous, $chi'$ continuous where $U$ is finite, $chi$ normalisable.
+ Only some $E$ satisfy all three: this is _quantisation_. If $U$ is even, try even and odd $chi$.

#table(
  columns: (auto, 1fr, 1fr),
  table.header[System][Result][To remember],
  [Infinite well, $abs(x) <= a$], [$E_n = (hbar^2 ppi^2 n^2) / (8 m a^2)$, $chi_n$ a $cos$ or $sin$], [$chi'$ jumps at the walls; $E_1 > 0$],
  [Finite well, depth $U_0$], [$xi tan xi = eta$, $xi^2 + eta^2 = r_0^2$ (even case)], [finitely many bound states; $U_0 -> oo$ gives the infinite well],
  [Harmonic oscillator], [$E_N = (N + 1/2) hbar omega$, $chi_N = f_N (xi) ee^(-xi^2 \/ 2)$], [the series must terminate; equal spacing, $E_0 = hbar omega \/ 2$],
  [Free particle], [$psi_k = C ee^(ii (k x - hbar k^2 t \/ 2m))$, $E = (hbar^2 k^2) / (2m)$], [not normalisable (see below)],
  [Step and barrier], [$R + T = 1$], [in progress],
)

= Bound and Scattering States

- *Bound states* have $E$ below $U$ at $plus.minus oo$, so $chi -> 0$ there, $chi$ is normalisable and $E$ is discrete, as in the three wells.
- *Scattering states* have $chi$ oscillating at infinity, so they are not normalisable, and $E$ is continuous. There are two ways to handle them:
  - _superpose_ them into a wavepacket. For the Gaussian, $expt(x) = hbar k_0 t \/ m$, $Delta x$ grows with $t$, and $Delta x Delta p = hbar \/ 2$ at $t = 0$;
  - _reinterpret_ them as a beam, with density $abs(C)^2$ and flux $j = abs(C)^2 hbar k \/ m$. Then $R$ and $T$ are ratios of fluxes.

= Common Points of Confusion

- $psi$ itself is not observable. Only $abs(psi)^2$ and inner products are, and $psi$ is fixed only up to a constant phase.
- _Stationary_ means that $abs(psi)^2$ does not depend on $t$; $psi$ still changes by the phase $ee^(-ii E t \/ hbar)$.
- A superposition of stationary states with different energies is not stationary.
- Plane waves $ee^(ii k x)$ solve the TISE but are not states. They are a basis to expand in.
- A probability of an outcome uses the coefficient of $psi$ in the eigenbasis of the operator being measured, not $psi(x)$ itself.
