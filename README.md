# Tripos Notes

Typst lecture notes for the Cambridge Mathematical Tripos, written by Micfong
(Zixuan). They are not endorsed by the lecturers or the University, and all
errors are my own.

The web edition, with hover-and-click concept explanations, is at
[academic.micfong.space](https://academic.micfong.space).

## Courses

| Course | Lecturer | Lectured in | Version |
| --- | --- | --- | --- |
| Part IA – Analysis I | Dr Rita Teixeira da Costa | Lent 2026 | Version 20260522 |
| Part IA – Differential Equations | Prof Christopher Thomas | Michaelmas 2025 | Version 20260111 |
| Part IA – Dynamics and Relativity | Prof Sean Hartnoll | Lent 2026 | Version 20260609 |
| Part IA – Groups | Prof Henry Wilton | Michaelmas 2025 | Version 20260607 |
| Part IA – Numbers and Sets | Dr Zoe Wyatt | Michaelmas 2025 | Version 20260608 |
| Part IA – Probability | Prof Perla Sousi | Lent 2026 | Version 20260523 |
| Part IA – Vectors and Matrices | Dr Ángela Capel Cuevas | Michaelmas 2025 | Version 20251217 |
| Part IB – Optimisation | Prof Varun Jog | Easter 2026 | Work in Progress |
| Part IB – Variational Principles | Prof Harvey Reall | Easter 2026 | Work in Progress |

## Reading the notes

Compiled PDFs are attached to each [release] and served from
`storage.micfong.space/notes/`. Every course is published in four variants, so
pick the one you like:

|  | Sans | Serif |
| --- | --- | --- |
| **Light** | IBM Plex Sans + Lete Sans Math | IBM Plex Serif + IBM Plex Math |
| **Dark** | IBM Plex Sans + Lete Sans Math | IBM Plex Serif + IBM Plex Math |

The Part IA courses are also collected into one document, *Tripos Notes: Part
IA* (`S/ACD/UND/NTE/1`): a cover indexing every course, then each course as a
volume with its own cover, doc id and page numbers.

[release]: https://github.com/micfong-z/tripos-notes/releases

## Building them yourself

You need [Typst](https://typst.app) 0.15.1 (the version in `.typst-version`)
and [just](https://github.com/casey/just). The fonts are vendored in `fonts/`,
and builds ignore system fonts, so a compile here matches CI exactly.

```sh
just build part-ia/groups              # light, sans
just build part-ia/groups dark serif   # any of the four variants
just build-all                         # every course, all variants -> build/
just series                            # every Part IA course in one PDF
just series dark serif                 # any of the four variants
just watch part-ia/groups              # recompile on save
```

Compiling a course directly needs `--root .`, because the shared template is
imported as `/template/lib.typ`:

```sh
typst compile --root . --font-path fonts --ignore-system-fonts \
  --input theme=dark --input font=serif part-ia/groups/main.typ notes.pdf
```

## Layout

```
template/          the notes' template, theme- and font-aware
template/micfong/  the Micfong design system it is built on, vendored
part-ia/<course>/  main.typ, meta.typ, content.typ, prelude.typ, symbols.typ,
                   chapters/, media/
part-ia/series.typ every Part IA course as one series
part-ib/<course>/  same shape
fonts/             vendored OFL faces and their licences
ponder/            the concept layer behind the web edition
```

A course's identity (title, lecturer, doc id) lives in `meta.typ` and its body
in `content.typ`, so the standalone book (`main.typ`) and the series volume
share both. The chapters import only `../prelude.typ`, which re-exports the
shared template plus that course's own notation from `symbols.typ`.

## Ponder

`#ponder("algebra.group")[Groups]` marks a phrase in the source. It is invisible
in the PDF and becomes an anchor in the HTML export, which the website turns into
a tooltip and a concept page. The tooling and the entry registry live in
`ponder/`; see `ponder/AGENTS.md`.

```sh
cd ponder && pnpm install
pnpm ponder:check                      # validate the registry and run the tests
```

## LLM Usage Disclaimer

LLMs have been used to assist in organising this repository, including generating
the README, build scripts and the Ponder registry. However, all notes and figures
are created by a human being.

## Licence

The notes, including the figures, are licensed under
[CC BY-NC-SA 4.0](LICENSE). The code, meaning `template/` and `ponder/`, is
licensed under the [MIT licence](LICENSE-CODE), except the Material Design
Icons in `template/micfong/assets/mdi.json`, which are by Pictogrammers under
the Apache 2.0 licence.

The fonts in `fonts/` are redistributed under the SIL Open Font Licence; each
family's licence is in `fonts/LICENSES/`. IBM Plex Sans 3, Lete Sans Math 0.62,
IBM Plex Serif 3.006, IBM Plex Math 1.000 and JetBrains Mono.
