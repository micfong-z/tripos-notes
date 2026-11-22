#import "../prelude.typ": *
#show: chapter.with(3)

= 1D Solutions of the Time-Independent Schrödinger Equation

Recall @eq-tise[TISE],
$
  hat(H) chi = E chi.
$
The goal of this section is to find $E$, $chi$ for several systems.

#remark[
  The full form of the TISE is
  $
    -hbar^2/(2m) chi''(x) + U(x) chi(x) = E chi(x) quad E in RR.
  $

  The continuity of $chi$ and its derivative $chi'$ depends on the potential $U(x)$:

  - if $U(x)$ is finite, then $chi$ and $chi'$ must be continuous, though $chi''$ may jump where $U$ does;

  - if $U(x)$ is infinite (not just unbounded) in some regions, then $chi$ must be continuous but $chi'$ need not be. This case is illustrated in an infinite potential well #fade[[see @sec-infinite-potential-well]] and Q2 on Example Sheet 2.

]

== Bound States

=== Infinite Potential Well <sec-infinite-potential-well>

Consider, for some $a in RR^+$,
$
  U(x) = cases(
    0 quad & abs(x) <= a,
    oo quad & abs(x) > a.
  )
$

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e3.svg", width: 22em)
]

For $abs(x) > a$, we have $chi(x) = 0$, since otherwise $U chi = oo$.

For $abs(x) <= a$, we look for solutions of TISE in this region.
$
  -hbar^2/(2m) chi''(x) = E chi(x) quad =>quad chi'' + (2m E)/(hbar^2) chi = 0.
$
In this particular system, $E > 0$: we cannot have negative kinetic energy since $U >= 0$, and $E = 0$ would make $chi$ linear, which vanishes at $x = plus.minus a$ only if $chi equiv 0$. Hence we can define $k^2 =(2m E)/(hbar^2) > 0$, and hence
$
  chi'' + k^2 chi = 0.
$
Solving gives
$
  chi(x) = A sin (k x) + B cos (k x).
$
If we impose continuity condition for $chi$ at $x = plus.minus a$, we have
$
  cases(
    chi(a) = 0,
    chi(-a) = 0
  )
  quad => quad
  cases(
    A sin(k a) = 0,
    B cos(k a) = 0.
  )
$
Since $sin(k a)$ and $cos(k a)$ cannot vanish simultaneously, either $A = 0$ or $B = 0$, so we have two options to consider:

- If $A = 0$, then $cos(k a) = 0$ and $k_n = (n ppi)/(2a)$ with $n$ odd. In this case,
  $
    chi_n (x) = B_n cos(k_n x) quad n = 1, 3, 5, ...
  $


- If $B = 0$, then $sin(k a) = 0$ and $k_n = (n ppi)/(2a)$ with $n$ even. In this case,
  $
    chi_n (x) = A_n sin(k_n x) quad n = 2, 4, 6, ...
  $

Having found $k_n$, we can find the energy eigenvalues
$
  E_n = (hbar^2)/(2m) k_n^2 = (hbar^2 n^2 ppi^2)/(8 m a^2) quad n = 1, 2, 3, ...
$

#lecture-separator(lecture: 7, date: "2026-10-29")

Hence we have found the eigenvalues of $hat(H)$. #fade[[Since $E_1 > 0$ the particle is never still in the well.]]

To find $A, B$, consider the normalisation condition
$
  integral_(-a)^(a) abs(chi_n (x))^2 dif x = 1.
$
We get
$
  A = B = ee^(ii alpha) sqrt((1)/(a)).
$
We can choose $alpha = 0$ without loss of generality, so we have
$
  A = B = sqrt((1)/(a)).
$
Hence the normalised eigenfunctions are
$
  chi_n (x) = sqrt((1)/(a)) cases(
    cos((n ppi x)/(2a)) quad & n "odd",
    sin((n ppi x)/(2a)) quad & n "even".
  )
$

#exercise[
  As $n->oo$, we obtain the classical limit. Show that the probability density $abs(chi_n (x))^2$ approaches a uniform distribution in this limit.
]

#exercise[
  Check that $eval(chi')_(x->a+) - eval(chi')_(x->a-) != 0$.
]

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/p1.svg", width: 40em)
]

