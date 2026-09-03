Write $g(Y) = EE[X mid(|) Y]$ with $g(y) = EE[X mid(|) Y=y]$. The claim is that $g(Y)$ is independent of $Z$:
$
  PP(g(Y)=w, Z=z) & = sum_(y in g^(-1)({w})) PP(Y=y, Z=z) \
                  & = sum_(y in g^(-1)({w})) PP(Y=y) PP(Z=z) quad "by independence" \
                  & = PP(g(Y)=w) PP(Z=z).
$
Since $g(Y)$ and $Z$ are independent, $EE[g(Y) mid(|) Z] = EE[g(Y)]$; by the tower property $EE[g(Y)] = EE[X]$. Hence
$
  EE[EE[X mid(|) Y] mid(|) Z] = EE[X].
$
