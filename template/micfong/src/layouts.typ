// Document layouts.
//
//   book     a full cover page, then the body
//   article  title block on the first page, running straight into the body
//   series   a collection cover indexing its volumes; add each with `volume`
//
// All three share `_base` (typography, element styling, page furniture) and
// the same identity fields, so a book's metadata can be reused verbatim as a
// volume of a series. `chapter-covers: true` gives every numbered top-level
// heading its own cover page.

// equate 0.3.3 calls html.frame unconditionally, which is undefined without
// --features html; 0.3.2 is the paged-safe release.
#import "@preview/equate:0.3.2": equate
#import "config.typ": colors, fonts
#import "fonts.typ": cjk, mono, reset
#import "icons.typ": use-icons
#import "code.typ": code-rules
#import "elements.typ": callout, plain-link-label, quote-rules, rule, separator
#import "theorems.typ": theorem-rules, thm-kind
#import "furniture.typ": background, bounds, chapter-cover-label, footer, header, mark-start, start-label
#import "covers.typ": format-date, frame, lines, plain, title-block
#import "series-covers.typ": cover-body, default-accent, volume-label
#import "structure.typ": chapter-number, volume-heading-label, volume-numbering

#let _chapter-summary = state("micfong-chapter-summary", none)

/// A paragraph shown on the next chapter cover. Place it just before the
/// chapter's heading.
#let chapter-summary(body) = _chapter-summary.update(body)

// -------------------------------------------------------------------- identity

/// Normalise the identity fields shared by every layout into one dictionary.
#let _identity(
  title: "Untitled",
  subtitle: none,
  short-title: auto,
  authors: (),
  show-authors: true,
  date: none,
  version: none,
  info: (),
  meta: auto,
  doc-id: none,
  codes: true,
  wordmark: auto,
  draft: false,
  date-format: "iso",
) = {
  let authors = if type(authors) in (str, content) { (authors,) } else { authors }
  let date-text = if date == none { none } else { format-date(date, format: date-format) }
  // A datetime version prints as YYYYMMDD, the notes' version style.
  let version-text = if type(version) == datetime { format-date(version, format: "compact") } else { version }
  let meta = if meta != auto { meta } else {
    let lines = ()
    if show-authors and authors.len() > 0 { lines.push(authors.join(", ")) }
    lines += info
    if date-text != none { lines.push(date-text) }
    if version-text != none {
      lines.push(if type(version-text) == str [Version #version-text] else { version-text })
    }
    lines
  }
  (
    title: title,
    subtitle: subtitle,
    short-title: if short-title == auto { plain(title) } else { short-title },
    authors: authors,
    show-authors: show-authors,
    info: info,
    date: date,
    date-text: date-text,
    version-text: version-text,
    meta: meta,
    doc-id: doc-id,
    codes: codes,
    wordmark: wordmark,
    draft: draft,
  )
}

// --------------------------------------------------------------------- base

#let _outline-rules(body) = {
  set outline(indent: auto)
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  set outline.entry(fill: pad(bottom: 0.3em, x: 0.25em, line(
    length: 100%,
    stroke: (paint: colors.border-light, thickness: rule, dash: "densely-dashed"),
  )))
  show outline.entry.where(level: 1): set outline.entry(fill: pad(bottom: 0.3em, x: 0.25em, line(
    length: 100%,
    stroke: colors.border-dark + rule,
  )))
  body
}

// Tables are plain by default: a dark rule above and below, light rules
// between rows. Only rows marked with `table.header` become a header: bold, on
// a tint, closed by a dark rule.
//
// Show-set rules cannot reach inside `table.header`, and a table's own fill and
// stroke are fixed by the time its show rule runs, so a table with a header is
// rebuilt with header-aware functions. The plain functions double as sentinels:
// a table whose stroke or fill is not one of them was styled by its author,
// and that styling is kept.

#let _plain-stroke = (_, y) => (top: rule + if y == 0 { colors.border-dark } else { colors.border-light })
#let _plain-fill = (_, y) => none

/// How many rows the table's `table.header` spans, or 0 without one.
#let _header-rows(it) = {
  let first = it.children.at(0, default: none)
  if first == none or first.func() != table.header { return 0 }
  let columns = if type(it.columns) == array { it.columns.len() } else { it.columns }
  let span = first.children.map(c => if c.func() == table.cell { c.at("colspan", default: 1) } else { 1 }).sum()
  calc.ceil(span / columns)
}