#lemma[
  If a quantum system has non-degenerate eigenstates ($E_i != E_j$ for all $i != j$), then if $U(x) = U(-x)$, then the eigenfunctions of $hat(H)$ have to be either odd or even.
]

#proof[
  If $U(x) = U(-x)$, then @eq-tise[TISE] is invariant under $x |-> -x$. So, if $chi(x)$ is a solution with eigenvalue $E$, then also $chi(-x)$ is a solution with the same eigenvalue. Hence $chi(x)$ is equivalent to $chi(-x)$. Therefore,
  $
    chi(x) = lambda chi(-x) quad "with" quad abs(lambda) = 1.
  $
  So we have
  $
    chi(x) = chi(-(-x)) = lambda chi(-x) = lambda^2 chi(x).
  $
  So $lambda^2 = 1$ and $lambda = plus.minus 1$. Therefore, $chi(x) = plus.minus chi(-x)$.

  Hence the eigenfunctions of $hat(H)$ are either odd or even.
]

=== Finite Potential Well

Consider
$
  U(x) = cases(
    0 quad & abs(x) <= a,
    U_0 quad & abs(x) > a.
  )
$

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e4.svg", width: 22em)
]

Again $E >= 0$, and hence we look for bound states with $E < U_0$. Since $U(x)$ is symmetric, we look for even or odd eigenfunctions. #fade[[The odd case is examined in Example Sheet 2 Q3.]]

Solving @eq-tise[TISE] gives
$
  cases(
    -(hbar^2)/(2m) chi''(x) = E chi(x) quad & abs(x) <= a,
    -(hbar^2)/(2m) chi''(x) = (E - U_0) chi(x) quad & abs(x) > a.
  )
$

In the first region, with $k = sqrt((2 m E)/(hbar^2))$ we have
$
  chi''(x) + k^2 chi(x) = 0 quad =>quad chi(x) = A sin(k x) + B cos(k x).
$
For even solutions, we have $A = 0$. Hence $chi(x) = B cos(k x)$.

For the second region, with $overline(k) = sqrt((2 m (U_0 - E))/(hbar^2))$ we have
$
  chi''(x) - overline(k)^2 chi(x) = 0 quad =>quad chi(x) = C ee^(overline(k) x) + D ee^(-overline(k) x).
$
Imposing normalisability conditions, we have $C = 0$ for $x > a$ and $D = 0$ for $x < -a$. Hence
$
  chi(x) = cases(
    C ee^(overline(k) x) quad & x < -a,
    B cos(k x) quad & abs(x) <= a,
    D ee^(-overline(k) x) quad & x > a.
  )
$
$chi(x) = chi(-x)$ imposes $C = D$. Furthermore, continuity of $chi$ and $chi'$ at $x = plus.minus a$ gives #fade[[by symmetry, we only need to consider $x = a$]]

$
  cases(
    C ee^(-overline(k) a) & = B cos(k a),
    -overline(k) C ee^(-overline(k) a) & = -k B sin(k a)
  )
$ <eq-finite-potential-well-continuity>
Taking the ratio of the two equations gives
$
  k tan(k a) = overline(k).
$
Adding the definitions of $k$ and $overline(k)$ gives
$
  k^2 + overline(k)^2 = (2 m U_0)/(hbar^2).
$
We hence want to solve
$
  cases(
    k tan (k a) = overline(k),
    k^2 + overline(k)^2 = (2 m U_0)/(hbar^2).
  )
$
Rescaling with $xi = k a$ and $eta = overline(k)a$
gives
$
  cases(
    xi tan xi = eta,
    xi^2 + eta^2 = r_0^2 quad "with" quad r_0 = a sqrt((2 m U_0)/(hbar^2)).
  )
$
#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/p2.svg", width: 36em)
]
The eigenvalues of $hat(H)$ correspond to the points of intersection, $E_n = (hbar^2)/(2 m a^2) xi_n^2$, where $n = 1, ..., p$ since there are finitely many intersections.

One could also try to

+ use unused conditions in @eq-finite-potential-well-continuity to find $C(B)$;

+ use the normalisation condition to find $C$;

+ verify that $U_0-> oo$ and $r_0 ->oo$ gives solutions in @sec-infinite-potential-well.

=== Harmonic Oscillator <sec-harmonic-oscillator>

