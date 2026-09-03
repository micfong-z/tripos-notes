For $X ~ N(mu, sigma^2)$ with density $f(x) = 1 \/ sqrt(2 ppi sigma^2) exp(- (x - mu)^(2)\/(2 sigma^2))$, completing the square in the exponent gives
$
  theta x - ((x - mu)^2)/(2 sigma^2) = - ((x - (mu + theta sigma^2))^2)/(2 sigma^2) + mu theta + (theta^2 sigma^2)/2.
$
The first term integrates against the density of $N(mu + theta sigma^2, sigma^2)$ to $1$, so
$
  m(theta) = exp(mu theta + (theta^2 sigma^2)/2).
$
Together with multiplicativity under sums this recovers $X + Y ~ N(mu + nu, sigma^2 + tau^2)$ for independent normals $X ~ N(mu, sigma^2)$ and $Y ~ N(nu, tau^2)$.
