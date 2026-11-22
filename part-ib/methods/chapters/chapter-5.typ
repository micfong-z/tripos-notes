#import "../prelude.typ": *
#show: chapter.with(5)

= The Fourier Transform

== Definitions and Simple Properties

We have previously seen the Fourier series for periodic functions of period $L$. The Fourier transform is in some sense the $L->oo$ limit of the theory of Fourier series.

#definition[Fourier Transform][
  For an integrable function $F: RR->CC$, denote its *Fourier transform* by
  $
    hat(f)(lambda) = integral_(-oo)^(oo) ee^(-ii lambda x) f(x) dif x
  $
  for $lambda in RR$.
]

#notation[
  We denote the map that maps $f$ to its Fourier transform $hat(f)$ by $ftrans: f |-> hat(f)$ and write $ftrans(x, lambda) (f(x)) = hat(f)(lambda)$.
]

We will assume that we will work with nice functions so that all relevant integrals converge. Just like with Fourier series, we expect the Fourier transform of an integrable function to decay for large $abs(lambda)$ #fade[[_i.e._ the Riemann-Lebesgue lemma still holds]].

#proposition[
  The following properties hold:

  + conversion between differentiation and multiplication:
    $
      ftrans(x, lambda) [dv(, x, k) f(x)] & = (ii lambda)^k hat(f)(lambda), \
             ftrans(x, lambda) [x^k f(x)] & = ii^k dv(, lambda, k) hat(f)(lambda),
    $

  + conversion between shifts and phase changes:

    $
      ftrans(x, lambda) [f(x-a)] = ee^(-ii lambda a) hat(f)(lambda), \
      ftrans(x, lambda) [ee^(-ii a x) f(x)] = hat(f)(lambda + a),
    $

]

#proof[

  + From the definition and integrating by parts, assuming that all boundary terms vanish, we have
    $
      integral_(-oo)^(oo) f^((k))(x) ee^(-ii lambda x) dif x &= integral_(-oo)^(oo) f(x) (-1)^k dv(, x, k) ee^(-ii lambda x) dif x\
      & = (ii lambda)^k integral_(-oo)^(oo) f(x) ee^(-ii lambda x) dif x\
      & = (ii lambda)^k hat(f)(lambda).
    $

    For the other identity, we have
    $
      ii^k dv(, lambda, k) hat(f)(lambda) &= integral_(-oo)^(oo) x^k f(x) ee^(-ii lambda x) dif x = ftrans(x, lambda) [x^k f(x)].
    $

  + Left as an exercise.
]

The first property is particularly useful. Suppose we have a constant coefficient differential equation on the real line
$
  P(dv(, x)) y = F, quad x in RR,
$
where $P$ is a polynomial #fade[[_e.g._ if $P(z) = z^2 + 1$ then $P(dv(, x)) y = y'' + y$]]. Taking the Fourier transform of both sides, we have
$
  P(ii lambda) hat(y)(lambda) = hat(F)(lambda), quad lambda in RR.
$
So we can solve for $hat(y)$ to get
$
  hat(y) (lambda) = (hat(F)(lambda))/(P(ii lambda)),
$
and hence the Fourier transform $hat(y) = hat(y)(lambda)$ of the solution to the differential equation is immediate. But we wish to recover $y$ from $hat(y)$, which requires the inverse Fourier transform.

#proposition[
  If $f = f(x)$ has Fourier transform $hat(f) = hat(f)(lambda)$, then we have the inversion formula
  $
    f(x) = (1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda x) hat(f)(lambda) dif lambda.
  $
  This means that we can reconstruct $f$ from $hat(f)$.
] <prop-inversion-formula>

