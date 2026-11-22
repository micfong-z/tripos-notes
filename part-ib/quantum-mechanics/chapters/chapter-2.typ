#import "../prelude.typ": *
#show: chapter.with(2)

= Foundations of Quantum Mechanics <sec-foundations-of-quantum-mechanics>

We will use many ideas from linear algebra to describe quantum mechanics. The following table summarises the correspondence between the two subjects.

#table(
  columns: (auto, 1fr, 1fr),
  align: horizon,
  table.header("", "Linear Algebra", "Quantum Mechanics"),
  [Vector],
  [
    Vector ($n$-dimensional complex vector)\
    $vb(v), vb(w), ...$

  ],
  [
    State ($oo$-dimensional vector)\
    $psi, phi, ...$
  ],

  [Bases],
  [
    For basis ${vb(e)_j}_(j = 1, ..., n)$, write $vb(v) = vec(v_1, dots.v, v_n)$.

    #fade[[discrete basis]]
  ],
  [
    For basis ${vb(x)}_(vb(x) in RR^3)$, write $psi(vb(x), t) in CC$.

    #fade[[continuous basis]]
  ],

  [Vector space],
  [
    $CC^n$
  ],
  [
    $L^2(RR^3) equiv hilb$\
    #fade[[$CC$-valued square-integrable functions]]
  ],

  [Inner product],
  [
    For $vb(v), vb(w) in CC^n$,
    $ iprod(vb(v), vb(w)) = sum_(j=1)^n v_j^* w_j. $
  ],
  [
    For $psi, phi in hilb$,
    $ iprod(psi, phi) = integral_(RR^3) psi^*(vb(x), t) phi(vb(x), t) dif^3 vb(x). $
  ],

  [Linear map],
  [
    $CC^n -> CC^n$ represented by matrix
    $
      matbold(T) = mat(t_11, dots, t_(1 n); dots.v, dots.down, dots.v; t_(n 1), dots, t_(n n))
    $
  ],
  [
    $L^2 (RR^3) -> L^2 (RR^3)$ represented by an operator $hat(O)$ with
    $
      phi = hat(O)psi.
    $
  ],

  [Eigenvalue problem],
  [
    $matbold(T) vb(v) = lambda vb(v)$\
    $lambda$ eigenvalue, $vb(v)$ eigenvector
  ],
  [
    $hat(O) psi = lambda psi$\
    $lambda$ eigenvalue, $psi$ eigenfunction
  ],
)

== States, Wavefunctions and Probability Interpretations

In quantum mechanics, a particle is described by a state $psi$, which determines the dynamics of particles in a probabilistic way. Quantum states are abstract vectors in a vector space, and we can choose a basis ${vb(x)}$ to represent the state as a complex function $psi(vb(x), t)$, which is called the wavefunction of the particle.

#definition[Wavefunction][
  $psi(vb(x), t)$ is the complex coefficient of $psi$ in the continuous basis ${vb(x)}$ at a given time $t$. _i.e._
  $
    psi (vb(x), t) = psi "in the" vb(x) "representation"
  $
  and is called the *wavefunction* of the particle, with
  $
    psi(vb(x), t): RR^3 -> CC quad forall t in RR,
  $
  and $psi$ satisfies mathematical properties dictated by its physical interpretations.
]

#rule[Probabilistic interpretation (Born's rule)][
  The (probabilistic) *interpretation* of a particle is determined by the *Born's rule*, where the probability density for a particle described by $psi$ to be found at $vb(x)$ at a given time $t$ is
  $
    rho(vb(x), t) prop abs(psi(vb(x), t))^2 = psi^*(vb(x), t) psi(vb(x), t),
  $
  and the probability that the particle is found in $dif V$ centred at $vb(x)$ at the time $t$ is
  $
    rho(vb(x), t) dif V.
  $

] <def-probability-interpretation>

#remark[
  Note that $t$ is a parameter, not a variable, in the wavefunction.
]

@def-probability-interpretation leads to several mathematical properties.

