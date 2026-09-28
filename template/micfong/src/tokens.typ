// Semantic colour tokens, one set per theme, built from the raw palette.
//
// Neutral tokens name a role (page, text, rule...). Each chromatic family
// resolves to four roles that mirror between themes:
//
//   strong   text and labels on a tinted ground   light 700 / dark 200
//   base     rules and accents                    500 in both
//   soft     title strips, highlighted fills      light 100 / dark 800
//   subtle   large quiet fills                    light  50 / dark 900
//
// `shade700`/`shade500`/`shade100`/`shade50` alias the same four, so code
// written against the Tripos notes template keeps working.

#import "palette.typ": hues, palette

#let _family(name, theme) = {
  let f = palette.at(name)
  let (strong, soft, subtle) = if theme == "light" { ("700", "100", "50") } else { ("200", "800", "900") }
  let roles = (strong: f.at(strong), base: f.at("500"), soft: f.at(soft), subtle: f.at(subtle))
  roles + (shade700: roles.strong, shade500: roles.base, shade100: roles.soft, shade50: roles.subtle)
}

#let _neutrals = (
  light: (
    page: "0",
    text: "1000",
    text-secondary: "400",
    border-light: "200",
    border-dark: "300",
    surface: "50", // code blocks, table headers
    surface-strong: "100", // inline code, keys
  ),
  dark: (
    page: "900",
    text: "0",
    text-secondary: "600",
    border-light: "800",
    border-dark: "700",
    surface: "950",
    surface-strong: "800",
  ),
)

// Syntax colours: a darker level on white, a lighter one on grey 900. The
// lighter hues (green, orange, yellow) need a step more weight in light mode.
#let _syntax-levels = (
  light: (red: "600", orange: "700", yellow: "700", green: "700", blue: "600", purple: "600", gray: "500"),
  dark: (red: "300", orange: "200", yellow: "200", green: "200", blue: "300", purple: "300", gray: "500"),
)

#let color-tokens(theme) = {
  let neutral = _neutrals.at(theme).pairs().map(((k, v)) => (k, palette.gray.at(v))).to-dict()
  let families = hues.map(h => (h, _family(h, theme))).to-dict()
  let syntax = _syntax-levels.at(theme).pairs().map(((k, v)) => (k, palette.at(k).at(v))).to-dict()
  (
    ..neutral,
    ..families,
    gray: palette.gray.at("500"),
    // Highlighter ink, under the lower half of the letters.
    highlight: palette.yellow.at(if theme == "light" { "300" } else { "700" }),
    // The brand mark colour, as on the old covers and the website.
    brand: palette.orange.at("500"),
    syntax: syntax,
  )
}
