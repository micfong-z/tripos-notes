#import "../prelude.typ": *

= Elementary Number Theory

== #ponder("number-theory.prime-composite-numbers")[Primes]

Given $a, b in ZZ$, we say "$a$ divides $b$" if $exists c in ZZ$ such that $b = a c$. We write $a mid(|) b$.

For any $b in ZZ$, $plus.minus 1$ and $plus.minus b$ are always factors; all other factors are called *proper factors*.

#definition("Prime and Composite Numbers")[
  A natural number $n>=2$ is #ponder("number-theory.prime-composite-numbers")[prime] if its only factors are $plus.minus 1$ and $plus.minus n$. If $n>=2$ is not #ponder("number-theory.prime-composite-numbers")[prime], it is called *#ponder("number-theory.prime-composite-numbers")[composite]*.
] <def-prime-composite>

#lecture-separator(lecture: 9, date: "2025-10-28")

#proposition[
  Every natural number $n>1$ can be written as a product of #ponder("number-theory.prime-composite-numbers")[primes].
] <prop-factorisation>

#proof[
  We will #ponder("set-theory.proof")[prove] by induction on $n$.

  *Base case.* The #ponder("set-theory.statement")[statement] is true for $n = 2$.

  *Inductive step.* Let $n>2$ and suppose that the claim holds for all natural numbers $2 <= k <= n-1$. If $n$ is #ponder("number-theory.prime-composite-numbers")[prime], we are done. Otherwise, $n$ is #ponder("number-theory.prime-composite-numbers")[composite], so there exists $a, b in NN$ such that $n = a b$ and $1 < a, b < n$. By the inductive hypothesis, both $a$ and $b$ can be written as a product of #ponder("number-theory.prime-composite-numbers")[primes]. Thus, $n$ can also be written as a product of #ponder("number-theory.prime-composite-numbers")[primes].
]

#theorem[
  There are #ponder("number-theory.infinitude-of-primes")[infinitely many prime numbers].
] <thm-infinitude-of-primes>

#proof[
  Suppose there are finitely many #ponder("number-theory.prime-composite-numbers")[primes], say $p_1, ..., p_k$. Consider $N = p_1 p_2 ... p_k + 1$. Then $p_1 divides.not N$, or otherwise $p_1$ would divide $1$. Likewise, none of $p_2, ..., p_k$ divide $N$. Thus, either $N$ is #ponder("number-theory.prime-composite-numbers")[prime] itself, or it has a #ponder("number-theory.prime-composite-numbers")[prime] factor not in the list $p_1, ..., p_k$. In either case, we have a contradiction. $smash$
]

One may naturally wonder if all numbers can be written in only one way as a product of #ponder("number-theory.prime-composite-numbers")[primes] (up to ordering). This is indeed the case, as we shall see later.

#proposition[Euclid's Lemma][
  If $p$ is a #ponder("number-theory.prime-composite-numbers")[prime] and $p divides a b$, then $p divides a$ or $p divides b$.
] <prop-euclid-lemma>

== #ponder("number-theory.highest-common-factor")[Highest Common Factor]

#definition[Highest Common Factor][
  Given $a, b in NN$, a natural number $c$ is the *#ponder("number-theory.highest-common-factor")[highest common factor]* or the *#ponder("number-theory.highest-common-factor")[greatest common divisor]* of $a$ and $b$ if

  1. $c divides a$ and $c divides b$;
  2. for any $d in NN$ such that $d divides a$ and $d divides b$, we have $d divides c$.

  We write $c = "hcf"(a, b)$ or $c=gcd(a, b)$.
] <def-hcf>

#example[
  The factors of $12$ are $1, 2, 3, 4, 6, 12$. The factors of $18$ are $1, 2, 3, 6, 9, 18$.

  Thus, the common factors of $12$ and $18$ are $1, 2, 3, 6$, and the #ponder("number-theory.highest-common-factor")[highest common factor] is $6$. Therefore, $gcd(12, 18) = 6$.
]

We will need to show that the #ponder("number-theory.highest-common-factor")[highest common factor] always exists.

#proposition[Division algorithm][
  Given $n, k in NN$, we can write $n = q k + r$, where $q, r in ZZ$ with $0 <= r <= k-1$. #fade[[We are using $q$ and $r$ to denote the quotient and remainder respectively.]]
] <prop-division-algorithm>

#proof[
  We will prove this by induction on $n$.

  *Base case.* The statement is true for $n=1$.

  *Inductive step.* For $n>=2$, suppose the #ponder("set-theory.statement")[statements] holds for all natural numbers $1 <= m <= n-1$. We want to show that it also holds for $n$. _i.e._ $n-1=q k + r$ for some $q, r in ZZ$ with $0 <= r <= k-1$.

  If $r < k-1$, then $n = (n-1) + 1 = q k + (r+1)$.

  Otherwise, if $r = k-1$, then $n = (n-1) + 1 = (q+1) k + 0$.

  Thus, in either case, we have expressed $n$ in the desired form.

  Note that $q$ and $r$ thus obtained are unique: if $n = q k + r = q' k + r'$, then $(q-q') k = r'-r$. Since $0 <= r, r' <= k-1$, we have $-(k-1) <= r'-r <= k-1$. The only multiple of $k$ in this range is $0$, so $r' = r$ and hence $q' = q$.
]

== #ponder("number-theory.euclids-algorithm")[Euclid's Algorithm]

