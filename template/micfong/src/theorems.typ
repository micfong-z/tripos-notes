// Theorem-like environments and mathematical callouts.
//
// Every environment is a figure of one shared kind, so they share one counter
// (Definition 1.1, Example 1.2, Theorem 1.3...), number within the top-level
// heading, and can be labelled and referenced like any figure:
//
//     #theorem("Lagrange")[...] <lagrange>
//     By @lagrange, ...                       // "By Theorem 3.2, ..."

#import "elements.typ": callout, panel
#import "structure.typ": chapter-number

#let thm-kind = "micfong-theorem"

/// `<chapter>.<n>`. Typst calls figure numbering in the figure's context, so
/// references resolve to the chapter the theorem sits in.
#let thm-numbering(n) = numbering("1.1", chapter-number(), n)

/// Make a new environment. `accent` is a colour family name.
///
///     #let conjecture = theorem-env("Conjecture", accent: "purple")
#let theorem-env(supplement, accent: "orange") = (..args) => {
  let pos = args.pos()
  assert(pos.len() in (1, 2), message: supplement + " takes an optional name and a body")
  let (name, body) = if pos.len() == 2 { pos } else { (none, pos.first()) }
  let footer = args.named().at("footer", default: none)
  figure(
    kind: thm-kind,
    supplement: supplement,
    numbering: thm-numbering,
    outlined: false,
    context {
      let number = numbering(thm-numbering, ..counter(figure.where(kind: thm-kind)).get())
      let title = [*#supplement #number*]
      if name not in (none, "") { title += [ (#name)] }
      panel(title: title, accent: accent, footer: footer, body)
    },
  )
}

/// Show rules for the environments. The layouts apply these.
#let theorem-rules(body) = {
  show figure.where(kind: thm-kind): set block(breakable: true)
  show figure.where(kind: thm-kind): set align(start)
  show figure.where(kind: thm-kind): it => it.body
  body
}

#let theorem = theorem-env("Theorem")
#let lemma = theorem-env("Lemma")
#let proposition = theorem-env("Proposition")
#let corollary = theorem-env("Corollary", accent: "yellow")
#let definition = theorem-env("Definition", accent: "red")
#let law = theorem-env("Law")
#let axiom = theorem-env("Axiom")
#let rule = theorem-env("Rule")
#let question = theorem-env("Question", accent: "blue")
#let example = theorem-env("Example", accent: "blue")

// Callouts carry no number. Proof is neutral; the rest take a family colour.
#let proof(body) = callout("Proof", body)
#let prooflike(type, body) = callout("Proof", label: [*#type.*], body)
#let remark(body) = callout("Remark", accent: "blue", body)
#let remarklike(type, body) = callout("Remark", accent: "blue", label: [*#type.*], body)
#let notation(body) = callout("Notation", accent: "blue", body)
#let claim(body) = callout("Claim", accent: "orange", body)
#let exercise(body) = callout("Exercise", accent: "purple", body)