#let _table-rules(body) = {
  set table(
    stroke: _plain-stroke,
    fill: _plain-fill,
    inset: (x: 0.7em, y: 0.55em),
    // Cells read left to right even inside a centred figure.
    align: start,
  )
  show table: it => {
    let n = _header-rows(it)
    let restroke = n > 0 and it.stroke == _plain-stroke
    let refill = n > 0 and it.fill == _plain-fill
    if restroke or refill {
      let fields = it.fields()
      let children = fields.remove("children")
      let _ = fields.remove("label", default: none)
      if refill { fields.fill = (_, y) => if y < n { colors.surface } }
      if restroke {
        fields.stroke = (_, y) => (top: rule + if y == 0 or y == n { colors.border-dark } else { colors.border-light })
      }
      // The rebuilt table comes back through this rule, which then styles it.
      return table(..fields, ..children)
    }
    show table.cell: c => if c.y < n { strong(c) } else { c }
    // Close the table with the same dark rule it opens with.
    block(stroke: (bottom: rule + colors.border-dark), it)
  }
  body
}

#let _figure-rules(chapter-figures, body) = {
  set figure(numbering: if chapter-figures {
    n => numbering("1.1", chapter-number(), n)
  } else { "1" })
  set figure(gap: 0.9em)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.caption: it => {
    set text(size: 0.9em)
    let label = if it.numbering != none [#it.supplement #context it.counter.display(it.numbering)] else {
      it.supplement
    }
    [#strong(label)#h(0.6em)#it.body]
  }
  body
}

/// Per-line numbering for multi-line aligned equations, as in the notes.
#let _equation-numbering(body) = {
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

/// Reset the chapter-scoped counters at a top-level heading.
#let _chapter-resets(chapter-figures) = {
  counter(figure.where(kind: thm-kind)).update(0)
  if chapter-figures {
    for kind in (image, table, raw) { counter(figure.where(kind: kind)).update(0) }
  }
}

