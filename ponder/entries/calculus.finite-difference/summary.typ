A derivative evaluated at a grid point can be approximated by nearby samples,
$ eval((dif^(2) y)/(dif x^(2)))_(x_n) approx (y_(n+1) - 2 y_n + y_(n-1))/(h^(2)), $
so discretising an ODE turns it into a discrete equation for the samples $y_n$.
