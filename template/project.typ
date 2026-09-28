// The document wrappers. `project` is one course as a standalone book; `series`
// and `volume` collect several courses under one cover.
//
// In PDF these are the design system's `book`, `series` and `volume` layouts.
// The HTML export for Ponder keeps its own body rules below, installed in a
// separate branch so that `html.*` is only ever evaluated under
// `--features html`.

// equate 0.3.3 calls html.frame unconditionally, which is undefined without
// --features html; 0.3.2 is the paged-safe release. Both are imported and the
// target picks one.
#import "@preview/equate:0.3.2": equate as equate-paged
#import "@preview/equate:0.3.3": equate as equate-html
#import "micfong/src/layouts.typ": book, series as ds-series, volume as ds-volume
#import "config.typ": apply-fonts, colors, is-html
#import "theorems.typ": html-theorem-rules

/// A course's identity in the design system's fields. The cover's metadata
/// column is the lecturer (in bold), the term and the version, as the notes
/// have always printed it; the authors go to the PDF metadata only.
#let _identity(title, authors, lecturer, lectured-in, updated, doc-id) = (
  title: title,
  authors: authors,
  meta: (lecturer, lectured-in, updated).filter(x => x not in (none, "")).map(x => [#x]),
  doc-id: doc-id,
)

/// A course title, with its Part on the line above: "Part IA\nGroups".
#let _full-title(part, title) = if part == none { title } else { part + "\n" + title }

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

/// A reference to a missing label reads as a red "(?)" while drafting. One to a
/// label defined twice is an error instead: a series holds several courses,
/// and two courses sharing a label would otherwise print "(?)" without notice.
#let _ref-rules(body) = {
  show ref: it => {
    if it.element != none { return it }
    context {
      let found = query(it.target).len()
      assert(found < 2, message: "label " + repr(it.target) + " is defined " + str(found) + " times, so this reference is ambiguous")
      text(fill: colors.red.shade500)[(?)]
    }
  }
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

/// content.typ breaks the page between chapters itself, and many chapters open
/// with a lecture divider above their heading. The layouts' own break before
/// each chapter heading would strand that divider alone on the page before.
#let _chapter-pagebreak = false

/// One course as a standalone document.
///
///     #show: project.with(..meta)
#let project(
  part: none,
  title: "New Document",
  authors: ("Zixuan Zhang",),
  lecturer: "",
  lectured-in: "",
  updated: "",
  doc-id: none,
  cover: auto,
  numbered-equations: false,
  body,
) = {
  let title = _full-title(part, title)
  if is-html {
    show: html-theorem-rules
    show: apply-fonts
    set document(author: authors, title: title.replace("\n", " "))
    set heading(numbering: "1.1 ")
    set table(stroke: 0.75pt + colors.border-dark)
    show: _ref-rules
    // A `show:` inside an `if` would only style that branch, so the equation
    // rules wrap the assembled body instead.
    let inner = _html-body(body, numbered-equations)
    if numbered-equations { _equation-numbering(inner) } else { inner }
  } else {
    show: book.with(
      .._identity(title, authors, lecturer, lectured-in, updated, doc-id),
      cover: cover,
      chapter-pagebreak: _chapter-pagebreak,
    )
    show: _ref-rules
    if numbered-equations { _equation-numbering(body) } else { body }
  }
}

/// Several courses under one cover. Takes the design system's `series`
/// arguments; add each course with `volume`.
///
///     #show: series.with(title: "Tripos Notes", doc-id: "S/ACD/UND/NTE/1", cover-style: "drafting")
#let series(..args, body) = {
  assert(not is-html, message: "a series is PDF-only")
  show: ds-series.with(chapter-pagebreak: _chapter-pagebreak, ..args)
  show: _ref-rules
  body
}

/// One course inside a series: its own cover, doc id, page numbers and
/// counters. Takes the same fields as `project`, so a course's `meta.typ` serves
/// both. The Part is left off the title, since the series names it.
///
///     #volume(..groups)[#include "groups/content.typ"]
#let volume(
  part: none,
  title: "New Document",
  authors: ("Zixuan Zhang",),
  lecturer: "",
  lectured-in: "",
  updated: "",
  doc-id: none,
  cover: auto,
  numbered-equations: false,
  body,
) = ds-volume(
  .._identity(title, authors, lecturer, lectured-in, updated, doc-id),
  cover: cover,
  if numbered-equations { _equation-numbering(body) } else { body },
)
