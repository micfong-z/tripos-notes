Under $(x, y) -> (x + delta x, y + delta y)$,
$
  delta f
    = [f(x + delta x, y + delta y) - f(x + delta x, y)]
      + [f(x + delta x, y) - f(x, y)].
$
Taylor's theorem gives
$ f(x + delta x, y) - f(x, y) = f_x (x, y) delta x + o(delta x) $
and
$ f(x + delta x, y + delta y) - f(x + delta x, y) = f_y (x + delta x, y) delta y + o(delta y), $
while
$ f_y (x + delta x, y) = f_y (x, y) + f_(y x) (x, y) delta x + o(delta x). $
Hence
$
  delta f
    = [f_y (x, y) + f_(y x) (x, y) delta x + o(delta x)] delta y
      + f_x (x, y) delta x + o(delta x) + o(delta y).
$
The limit $delta x, delta y -> 0$ is $dif f = f_x dif x + f_y dif y$.