#proof[
  Using the definition of $hat(f)(lambda)$ and interchanging the order of integration gives
  $
    (1)/(2ppi) integral_(-n)^(n) ee^(ii lambda x) hat(f)(lambda) dif lambda &= integral_(-oo)^(oo) [(1)/(2ppi) integral_(-n)^(n) ee^(ii lambda (x - y)) dif lambda] f(y) dif y. \
  $
  Notice that
  $
    (1)/(2ppi) integral_(-n)^(n) ee^(ii lambda(x-y)) dif lambda = sin(n(x-y))/(ppi (x-y)),
  $
  we get
  $
    (1)/(2ppi) integral_(-n)^(n) ee^(ii lambda x) hat(f)(lambda) dif lambda = integral_(-oo)^(oo) sin[n(x-y)]/(ppi (x-y)) f(y) dif y = integral_(-oo)^(oo) sin(n y)/(ppi y) f(x +y) dif y.
  $
  It can be shown that $integral_(-oo)^(oo) sin(n y)/(ppi y) dif y = 1$. Hence
  $
    (1)/(2ppi) integral_(-n)^(n) ee^(-ii lambda x) hat(f)(lambda) dif lambda - f(x) = integral_(-oo)^(oo) sin(n y) underbracket((f(x+y) - f(x))/(ppi y), F(y, x)) dif y.
  $
  Integrating by parts gives, as $n -> oo$
  $
    (1)/(2ppi) integral_(-n)^(n) ee^(ii lambda x) hat(f)(lambda) dif lambda - f(x) = (1)/(n) integral_(-oo)^(oo) cos (n y) F_y (y, x) dif y -> 0
  $
  which gives the desired result.
]

If we remove the limiting process, this argument has given us the formal result
$
  f(x) = integral_(-oo)^(oo) (1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda (x-y)) dif lambda
$
and so
$
  delta(x) = (1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda x) dif lambda.
$



#proposition[Parseval's Theorem for Fourier Transforms][
  We have Parseval's theorem (_c.f._ @thm-parseval)
  $
    integral_(-oo)^(oo) f(x) overline(g(x)) dif x &= (1)/(2ppi) integral_(-oo)^(oo) hat(f)(lambda) overline(hat(g)(lambda)) dif lambda, \
    integral_(-oo)^(oo) abs(f(x))^2 dif x &= (1)/(2ppi) integral_(-oo)^(oo) abs(hat(f)(lambda))^2 dif lambda.
  $
] <prop-parseval-fourier-transform>

#proof[
  Using the definition of the Fourier transform we get the RHS as
  $
    (1)/(2ppi) integral_(-oo)^(oo) [integral_(-oo)^(oo) ee^(-ii lambda x) f(x) dif x][integral_(-oo)^(oo) ee^(ii lambda y) overline(g(y)) dif y] dif lambda = integral_(-oo)^(oo) integral_(-oo)^(oo) f(x) overline(g(y)) [(1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda (x-y)) dif lambda] dif x dif y.
  $
  We noticed that the term in square brackets is $delta(x-y)$, and so we get the desired result.
]

#definition[Convolution][
  For integrable functions $f, g: RR->CC$, we define the *convolution* of $f$ and $g$ to be
  $
    (f * g) (x) = integral_(-oo)^(oo) f(y) g(x-y) dif y.
  $
]

#proposition[
  $
    ftrans(x, lambda) [(f * g)(x)] = hat(f)(lambda) hat(g)(lambda).
  $
]

#proof[
  By interchanging the order of integration and substituting $x |-> x + y$ gives
  $
    integral_(-oo)^(oo) (f*g)(x) ee^(-ii lambda x) dif x &= integral_(-oo)^(oo) integral_(-oo)^(oo) f(y) g(x-y) ee^(-ii lambda x) dif y dif x\
    &= integral_(-oo)^(oo) integral_(-oo)^(oo) f(x) g(y) ee^(-ii lambda (x+y)) dif x dif y\
    &= integral_(-oo)^(oo) f(x) ee^(-ii lambda x) dif x integral_(-oo)^(oo) g(y) ee^(-ii lambda y) dif y\
    & = hat(f)(lambda) hat(g)(lambda).
  $

]

#lecture-separator(lecture: 16, date: "2026-11-13")

== Important Examples

=== Exponentials

Fix $sigma in CC$, with $re sigma > 0$. Define
$
  f(x) & = H(x) ee^(-sigma x) \
$
where $H$ is the Heaviside step function. Then we have
$
  hat(f) (lambda) & = integral_(-oo)^(oo) ee^(-ii lambda x) f(x) dif x \
                  & = integral_(0)^(oo) ee^(- (ii lambda + sigma) x) dif x \
                  & = (1)/(ii lambda + sigma). \
$

Observe that $abs(hat(f)) -> 0$ as $abs(lambda) -> oo$, as expected from the Riemann-Lebesgue lemma. By inversion,
$
  H(x) ee^(-sigma x) & = (1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda x)/(ii lambda + sigma) dif lambda \
                     & = (1)/(2ppi ii) integral_(-oo)^(oo) ee^(ii lambda x)/(lambda - ii sigma) dif lambda. \
