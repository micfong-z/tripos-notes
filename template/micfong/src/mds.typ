#import "config.typ": font, mds-rendition, mds-token, theme
#import "furniture.typ": chapter-cover-label, page-record-label, start-label
#import "structure.typ": is-volume-heading

#let _package = toml("../typst.toml").package

#let _space = [ ].func()

#let _plain(it) = {
  if it == none { "" } else if type(it) == str { it } else if type(it) == array { it.map(_plain).sum(default: "") } else if (
    type(it) != content
  ) { "" } else if it.func() in (_space, linebreak, parbreak) { " " } else if it.func() == smartquote {
    if it.double { "\"" } else { "'" }
  } else if it.has("text") and type(it.text) == str { it.text } else {
    it.fields().pairs().filter(((k, v)) => k != "label" and type(v) in (content, array)).map(((_, v)) => _plain(v)).sum(default: "")
  }
}

#let plain-text(it) = if it == none { none } else { _plain(it).replace(regex("\s+"), " ").trim() }

#let _is-series(m) = m.value.at("is-series", default: false)

#let _is-coded(m) = m.value.doc-id != none and m.value.codes

#let mds-map() = context {
  if target() != "paged" { return }
  let starts = query(start-label)
  let last = here().page()
  let in-series = starts.any(_is-series)
  let marks = starts
    .enumerate()
    .map(((i, m)) => {
      let series = _is-series(m)
      (
        from: m.location().page(),
        to: if i + 1 < starts.len() { starts.at(i + 1).location().page() - 1 } else { last },
        info: m.value,
        role: if series { "front" } else if in-series { "volume" } else { "document" },
        ordinal: if series or not in-series or not _is-coded(m) { none } else {
          starts.slice(0, i + 1).filter(s => not _is-series(s) and _is-coded(s)).len()
        },
      )
    })
  let segments = marks
    .filter(k => k.info.doc-id != none and k.info.codes)
    .map(k => (
      phys_from: k.from,
      phys_to: k.to,
      code_id: k.info.doc-id,
      role: k.role,
      ordinal: k.ordinal,
      title: plain-text(k.info.title),
      version_text: plain-text(k.info.version-text),
      draft: k.info.draft,
    ))
  if segments.len() == 0 { return }
  let covers = query(chapter-cover-label).map(m => m.location().page())
  let records = (:)
  for r in query(page-record-label) {
    if str(r.value.p) not in records { records.insert(str(r.value.p), r.value) }
  }
  let pages = range(1, last + 1).map(p => {
    let mark = marks.filter(k => k.from <= p).at(-1, default: none)
    let local = if mark == none { none } else { p - mark.from + 1 }
    let coded = mark != none and mark.info.doc-id != none and mark.info.codes
    let record = records.at(str(p), default: none)
    (
      p: p,
      code_id: if record != none { record.code_id } else if coded { mark.info.doc-id },
      code_page: if record != none { record.code_page } else if coded { local },
      label: if record != none { record.label } else if local != none { str(local) },
      kind: if local == 1 { if mark.role == "front" { "front" } else { "cover" } } else if p in covers {
        "chapter-cover"
      } else { "body" },
    )
  })
  let headings = query(heading)
    .filter(h => h.outlined and not is-volume-heading(h))
    .map(h => {
      let p = h.location().page()
      let mark = marks.filter(k => k.from <= p).at(-1, default: none)
      (
        p: p,
        level: h.level - h.offset,
        numbering: if h.numbering == none { none } else {
          plain-text(numbering(h.numbering, ..counter(heading).at(h.location())))
        },
        title: plain-text(h.body),
        label: if h.has("label") { str(h.label) } else { none },
        ordinal: if mark == none { none } else { mark.ordinal },
      )
    })
  pdf.attach(
    "/mds.json",
    bytes(json.encode(
      (
        spec: "mds-pages/1",
        generator: (typst: str(sys.version), template: _package.name + " " + _package.version),
        build: (token: mds-token, rendition: mds-rendition, theme: theme, font: font),
        page_count: last,
        segments: segments,
        pages: pages,
        headings: headings,
      ),
      pretty: false,
    )),
    mime-type: "application/json",
    relationship: "data",
    description: "MDS page map",
  )
}
