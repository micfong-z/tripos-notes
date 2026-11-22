// Maths shorthands shared by every course: the design system's `maths` module,
// re-exported so chapters reach them without a second import. Course-specific
// operators live in each course's `symbols.typ`, which may also shadow a name
// defined here (Groups redefines `im` as the image operator, for instance).
//
// Vector, gradient and transpose notation is physica's, imported by the
// symbols.typ of each course that needs it: `vb`, `vu`, `grad`, `TT`,
// `vecrow`, `iprod`. Only what physica has no equivalent for lives here.

#import "config.typ": is-html
#import "micfong/src/maths.typ": argmax, argmin, ee, eval, ii, im, img, matbold, mathsec, ppi, re

/// A note beside one line of a display equation, usually the reason for a
/// step: `& = x #eq-note[by @eq-force-balance]`. It takes no width, so the
/// equation is centred and aligned as if it were absent, and every note ends at
/// the same x on the page, clear of the equation numbers. A line too long for
/// that sets its note 1em after the line instead. HTML has no page to measure,
/// so there the note just follows its line.
#let eq-note(body) = if is-html { h(2em) + body } else {
  context {
    let margin = page.margin.right
    let margin = if type(margin) == relative {
      margin.length.to-absolute() + margin.ratio * page.width
    } else { margin.to-absolute() }
    let edge = page.width - margin - measure([· 999]).width - 1em.to-absolute()
    let width = measure(body).width
    let shift = calc.max(edge - width - here().position().x, 1em.to-absolute())
    // Zero width exactly: spacing that cancels the note's measured width
    // leaves a rounding error, which moves the note and never converges.
    box(width: 0pt, align(left, move(dx: shift, box(width: width, body))))
  }
}
