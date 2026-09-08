// Vectors and Matrices: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/physica:0.9.8": *

// `rank` comes from physica.
#let null = math.op("null")
#let span = math.op("span")
#let adj = math.op("adj")
#let SO = math.op("SO")