#table(
  columns: (auto, 1fr, 1fr),
  [*INPUT*], [$a,b$], [$a=372 quad b=162$],
  [*STEP 1*], [$a = q_1 b + r_1$ with $q_1, r_1 in ZZ, 0<=r_1<=b-1$], [$372 = 2 times 162 + 48$],
  [*STEP 2*], [$b = q_2 r_1 + r_2$ with $0<=r_2<=r_1-1$], [$162 = 3 times 48 + 18$],
  [*STEP 3*], [$r_1 = q_3 r_2 + r_3$ with $0<=r_3<=r_2-1$], [$48 = 2 times 18 + 12$],
  [*STEP $n$*], [$r_(n-2) = q_n r_(n-1) + r_n$ with $0<=r_n<=r_(n-1)-1$], [$18 = 1 times 12 + 6$],
  [*STEP $n+1$*], [$r_(n-1) = q_(n+1) r_n + r_(n+1)$ with $r_(n+1) = 0$], [$12 = 2 times 6 + 0$],
  [*OUTPUT*], [$r_n$], [$6$],
)

Note that the algorithm terminates in $n < b$ steps, since $b > r_1 > r_2 > ... > r_n > 0$.

#theorem[
  The output of #ponder("number-theory.euclids-algorithm")[Euclid's algorithm] with input $(a, b)$ is $gcd(a, b)$.
] <thm-euclid-algorithm>

#proof[

  1. We have $r_n divides r_(n-1)$ as $r_(n-1) = q_(n+1) r_n + 0$. Back-substituting, we get $r_n$ divides $r_(n-2)$, and continuing inductively, we find that $r_n$ divides both $a$ and $b$.

  2. Given $d$ such that $d divides a$ and $d divides b$. Thence we have $d divides r_1$ as $r_1 = a - q_1 b$. Back-substituting, we get $d$ divides $r_2$, and continuing inductively, we find that $d$ divides $r_n$.
]

#example[
  We want $gcd(87, 52)$. We run #ponder("number-theory.euclids-algorithm")[Euclid's algorithm]:
  $
    87 & = 1  & times & 52 & + & 35 \
    52 & = 1  & times & 35 & + & 17 \
    35 & = 2  & times & 17 & + & 1 \
    17 & = 17 & times & 1  & + & 0
  $
  The answer is the last non-zero remainder. Thus, $gcd(87, 52) = 1$.
]

#lecture-separator(lecture: 10, date: "2025-10-30")

#remark[
  When $gcd(a, b) = 1$, we say that $a$ and $b$ are *coprime*.
]

We can reverse the steps of #ponder("number-theory.euclids-algorithm")[Euclid's algorithm] to express the #ponder("number-theory.highest-common-factor")[highest common factor] as a linear combination of $a$ and $b$.

#example[
  Continuing from the previous example, we have
  $
    1 & = 35 - 2 times 17 \
      & = 35 - 2 times (52 - 1 times 35) \
      & = 3 times 35 - 2 times 52 \
      & = 3 times (87 - 1 times 52) - 2 times 52 \
      & = 3 times 87 - 5 times 52
  $
  Thus, we have expressed $gcd(87, 52) = 1$ as a linear combination of $87$ and $52$.
]

This reversal procedure leads to the following important result.

#theorem[Bézout's theorem][
  Given $a, b in NN$, there exist $x, y in ZZ$ such that $gcd(a, b) = a x + b y$. _i.e._ we can write the #ponder("number-theory.highest-common-factor")[highest common factor] of $a$ and $b$ as a linear combination of $a$ and $b$.
] <thm-bezout>

#prooflike[Proof 1][
  We can run #ponder("number-theory.euclids-algorithm")[Euclid's algorithm] with inputs $a, b$ to obtain an output $r_n$. Then we have $r_n = x r_(n-1) + y r_(n-2)$ for some $x, y in ZZ$.

  But from step $n-1$ we see that $r_(n-1)$ is expressible as a linear combination of $r_(n-2)$ and $r_(n-3)$. Substituting this into the previous equation, we can express $r_n$ as a linear combination of $r_(n-2)$ and $r_(n-3)$. Continuing inductively, we can write, for some $x, y in ZZ$,
  $
    r_n = x r_i + y r_(i-1)
  $
  for all $1 <= i <= n-1$. In particular,
  $
    r_n = x b + y a.
  $
  for some $x, y in ZZ$, by step 1 and 2.
]

#remark[
  #ponder("number-theory.euclids-algorithm")[Euclid's algorithm] does not only #ponder("set-theory.proof")[prove] the existsence of such $x, y$, but also provides a method to compute them.
]

#prooflike[Proof 2][
  Let $h$ be the least positive linear combination of $a$ and $b$, _i.e._ the smallest positive integer of the form $h = a x + b y$ for some $x, y in ZZ$. We will show that $h = gcd(a, b)$. We shall #ponder("set-theory.proof")[prove] the two conditions in @def-hcf.

  To show (2), observe that given $d$ such that $d divides a$ and $d divides b$, we have $d divides a x + b y$ for all $x, y in ZZ$. In particular, $d divides h$.

  To show (1), suppose that $h divides.not a$. Then we can write $a = q h + r$ for some $q, r in ZZ$ ans $0 < r < h$. Hence $r = a - q h = a - q (x a + y b)$ is also a positive linear combination of $a$ and $b$, contradicting the minimality of $h$. Thus, $h divides a$. Similarly, we can show that $h divides b$.

  Therefore, $h = gcd(a, b)$.
]

