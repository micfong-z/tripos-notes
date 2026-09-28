// Material Design Icons (Pictogrammers), via the iconify package.
//
// `assets/mdi.json` is the Iconify collection from @iconify-json/mdi (Apache
// 2.0). Every layout calls `provide-icons` once, so `icon` works anywhere in a
// document built on one of them. Browse names at
// https://pictogrammers.com/library/mdi/ and drop the `mdi-` prefix:
//
//     #icon("github")            // mdi:github
//     #icon("mdi:github")        // the same
//     #icon("lucide:x")          // another collection, once provided

#import "@preview/iconify:0.5.3": icon-svg, provide-icons

#let mdi = json("../assets/mdi.json")

/// Load the MDI collection. Layouts do this; call it yourself only when using
/// `icon` in a document that does not use a layout.
#let use-icons = provide-icons(mdi)

/// An inline icon, one em tall by default, coloured like the surrounding text.
///
/// MDI glyphs sit on a 24-unit grid with 2 units of padding, so the box is
/// lowered by 14% of its height: the drawn shape then spans roughly the
/// baseline to just above cap height, like a capital letter.
#let icon(name, size: 1em, fill: auto) = {
  let full = if name.contains(":") { name } else { "mdi:" + name }
  let glyph = context box(
    baseline: 14%,
    image(bytes(icon-svg(full)), format: "svg", height: size),
  )
  if fill == auto { glyph } else { text(fill: fill, glyph) }
}