The harmonic oscillator is a system with potential
$
  U = (1)/(2) k x^2
$
where $k in RR^+$ is the elastic constant, $omega = sqrt((k)/(m))$ is the frequency of oscillation, and $k = m omega^2$.

Classical mechanics states that
$
  dot.double(x)(t) & = -omega^2 x(t) \
              x(t) & = A sin (omega t) + B cos (omega t)
$

In quantum mechanics, we have the @eq-tise[TISE]
$
  -(hbar^2)/(2m) chi''(x) + (1)/(2) m omega^2 x^2 chi(x) = E chi(x).
$
We know that

- bound states imply distinct eigenvalues;

- symmetry $U(x) = U(-x)$ implies that the eigenfunctions are either odd or even.

By a change of variables
$xi = sqrt((m omega)/(hbar)) x$ and $epsilon = (2E)/(hbar omega)$, we get
$
  - dv(chi(xi), xi, 2) + xi^2 chi(xi) = epsilon chi(xi).
$ <eq-harmonic-oscillator-tise>

#lecture-separator(lecture: 8, date: "2026-11-03")

We will start from a particular solution for $epsilon = 1$, so by inspection we have
$
  chi_0 (xi) = ee^(-xi^2/(2)).
$ <eq-harmonic-oscillator-ground-state>

Substituting @eq-harmonic-oscillator-ground-state into @eq-harmonic-oscillator-tise, we find that $chi_0 (xi)$ is indeed a solution with $epsilon = 1$. Hence we have found the ground state of the harmonic oscillator, with energy $E_0 = (1)/(2) hbar omega$. Thus
$
  chi_0 (x) = A ee^(-(m omega)/(2 hbar) x^2).
$

To find other eigenfunctions of $hat(H)$, consider the ansatz
$
  chi(xi) = f(xi) ee^(-xi^2/(2)).
$ <eq-harmonic-oscillator-ansatz>

Substituting @eq-harmonic-oscillator-ansatz into @eq-harmonic-oscillator-tise gives
$
  -f'' + 2 xi f' + (1 - epsilon) f = 0.
$ <eq-harmonic-oscillator-f>
Using power series method with $xi = 0$ as the regular point, we have
$
    f(xi) & = sum_(n=0)^oo a_n xi^n \
   f'(xi) & = sum_(n=1)^oo n a_n xi^(n-1) \
  f''(xi) & = sum_(n=2)^oo n (n-1) a_n xi^(n-2) = sum_(n=0)^oo (n+2)(n+1) a_(n+2) xi^n.
$
Hence, substituting back to @eq-harmonic-oscillator-f, we have
$
  sum_(n=0)^oo [(n+1)(n+2) a_(n+2) - 2n a_n + (epsilon-1)a_n] xi^n = 0.
$
Thus
$
  a_(n+2) = (2n + 1 - epsilon)/((n+1)(n+2)) a_n.
$ <eq-harmonic-oscillator-recurrence>
By the parity of eigenfunctions, we have $chi(-x) = plus.minus chi(x)$. Hence either

- $a_n = 0$ for all odd $n$, giving $f(xi) = f(-xi)$ and hence even eigenfunctions; or

- $a_n = 0$ for all even $n$, giving $f(xi) = -f(-xi)$ and hence odd eigenfunctions.


#proposition[
  If series $f(xi) = sum_(n=0)^oo a_n xi^n$ does not terminate, then eigenfunctions of $hat(H)$ are not normalisable.
]

#proof[
  Suppose the series does not terminate. Then as $n->oo$ we have $(a_(n+2))/(a_n) -> (2)/(n)$. This is identical to the asymptotic behaviour of $g(xi) = ee^(xi^2)$. Indeed,
  $
    g(xi) = sum_(n=0)^oo xi^(2n)/(n!) = sum_(m=0)^oo b_m xi^m
  $
  where $m = 2n$ and $b_m = cases(
    1/(((m)/(2))!) quad & m "even",
    0 quad & m "odd"
  )$. Thus as $m->oo$,
  $
    (b_(m+2))/(b_m) = ((m)/(2))!/((m)/(2)+1)! = (2)/(m+2) -> (2)/(m).
  $
  So $f(xi)$ and $ee^(xi^2)$ have the same asymptotic behaviour. Hence
  $
    chi(xi) stretch(~)_(xi ->oo) ee^(xi^2) ee^(-xi^2/(2)) = ee^(xi^2/(2)) -> oo.
  $
  Hence $chi$ would not be normalisable.
]
However, we require that $chi(xi)$ is normalisable, so the series must terminate. Hence there exists $N in ZZ_(>=0)$ such that $a_(N+2) = 0$ where $a_N != 0$.

