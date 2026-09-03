# Ponder Entry YAML Format

Each ponder entry lives in its own directory:

```text
ponder/entries/<entry-id>/
  entry.yml
  summary.typ
  body.typ          # Optional supplemental content
```

The directory name must exactly match the `id` in `entry.yml`.

## Complete Template

```yaml
# Stable global concept ID. It must also be the directory name.
id: subject.concept-name

# Canonical kind for the entry as a whole.
kind: definition

# Human-readable canonical title.
title: Concept Name

# Wikidata QID for the concept.
wikidataQID: Q123456

# Alternative names that should identify the same concept.
# An empty array is valid.
aliases:
  - first alternative
  - second alternative

# Search, grouping, and migration metadata.
# An empty array is valid.
tags:
  - topic
  - technique

# Typst fragment used as both the tooltip summary and the description at the
# top of the ponder entry view. The path is relative to this entry directory.
summary: summary.typ

# The authoritative labeled Typst block for this entry.
primarySource:
  document: part-ia/groups/chapters/chapter-n.typ
  label: source-label
  kind: definition

# Ordered content shown in the ponder entry view. At least one section is
# required. Every section must specify exactly one of `source` or
# `supplemental`.
sections:
  # A section backed by the primary source. Its section heading is suppressed
  # in the web view because the Typst block already has its own heading.
  - title: Definition
    kind: definition
    source:
      document: part-ia/groups/chapters/chapter-n.typ
      label: source-label

  # A supporting labeled block. `referenceTarget: true` makes references to
  # this label open this ponder entry as well. Omit it or set it to false when
  # the block is merely supporting material.
  - title: Consequence
    kind: corollary
    source:
      document: part-ia/groups/chapters/chapter-n.typ
      label: supporting-label
      kind: corollary
      referenceTarget: true

  # Supplemental Typst written specifically for the ponder entry.
  - title: Interpretation
    kind: remark
    supplemental: body.typ

# IDs of other ponder entries. Every ID must exist and must differ from this
# entry's own ID. An empty array is valid.
related:
  - subject.related-concept
  - subject.another-concept

# Optional course or convention variants. Variant keys are stable slugs.
variants:
  variant-name:
    title: Human-readable variant title
    description: A concise explanation of what differs in this variant.
    primarySource:
      document: part-ia/groups/chapters/chapter-n.typ
      label: variant-source-label
      kind: definition
```

## Top-Level Fields

| Field | Required | Meaning |
| --- | --- | --- |
| `id` | Yes | Stable global concept ID and entry directory name. |
| `kind` | Yes | Canonical kind controlling the entry accent and classification. |
| `title` | Yes | Canonical display title. |
| `wikidataQID` | No | Wikidata QID for the concept. |
| `aliases` | Yes | Alternative names for tooltips, discovery, and annotation. May be empty. |
| `tags` | Yes | Search and organizational metadata. May be empty. |
| `summary` | Yes | Entry-relative Typst fragment used by the tooltip and entry header. |
| `primarySource` | Yes | Authoritative `{document, label}` source for the concept. |
| `sections` | Yes | Ordered entry content. Must contain at least one section. |
| `related` | Yes | IDs of related ponder entries. May be empty. |
| `variants` | No | Named course, notation, or convention variants. |

There is no top-level `description` field. Write the description in the Typst
file referenced by `summary`.

Summary and supplemental fragments compile with the course notation declared
in `ponder/fragment-preamble.typ`. Add a reusable course operator there rather
than redefining it independently in entry fragments.

## Allowed Kinds

```text
term
noun
definition
theorem
proposition
lemma
claim
corollary
warning
important
example
remark
notation
proof
exercise
solution
```

The top-level `kind` describes the concept. Each section has its own `kind`, so
a definition entry may contain a theorem, example, proof, warning, or exercise.

## Source References

A source reference has this shape:

```yaml
document: part-ia/groups/chapters/chapter-n.typ
label: typst-label
kind: theorem
referenceTarget: true
```

| Field | Required | Meaning |
| --- | --- | --- |
| `document` | Yes | Repository-relative Typst source file. It may not escape the repository. |
| `label` | Yes | Typst label written as `<typst-label>` in that document. |
| `kind` | No | Kind of the referenced block. Useful source metadata. |
| `referenceTarget` | No | On a supporting section source, maps references to this label to the entry. Defaults to false. |

`primarySource` is always a reference target. A particular
`document#label` may map to at most one entry. Supporting blocks may
appear in multiple entries when `referenceTarget` is omitted or false.

