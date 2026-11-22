// Methods: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/physica:0.9.8": *

// The Fourier transform: ftrans (or ftrans()) is the bare operator, ftrans(x)
// names the variable it integrates out, and ftrans(x, lambda) also names the
// new one.
#let ftrans(..vars) = {
  let vars = vars.pos()
  assert(vars.len() <= 2, message: "ftrans takes at most two variables")
  if vars.len() == 0 { $cal(F)$ }
  else if vars.len() == 1 { $cal(F)_#vars.first()$ }
  else { $cal(F)_(#vars.at(0) -> #vars.at(1))$ }
}

// Show rules for the notation above; the prelude's `chapter` applies them to
// every chapter. A bare `ftrans` is the function itself, which Typst prints as
// its name in inline code, so the first rule prints the operator instead. The
// operator would keep the code span's size, font and font features, so the
// second rule gives it those of the equation around it. Footnotes, the table of
// contents and PDF bookmarks are laid out outside the chapter, where these rules
// do not reach and a bare `ftrans` prints as code, so headings and footnotes
// write `ftrans()`.
#let notation-rules(body) = {
  let bare = raw.where(lang: "typc", text: "ftrans")
  show bare: ftrans()
  show math.equation: it => context {
    show bare: set text(size: text.size, font: text.font, features: text.features)
    it
  }
  body
}