Substituting into @eq-harmonic-oscillator-recurrence gives
$
  a_(N+2) = (2N + 1 - epsilon)/((N+1)(N+2)) a_N = 0
$
Hence $epsilon = 2N + 1$. Therefore by $epsilon = (2E)/(hbar omega)$, we get
$
  E_N = (N + (1)/(2)) hbar omega.
$
The eigenvalues are defined by
$
            E_0 & = (hbar omega)/(2), \
  E_(N+1) - E_N & = hbar omega.
$
Therefore
$
   chi_N (xi) & = f_N (xi) ee^(-xi^2/(2)) \
  chi_N (-xi) & = (-1)^N chi_N (xi).
$

The polynomials defined by @eq-harmonic-oscillator-recurrence are called Hermite polynomials, #fade[[with general form $f_N (xi) prop (-1)^N ee^(xi^2) dv(, xi, N) ee^(-xi^2)$]] with the first few given by

#align(center, table(
  columns: 3,
  table.header([$N$], [$E_N$], [$f_N (xi)$]),
  $0$, $(1)/(2) hbar omega$, $1$,
  $1$, $(3)/(2) hbar omega$, $xi$,
  $2$, $(5)/(2) hbar omega$, $1 - 2 xi^2$,
  $3$, $(7)/(2) hbar omega$, $xi - (2)/(3) xi^3$,
))

== Free Particle

With $U(x) equiv 0$, we have
$
              -hbar^2/(2m) chi''(x) & = E chi(x) \
  chi''(x) + (2m E)/(hbar^2) chi(x) & = 0 \
              chi''(x) + k^2 chi(x) & = 0 #eq-note[with $k^2 = (2m E)/(hbar^2)$] \
                             chi(x) & = C ee^(ii k x) + D ee^(-ii k x) \
$
with $D = 0$ if we assume there is no particle from the right. Hence we get, for some $k in RR$,
$
  cases(
    E_k = (hbar^2 k^2)/(2m),
    chi_k (x) = C ee^(ii k x).
  )
$
Substituting this to @eq-tdse[TDSE] gives
$
  psi_k (x, t) = chi_k (x) exp(-ii E_k t/(hbar)) = C exp(ii ( k x - (hbar k^2)/(2m) t)).
$ <eq-free-particle-solution>

This coincides with de Broglie waves. However, such solutions are not square-integrable, as
$
  integral_(-oo)^(oo) abs(psi_k (x, t))^2 dif x = oo
$
unless $C = 0$.

We can resolve this in one of the following ways:

+ treat the plane wave solution $psi_k$ as a limiting case of a Gaussian wavepacket describing a localised particle, and build a linear superposition of $chi_k$ that is normalisable (as in @sec-gauss-wavepacket);

+ ignore this problem and change our interpretation of this result (as in @sec-beam-interpretation).

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e6.svg", width: 36em)
]

=== Gaussian Wavepacket <sec-gauss-wavepacket>

We can construct new solutions of the TDSE by taking a linear superposition of $psi_k (x, t)$. Given that $k$ is a continuous variable, we can take an integral over $k$,

$
  psi(x, t) = integral_(-oo)^(oo) A(k) psi_k (x, t) dif k
$
where $A(k) in RR$ is the continuous coefficients of linear combination. A possible option is the Gaussian wavepacket, with
$
  A(k) = A_"GP" (k) = exp[-(sigma)/(2) (k-k_0)^2]
$
where $sigma in RR^+$ and $k_0 in RR$.

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e5.svg", width: 22em)
]
Then we have
$
  psi_"GP" (x, t) & = integral_(-oo)^(oo) A_"GP" (k) psi_k (x, t) dif k \
                  & = integral_(-oo)^(oo) exp(F(k)) dif k \
