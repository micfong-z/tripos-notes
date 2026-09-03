// Groups: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/fletcher:0.5.8" as fletcher

// The image operator. Shadows the shared `im` (the imaginary part), which this
// course never needs.
#let im = math.op("im")

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
#let nsub = math.lt.tri

#let fletcher-diagram(..args) = align(center, fletcher.diagram(
  edge-stroke: colors.text,
  ..args,
))