#proposition[
  1. We have,
    $
      integral_(RR^3) psi^* (vb(x), t) psi(vb(x), t) dif^3 vb(x) = integral_(RR^3)
      abs(psi(vb(x), t))^2 dif^3 vb(x) = N < oo,
    $
    where $N$ is a finite real number.

  2. Since the total probability must be $1$, the wavefunction has to be normalised to $1$, _i.e._ we define
    $
      overline(psi)(vb(x), t) = (1)/(sqrt(N)) psi(vb(x), t)
    $
    to be the normalised wavefunction. Hence
    $
      integral_(RR^3) abs(overline(psi)(vb(x), t))^2 dif^3 vb(x) = 1 quad forall t,
    $
    and in particular, $rho(vb(x), t) = abs(overline(psi)(vb(x), t))^2$.

  #notation[
    Sometimes, we will drop the overline and assume that $psi$ is normalised to $1$.
  ]

  3. If $tilde(psi) (vb(x), t) = ee^(ii alpha) psi(vb(x), t)$ for some constant $alpha in RR$, then $tilde(psi)$ is physically equivalent to $psi$. In particular,
    $
      abs(tilde(psi)(vb(x), t))^2 = abs(psi(vb(x), t))^2,
    $
    though the converse fails: a spatially varying phase $ee^(ii alpha(vb(x)))$ preserves $abs(psi)^2$ but changes other observables.
]

== The Hilbert Space $hilb$

#definition[Hilbert Space][
  The set of all square-integrable functions in $RR^3$ is called the *Hilbert space* $L^2(RR^3)$ or $hilb$.
]

The Hilbert space has an important property.

#proposition[
  If $psi_1, psi_2 in hilb$, then $psi = a_1 psi_1 + a_2 psi_2 in hilb$ for any $a_1, a_2 in CC$.
] <prop-linear-combination>

To prove @prop-linear-combination, we need the following theorem.

#theorem[
  If $psi_1 (vb(x), t)$ and $psi_2 (vb(x), t)$ are square-integrable, then
  $
    psi(vb(x), t) = a_1 psi_1 (vb(x), t) + a_2 psi_2 (vb(x), t)
  $
  is also square-integrable.
]

#proof[
  We have that
  $
    integral_(RR^3) abs(psi_1 (vb(x), t))^2 dif^3 vb(x) & = N_1 < oo \
    integral_(RR^3) abs(psi_2 (vb(x), t))^2 dif^3 vb(x) & = N_2 < oo.
  $
  The triangle inequality for complex numbers $z_1, z_2 in CC$ states that
  $ abs(z_1 + z_2) <= abs(z_1) + abs(z_2), $
  along with the fact that $(abs(z_1) - abs(z_2))^2 >= 0$, substituting $z_1 = a_1 psi_1 (vb(x), t)$ and $z_2 = a_2 psi_2 (vb(x), t)$ gives
  $
    integral_(RR^3) abs(psi (vb(x), t))^2 dif^3 vb(x) & = integral_(RR^3) abs(a_1 psi_1 + a_2 psi_2)^2 dif^3 vb(x) \
    & <= integral_(RR^3) (abs(a_1 psi_1) + abs(a_2 psi_2))^2 dif^3 vb(x) \
    &= integral_(RR^3) (abs(a_1 psi_1)^2 + 2 abs(a_1 psi_1) abs(a_2 psi_2) + abs(a_2 psi_2)^2) dif^3 vb(x) \
    &<= integral_(RR^3) (2 abs(a_1 psi_1)^2 + 2 abs(a_2 psi_2)^2) dif^3 vb(x) \
    &= 2 abs(a_1)^2 N_1 + 2 abs(a_2)^2 N_2 < oo. \
  $


]

#lecture-separator(lecture: 3, date: "2026-10-15")

== Inner Product

#definition[Inner product in $hilb$][
  The *inner product* in $hilb$ is defined as
  $
    iprod(psi, phi) := integral_(RR^3) psi^*(vb(x), t) phi(vb(x), t) dif^3 vb(x)
  $
]

#theorem[
  If $psi, phi in hilb$, then $iprod(psi, phi)$ exists.
]

#proof[
  We have, by definition of $hilb$,
  $
    integral_(RR^3) abs(psi(vb(x), t))^2 dif^3 vb(x) & = N_1 < oo \
    integral_(RR^3) abs(phi(vb(x), t))^2 dif^3 vb(x) & = N_2 < oo.
  $
  Hence, by the Cauchy--Schwarz inequality for integrals,
  $
    abs(iprod(psi, phi)) &= abs(integral_(RR^3) psi^*(vb(x), t) phi(vb(x), t) dif^3 vb(x)) \
    &<= sqrt(integral_(RR^3) abs(psi(vb(x), t))^2 dif^3 vb(x) integral_(RR^3) abs(phi(vb(x), t))^2 dif^3 vb(x)) \
    &= sqrt(N_1 N_2) < oo. \
  $
]

