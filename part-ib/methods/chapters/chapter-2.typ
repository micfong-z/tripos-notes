#import "../prelude.typ": *
#show: chapter.with(2)

#lecture-separator(lecture: 4, date: "2026-10-16")

= Sturm-Liouville Problems

== Abstract Eigenvalue Problem

Recall from IA Vectors and Matrices that a linear map $matbold(A): V_N -> V_N$ is called *Hermitian* if, for all vectors $vb(x), vb(y) in V_N$,
$
  vb(x) dot matbold(A) vb(y) = (matbold(A) vb(x)) dot vb(y),
$
equivalently, $matbold(A) = matbold(A)^dagger$. For such maps, we have

+ the eigenvalues of $matbold(A)$ are real, and

+ the eigenvectors corresponding to different eigenvalues are orthogonal #fade[[w.r.t. $vb(x) dot vb(y) = sum_i x_i overline(y)_i$]].

+ There exists a set ${vb(y)_n}_(n=1)^N$ of eigenvectors such that every $vb(x) in V_N$ can be written as
  $
    vb(x) = sum_(n=1)^N hat(x)_n vb(y)_n, quad "where" hat(x)_n = (vb(x) dot vb(y)_n) / norm(vb(y)_n)^2.
  $
  #fade[[This is the spectral theorem for Hermitian matrices.]]

We wonder if this generalises.

Let $V$ be a vector space of functions on $[a, b]$ (we will take $V <= C^2[a, b]$). Equip $V$ with the inner product
$
  iprod(f, g)_w = integral_(a)^(b) f(x) overline(g(x)) w(x) dif x
$
where $w(x)$ is real and $w > 0$ on $(a, b)$. Set $norm(f)_w = sqrt(iprod(f, f)_w)$.

#notation[
  We will denote $iprod(f, g)_1 =: iprod(f, g)$.
]

#definition[Self-Adjoint Operators][
  A linear operator $L$ on $V$ is called self-adjoint on $(V, iprod(dot, dot)_w)$ if
  $
    iprod(L y_1, y_2)_w = iprod(y_1, L y_2)_w
  $
  for all $y_1, y_2 in V$. #fade[[Note that with abuse of notation, this is $L = L^dagger$ w.r.t. $iprod(dot, dot)_w$.]]

  We say $(lambda, y) in CC times (V \\ {0})$ is an eigenvalue-eigenfunction pair for $L$ if $L y = lambda y$.
]

#proposition[
  If $L$ is self-adjoint on $(V, iprod(dot, dot)_w)$, then

  + the eigenvalues of $L$ are real, and

  + the eigenfunctions corresponding to different eigenvalues are orthogonal w.r.t. $iprod(dot, dot)_w$.

  + $exists {y_n}_(n=1)^oo$ of eigenfunctions such that every $f in V$ can be written as
    $
      f(x) = sum_(n=1)^oo hat(f)_n y_n (x), quad "where" hat(f)_n = iprod(f, y_n)_w / norm(y_n)_w^2
    $

] <prop-self-adjoint-operator-properties>

#proof[
  + Suppose $L y = lambda y$ where $y != 0$. Then
    $
      (lambda - overline(lambda)) norm(y)^2_w & = (lambda - overline(lambda) )iprod(y, y)_w \
                                              & = iprod(lambda y, y)_w - iprod(y, lambda y)_w \
                                              & = iprod(L y, y)_w - iprod(y, L y)_w \
                                              & = 0.
    $
    Hence $lambda = overline(lambda)$, so $lambda in RR$.

  + Suppose $L y_1 = lambda_1 y_1$ and $L y_2 = lambda_2 y_2$ where $lambda_1 != lambda_2$. Then

    $
      (lambda_1 - lambda_2) iprod(y_1, y_2)_w & = iprod(lambda_1 y_1, y_2)_w - iprod(y_1, lambda_2 y_2)_w \
                                              & = iprod(L y_1, y_2)_w - iprod(y_1, L y_2)_w \
                                              & = 0.
    $
    Hence $iprod(y_1, y_2)_w = 0$.

  + _Proof by authority_: David Hilbert says it is true. #fade[[#"¯\_(ツ)_/¯" This is beyond the scope of this course.]]
]

== Self-Adjointness and Boundary Conditions

We will study problems of the form
$
  cases(
    L y = lambda y quad "for" a < x < b,
    "some boundary conditions at" x = a\, b
  )
$ <eq-sturm-liouville>