$

By IB Complex Analysis or IB Complex Methods, the RHS can be computed by contour integration. Note, by applying $(-pdv(, sigma))^k$ to both sides, we get
$
  H(x) x^k ee^(-sigma x) & = (k!)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda x)/(ii lambda + sigma)^(k+1) dif lambda \
$

#fade[[The LHS is now a nicer function than before at $x=0$, and indeed the Fourier transform decays faster.]]

=== Gaussians

Let
$
  f(x) = (1)/(sqrt(2ppi)) ee^(-(x^2)/(2)),
$
_i.e._ standard $"N"(0, 1)$ PDF. Then we have
$
  hat(f)(lambda) & = integral_(-oo)^(oo) (1)/(sqrt(2ppi)) ee^(-ii lambda x - (x^2)/(2)) dif x , \
$
which is hard to do without IB Complex Analysis. However, note that
$
  dv(f, x) = -x f.
$
Take Fourier transforms of both sides, we get
$
   (ii lambda) hat(f) & = - ii dv(, lambda) hat(f) \
  dv(, lambda) hat(f) & = - lambda hat(f).
$
Note that $hat(f)$ and $f$ obey the same differential equation, and so we can conclude that
$
  hat(f) (lambda) = hat(f)(0) ee^(-(lambda^2)/(2)).
$
But
$
  hat(f)(0) = integral_(-oo)^(oo) f(x) dif x.
$
Since $f$ is a PDF, we have $hat(f)(0) = 1$, and so
$
  hat(f)(lambda) = ee^(-(lambda^2)/(2)) = (1)/(sqrt(2ppi)) integral_(-oo)^(oo) ee^(-ii lambda x - (x^2)/(2)) dif x.
$
So, $f(x) = (1)/(sqrt(2ppi)) ee^((x^2)/(2))$ is an eigenfunction of $ftrans$, _i.e._
$
  ftrans[f] prop f.
$
#fade[[_c.f._ simple harmonic oscillator in IB Quantum Mechanics.]]

=== Dirac Delta

We can take Fourier transforms of delta function
$
  hat(f)(lambda) & = integral_(-oo)^(oo) delta(x) ee^(-ii lambda x) dif x \
                 & = ee^(-ii lambda 0) \
                 & = 1.
$

#fade[[This seems to violate the Riemann-Lebesgue lemma, but note that essentially we are taking a limit of a sequence of functions, instead of dealing with a actual function $delta(x)$.]] So by inversion,
$
  delta(x) = (1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda x) dif lambda.
$
This is the formula we saw after the proof of @prop-inversion-formula.

== Revisiting Initial Value Problems

Consider IVP
$
  cases(
    L y = f(t) & quad t>0,
    y(0) = dot(y)(0) = 0
  )
$
where
$
  L = alpha dv(, t, 2) + beta dv(, t) + gamma
$
and $alpha != 0$ for constants $alpha, beta, gamma$. WLOG take $alpha = 1$.

We wish to use Fourier transform, so we need to extend functions $y, f$ to the whole real line, so that
$
  f(t) = y(t) = 0 quad "for" t < 0.
$
Write
$
  hat(y) (omega) = ftrans(t, omega) [y(t)].
$
Take Fourier transforms of both sides of the differential equation, we get
$
  [(ii omega)^2 + beta(ii omega) + gamma] hat(y)(omega) = hat(f) (omega).
$
So
$
  hat(y)( omega) = (hat(f) (omega))/(P(omega)),
$
where $P(omega) = (i omega)^2 + beta(i omega) + gamma$. Assume that $beta, gamma$ are such that
$
  P(omega) = (ii omega + sigma_1) (ii omega + sigma_2)
$
where $sigma_1 != sigma_2$ and $re [sigma_i] > 0$ for $i in {1, 2}$. Then
$
  (1)/(P(omega)) &= (1)/(sigma_2 - sigma_1) [(1)/(ii omega + sigma_1) - (1)/(ii omega + sigma_2)]\
  &= (1)/(sigma_2-sigma_1) [ftrans(t, omega) (H(t) ee^(-sigma_1 t)) - ftrans(t, omega) (H(t) ee^(-sigma_2 t))] \
  &= ftrans(t, omega) [H(t) (ee^(-sigma_1 t) - ee^(-sigma_2 t))/(sigma_2 - sigma_1)]. \
