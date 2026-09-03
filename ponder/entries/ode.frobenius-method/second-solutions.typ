Getting one Frobenius-type solution about a regular singular point is guaranteed, but whether there is a second linearly independent one depends on the roots $sigma_1$ and $sigma_2$ of the indicial equation:

+ If $sigma_1 - sigma_2$ is not an integer, two linearly independent solutions are obtained directly:

$
  y_1 &= (x - x_0)^(sigma_1) sum_(n=0)^oo a_n (x - x_0)^n, \
  y_2 &= (x - x_0)^(sigma_2) sum_(n=0)^oo b_n (x - x_0)^n.
$

+ If $sigma_2 - sigma_1$ is a non-zero integer, one series solution involves the larger root, say $sigma_2$. The second solution has the form

$
  y_2 = (x-x_0)^(sigma_1) sum_(n=0)^oo b_n (x - x_0)^n + C y_1 ln (x - x_0),
$

  where $C$ may or may not be zero and is determined in terms of $a_0$ and $b_0$, so that two arbitrary constants remain.

+ If $sigma_1 = sigma_2 = sigma$, the form is similar to case (2), but the logarithmic term is always present.

For example, in $x^2 y'' - x y = 0$ the indicial equation is $sigma(sigma - 1) = 0$, so $sigma_1 = 0$ and $sigma_2 = 1$ differ by a non-zero integer: the larger root gives the Taylor-series solution $y_1 = a_0 x (1 + (x)/(2) + (x^2)/(12) + dots)$, while for $sigma_1 = 0$ the recurrence demands $0 = a_0$ when $n = 1$, so no series solution exists and the logarithmic form $y_2 = sum b_n x^n + C y_1 ln x$ is required instead.