where $L$ is a special type of differential operator.

#definition[Sturm-Liouville Operator][
  A *Sturm-Liouville operator* is a second-order linear differential operator of the form
  $
    L dot = (1)/(w) [-dv(, x) (p dv(dot, x)) + q dot]
  $
  where $p, q, w$ are real-valued functions, and $p, w > 0$ on $(a, b)$. We call $w$ the *weight function* associated with $L$.
]

Thus, $L y = lambda y$ becomes
$
  -dv(, x) (p dv(y, x)) + q y = lambda w y quad "for" a < x < b.
$

We will impose boundary conditions by forcing $y$ to belong to some vector space $V$ that enforces them. Thus, @eq-sturm-liouville is equivalent to $L y = lambda y$, $y in V$.

#definition[Singular and Non-Singular Endpoints][
  Given a Sturm-Liouville operator on $(a, b)$, an endpoint $c in {a, b}$ is *singular* if $p(c) = 0$, and *non-singular* otherwise.
]

We will only specify boundary conditions at non-singular endpoints. At non-singular endpoints, we will impose *real homogeneous boundary conditions* of the form
$
  alpha_c y(c) + beta_c y'(c) = 0
$
where $alpha_c, beta_c in RR$, $alpha^2_c + beta^2_c != 0$. Note that if $y_1, y_2$ satisfy boundary conditions of this form, then so does $c_1 y_1 + c_2 y_2$ where $c_1, c_2$ are constants, _i.e._ a vector space structure.

So given a Sturm-Liouville operator $L$ on $(a, b)$, we work on a vector space of form
$
  V = Set(y in C^2 [a, b], y "satisfies real homogeneous b.c. at each non-singular endpoint")
$ <eq-def-V>
Equip $V$ with the inner product $iprod(dot, dot)_w$ where $w$ is the weight function associated with $L$.

#example[
  Consider $V = Set(y in C^2[0, ppi]; y(0) = 0)$. Consider the Sturm-Liouville problem
  $
    -dv(, x) (underbracket(cos((x)/(2)), p)dv(y, x)) + underbracket(sin((x)/(2)), q) y = underbracket(#fade[$1$], w) dot lambda y
  $
  Note that $p(ppi) = 0$ (singular), but $p(0) != 0$ (non-singular). We have
  $
    iprod(f, g) = integral_(0)^(ppi) f(x) overline(g(x)) dif x.
  $
]

#proposition[
  Let $V$ be a vector space (defined by @eq-def-V) associated with a Sturm-Liouville operator $L$. Then $L$ is self-adjoint on the pair $(V, iprod(dot, dot)_w)$ where $w$ is a weight function associated with $L$.

  #fade[[_i.e._ $iprod(L y_1, y_2)_w = iprod(y_1, L y_2)_w$ for all $y_1, y_2 in V$.]]
]

