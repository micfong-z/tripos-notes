#import "../prelude.typ": *
#show: chapter.with(4)

= Simultaneous Measurements in Quantum Mechanics

Recall that in @sec-foundations-of-quantum-mechanics,

- we associated
  $
    & "observables" & <-> & "Hermitian operator" \
    & O & & hat(O) = hat(O)^dagger <=> iprod(psi, hat(O) phi) = iprod(hat(O) psi, phi) quad forall psi, phi in hilb, \
  $

- we associated
  $
    "possible outcomes" <-> "eigenvalues of" hat(O),
  $

- if $psi = sum a_i psi_i$, where $psi_i$ are eigenstates of $hat(O)$ with eigenvalue $lambda_i$, we have
  $
    PP(O = lambda_i) = abs(a_i)^2 = abs(iprod(psi, psi_i))^2,
  $

- immediately after measurement with outcome $lambda_i$, the wavefunction $psi$ becomes $psi_i$.

== Commutator

#definition[Commutator][
  The *commutator* of two operators $hat(A)$ and $hat(B)$ is the operator defined as
  $
    [hat(A), hat(B)] = hat(A) hat(B) - hat(B) hat(A).
  $
]

#proposition[Properties of Commutator][
  - $[hat(A), hat(B)] = -[hat(B), hat(A)]$

  - $[hat(A), hat(A)] = 0$

  - $[hat(A), hat(B)hat(C)] = [hat(A), hat(B)]hat(C) + hat(B)[hat(A), hat(C)]$

  - $[hat(A) hat(B), hat(C)] = hat(A) [hat(B), hat(C)] + [hat(A), hat(C)]hat(B)$

]

#example[
  Consider the commutator of the position and momentum operators $hat(x), hat(p)$ in 1D. Take $psi in hilb$. We have
  $
    hat(x) hat(p) psi & = x (-ii hbar pdv(, x)) psi(x, t) = -ii hbar x pdv(psi, x), \
    hat(p) hat(x) psi & = -ii hbar pdv(, x) (x psi(x, t)) = -ii hbar psi - ii hbar x pdv(psi, x). \
  $
  Therefore,
  $
    [hat(x), hat(p)] psi = ii hbar psi.
  $
  Hence,
  $
    [hat(x), hat(p)] = ii hbar hat(I)
  $
  where $hat(I)$ is the identity operator. This is known as the *canonical commutation relation*.
]

#definition[Simultaneously Diagonalisable Operators][
  Two Hermitian operators $hat(A), hat(B)$ are simultaneously diagonalisable in $hilb$ if there exists a complete basis for $hilb$ of joint eigenfunctions ${psi_i}$ such that
  $
    hat(A) psi_i = a_i psi_i, quad hat(B) psi_i = b_i psi_i,
  $
  with $a_i, b_i in RR$.

  #fade[[_i.e._ a set of shared eigenfunctions of $hat(A)$ and $hat(B)$ form a complete basis for $hilb$.]]
]

#theorem[
  Two Hermitian operators $hat(A), hat(B)$ are simultaneously diagonalisable in $hilb$ if and only if $[hat(A), hat(B)] = 0$.
]


#proof[
  #fade[[$=>$]] $hat(A)$ and $hat(B)$ are simultaneously diagonalisable, so that there exists a set of joint eigenfunctions ${psi_i}$ such that it form a complete basis for $hilb$. Then, we have
  $
    forall psi_i quad [hat(A), hat(B)] psi_i = hat(A) hat(B) psi_i - hat(B) hat(A) psi_i = a_i b_i psi_i - b_i a_i psi_i = 0.
  $
  Hence take any $psi in hilb$, $psi = sum c_i psi_i$. We have
  $
    [hat(A), hat(B)] psi = sum c_i [hat(A), hat(B)] psi_i = 0.
  $
  Therefore, $[hat(A), hat(B)] = 0$.


  #fade[[$arrow.l.double$]] Take $psi_i$ to be an eigenfunction of $hat(A)$ with eigenvalue $a_i$. Then
  $
    0 = [hat(A), hat(B)] psi_i = hat(A) hat(B) psi_i - hat(B) hat(A) psi_i = hat(A) hat(B) psi_i - a_i hat(B) psi_i.
  $
  Therefore, $hat(A)(hat(B)psi_i) = a_i hat(B) psi_i$. Therefore, $hat(B)$ preserves the eigenspace of $hat(A)$ with eigenvalue $a_i$. So $eval(hat(B))_(E_i)$ is a Hermitian operator of $E_i$.

  This holds for all eigenspaces $E_i$ of $hat(A)$. Hence, we can find a complete basis of joint eigenfunctions of $hat(A)$ and $hat(B)$.
]