$
and
$
  F(k) & = -(sigma)/(2) (k-k_0)^2 + ii k x - ii (hbar k^2)/(2m) t \
  & = -(1)/(2) underbracket((sigma + (ii hbar t)/(m)), alpha) k^2 + underbracket((k_0 sigma + ii x), beta) k underbracket(- (sigma)/(2) k_0^2, delta) \
  &= -(alpha)/(2) (k-(beta)/(alpha))^2 + (beta^2)/(2alpha) + delta. #eq-note[completing the square] \
$
Thus,
$
  psi_"GP" (x, t) = exp((beta^2)/(2 alpha) + delta) integral_(-oo)^(oo) exp(-(alpha)/(2) (k-(beta)/(alpha))^2) dif k.
$
We want to turn this into the form of the standard Gaussian integral $integral_(-oo)^(oo) exp(-a y^2) dif y = sqrt(ppi/a)$. Since
$
  (beta)/(alpha) = re((beta)/(alpha)) + ii im((beta)/(alpha))
$
we have
$
  tilde(k) = k - (beta)/(alpha) = k - re((beta)/(alpha)) - ii underbracket(im((beta)/(alpha)), nu).
$

Then
$
  psi_"GP" (x, t) &= exp((beta^2)/(2 alpha) + delta) integral_(-oo - ii nu)^(oo - ii nu) exp(-(alpha)/(2) tilde(k)^2) dif tilde(k)\
  &= sqrt((2ppi)/(alpha)) exp((beta^2)/(2 alpha) + delta).
$

#lecture-separator(lecture: 9, date: "2026-11-05")

This wavefunction decays exponentially at $x -> plus.minus oo$, and is hence normalisable. The probability density is
$
  rho_"GP" (x, t) = abs(overline(psi)_"GP" (x, t))^2 = overline(psi)^*_"GP" (x, t) psi_"GP" (x, t)
$
where $overline(psi)_"GP" (x, t)$ is the normalised wavefunction. We obtain
$
  rho_"GP" (x, t) = abs(C)^2/sqrt(sigma^2 + (hbar^2 t^2)/(m^2)) exp(-(sigma (x-(hbar k_0)/(m)t)^2)/(sigma^2 + (hbar^2 t^2)/(m^2))).
$
It can be proven that $C$ is fixed by the normalisation condition $integral_(-oo)^(oo) rho_"GP" (x, t) dif x = 1$. For some $phi in RR$,
$
  C = (sigma/(4 ppi^3))^(1/4) ee^(ii phi).
$

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e7.svg", width: 30em)
]

$rho_"GP" (x, t)$ is a Gaussian probability distribution for the position of the particle. We have
$
  expt(x) = (hbar k_0)/(m) t
$ <eq-result-expt-x-gp>
and moves at constant speed
$
  v = (hbar k_0)/(m) = expt(p)/(m).
$
The width of the distribution $Delta x$ corresponds to the uncertainty in the measurement of position, where
$
  Delta x = sqrt(expt(x^2) - expt(x)^2) = sqrt((1)/(2)(sigma + (hbar^2 t^2)/(m^2 sigma))).
$
$Delta x$ increases with time, so Gaussian wavepacket is not a stationary state.

Note that the average value of the position $x$ is exactly the expectation value of the operator $hat(x)$ computed on the normalised Gaussian wavepacket state
$
  expt(x) = expt(hat(x))_(overline(Psi)_"GP") = integral_(-oo)^(oo) overline(Psi)^*_"GP" (x, t) x overline(Psi)_"GP" (x, t) dif x = integral_(-oo)^(oo) abs(overline(Psi)_"GP" (x, t))^2 x dif x
$
which is exactly the same as @eq-result-expt-x-gp. Moreover,
$
  expt(p) = expt(hat(p))_(overline(Psi)_"GP") = integral_(-oo)^(oo) overline(Psi)^*_"GP" (x, t) (-ii hbar dv(overline(Psi)_"GP" (x, t), x)) dif x = hbar k_0.
$
Analogously, $Delta x$ and $Delta p$ can be defined in terms of $hat(x)$ and $hat(p)$ by
$
  Delta x & = sqrt(expt(hat(x)^2)_(overline(Psi)_"GP") - expt(hat(x))_(overline(Psi)_"GP")^2) \
  Delta p & = sqrt(expt(hat(p)^2)_(overline(Psi)_"GP") - expt(hat(p))_(overline(Psi)_"GP")^2).