$
So
$
  hat(y)(omega) = hat(R) (omega) hat(f)(omega)
$
where $R(t)$ is the *response function* associated with the differential operator $L$, and is given by
$
  R(t) = H(t) [(ee^(-sigma_1 t) - ee^(-sigma_2 t))/(sigma_2 - sigma_1)].
$
If $sigma_1 = sigma_2 = sigma$, then let $sigma_1 = sigma$, $sigma_2 = sigma + epsilon$ and take limits as $epsilon -> 0$ to get
$
  R(t) = H(t) t ee^(-sigma t).
$
By the convolution theorem, we have
$
                 ftrans [f*g] & = hat(f) hat(g) \
  ftrans^(-1) [hat(f) hat(g)] & = f * g.
$
Hence applying to $hat(y) = hat(R) hat(f)$, we get
$
  y(t)) & = R * f (t) \
  & = integral_(-oo)^(oo) underbracket(R (t-tau), =0\ "for" tau > t) underbracket(f(tau), =0\ "for" tau < 0) dif tau \
  &= integral_(0)^(t) R (t-tau) f(tau) dif tau. \
$
We find that $R(t-tau) = G(t, tau)$, the Green's function for IVP associated with $L$. So
$
  L_t [R(t)] = delta(t),
$
_i.e._ response to an impulse at $t=0$.
#example[
  Consider damped harmonic oscillator under load $f$, initially at rest and satisfies for some $gamma > 0$,
  $
    cases(
      dot.double(y) + 2 gamma dot(y) + y = f(t) quad & t >0,
      y(0) = dot(y)(0) = 0.
    )
  $
  As before, we get
  $
    hat(y)(omega) = (hat(f)(omega))/(P(omega))
  $
  where
  $
    P(omega) = (ii omega + gamma + sqrt(gamma^2 - 1)) (ii omega + gamma - sqrt(gamma^2 - 1)).
  $
  Note that
  $
    Re [sigma_(plus.minus) (gamma)] = Re[ gamma plus.minus sqrt(gamma^2 - 1)] > 0.
  $
  So we get $(1)/(P(omega)) = hat(R) (omega)$, where
  $
    R(t) = H(t) [(ee^(- sigma_- t) - ee^(- sigma_+ t))/(sigma_+ - sigma_-)].
  $
  Different cases that arise are as follows.

  *$gamma > 1$*. We have
  $
    R(t) = H(t) ee^(-gamma t) (sinh [t sqrt(gamma^2 - 1)])/(sqrt(gamma^2-1)).
  $
  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p17.svg", width: 24em)
  ]

  *$0 < gamma < 1$*. We have
  $
    R(t) = H(t) ee^(-gamma t) (sin [t sqrt(1 - gamma^2)])/(sqrt(1-gamma^2)).
  $
  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p18.svg", width: 24em)
  ]

  *$gamma = 1$*. Set $1-gamma^2 = epsilon^2$, taking $epsilon ->0$ gives
  $
    R(t) = H(t) t ee^(-t)
  $
  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p19.svg", width: 24em)
  ]
  However, we seem to have overlooked the initial conditions required to do the Fourier transform. Consider
  $
    integral_(0)^(oo) ee^(-ii omega t) dot.double(y)(t) dif t &= [dot(y) ee^(-ii omega t)]_0^oo + ii omega integral_(0)^(oo) ee^(-ii omega t) dot(y)(t) dif t \
    &= - dot(y)(0) + ii omega integral_(0)^(oo) ee^(-ii omega t) dot(y)(t) dif t\
    &= integral_(0)^(oo) ee^(-ii omega t) dot(y)(t) dif t \
  $
  and doing this again we indeed get the intended result. For details, see IB Complex Methods for the Laplace transform method.
]

#lecture-separator(lecture: 17, date: "2026-11-16")

== Some Neat Applications

=== Poisson Summation Formula