#lecture-separator(lecture: 11, date: "2026-11-12")

== Heisenberg's Uncertainty Principle

#definition[
  The *uncertainty* in the measurement of an observable $A$ on state $psi$ is
  $
    Delta_psi A = sqrt((Delta_psi A)^2)
  $
  where
  $
    (Delta_psi A)^2 = expt((hat(A) - expt(hat(A))_psi hat(I))^2)_psi = expt(hat(A)^2)_psi - expt(hat(A))_psi^2.
  $
]

The two definitions are indeed equivalent, since
$
  expt((hat(A) - expt(hat(A))_psi hat(I))^2)_psi &= iprod(psi, (hat(A) - expt(hat(A))_psi hat(I))^2 psi) \
  &= integral_(-oo)^(oo) psi^* (hat(A) - expt(hat(A))_psi hat(I))^2 psi dif x \
  &= integral_(-oo)^(oo) psi^* hat(A)^2 psi dif x + (expt(hat(A))_psi)^2 integral_(-oo)^(oo) psi^* psi dif x - 2 expt(hat(A))_psi integral_(-oo)^(oo) psi^* hat(A) psi dif x \
  &= expt(hat(A)^2)_psi - expt(hat(A))_psi^2. \
$

#lemma[
  For any observable $A$, we have $Delta_psi A >= 0$ and $Delta_psi A = 0$ if and only if $psi$ is an eigenstate of $hat(A)$.
]

#proof[
  Note that
  $
    (Delta_psi A)^2 & = iprod(psi, (hat(A) - expt(hat(A))_psi hat(I))^2 psi) \
                    & = iprod((hat(A) - expt(hat(A))_psi hat(I)) psi, (hat(A) - expt(hat(A))_psi hat(I)) psi) \
                    & = norm((hat(A) - expt(hat(A))_psi hat(I)) psi)^2 >= 0.
  $
  Let $phi = (hat(A) - expt(hat(A))_psi hat(I)) psi$.

  #fade[[$=>$]] We have $(Delta_psi A)^2 = norm(phi)^2 = iprod(phi, phi) = 0$ if and only if $phi = 0$, so
  $
    hat(A) psi = expt(hat(A))_psi psi.
  $
  Thus $psi$ is an eigenstate of $hat(A)$.

  #fade[[$arrow.l.double$]] If $psi$ is an eigenstate of $hat(A)$ with eigenvalue $a in RR$, then
  $
      expt(hat(A))_psi & = (psi, hat(A)psi) = a \
    expt(hat(A)^2)_psi & = a^2
  $
  and hence
  $
    (Delta_psi A)^2 = expt(hat(A)^2)_psi - expt(hat(A))_psi^2 = a^2 - a^2 = 0.
  $
]

#lemma[Cauchy-Schwarz Inequality][
  If $psi, phi in hilb$ then $abs(iprod(phi, psi))^2 <= iprod(phi, phi) iprod(psi, psi)$.

  Moreover, equality holds if and only if $phi =ee^(ii alpha) psi$ for some $alpha in RR$.
] <lem-quantum-cauchy-schwarz>

#proof[
  Direct calculation using the Cauchy-Schwarz inequality.
]

#theorem[Generalised uncertainty theorem][
  If $A, B$ are observables, and $psi$ is a state, then
  $
    (Delta_psi A)(Delta_psi B) >= (1)/(2) abs(expt([hat(A), hat(B)])_psi).
  $
]