#remark[
  Proof 2 tells us that $gcd(a, b)$ exists and is a linear combination of $a$ and $b$, but it gives no method to compute it.
]

#example[
  Consider whether we have integer solutions to the equation $ 87 x + 52 y = 33. $ Since $gcd(87, 52) = 1$ divides $33$, by #ponder("number-theory.bezouts-theorem")[Bézout's identity], we can write $87 x' + 52 y' = 1$ for some $x', y' in ZZ$, and thus $87 (33 x') + 52 (33 y') = 33$. Therefore, integer solutions do exist.
]

#corollary[Bézout's identity, continued][
  Let $a, b in NN$. Then the equation $a x + b y = c$ has a solution with $x, y in ZZ$ if and only if $gcd(a, b) divides c$.
] <cor-bezout-solvability>

#proof[

  #fade[[$=>$]] Let $h = gcd(a, b)$. Suppose that there are $x, y in ZZ$ such that $a x + b y = c$. Since $h divides a$ and $h divides b$, we have $h divides (a x + b y) = c$.

  #fade[[$arrow.double.l$]] Conversely, suppose $h divides c$. By #ponder("number-theory.bezouts-theorem")[Bézout's identity], there exist $x', y' in ZZ$ such that $a x' + b y' = h$. Thus, $a ( (c)/(h) x') + b (c/h y') = c$, giving a solution.
]

Recall @prop-euclid-lemma. We shall now #ponder("set-theory.proof")[prove] it.


#proof[
  #fade[[For @prop-euclid-lemma]]

  Suppose $p divides a b$ but $p divides.not a$. We wish to show that $p divides b$. Since $p$ is prime and $p divides.not a$, we have $gcd(p, a) = 1$. By #ponder("number-theory.bezouts-theorem")[Bézout's identity], there exist $x, y in ZZ$ such that $p x + a y = 1$. Multiplying both sides by $b$, we get $p (x b) + a (y b) = b$. Since $p divides a b$ and $p divides p x b$, we have $p divides b$.

  The other case is similar.
]

#remark[

  1. Similarly $p divides a_1 a_2 ... a_n => p divides a_i$ for some $i = 1,2, ..., n$, by induction on $n$.

  2. The #ponder("set-theory.statement")[statement] is false if $p$ is not #ponder("number-theory.prime-composite-numbers")[prime]. For example, $6 divides 2 times 3$, but $6 divides.not 2$ and $6 divides.not 3$.
]

#theorem[Fundamental theorem of arithmetic][
  Every natural number $n >= 2$ can be written uniquely (up to ordering) as a product of #ponder("number-theory.prime-composite-numbers")[primes].
] <thm-fundamental-arithmetic>

#proof[
  The #ponder("number-theory.prime-factorisation-existence")[existence of factorisation] follows from @prop-factorisation. To show uniqueness, we will use induction on $n$.

  *Base case.* The #ponder("set-theory.statement")[statement] is true for $n=2$.

  *Inductive step.* Let $n>2$ and suppose the statement holds for all natural numbers $2 <= k <= n-1$. Suppose that $n = p_1p_2...p_k = q_1q_2...q_l$ where $p_i, q_j$  are all #ponder("number-theory.prime-composite-numbers")[primes]. We want to #ponder("set-theory.proof")[prove] that $k = l$ and, after reordering, $p_i = q_i$ for all $1 <= i <= k$.

  Hence $p_1 | n = q_1...q_l$. By @prop-euclid-lemma, $p_1 | q_j$ for some $1 <= j <= l$. Since $q_j$ is #ponder("number-theory.prime-composite-numbers")[prime], we have $p_1 = q_j$. Without loss of generality, let $j=1$. Cancelling $p_1 = q_1$ from both sides, we get $p_2...p_k = q_2...q_l$, which is a natural number less than $n$. By the inductive hypothesis, we have $k-1 = l-1$ and, after reordering, $p_i = q_i$ for all $2 <= i <= k$. Thus, the result holds for $n$.
]

#lecture-separator(lecture: 11, date: "2025-11-01")

#remark[
  There are "arithmetic systems" (permitting $+$ and $times$) in which factorisation is not unique.
]

#example[
  Consider $ZZ[sqrt(-3) ]$, which is the set of all numbers of the form $a + b (sqrt(-3))$ where $a, b in ZZ$. We can define addition and multiplication as usual. For example,
  $
         (1 + sqrt(-3)) + (1- sqrt(-3)) & = 2 + 0 = 2 \
    (1 + sqrt(-3)) times (1 - sqrt(-3)) & = 1 - (-3) = 4.
  $

  In $ZZ[sqrt(-3) ]$ we can define what it means to be a "#ponder("number-theory.prime-composite-numbers")[prime]", and both $1 plus.minus sqrt(-3)$ happens to be #ponder("number-theory.prime-composite-numbers")[primes] in this sense. However, we can also write $4$ as $4 = 2 times 2$, so the factorisation is not unique.
]


We shall consider some applications of the #ponder("number-theory.fundamental-theorem-of-arithmetic")[fundamental theorem of arithmetic].

1. The factors of $n = 2^3 dot 3^7 dot 11$ are all numbers of the form $2^a 3^b 11^c$ where $0 <= a <= 3$, $0 <= b <= 7$ and $0 <= c <= 1$. We can show that there are others: if, for example, $7 divides n$, then we would have a factorisation of $n$ involving $7$, contradicting the uniqueness of factorisation.

  More generally, the factors of $n = p_1^(a_1) p_2^(a_2) ... p_k^(a_k)$ are all numbers of the form $p_1^(b_1) p_2^(b_2) ... p_k^(b_k)$ where $0 <= b_i <= a_i$ for all $1 <= i <= k$.