#proposition[
  For nice functions $f$,
  $
    sum_(n in ZZ) f(x+n) = sum_(n in ZZ) hat(f) (2ppi n) ee^(2ppi i n x).
  $
]
#proof[
  Both sides are 1-periodic functions. Set $"LHS" = F(x)$ and $"RHS" = G(x)$.

  Clearly $hat(G)_n = hat(f)(2 ppi n)$. Then
  $
    hat(F)_n & = integral_(0)^(1) ee^(-2 ppi ii n x) F(x) dif x \
             & = sum_(m in ZZ) integral_(0)^(1) ee^(-2 ppi ii n x) f(x+m) dif x \
             & = sum_(m in ZZ) integral_(m)^(m+1) ee^(-2ppi ii n y) f(y) dif y #eq-note[$y = x + m$] \
             & = integral_(-oo)^(oo) ee^(-2ppi ii n y) f(y) dif y \
             & = hat(f) (2ppi n). \
  $
  Therefore, $hat(F)_n = hat(G)_n$ for all $n in ZZ$, and so $F = G$.
]

#remark[
  This is often seen in form
  $
    sum_(n in ZZ) f(n) = sum_(n in ZZ) hat(f)(2ppi n).
  $
]

#example[
  Consider
  $
    f(x) = H(x) x ee^(-sigma x).
  $
  Then
  $
    hat(f)(x) = (1)/(sigma + ii lambda)^2.
  $
  We get
  $
    sum_(n in ZZ) (2ppi ii n + sigma)^(-2) & = sum_(n=1)^oo n ee^(-sigma n) \
                                           & = ee^(sigma)/(1 - ee^sigma)^2 \
                                           & = (4)/(sinh^2 ((sigma)/(2))). \
  $


]

=== Heisenberg Uncertainty Principle

#proposition[
  If $integral_(-oo)^(oo) abs(psi)^2 dif x = 1$, then
  $
    (integral_(-oo)^(oo) x^2 abs(psi)^2 dif x) (integral_(-oo)^(oo) lambda^2 abs(hat(psi))^2 dif lambda) >= (ppi)/(2).
  $
]

