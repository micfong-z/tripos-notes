# Ponder Course Notes Agent Guide

This repository contains Typst lecture notes and a Ponder knowledge layer. Use
this guide when adding Ponder support to this course or adapting the workflow
to another course repository.

## Mission

Build a source-grounded, reviewable concept layer over the notes:

- concepts have stable global IDs;
- source content remains authoritative in Typst;
- Ponder annotations are additive and reversible;
- existing PDF output and ordinary HTML references retain their behavior;
- generated website data is derived from the notes and entry files, never hand
  edited.

Do not treat Ponder as a second set of lecture notes. A Ponder entry indexes
and explains source material; it must not silently replace or rewrite it.

## Repository Discovery

All commands in this guide run from the `ponder/` directory, which is a
self-contained subproject of the notes repository: its `package.json`,
`tsconfig.json` and `node_modules` live here, and the notes tree is its parent.
Pass `--root` to point at a different checkout.

Before editing, identify:

1. the course configuration in `ponder/config.yml`;
2. the source Typst document and the shared template in `template/`;
3. the course's chapter and label conventions;
4. the target website repository, if export synchronization is required;
5. existing local instructions and uncommitted changes.

Course-specific values belong in `ponder/config.yml`, not in this guide or in
shared scripts. Keep paths repository-relative and do not assume the course is
Groups, Part IA, or mathematics.

### Course Sequencing

This workspace contains several courses and one shared Ponder entry registry.
`ponder/config.yml` only names the default course; each profile lives in
`ponder/courses/<course>.yml` and inherits the shared settings in
`ponder/courses/_defaults.yml`. A profile states only what differs, and its
chapter list is derived from `<course>/chapters/chapter-*.typ` unless it sets
`batchDocuments` explicitly. Select a profile for every non-default operation,
for example `--course differential-equations`, or `--course all` to sweep every
course. When adding another course chapter:

- inspect the selected config before editing and do not silently change the
  default course;
- use a concept-domain namespace for new IDs, such as `calculus.*`;
- keep source paths in `primarySource` and sections relative to the repository
  root, for example `part-ia/differential-equations/chapters/chapter-1.typ`;
- add labels to native source blocks before making them primary sources;
- validate source-backed entries with the selected profile; do not claim a full
  export until that profile's document and batch document list are selected
  together;
- process chapters in order so later entries can relate to earlier IDs without
  inventing forward links or duplicate concepts.

The completed Groups entries are the formatting and content model. They are
not evidence that a Differential Equations entry should use an `algebra.*` or
`geometry.*` ID.

### Working in Parallel

Several agents may work on different courses at the same time. Nothing
generated is shared between courses any more, so keep it that way:

- edit only the selected course's directory, its profile, and the entry
  directories that course owns;
- `ponder/entries/<id>/` is one directory per concept, so two agents adding
  different concepts never touch the same file;
- courses do annotate each other's concepts, so changing an existing entry's
  `kind`, `title`, or `summary` changes another course's output on its next
  export. Changing an entry another course owns is a cross-course edit: say so;
- `pnpm ponder:validate -- --course <name>` reports only what that course is
  responsible for. A half-finished entry in another course is a note, not a
  failure. Run `pnpm ponder:validate:all` before handing off;
- exports write a per-course tooltip shard and rebuild the merged index from
  every shard, so two exports running at once converge instead of overwriting
  each other.

### Namespace Vocabulary

Namespaces identify the mathematical domain of a concept, not the course in
which it first appears. Use the most specific existing namespace and do not
create a course-name namespace merely because a course profile exists.

The reserved vocabulary is:

| Namespace | Use for |
| --- | --- |
| `algebra` | groups, rings, homomorphisms, permutations, and abstract algebra |
| `calculus` | derivatives, integrals, Taylor theory, asymptotics, and routine calculus |
| `analysis` | rigorous real/complex analysis, limits, continuity, topology, and measure |
| `ode` | ordinary differential equations and their solution theory |
| `linear-algebra` | vector spaces, matrices, linear maps, eigenvalues, and forms |
| `geometry` | Euclidean, projective, differential, and geometric transformation concepts |
| `dynamics` | mechanics, dynamical systems, phase-space, and motion concepts |
| `relativity` | special or general relativity concepts |
| `probability` | probability spaces, random variables, distributions, and stochastic results |
| `statistics` | inference, estimation, regression, and statistical procedures |
| `number-theory` | divisibility, primes, congruences, and arithmetic theorems |
| `set-theory` | sets, relations, functions, cardinality, and foundational constructions |
| `combinatorics` | counting, graph theory, finite structures, and discrete enumeration |

