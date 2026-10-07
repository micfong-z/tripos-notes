// Font suites. A document sets one for its main content and one for its meta
// parts (covers, headers, footers): see `resolve-fonts` in config.typ.
//
// Feature tags were checked against the vendored faces in `fonts/`. Typst
// silently ignores an unknown tag, so a font upgrade can drop a feature without
// any error; `just fonts-check` guards the families, and the showcase example
// prints `a g 0 1` in every suite so a regression is visible at a glance.
//
// Features fold down the tree: math, raw text and a nested suite inherit the
// tags around them unless they switch them off, which is why `reset` exists.

/// Code face, shared by both suites: Micfong's own Iosevka build (ss14 base,
/// slashed zero, normal width, so a 0.6em cell like JetBrains Mono's).
#let mono = "Iosevka Micfong"

/// Code size relative to the text around it. Iosevka Micfong's x-height is
/// 0.52em, so 0.95em gives code the optical size JetBrains Mono had at 0.9em.
#let mono-scale = 0.95

/// The wordmark and other identity marks stay in Plex Sans whatever the suite,
/// so the brand reads the same on a serif document.
#let brand = "IBM Plex Sans"

/// CJK fallback, used when a run contains Han characters.
#let cjk = "IBM Plex Sans SC"

#let font-suites = (
  // IBM Plex Sans 3.x + Lete Sans Math 0.62
  sans: (
    body: "IBM Plex Sans",
    // Zeros stay plain in both suites: a slashed zero is too close to the empty
    // set, ∅. Code keeps Iosevka Micfong's own slashed zero.
    body-features: (
      "ss01": 1, // single-storey a
      "ss02": 1, // single-storey g
      "tnum": 1, // tabular figures
    ),
    math: "Lete Sans Math",
    math-features: (
      "ss04": 1, // slanted weak inequalities
      "cv01": 1, // horizontal bar on reduced Planck's constant
      "cv03": 1, // alternate epsilon shape
      "cv11": 1, // single-storey g
      "cv12": 1, // disambiguated l
    ),
  ),
  // IBM Plex Serif 3.006 + IBM Plex Math 1.000
  serif: (
    body: "IBM Plex Serif",
    body-features: (:),
    math: "IBM Plex Math",
    math-features: (:),
  ),
)

/// A feature dictionary that switches off every tag in `features`, so a child
/// face does not inherit tags meant for the body.
#let reset(features) = features.keys().map(k => (k, 0)).to-dict()

/// Switches off every body tag of every suite. Text in one suite can sit inside
/// another (a sans cover on a serif document), so each suite starts clean.
#let reset-all = reset(font-suites.values().map(s => s.body-features).sum())

/// Typeset `body` in the named suite: its face, features and maths.
///
///     #in-suite("sans")[A sans aside in a serif document.]
#let in-suite(name, body) = {
  assert(name in font-suites, message: "font must be sans or serif, got " + repr(name))
  let suite = font-suites.at(name)
  set text(font: (suite.body, cjk), features: reset-all + suite.body-features)
  show math.equation: set text(font: suite.math, features: reset-all + suite.math-features)
  body
}