#proof[
  We have
  $
    (Delta_psi A)^2 = iprod((hat(A) - expt(hat(A))_psi hat(I)) psi, (hat(A) - expt(hat(A))_psi hat(I)) psi).
  $
  Let $hat(A)' = hat(A) - expt(hat(A))_psi hat(I)$ and $hat(B)' = hat(B) - expt(hat(B))_psi hat(I)$. Then
  $
    (Delta_psi A)^2 & = iprod(hat(A)' psi, hat(A)' psi), \
    (Delta_psi B)^2 & = iprod(hat(B)' psi, hat(B)' psi).
  $
  Then by @lem-quantum-cauchy-schwarz,
  $
    (Delta_psi A)^2 (Delta_psi B)^2 & >= abs(iprod(hat(A)' psi, hat(B)' psi))^2 \
                                    & = abs(iprod(psi, hat(A)' hat(B)' psi))^2. \
  $
  Writing $hat(A)' hat(B)'$ in terms of the commutator and anticommutator, where the anticommutator is defined as ${hat(A)', hat(B)'} = hat(A)' hat(B)' + hat(B)' hat(A)'$, we get
  $
    hat(A)' hat(B)' = (1)/(2) [hat(A)', hat(B)'] + (1)/(2) {hat(A)', hat(B)'}.
  $
  Therefore,
  $
    (Delta_psi A)^2 (Delta_psi B)^2 & >= (1)/(4) abs(iprod(psi, [hat(A)', hat(B)'] psi) + iprod(psi, {hat(A)', hat(B)'} psi))^2.
  $


  Also, given Hermitian operators $hat(A)', hat(B)'$, we have
  $
    [hat(A)', hat(B)']^dagger = -[hat(A)', hat(B)'], quad {hat(A)', hat(B)'}^dagger = {hat(A)', hat(B)'}.
  $
  Hence for any state $psi$, we have
  $
    iprod(psi, [hat(A)', hat(B)']psi) = ii r,\
    iprod(psi, {hat(A)', hat(B)'}psi) = s,
  $
  for some $r, s in RR$. Therefore,
  $
    (Delta_psi A)^2 (Delta_psi B)^2 & >= (1)/(4) abs(ii r + s)^2 \
                                    & >= (1)/(4) r^2 \
                                    & = (1)/(4) abs(iprod(psi, [hat(A)', hat(B)'] psi))^2. \
  $
  But since $[hat(A)', hat(B)'] = [hat(A), hat(B)]$, we have
  $
    (Delta_psi A)(Delta_psi B) >= (1)/(2) abs(iprod(psi, [hat(A), hat(B)] psi)).
  $
]

Therefore we have the following consequences.

#corollary[
  If $[hat(A), hat(B)] = 0$, then $A, B$ can be measured simultaneously with arbitrary precision on $psi in hilb.$
]

#corollary[Heisenberg uncertainty principle][
  Take $A = x$ and $B = p$. Then $[hat(x), hat(p)] = ii hbar hat(I)$, so that
  $ (Delta_psi x)(Delta_psi p) >= (hbar)/(2). $
  This is the *Heisenberg uncertainty principle*.
]

Recall that with $psi = psi_"GP"$, we have
$
  (Delta_(psi_"GP")(x))(Delta_(psi_"GP")(p) )= (hbar)/(2)
$
So the Gaussian wavepacket is a state of minimum uncertainty.

#lemma[
  $psi$ is a state of minimum uncertainty if and only if $hat(x) psi = ii a hat(p) psi$ for some $a in RR$.

  Moreover, this holds if and only if $psi (x) = C ee^(-b x^2)$ for some $C in CC, b in RR^+$.
]
Note that with $psi = ee^(ii k x) ee^(-(ii hbar k^2)/(2 hbar) t)$, we have $delta p = 0$ and $delta x = oo$. This is a state of minimum uncertainty, but it is not normalisable.

== Ehrenfest Theorem

#theorem[
  The expectation value of $hat(A)$ evolves according to
  $
    dv(, t) expt(hat(A))_psi = (1)/(ii hbar) expt([hat(H), hat(A)])_psi + expt(pdv(hat(A), t))_psi.
  $
]

#proof[
  We have
  $
    dv(, t) expt(hat(A))_psi & = dv(, t) integral_(-oo)^(oo) psi^* hat(A) psi dif x \
    & = integral_(-oo)^(oo) pdv(, t) (psi^* hat(A) psi) dif x \
    &= integral_(-oo)^(oo) (pdv(psi^*, t) hat(A) psi + psi^* pdv(hat(A), t) psi + psi^* hat(A) pdv(psi, t)) dif x \
  $
  Using @eq-tdse[TDSE] on $psi$ and $psi^*$, we have
  $
    dv(, t) expt(hat(A))_psi &= (ii)/(hbar) integral_(-oo)^(oo) (psi^* hat(H) hat(A) psi - psi^* hat(A) hat(H) psi) dif x + integral_(-oo)^(oo) psi^* pdv(hat(A), t) psi dif x \
    &= (ii)/(hbar) integral_(-oo)^(oo) psi^* [hat(H), hat(A)] psi dif x + expt(pdv(hat(A), t))_psi \
    &= (1)/(ii hbar) expt([hat(H), hat(A)])_psi + expt(pdv(hat(A), t))_psi.
  $


]

#example[
  + Take $hat(A) = hat(H)$. Then we get
    $
      dv(E, t) = 0
    $
    which is the conservation of energy.

  + Take $hat(A) = hat(p)$, then we get
    $
      dv(p, t) = - expt(pdv(U, x))_psi
    $
    so we have $dot(p) = - dv(U, x)$.


  + Take $hat(A) = hat(x)$, then we get
    $
      dv(x, t) = (1)/(m) expt(hat(p))_psi
    $
    so we have $dot(x) = p/m$.
]

