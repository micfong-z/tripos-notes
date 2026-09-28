// Micfong document system for Typst.
//
//     #import "@local/micfong:0.1.0": *
//     #show: article.with(title: "…", authors: "Micfong")
//
// Compile with the vendored fonts:
//
//     typst compile --font-path <this folder>/fonts --input theme=dark doc.typ
//
// See README.md for the full reference.

// Tokens
#import "src/config.typ": colors, font, fonts, is-dark, theme
#import "src/palette.typ": hues, palette
#import "src/fonts.typ": brand, mono

// Identity
#import "src/identity.typ": barcode, data-matrix, hex-id, wordmark
#import "src/icons.typ": icon, provide-icons, use-icons

// Layouts
#import "src/layouts.typ": article, book, chapter-summary, series, volume
#import "src/furniture.typ": contents

// Elements
#import "src/elements.typ": (
  badge, boxed, boxed-header, callout, caution, divider, end-of-document, fade, figure-required, important,
  invert-svg, kbd, note, panel, recolor-svg, separator, tip, warning,
)
#import "src/code.typ": code

// Mathematics
#import "src/theorems.typ": (
  axiom, claim, corollary, definition, example, exercise, law, lemma, notation, proof, prooflike, proposition,
  question, remark, remarklike, rule, theorem, theorem-env,
)
#import "src/maths.typ"