#proof[
  By integration by parts, we have
  $
    1 & = integral_(-oo)^(oo) abs(psi)^2 dif x \
      & = -integral_(-oo)^(oo) x dv(, x) (psi overline(psi)) dif x \
      & =- integral_(-oo)^(oo) x [psi overline(psi)' + psi' overline(psi)] dif x \
      & <= 2 integral_(-oo)^(oo) abs(x) abs(psi) abs(psi') dif x. \
  $
  By Cauchy-Schwarz #fade[[of the form $integral f g <= (integral abs(f)^2)^((1)/(2)) (integral abs(g)^2)^((1)/(2))$]], we have
  $
    1 <= 2 (integral_(-oo)^(oo) x^2 abs(psi)^2 dif x)^((1)/(2)) (integral_(-oo)^(oo) abs(psi')^2 dif x)^((1)/(2)).
  $
  Recall that
  $
    integral_(-oo)^(oo) abs(f(x))^2 dif x & = (1)/(2ppi) integral_(-oo)^(oo) abs(hat(f)(lambda))^2 dif lambda. \
  $
  If $f = psi'$, then $hat(f)(lambda) = (ii lambda) hat(psi)(lambda)$. So
  $
    1 <= 2 (integral_(-oo)^(oo) x^2 abs(psi)^2 dif x)^((1)/(2)) ((1)/(2ppi) integral_(-oo)^(oo) lambda^2 abs(hat(psi))^2 dif lambda)^((1)/(2)).
  $
  So we get the desired result.
]

If we replace $psi(x)$ with $ee^(-ii lambda_0 x) psi(x + x_0)$, then $hat(psi)(lambda)$ gets replaced by
$
  ee^(ii lambda x_0) hat(psi)(lambda + lambda_0)
$
and hence
$
  (integral_(-oo)^(oo) x^2 abs(psi(x + x_0))^2 dif x)(integral_(-oo)^(oo) lambda^2 abs(hat(psi)(lambda + lambda_0))^2 dif lambda) >= (ppi)/(2)
$
which is equivalent to
$
  (integral_(-oo)^(oo) (x-x_0)^2 abs(psi(x))^2 dif x)(integral_(-oo)^(oo) (lambda - lambda_0)^2 abs(hat(psi)(lambda))^2 dif lambda) >= (ppi)/(2).
$ <eq-heisenberg-uncertainty-principle-1>
In IB Quantum Mechanics, we have
$
            integral_(a)^(b) abs(psi)^2 dif x & prop PP("particle position in" (a, b)), \
  integral_(A)^(B) abs(hat(psi))^2 dif lambda & prop PP("particle momentum in" (A, B)).
$
Take
$
  x_0 = EE["position"] quad "and" quad lambda_0 = EE["momentum"],
$
then @eq-heisenberg-uncertainty-principle-1 gives
$
  "variance of position" times "variance of momentum" >= (ppi)/(2).
$

=== From Fourier Series to Fourier Transforms

Let $f: RR->CC$, assume $f$ vanishes outside $(-L, L)$. Then for $x in (-L, L)$,
$
  f(x) = sum_n ee^((ii ppi n x)/(L)) hat(f)_n
$
where
$
  hat(f)_n & = (1)/(2L) integral_(-L)^(L) f(x) ee^((-ii ppi n x)/(L)) dif x \
           & = (1)/(2L) integral_(-oo)^(oo) f(x) ee^((-ii ppi n x)/(L)) dif x \
           & = (1)/(2L) hat(f) (lambda_n) \
$
where $lambda_n = (ppi n)/(L)$.

Write $delta lambda = lambda_(n+1) - lambda_n = (ppi)/(L)$. So for $x in (-L, L)$,
$
  f(x) = (1)/(2ppi) sum_n hat(f)(lambda_n) ee^(ii lambda_n x) delta lambda.
$
Take $L -> oo$, which means $delta lambda -> 0$, we have
$
  f(x) = (1)/(2ppi) integral_(-oo)^(oo) ee^(ii lambda x) hat(f)(lambda) dif lambda.
$
This is @prop-inversion-formula[Fourier Inversion Formula].

From Parseval's theorem for Fourier series, we have
$
  integral_(-L)^(L) abs(f(x))^2 dif x & = 2L sum_n abs(hat(f)_n)^2 \
                                      & = 2L sum_n abs(hat(f)(lambda_n))^2/(4 L^2) \
                                      & = (1)/(2ppi) sum_n abs(hat(f)(lambda_n))^2 delta lambda. \
$
Take $L -> oo$, so that $delta lambda -> 0$, we have
$
  integral_(-oo)^(oo) abs(f(x))^2 dif x = (1)/(2ppi) integral_(-oo)^(oo) abs(hat(f)(lambda))^2 dif lambda.
$

This is @prop-parseval-fourier-transform[Parseval's Theorem for Fourier Transforms].

=== Central Limit Theorem

Let $X_1, ..., X_n$ be i.i.d. random variables with mean $mu = 0$ and variance $sigma^2 = 1$. Define
$
  S_n = (X_1 + ... + X_n)/(sqrt(n)).
$
Let $f_n$ be the PDF of $S_n$. Then we have
$
  hat(f)_n (lambda) = integral_(-oo)^(oo) ee^(-ii lambda x) f_n (x) dif x & = EE[ee^(-ii lambda S_n)] \
  & = EE[ee^(-ii lambda (X_1)/(sqrt(n)) - ... - ii lambda (X_n)/(sqrt(n)))] \
  &= EE[ee^(-ii lambda (X_1)/(sqrt(n)))] dots.c EE[ee^(-ii lambda (X_n)/(sqrt(n)))] #eq-note[by independence]\
  &= (EE[ee^(- (ii lambda X_1)/(sqrt(n)))])^n #eq-note[by identical distribution]\
  &= [EE(1- (ii lambda X_1)/(sqrt(n)) - (lambda^2 X_1^2)/(2 n) + o((1)/(n)))]^n \
  &= [EE(1 + 0 - (lambda^2)/(2 n) + o((1)/(n)))]^n \
  &-> ee^(-(lambda^2)/(2)). #eq-note[as $n -> oo$]
$
Recall that
$
  ftrans(x, lambda) [(1)/(sqrt(2ppi)) ee^(-(x^2)/(2))] = ee^(-(lambda^2)/(2)).
$
From inversion theorem,
$
  lim_(n->oo) f_n (x) = (1)/(2 ppi) integral_(-oo)^(oo) ee^(ii lambda x) ee^(-(lambda^2)/(2)) dif lambda = (1)/(sqrt(2ppi)) ee^(-(x^2)/(2)).
$
We conclude that $S_n -> "N"(0, 1)$ in distribution, which is the Central Limit Theorem #fade[[_c.f._ IA Probability]].

#fade-block[
  For $P(dv(, x)) y = f$ we have
  $
    hat(y)(lambda) = (hat(f)(lambda))/(P(ii lambda)).
  $
  Then for $P(pdv(, x_1), pdv(, x_2), ..., pdv(, x_n)) y = f$, we might expect
  $
    hat(y)(lambda_1, lambda_2, ..., lambda_n) = (hat(f)(lambda_1, lambda_2, ..., lambda_n))/(P(ii lambda_1, ii lambda_2, ..., ii lambda_n)),
  $
  so we may get the inverse Fourier transform
  $
    y(x_1, ..., x_n) = (1)/(2ppi)^n integral_(-oo)^(oo) ee^(ii vb(lambda) dot vb(x)) (hat(f)(vb(lambda)))/(P(ii vb(lambda))) dif^n lambda.
  $

  Unfortunately, this is hard to solve with various issues. See Part III for further details.
]

#lecture-separator(lecture: 18, date: "2026-11-18")

== Discrete Fourier Transform (DFT)

#definition[Discrete Fourier Transform][
  Given a finite sequence of complex numbers ${X_n}_(n=0)^(N-1)$, define their *discrete Fourier transform* by ${hat(X)_k}_(k=0)^(N-1)$, where
  $
    hat(X)_k = sum_(n=0)^(N-1) X_n ee^(-ii (2ppi n)/(N)k).
  $
]

Often, the ${X_n}_(n=0)^(N-1)$ is the result of evaluating a $2ppi$-periodic function at the points $x_n = (2ppi n)/(N)$, _i.e._
$
  X_n = f(x_n) = f((2ppi n)/(N)).
$
If we set $delta x = x_(n+1) - x_n = (2 ppi)/(N)$, then
$
  hat(X)_k & = (N)/(2ppi) sum_(n=0)^(N-1) f(x_n) ee^(-ii k x_n) delta x \
           & approx (N)/(2ppi) integral_(0)^(2ppi) f(x) ee^(-ii k x) dif x #eq-note[for very large $N$] \
           & = N hat(f)_k. \
$

Thus for $N >> 1$,
$
  hat(f)_k approx (hat(X)_k)/(N).
$
So we hope that
$
  X_n = f(x_n) & approx sum_(k=0)^(N-1) hat(f)_k ee^(ii k x_n) \
               & approx (1)/(N) sum_(k=0)^(N-1) hat(X)_k ee^(ii (2 ppi k)/(N) n).
$
It turns out that we can exactly recover the ${X_n}_(n=0)^(N-1)$ from ${hat(X)_k}_(k=0)^(N-1)$, just like the usual Fourier transform.

#proposition[
  For all $n in {0, 1, ..., N-1}$, we have
  $
    X_n = (1)/(N) sum_(k=0)^(N-1) hat(X)_k ee^(ii (2ppi k)/(N) n).
  $
]