#lecture-separator(lecture: 12, date: "2026-11-17")

== Harmonic Oscillator, Revisited #fade[[Non-examinable]]

We can use the commutator to solve the harmonic oscillator problem seen in @sec-harmonic-oscillator.

Consider the harmonic oscillator with Hamiltonian
$
  hat(H) = (hat(p)^2)/(2m) + (1)/(2) m omega^2 hat(x)^2
$
and let $k = m omega^2$ be the spring constant. Then we can rewrite $hat(H)$ as
$
  hat(H) & = (1)/(2m) (hat(p) ii m omega hat(x)) (hat(p) - ii m omega hat(x)) + (ii omega)/(2) [hat(x), hat(p)] \
         & = (1)/(2m) (hat(p) + ii m omega hat(x))(hat(p) - ii m omega hat(x)) + (hbar omega)/(2) hat(I). \
$
#definition[Ladder Operator][
  Let
  $
    hat(a) = (1)/(sqrt(2m)) (hat(p) - ii m omega hat(x)), quad hat(a)^dagger = (1)/(sqrt(2m)) (hat(p) + ii m omega hat(x)).
  $
  These are the *ladder operators*. Note that we have
  $
    hat(H) = hat(a)^dagger hat(a) + (hbar omega)/(2) hat(I).
  $
]
Compute
$
  [hat(a), hat(a)^dagger] & = (1)/(2m) [hat(p) - ii m omega hat(x), hat(p) + ii m omega hat(x)] \
                          & = hbar omega hat(I). \
         [hat(H), hat(a)] & = [hat(a)^dagger hat(a), hat(a)] \
                          & = [hat(a)^dagger, hat(a)] hat(a) \
                          & = -hbar omega hat(a). \
  [hat(H), hat(a)^dagger] & = [hat(a)^dagger hat(a), hat(a)^dagger] \
                          & = [hat(a)^dagger, hat(a)^dagger] hat(a) \
                          & = hbar omega hat(a)^dagger. \
$

Now suppose $chi$ is an eigenstate of $hat(H)$ with eigenvalue $E$, _i.e._ $hat(H) chi = E chi$.

Consider the energy in the case of $chi |-> (hat(a) chi)$. We have
$
  hat(H)(hat(a) chi) & = hat(H) hat(a) chi \
                     & = [hat(H), hat(a)] chi + hat(a) hat(H) chi \
                     & = -hbar omega hat(a) chi + E hat(a) chi \
                     & = (E - hbar omega)(hat(a) chi).
$
Similarly,
$
  hat(H)(hat(a)^dagger chi) & = (E + hbar omega)(hat(a)^dagger chi). \
$
Hence, $hat(a) chi$ is an eigenstate of $hat(H)$ with energy $E - hbar omega$ and $hat(a)^dagger chi$ is an eigenstate of $hat(H)$ with energy $E + hbar omega$. We can prove by induction that
$
           (hat(a)^n chi) "is an eigenstate of" hat(H) "with eigenvalue" & E - n hbar omega, \
  ((hat(a)^dagger)^n chi) "is an eigenstate of" hat(H) "with eigenvalue" & E + n hbar omega.
$

Using the fact that $E >= 0$, we must have $expt(hat(H))_chi >=0$, there cannot be an eigenstate of arbitrarily low energy. Hence, there exists an eigenstate $chi_0$ such that
$
  hat(a) chi_0 = 0.
$
We can find $chi_0$ by
$
  (1)/(sqrt(2m)) (hat(p) - ii m omega hat(x)) chi_0 & = 0 \
        -ii hbar pdv(chi_0, x) - ii m omega x chi_0 & = 0 \
                                          chi_0 (x) & = C ee^(-(m omega)/(2 hbar) x^2).
$
Hence, the ground state energy is given by
$
  hat(H) chi_0 & = hat(a)^dagger hat(a) chi_0 + (hbar omega)/(2) hat(I) chi_0 \
               & = (hbar omega)/(2) chi_0. \
$
Hence $E_0 = (hbar omega)/(2)$. To find states with $E > E_0$, consider
$
  chi_n = (hat(a)^dagger)^n chi_0 & = (1)/(sqrt(2m))^n (hat(p) + ii m omega hat(x))^n chi_0 \
                                  & = (C)/(2m)^((n)/(2)) (-ii hbar dv(, x) + ii m omega x)^n ee^(-(m omega)/(2 hbar) x^2) \
$
which gives the Hermite polynomials. The corresponding eigenvalues are
$
  E_n = (hbar omega)/(2) + n hbar omega = (n + (1)/(2)) hbar omega, quad n in ZZ^+.
$






