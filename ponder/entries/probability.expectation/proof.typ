With $Omega$ countable, the identity $EE[sum_(k=1)^(oo) X_k] = sum_(k=1)^(oo) EE[X_k]$ for non-negative random variables follows by interchanging the sums:
$
  EE[sum_n X_n] & = sum_(omega in Omega) (sum_n X_n (omega)) dot PP({omega}) \
                & = sum_n sum_(omega in Omega) X_n (omega) PP({omega}) quad "since all terms are non-negative" \
                & = sum_n EE[X_n].
$
Non-negativity is what licenses the interchange: every partial sum of non-negative terms may be reordered freely.
