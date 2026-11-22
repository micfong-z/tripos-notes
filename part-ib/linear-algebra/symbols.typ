// Linear Algebra: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/physica:0.9.8": *
#import "/template/illustrate.typ": *

#let teq = math.tilde.equiv
#let im = math.op("im")
#let ker = math.op("ker")
#let col = math.op("col")
#let colrank = math.op("colrank")
#let row = math.op("row")
#let rowrank = math.op("rowrank")
#let null = math.op("null")
#let Sym = math.op("Sym")
#let adj = math.op("adj")
#let span(content) = $lr(chevron.l #content chevron.r)$
#let lperp(content) = $attach(#content, tl: perp)$
#let rperp(content) = $#content^perp$