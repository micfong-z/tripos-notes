// Theorem-like environments and callouts.
//
// In PDF these are the design system's: every environment is a figure of one
// shared kind, numbered within the top-level heading, drawn as a titled panel.
// In HTML they stay ctheorems environments rendered as classed divs, because
// the `typst-*` class names and their nesting are a contract with
// ponder/scripts/document-index.ts (block extraction) and the website CSS.
//
// Either way a name is title-cased, as the notes have always done, and a
// labelled environment is referenced as "Theorem 3.2".

#import "@preview/ctheorems:1.1.3": thmenv, thmrules
#import "@preview/titleize:0.1.1": titlecase
#import "micfong/src/theorems.typ" as ds
#import "micfong/src/elements.typ": (
  callout as ds-callout, caution as ds-caution, important as ds-important, note as ds-note, rule as ds-rule,
  tip as ds-tip, warning as ds-warning,
)
#import "config.typ": colors, is-html

// ------------------------------------------------------------------------- HTML

#let _html-box(suffix, title: "", footer: "", body) = {
  html.div(class: "typst-showybox-" + suffix + " typst-showybox")[
    #html.div(class: "typst-showybox-" + suffix + "-title")[
      #block(
        text(fill: colors.at(suffix).shade700, title),
      )
    ]
    #html.div(class: "typst-showybox-body")[
      #block(body)
    ]
    #html.div(class: "typst-showybox-" + suffix + "-footer")[
      #block(footer)
    ]
  ]
}

#let _html-env(type, accent) = thmenv(
  "mathematics",
  "heading",
  1,
  (name, number, body, footer: "") => [
    #if (name != none) and (name != "") {
      name = "(" + name + ")"
    }
    #_html-box(
      accent,
      title: [*#type #number* #titlecase(name)],
      footer: footer,
    )[#body]
  ],
).with(supplement: type)

// -------------------------------------------------------------------------- PDF

#let _pdf-env(type, accent) = {
  let env = ds.theorem-env(type, accent: accent)
  (..args) => {
    let pos = args.pos()
    if pos.len() == 2 and pos.at(0) not in (none, "") { pos.at(0) = titlecase(pos.at(0)) }
    env(..pos, ..args.named())
  }
}

// ------------------------------------------------------------------ environments

#let _env(type, accent) = if is-html { _html-env(type, accent) } else { _pdf-env(type, accent) }

#let theorem = _env("Theorem", "orange")
#let lemma = _env("Lemma", "orange")
#let proposition = _env("Proposition", "orange")
#let corollary = _env("Corollary", "yellow")
#let definition = _env("Definition", "red")
#let law = _env("Law", "orange")
#let axiom = _env("Axiom", "orange")
#let listing = _env("Listing", "orange")
#let rule = _env("Rule", "orange")
#let question = _env("Question", "blue")
#let example = _env("Example", "blue")

/// ctheorems' show rules, which only the HTML body needs.
#let html-theorem-rules = thmrules

// ----------------------------------------------------------------------- callouts

/// A left-ruled note. `accent` is none for the neutral (proof) style, otherwise
/// a colour family whose base shade rules the edge and whose strong shade marks
/// the label.
#let callout(name, accent, content, label: none) = if is-html {
  let marker = if label == none { [_*#name.*_] } else { label }
  let class = "typst-" + lower(name)
  html.div(
    class: class + " typst-simple-callout",
    block(
      width: 100%,
      inset: (left: 1em, top: 0.5em, bottom: 0.5em),
      if accent == none { marker } else {
        html.span(class: class + "-marker", marker)
      }
        + content,
    ),
  )
} else {
  ds-callout(name, accent: accent, label: if label == none { auto } else { label }, content)
}

#let proof(content) = callout("Proof", none, content)
#let prooflike(type, content) = callout("Proof", none, content, label: if is-html [_*#type.*_] else [*#type.*])
#let remark(content) = callout("Remark", colors.blue, content)
#let remarklike(type, content) = callout("Remark", colors.blue, content, label: if is-html [_*#type.*_] else [*#type.*])
#let important(content) = if is-html { callout("Important", colors.yellow, content) } else { ds-important(content) }
#let notation(content) = callout("Notation", colors.blue, content)
#let claim(content) = callout("Claim", colors.orange, content)
#let exercise(content) = callout("Exercise", colors.purple, content)

// The design system's alerts draw an MDI icon, which needs the collection only
// its PDF layouts provide; in HTML they are plain callouts, as `important` is.
#let note(content) = if is-html { callout("Note", colors.blue, content) } else { ds-note(content) }
#let tip(content) = if is-html { callout("Tip", colors.green, content) } else { ds-tip(content) }
#let warning(content) = if is-html { callout("Warning", colors.orange, content) } else { ds-warning(content) }
#let caution(content) = if is-html { callout("Caution", colors.red, content) } else { ds-caution(content) }

// ---------------------------------------------------------------------- intuition

/// An aside for intuition rather than proof: a picture, a worked case, the
/// idea behind a statement. Every one carries the label `<intuition>`, so a
/// document drops them all with one rule before its content, as in
///
///     #show <intuition>: none
///     #include "content.typ"
///
/// They are unnumbered and hold no labels, so dropping them renumbers nothing
/// and breaks no reference. In PDF each is a box ruled all round with a dashed
/// purple line, with no heading; in HTML it is a simple callout without its
/// marker, so the exporter still treats it as a source block.
#let intuition(content) = {
  let aside = if is-html {
    html.div(class: "typst-intuition typst-simple-callout", block(width: 100%, content))
  } else {
    block(
      width: 100%,
      stroke: (paint: colors.purple.base, thickness: ds-rule, dash: "dashed"),
      inset: (x: 1em, y: 0.75em),
      breakable: true,
      content,
    )
  }
  [#aside<intuition>]
}