2. The common factors of $2^3 dot 3^7 dot 5 dot 11^3$ and $2^4 dot 3^2 dot 11 dot 13$ are all numbers of the form $2^a 3^b 11^c$ where $0 <= a <= 3$, $0 <= b <= 2$ and $0 <= c <= 1$. Thus, the #ponder("number-theory.highest-common-factor")[highest common factor] is $2^3 dot 3^2 dot 11$.

  More generally, if $a = p_1^(a_1) p_2^(a_2) ... p_k^(a_k)$ and $b = p_1^(b_1) p_2^(b_2) ... p_k^(b_k)$ with $a_i, b_i >= 0$ for all $1 <= i <= k$, then $gcd(a, b) = p_1^(min(a_1, b_1)) p_2^(min(a_2, b_2)) ... p_k^(min(a_k, b_k))$.

3. The common multiples of $2^3 dot 3^7 dot 5 dot 11^3$ and $2^4 dot 3^2 dot 11 dot 13$ are all numbers of the form $2^a 3^b 5^c 11^d 13^e k$ where $a >= 4$, $b >= 7$, $c >= 1$, $d >= 3$, $e >= 1$ and $k$ is any integer. Thus, the lowest common multiple is $2^4 dot 3^7 dot 5 dot 11^3 dot 13$.

  More generally, if $a = p_1^(a_1) p_2^(a_2) ... p_k^(a_k)$ and $b = p_1^(b_1) p_2^(b_2) ... p_k^(b_k)$ with $a_i, b_i >= 0$ for all $1 <= i <= k$, then $lcm(a, b) = p_1^(max(a_1, b_1)) p_2^(max(a_2, b_2)) ... p_k^(max(a_k, b_k))$.

4. We have another proof of #ponder("number-theory.infinitude-of-primes")[infinite prime numbers] due to Erdös.

  #proof[
    Let $p_1, p_2, ..., p_k$ be all the #ponder("number-theory.prime-composite-numbers")[primes]. Since any number is uniquely expressed as a product of #ponder("number-theory.prime-composite-numbers")[primes], consider $p_1^(j_1) p_2^(j_2) ... p_k^(j_k)$ where $j_i >= 0$ for all $1 <= i <= k$.

    We can rewrite this in the following form:

    $
      p_1^(j_1) p_2^(j_2) ... p_k^(j_k) = m^2 times p_1^(i_1) p_2^(i_2) ... p_k^(i_k)
    $
    where $i_i in {0, 1}$ for all $1 <= i <= k$, and $m$ is some integer.

    Let $N in NN$. Given a number less than or equal to $N$ in the form above, we must have $m <= sqrt(N)$, so there are at most $sqrt(N) 2^k$ numbers of the form less than or equal to $N$.

    If $N > sqrt(N) 2^k$, _i.e._ $N > 4^k$, there must be a number less than or equal to $N$ that is not of the form above. So this number must have a #ponder("number-theory.prime-composite-numbers")[prime] factor not in the list $p_1, p_2, ..., p_k$, giving a contradiction.
  ]

  Note that Euclid's proof tells us that the $k$th #ponder("number-theory.prime-composite-numbers")[prime] is $< 2^(2^k)$ whereas Erdös' proof tells us that the $k$th #ponder("number-theory.prime-composite-numbers")[prime] is $< 4^k$. In fact, we know that the $k$th #ponder("number-theory.prime-composite-numbers")[prime] is approximately $k log k$ for large $k$ (the prime number theorem), which is a much stronger result.

== #ponder("number-theory.integer-modulo-n")[Modular Arithmetic]

#definition[Integer Modulo $n$][
  Let $n >= 2$ be a natural number. Then the *#ponder("number-theory.integer-modulo-n")[integer modulo] $n$*, denoted $ZZ_n$ or $ZZ\/n ZZ$, is the set of integers with two integers regarded as the same if they differ by a multiple of $n$. More precisely, we say that $a, b in ZZ$ are #ponder("number-theory.integer-modulo-n")[congruent modulo] $n$, written $a equiv b mod n$, if $n divides (a - b)$.
] <def-integers-modulo-n>

We have $x equiv y mod n <=> n divides x - y <=> x = y + k n$ for some $k in ZZ$.

Note that we can view $ZZ_n$ as a circular loop of integers $0, 1, 2, ..., n-1$, where after $n-1$ we return to $0$.

#remark[
  If $a equiv a' mod n$ and $b equiv b' mod n$ then $n divides (a - a') + (b - b')$ so $a + b equiv a' + b' mod n$. Similarly, $a b equiv a' b' mod n$.
]

#example[
  Consider whether $2a^2 + 3b^3 = 1$ has a solution with $a, b in ZZ$. If there is a solution, then $2a^2 equiv 1 mod 3$ , but $2a^2$ can only be $0$ or $2$ modulo $3$ since $a^2 equiv 0$ or $1$ mod $3$. Thus, there are no integer solutions.
]


#lecture-separator(lecture: 12, date: "2025-11-04")

== Solving Congruences

We cannot divide both sides of a #ponder("number-theory.integer-modulo-n")[congruence] by an integer in general. Thus, we need other methods to solve #ponder("number-theory.integer-modulo-n")[congruences].

