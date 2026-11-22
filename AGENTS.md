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
`#end-of-document()`, is `content.typ`, which has no layout of its own; only its
chapters can also compile alone (see the template conventions).
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
just new-course                        # asks, then: MDS ID, folder, courses.tsv, README row
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
so `just fonts-check` is what catches a wrong font version. Code is set in
Iosevka Micfong, and Han characters fall back to IBM Plex Sans SC; only its
Regular and Bold are vendored, because its other weights carry family names of
their own (`IBM Plex Sans SC Medm`, `IBM Plex Sans SC SmBld`) that the design
system never asks for.

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
- A course's chapters import only `../prelude.typ`. The prelude re-exports the
  shared `/template/lib.typ` and the course's `symbols.typ`, and binds `chapter`
  to the course's `meta`. Course notation therefore lives in one greppable file
  per course, and may shadow a shared name (Groups redefines `im` as the image
  operator).
- Every chapter opens with its import and `#show: chapter.with(N)`, where `N` is
  its number in the course, so it can be compiled on its own: opening one in
  Tinymist and starting the preview shows only that chapter, with no `main.typ`
  involved. The rule does nothing inside a course or series. Alone, a chapter
  has the book's styling and numbering without the cover, equations count from
  1, and a reference to another chapter's label shows the label's name, because
  a typo and a label elsewhere look the same from inside one chapter. The full
  build's red "(?)" is what catches a label that exists nowhere.
- Notation packages a course needs (physica, mannot, fletcher, unify) are
  imported by its `symbols.typ`, so they reach chapters through the prelude.
  Vector notation is physica's throughout: `vb`/`vu` for bold and unit vectors,
  `vecrow` for a row vector, `grad`/`div`/`curl`, `iprod` for an inner product,
  and `TT` for a transpose. Every course except Analysis I and Numbers and Sets
  imports it, as does `ponder/fragment-preamble.typ`. physica shadows the
  built-in `div` (the division sign) with the divergence operator, which is why
  Numbers and Sets, which writes `÷`, stays out.
- State diagrams come from `template/automata.typ`, which draws with the finite
  package: `automaton` takes finite's transition tables, and `markov-chain` a
  table or the transition matrix (the `mat` itself will do), dropping zero
  entries. It places the states, bends, loops and labels itself, so a diagram
  needs no positions, curves or loop anchors, and its ink and fills follow the
  theme. It stays out of `lib.typ` because finite loads cetz and a Graphviz
  plugin; a course that draws them imports it from its `symbols.typ`, as Markov
  Chains does.
- Proof illustrations come from `template/illustrate.typ`: coloured, highlighted
  and boxed terms in maths (`cblue`, `hblue`, `bblue`, and the same for red,
  green, orange, purple and gray), `annot` for a few words under a tagged term,
  `blocks`/`blk` for a matrix drawn as tinted blocks, and `canvas` (cetz) and
  `fletcher-diagram` for drawings, all in the theme's colours. Under the HTML
  target the markers fall back to plain coloured ink and `annot` draws nothing,
  because mannot cannot lay them out there. Like `automata.typ` it stays out of
  `lib.typ`; Linear Algebra and Markov Chains import it from `symbols.typ`. The
  pictures go in `#intuition[...]` asides, leave the statements and proofs
  uncoloured, and use a colour only where it means something.
- `project()` applies the theorem rules and the fonts once. Chapters must not
  reapply them.
- Tables are plain unless a row is marked with `table.header(...)`, which the
  design system sets in bold on a tint. Mark a table's header row that way;
  a table's own `stroke` or `fill` replaces the default styling.
- Asides written for intuition rather than proof (pictures, worked cases) go in
  `#intuition[...]`, a box ruled with a dashed purple line and no heading. Each
  carries the label `<intuition>`, so `#show <intuition>: none` before a
  course's content drops them all. They are unnumbered and hold no labels, so
  dropping them renumbers nothing.
- Anything that renders differently in HTML branches on `is-html` inside one
  definition. The `typst-*` class names are a contract with the Ponder exporter
  and the website CSS: do not rename them.