#proposition[Properties of Inner product in $hilb$][
  + $iprod(psi, phi) = iprod(phi, psi)^*$ for all $psi, phi in hilb$.

  + antilinear in the first argument and linear in the second argument, _i.e._
    $
      iprod(a_1 psi_1 + a_2 psi_2, phi) = a_1^* iprod(psi_1, phi) + a_2^* iprod(psi_2, phi) \
      iprod(psi, a_1 phi_1 + a_2 phi_2) = a_1 iprod(psi, phi_1) + a_2 iprod(psi, phi_2)
    $

  + $iprod(psi, psi) > 0$ for all non-zero $psi in hilb$, since
    $
      iprod(psi, psi) = integral_(RR^3) abs(psi(vb(x), t))^2 dif^3 vb(x) = N < oo
    $
    and $N = 0$ only for $psi equiv 0$, which is not a valid state.
]

#definition[Norm of a wavefunction][
  The *norm* of a wavefunction is a real function
  $
    psi |-> norm(psi) = sqrt(iprod(psi, psi)).
  $
]

#definition[Normalised wavefunction][
  $psi$ is *normalised* if $norm(psi) = 1$.
]

#definition[Orthogonal wavefunctions][
  Two wavefunctions $psi, phi in hilb$ are *orthogonal* if $iprod(psi, phi) = 0$.
]

#definition[Orthonormal wavefunctions][
  A set of wavefunctions ${psi_n}$ is *orthonormal* if $iprod(psi_m, psi_n) = delta_(m n) = cases(
    0 quad &"if" m != n,
    1 quad &"if" m = n.
  )$
]

#definition[
  A set of wavefunctions ${psi_n}$ is *complete* if we can write any wavefunction $phi in hilb$ as a linear combination of the set, _i.e._

  $
    phi = sum_(n=0)^oo c_n psi_n quad c_n in CC, psi_n in hilb, quad forall phi in hilb.
  $

]

#lemma[
  If ${psi_n}$ forms a complete and orthonormal basis of $hilb$, then
  $
    c_n = iprod(psi_n, phi).
  $

]

#proof[
  We have
  $
    iprod(psi_n, phi) & = iprod(psi_n, sum_(m=0)^oo c_m psi_m) \
                      & = sum_(m=0)^oo c_m iprod(psi_n, psi_m) \
                      & = sum_(m=0)^oo c_m delta_(n m) \
                      & = c_n.
  $
]

== Time-Dependent Schrödinger Equation (TDSE)

The second postulate of quantum mechanics is the Time-Dependent Schrödinger Equation (TDSE), which describes the time evolution of a particle's state as
$
  #boxed[$ ii hbar pdv(psi(vb(x), t), t) = -(hbar^2)/(2 m) laplacian psi(vb(x), t) + U(vb(x)) psi(vb(x), t). $]
$ <eq-tdse>
where $hbar$ is the reduced Planck's constant, $m$ is the mass of the particle, and $U(vb(x)) in RR$ is a real function called the potential, and $laplacian$ is the Laplacian operator w.r.t. $vb(x)$.

Note that

+ the 1st derivative is w.r.t. $t$, but the second derivative is w.r.t. $vb(x)$, so the @eq-tdse[TDSE] is a non-relativistic equation due to this asymmetry.

+ once $psi(vb(x), t_0)$ is known, @eq-tdse[TDSE] gives $psi(vb(x), t)$ for all $t > t_0$.

+ the dimension of $psi$ is $[psi] = ["length"]^(-(3)/(2))$

=== Heuristic Interpretation of TDSE in 1D

We know that $electron$ behaves like a wave. Take the solution of the wave equation
$
  ee^(ii (k x - omega t)).
$ <eq-sol-wave-equation>
For EM waves, we have $omega = c k$. We wish to know the dispersion relation for $electron$.

In 1D with $U = 0$, @eq-tdse[TDSE] reads
$
  - ii hbar pdv(psi(x, t), t) = (hbar^2)/(2 m) pdv(psi(x, t), x, 2).
$
Substituting @eq-sol-wave-equation gives $- hbar omega = - (hbar^2 k^2)/(2 m)$, and hence $omega prop k^2$.

This is consistent with the de Broglie relation, since $k = (p)/(hbar)$ and $omega = (E)/(hbar)$, and hence for a free particle, $E = (p^2)/(2 m)$. Therefore,
$
  omega = (p^2)/(2 m hbar) = (hbar k^2)/(2 m) prop k^2.
$

However, if the above are true, we do not yet know if this is compatible with the probabilistic interpretation of $psi$, since we require that the total probability is conserved.

#proposition[
  If $psi$ obeys @eq-tdse[TDSE], then the normalisation of $psi$ is preserved.
]

