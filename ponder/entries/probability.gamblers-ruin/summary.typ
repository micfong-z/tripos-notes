A simple random walk models a gambler's fortune starting at $x$, winning $£1$ with probability $p$ and losing $£1$ with probability $q = 1-p$ each step, until the fortune reaches $0$ or $a$. With $h(x) = PP_x(X$ reaches $a$ before reaching $0)$, the ruin-avoidance probabilities solve
$
  h(x) = p h(x+1) + (1-p) h(x-1), quad h(0) = 0, quad h(a) = 1,
$
giving $h(x) = x / a$ for the symmetric walk and
$
  h(x) = ((q/p)^x - 1) / ((q/p)^a - 1)
$
otherwise.