IDs use the form `<namespace>.<concept-slug>`. Prefer an established
namespace over adding a synonym. Use `ode.*` for future differential-equation
solution concepts; the Chapter 1 derivative and Taylor entries have been
renamed to `calculus.*`. Course profile slugs such as
`differential-equations` remain valid operational names and are not concept
namespaces.

## Entry Contract

Read `ponder/ENTRY_FORMAT.md` before creating or changing entries. It is the
canonical schema reference. In particular:

- each entry is `ponder/entries/<id>/entry.yml`;
- the directory name and `id` must match;
- IDs are stable concept identifiers, not theorem numbers, headings, or URLs;
- `summary` is the only entry description source and is a Typst fragment;
- there is no top-level `description` field;
- `primarySource` identifies the authoritative labeled source block;
- every section has exactly one `source` or `supplemental` payload;
- the primary section's redundant web heading is suppressed, while supporting
  and supplemental sections keep their plain section headings;
- `related`, `aliases`, `tags`, and `variants` must reflect real data and may
  be empty where the schema permits it;
- source identity is `document + label`, never heading text, numbering, or a
  generated URL.

Use the existing notes palette and allowed kinds. The top-level kind controls
the concept accent; section kinds describe individual blocks. Do not invent a
new kind for a one-off entry without updating the shared schema and renderer.

## Source and Reference Rules

The primary source always maps its label to the entry. A supporting source maps
references only when it explicitly has `referenceTarget: true`. Validate that a
document/label pair maps to at most one entry or variant.

During export, derive source provenance from the labeled block and its single
nearest preceding heading. Do not store a copied heading, source URL, theorem
number, or display number in YAML. Headings and URLs are allowed to change.

Existing Typst references must remain references. Enrich a generated internal
HTML anchor only when its target label has a unique Ponder mapping. Preserve
its exact `href`, displayed text, and citation numbering. Leave unmapped
internal links, TOC links, external links, and all PDF references unchanged.

## Typst Annotation Rules

Use the shared `#ponder(id, variant: none, block: false)[body]` helper, which
every course gets from `template/lib.typ` via its own `prelude.typ`. It renders
as the original body in PDF and as a metadata-bearing anchor in HTML; the target
is selected by `--input target=html`, not by swapping template files.

Annotations must be:

- semantically unambiguous;
- applied to the smallest meaningful prose span;
- outside raw code and existing links;
- outside the contents of math unless the whole expression is deliberately
  selected as one target;
- free of nested Ponder anchors and nested ordinary links;
- safe when repeated or removed.

Note, you should

1. Identify every unambiguous, durable mathematical concept worth pondering.
   Do not wrap an entire theorem-like block title when the title is the same as
   the pondered concept. A distinct concept phrase within a composite title may
   still be annotated, for example “L'Hôpital's rule” in “Stronger version of
   L'Hôpital's rule”. The body should still be annotated nevertheless.
2. Reuse an existing global ID whenever the registry already represents it.
3. Create a new entry on the go when no registry entry represents the concept.
4. Annotate every unambiguous prose occurrence, including repeated occurrences.
5. Preserve the source wording exactly inside each #ponder wrapper.
6. Add a stable Typst label only when a new entry needs a primary source and
   the authoritative native block does not already have one.

Do not wrap an entire theorem, proof, corollary, or other native Typst block
inside another block. The native block already supplies its structure. A plain
section header is sufficient for supplemental or supporting content.

Do not annotate headings merely to make the heading itself interactive without
checking the generated outline. Typst copies heading content into the HTML
table of contents. The exporter must make TOC copies navigation-only: every
visible TOC fragment, including text after a Ponder term, must remain linked to
the heading fragment, while the actual document heading may retain Ponder
metadata.

## Automated/Luna Annotation Workflow

Automatic creation is allowed, but source edits are reviewed operations, not
free-form text replacement.

1. Inspect the existing registry and labels before proposing a concept.
2. Reuse an existing global concept ID when the concept is the same.
3. Propose new entries only when the source contains a distinct, reusable
   concept; include a source label and source-grounded summary.
4. Return exact source edit operations with enough context to detect stale
   input. Never return HTML or arbitrary regex replacements.
5. Never modify existing `@label` references or turn them into `#ponder` calls.
6. Reject stale, nested, linked, raw-code, and invalid math edits.
7. Record the model, prompt version, and input hash for every batch.
8. Apply reviewed results deterministically, then inspect the diff before
   compiling.

