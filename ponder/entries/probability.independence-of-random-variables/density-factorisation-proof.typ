Suppose $X_1, ..., X_n$ are independent with densities $f_1, ..., f_n$. Then
$
  PP(X_1 <= x_1, ..., X_n <= x_n) & = PP(X_1 <= x_1) ... PP(X_n <= x_n) \
  & = (integral_(-oo)^(x_1) f_1(y_1) dif y_1) ... (integral_(-oo)^(x_n) f_n (y_n) dif y_n) \
  & = integral_(-oo)^(x_1) ... integral_(-oo)^(x_n) f_1(y_1) ... f_n (y_n) dif y_n ... dif y_1,
$
so the joint distribution function is that of a random vector with density $f(x_1, ..., x_n) = f_1 (x_1) ... f_n (x_n)$.

Conversely, suppose $f$ factorises as $f(x_1, ..., x_n) = f_1 (x_1) ... f_n (x_n)$ for non-negative functions $f_1, ..., f_n$. Then
$
  PP(X_1 <= x_1, ..., X_n <= x_n) & = integral_(-oo)^(x_1) ... integral_(-oo)^(x_n) f_1 (y_1) ... f_n (y_n) dif y_n ... dif y_1 \
  & = (integral_(-oo)^(x_1) f_1 (y_1) dif y_1)/(integral_(-oo)^(oo) f_1 (y_1) dif y_1) ... (integral_(-oo)^(x_n) f_n (y_n) dif y_n)/(integral_(-oo)^(oo) f_n (y_n) dif y_n),
$
where the denominators normalise each factor since $integral_(-oo)^(oo) ... integral_(-oo)^(oo) f(y_1) ... f_n (y_n) dif y_n ... dif y_1 = 1$. The joint distribution function is a product of functions of single coordinates, so $X_1, ..., X_n$ are independent with densities proportional to $f_1, ..., f_n$.