#proof[
  We have
  $
    integral_(RR^3) abs(psi(vb(x), t))^2 dif^3 vb(x) = N.
  $
  Then
  $
    dv(N, t) & = dv(, t) integral_(RR^3) abs(psi(vb(x), t))^2 dif^3 vb(x) \
             & = integral_(RR^3) pdv(, t) abs(psi(vb(x), t))^2 dif^3 vb(x).
  $
  Note that $pdv((psi^* psi), t) = psi^* pdv(psi, t) + pdv(psi^*, t) psi$. Hence @eq-tdse[TDSE] gives
  $
      pdv(psi, t) & = (ii hbar)/(2 m) laplacian psi - (ii U )/(hbar) psi \
    pdv(psi^*, t) & = -(ii hbar)/(2 m) laplacian psi^* + (ii U)/(hbar) psi^*.
  $
  Because $laplacian = grad dot grad$, we have
  $
    pdv(, t)(psi^* psi) = div ((ii hbar)/(2 m) (psi^* grad psi - psi grad psi^*) ).
  $ <eq-preservation-of-probability>
  Hence
  $
    dv(N, t) = integral_(RR^3) div ((ii hbar)/(2 m) (psi^* grad psi - psi grad psi^*) ) dif^3 vb(x) = 0,
  $
  because $psi, psi^*$ are square-integrable and vanish at infinity. Therefore, $N$ is independent of $t$.
]

#lecture-separator(lecture: 4, date: "2026-10-20")

Note that @eq-preservation-of-probability is a continuity equation, where probability is conserved. It can be rewritten as
$
  pdv(, t) rho(vb(x), t) + div vb(j) = 0,
$
where $rho(vb(x), t) = |psi(vb(x), t)|^2$ is the probability density, and $vb(j) = -(ii hbar)/(2 m) (psi^* grad psi - psi grad psi^*)$ is the probability current.

Hence, the conservation of probability in quantum mechanics is guaranteed by TDSE.

== Measurements in Quantum Mechanics

We will now consider how to extract information from a state $psi$, apart from the probability distribution of the position of the particle, like momentum, energy, etc.

#definition[Observable][
  An *observable* is a physical quantity of a particle described by $psi$ that can be measured.
]

In quantum mechanics, the following correspondence exists:
$
   "observable" & <-> "operator" hat(O) "acting on" psi, \
  "measurement" & <-> "expectation value of an operator" expt(hat(O)).
$

=== Heuristic Derivation of Expectation Values for $x$, $p$

Consider the mean value of a fair six-sided die from an infinite number of rolls. Then, we have
$
  expt("result") = sum_(i=1)^6 (i)/(6) = 3.5.
$

The expectation value of an observable $O$ is the mean of an infinite series of measurements performed on particles all prepared in state $psi$. For example,
$
  expt(x) & = integral_(-oo)^(oo) x rho(x, t) dif x #eq-note($"in 1D, where" rho(x, t) = |psi(x, t)|^2$) \
  & = integral_(-oo)^(oo) psi^*(x, t) x psi(x, t) dif x. #(<eq-expt-x>)\
  expt(p) & = m dv(expt(x), t) \
  & = m dv(, t) integral_(-oo)^(oo) psi^* x psi dif x \
  & = m integral_(-oo)^(oo) x pdv(psi^* psi, t) dif x \
  & = (ii hbar m)/(2m) integral_(-oo)^(oo) x pdv(, x) (psi^* pdv(psi, x) - psi pdv(psi^*, x)) dif x #eq-note("by TDSE") \
  &= integral_(-oo)^(oo) psi^* (-ii hbar pdv(, x)) psi dif x. #(<eq-expt-p>) \
$

#remark[
  The expectation value is the average of repeated measurements on an ensemble of identically prepared systems, not the average of repeated measurements on the same system, since once a measurement is made, the state of the system collapses to an eigenstate of the observable being measured.
]

Note that @eq-expt-x and @eq-expt-p are of similar forms, where a certain term is sandwiched between $psi^*$ and $psi$ and integrated over all space. Heuristically, the expectation value of an observable would be given by
$
  integral_(-oo)^(oo) psi^* #fade[[operator]] psi dif x.
$

=== Hermitian Operator

In $CC^n$ one can define a linear map $matbold(T): CC^n -> CC^n$ where $vb(v) |-> vb(w)$, and can write
$
  vb(w) = matbold(T) vb(v), quad matbold(T) = mat(t_11, dots, t_(1 n); dots.v, dots.down, dots.v; t_(n 1), dots, t_(n n)).
$

Similarly, in $hilb$ one can define a linear map $hat(O): hilb -> hilb$ where $psi |-> phi$, and can write
$
  phi = hat(O) psi.
$
In this course, we will always work in the $vb(x)$ representation, so that $hat(O)$ and $psi$ are both expressed in the basis ${vb(x)}$.

