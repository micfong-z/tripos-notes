Write $z_1 = r_1 (cos theta_1 + ii sin theta_1)$ and $z_2 = r_2 (cos theta_2 + ii sin theta_2)$. Expanding the product and collecting terms,

$ z_1 z_2 = r_1 r_2 (cos(theta_1 + theta_2) + ii sin(theta_1 + theta_2)), $

so angles add when complex numbers in polar form are multiplied.

For $n = 0$, the statement reads $z^0 = 1$. For $n >= 0$, induction on $n$ combines the base case with the product rule above. For $n < 0$, write $n = -m$ with $m > 0$; since $abs(cos(m theta) + ii sin(m theta)) = 1$,

$ (cos(m theta) + ii sin(m theta))^(-1) = overline(cos(m theta) + ii sin(m theta)) = cos(-m theta) + ii sin(-m theta), $

which reduces the negative case to the positive one.