#example[
  Consider the equation $7x equiv 2 mod 10.$

  Note that $3 dot 7 equiv 1 mod 10$, so $3 dot 7x equiv 3 dot 2 mod 10$, and so $x equiv 6 mod 10$ since $3 dot 7 equiv 1 mod 10$.
]

#definition[Inverse and Unit Modulo $n$][
  Given $a, b in ZZ$, we say that $b$ is an *#ponder("number-theory.unit-modulo-n")[inverse of] $a$ modulo $n$* if $a b equiv 1 mod n$.

  We say that $a$ is *#ponder("number-theory.unit-modulo-n")[invertible modulo] $n$*, or that $a$ is a *#ponder("number-theory.unit-modulo-n")[unit]* modulo $n$, if such a $b$ exists.
] <def-unit-modulo-n>

#example[
  In $ZZ_(10)$, $3$ is an inverse of $7$. Hence, both $3$ and $7$ are #ponder("number-theory.unit-modulo-n")[units modulo] $10$.

  But $4$ is not a #ponder("number-theory.unit-modulo-n")[unit modulo] $10$ since there is no integer $b$ such that $4 b equiv 1 mod 10$.
]

#remark[
  If $a$ is a #ponder("number-theory.unit-modulo-n")[unit modulo] $n$, then

  1. its inverse is unique: suppose $exists b, b'$ such that $a b equiv a b' equiv 1 mod n$. Then
    $ b equiv b (a b) equiv b (a b') equiv (b a) b' equiv b. $

  2. We can write $a^(-1)$ for its inverse.

  3. If $a b equiv a c mod n$, then $b equiv c mod n$. _i.e._ we can #ponder("number-theory.unit-modulo-n")[cancel units], by multiplying both sides by their inverses.

    #important[
      This is not true in general. Consider $4 dot 3 equiv 4 dot 8 mod 10$. Certainly $3 equiv.not 8 mod 10$.
    ]
]

#proposition[
  Let $p$ be #ponder("number-theory.prime-composite-numbers")[prime]. Then every $a equiv.not 0 mod p$ is a #ponder("number-theory.unit-modulo-n")[unit modulo] $p$.
]

#proof[
  We have $gcd(a, p) = 1$. By @thm-bezout (#ponder("number-theory.bezouts-theorem")[Bézout's theorem]), there exist $x, y in ZZ$ such that $a x + p y = 1$. Thus, $a x equiv 1 mod p$, so $x$ is an #ponder("number-theory.unit-modulo-n")[inverse of] $a$ modulo $p$.
]

We can rephrase this proposition more generally.

#proposition[
  Let $n >= 2$. Then $a$ is a #ponder("number-theory.unit-modulo-n")[unit modulo] $n$ if and only if $gcd(a, n) = 1$.
]

#proof[
  $
    gcd(a, n) = 1 & <=> a x + n y = 1 quad "for some" x, y in ZZ \
                  & <=> a x equiv 1 mod n \
                  & <=> a "is a unit modulo" n.
  $
]

#corollary[
  If $gcd(a, n) = 1$, then the #ponder("number-theory.integer-modulo-n")[congruence] $a x equiv b mod n$ has a unique solution. In particular, if $gcd(a, n) = 1$, there is a unique inverse of $a$ modulo $n$.
]

#example[Diophantine equations][
  Consider whether "New Year's Day" can fall on any day of the week in a year. #fade[[Assume a year has 365 days and a week has 7 days.]]

  Since $gcd(365, 7) = 1$, so if we put "New Year's Day" as day 0, and our week has 7 days in it, then we need to solve
  $ 7 x + k = 365 y. $ _i.e._ $365 x equiv k mod 7$, which has a unique solution for all $k in {0, 1, 2, 3, 4, 5, 6}$. Thus, "New Year's Day" can fall on any day of the week.
]

We shall now consider equations of the form $a x equiv b mod n$ with $gcd(a, n) != 1$, say $gcd(a, n) = d > 1$.

#proposition[
  If $gcd(a, n) = d > 1$, the #ponder("number-theory.integer-modulo-n")[congruence] $a x equiv b mod n$ has no solution if $d divides.not b$, and otherwise the solutions are exactly $a / d x equiv b / d mod n / d$.
]

#proof[
  Suppose $a x equiv b mod n$. Then $n divides a x - b$, and so $d divides a x - b$ and $d divides a$. So if there is a solution, we must have $d divides b$.

  Conversely, if $d divides b$, then $n = d dot n'$, $a = d dot a'$, and $b = d dot b'$, and the equation is

  $
    a x equiv b mod n & <=> a x - b = k n quad "for some" k in ZZ \
                      & <=> d a'x - d b' = k d n' \
                      & <=> a' x - b' = k n' \
                      & <=> a' x equiv b' mod n'.
  $

  Note that $gcd(a', n') = 1$. Thus, by the previous corollary, there is a unique solution modulo $n'$ to this equation.

  So if $gcd(a, n) = d > 1$, the #ponder("number-theory.integer-modulo-n")[congruence] $a x equiv b mod n$ has no solution if $d divides.not b$, and otherwise the solutions are exactly $a / d x equiv b / d mod n / d$.
]

