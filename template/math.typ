// Maths shorthands shared by every course. Course-specific operators live in
// each course's `prelude.typ`, which may also shadow a name defined here
// (Groups redefines `im` as the image operator, for instance).

#let re = math.op("Re")
#let im = math.op("Im")
#let img = math.op("im")
#let ii = math.upright("i")
#let ppi = math.upright(sym.pi)
#let ee = math.upright("e")
#let eval(expr, size: 100%) = $lr(#expr|, size: #size)$
#let matbold(content) = math.upright(math.bold(content))
#let tp = sym.top
#let argmin = math.op("argmin", limits: true)