#proof[
  Take $y_1, y_2 in C^2[a, b]$. Then
  $
    iprod(L y_1, y_2)_w - iprod(y_1, L y_2)_w
    & = integral_(a)^(b) (1)/(w) [-(p y'_1)' + q y_1] overline(y_2) w dif x - integral_(a)^(b) (1)/(w) y_1 [-(p overline(y_2)')' + q overline(y_2)] w dif x \
    &= integral_(a)^(b) (y_1 (p overline(y_2)')' - overline(y_2) (p y'_1)') dif x \
    &= integral_a^b [p underbracket((y_1 overline(y_2)' - y'_1 overline(y_2)), "Wronskian" W(y_1, overline(y_2)))]' dif x \
    &= [p(x) W(y_1, overline(y_2))(x)]_a^b. #(<eq-double-dagger>) \
  $
  Now assume $y_1, y_2 in V$. If $c in {a, b}$ is singular then $p(c) = 0$. _i.e._ the RHS of @eq-double-dagger vanishes at $x = c$. If $c in {a, b}$ is non-singular, then because $y_1, y_2 in V$, they obey boundary conditions of the form
  $
    alpha_c y(c) + beta_c y'(c) = 0, quad alpha_c, beta_c in RR, quad alpha^2_c + beta^2_c != 0.
  $
  Since $alpha_c$ and $beta_c$ are real, the same holds with $y$ replaced by $overline(y)$. Hence
  $
    mat(y_1 (c), y'_1 (c); overline(y_2) (c), overline(y_2)' (c)) vec(alpha_c, beta_c) = 0.
  $
  Since $alpha_c^2 + beta_c^2 != 0$, the vector is non-zero and hence we must have
  $
    mat(delim: "|", y_1 (c), y'_1 (c); overline(y_2) (c), overline(y_2)' (c)) = 0.
  $
  But this is exactly $W(y_1, overline(y_2))(c) = 0$. Hence the RHS of @eq-double-dagger vanishes at $x = c$ for non-singular endpoints as well.

  Thus, $iprod(L y_1, y_2)_w = iprod(y_1, L y_2)_w$ for all $y_1, y_2 in V$, _i.e._ $L$ is self-adjoint on $(V, iprod(dot, dot)_w)$.
]

#lecture-separator(lecture: 5, date: "2026-10-19")

== The Sturm-Liouville Eigenvalue Problem

We will study problems of the form
$
  - dv(, x)(p dv(y, x)) + q y =lambda w y
$
where $y in V = Set(y in C^2[a, b]; y "satisfies real homogeneous b.c. at each non-singular endpoint")$. Equip $V$ with inner product
$
  iprod(f, g)_w = integral_(a)^(b) f(x) overline(g(x)) w(x) dif x.
$

Note that we can assume elements of $V$ are real WLOG, since if $L y = lambda y$ and $y = u + ii v$, then
$
  L u = lambda u, quad L v = lambda v
$
since $p, q, w, lambda$ are real. Hence for $y_1, y_2 in V$, we have
$
  iprod(y_1, y_2)_w = integral_(a)^(b) y_1(x) y_2(x) w(x) dif x.
$
Since $L$ is self-adjoint on $(V, iprod(dot, dot)_w)$, we know $exists (lambda_n, y_n)_(n=1)^oo in RR times (V \\ {0})$ such that $L y_n = lambda_n y_n$, and
$
  integral_(a)^(b) y_m (x) y_n (x) w(x) dif x = 0, quad "if" lambda_m != lambda_n.
$
Also, for any $f in V$, we can write
$
  f(x) = sum_(n=1)^oo hat(f)_n y_n (x), quad "where" hat(f)_n = iprod(f, y_n)_w / norm(y_n)_w^2.
$

#fade[[Recall @prop-self-adjoint-operator-properties.]] It will turn out, for our Sturm-Liouville problems, eigenvalues are bounded below and can be ordered so that
$
  lambda_1 < lambda_2 < dots < lambda_n < dots, quad "and" lim_(n->oo) lambda_n = oo.
$

#example[
  Consider the Sturm-Liouville problem
  $
    cases(
      -y'' & = lambda y quad 0 < x < L,
      y(0) & = 0,
      y(L) & = 0.
    )
  $
  So $p = 1, q=0, w=1$ and $V = Set(y in C^2 [0, L]; y(0) = 0, y(L) = 0)$.

  Here, we require $lambda > 0$ for non-trivial solutions #fade[[one needs to check this explicitly in exams]]. Then
  $
    y = A sin (sqrt(lambda) x ) + B cos (sqrt(lambda) x).
  $
  The boundary condition at $x=0$ gives $B = 0$.

  The boundary condition at $x=L$ gives $A sin (sqrt(lambda) L) = 0$. For non-trivial solutions, we require $sqrt(lambda) L = n ppi$ for some $n in ZZ^+$. Hence
  $
    lambda_n = ((ppi n)/(L))^2, quad y_n (x) = sin((n ppi x)/(L)) quad n in ZZ^+.
  $
  #fade[[We chose $A = 1$ here.]]
  Note that
  $
    integral_(0)^(L) y_m (x) y_n (x) dif x = (L)/(2) delta_(m n).
  $

  Hence, for any $f in V$, we have
  $
    f(x) = sum_(n=1)^oo hat(f)_n sin((n ppi x)/(L)),
  $
  where
  $
    hat(f)_n & = iprod(f, y_n)_w / norm(y_n)_w^2 \
              & = (2)/(L) integral_(0)^(L) f(x) sin((n ppi x)/(L)) dif x.
  $
  Note that we re-derived the Fourier sine series in @def-cosine-sine-series.
]

== Reduction to Sturm-Liouville Form

#proposition[

  Consider generic eigenvalue problems of the form
  $
    alpha(x) dv(y, x, 2) + beta(x) dv(y, x) + gamma(x) y + lambda y = 0
  $
  for $a< x < b$, where $alpha(x) > 0$ on $(a, b)$.


  Dividing through by $alpha(x) > 0$ and multiplying by an integrating factor, for a suitable fixed $x_0$,
  $ I(x) = exp(integral_(x_0)^(x) (beta(t))/(alpha(t)) dif t), $ the problem is equivalent to a Sturm-Liouville problem of the form
  $
    - dv(, x) (p dv(y, x)) + q y = lambda w y,
  $
  where
  $
    p(x) & = I(x), \
    q(x) & = -(gamma(x) I(x))/(alpha(x)) \
    w(x) & = I(x)/(alpha(x)).
  $
]

#proof[
  From definitions, we have
  $
    - dv(, x) (p dv(y, x)) + q y - lambda w y & = I(x) [- y'' - (beta)/(alpha) y' - (gamma)/(alpha) y - (lambda)/(alpha) y] \
                                              & = 0 quad <=> "the problem is satisfied since" I!=0. \
  $
  Note also that $p > 0$, $w > 0$ on $(a, b)$.

]

#example[
  Consider
  $
    cases(
      y'' - 2y' + lambda y & = 0 quad 0 < x < 1,
      y(0) & = 0,
      y'(1) & = 0.
    )
  $
  The integrating factor is
  $
    I(x) = exp(integral_(0)^(x) (-2) dif t) & = ee^(-2x).
  $
  Then the problem becomes
  $
    - dv(, x) (ee^(-2x) dv(y, x)) = lambda ee^(-2x) y quad 0 < x < 1,
  $
  where $p = ee^(-2x)$, $q = 0$, $w = ee^(-2x)$.


  #remark[
    The point of putting a differential equation into Sturm-Liouville form is that we can then find out the weight function $w$, on which our inner product is based.
  ]

  The general solution to this Sturm-Liouville problem is of the form
  $
    y = ee^x [A sinh (sqrt(1 - lambda) x) + B cosh (sqrt(1 - lambda) x)].
  $
  It turns out that we get non-trivial solutions only when $1-lambda < 0$. Hence set $1 - lambda = -mu^2$ where $mu > 0$ WLOG. So
  $
    y = ee^x [A sin (mu x) + B cos (mu x)].
  $
  Hence for $x = 0$, the boundary condition leads to $B = 0$. For $x = 1$, the boundary condition leads to
  $
    0 = A ee[sin mu + mu cos mu].
  $
  So for non-trivial solutions, we require

  $
    sin mu + mu cos mu & = 0 \
                tan mu & = -mu quad mu > 0. \
  $

  This is usually solved numerically.

  #align(center)[
    #dynamic-svg2("/part-ib/methods/media/p5.svg", width: 44em)
  ]

  So we get an infinite sequence $lambda_n = 1 + mu_n^2$ and indeed $lambda_1 < lambda_2 < ...$ and $lim_(n->oo) lambda_n = oo$.

  Hence the eigenfunctions are
  $
    y_n (x) & = ee^x sin (mu_n x).
  $
  We need to check whether the eigenfunctions are orthogonal for $n != m$. We have
  $
    integral_(0)^(1) ee^(x) sin (mu_n x) ee^(x) sin (mu_m x) ee^(-2x) dif x &= integral_(0)^(1) sin (mu_n x) sin (mu_m x) dif x\
    &= (1)/(2) integral_(0)^(1) [cos((mu_n - mu_m) x) - cos ((mu_n + mu_m) x)] dif x \
    &= (1)/(2) [sin(mu_n - mu_m)/(mu_n - mu_m) - sin(mu_n + mu_m)/(mu_n + mu_m)] \
    &= (sin mu_n cos mu_m - sin mu_m cos mu_n)/(2(mu_n - mu_m)) #<equate:revoke> \
    &quad - (sin mu_n cos mu_m + sin mu_m cos mu_n)/(2(mu_n + mu_m)) \
    &= (1)/(2) cos mu_n cos mu_m [(tan mu_n - tan mu_m)/(mu_n - mu_m) - (tan mu_n + tan mu_m)/(mu_n + mu_m)] \
    &= (1)/(2) cos mu_n cos mu_m [(- mu_n + mu_m)/(mu_n - mu_m) + ( mu_n + mu_m)/(mu_n + mu_m)] \
    &= 0.
  $

  #remark[
    This is indeed tedious. One should use Sturm-Liouville theory to demonstrate orthogonality instead. (See @prop-self-adjoint-operator-properties.)
  ]
]