#definition[Operator in $hilb$][
  An *operator* $hat(O)$ in $hilb$ is any linear map $hilb -> hilb$ such that
  $
    hat(O)(a_1 psi_1 + a_2 psi_2) = a_1 hat(O) psi_1 + a_2 hat(O) psi_2, quad forall a_1, a_2 in CC, psi_1, psi_2 in hilb.
  $
]

#example[
  The following are examples of operators in $hilb$:

  - finite differential operators
    $
      sum_(n=0)^N q_n (x) pdv(, x, [n]) .#eq-note[$q_n (x)$ are polynomials]
    $
    Note that $x$ and $-ii hbar pdv(, x)$ are both such operators in $hilb$;

  - translations

    $
      hat(S)_a : psi(x) |-> psi(x - a), quad forall a in RR.
    $

  - parity operator
    $
      hat(P) : psi(x) |-> psi(-x).
    $
]

#definition[Hermitian conjugate][
  The *Hermitian conjugate* $hat(O)^dagger$ of an operator $hat(O)$ is the operator such that
  $
    iprod(hat(O)^dagger psi_1, psi_2) = iprod(psi_1, hat(O) psi_2), quad forall psi_1, psi_2 in hilb.
  $
]

#proposition[
  It is easy to verify that, for all operators $hat(A)_1$, $hat(A)_2$ on $hilb$ and all $a_1, a_2 in CC$,
  $
    (a_1 hat(A)_1 + a_2 hat(A)_2)^dagger &= a_1^* hat(A)_1^dagger + a_2^* hat(A)_2^dagger, \
    (hat(A)_1 hat(A)_2)^dagger &= hat(A)_2^dagger hat(A)_1^dagger.
  $
]

#definition[Hermitian operator][
  An operator $hat(O)$ is *Hermitian* if
  $
    hat(O)^dagger = hat(O),
  $
  _i.e._
  $
    iprod(hat(O) psi_1, psi_2) = iprod(psi_1, hat(O) psi_2), quad forall psi_1, psi_2 in hilb.
  $
]

The reason we are interested in Hermitian operators is that all physical quantities (observables) are represented by Hermitian operators. #fade[[Recall from IA Vectors and Matrices and IB Linear Algebra that Hermitian matrices have real eigenvalues and orthogonal eigenvectors, which is useful for measurements in quantum mechanics.]]

#example[
  + Consider the position operator $hat(x): psi(x, t) |-> x psi(x, t)$. To verify that $hat(x)$ is Hermitian,
    $
      hat(x)^dagger = hat(x) & <=> & iprod(hat(x) psi_1, psi_2) = iprod(psi_1, hat(x) psi_2). #eq-note[$forall psi_1, psi_2 in hilb$]\
    $
    Now,
    $
      iprod(hat(x) psi_1, psi_2) & = integral_(-oo)^(oo) (x psi_1)^* psi_2 dif x \
                                 & = integral_(-oo)^(oo) x psi_1^* psi_2 dif x \
                                 & = integral_(-oo)^(oo) psi_1^* x psi_2 dif x \
                                 & = iprod(psi_1, hat(x) psi_2). \
    $

  + Consider the momentum  operator $hat(p): psi(x, t) |-> -ii hbar pdv(, x) psi(x, t)$. To verify that $hat(p)$ is Hermitian,
    $
      hat(p)^dagger = hat(p) & <=> & iprod(hat(p) psi_1, psi_2) = iprod(psi_1, hat(p) psi_2). #eq-note[$forall psi_1, psi_2 in hilb$]\
    $
    Now,
    $
      iprod(hat(p) psi_1, psi_2) & = integral_(-oo)^(oo) (-ii hbar pdv(psi_1, x))^* psi_2 dif x \
      & = ii hbar integral_(-oo)^(oo) pdv(psi_1^*, x) psi_2 dif x \
      & = [ii hbar (psi_1^* psi_2)]_(x=-oo)^(x=oo) - ii hbar integral_(-oo)^(oo) psi_1^* pdv(psi_2, x) dif x #eq-note[by parts]\
      & = integral_(-oo)^(oo) psi_1^* (-ii hbar pdv(psi_2, x)) dif x \
      & = iprod(psi_1, hat(p) psi_2). \
    $

  The following are also Hermitian operators, but we will not prove them here:

  + The kinetic energy operator
    $
      hat(T) : psi(x, t) |-> hat(p)^2/(2m) psi(x, t) = -(hbar^2)/(2 m) pdv(, x, 2) psi(x, t).
    $

  + The potential energy operator
    $
      hat(U) : psi(x, t) |-> U(x) psi(x, t)
    $
    where $U in RR$.

  + The total energy operator (Hamiltonian)
    $
      hat(H) : psi(x, t) |-> (hat(T) + hat(U)) psi(x, t) = -(hbar^2)/(2 m) pdv(, x, 2) psi(x, t) + U(x) psi(x, t),
    $
    note that $hat(H)$ is the operator in the RHS of @eq-tdse[TDSE].
]

