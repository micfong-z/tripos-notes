// Course notation available to tooltip summaries and supplemental sections.
//
// Fragments are course-independent: they compile against the shared template
// plus this file, never a single course's prelude. Any operator a summary uses
// therefore has to be declared here as well as in the course that owns it.
//
// physica supplies the vector notation (`vb`, `vu`, `grad`, `TT`, `vecrow`,
// `iprod`) that the courses import through their own symbols.typ. It also
// shadows the built-in `div` (the division sign) with the divergence operator,
// so a fragment wanting the sign has to reach for `std.sym.div`.
#import "@preview/physica:0.9.8": *

#let im = math.op("im")
#let ii = math.upright("i")
#let ppi = math.upright(sym.pi)
#let ee = math.upright("e")
#let sym = math.op("Sym")
#let isom = math.op("Isom")
#let stab = math.op("Stab")
#let ccl = math.op("ccl")
#let sign = math.op("sign")
#let fix = math.op("Fix")
#let GL = math.upright("GL")
#let SL = math.upright("SL")
#let SO = math.upright("SO")
#let teq = math.tilde.equiv
#let nsub = math.lt.closed
#let matbold(content) = math.upright(math.bold(content))

// Vectors and Matrices
#let rank = math.op("rank")
#let null = math.op("null")
#let span = math.op("span")
#let adj = math.op("adj")

// Probability. `sym` is shadowed above by the Sym operator, so these reach for
// the built-in symbol module explicitly.
#let cp = std.sym.complement
#let indep = std.sym.perp

// Numbers and Sets
#let indicator = math.bold([1])