#lecture-separator(lecture: 6, date: "2026-10-21")

== Legendre's Equation

Consider the Sturm-Liouville problem
$
  -dv(, x) ((1-x^2) dv(y, x)) = lambda y quad -1 <x<1
$
with $p = (1-x^2)$, $q =0$, $w = 1$, and $V = Set(y in C^2[-1, 1])$ #fade[[note that $p(plus.minus 1) = 0$]]. Equip $V$ with
$
  iprod(f, g) = integral_(-1)^(1) f(x) g(x) dif x.
$
Then $L$ is self-adjoint on $(V, iprod(dot, dot))$. Since $x=0$ is ordinary (see IA Differential Equations), we can look for solutions of form
$
  y = sum_(n=0)^oo a_n x^n.
$
We will then find that
$
  a_(n+2) = (n(n+1) - lambda)/((n+1)(n+2)) a_n.
$
Hence we will get two linearly independent solutions
$
  y_0 & = a_0 [1 + (-lambda)/(2!) x^2 + ((-lambda)(6-lambda))/(4!) x^4 + ...] \
  y_1 & = a_1 [x + (2-lambda)/(3!) x^3 + ((2-lambda)(12-lambda))/(5!) x^5 + ...].
$

Since $a_(n+2)/(a_n) -> 1$ as $n -> oo$, so by ratio test (see IA Analysis I), we know that the series converge for all $abs(x) < 1$. We now wonder what happens at $x = plus.minus 1$.