- Figure paths are root-absolute (`/part-ia/groups/media/x.svg`) because the
  shared template resolves `read()` against its own file, not the caller.
- Figures are included with `dynamic-svg2`, which inverts them for the dark
  theme, so a figure needs only one asset; see Figures below. `dynamic-svg`, the
  older black-to-white swap, is no longer used by any figure.

## Figures

Figures are hand-written SVGs in a course's `media/`, included as
`#dynamic-svg2("/part-ib/methods/media/p9.svg", width: 20em)`. They all share
one drawing style, and a new or redrawn figure follows it.

- The dark theme passes every figure through `invert-svg`: it inverts each
  colour, then rotates the hue back by 185°, over the gray 900 page. A figure
  therefore has no background and nothing white or opaque gray in it: white
  turns into a black patch and a light gray all but vanishes.
- The viewBox is 13.9 units wide per em of the call's `width` (a `20em` figure
  is 278 wide), so 13-unit labels print at about the body size. Labels are 13,
  secondary text 12, tick labels 11, and sub- and superscripts about 68%.
- Text is `font-family="Micfong Sans Math, IBM Plex Sans"`. Maths uses Unicode
  math italic (𝑥, 𝜃, and bold italic 𝒂 for vectors); digits, operators, the
  d of d𝑥, function names and words stay upright, and minus is U+2212. Keep
  every word of a figure's text: a sentence inside a figure is part of the
  notes.
- Ink is black. Accent colours come only from the palette's 500 level: blue
  `#007AF5`, red `#E43748`, orange `#EC6F27`, green `#14AE52`, purple
  `#9154FF`, and gray `#808080` for secondary annotations.
- Lines are 1.5 for the outline of a solid, 1 for ordinary lines and axes, 1.3
  for function graphs, and 0.8 dashed `3 2.5` for hidden or construction
  lines. Arrowheads are the filled triangle marker (`viewBox="0 0 10 10"`,
  `markerWidth="7"`, `orient="auto-start-reverse"`).
- Fills have three jobs and no others:
  - Hatching marks the subject: blue 1-unit lines at a 6-unit pitch, at −45°,
    with no background. A second set is red at +45°, so overlaps cross-hatch. A
    2D region is hatched, never tinted.
  - Tone says which way a flat face of a solid points: black at
    `fill-opacity` 0.10 for a face towards the viewer and 0.22 for one turned
    away, with top faces unfilled. It is translucent black rather than gray so
    the dark theme makes it translucent white over the page. A tone stops only
    at an edge, and never goes on a curved surface or a plane.
  - Faint gridlines show curved surfaces and planes: 0.5 wide at
    `stroke-opacity` 0.32, on the visible side only. Spheres get parallels and
    meridians every 30°, cones their generators, and planes in space a thin
    gray outline with a grid parallel to their edges. A computed surface keeps
    its plotted mesh, at 0.55 wide and 0.6 opacity in its own colour.
- 3D is a true orthographic projection with hidden edges dashed. Anything lying
  in a plane is drawn foreshortened in that plane. A rotation arrow is a circle
  around its axis, in the plane perpendicular to it, broken where it passes
  behind the axis and turning by the right-hand rule when the axis has a
  direction.
- No label touches a line, an arrowhead, hatching, gridlines or another label.
  Labels go in clear space; one that must sit inside hatching or a grid gets
  that layer cut away under it with a mask, never a white halo, which the dark
  theme would turn into a dark patch.
- Function plots have boxed axes, a light gray grid (0.5 wide, 45% opacity),
  curves 1.3 wide in their accent colour, and the same functions and ranges as
  their source.

## Ponder

`#ponder("namespace.slug")[text]` is invisible in PDF and becomes an anchor in
HTML. The exporter compiles each course's `main.typ` and follows its includes
through `content.typ` to the chapters. The tooling, entry registry and its own
agent guide live in `ponder/`;
read `ponder/AGENTS.md` before touching any of it. Entry tooltip fragments
compile against `template/lib.typ` plus `ponder/fragment-preamble.typ`, never a
course prelude, so an operator a summary uses must be declared in the preamble
too.