/// The cover page for one top-level heading: its title and facts on top, the
/// chapter's sections inside the frame, a large numeral in the corner.
#let _chapter-cover(it) = {
  pagebreak(weak: true)
  [#metadata(none)#chapter-cover-label]
  // The cover is the heading's own realisation, so undo the heading text style.
  set text(size: 11pt, weight: "regular")
  set par(justify: false)
  context {
    let loc = it.location()
    let number = numbering(it.numbering, ..counter(heading).at(loc))
    let (_, next-start) = bounds(loc.page())
    let next-chapter = query(heading.where(depth: 1).after(loc)).filter(hd => hd.location() != loc).at(0, default: none)
    let ends = (next-chapter, next-start).filter(x => x != none).map(x => x.location())
    let end = ends.sorted(key: l => l.page()).at(0, default: none)

    let sections = heading.where(depth: 2).after(loc)
    if end != none { sections = sections.before(end) }
    let count = query(sections).len()
    let first-page = counter(page).at(loc).first()
    let last-page = if end == none {
      counter(page).final().first()
    } else {
      counter(page).at(end).first() - 1
    }

    let facts = ()
    if count > 0 { facts.push(if count == 1 [1 section] else [#count sections]) }
    facts.push(if last-page > first-page [Pages #first-page–#last-page] else [Page #first-page])

    title-block((
      title: [#text(fill: colors.text-secondary, number)#h(0.5em)#it.body],
      subtitle: none,
      meta: facts,
    ))
    frame(inset: 1.5em, {
      place(bottom + right, dx: 0.12em, dy: 0.2em, text(
        size: 12em,
        weight: 700,
        fill: colors.border-light,
        "§" + number,
      ))
      let summary = _chapter-summary.get()
      if summary != none {
        block(width: 75%, below: 2em, summary)
      }
      if count > 0 { outline(title: none, indent: 0pt, target: sections) }
    })
  }
  _chapter-summary.update(none)
  pagebreak()
}

#let _base(
  paper: "a4",
  lang: "en",
  region: "gb",
  chapter-figures: false,
  chapter-pagebreak: false,
  chapter-covers: false,
  numbered-equations: false,
  line-numbers: true,
  chapter-supplement: none,
  body,
) = {
  set text(
    size: 11pt,
    font: (fonts.body, cjk),
    lang: lang,
    region: region,
    features: fonts.body-features,
    fill: colors.text,
  )
  show math.equation: set text(font: fonts.math, features: reset(fonts.body-features) + fonts.math-features)

  set page(
    paper: paper,
    margin: (top: 2.5cm, bottom: 2.5cm, x: 1.5cm),
    fill: colors.page,
    header: header,
    footer: footer,
    background: background,
  )

  // Headings are styled by depth, not level, so a series volume's headings
  // (offset one level down for the PDF outline) look as they do in a book.
  set heading(numbering: "1.1")
  show heading.where(depth: 1): set heading(supplement: if chapter-supplement == none { auto } else {
    chapter-supplement
  })
  // Typst sizes headings by level, and a relative size here would compound
  // with that, so these are absolute: its 1.4em, 1.2em and 1em of the 11pt body.
  show heading.where(depth: 1): set text(size: 15.4pt)
  show heading.where(depth: 2): set text(size: 13.2pt)
  show heading.where(depth: 3): set text(size: 11pt)
  show heading: set block(above: 1.6em, below: 1em)
  show heading: it => {
    if it.numbering == none { return it.body }
    [#text(fill: colors.text-secondary, counter(heading).display(it.numbering))#h(0.6em)#it.body]
  }
  show heading.where(depth: 1): it => {
    let chapter = it.numbering != none and it.outlined
    _chapter-resets(chapter-figures)
    if chapter and chapter-covers {
      _chapter-cover(it)
    } else {
      if chapter and chapter-pagebreak { pagebreak(weak: true) }
      it
    }
  }
  // A volume's own heading only anchors its PDF bookmark; it draws nothing.
  show heading: it => if it.at("label", default: none) == volume-heading-label { none } else { it }

  // Links are underlined, except those an index draws as whole rows.
  show link: it => if it.at("label", default: none) == plain-link-label { it } else {
    underline(stroke: rule + colors.border-dark, offset: 0.2em, it)
  }
  set footnote.entry(separator: line(length: 30% + 0pt, stroke: 0.5pt + colors.border-light))
  set list(marker: ([•], [–]))
  set enum(numbering: "1.a.i.")
  // Items are spaced like paragraphs. The built-in layout already sets the term
  // in bold; wrapping an item in `par` instead would drop any display maths or
  // second paragraph in its description.
  set terms(separator: h(0.6em), hanging-indent: 1.5em, spacing: 1.2em)
  // A marker stroke across the lower half of the letters: from half the cap
  // height down to just under the baseline (a positive bottom edge is below it).
  set highlight(fill: colors.highlight, top-edge: 0.35em, bottom-edge: 0.06em)

  show: _outline-rules
  show: _table-rules
  show: _figure-rules.with(chapter-figures)
  show: code-rules.with(line-numbers: line-numbers)
  show: quote-rules
  show: theorem-rules

  use-icons
  if numbered-equations { _equation-numbering(body) } else { body }
}

/// Arguments for `set document`. A set rule inside a helper would only style
/// the helper's own (empty) output, so each layout applies it itself.
#let _document-args(id, keywords) = (
  title: plain(id.title),
  author: id.authors.filter(a => type(a) == str),
  keywords: keywords,
  date: if type(id.date) == datetime { id.date } else { none },
)

// --------------------------------------------------------------------- layouts

/// A document with a full cover page.
///
///     #show: book.with(title: "Groups", subtitle: "Part IA", doc-id: "D/ACD/UND/NTE/5")
#let book(
  cover: auto,
  keywords: (),
  paper: "a4",
  lang: "en",
  region: "gb",
  chapter-covers: false,
  chapter-pagebreak: true,
  chapter-figures: true,
  numbered-equations: false,
  line-numbers: true,
  ..identity,
  body,
) = {
  let id = _identity(..identity)
  set document(.._document-args(id, keywords))
  show: _base.with(
    paper: paper,
    lang: lang,
    region: region,
    chapter-figures: chapter-figures,
    chapter-pagebreak: chapter-pagebreak,
    chapter-covers: chapter-covers,
    numbered-equations: numbered-equations,
    line-numbers: line-numbers,
    chapter-supplement: [Chapter],
  )
  mark-start(id)
  title-block(id)
  frame(cover)
  pagebreak()
  body
}

/// A document without a cover: the title block heads the first page and the
/// body follows at once.
///
///     #show: article.with(title: "Design Notes", authors: "Micfong", abstract: [...])
#let article(
  abstract: none,
  keywords: (),
  paper: "a4",
  lang: "en",
  region: "gb",
  chapter-covers: false,
  chapter-pagebreak: false,
  chapter-figures: false,
  numbered-equations: false,
  line-numbers: true,
  ..identity,
  body,
) = {
  let id = _identity(..identity)
  set document(.._document-args(id, keywords))
  show: _base.with(
    paper: paper,
    lang: lang,
    region: region,
    chapter-figures: chapter-figures,
    chapter-pagebreak: chapter-pagebreak,
    chapter-covers: chapter-covers,
    numbered-equations: numbered-equations,
    line-numbers: line-numbers,
  )
  mark-start(id)
  title-block(id)
  v(0.4em)
  separator
  if abstract != none {
    v(0.4em)
    callout("Abstract", abstract)
  }
  v(0.8em)
  body
}

/// A collection of volumes under one cover, which indexes every `volume` in
/// the body with its doc id and starting page. `cover-style` picks the cover's
/// design (see series-covers.typ); `cover-accent` names the colour family it is
/// drawn in; `cover-corner` places the drafting sheet's tables.
///
///     #show: series.with(title: "Tripos Notes", doc-id: "D/ACD/UND/NTE")
///     #volume(..groups-meta)[#include "groups/content.typ"]
#let series(
  cover: auto,
  cover-style: "frame",
  cover-accent: auto,
  cover-corner: "top-left",
  keywords: (),
  paper: "a4",
  lang: "en",
  region: "gb",
  chapter-covers: false,
  chapter-pagebreak: true,
  chapter-figures: true,
  numbered-equations: false,
  line-numbers: true,
  ..identity,
  body,
) = {
  let id = _identity(..identity)
  let accent = if cover-accent == auto { default-accent(cover-style) } else { cover-accent }
  set document(.._document-args(id, keywords))
  show: _base.with(
    paper: paper,
    lang: lang,
    region: region,
    chapter-figures: chapter-figures,
    chapter-pagebreak: chapter-pagebreak,
    chapter-covers: chapter-covers,
    numbered-equations: numbered-equations,
    line-numbers: line-numbers,
    chapter-supplement: [Chapter],
  )
  mark-start(id + (is-series: true, cover-style: cover-style, cover-accent: accent, cover-corner: cover-corner))
  cover-body(id, style: cover-style, accent: accent, corner: cover-corner, cover: cover)
  pagebreak()
  body
}

/// One volume of a series: its own cover, doc id, page numbers and counters.
/// Takes the same identity fields as `book`.
///
/// In the PDF outline the volume is a top-level entry and its headings nest
/// under it: a hidden level-1 heading carries the bookmark, and the volume's
/// own headings are offset one level down.
#let volume(cover: auto, ..identity, body) = {
  let id = _identity(..identity)
  pagebreak(weak: true)
  mark-start(id)
  [#metadata((title: id.title, subtitle: id.subtitle, doc-id: id.doc-id))#volume-label]
  counter(page).update(1)
  counter(heading).update(0)
  counter(math.equation).update(0)
  for kind in (image, table, raw, thm-kind) { counter(figure.where(kind: kind)).update(0) }
  [#heading(level: 1, numbering: none, outlined: false, bookmarked: true, plain(id.title))#volume-heading-label]
  set heading(offset: 1, numbering: volume-numbering)
  context {
    // "Volume 2 of Tripos Notes", from this volume's place in the series.
    let number = query(selector(volume-label).before(here())).len()
    let series = query(start-label)
      .filter(m => m.location().page() < here().page())
      .find(m => m.value.at("is-series", default: false))
    let meta = id.meta
    if series != none {
      meta.push(text(fill: colors.text-secondary)[Volume #number of #series.value.short-title])
    }
    title-block(id + (meta: meta))
  }
  frame(cover)
  pagebreak()
  body
}