#example[
  1. Consider the equation $7x equiv 4 mod 30$. Hence $gcd(7, 30) = 1$, so by #ponder("number-theory.bezouts-theorem")[Bézout's theorem],
    $ 13 dot 7 - 3 dot 30 = 1. $

    Thus $13 dot 7 equiv 1 mod 30$, and thus $x equiv 13 dot 4 mod 30$.

    Let us check the uniqueness of the solution. Suppose $7 x' equiv 4 mod 30$. Then $7 (x - x') equiv 0 mod 30$. Since $gcd(7, 30) = 1$, $7$ is a #ponder("number-theory.unit-modulo-n")[unit modulo] $30$, and so $x equiv x' mod 30$.

    #prooflike[Short form][
      This might be helpful in tackling problems:
      $
        &     &        7x & equiv 4 mod 30 \
        & <=> & 13 dot 7x & equiv 13 dot 4 mod 30 quad "backwards implication since" 13 "is a unit" mod 30 \
        & <=> &         x & equiv 22 mod 30
      $
    ]

  2. Consider $10 x equiv 12 mod 34$:

    $
      10 x equiv 12 mod 34 & <=> 10x = 12 + 34 k quad "for some" k in ZZ \
                           & <=> 5 x = 6 + 17 k \
                           & <=> 5 x equiv 6 mod 17
    $
    ans so we reduce to the case of example (1).
]

== Solving Simultaneous Congruence

Consider this old Chinese problem:

#align(center)[
  _How many soldiers are there in Han Xin's army, if you let them parade in rows of 3, 2 are left; and if you let them parade in rows of 4, 1 is left?_
]

This is equivalent to solving the #ponder("number-theory.integer-modulo-n")[simultaneous congruences]
$
  cases(
    x & equiv 2 mod 3 & => x equiv 2\, 5\, 8\, ...,
    x & equiv 1 mod 4 & => x equiv 1\, 5\, 9\, ...
  )
$
so $x=5$ is a solution.

Now consider another case:

$
  cases(
    x & equiv 1 mod 4,
    x & equiv 2 mod 6
  )
$

This #ponder("number-theory.integer-modulo-n")[simultaneous congruence] has no solution since $x equiv 2 mod 6$ implies that $x$ is even, but $x equiv 1 mod 4$ implies that $x$ is odd.

Now let us consider the general case.

#theorem[Chinese remainder theorem][
  Let $m, n$ be coprime, and $a, b in ZZ$. Then there is a unique solution modulo $m n$ to the #ponder("number-theory.integer-modulo-n")[simultaneous congruences]
  $
    x & equiv a mod m, \
    x & equiv b mod n.
  $
  _i.e._ $y$ is another solution if and only if $x equiv y mod (m n)$.
]

#lecture-separator(lecture: 13, date: "2025-11-06")

#proof[

  #fade[[Existence.]] Since $gcd(m, n) = 1$, by #ponder("number-theory.bezouts-theorem")[Bézout's theorem], there exist $s, t in ZZ$ such that $s m + t n = 1$.

  Note that
  $
    s m & equiv 1 mod n quad & "and" quad t n & equiv 1 mod m \
    s m & equiv 0 mod m quad & "and" quad t n & equiv 0 mod n.
  $
  Hence $ x = a(t n) + b (s m) equiv a mod n equiv b mod m. $

  #fade[[Uniqueness.]] Suppose $y$ is another solution. _i.e._
  $
        & y equiv a mod m    &   quad "and" & quad y equiv b mod n \
    <=> & y equiv x mod m    &   quad "and" & quad y equiv x mod n \
    <=> & m divides y - x    &   quad "and" & quad n divides y - x \
    <=> & m n divides y - x  & quad "since" & quad gcd(m, n) = 1 \
    <=> & y equiv x mod m n.
  $
]

#remark[
  The #ponder("algebra.chinese-remainder-theorem")[Chinese remainder theorem] can be generalised to more than two moduli by induction.

  If $m_1, m_2, ..., m_k$ are pairwise coprime, then the #ponder("number-theory.integer-modulo-n")[simultaneous congruences]
  $
    x & equiv a_1 mod m_1, \
    x & equiv a_2 mod m_2, \
      & dots.v \
    x & equiv a_k mod m_k
  $
  has a unique solution modulo $m_1 m_2 ... m_k$.
]

== Prime Modular Arithmetic


#definition[Euler Totient Function][
  Let $m >= 2$ be a natural number.

  We denote by $phi(m)$ the number of integers $a$ with $1 <= a <= m$ such that $gcd(a, m) = 1$. That is, $phi(m)$ is counting the number of #ponder("number-theory.unit-modulo-n")[units modulo] $m$.

  $phi$ is called the *#ponder("algebra.euler-totient-function")[Euler totient function]*.
]

#example[
  1. $phi(9) = 6$

  2. When $p$ is #ponder("number-theory.prime-composite-numbers")[prime], $phi(p) = p - 1$, and $phi(p^2) = p^2 - p$.

  3. When $p, q$ are distinct #ponder("number-theory.prime-composite-numbers")[primes], we have $phi(p q) = p q - p - q + 1 = (p - 1)(q - 1)$, where we are counting the numbers not divisible by either $p$ or $q$.
]


We shall now consider the behaviour of an integer power modulo $n$.

#example[
  - Consider $2^n$ modulo $7$: $2^1 equiv 2$, $2^2 equiv 4$, $2^3 equiv 1$, $2^4 equiv 2$, and so on. We see that the powers of $2$ modulo $7$ are periodic with period $3$.

  - Consider $2^n$ modulo $11$: $2^1 equiv 2$, $2^2 equiv 4$, $2^3 equiv 8$, $2^4 equiv 5$, $2^5 equiv 10$, $2^6 equiv 9$, $2^7 equiv 7$, $2^8 equiv 3$, $2^9 equiv 6$, $2^10 equiv 1$, $2^11 equiv 2$, and so on. We see that the powers of $2$ modulo $11$ are periodic with period $10$.
]