#theorem[
  The eigenvalues of Hermitian operators are real.
]

#proof[
  Let $hat(A)$ be a Hermitian operator with eigenvalue $a in CC$, and let $psi in hilb$ be a corresponding eigenfunction with $norm(psi) = 1$. Then
  $
    iprod(psi, hat(A) psi) & =iprod(psi, a psi) \
                           & = a iprod(psi, psi) \
                           & = a norm(psi)^2 \
                           & = a \
  $
  But since $hat(A)$ is Hermitian, we have
  $
    iprod(psi, hat(A) psi) & = iprod(hat(A) psi, psi) \
                           & = iprod(a psi, psi) \
                           & = a^* iprod(psi, psi) \
                           & = a^*. \
  $
  Hence $a = a^* in RR$.

]

#lecture-separator(lecture: 5, date: "2026-10-22")

#theorem[
  If $hat(A)$ is a Hermitian operator, and $psi_1$, $psi_2$ are normalised eigenfunctions of $hat(A)$ with eigenvalues $a_1, a_2 in RR$ respectively and $a_1 != a_2$, then $psi_1$ and $psi_2$ are orthogonal.
]

#proof[
  We have
  $
    hat(A) psi_1 & = a_1 psi_1 \
    hat(A) psi_2 & = a_2 psi_2 \
  $
  So
  $
    a_1 iprod(psi_1, psi_2) & = a^*_1 iprod(psi_1, psi_2)  & = & iprod(a_1 psi_1, psi_2) \
                            & = iprod(hat(A) psi_1, psi_2) & = & iprod(psi_1, hat(A) psi_2) \
                            & = iprod(psi_1, a_2 psi_2)    & = & a_2 iprod(psi_1, psi_2). \
  $
  Therefore $(a_1 - a_2) iprod(psi_1, psi_2) = 0$, which implies that $iprod(psi_1, psi_2) = 0$ since $a_1 != a_2$. Thus $psi_1$ and $psi_2$ are orthogonal.
]

#theorem[
  The discrete and continuous sets of eigenfunctions of any Hermitian operator together form a complete orthogonal basis of $hilb$, once an orthogonal basis of eigenfunctions is chosen for each degenerate eigenvalue.
] <thm-complete-orthonormal-basis>

This theorem is difficult to prove, and hence we will assume this result without proof in this course.

By @thm-complete-orthonormal-basis, for any $psi in hilb$, we can write
$
  psi(x, t) = sum_(i=0)^oo a_i psi_i (x, t)
$
where $a_i in CC$ and ${psi_i}$ is a set of eigenfunctions of the Hermitian operator. Note that if one finds ${psi_i}$ for a Hermitian operator $hat(A)$, then any wavefunction can be written as a linear combination of $psi_i$.

Moreover, if the basis is continuous, then for ${psi_lambda (x, t)}_(lambda in RR)$ we can write
$
  psi(x, t) = integral_(Delta lambda) a(lambda) psi_lambda (x, t) dif lambda
$
where $a(lambda) in CC$ and $Delta lambda subset.eq RR$.

=== Expectation Values and Measurements

#rule[Copenhagen interpretation of quantum mechanics][
  The Copenhagen interpretation of quantum mechanics introduces the following postulates for a measurement of an observable $O$ represented by a Hermitian operator $hat(O)$:

  + The eigenvalues of $hat(O)$ are the possible outcomes of a measurement of $O$.

  + If $hat(O)$ has a discrete set of normalised eigenfunctions ${psi_i}$ with distinct eigenvalues ${lambda_i}$, then the measurement of $O$ on a particle described by state $psi$ satisfies
    $
      PP(O = lambda_i) = abs(a_i)^2= abs(iprod(psi_i, psi))^2
    $
    where $psi = sum_(i = 0)^oo a_i psi_i$.

  + Extending from (2), if ${psi_i}$ is an orthonormal set of eigenfunctions of $hat(O)$ and ${psi_j}_(j in J)$ is the subset of all those eigenfunctions with eigenvalue $lambda$, then
    $
      PP(O=lambda) = sum_(j in J) abs(a_j)^2 = sum_(j in J) abs(iprod(psi_j, psi))^2.
    $

    As a sanity check, we have
    $
      sum_(i=0)^oo abs(a_i)^2 = sum_(i=0)^oo iprod(a_i psi_i, a_i psi_i) = sum_(i, j = 0)^oo iprod(a_i psi_i, a_j psi_j) = iprod(psi, psi) = 1,
    $
    as required by the probabilistic interpretation of $psi$.

  + *The projection postulate.* If $O$ is measured on $psi$ at time $t$ and the outcome of measurement is $lambda_i$, then the wavefunction of $psi$ instantaneously collapses after the measurement to $psi_i$, the eigenfunction of $hat(O)$ corresponding to the eigenvalue $lambda_i$.

  + Extending from (4), if the outcome of measurement is $lambda$, then the wavefunction of $psi$ instantaneously collapses after the measurement to
    $
      psi_lambda = sum_(j in J) a_j psi_j
    $
    where ${psi_j}_(j in J)$ is the subset of all those eigenfunctions with eigenvalue $lambda$, up to a normalisation factor.

]