#fade-block[[Non-examinable.] We can analyse $y_0, y_1$ very similarly. Set $A_n = a_(2n)$. Then
  $
    (A_n)/(A_(n+1)) = a_(2n)/(a_(2n+2)) = 1 + (1)/(n) + epsilon_n, quad n->oo
  $
  where $abs(epsilon_n) <= M(lambda)/(n^2)$. Note $"RHS" > 0$ for sufficiently large $n$, _e.g._ $n >= N$. So $A_n, A_(n+1)$ have the same sign for $n >= N$.
  Using $1+x <= ee^x$ for $x in RR$, we have
  $
    abs(A_n)/(abs(A_(n+1))) = (A_n)/(A_(n+1)) <= ee^((1)/(n) + epsilon_n) <= ee^((1)/(n) + (M)/(n^2)),
  $
  _i.e._ for $n >= N$,
  $
    abs(A_(n+1)) & >= abs(A_n) ee^(-(1)/(n) - (M)/(n^2)) \
                 & >= abs(A_N) ee^(-((1)/(n) + (1)/(n-1) + ... + (1)/(N)) - M(1/(N^2) + 1/((N+1)^2) + ... + 1/(n^2))) \
                 & >= abs(A_N) ee^(-M (ppi^2)/(6)) ee^(-H_n) ee^(H_(N-1)) #eq-note[where $H_n = sum_(k=1)^n 1/k$] \
  $
  Recall that $H_n <= log n + 2 gamma$, where $gamma$ is the Euler-Mascheroni constant. Hence for $n >= N$,
  $
    abs(A_(n+1)) & >= abs(A_N) ee^(-M (ppi^2)/(6)) ee^(H_(N-1)) ee^(-2 gamma) ee^(-log n) \
                 & >= (C)/(n+1) #eq-note[where $C = C(N, lambda)$]
  $
  Write
  $
    y_0 = sum_(n <= N) A_n x^(2n) + sum_(n > N) A_n x^(2n).
  $
  In the latter sum, all the coefficients have the same sign, WLOG positive. Then
  $
    sum_(n>N) A_n x^(2n) & >= C sum_(n>N) (x^(2n))/(n) \
                          & >= C[log((1)/(1-x^2)) - sum_(n=1)^N (x^(2n))/(n)] -> oo quad "as" x -> plus.minus 1.
  $
  which is not good.]

This can only be saved if the series terminates, _i.e._ $a_(n+2) = 0$ for some $n$. So we need $lambda = lambda_n = n(n+1)$. In this case we get a polynomial of degree $n$. If $n$ is even (odd), this polynomial is even (odd).

By convention, we normalise so that $y(1) = 1$, and get the Legendre Polynomials

#align(center, table(
  columns: (auto, auto, auto),
  table.header([$n$], [$lambda_n = n(n+1)$], [Polynomials]),
  [0], [0], [$P_0 (x) = 1$],
  [1], [2], [$P_1 (x) = x$],
  [2], [6], [$P_2 (x) = (1)/(2) (3 x^2 - 1)$],
  [3], [12], [$P_3 (x) = (1)/(2) (5 x^3 - 3 x)$],
))
We can show that
$
  iprod(P_n, P_m) = integral_(-1)^(1) P_n (x) P_m (x) dif x = (2)/(2n+1) delta_(n m).