#theorem[Fermat's Little Theorem][
  Let $p$ be a #ponder("number-theory.prime-composite-numbers")[prime]. Then $a^p equiv a mod p$ for all $a in ZZ$. Equivalently, $a^(p-1) equiv 1 mod p$ for all $a equiv.not 0 mod p$.
] <fermat-little-theorem>

#proof[
  If $a equiv.not 0 mod p$, then $a$ is a #ponder("number-theory.unit-modulo-n")[unit modulo] $p$. Thus $a x equiv a y mod p$ iff $x equiv y mod p$ by cancelling $a$.

  Hence the numbers $a, 2a, 3a, ..., (p-1)a$ are pairwise incongruent (distinct) modulo $p$, and they are not congruent to $0$ modulo $p$ either. Therefore, they must be congruent to $1, 2, 3, ..., (p-1)$ in some order modulo $p$. Hence
  $ a dot 2 a dot 3 a dot ... dot (p-1)a equiv (p-1)! mod p. $

  Equivalently,
  $ a^(p-1) (p-1)! equiv (p-1)! mod p. $

  Since $(p-1)!$ is a #ponder("number-theory.unit-modulo-n")[unit] $mod p$ #fade[[it is a prouct of #ponder("number-theory.unit-modulo-n")[units]]], we can cancel it to get $a^(p-1) equiv 1 mod p$.
]

We can generalise this to non-prime moduli.

#theorem[Fermat-Euler Theorem][
  Let $gcd(a, m) = 1$. Then $a^(phi(m)) equiv 1 mod m$.
] <fermat-euler-theorem>

#proof[
  Let $cal(U) = {x in ZZ: 0 < x < m, gcd(x, m) = 1}$ be the set of #ponder("number-theory.unit-modulo-n")[units modulo] $m$. Note that $|cal(U)| = phi(m)$. Label them $u_1, u_2, ..., u_phi(m)$. Then $a u_1, a u_2, ..., a u_phi(m)$ are all distinct and #ponder("number-theory.unit-modulo-n")[invertible modulo] $m$ #fade[[since $a$ is a #ponder("number-theory.unit-modulo-n")[unit]]], and hence they are $u_1, ..., u_phi(m)$ up to reordering. Thus,
  $ a u_1 dot a u_2 dot ... dot a u_phi(m) equiv u_1 dot u_2 dot ... dot u_phi(m) mod m. $
  Equivalently,
  $ a^(phi(m)) (u_1 dot u_2 dot ... dot u_phi(m)) equiv (u_1 dot u_2 dot ... dot u_phi(m)) mod m. $
  Since $u_1, u_2, ..., u_phi(m)$ are all #ponder("number-theory.unit-modulo-n")[units modulo] $m$, so is their product #fade[[it is a product of #ponder("number-theory.unit-modulo-n")[units]]]. Thus, we can cancel it to get $a^(phi(m)) equiv 1 mod m$.
]

Consider $(p-1)!$ modulo $p$ for a #ponder("number-theory.prime-composite-numbers")[prime] $p$.

#example[
  When $p=5$, we have $4! = 24 equiv -1 mod 5$.

  When $p=7$, we have $6! = 720 equiv -1 mod 7$.
]

#lemma[
  Let $p$ be a #ponder("number-theory.prime-composite-numbers")[prime]. Then $x^2 equiv 1 mod p <=> x equiv 1 mod p "or" x equiv -1 mod p$.
] <lem-quad-residue>

#remark[
  $p$ must be #ponder("number-theory.prime-composite-numbers")[prime] for this to hold. For example, $x^2 equiv 1 mod 8$ has solutions $x equiv 1, 3, 5, 7 mod 8$.
]

#proof[
  $
    x^2 equiv 1 mod p & <=> x^2 - 1 equiv 0 mod p \
                      & <=> (x - 1)(x + 1) equiv 0 mod p \
                      & <=> p divides (x - 1)(x + 1) \
                      & <=> p divides (x - 1) "or" p divides (x + 1) \
                      & <=> x equiv 1 mod p "or" x equiv -1 mod p.
  $
]

#remark[
  More generally, a non-zero polynomial of degree $k$ over $ZZ_p$ has at most $k$ roots $mod p$.
]

#lecture-separator(lecture: 14, date: "2025-11-08")

#theorem[Wilson's Theorem][
  Let $p$ be a #ponder("number-theory.prime-composite-numbers")[prime]. Then $(p-1)! equiv -1 mod p$.
] <thm-wilsons-theorem>

#proof[
  As an edge case, this is true for $p=2$. Let us assume $p >= 3$ from now on.

  Note that the #ponder("number-theory.unit-modulo-n")[units modulo] $p$ become in pairs where each pair multiplies to $1$ modulo $p$, together with some elements that are self-inverse, _i.e._ $x$ such that $x^2 equiv 1 mod p$.

  By @lem-quad-residue, the only self-inverse elements are $1$ and $p-1$. Thus the remaining $p-3$ units of $ZZ_p$ come in inverse pairs. Hence,
  $
    (p-1)! & equiv 1 times (p-1) times ("pairs that multiply to" 1) \
           & equiv (p-1) \
           & equiv -1 mod p.
  $
]

We may wonder if $-1$ is a square modulo $p$ for some #ponder("number-theory.prime-composite-numbers")[prime] $p$.

