If $X$ and $Y$ are independent discrete random variables,
$
  EE[X mid(|) Y] & = sum_y EE[X mid(|) Y=y] bb(1)(Y=y) \
                 & = sum_y bb(1)(Y=y) sum_x x PP(X=x mid(|) Y=y) \
                 & = sum_y bb(1)(Y=y) sum_x x PP(X=x) quad "by independence" \
                 & = sum_y bb(1)(Y=y) EE[X] \
                 & = EE[X].
$
