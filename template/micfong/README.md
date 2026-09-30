# Micfong Typst template

The document half of the design system: page layouts, identity marks and element styles built on the Micfong
Colour System, generalised from the Tripos notes template. Its visual language is unchanged from the notes:
0.75pt rules, left-ruled callouts, tinted title strips, a faded heading counter, and the `MICFONG ▲` wordmark
with its Data Matrix and barcode.

## Quick start

The folder is a Typst package, symlinked as `@local/micfong` (`just link` recreates the link):

```typst
#import "@local/micfong:0.1.0": *

#show: article.with(title: "Notes on Things", authors: "Micfong", date: datetime.today())

= Introduction
```

Or scaffold a new document with `typst init @local/micfong:0.1.0 my-doc`.

Compile with the vendored fonts. Two inputs select the variant:

```sh
typst compile --font-path "<this folder>/fonts" --input theme=dark --input font=serif doc.typ
```

| Input | Values | Default |
| --- | --- | --- |
| `theme` | `light`, `dark` | `light` |
| `font` | `sans`, `serif` | `sans` |
| `mds-token` | 4 Crockford base32 characters (`0-9`, `A-Z` without `I L O U`) | unset |

`mds-token` is the MDS build token. `mds push` sets it; leave it unset for ordinary builds (see
[MDS integration](#mds-integration)).

Set `TYPST_FONT_PATHS` to the fonts folder to drop the flag. Tinymist takes the same path in its
`fontPaths` setting.

## Layouts

| Layout | Opens with | Default numbering |
| --- | --- | --- |
| `book` | A full cover: title block over a framed diagonal | Chapters break pages; figures number `1.1` |
| `article` | The title block, a rule and an optional abstract, then the body | Figures number `1` |
| `series` + `volume` | A cover indexing the volumes; each volume has its own cover | As `book`, restarting per volume |

`chapter-covers: true`, on any layout, gives every numbered top-level heading a cover page. It shows the
chapter's title, section count and page range, lists its sections inside the frame, and sets the chapter
number large in the corner. Put `#chapter-summary[...]` before a heading to add a paragraph to its cover.

### Identity fields

Every layout, and `volume`, takes the same fields:

| Field | Meaning |
| --- | --- |
| `title`, `subtitle` | Title in bold, subtitle below it in the secondary colour. A `"\n"` in a string breaks the line. |
| `short-title` | For running headers (defaults to the title). |
| `authors` | A string or an array of strings. Becomes the bold first line of the metadata, and PDF metadata. |
| `show-authors` | `false` leaves the authors off the page but keeps them in the PDF metadata. The next line becomes the bold one. |
| `info` | Extra metadata lines, e.g. `("Michaelmas 2025",)`. |
| `date` | A `datetime`, printed in `date-format`, or any content. |
| `date-format` | `"iso"` (2026-09-27, the default), `"compact"` (20260927), `"long"` (27 September 2026), or any Typst format string such as `"[day].[month].[year]"`. |
| `version` | A string is printed as "Version …", a `datetime` as "Version 20260927"; content is printed as is. |
| `meta` | Replaces the metadata lines outright. The first line is always bold. |
| `doc-id` | E.g. `"D/ACD/UND/NTE/5"`. Printed on the first page and encoded in every page header. |
| `codes` | `false` hides the Data Matrix and the barcode but keeps the printed doc id. |
| `wordmark` | `auto` for `MICFONG ▲`, `none`, or your own content. |
| `draft` | `true` puts a red DRAFT badge in every header. |
| `cover` | (`book`, `series`, `volume`) `auto` for the default frame, `none` for an empty frame, or content that fills the frame. |

Layout options: `abstract` (article), `keywords`, `paper` (`"a4"`), `lang`/`region` (`"en"`/`"gb"`),
`chapter-covers`, `chapter-pagebreak`, `chapter-figures`, `numbered-equations` (per-line equation numbers as
in the notes), and `line-numbers` (code blocks).

### Series

Give each book a `meta.typ` with its identity and a `content.typ` with its body and no layout. Then the
standalone build and the series share them:

```typst
// handbook/main.typ
#show: book.with(..meta)
#include "content.typ"

// series.typ
#show: series.with(title: "Design System", doc-id: "X/DSN/SYS/TYP/2")
#volume(..handbook)[#include "handbook/content.typ"]
#volume(..colour)[#include "palette/content.typ"]
```

Volumes restart their page, heading, figure and theorem numbering. Their headers encode their own doc id with
the page numbers of the standalone book, so page *n* of a volume carries the same code as page *n* of the book.
Use `#contents()` rather than `#outline()` in shared content: it lists only the current volume.

In the PDF outline (the bookmarks panel), each volume is a top-level entry with its chapters and sections nested
under it. A hidden heading carries each volume's bookmark, and the volume's own headings are offset one level
down (`heading(offset: 1)`). Everything that means "chapter" keys on a heading's `depth` rather than its
`level`, so a volume's pages come out identical to the standalone book's; in your own show rules, select
`heading.where(depth: 1)` for chapters, not `level: 1`. On the series cover, every row of the volume index or
parts list links to that volume's first page.

`cover-style` picks the series cover's design. `cover-accent` names a colour family: on `frame` it puts the
whole cover on that family's key colour with black type (the default, `none`, keeps the page's colours); on
`smear` it colours the streaks (default `"orange"`); on `drafting` it colours the corner angles. `just covers`
renders every style side by side in `build/cover-gallery.pdf`.

| Style | Cover |
| --- | --- |
| `frame` | The book cover's frame and diagonal, with the volume index on top (default). |
| `smear` | The frame's layout over a dark ground of downward-smeared streaks, generated from a seed. |
| `drafting` | A drawing sheet filling the page; the identity only in its title block, joined to the parts list. |

Like the frame, the drafting sheet draws nothing that carries no information: the accent angles register its
corners, and the title block and the parts list (`#`, title, doc id, page) hold everything else, once each.
`cover-corner` alone places the two tables: `"top-left"` (the default) puts the parts list under the title
block, `"bottom-right"` puts it above, as on an engineering drawing. Either way a long list grows towards the
middle of the page.

## MDS integration

MDS (the Micfong Document System) registers every build, and resolves a scanned page code back to the exact
version and page. None of the template's support for it changes what a tokenless build prints.

**Page payloads.** Every page header encodes `page-payload(doc-id, n)` in its Data Matrix: `<doc-id>-<n in hex,
at least 4 digits>` (payload v1, `D/ACD/UND/NTE/5-000A`), plus `+<token>` when the build has an `mds-token`
(payload v2, `D/ACD/UND/NTE/5-000A+K7Q2`). `n` is the physical page within the document or volume. A series
cover encodes `S/…/1-0001+<token>`, and every volume page carries the series build's token.

**Symbol size.** Tokenless symbols keep Zint's automatic size, so they are byte for byte what earlier builds
printed. A tokened symbol would otherwise grow into a square (`20×20` for `D/ACD/UND/NTE/5-000A+K7Q2`), so it
uses the smallest rectangular ECC200 size that holds the payload: Zint's own automatic choice gives the data's
capacity class, and the first of `8×18`, `8×32`, `12×26`, `12×36`, `16×36`, `16×48` with at least that capacity is
used. A `KIND/DOM/AREA/TYPE/n` ID with a serial up to 9999 and a page up to `FFFF` always fits `12×36` (3.2 × 9.5
mm, the height of today's `12×26`); longer payloads, such as five- or six-digit serials, get `16×36`. The symbol
sits in a box as tall as the tokenless symbol for the same page would be, so the wordmark, the running title and
the rule below never move: a tokened build differs from a tokenless one only inside the symbol. `tests/payloads.typ` prints the boundary payloads and
the legacy forms, one per page; compile it with and without `--input mds-token=…` and scan it with `mds scan`.

**Page records.** Each header also emits a zero-size `metadata((p, code_id, code_page, label)) <mds-page>`:
the physical page, the code it prints (`none` without a doc id or with `codes: false`) and its printed page
label. `typst eval 'query(<mds-page>).map(it => it.value)' --in doc.typ` lists them.

**`mds.json`.** `book`, `article` and `series` end with `mds-map()`, which attaches `mds.json` (schema
`mds-pages/1`) to the PDF: the build (`token`, `rendition` = `theme-font`, `theme`, `font`), the page count,
one segment per start marker that prints a code (`role` `document`, or `front` for the series cover and
`volume` with its 1-based `ordinal` for each volume; `title`, `version_text`, `draft`), one record per page
(`p`, `code_id`, `code_page`, `label`, `kind` = `cover`, `front`, `chapter-cover` or `body`) and the outlined
headings (`p`, `level` counted from the document or volume, `numbering`, `title`, `label`, `ordinal`). `volume`
does not attach one, since the series maps the whole PDF. The map is attached only for paged output and only when
some marker has a doc id; `pdfdetach -list` shows it. `mds push` reads the document ID, segments and version from
it, so a document never needs to be decoded to be registered.

**PDF metadata.** A document with a doc id adds the keywords `mds:<doc-id>`, `mds-rendition:<theme-font>`,
`mds-version:<version>` (when there is one) and `mds-token:<token>` (tokened builds), and the description
`MDS <doc-id> · <title>`, so `pdfinfo` identifies any copy.

## Elements

| Element | Use |
| --- | --- |
| `note`, `tip`, `important`, `warning`, `caution` | Alerts with an MDI icon, in blue, green, yellow, orange and red. |
| `callout(name, accent:, icon-name:, label:)` | The left-ruled note they are built from. |
| `panel(title:, accent:, footer:)` | The titled box the theorem environments use. |
| `code(title:, numbers:)[```lang ...```]` | A code block with a file name in its top rule, or with different numbering. |
| `kbd("Cmd", "P")`, `badge("beta", accent:)` | Keys and small labels. |
| `fade`, `boxed`, `separator`, `divider[label]`, `boxed-header` | Inline and structural odds and ends from the notes. |
| `recolor-svg(read(...))`, `invert-svg(read(..., encoding: none))` | Figures adapted to the dark theme. Pass the file's contents, since a package cannot read your files. |
| `figure-required[...]`, `end-of-document()` | Placeholders and the closing rule. |
| `icon("github", size:, fill:)` | Any [MDI](https://pictogrammers.com/library/mdi/) icon by name. `provide-icons(json(...))` adds other Iconify sets, addressed as `set:name`. |
| `wordmark()`, `data-matrix`, `barcode`, `hex-id` | The identity marks, for use outside the layouts. |

Plain Typst is styled too. Code is bracketed, as on micfong.space, rather than filled: inline code sits between
grey JetBrains Mono brackets, and a block between top and bottom rules whose ends turn inwards. The inline
brackets are the font's outlines drawn as shapes, so, like `user-select: none` on the web, they are never
selected or copied with the code. Blocks also get line numbers, a language label in the top rule, and a syntax
theme generated from the palette.

Tables are plain by default: a dark rule above and below, light rules between rows. Mark header rows with
`table.header` to set them in bold on a tint, closed by a dark rule; a table without one has no header styling.
A table's own `stroke` or `fill` (in the call or a `set table` rule) replaces the default, and a marked header
stays bold either way.

```typst
#table(columns: 2, table.header[Key][Value], [a], [1], [b], [2])
```

Captions are bold, and set above tables and listings. Block quotes are ruled and italic, links underlined, and lists, enumerations and
term lists have their own markers and indents.

### Mathematics

`theorem`, `lemma`, `proposition`, `corollary`, `definition`, `law`, `axiom`, `rule`, `question` and `example`
share one counter numbered within the top-level heading, and can be labelled and referenced (`@lagrange` →
"Theorem 3.2"). `theorem-env("Conjecture", accent: "purple")` makes more. The unnumbered callouts are `proof`,
`prooflike`, `remark`, `remarklike`, `notation`, `claim` and `exercise`.

The notes' shorthands (`re`, `im`, `ii`, `ee`, `ppi`, `eval`, `matbold`, `argmin`, `mathsec`, …) live in a
module so their short names stay out of the way until needed: `#import maths: *`.

## Tokens

`palette` is the full colour sheet: seven families (`gray` plus `hues`), each keyed `"0"`–`"1000"`.
`palette.orange.at("500")` is the brand orange.

`colors` holds the semantic tokens for the active theme: `page`, `text`, `text-secondary`, `border-light`,
`border-dark`, `surface`, `surface-strong`, `brand`, `highlight` (yellow 300, or 700 in dark, drawn under the
lower half of highlighted text), and one entry per hue with four roles that mirror between
themes:

| Role | Light | Dark | Used for |
| --- | --- | --- | --- |
| `strong` | 700 | 200 | Labels and text on a tint |
| `base` | 500 | 500 | Rules and accents |
| `soft` | 100 | 800 | Title strips |
| `subtle` | 50 | 900 | Large quiet fills |

The notes' `shade700`, `shade500`, `shade100` and `shade50` remain as aliases.

## Fonts

| Suite | Body | Maths | Features |
| --- | --- | --- | --- |
| `sans` | IBM Plex Sans | Lete Sans Math | `ss01` single-storey a, `ss02` single-storey g, `tnum`. Zeros stay plain, so they cannot be mistaken for ∅. |
| `serif` | IBM Plex Serif | IBM Plex Math | Defaults, as in the notes |

Code is JetBrains Mono in both suites, with the body's feature tags switched off so they don't leak into it.
The wordmark stays in Plex Sans Bold under either suite. Han characters fall back to IBM Plex Sans SC, which
is not vendored (it is large), so that fallback needs the system install.
`just fonts-check` confirms the five vendored families are present.

## Layout of this folder

```
lib.typ          public API (the package entrypoint)
src/             palette, tokens, fonts, identity, icons, code, elements, theorems, maths,
                 furniture (header, footer, contents), covers (title block, frame),
                 series-covers (the cover styles), layouts, mds (the mds.json page map)
assets/mdi.json  Material Design Icons as an Iconify collection (@iconify-json/mdi 1.2.3)
fonts/           vendored faces and their licences
template/        the `typst init` starter
tests/           payloads.typ: every boundary and legacy page payload, for `mds scan`
examples/        article (element showcase), handbook (book + chapter covers),
                 palette (custom cover art), series (both, as volumes),
                 cover-gallery (every series cover style, via `just covers`)
```

The examples use `X/DSN/SYS/…` doc ids: MDS never allocates kind `X`, so their codes resolve as placeholders.
`just examples` builds every example in all four variants into `build/`; `just covers` builds the series cover
gallery.

## Changes from the notes template

- `project(lecturer:, lectured-in:, updated:)` became `book(authors:, info:, version:)`. `meta:` reproduces
  the notes' cover exactly, e.g. `meta: ([Prof Henry Wilton], [Michaelmas 2025], [Version 20260607])`.
- `cover-design` became `cover`.
- `dynamic-svg(path)` and `dynamic-svg2(path)` became `recolor-svg(read(path))` and `invert-svg(read(path,
  encoding: none))`.
- `showybox-*` became `panel(accent:)`, and theorems are native figures, dropping ctheorems, showybox, hydra and
  titleize.
- The HTML/Ponder path is gone: this template is PDF-only.
- `lecture-separator(lecture:, date:)` became `divider[Lecture 3 · 14 Oct]`, and `figure-req` became
  `figure-required`.

## Attribution

IBM Plex, Lete Sans Math and JetBrains Mono are under the SIL Open Font Licence (`fonts/LICENSES/`). Material
Design Icons are by Pictogrammers under the Apache 2.0 licence
(<https://github.com/Templarian/MaterialDesign/blob/master/LICENSE>).
