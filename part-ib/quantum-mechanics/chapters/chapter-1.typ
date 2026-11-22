#import "../prelude.typ": *
#show: chapter.with(1)

#lecture-separator(lecture: 1, date: "2026-10-08")

= Historical Introduction

First of all, we will consider several observations and incidents that led to the development of quantum mechanics.

#remark[
  Quantum mechanics involves a fundamental constant $h$ (Planck constant) or $hbar = (h)/(2ppi)$. It has dimension of $["energy"] times ["time"] = ["position"] times ["momentum"]$, and can be thought of as the _strength_ of quantum effects. In the limit $hbar -> 0$, we recover classical mechanics.
]

#notation[
  We will use the following symbols for particles in this course:

  #align(center, table(
    columns: (auto, auto),
    table.header([Symbol], [Meaning]),
    [$electron$], [#link("https://en.wikipedia.org/wiki/Electron")[electron]],
    [$positron$], [#link("https://en.wikipedia.org/wiki/Positron")[positron]],
    [$photon$], [#link("https://en.wikipedia.org/wiki/Photon")[photon]],
  ))
]

== Particles and Waves in Classical Mechanics

Classical mechanics is based on two distinct concepts:

+ *Particles*, which

  - are point-like objects;

  - are described by $vb(x)(t)$, $dot(vb(x))(t)$;

  - satisfy ODE $m dot.double(vb(x)) = vb(F)(vb(x), dot(vb(x)))$, and once $vb(x)_0$ and $dot(vb(x))_0$ are known, the solution gives $vb(x)(t), dot(vb(x))(t)$ for all $t$;

  - do not exhibit interference.

+ *Waves*, which

  - are spread-out objects;

  - are described by $f(x, t)$ periodic in $t$ or $x$;

  - have propagation determined by  the wave equation
    $
      pdv(f(x, t), t, 2) - c^2 pdv(f(x, t), x, 2) = 0,
    $
    whose solutions are superpositions of $f_(plus.minus ) (x, t) = A exp(ii (plus.minus k x - omega t))$ where $A in CC$, $k, omega in RR$, and solutions obey dispersion relation

    $
      #boxed($omega = c k$)
    $

    where $omega$ is the angular frequency related to $lambda$ and frequency $nu$ by
    $
      nu = (omega)/(2ppi), quad lambda = (2ppi c)/(omega )= (c)/(nu);
    $

  - can interfere either constructively or destructively.

== Particle-Like Properties of Light

Several experiments in the late 19th and early 20th century showed that light, which was previously thought to be a wave, also exhibited particle-like properties. These experiments include #link("https://en.wikipedia.org/wiki/Black-body_radiation")[black-body radiation], #link("https://en.wikipedia.org/wiki/Photoelectric_effect")[photoelectric effect] and #link("https://en.wikipedia.org/wiki/Compton_scattering")[Compton scattering].

We will mainly discuss the photoelectric effect in detail in this section.

=== Photoelectric Effect


#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e1.svg", width: 20em)
]

Consider shining light onto a metal surface, using a source of

- fixed wavelength $lambda$ for each beam, but

- changing intensity of light $I = abs(A)^2$.

The classical expectations are that

+ since incident light has energy $E prop I$, as $I$ increases and a threshold value $I_0$ is reached, then $electron$ will be emitted;

+ the emission rate #fade[[number of $electron$ emitted]] should be constant after the threshold, but velocity of electrons will increase with $I$.

However, we have observed that

+ below a given $omega$ (above a given $lambda$), there was no $electron$ emission;

+ the velocity of $electron$ depended on $omega$, not $I$;

+ the emission rate increases with $I$.

In 1905, Einstein proposed that


- light comes in small quanta #fade[[photons $photon$]];

- each quantum of light carries energy
  $ E = hbar omega, $
  and the momentum of light quanta satisfies
  $
    vb(p) = hbar vb(k)
  $
  where $vb(k)$ is the #link("https://en.wikipedia.org/wiki/Wave_vector")[wave vector] of the light quantum. We also observed that
  $
    "max KE of" electron = "energy of light quantum" - "work function" = hbar omega - phi,
  $
  where the work function $phi$ is the energy binding $electron$ to the metal. Hence
  $
    E_max (omega_min) = 0 = hbar omega_min - phi.
  $
From this, we can explain our observations that

+ below $omega_min = (phi)/(hbar)$, nothing happens;

