Replacing $[a, b]$ by a subset of $RR$ that is not an interval can fail. Consider $f: QQ -> RR$ defined by
$
  f(x) = cases(
    0 quad & x^2 > 2,
    1 quad & x^2 < 2.
  )
$
By definition, $f$ is continuous and differentiable at every point of $QQ$, and $f' = 0$ on $QQ$. Yet $f$ is not constant on $QQ$: the missing point $sqrt(2)$ is exactly what the Mean Value Theorem needs in order to pass from $f' = 0$ to constancy.
