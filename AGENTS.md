# Tripos Notes

Typst lecture notes for the Cambridge Mathematical Tripos, plus the Ponder
concept layer that powers the web edition.

## Layout

```
template/          one shared template; every course imports template/lib.typ
template/micfong/  the Micfong design system, vendored; do not edit here
part-ia/<course>/  main.typ, meta.typ, content.typ, prelude.typ, symbols.typ,
                   chapters/, media/
part-ia/series.typ every Part IA course as volumes of one series
part-ib/<course>/  same shape
fonts/             vendored OFL faces; builds ignore system fonts
ponder/            self-contained tooling subproject (see ponder/AGENTS.md)
build/             compiled PDFs, not tracked
```

A course's identity (part, title, lecturer, term, version, doc id, and any
cover art or `numbered-equations`) is the `meta` dictionary in `meta.typ`. Its
body, from the introduction through the chapter includes to
`#end-of-document()`, is `content.typ`, which has no layout of its own.
`main.typ` is only `#show: project.with(..meta)` and `#include "content.typ"`,
and `part-ia/series.typ` wraps the same two files in `#volume(..meta)[...]`. A
new chapter is therefore included from `content.typ`, and the table of contents
is `#contents()`, which in a series lists only its own volume.

`courses.tsv` has three tab-separated columns: the build slug, the display name,
and the slug the website and the R2 object keys use. It drives `build-all`, the
README table and publishing, so a new course is added there once.

## Building

```sh
just build part-ia/groups dark serif   # one course, one variant
just build-all                         # every course, all four variants
just series dark serif                 # the Part IA series, one variant
just series-all                        # the Part IA series, all four variants
just watch part-ia/groups              # live preview
just fonts-check                       # verify the vendored faces
just sync-template                     # re-vendor the design system
just publish                           # build everything, then push to R2
```

The series is not in `courses.tsv`, so `build-all` leaves it out; `publish`
builds and uploads it too. Its cover is the design system's `drafting` style.

Labels must be unique across all the Part IA courses, not just within one,
because the series puts them in one document. A reference to a label defined
twice fails the build; a reference to a missing label prints a red "(?)".

## Publishing

Tagging `v*` runs the release workflow: it builds all four variants, attaches
them to the GitHub release, and uploads them to the `micfong-space` R2 bucket
that `storage.micfong.space` serves. Object keys are
`notes/<site-slug>.<theme>.<font>.pdf`, plus `notes/<site-slug>.pdf` as an alias
for the light/sans build so links predating the variants still resolve.

`just publish` does the same from a local `wrangler login` session, where CI
reads the `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` repository secrets
instead. It also uploads the Part IA series under the slug `ia-series`
(`notes/ia-series.<theme>.<font>.pdf`, plus `notes/ia-series.pdf`), which the
release workflow does not build.

Every compile passes `--root .`, because the shared template is imported
root-absolutely as `/template/lib.typ`. Compiling a course file directly without
`--root .` will fail.

## The four export targets

Two inputs select the variant, both read in `template/config.typ`:

| Input | Values | Default |
| --- | --- | --- |
| `theme` | `light`, `dark` | `light` |
| `font` | `sans`, `serif` | `sans` |
| `target` | `pdf`, `html` | `pdf` |

The sans suite is IBM Plex Sans with Lete Sans Math; the serif suite is IBM Plex
Serif with IBM Plex Math. Feature tags per suite are the design system's, in
`template/micfong/src/fonts.typ`. Typst silently ignores an unknown feature tag,
so `just fonts-check` is what catches a wrong font version. The design system
lists IBM Plex Sans SC as a CJK fallback, which is not vendored, so every build
warns `unknown font family: ibm plex sans sc`; it is harmless while the notes
contain no Han characters.

`target` is a plain `sys.inputs` value rather than Typst's `target()`, because
`target()` is undefined unless `--features html` is passed, and `set` rules need
a non-contextual value.

## Template conventions

- The PDF design is the Micfong design system (`template/micfong/`, see its
  README). It is vendored so CI needs nothing outside the repository; change it
  at its source and run `just sync-template`, never edit the copy. The rest of
  `template/` keeps the notes' own API on top of it (`project`, `volume`,
  `theorem`, `callout`, `dynamic-svg`, `lecture-separator`, ...), plus the HTML
  branch the design system does not have.
- `project()` is the design system's `book` in PDF; `series()` and `volume()`
  are its series layouts. Theorem environments in PDF are its numbered figures,
  so `@label` still reads "Theorem 3.2". In HTML they remain ctheorems
  environments, because the exporter depends on their markup.
- A course's chapters import only `../prelude.typ`. The prelude is two lines:
  the shared `/template/lib.typ` and the course's `symbols.typ`, which it
  re-exports. Course notation therefore lives in one greppable file per course,
  and may shadow a shared name (Groups redefines `im` as the image operator).
- Notation packages a course needs (physica, mannot, fletcher, unify) are
  imported by its `symbols.typ`, so they reach chapters through the prelude.
  Vector notation is physica's throughout: `vb`/`vu` for bold and unit vectors,
  `vecrow` for a row vector, `grad`/`div`/`curl`, `iprod` for an inner product,
  and `TT` for a transpose. Every course except Analysis I and Numbers and Sets
  imports it, as does `ponder/fragment-preamble.typ`. physica shadows the
  built-in `div` (the division sign) with the divergence operator, which is why
  Numbers and Sets, which writes `÷`, stays out.
- `project()` applies the theorem rules and the fonts once. Chapters must not
  reapply them.
- Tables are plain unless a row is marked with `table.header(...)`, which the
  design system sets in bold on a tint. Mark a table's header row that way;
  a table's own `stroke` or `fill` replaces the default styling.
- Anything that renders differently in HTML branches on `is-html` inside one
  definition. The `typst-*` class names are a contract with the Ponder exporter
  and the website CSS: do not rename them.
- Figure paths are root-absolute (`/part-ia/groups/media/x.svg`) because the
  shared template resolves `read()` against its own file, not the caller.
- `dynamic-svg` recolours black-on-white Inkscape figures for the dark theme, so
  figures need only one asset.

## Ponder

`#ponder("namespace.slug")[text]` is invisible in PDF and becomes an anchor in
HTML. The exporter compiles each course's `main.typ` and follows its includes
through `content.typ` to the chapters. The tooling, entry registry and its own
agent guide live in `ponder/`;
read `ponder/AGENTS.md` before touching any of it. Entry tooltip fragments
compile against `template/lib.typ` plus `ponder/fragment-preamble.typ`, never a
course prelude, so an operator a summary uses must be declared in the preamble
too.
