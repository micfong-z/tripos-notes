// The document wrapper. One definition serves all four PDF variants and the
// HTML export; the target-specific show rules are installed in separate
// branches so that `html.*` is only ever evaluated under `--features html`.

#import "@preview/tiaoma:0.3.0"
#import "@preview/ctheorems:1.1.3": *
#import "@preview/hydra:0.6.2": hydra
// equate 0.3.3 calls html.frame unconditionally, which is undefined without
// --features html; 0.3.2 is the paged-safe release. Both are imported and the
// target picks one, matching what the two old template families each used.
#import "@preview/equate:0.3.2": equate as equate-paged
#import "@preview/equate:0.3.3": equate as equate-html
#import "config.typ": apply-fonts, colors, is-html
#import "fonts.typ": mono

/// `D/ACD/UND/NTE/5-000A` -- the doc id plus the zero-padded hex page number.
/// Call from inside a `context` block; it needs the resolved page counter.
#let _hex-id(doc-id, page-number) = {
  let hex-page = upper(str(page-number, base: 16))
  doc-id + "-" + ("0" * calc.max(0, 4 - hex-page.len())) + hex-page
}

#let _data-matrix(payload) = box(
  tiaoma.data-matrix(
    payload,
    options: (fg-color: colors.text, bg-color: colors.page, show-hrt: false, scale: 0.5),
  ),
)

/// The default cover: an empty frame crossed by a diagonal rule.
#let _default-cover = [
  #block(height: 100% - 6em, width: 100%, stroke: colors.border-light + 0.75pt)[
    #line(start: (1em, 100% - 1em), end: (100% - 1em, 1em), stroke: colors.border-light + 0.75pt)
  ]
]

#let _outline-rules(body) = {
  set outline(indent: auto)
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  set outline.entry(fill: pad(bottom: 0.3em, x: 0.25em, line(
    length: 100%,
    stroke: (paint: colors.border-light, thickness: 0.75pt, dash: "densely-dashed"),
  )))
  show outline.entry.where(level: 1): set outline.entry(fill: pad(bottom: 0.3em, x: 0.25em, line(
    length: 100%,
    stroke: colors.border-dark + 0.75pt,
  )))
  body
}

/// Per-line numbering for multi-line aligned equations. Only courses that
/// actually reference equations turn this on.
#let _equation-numbering(body) = {
  let equate = if is-html { equate-html } else { equate-paged }
  show: equate.with(breakable: true, sub-numbering: false)
  set math.equation(
    numbering: (..nums) => text(
      "· "
        + str(nums.at(0))
        + (if nums.pos().len() > 1 { str.from-unicode(nums.at(1) - 1 + "α".to-unicode()) } else { "" }),
      fill: colors.text-secondary,
    ),
    supplement: it => text("Eq", fill: colors.text-secondary),
  )
  body
}

#let _html-body(body, numbered-equations) = {
  // The blank lines are load-bearing: they make Typst wrap the heading body in a
  // <p>, matching the HTML the website's CSS and the exporter were built against.
  show heading: it => [

    #html.elem("h" + str(calc.min(it.depth + 1, 6)))[

      #context {
        if counter(heading).get().first() != 0 {
          html.span(
            class: "typst-header-counter",
            text(fill: colors.text-secondary, counter(heading).display()),
          )
        }
      }
      #it.body
    ]
  ]

  set outline(indent: auto, title: none)
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }

  show math.equation.where(block: false): it => box(html.frame(it))
  show align: it => it.body

  // equate frames block equations itself; a second wrapper would break it.
  if numbered-equations {
    body
  } else {
    show math.equation.where(block: true): it => {
      html.div(class: "typst-full-equation", html.frame(it))
    }
    show grid: html.frame
    body
  }
}

#let _paged-body(body, title: "", lecturer: "", lectured-in: "", updated: "", doc-id: "", cover-design: auto) = {
  show: _outline-rules
  show link: it => underline(stroke: 0.75pt + colors.border-dark, it)

  set footnote.entry(separator: line(length: 30% + 0pt, stroke: 0.5pt + colors.border-light))
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 1.5cm, right: 1.5cm),
    fill: colors.page,
    header: context {
      let cur-page = counter(page).get().first()
      _data-matrix(_hex-id(doc-id, cur-page))
      h(1fr)
      if cur-page == 1 {
        text(size: 11pt, weight: "bold", "MICFONG ▲")
      } else {
        text(weight: 700, fill: colors.text-secondary, hydra(1, skip-starting: false))
      }
    }
      + line(length: 100%, stroke: colors.border-light + 0.75pt),
    footer: context {
      if counter(page).get().first() == 1 {
        box(
          tiaoma.code128(
            doc-id,
            options: (
              fg-color: colors.text,
              bg-color: colors.page,
              show-hrt: false,
              height: 10.0,
              scale: 0.5,
            ),
          ),
        )
        h(1fr)
        text(size: 11pt, fill: colors.text-secondary, font: mono, [*#doc-id*])
      } else {
        let elements = query(heading.where(level: 2).before(here()))
        if elements.len() >= 1 {
          let loc = elements.last().location()
          let section = numbering(elements.last().numbering, ..counter(heading).at(loc))
          text(fill: colors.text-secondary, section + elements.last().body)
        }
        h(1fr)
        counter(page).display("1")
      }
    },
  )

  [
    #box(text(1.75em, weight: 700, title))
    #h(1fr)
    #box(align(right)[
      *#lecturer*\
      #lectured-in\
      #updated
    ])

    #if cover-design == auto { _default-cover } else { cover-design }

    #pagebreak()

    #body
  ]
}

#let project(
  title: "New Document",
  authors: (),
  lecturer: "Dr Zoe Wyatt",
  lectured-in: "Michaelmas 2025",
  doc-id: "MET/TEM#1",
  updated: "",
  cover-design: auto,
  numbered-equations: false,
  body,
) = {
  show: thmrules
  show: apply-fonts

  set document(author: authors, title: title.replace("\n", " "))
  set heading(numbering: "1.1 ")
  set table(stroke: 0.75pt + colors.border-dark)

  show ref: it => {
    if it.element == none {
      text(fill: colors.red.shade500)[(?)]
    } else {
      it
    }
  }

  let inner = if is-html {
    _html-body(body, numbered-equations)
  } else {
    _paged-body(
      body,
      title: title,
      lecturer: lecturer,
      lectured-in: lectured-in,
      updated: updated,
      doc-id: doc-id,
      cover-design: cover-design,
    )
  }

  // A `show:` inside an `if` would only style that branch, so the equation
  // rules wrap the assembled document instead.
  if numbered-equations { _equation-numbering(inner) } else { inner }
}