#example[
  When $p=5$, we have $2^2 equiv -1 mod 5$.

  When $p=7$, there is no integer $x$ such that $x^2 equiv -1 mod 7$.

  When $p=13$, we have $5^2 equiv -1 mod 13$.

  When $p=19$, there is no integer $x$ such that $x^2 equiv -1 mod 19$.
]

#proposition[
  Let $p$ be an odd #ponder("number-theory.prime-composite-numbers")[prime]. Then $-1$ is a square modulo $p$ if and only if $p equiv 1 mod 4$.
] <prop-minus-one-square>

#proof[

  #fade[[$arrow.double.l$]] Suppose $p equiv 1 mod 4$. By #ponder("number-theory.wilsons-theorem")[Wilson's theorem], we have
  $
    - 1 equiv (p-1)! & equiv 1 dot 2 dot 3 dot ... dot (p-1)/2 dot (p+1)/2 dot ... dot (p-3) dot (p-2) dot (p-1) mod p \
                     & equiv 1 dot 2 dot 3 dot ... dot (p-1)/2 dot (- (p-1)/2) dot ... dot -3 dot -2 dot -1 mod p \
                     & equiv (-1)^((p-1)/2) [((p-1)/2)!]^2 \
                     & equiv [((p-1)/2)!]^2 mod p.
  $
  Since $p equiv 1 mod 4$, $p = 4 k + 1$ for some $k in NN$, so $(p-1)/2 = 2 k$ is even. Thus, $(-1)^((p-1)/2) = 1$. Hence, $-1$ is a square modulo $p$.

  #fade[[$=>$]] We shall #ponder("set-theory.proof")[prove] by contradiction on the contrapositive. Suppose on the other hand that $p equiv -1 mod 4$. #fade[[Note that for odd $p$, $p equiv -1 mod 4 <=> p equiv 3 mod 4$ and this is the only other choice other than $p equiv 1 mod 4$.]] If $-1$ were a square modulo $p$, _i.e._ if there were $z in ZZ$ such that $z^2 equiv -1 mod p$, then by #ponder("number-theory.fermats-little-theorem")[Fermat's little theorem] (@fermat-little-theorem), we would have
  $
    1 & equiv z^(p-1) mod p \
      & equiv z^(4k + 2) mod p \
      & equiv (z^2)^(2k + 1) mod p \
      & equiv (-1)^(2k + 1) mod p \
      & equiv -1 mod p. quad smash
  $
]

#remark[
  When $p equiv 1 mod 4$, #ponder("number-theory.wilsons-theorem")[Wilson's theorem] tells us a solution to $x^2 equiv -1 mod p$.
]

== Public Key Cryptography

#proposition[Fermat's Criterion [Non-Examinable]][
  When $a = 2$, #ponder("number-theory.fermats-little-theorem")[Fermat's little theorem] (@fermat-little-theorem) can be read as
  $
    2^p equiv 2 mod p.
  $
  Another way is to state that if $2^p mod p = 2$, then there is a good chance that $p$ is #ponder("number-theory.prime-composite-numbers")[prime]. If not, then $p$ is called a #ponder("number-theory.pseudoprime")[pseudoprime].

] <prop-fermats-criterion>

Let us agree to write messages as sequences of numbers, say $A -> 00$, $B -> 01$, ..., $Z -> 25$, $"space" -> 26$, $"full stop" -> 27$, $"comma" -> 28$, and so on. One (say, $A$) want to send secure messages in an encrypted form in such a way that the intended recipient can decrypt them easily, but an eavesdropper cannot.

We are going to use the RSA (Rivest-Shamir-Adleman) algorithm, which is based on #ponder("number-theory.integer-modulo-n")[modular arithmetic].

- To set up the encryption scheme,

  - $A$ thinks of two very large #ponder("number-theory.prime-composite-numbers")[primes] $p$ and $q$.

  - $A$ lets $n = p q$ and computes the *encoding exponent* $e$ which is coprime to the *#ponder("algebra.euler-totient-function")[Euler totient]* $phi(n) = (p-1)(q-1)$.

  - $A$ makes $(n, e)$ public (this is the *public key* or *encryption scheme*).

- To send $A$ an encrypted message,

  - $B$ slices the messages into blocks of numbers less than $n$.

  - $B$ encodes each block $m$ as $c equiv m^e mod n$ (the *ciphertext*). This can be computed efficiently using repeated squaring.

  - $B$ sends the ciphertext $c$ to $A$.

- To decrypt the message,

  - $A$ computes the *decoding exponent* $d$ such that $e d equiv 1 mod phi(n)$ (this can be done using the #ponder("number-theory.euclids-algorithm")[Euclidean algorithm]). This step requires knowledge of $phi(n)$, which in turn requires knowledge of $p$ and $q$ for computation within reasonable time.

  - $A$ computes $(m^e)^d = m^(k phi(n) + 1)$ for some $k in ZZ$. By #ponder("algebra.fermat-euler-theorem")[Fermat-Euler theorem] (@fermat-euler-theorem), we have $m^(k phi(n)) equiv 1 mod n$ since $gcd(m, n) = 1$ if $m < n$. Thus, $m^(k phi(n) + 1) equiv m mod n$.

#remark[
  Finding $phi(n)$ without knowing $p$ and $q$ is equivalent to factoring $n$ into $p$ and $q$, which is believed to be hard for classical computers on large $n$. This is what makes RSA secure.

  It is unknown whether there are efficient algorithms for factoring large integers on quantum computers. If such algorithms exist, they would compromise the security of RSA.
]