The process of (4) can be described using the projection operator.

#definition[Projection Operator][
  The projection operator $hat(P)_i$ on $psi = sum_j a_j psi_j = sum_j iprod(psi_j, psi) psi_j$ is defined as
  $
    hat(P)_i: psi |-> iprod(psi_i, psi) psi_i.
  $
]

The projection postulate tells us that if $O$ is measured twice at time interval $Delta t -> 0$, the second measurement yields the same result as the first with probability $1$.

We can formulate the expectation value of an observable $O$ represented by a Hermitian operator $hat(O)$.

#proposition[
  The expectation value of $O$ measured on state $psi$ is given by
  $
    expt(O)_psi & = sum_(i=0)^oo lambda_i PP(O = lambda_i) \
                & = sum_(i=0)^oo lambda_i abs(a_i)^2 \
                & = sum_(i=0)^oo lambda_i abs(iprod(psi_i, psi))^2 \
                & = iprod(sum_(i=0)^oo iprod(psi_i, psi) psi_i, sum_(j=0)^oo lambda_j iprod(psi_j, psi) psi_j) \
                & = iprod(psi, hat(O) psi) \
                & = integral_(-oo)^(oo) psi^*(x, t) hat(O) psi(x, t) dif x. #eq-note[in 1D] \
  $
]

#proposition[
  For Hermitian operators $hat(A)$, $hat(B)$ and state $psi$, we have
  $
    expt(a hat(A) + b hat(B))_psi = a expt(hat(A))_psi + b expt(hat(B))_psi, quad forall a, b in RR.
  $
]

The discussion about expectation values we had allows us to give a physical interpretation of the inner product in $hilb$.

#rule[Born's Rule \#2][
  If $phi$ is the state that gives the desired outcome of a measurement on a particle described by $psi$, then the probability of obtaining the desired outcome is
  $
    abs(iprod(phi, psi))^2 = abs(integral_(-oo)^(oo) phi^* (x, t) psi(x, t) dif x)^2.
  $
]

== Time-Independent Schrödinger Equation (TISE)

Recall the @eq-tdse[TDSE] in 1D,
$
  ii hbar pdv(psi(x, t), t) & = -(hbar^2)/(2 m) pdv(psi(x, t), x, 2) + U(x) psi(x, t) \
                            & = hat(H) psi(x, t) \
$
where $hat(H) = hat(T) + hat(U)$ is the Hamiltonian operator. We try to solve this equation using a factorised ansatz
$
  psi(x, t) = T(t) chi(x).
$
Substituting into @eq-tdse[TDSE] gives
$
      ii hbar pdv(T(t), t) chi(x) & = T(t) hat(H) chi(x) \
  (1)/(T(t)) ii hbar pdv(T(t), t) & = (hat(H) chi(x))/(chi(x)) \
$
Since the LHS is a function of $t$ only and the RHS is a function of $x$ only, both sides must be equal to a constant $E in RR$. Hence we have
$
  (1)/(T(t)) ii hbar pdv(T(t), t) = E
$ <eq-tise-for-t>
and the time-independent Schrödinger equation (TISE)
$
  #boxed[
    $hat(H) chi = E chi.$
  ]
$ <eq-tise>

#lecture-separator(lecture: 6, date: "2026-10-27")

Rewriting @eq-tise-for-t gives
$
  (1)/(T(t)) ii hbar pdv(T(t), t) & = E \
                             T(t) & = ee^(-(ii E t)/(hbar)) #eq-note[complex coeff. does not matter] \
$
@eq-tise[TISE] gives
$
  hat(H) chi(x) = E chi(x)\
$
$
  #boxed[$ -hbar^2/(2 m) pdv(chi(x), x, 2) + U(x) chi(x) = E chi(x). \ $]
$ <eq-tise-2>
where @eq-tise-2 is the TISE (time-independent Schrödinger equation) in 1D.