#proof[
  $
    "RHS" & = (1)/(N) sum_(k=0)^(N-1) [sum_(m=0)^(N-1) X_m ee^(-ii (2ppi m)/(N) k)] ee^(ii (2ppi k)/(N) n) \
          & = (1)/(N) sum_(m=0)^(N-1) X_m underbracket([sum_(k=0)^(N-1) ee^(2 ppi ii (n-m) (k)/(N))], (star)). \
  $
  Setting $omega_N = ee^(ii (2ppi)/(N))$, then for $n != m$,
  $
    (star) = sum_(k=0)^(N-1) omega_N^((n-m) k) = (1 - omega_N^((n-m) N))/(1 - omega_N^(n-m)) = 0.
  $
  For $n = m$, we have $(star) = N$. Hence
  $
    "RHS" & = (1)/(N) sum_(m=0)^(N-1) X_m N delta_(m n) = X_n. \
  $
]
In relation to linear algebra, we can write #fade[[taking indices from $0$ to $N-1$]]
$
  vb(X) = vec(X_0, X_1, dots.v, X_(N-1)) in CC^N,
$
then
$
  hat(vb(X)) = vec(hat(X)_0, hat(X)_1, dots.v, hat(X)_(N-1)) = cal(F)(vb(X))
$
where $cal(F) : CC^N -> CC^N$  is the linear map defined in matrix form by
$
  (cal(F))_(k n) = ee^(-ii (2ppi n)/(N) k).
$
Our computation shows that
$
  (cal(F))^dagger cal(F) = cal(F) (cal(F))^dagger = N matbold(I)_N.
$
Write $matbold(U) = (1)/(sqrt(N)) cal(F)$, then $matbold(U)$ is unitary, _i.e._
$
  matbold(U)^dagger matbold(U) = matbold(U) matbold(U)^dagger = matbold(I)_N.
