// Quantum Mechanics: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/physica:0.9.8": *

#let electron = $ee^(-)$
#let positron = $ee^(+)$
#let proton = $upright(p)^(+)$
#let photon = $upright(gamma)$
#let hilb = $cal(H)$

#let expt(content) = $lr(chevron.l #content chevron.r)$
