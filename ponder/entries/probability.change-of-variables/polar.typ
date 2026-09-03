Let $X, Y ~ N(0, 1)$ be independent and set $R = sqrt(X^2 + Y^2)$, $Theta = arctan(Y \/ X)$. The map $(r, theta) -> (r cos theta, r sin theta)$ has Jacobian determinant
$
  matbold(J) = mat(cos theta, -r sin theta; sin theta, r cos theta), quad quad det matbold(J) = r,
$
so the density of $(R, Theta)$ is
$
  f_(R, Theta) (r, theta) & = f_X (r cos theta) dot f_Y (r sin theta) dot r \
  & = 1/sqrt(2 ppi) exp(- (r^2 cos^2 theta)/2) dot 1/sqrt(2 ppi) exp(- (r^2 sin^2 theta)/2) dot r = 1/(2 ppi) ee^(-(r^2)/2) dot r,
$
for $r >= 0$ and $theta in [0, 2 ppi]$. The joint density factorises into a function of $r$ times a function of $theta$, so $Theta ~ U[0, 2 ppi]$ and $R$ has density $f_R (r) = r ee^(-(r^2)/2)$ for $r >= 0$, independently of each other.