+ $E_max = hbar omega - phi$ for $omega > omega_min$, so the velocity of $electron$ depends on $omega$;

+ larger $I$ implies more light quanta, so more scattering events happen, and hence more $electron$ emitted.

== Atomic Spectra

We used the Rutherford model for atoms in the early 20th century:

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e2.svg", width: 8em)
]

However, the model could not work due to the following reasons:

+ $electron$ on orbits around nucleus are accelerating, so would radiate energy;

+ $electron$ would therefore spiral in and collapse on nucleus;

+ experimentally measured #link("https://en.wikipedia.org/wiki/Emission_spectrum")[atomic spectra] were discrete, where the light emitted by atoms when hit by light was described by a set of lines
  $
    omega_(m n) = 2ppi c R_0 ((1)/(n^2) - (1)/(m^2)) quad "where" quad m, n in ZZ^+, m > n, #<eq-spectral-lines>
  $
  where $R_0$ is the Rydberg constant.

Bohr explained (1)--(3) by the following postulate:

#claim[
  The orbital angular momentum $L$ of $electron$ around nucleus only takes values that are integer multiples of $hbar$:
  $
    L_n = hbar n, quad "where" n in ZZ^+. #<eq-discrete-ang-momentum>
  $
]

With the claim, we can propose:

#claim[
  The quantisation of $L$ implies the quantisation of $r$, $v$ and $E$.
]
#proof[
  For the case of a hydrogen atom, we have $Z=1$ and
  $
    vb(L) = m_ee vb(r) times vb(v).
  $
  Assuming circular orbit,
  $
    abs(vb(L)) & = L = m_ee v r \
             v & = (L)/(m_ee r) \
           v_n & = (n hbar)/(m_ee r_n). #eq-note[by @eq-discrete-ang-momentum] #<eq-discrete-velocity>
  $
  with $vb(F)_"Coulomb" = m_ee vb(a) = -(e^2)/(4ppi epsilon_0 r^2) vb(e)_r$. Hence
  $
    (e^2)/(4ppi epsilon_0) (1)/(r^2) & = m_ee v^2/r #<eq-force-balance> \
    r_n & = (4ppi epsilon_0)/(m_ee e^2) hbar^2 n^2. #eq-note[by @eq-discrete-velocity] #<eq-discrete-radius>
  $
  Therefore, the minimum radius #fade[[Bohr radius]] is
  $
    r_1 = (4ppi epsilon_0)/(m_ee e^2) hbar^2. #<eq-bohr-radius>
  $
  Moreover,
  $
    E_n & = (1)/(2) m_ee v_n^2 - (e^2)/(4ppi epsilon_0 r_n) \
        & = -(e^2)/(8ppi epsilon_0 r_n) #eq-note[by @eq-force-balance] \
        & = -(e^2)/(8ppi epsilon_0 r_1) (1)/(n^2). #eq-note[by @eq-discrete-radius] #<eq-discrete-energy>
  $
  Hence,
  $
    hbar omega = E => omega_(m n) & = (E_m - E_n)/(hbar) \
    & = (e^2)/(8ppi epsilon_0 r_1 hbar) ((1)/(n^2) - (1)/(m^2)) #eq-note[by @eq-discrete-energy] \
    & = 2ppi c underbracket((m_ee c)/(2 h) ((e^2)/(4ppi epsilon_0 hbar c))^2, R_0) ((1)/(n^2) - (1)/(m^2)) #eq-note[by @eq-bohr-radius]
  $
  and we recover @eq-spectral-lines.
]

In particular, $v_n prop (1)/(n)$, $r_n prop n^2$ and $E_n prop (1)/(n^2)$.

$r_1$ is called the Bohr radius, and $E_1$ is called the ground state energy of the hydrogen atom.

== Particles Behaving Like Waves

Observations such as #link("https://en.wikipedia.org/wiki/Electron_diffraction")[$electron$ diffraction], which confirmed the #link("https://en.wikipedia.org/wiki/Matter_wave")[de Broglie hypothesis], show that particles can also behave like waves.

#lecture-separator(lecture: 2, date: "2026-10-13")

In 1923, de Broglie hypothesised that any particle of any mass $m$ is associated to a wave having
$
  omega & = (E)/(hbar) \
  vb(k) & = vb(p)/(hbar).
$
In 1927, Davisson and Germer experimentally confirmed the hypothesis by observing an interference pattern of $electron$ beams scattered by a crystal.