$
Computing explicitly, we get
$
  Delta x & = sqrt((1)/(2)(sigma + (hbar^2 t^2)/(m^2 sigma))) \
  Delta p & = sqrt((hbar^2)/(2sigma))
$
So, for a Gaussian wavepacket at $t=0$,
$
  Delta x Delta p = (hbar)/(2)
$
with $Delta x Delta p > (hbar)/(2)$ for $t > 0$. This tells us that for a particle modelled by a Gaussian wavepacket, we cannot measure its position and momentum simultaneously with arbitrary precision.

=== Beam Interpretation <sec-beam-interpretation>

Another way to use the non-normalisable solutions $psi_k (x, t)$ is to interpret them as a continuous beam of particles, whose probability density is now interpreted as the average density of particles. We can describe @eq-free-particle-solution as a beam of particles with momentum
$
  p = hbar k
$
and energy
$
  E = hbar omega = (hbar^2 k^2)/(2m) = p^2/(2m).
$
The probability density
$
  rho(x, t) = abs(psi_k (x, t))^2 = abs(C)^2
$
is now the constant average density of particles. The probability current is given by
$
  J_k (x, t) & = -(ii hbar)/(2m) (psi_k^* dv(psi_k, x) - psi_k dv(psi_k^*, x)) \
             & = - (ii hbar k)/(2m) dot abs(C)^2 dot 2 ii k \
             & = abs(C^2) (hbar k)/(m) \
             & = abs(C^2) (p)/(m) \
             & = "average density" times "velocity" \
             & = "average flux of particles". \
$ <eq-probability-current-beam-interpretation>

== Scattering States

Consider a particle scattering on a potential barrier
$
  U(x) = cases(
    0 quad & x < 0,
    U_0 quad & 0 <= x <= a,
    0 quad & x > a.
  )
$

An incoming particle of mass $m$ and total energy $E$ hits the potential barrier from left.

In classical mechanics, if $E > U_0$ the particle gets over the barrier and goes to $x = +oo$, and if $E < U_0$ the particle is reflected back to $x = -oo$.

However, in quantum mechanics, consider a localised Gaussian wavepacket with normalised wavefunction $psi_"GP" (x, t)$
$
  integral_(-oo)^(oo) abs(psi_"GP" (x, t))^2 dif x = 1,
$
the wavepacket is centred at $x = x_0(t) << 0$ at $t = 0$ with average momentum $expt(p) > 0$. If we evolve the wavefunctions according to TDSE, we get a superposition of reflected and transmitted wavefunctions, independent of whether $E > U_0$ or $E < U_0$.

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e9.svg", width: 30em)
]

Define the reflection and transmission coefficients $R$ and $T$ by
$
  R & = lim_(t->oo) integral_(-oo)^(0) abs(psi_"GP" (x, t))^2 dif x \
  T & = lim_(t->oo) integral_(0)^(oo) abs(psi_"GP" (x, t))^2 dif x \
$
which measure the probabilities of the particle being reflected and transmitted, respectively. Since the wavefunction is normalised, we have
$
  R + T = integral_(-oo)^(oo) abs(psi_"GP" (x, t))^2 dif x = 1.
$

In practice this is mathematically difficult to work with, so we will work with non-normalisable plane wave solutions described in @sec-beam-interpretation with the beam interpretation. Take
$
  psi_k (x, t) = chi_k (x) exp(-ii (hbar k^2 t)/(2m))
$

with $chi_k (x) = C exp(ii k x)$ interpreted as a beam of particles with momentum $p = hbar k$. The average density of particles is $abs(C)^2$. The incident particle flux (probability current) is given by @eq-probability-current-beam-interpretation. We will now explicitly solve the TISE for the scattering of particles off a potential step and a potential barrier using the beam interpretation.

=== Scattering on a Potential Step

Consider a potential step
$
  U(x) = cases(
    0 quad & x < 0,
    U_0 quad & x >= 0.
  )
$

The eigenfunctions $chi_k (x)$ obey TISE
$
  -(hbar^2)/(2m) chi''_k(x) + U(x) chi_k (x) = E chi_k (x).
$

#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e10.svg", width: 22em)
]