Source identity comes from `document` and `label`, not headings, numbering, or
URLs. During export, the source record is generated from the compiled document:

- `href` is `ponder/config.yml`'s `sourceBase` plus `#<label>`;
- `display` is extracted from the labeled Typst block's native title;
- `heading` is the single nearest preceding document heading;
- `role` is `primary`, `supporting`, or `variant`.

Do not store source URLs, theorem numbers, or heading text in `entry.yml`; they
are derived again on every export.

## Sections

Every section requires `title` and `kind`, plus exactly one content source:

```yaml
# Existing labeled Typst block
- title: Statement
  kind: theorem
  source:
    document: part-ia/groups/chapters/chapter-n.typ
    label: theorem-label

# Entry-local Typst fragment
- title: Proof idea
  kind: proof
  supplemental: body.typ
```

If a section's source matches `primarySource.document` and
`primarySource.label`, its plain web section heading is hidden. The native Typst
block remains unchanged. Supporting and supplemental sections retain their
plain section headings.

Supplemental paths are relative to the entry directory. A section may not have
both `source` and `supplemental`, and it may not omit both.

## Variants

Variant keys must match:

```text
^[a-z][a-z0-9-]*$
```

Each variant requires a `title` and `description`. `primarySource` is optional
and should be supplied when the variant has its own labeled statement.

Variants change course-specific wording, notation, or conventions without
creating a second global concept ID.

## ID Rules

Entry IDs must match:

```text
^[a-z][a-z0-9]*(?:[.-][a-z0-9]+)+$
```

Examples:

```text
algebra.group
algebra.lagrange-theorem
analysis.mean-value-theorem
```

IDs are stable data keys. Do not change an ID merely because the displayed
title, course numbering, source heading, or URL changes.

Choose IDs from the controlled concept namespaces in the repository's
`AGENTS.md`. A course profile name is not automatically a concept namespace:
for example, derivative and Taylor concepts use `calculus.*`, while future
differential-equation solution concepts should use `ode.*`.

## Validation And Export

From the `ponder/` directory, the commands without a profile use the
legacy/default `ponder/config.yml` course:

```sh
pnpm ponder:validate
pnpm ponder:test
pnpm ponder:export
```

This repository supports multiple course profiles. A profile is a YAML file
under `ponder/courses/` and supplies the source document, generated
kind registry, output filename, and exact batch document list. Select one with:

```sh
pnpm ponder:validate -- --course differential-equations
pnpm ponder:batch -- --course differential-equations
pnpm ponder:export -- --course differential-equations
```

Do not change `ponder/config.yml` merely to work on another course. Add or use
the appropriate profile instead. The shared `ponder/entries` registry may
contain entries for several courses; source validation is profile-independent,
while export compiles only the selected profile's document.

To synchronize generated artifacts into the website:

```sh
pnpm ponder:export -- --site-root /path/to/ms-academic
```

## Reviewed Automatic Creation

The Luna annotation batch receives the existing registry and may return three
types of reviewed operations:

- exact `#ponder` wrapper edits for existing or newly proposed concepts;
- exact Typst label insertions needed by new primary sources;
- new concept proposals containing registry metadata, a source-grounded Typst
  summary, and a labeled primary source.

Applying a reviewed result creates a minimal valid directory with `entry.yml`
and `summary.typ`. The ID is immediately usable in Typst: `#ponder` records only
the ID, and the exporter resolves the kind from this registry, so nothing has to
be regenerated first. Proof, example, supporting-source, relation,
variant, and verified Wikidata enrichment can follow in an authoring pass. The
deterministic applicator rejects stale or overlapping edits, unknown IDs,
invalid kinds or QIDs, unclaimed or duplicate label edits, missing source
labels, duplicate source mappings, nested wrappers, and edits to references,
code, comments, or math.

From `Part IA/`, prepare or apply reviewed batches with:

```sh
pnpm ponder:batch
pnpm ponder:batch apply batches/reviewed-result.json
```

Validation checks IDs, kinds, primary and section source labels, source files,
supplemental files, relations, variant keys, one-to-one reference-target
mappings, and that every annotated `#ponder` ID resolves to an entry. It is
scoped to the selected course unless run with `--all`. Export compiles the summary and supplemental Typst, extracts labeled
source blocks structurally, enriches mapped references without changing their
original href or text, and emits the tooltip index plus one JSON artifact per
entry.

Content-selection, summary-writing, annotation-density, nested-ponder, and
Wikidata policies live in `ponder/prompts/entry-authoring.txt` and
`ponder/prompts/annotation.txt`. This document is the deterministic YAML and
export contract.
