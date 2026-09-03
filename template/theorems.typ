// Theorem-like environments and callouts.
//
// Each renders as a showybox / left-ruled block in PDF and as a classed div in
// HTML. The `typst-*` class names and their nesting are a contract with
// ponder/scripts/document-index.ts (block extraction) and the website CSS.

#import "@preview/showybox:2.0.4": showybox
#import "@preview/ctheorems:1.1.3": *
#import "@preview/titleize:0.1.1": titlecase
#import "config.typ": colors, is-html

// ---------------------------------------------------------------- coloured boxes

#let showybox-colored(
  shade700: rgb("#A14A13"),
  shade500: rgb("#EC6F27"),
  shade100: rgb("#FCD6C0"),
  shade50: rgb("#FFE7DA"),
  title: "Orange",
  footer: "",
  body,
) = [
  #showybox(
    title: title,
    footer: footer,
    breakable: true,
    frame: (
      radius: 0pt,
      border-color: shade500,
      title-color: shade100,
      body-color: colors.page,
      footer-color: shade50,
      thickness: (left: 0.75pt),
      body-inset: 1em,
    ),
    title-style: (
      color: shade700,
      sep-thickness: 0pt,
    ),
    body-style: (
      color: colors.text,
    ),
    footer-style: (
      color: colors.text,
      sep-thickness: 0pt,
    ),
    body,
  )
]

#let showybox-html-colored(suffix, title: "Orange", footer: "", body, color) = {
  html.div(class: "typst-showybox-" + suffix + " typst-showybox")[
    #html.div(class: "typst-showybox-" + suffix + "-title")[
      #block(
        text(fill: color.shade700, title),
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

#let showybox-of(suffix) = (title: suffix, footer: "", body) => if is-html {
  showybox-html-colored(suffix, title: title, footer: footer, body, colors.at(suffix))
} else {
  showybox-colored(title: title, footer: footer, ..colors.at(suffix), body)
}

#let showybox-orange = showybox-of("orange")
#let showybox-yellow = showybox-of("yellow")
#let showybox-red = showybox-of("red")
#let showybox-blue = showybox-of("blue")
#let showybox-purple = showybox-of("purple")

// ------------------------------------------------------------------- thm wrappers

#let thmenv-wrapped(type, box) = thmenv(
  "mathematics",
  "heading",
  1,
  (name, number, body, footer: "") => [
    #if (name != none) and (name != "") {
      name = "(" + name + ")"
    }
    #box(
      title: [*#type #number* #titlecase(name)],
      footer: footer,
    )[#body]
  ],
)

#let sol-thmenv-wrapped(type, box) = thmenv(
  "solutions",
  "heading",
  2,
  (name, number, body, footer: "") => [
    #box(
      title: [*#type Ex. #number*],
      footer: footer,
    )[#body]
  ],
).with(numbering: (..nums) => nums.pos().slice(1).map(str).join("."))

#let theorem(..args) = thmenv-wrapped("Theorem", showybox-orange)(supplement: "Theorem", ..args)
#let lemma(..args) = thmenv-wrapped("Lemma", showybox-orange)(supplement: "Lemma", ..args)
#let proposition(..args) = thmenv-wrapped("Proposition", showybox-orange)(supplement: "Proposition", ..args)
#let corollary(..args) = thmenv-wrapped("Corollary", showybox-yellow)(supplement: "Corollary", ..args)
#let definition(..args) = thmenv-wrapped("Definition", showybox-red)(supplement: "Definition", ..args)
#let law(..args) = thmenv-wrapped("Law", showybox-orange)(supplement: "Law", ..args)
#let axiom(..args) = thmenv-wrapped("Axiom", showybox-orange)(supplement: "Axiom", ..args)
#let listing(..args) = thmenv-wrapped("Listing", showybox-orange)(supplement: "Listing", ..args)
#let rule(..args) = thmenv-wrapped("Rule", showybox-orange)(supplement: "Rule", ..args)
#let question(..args) = thmenv-wrapped("Question", showybox-blue)(supplement: "Question", ..args)
#let example(..args) = thmenv-wrapped("Example", showybox-blue)(supplement: "Example", ..args)
#let solution(..args) = sol-thmenv-wrapped("Solution for", showybox-purple)(supplement: "Exercise", ..args)

// ----------------------------------------------------------------------- callouts

/// A left-ruled note. `accent` is none for the neutral (proof) style, otherwise
/// a palette family whose shade500 rules the edge and shade700 marks the label.
#let callout(name, accent, content, label: none) = {
  let marker = if label == none { [_*#name.*_] } else { label }
  if is-html {
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
    block(
      stroke: (left: 0.75pt + if accent == none { colors.gray } else { accent.shade500 }),
      block(
        width: 100%,
        inset: (left: 1em, top: 0.5em, bottom: 0.5em),
        if accent == none { marker } else { text(fill: accent.shade700, marker) } + content,
      ),
    )
  }
}

#let proof(content) = callout("Proof", none, content)
#let prooflike(type, content) = callout("Proof", none, content, label: [_*#type.*_])
#let remark(content) = callout("Remark", colors.blue, content)
#let remarklike(type, content) = callout("Remark", colors.blue, content, label: [_*#type.*_])
#let important(content) = callout("Important", colors.yellow, content)
#let notation(content) = callout("Notation", colors.blue, content)
#let claim(content) = callout("Claim", colors.orange, content)
#let exercise(content) = callout("Exercise", colors.purple, content)