We will consider the case of $E > U_0$ first. In the region $x <= 0$, we have
$
  chi''_k (x) + k^2 chi_k (x) = 0
$
with $k = sqrt((2 m E)/(hbar^2)) >=0$. For $E > 0$, the general solution is
$
  chi_k (x) = A exp(ii k x) + B exp(-ii k x).
$
Define $chi^((+))_k (x) = A exp(ii k x)$, which corresponds to a beam of particles moving to the right with $p = hbar k$. We have the corresponding particle flux
$
  J_k^((+)) = abs(A)^2 (hbar k)/(m).
$
and $chi^((-))_k = B exp(-ii k x)$, which corresponds to a beam of particles moving to the left with $p = -hbar k$. We have the corresponding particle flux
$
  J_k^((-)) = abs(B)^2 (hbar k)/(m).
$
In our scattering problem we have incident particles from the left and also expect some particles to be reflected off the barrier. Thus we retain the general solution
$
  chi_k (x) = A exp(ii k x) + B exp(-ii k x) quad "for" x < 0.
$


In the region $x >= 0$, we have
$
  chi''(x) + (2m)/(hbar^2) (E - U_0) chi(x) = 0
$
with $overline(k) = sqrt((2m)/(hbar^2) (E - U_0))$, we have $overline(k)$ real if $E >= U_0$ and $overline(k)$ imaginary if $E < U_0$.

For $E >= U_0$, the general solution is
$
  chi_(overline(k)) (x) = C exp(ii overline(k) x) + D exp(-ii overline(k) x).
$
We can set $D = 0$ since there is no incident beam from $+oo$ due to initial conditions. Hence
$
  chi_(k, overline(k))(x) = cases(
    A exp(ii k x) + B exp(-ii k x) quad & x < 0,
    C exp(ii overline(k) x) quad & x >= 0.
  )
$


Imposing continuity of $chi$ and $chi'$ at $x = 0$ gives
$
  cases(
    A + B = C,
    ii k A - ii k B = ii overline(k) C.
  )
$
Thus we get
$
  cases(
    B = (k - overline(k))/(k + overline(k)) A,
    C = (2 k)/(k + overline(k)) A.
  )
$
Hence we have probability currents
$
  J(x, t) = - (i hbar)/(2m) (chi^* dv(chi, x) - chi dv(chi^*, x)) & = cases(
                                                                      J_k^((+)) + J_k^((-)) quad & x < 0,
                                                                      J_(overline(k))^((+)) quad & x >= 0
                                                                    ) \
                                                                  & = cases(
                                                                      (hbar k)/(m) (abs(A)^2 - abs(B)^2) quad & x < 0,
                                                                      ( hbar overline(k))/(m) abs(C)^2 quad & x >= 0.
                                                                    ) \
$

#lecture-separator(lecture: 10, date: "2026-11-10")

So we have
$
  J_"incident" = (hbar k)/(m) abs(A)^2, quad J_"reflected" = (hbar k)/(m) abs(B)^2, quad J_"transmitted" = (hbar overline(k))/(m) abs(C)^2.
$
Hence the reflection and transmission coefficients are
$
  R = (J_"reflected")/(J_"incident") = abs(B)^2/abs(A)^2 = ((k - overline(k))/(k + overline(k)))^2, quad T = (J_"transmitted")/(J_"incident") = (overline(k)/k) abs(C)^2/abs(A)^2 = (4 k overline(k))/(k + overline(k))^2.
$

Observe that
- $R + T = 1$, so the number of particles is conserved;

- As $E -> U_0$, we have $overline(k) -> 0$, so $R -> 1$ and $T -> 0$.

- As $E -> oo$, we have $overline(k) -> k$, so $R -> 0$ and $T -> 1$.

Now consider the case of $E < U_0$ for $x > 0$. With
$
  eta = sqrt((2 m (U_0 - E))/(hbar^2)) = ii overline(k),
$
we get
$
  chi_(k, overline(k)) (x) = cases(
    A exp(ii k x) + B exp(-ii k x) quad & x < 0,
    C exp(-eta x) + D exp(eta x) quad & x >= 0.
  )
