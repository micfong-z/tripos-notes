// The Micfong Colour System, transcribed from `Micfong Colour System.pdf`.
//
// Seven families, each a 0-1000 scale. 0 and 1000 are pure white and black in
// every family; 500 is the family's key colour. Look a swatch up by level:
//
//     palette.orange.at("500")   // #EC6F27
//
// Pages should not reach for these directly. Use the semantic tokens in
// `tokens.typ`, which pick the right level for the active theme.

#let _scale(..hex) = {
  let levels = ("0", "50", "100", "200", "300", "400", "500", "600", "700", "800", "900", "950", "1000")
  let values = hex.pos()
  assert(values.len() == levels.len(), message: "a scale needs 13 swatches")
  levels.zip(values.map(rgb)).to-dict()
}

#let palette = (
  gray: _scale(
    "#FFFFFF", "#F5F5F5", "#EEEEEE", "#E0E0E0", "#BDBDBD", "#9E9E9E", "#808080",
    "#757575", "#616161", "#424242", "#212121", "#131313", "#000000",
  ),
  red: _scale(
    "#FFFFFF", "#FFE3E3", "#FDD3D5", "#FAB2B9", "#F4949D", "#F05E6C", "#E43748",
    "#B22D39", "#8C242E", "#5B191F", "#360E12", "#22080A", "#000000",
  ),
  orange: _scale(
    "#FFFFFF", "#FFE7DA", "#FCD6C0", "#F9BC98", "#F6A373", "#F1884B", "#EC6F27",
    "#C75E1C", "#A14A13", "#632B08", "#3A1904", "#260F01", "#000000",
  ),
  yellow: _scale(
    "#FFFFFF", "#FFF4D5", "#FFEBB0", "#FFE38D", "#FFD65C", "#FFCC34", "#FFC107",
    "#CC960E", "#97700D", "#624309", "#352403", "#271A01", "#000000",
  ),
  green: _scale(
    "#FFFFFF", "#DBF7DC", "#C1ECC2", "#96E29E", "#6EDB86", "#2EBF57", "#14AE52",
    "#0D883E", "#08682F", "#054920", "#033015", "#01240F", "#000000",
  ),
  blue: _scale(
    "#FFFFFF", "#D9ECFF", "#BEDFFF", "#8FC7FF", "#54A9FD", "#3296FB", "#007AF5",
    "#0161C1", "#024BA0", "#003471", "#01244D", "#001637", "#000000",
  ),
  purple: _scale(
    "#FFFFFF", "#ECE1FF", "#DECBFF", "#C29EFF", "#AE7EFF", "#A06CFF", "#9154FF",
    "#6736C0", "#562DA4", "#391D70", "#291353", "#160633", "#000000",
  ),
)

/// The chromatic families, in the order the colour sheet lists them.
#let hues = ("red", "orange", "yellow", "green", "blue", "purple")
