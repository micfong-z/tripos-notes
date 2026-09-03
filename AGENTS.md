# Tripos Notes

Typst lecture notes for the Cambridge Mathematical Tripos, plus the Ponder
concept layer that powers the web edition.

## Layout

```
template/          one shared template; every course imports template/lib.typ
part-ia/<course>/  main.typ, prelude.typ, symbols.typ, chapters/, media/
part-ib/<course>/  same shape
fonts/             vendored OFL faces; builds ignore system fonts
ponder/            self-contained tooling subproject (see ponder/AGENTS.md)
build/             compiled PDFs, not tracked
```

`courses.tsv` maps each course slug to its display name and drives `build-all`,
release asset names and the README table.

## Building

```sh
just build part-ia/groups dark serif   # one course, one variant
just build-all                         # every course, all four variants
just watch part-ia/groups              # live preview
just fonts-check                       # verify the vendored faces
```

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

The sans suite is Inter with Lete Sans Math; the serif suite is IBM Plex Serif
with IBM Plex Math. Feature tags per suite live in `template/fonts.typ`. Typst
silently ignores an unknown feature tag, so `just fonts-check` is what catches a
wrong font version.

`target` is a plain `sys.inputs` value rather than Typst's `target()`, because
`target()` is undefined unless `--features html` is passed, and `set` rules need
a non-contextual value.

## Template conventions

- A course's chapters import only `../prelude.typ`. The prelude is two lines:
  the shared `/template/lib.typ` and the course's `symbols.typ`, which it
  re-exports. Course notation therefore lives in one greppable file per course,
  and may shadow a shared name (Groups redefines `im` as the image operator).
- Notation packages a course needs (physica, mannot, fletcher, unify) are
  imported by its `symbols.typ`, so they reach chapters through the prelude.
- `project()` applies `thmrules` and the fonts once. Chapters must not reapply
  them.
- Anything that renders differently in HTML branches on `is-html` inside one
  definition. The `typst-*` class names are a contract with the Ponder exporter
  and the website CSS: do not rename them.
- Figure paths are root-absolute (`/part-ia/groups/media/x.svg`) because the
  shared template resolves `read()` against its own file, not the caller.
- `dynamic-svg` recolours black-on-white Inkscape figures for the dark theme, so
  figures need only one asset.

## Ponder

`#ponder("namespace.slug")[text]` is invisible in PDF and becomes an anchor in
HTML. The tooling, entry registry and its own agent guide live in `ponder/`;
read `ponder/AGENTS.md` before touching any of it. Entry tooltip fragments
compile against `template/lib.typ` plus `ponder/fragment-preamble.typ`, never a
course prelude, so an operator a summary uses must be declared in the preamble
too.
