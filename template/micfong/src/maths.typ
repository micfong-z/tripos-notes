// Maths shorthands, kept out of the top-level namespace because the names are
// short and easy to collide with. Opt in per document:
//
//     #import "@local/micfong:0.1.0": *
//     #import maths: *

#import "config.typ": colors

#let re = math.op("Re")
#let im = math.op("Im")
#let img = math.op("im")
#let ii = math.upright("i")
#let ppi = math.upright(sym.pi)
#let ee = math.upright("e")
#let eval(expr, size: 100%) = $lr(#expr|, size: #size)$
#let matbold(body) = math.upright(math.bold(body))
#let argmin = math.op("argmin", limits: true)
#let argmax = math.op("argmax", limits: true)

/// Structural maths in the secondary colour, e.g. brackets in a quantifier chain.
#let mathsec(x) = text(fill: colors.text-secondary, $#x$)
