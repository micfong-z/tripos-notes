// Font suites. A document picks one with `--input font=sans|serif`.
//
// Feature tags were checked against the vendored faces in `fonts/`. Typst
// silently ignores an unknown tag, so a font upgrade can drop a feature without
// any error; `just fonts-check` guards the families, and the showcase example
// prints `a g 0 1` in every suite so a regression is visible at a glance.
//
// Features fold down the tree: math and raw text inherit the body's tags unless
// they switch them off, which is why `reset` exists.

/// Code face, shared by both suites.
#let mono = "JetBrains Mono"

/// The wordmark and other identity marks stay in Plex Sans whatever the suite,
/// so the brand reads the same on a serif document.
#let brand = "IBM Plex Sans"

/// CJK fallback, used when a run contains Han characters.
#let cjk = "IBM Plex Sans SC"

#let font-suites = (
  // IBM Plex Sans 3.x + Lete Sans Math 0.62
  sans: (
    body: "IBM Plex Sans",
    // Zeros stay plain in every suite: a slashed zero is too close to the empty
    // set, ∅. Mono text keeps JetBrains Mono's own dotted zero.
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