Prefer a small manually reviewed vertical slice before a whole-course batch.
The slice should include definitions, results, examples, proofs, warnings,
mapped references, unmapped references, and at least one whole-expression math
case where that feature is supported.

## Export and Website Rules

Use structural HTML parsing (`parse5` or the established parser helpers), not
regex rewriting, for block extraction, label mapping, reference enrichment,
TOC repair, and provenance.

Generate the course tooltip index and one lazy artifact per entry. Do not load
full entry bodies merely because a term or reference is visible. Keep the
delegated client controller single-instance and preserve no-JavaScript links.

Exports are multi-course and must be additive. Never recursively delete the
shared `ponder/dist/entries` directory or the website's shared
`_notes/IA/ponder/entries` directory. Write or overwrite only the selected
course's output and entry IDs.

Each course writes its tooltip records to its own shard, `ponder/dist/tooltip/
<course>.json`, and the merged `tooltip-index.json` is rebuilt as a pure
function of the shards present. Exporting one course therefore cannot drop
another course's records, and an entry deleted from a course disappears from
the merged index instead of lingering. If a shard is missing, the export says
so and names the courses to rebuild. `--prune` additionally deletes generated
artifacts whose ID no longer exists anywhere in the registry; it never removes
a directory.

Compiled Typst output is cached under `ponder/dist/.cache`, keyed by content:
fragments by their own text plus the shared template, the fragment preamble and
the Typst version, and the course document by everything it can read. Editing one
entry recompiles one fragment. Pass `--no-cache` after upgrading a Typst
*package*, which the key cannot see.

The web interaction contract is:

- neutral dotted underline for annotated prose;
- tooltip accent determined by kind;
- hover/focus previews the tooltip;
- click, Enter, or a completed 400 ms hold of `W` opens Ponder for normal terms;
- mapped references preserve citation navigation on click/tap while supporting
  tooltip preview and hold-`W` activation;
- cancellation handles key release, pointer departure, focus loss, blur,
  modifiers, autorepeat, and editable controls;
- modal navigation uses the canonical entry URL and browser history;
- nested Ponder navigation is capped at four visible levels;
- close, backdrop, Escape, Back, and Forward restore the correct history and
  focus state.

Use native dialog semantics and reduced-motion support. Do not add a listener
or mounted component per term.

## Verification

Run from the `ponder/` directory after each meaningful batch. Commands without
`--course` use the default course named in `ponder/config.yml`:

```sh
pnpm ponder:validate
pnpm ponder:test
pnpm ponder:check
pnpm ponder:export
```

For another course, select its profile on every command:

```sh
pnpm ponder:validate -- --course differential-equations
pnpm ponder:test
pnpm ponder:batch -- --course differential-equations
pnpm ponder:batch apply batches/annotation.jsonl --course differential-equations
pnpm ponder:export -- --course differential-equations --site-root /path/to/site
```

`ponder:validate` is scoped to the selected course: the entries it owns plus the
entries it annotates. `pnpm ponder:validate:all` sweeps the whole shared
registry and is what `ponder:check` runs. `ponder:export` accepts
`--course all`, `--no-cache`, and `--prune`. `ponder:batch` reads the resolved
`batchDocuments` list; it does not assume ten chapters or a `part-ia/groups/chapters`
directory. `ponder:test` is shared and does not need a course flag.

When a website repository is configured, synchronize it with:

```sh
pnpm ponder:export -- --site-root /path/to/site
```

Also compile both PDF and HTML. Check that:

- validation reports unique IDs, kinds, sources, variants, relations, and
  reference targets, and every annotated `#ponder` ID resolves to an entry;
- mapped references retain exact `href`, text, and numbering;
- unmapped and external links are unchanged;
- TOC anchors all remain fragment navigation, including text following
  annotated terms;
- actual document terms and headings retain only intended Ponder metadata;
- no entry body is fetched before activation;
- every kind resolves to the same accent in tooltip, entry view, and modal;
- generated artifacts stay within the configured size budgets;
- PDF source behavior and visual output have not regressed.

For UI changes, use desktop and mobile browser checks where available. Test
normal terms and references separately, including mouse, touch, keyboard,
hold cancellation, repeated activation after close, direct modal URLs, browser
Back/Forward, and no-JavaScript navigation.

## Change Discipline

Keep edits scoped to the requested course and preserve unrelated user changes.
Do not hand-edit generated HTML, indexes, or entry artifacts; regenerate them
with the exporter. Do not use destructive Git commands to clean the worktree.

Before handing off, report the files changed, commands run, any generated
artifacts updated, and any verification gap that remains.
