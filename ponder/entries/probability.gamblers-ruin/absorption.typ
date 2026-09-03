Let $T = min{n >= 0 : X_n in {0, a}}$ be the time to absorption and write $EE_x [T] = EE[T mid(|) X_0 = x] = k(x)$. Conditioning on the first step by the law of total expectation,
$
  k(x) & = EE_x [T] \
       & = EE_x [T mid(|) Y_1 = 1] PP(Y_1 = 1) + EE_x [T mid(|) Y_1 = -1] PP(Y_1 = -1) \
       & = p (k(x+1) + 1) + q (k(x-1) + 1) \
       & = p k(x+1) + q k(x-1) + 1,
$
with boundary conditions $k(0) = k(a) = 0$.

For the symmetric walk $p = q = 1/2$, trying $k(x) = A x^2$ forces $A = -1$, so the general solution is $k(x) = -x^2 + B x + C$ and the boundary conditions give
$
  k(x) = x (a-x).
$

For $p != q$, trying $C x$ gives $C = 1/(q-p)$, and the full solution is
$
  k(x) = (1)/(q-p) x - (a)/(q-p) (((q)/(p))^x - 1) / (((q)/(p))^a - 1).
$
