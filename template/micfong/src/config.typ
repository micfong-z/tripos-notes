// Compile-time configuration, driven by `--input` flags:
//
//   --input theme=light|dark       colour scheme                 (default light)
//   --input font=sans|serif        main-content font suite       (default sans)
//   --input meta-font=sans|serif   covers, headers and footers   (default: as font)
//
// A layout's `font` and `meta-font` parameters override the two font inputs;
// the inputs only apply where a document leaves those parameters out.
//
// Read at module scope rather than inside `context`, because `set` rules and
// the `colors` dictionary every element closes over need plain values.

#import "tokens.typ": color-tokens
#import "fonts.typ": font-suites

#let theme = sys.inputs.at("theme", default: "light")
#assert(theme in ("light", "dark"), message: "theme must be light or dark, got " + theme)

#let _suite-input(key) = {
  let value = sys.inputs.at(key, default: none)
  assert(value in (none, "sans", "serif"), message: key + " must be sans or serif, got " + repr(value))
  value
}

/// The `--input font` suite (sans when unset); a document may override it.
#let font = { let f = _suite-input("font"); if f == none { "sans" } else { f } }
#let _meta-font-input = _suite-input("meta-font")

/// The suites a document uses: `(body: ..., meta: ...)`. Each parameter wins
/// over its `--input`; the meta suite falls back to the body suite.
#let resolve-fonts(font: auto, meta-font: auto) = {
  for (key, value) in (("font", font), ("meta-font", meta-font)) {
    assert(value in (auto, "sans", "serif"), message: key + " must be auto, sans or serif, got " + repr(value))
  }
  let body = if font != auto { font } else { _suite-input("font") }
  if body == none { body = "sans" }
  let meta = if meta-font != auto { meta-font } else if _meta-font-input != none { _meta-font-input } else { body }
  (body: body, meta: meta)
}

#let mds-token = sys.inputs.at("mds-token", default: none)
#assert(
  mds-token == none or mds-token.match(regex("^[0-9A-HJKMNP-TV-Z]{4}$")) != none,
  message: "mds-token must be 4 Crockford base32 characters, got " + repr(mds-token),
)

/// The MDS rendition of a build: `theme-font` (`light-serif`), or
/// `theme-body-meta` (`light-serif-sans`) when the meta parts use another suite.
#let rendition(fonts) = (
  theme + "-" + fonts.body + if fonts.meta != fonts.body { "-" + fonts.meta } else { "" }
)

/// The rendition the `--input` flags alone would give.
#let mds-rendition = rendition(resolve-fonts())

#let colors = color-tokens(theme)
/// The `--input font` suite's definition; documents may use another.
#let fonts = font-suites.at(font)
#let is-dark = theme == "dark"
