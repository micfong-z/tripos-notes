#import "../prelude.typ": *
#import "@preview/physica:0.9.8": *

= The Jacobi Equation

Consider the same setup as @sec-second-variation. Let $y_0 in cal(C)$ satisfy the Euler-Lagrange equation of $F$. Then consider
$
  0 & = integral_(alpha)^(beta) (phi xi^2)' dif x quad                & "since" xi(alpha) = xi(beta) = 0 \
    & = integral_(alpha)^(beta) (2 phi xi xi' + phi' xi^2) dif x quad &     "for any differentiable" phi \
$
Adding this to @eq-11-4,
$
  delta^2 F[y_0, xi] = (1)/(2) integral_(alpha)^(beta) (rho (xi')^2 + 2 phi xi xi' + (sigma + phi') xi^2) dif x.
$

Assume that $rho > 0$ for $x in [alpha, beta]$. Then completing the square gives
$
  delta^2 F[y_0, xi] &= (1)/(2) integral_(alpha)^(beta) (rho (xi' + (phi)/(rho) xi)^2 + (sigma + phi' - (phi^2)/(rho)) xi^2) dif x.
$
If we can choose $phi$ to satisfy the Riccati equation

#set math.equation(numbering: "(1)")
$
  phi' + sigma = (phi^2)/(rho)
$ <eq-12-1>
#set math.equation(numbering: none)

then
$
  delta^2 F[y_0, xi] = (1)/(2) integral_(alpha)^(beta) rho (xi' + (phi)/(rho) xi)^2 dif x >= 0.
$
and vanishes iff $xi' + (phi)/(rho) xi = 0$. The solution to this differential equation is
$
  xi(x) = C exp (-integral_alpha^x (phi(s))/(rho(s)) dif s).
$
But note that $xi(alpha) = 0 = C$, so $xi(x) equiv 0$. Hence, $delta^2 F[y_0, xi] > 0$ for all non-trivial allowed $xi$.

Hence, $y_0$ is a local minimum if there exists a solution $phi$ to the Riccati equation @eq-12-1. Note that this is a first order nonlinear ODE, but we can convert it to a linear second order ODE by the substitution $phi = -rho (u')/(u)$ for $u != 0$. This gives
$
                 -(rho (u')/(u))' + sigma & = rho ((u')/(u))^2 \
  -(rho u')'/u + rho (u')^2/(u^2) + sigma & = rho (u')^2/(u^2) \
$
Therefore, we have the Jacobi accessory equation
#set math.equation(numbering: "(1)")
$
  -(rho u')' + sigma u & = 0.
$ <eq-12-2>
#set math.equation(numbering: none)

Note that this is linear, so it can always be solved #fade[[but not necessarily always with $u != 0$]]. If there exists a solution of @eq-12-2 with $u != 0$ on $[alpha, beta]$ then we obtain a solution $phi$ of @eq-12-1, which in turn guarantees that $y_0$ is a local minimum.

#example[
  Consider
  $
    F = (1)/(2) integral_(0)^(a)((y')^(2)- y^2) dif x quad "with" rho = 1, sigma = -1.
  $
  Hence @eq-12-2 becomes
  $
    -u'' -u=0 => u = A sin(x- x_0).
  $
  So solutions oscillate with period $2 ppi$. Therefore we can find a solution with $u = 0$ on $[0, a]$ iff $a < ppi$. Therefore, we learn that a solution $y_0$ of the Euler-Lagrange equation is a local minimum of $F$ if $a < ppi$.

  #fade[[We arrive at the same result as @ex-sl-example, but this is a weaker result since we did not prove that $y_0$ is not a local minimum if $a > ppi$.]]
]