$
This means that they are orthogonal.

== Bessel's Equation

Consider the Sturm-Liouville problem
$
  -dv(, r)(r dv(y, r)) + (m^2)/(r) y & = lambda r y quad 0 < r < 1 \
                                y(1) & = 0,
$
where $m$ is a fixed non-negative integer. #fade[[This has been seen in polar coordinates for Laplace's equation in IA Vector Calculus.]] We have $p = r, q = (m^2)/(r), w = r$, and
$
  V = Set(y in C^2[0, 1]; y(1) = 0).
$
Then $L$ is self-adjoint on $(V, iprod(dot, dot)_w)$ where
$
  iprod(f, g)_w = integral_(0)^(1) f(r) g(r) r dif r.
$
Expanding derivatives, we get
$
  r^2 y'' + r y' + (lambda r^2 - m^2) y = 0.
$
Setting $z = sqrt(lambda) r$ and writing $y(r) = R(z)$ gives
$
  z^2 R'' + z R' + (z^2 - m^2) R = 0
$ <eq-mth-order-bessel>
where $0 < z < sqrt(lambda)$, and $R(sqrt(lambda)) = 0.$

@eq-mth-order-bessel is called the *$m$-th order Bessel equation*.

Since $z = 0$ is a regular singular point, Fuchs' theorem #fade[[see IA Differential Equations]] says there exist solutions of the form
$
  z^sigma sum_(n=0)^oo a_n z^n
$
We will get 2 linearly independent solutions, only one of which is non-singular at $z=0$. So up to constant of proportionality, we get $R(z) = J_m (z)$ where
$
  J_m (z) = ((z)/(2))^m sum_(n=0)^oo ((-1)^n)/(n! (n+m)!) ((z)/(2))^(2n),
$
which is called the *Bessel function of the first kind of order $m$*.

Recall that we need $y(1) = R (sqrt(lambda)) = J_m (sqrt(lambda)) = 0$. One can show #fade[[see II Asymptotic Methods]] that
$
  J_m (z) = sqrt((2)/(ppi z)) cos(z - (m ppi)/(2) - (ppi)/(4)) + O((1)/(z^((3)/(2)))) quad "as" z->oo.
$
So $J_m (z)$ has infinitely many zeros in $(0, oo)$. Label them $j_(m k)$ for $k in ZZ^+$. So we get the eigenvalues and their corresponding eigenfunctions
$
  lambda_k & = j_(m k)^2, \
   y_k (r) & = J_m (j_(m k) r).
$
By orthogonality, we get
$
  integral_(0)^(1) J_m (j_(m k) r) J_m (j_(m l) r) r dif r prop delta_(k l).
$
The constant of proportionality can be found on Example Sheet 1.

== Inhomogeneous Problems

Consider problems of the form $L y = f$, where $L$ is a Sturm-Liouville operator. By absorbing into $f$ if necessary, we can assume that $w = 1$ WLOG. Let $V$ be an appropriate subspace of $C^2[a, b]$ so that $L$ is self-adjoint on $(V, iprod(dot, dot))$.

Let ${Y_k}$ be normalised ($norm(Y_k) = 1$) eigenfunctions of $L$ with $L Y_k = lambda_k Y_k$. If $f in V$, by completeness, we can write

$
  y = sum_k A_k Y_k, quad f = sum_k B_k Y_k
$
where $B_k = iprod(f, Y_k).$ Plugging into $L y -f = 0$ gives

$
  sum_k (A_k lambda_k - B_k) Y_k = 0.
$
By orthogonality, $A_k lambda_k = B_k$. So if $lambda_k != 0$ for every $k$, we get $A_k = (B_k)/(lambda_k)$. Hence
$
  y(x) & = sum_k (1)/(lambda_k) B_k Y_k (x) \
       & = sum_k (1)/(lambda_k) (integral_(a)^(b) f(xi) Y_k (xi) dif xi) Y_k (x) \
       & = integral_(a)^(b) G(x, xi) f(xi) dif xi #(<eq-L-inverse>) \
$
where
$
  G(x, xi) = sum_k (Y_k (x) Y_k (xi))/(lambda_k)
$
is called the *Green's function*. Note that @eq-L-inverse looks like an inverse of $L$.