$
and $D = 0$ since we require normalisability. Imposing continuity of $chi$ and $chi'$ at $x = 0$ gives
$
  J_"incident" = (hbar k)/(m) abs(A)^2, quad J_"reflected" = (hbar k)/(m) abs(B)^2, quad J_"transmitted" = 0.
$
Hence $R = 1$ and $T = 0$, but $chi_(overline(k)) (x) != 0$ for $x > 0$. This is called a evanescent wave.

=== Scattering on a Potential Barrier

Consider
$
  U(x) = cases(
    0 quad & x <= 0,
    U_0 quad & 0 < x < a,
    0 quad & x >= a.
  )
$
#align(center)[
  #dynamic-svg2("/part-ib/quantum-mechanics/media/d1e11.svg", width: 22em)
]

Consider the case of $E < U_0$. Writing the TISE we find
$
  k = sqrt((2 m E)/(hbar^2)), quad eta = sqrt((2 m (U_0 - E))/(hbar^2))
$
where $k$ applies to the regions $x <= 0$ and $x >= a$, and $eta$ applies to the region $0 < x < a$. The general solution is
$
  chi_(k, eta)(x) = cases(
    A exp(ii k x) + B exp(-ii k x) quad & x <= 0,
    C exp(-eta x) + D exp(eta x) quad & 0 < x < a,
    F exp(ii k x) + G exp(-ii k x) quad & x >= a.
  )
$
We can normalise the solution by setting $A = 1$ #fade[[we will always divide by $A$ to get the reflection and transmission coefficients]]. Moreover, since the incident beam is from the left, we have $G = 0$. So
$
  chi_(k, eta)(x) = cases(
    exp(ii k x) + A exp(-ii k x) quad & x <= 0,
    B exp(-eta x) + C exp(eta x) quad & 0 < x < a,
    D exp(ii k x) quad & x >= a.
  )
$

We can solve for $A, B, C, D$ by using the 4 continuity conditions at $x = 0$ and $x = a$ for $chi$ and $chi'$ respectively. This gives

$
  cases(
    1 + A = B + C quad & "continuity of" chi "at" x = 0,
    -ii k + ii k A = -eta B + eta C quad & "continuity of" chi' "at" x = 0,
    B ee^(-eta a) + C ee^(eta a) = D ee^(ii k a) quad & "continuity of" chi "at" x = a,
    -eta B ee^(-eta a) + eta C ee^(eta a) = ii k D ee^(ii k a) quad & "continuity of" chi' "at" x = a
  )
$
Solving this system of equations gives
$
  D = -(4 ii eta k)/((eta - ii k)^2 exp((eta + ii k) a) - (eta + ii k)^2 exp(-(eta - ii k) a)).
$
Therefore, we can find the transmission coefficient
$
  T = abs(D)^2/(1)= (4k^2 eta^2)/((eta^2 + k^2)^2 sinh^2(eta a) + 4 k^2 eta^2).
$
Note that this is non-zero, so there is a non-zero probability of the particle tunnelling through the potential barrier. This is called the quantum tunnelling effect. In classical mechanics, the particle would be reflected back to $x = -oo$ with probability 1.

If $E << U_0$ such that $eta a >>1$, we  have
$
  T -> (16 k^2 eta^2)/((eta^2 + k^2)^2) exp(-2 eta a).
$

== Summary

For unbound states, the solutions of @eq-tdse[TDSE] are not normalisable
$
  psi_k (x, t) = exp(ii (plus.minus k x - (hbar k^2)/(2m) t)) in.not hilb.
$
So we have to either

+ build a linear superposition of $psi_k$ that is normalisable (as in @sec-gauss-wavepacket)
  $
    chi_"GP" (x, t) = integral_(-oo)^(oo) A(k) psi_k (x, t) dif k,
  $
  so that we have
  $
    R & = integral_(-oo)^(0) abs(chi_"GP" (x, t))^2 dif x \
    T & = integral_(0)^(oo) abs(chi_"GP" (x, t))^2 dif x.
  $

+ interpret $psi_k$ as beams of particles, with probability current
  $
    J (x, t) = - (i hbar)/(2m) (psi_k^* dv(psi_k, x) - psi_k dv(psi_k^*, x)) = "average flux of particles",
  $
  so that we have
  $
    R = (J_"reflected")/(J_"incident"), quad T = (J_"transmitted")/(J_"incident").
  $





