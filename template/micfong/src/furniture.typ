// Page furniture: running header, footer, and the markers they navigate by.
//
// Each document, and each volume inside a series, opens with a `<micfong-start>`
// metadata marker carrying its identity (title, doc id, wordmark). Headers and
// footers find the latest marker at or before their page, so one page setup
// serves a lone document and a series of volumes alike.
//
// Headers are laid out before their page's content, so they never see a
// counter update made on the same page. The local page number is therefore
// derived from the marker's page, not read from the page counter.

#import "config.typ": colors
#import "identity.typ": barcode, data-matrix, doc-id-label, page-payload, wordmark
#import "elements.typ": badge
#import "series-covers.typ": cover-background, cover-footer, cover-header
#import "structure.typ": is-volume-heading

#let start-label = <micfong-start>
#let chapter-cover-label = <micfong-chapter-cover>

/// Emit a start marker for a document or volume.
#let mark-start(info) = [#metadata(info)#start-label]

/// The start marker governing physical page `pg`, and the one after it.
#let bounds(pg) = {
  let starts = query(start-label)
  let before = starts.filter(m => m.location().page() <= pg)
  let after = starts.filter(m => m.location().page() > pg)
  (before.at(-1, default: none), after.at(0, default: none))
}

#let _heading-label(hd) = {
  if hd.numbering == none { return hd.body }
  [#numbering(hd.numbering, ..counter(heading).at(hd.location()))#h(0.6em)#hd.body]
}

/// The chapter a page belongs to: one starting on the page wins, otherwise the
/// last one before it, never crossing into a previous volume. Chapters are
/// depth-1 headings; a volume's hidden heading is not one.
#let _running-title(start, pg) = {
  let first = if start == none { 1 } else { start.location().page() }
  let candidates = query(heading.where(depth: 1)).filter(hd => {
    let p = hd.location().page()
    p >= first and p <= pg and not is-volume-heading(hd)
  })
  let on-page = candidates.filter(hd => hd.location().page() == pg)
  let chosen = if on-page.len() > 0 { on-page.first() } else { candidates.at(-1, default: none) }
  if chosen != none { _heading-label(chosen) }
}

/// The series' identity when page `pg` is a series cover, else none. A series
/// cover draws its own header, footer and background in its cover style.
#let _series-cover(start, pg) = {
  if start == none or start.location().page() != pg { return none }
  if start.value.at("is-series", default: false) { start.value }
}

#let page-record-label = <mds-page>

#let _page-record(pg, info, local) = {
  let coded = info.codes and info.doc-id != none
  [#metadata((
    p: pg,
    code_id: if coded { info.doc-id },
    code_page: if coded { local },
    label: if local == 1 { "1" } else { counter(page).display("1") },
  ))#page-record-label]
}

#let header = context {
  let pg = here().page()
  let (start, _) = bounds(pg)
  if start == none { return }
  let series = _series-cover(start, pg)
  if series != none { return _page-record(pg, series, 1) + cover-header(series) }
  let info = start.value
  let local = pg - start.location().page() + 1
  let on-chapter-cover = query(chapter-cover-label).any(m => m.location().page() == pg)

  let code = if info.codes and info.doc-id != none { data-matrix(page-payload(info.doc-id, local)) }
  let mark = if local == 1 {
    if info.wordmark == auto { wordmark() } else { info.wordmark }
  } else {
    let title = if on-chapter-cover { info.short-title } else { _running-title(start, pg) }
    text(weight: 700, fill: colors.text-secondary, title)
  }
  if info.draft { mark = [#badge("Draft", accent: "red")#h(0.8em)#mark] }

  _page-record(pg, info, local)
  grid(columns: (auto, 1fr), align: (left + horizon, right + horizon), code, mark)
  line(length: 100%, stroke: colors.border-light + 0.75pt)
}

#let footer = context {
  let pg = here().page()
  let (start, _) = bounds(pg)
  if start == none { return }
  let series = _series-cover(start, pg)
  if series != none { return cover-footer(series) }
  let info = start.value
  let local = pg - start.location().page() + 1

  if local == 1 {
    if info.doc-id != none {
      if info.codes { barcode(info.doc-id) }
      h(1fr)
      doc-id-label(info.doc-id)
    }
  } else {
    // The latest chapter or section. Only a section is shown, so a new chapter
    // clears the previous chapter's section until its own first.
    let current = query(heading.where(depth: 1).or(heading.where(depth: 2)).before(here()))
      .filter(hd => hd.location().page() >= start.location().page() and not is-volume-heading(hd))
      .at(-1, default: none)
    if current != none and current.depth == 2 {
      text(fill: colors.text-secondary, _heading-label(current))
    }
    h(1fr)
    counter(page).display("1")
  }
}

#let background = context {
  let pg = here().page()
  let (start, _) = bounds(pg)
  let series = _series-cover(start, pg)
  if series != none { cover-background(series) }
}

/// An outline scoped to the current document. In a series, it lists only the
/// volume it appears in; otherwise it is `outline` with the usual defaults.
///
/// A volume's headings sit one level down (for the PDF outline), which would
/// indent every entry a step. Each entry is re-made one level up, so a volume's
/// contents look exactly like a book's; the label marks the re-made ones.
#let contents(title: auto, depth: none, indent: auto) = context {
  let (start, next) = bounds(here().page())
  let target = selector(heading)
  if start != none { target = target.after(start.location()) }
  if next != none { target = target.before(next.location()) }
  let offset = heading.offset
  show outline.entry: it => if offset == 0 or it.at("label", default: none) == <micfong-shifted-entry> { it } else {
    [#outline.entry(it.level - offset, it.element)<micfong-shifted-entry>]
  }
  outline(title: title, depth: if depth == none { none } else { depth + offset }, indent: indent, target: target)
}
