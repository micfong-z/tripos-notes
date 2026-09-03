// Font suites. Each export target picks one with `--input font=<name>`.
//
// Feature tags are verified to exist in the vendored faces under `fonts/`;
// Typst silently ignores an unknown tag, so a wrong font version is invisible
// at compile time. `just fonts-check` guards the versions.

#let mono = "JetBrains Mono"

#let font-suites = (
  // Inter v4.1 + Lete Sans Math v0.62
  sans: (
    body: "Inter",
    body-features: (
      "ss01": 1, // open digits
      "ss02": 1, // disambiguation, with slashed zero
      "tnum": 1, // tabular numbers
    ),
    math: "Lete Sans Math",
    math-features: (
      "ss04": 1, // slanted weak inequalities
      "cv01": 1, // horizontal bar on reduced Planck's constant
      "cv03": 1, // alternate epsilon shape
      "cv11": 1, // single storey g
      "cv13": 1, // disambiguation on l
      "cv14": 1, // slashed zero
    ),
  ),
  // IBM Plex Serif v3.006 + IBM Plex Math v1.000
  serif: (
    body: "IBM Plex Serif",
    body-features: (
      "zero": 1, // slashed zero
    ),
    math: "IBM Plex Math",
    math-features: (
      "zero": 1, // slashed zero
    ),
  ),
)
