// Ponder annotation shim.
//
// The concept kind is derived data. The exporter stamps data-ponder-kind onto
// every anchor from the shared entry registry, so this helper stays independent
// of which entries exist and an unregistered id can never break a compile.
//
// In PDF the annotation is invisible: it renders as its own body. Only the HTML
// target emits an anchor. This is what keeps ~4000 inline #ponder calls in the
// chapter sources free of any cost to the paged output.

#import "config.typ": is-html

#let ponder(id, variant: none, block: false, body) = {
  if is-html {
    let attrs = (
      "class": "ponder-anchor" + if block { " ponder-anchor-block" } else { "" },
      "href": "/en-US/notes/ponder/" + id,
      "data-ponder-id": id,
    )
    if variant != none {
      attrs.insert("data-ponder-variant", variant)
    }
    html.elem("a", attrs: attrs, body)
  } else {
    body
  }
}