$

#example[
  Take $X_n = binom(N-1, n)$ for $n = 0, ..., N-1$. Then
  $
    hat(X)_k & = sum_(n=0)^(N-1) binom(N-1, n) ee^(-ii (2ppi n)/(N) k) \
             & = (1 + ee^(-ii (2ppi k)/(N)))^(N-1). #eq-note[by Binomial theorem]
  $
] <ex-dft-binomial-coefficients>

#proposition[Parseval's Theorem for DFT][
  For any two complex sequences ${X_n}_(n=0)^(N-1)$ and ${Y_n}_(n=0)^(N-1)$, we have
  $
    sum_(n=0)^(N-1) X_n overline(Y_n) = (1)/(N) sum_(k=0)^(N-1) hat(X)_k overline(hat(Y)_k).
  $
  In particular,
  $
    sum_(n=0)^(N-1) abs(X_n)^2 = (1)/(N) sum_(k=0)^(N-1) abs(hat(X)_k)^2.
  $
]
#proof[
  Note that for any two vectors $vb(X), vb(Y) in CC^N$, we have
  $
    vb(X) dot vb(Y) = vb(Y)^TT vb(X) = sum_(n=0)^(N-1) X_n overline(Y_n).
  $
  Then
  $
    "RHS" & = ((1)/(sqrt(N)) cal(F) vb(X)) dot ((1)/(sqrt(N)) cal(F) vb(Y)) \
          & = matbold(U) vb(X) dot matbold(U) vb(Y) \
          & = vb(X) dot vb(Y) = "LHS".
  $
]

#example[
  Using previous ${X_n}_(n=0)^(N-1)$ in @ex-dft-binomial-coefficients, we have
  $
    sum_(n=0)^(N-1) binom(N-1, n)^2 & = (1)/(N) sum_(k=0)^(N-1) (1+ ee^(-ii (2ppi k)/(N)))^(N-1) (1 + ee^(ii (2ppi k)/(N)))^(N-1) \
    & = (1)/(N) sum_(k=0)^(N-1) [ee^(-ii (ppi k)/(N))]^(n-1) (ee^(ii (ppi k)/(N)) + ee^(-ii (ppi k)/(N)))^(N-1) dot [ee^(ii (ppi k)/(N))]^(N-1) (ee^(ii (ppi k)/(N)) + ee^(-ii (ppi k)/(N)))^(N-1) \
    &= (1)/(N) sum_(k=0)^(N-1) [2 cos((ppi k)/(N))]^(2N-2). \
  $
  By combinatorics,
  $
    "LHS" & = sum_(n=0)^(N-1) binom(N-1, n) binom(N-1, n) \
          & = sum_(n=0)^(N-1) binom(N-1, n) binom(N-1, N-1-n) \
          & = binom(2N-2, N-1). \
  $
  Set $N-1 = M$, and tidying up gives
  $
    underbracket((1)/(2^(2M)) binom(2M, M), PP(B = M mid(|) B ~ "Bin"(2M, (1)/(2)))) = (1)/(M+1) sum_(k=0)^(M) cos^(2M) ((ppi k)/(M+1)).
  $
]

Just like taking convolution on $RR$, we can take convolution of two sequences ${X_n}_(n=0)^(N-1)$ and ${Y_n}_(n=0)^(N-1)$, defined by
$
  (X * Y)_n = sum_(m=0)^(N-1) X_((n-m) mod N) Y_m
$
where $(n-m) mod N$ is evaluated in $0, 1, ..., N-1$.

#proposition[
  $
    ftrans[X*Y]_k = hat(X)_k hat(Y)_k.
  $
]
#proof[
  $
    "LHS" & = sum_(n=0)^(N-1) [sum_(m=0)^(N-1) X_((n-m) mod N) Y_m] ee^(-ii (2ppi n)/(N) k) \
          & = sum_(m=0)^(N-1) Y_m ee^(-ii (2ppi m)/(N) k) sum_(n=0)^(N-1) X_((n-m) mod N) ee^(-ii (2ppi (n-m))/(N) k). \
  $
  Note that the $n$-sum ranges over every residue modulo $N$, hence
  $
    "LHS" & = sum_(m=0)^(N-1) Y_m ee^(-ii (2ppi m)/(N) k) hat(X)_k \
          & = hat(X)_k hat(Y)_k. \
  $
]
