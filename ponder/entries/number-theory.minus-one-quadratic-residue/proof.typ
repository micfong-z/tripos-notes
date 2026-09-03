Suppose first that $p equiv 1 mod 4$. By Wilson's theorem,
$ -1 equiv (p-1)! &equiv 1 dot 2 dot 3 dot ... dot (p-1)/2 dot (p+1)/2 dot ... dot (p-3) dot (p-2) dot (p-1) mod p \
                  &equiv 1 dot 2 dot 3 dot ... dot (p-1)/2 dot (-(p-1)/2) dot ... dot -3 dot -2 dot -1 mod p \
                  &equiv (-1)^((p-1)/2) [((p-1)/2)!]^2 mod p. $
Since $p equiv 1 mod 4$, we have $p = 4k + 1$ for some $k in NN$, so $(p-1)/2 = 2k$ is even and $(-1)^((p-1)/2) = 1$. Hence
$ -1 equiv [((p-1)/2)!]^2 mod p, $
so $-1$ is a square modulo $p$.

Conversely, we prove the contrapositive: suppose $p equiv -1 mod 4$, say $p = 4k + 3$. If there were $z in ZZ$ with $z^2 equiv -1 mod p$, then by Fermat's little theorem,
$ 1 &equiv z^(p-1) mod p \
    &equiv z^(4k + 2) mod p \
    &equiv (z^2)^(2k + 1) mod p \
    &equiv (-1)^(2k + 1) mod p \
    &equiv -1 mod p, $
a contradiction.
