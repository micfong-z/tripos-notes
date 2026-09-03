// Colour palette. Identical in every historical template copy; the active
// scheme is selected in config.typ from the `theme` input.

#let color-palette = (
  light: (
    text: black,
    page: white,
    border-light: rgb("#E0E0E0"),
    border-dark: rgb("#BDBDBD"),
    text-secondary: rgb("#9E9E9E"),
    orange: (
      shade700: rgb("#A14A13"),
      shade500: rgb("#EC6F27"),
      shade100: rgb("#FCD6C0"),
      shade50: rgb("#FFE7DA"),
    ),
    yellow: (
      shade700: rgb("#97700D"),
      shade500: rgb("#FFC107"),
      shade100: rgb("#FFEBB0"),
      shade50: rgb("#FFF4D5"),
    ),
    red: (
      shade700: rgb("#8C242E"),
      shade500: rgb("#E43748"),
      shade100: rgb("#FDD3D5"),
      shade50: rgb("#FFE3E3"),
    ),
    blue: (
      shade700: rgb("#024BA0"),
      shade500: rgb("#007AF5"),
      shade100: rgb("#BEDFFF"),
      shade50: rgb("#D9ECFF"),
    ),
    purple: (
      shade700: rgb("#562DA4"),
      shade500: rgb("#9154FF"),
      shade100: rgb("#DECBFF"),
      shade50: rgb("#ECE1FF"),
    ),
    gray: rgb("#808080"),
  ),
  dark: (
    text: white,
    page: rgb("212121"),
    border-light: rgb("#424242"),
    border-dark: rgb("#616161"),
    text-secondary: rgb("#757575"),
    orange: (
      shade700: rgb("#F9BC98"),
      shade500: rgb("#EC6F27"),
      shade100: rgb("#632B08"),
      shade50: rgb("#3A1904"),
    ),
    yellow: (
      shade700: rgb("#FFE38D"),
      shade500: rgb("#FFC107"),
      shade100: rgb("#624309"),
      shade50: rgb("#352403"),
    ),
    red: (
      shade700: rgb("#FAB2B9"),
      shade500: rgb("#E43748"),
      shade100: rgb("#5B191F"),
      shade50: rgb("#360E12"),
    ),
    blue: (
      shade700: rgb("#8FC7FF"),
      shade500: rgb("#007AF5"),
      shade100: rgb("#003471"),
      shade50: rgb("#01244D"),
    ),
    purple: (
      shade700: rgb("#C29EFF"),
      shade500: rgb("#9154FF"),
      shade100: rgb("#391D70"),
      shade50: rgb("#291353"),
    ),
    gray: rgb("#808080"),
  ),
)