#remark[
  - @eq-tise[TISE] is an eigenvalue equation for $hat(H)$;

  - eigenvalues of $hat(H)$ are all possible outcomes of measurements of energy of state $psi$.

]

== Stationary States

#definition[Stationary State][
  Particular solutions of @eq-tdse[TDSE] in the form
  $
    psi(x, t) = chi(x) ee^(-(ii E t)/(hbar))
  $ <eq-stationary-state>
  where $E$ is the eigenvalue of $hat(H)$ corresponding to the eigenfunction $chi(x)$, are called *stationary states*.
]
This is because
$
  rho(x, t) = abs(ee^(-(ii E t)/(hbar)) chi(x))^2 = abs(chi(x))^2
$
so the probability density is independent of time, and hence the state is stationary.

#theorem[
  Every solution of @eq-tdse[TDSE] can be written as a linear combination of stationary states. #fade[[This is an application of @thm-complete-orthonormal-basis.]]
]

- For systems with a discrete set of eigenvalues of $hat(H)$, say $E_n = E_0, E_1, ...$, we have
  $
    psi(x, t) = sum_n a_n chi_n (x) ee^(-(ii E_n t)/(hbar))
  $
  where $chi_n$ are the eigenfunctions of $hat(H)$ corresponding to the eigenvalues $E_n$.

  In particular, when $t = 0$,
  $
    psi(x, 0) = sum_n a_n chi_n (x).
  $

- For systems with a continuous set of eigenvalues of $hat(H)$, say $E_alpha$ where $alpha in RR$, then
  $
    psi(x, t) = integral_(-oo)^oo A_alpha chi_alpha (x) ee^(-(ii E_alpha t)/(hbar)) dif alpha
  $
  where $chi_alpha$ are the eigenfunctions of $hat(H)$ corresponding to the eigenvalues $E_alpha$.

Recall the Copenhagen interpretation, that $abs(a_n)^2$ gives the probability of measuring the energy $E_n$ in state $psi(x, t)$, and $abs(A_alpha)^2 dif alpha$ gives the probability of measuring the energy $E_alpha$ in state $psi(x, t)$ in $dif alpha$.

Imagine a system with only 2 eigenvalues $E_1 != E_2$. Then any state $psi$ can be written as
$
  psi(x, t) & = a_1 chi_1 (x) ee^(-(ii E_1 t)/(hbar)) + a_2 chi_2 (x) ee^(-(ii E_2 t)/(hbar)) \
  psi(x, 0) & = a_1 chi_1 (x) + a_2 chi_2 (x)
$

Hence,

- if $a_1 = 0$ or $a_2 = 0$, then $psi(x, t)$ is a stationary state.

- if $a_1, a_2 != 0$, then
  $
    rho(x, t) &= abs(psi(x, t))^2 \
    &= psi^* psi \
    &= (a_1^* chi_1^* ee^((ii E_1 t)/(hbar)) + a_2^* chi_2^* ee^((ii E_2 t)/(hbar))) (a_1 chi_1 ee^(-(ii E_1 t)/(hbar)) + a_2 chi_2 ee^(-(ii E_2 t)/(hbar))) \
    &= abs(a_1)^2 abs(chi_1)^2 + abs(a_2)^2 abs(chi_2)^2 + a_1^* a_2 chi_1^* chi_2 ee^((ii (E_1 - E_2) t)/(hbar)) + a_1 a_2^* chi_1 chi_2^* ee^(-(ii (E_1 - E_2) t)/(hbar)). \
  $

  Since $U$ is real, we may take $chi_1, chi_2$ real (absorbing any constant phase into $a_1, a_2$), and hence
  $
    chi_1^* chi_2 & -> chi_1 chi_2 \
    chi_1 chi_2^* & -> chi_1 chi_2. \
  $
  With $a_1 = abs(a_1) ee^(-ii alpha_1)$ and $a_2 = abs(a_2) ee^(-ii alpha_2)$, we have
  $
    a_1^* a_2 & = abs(a_1) abs(a_2) ee^(+ii (alpha_1 - alpha_2)) \
    a_1 a_2^* & = abs(a_1) abs(a_2) ee^(- ii (alpha_1 - alpha_2)). \
  $

  Therefore,
  $
    rho(x, t) = abs(a_1)^2 abs(chi_1)^2 + abs(a_2)^2 abs(chi_2)^2 + 2 abs(a_1) abs(a_2) chi_1 chi_2 cos(((E_1 - E_2) t)/(hbar) + alpha_1 - alpha_2).
  $
  Thus, the probability density at each point $x$ oscillates as $cos((E_1 - E_2)/(hbar) t)$, and the frequency depends on the energy difference $E_1 - E_2$.


