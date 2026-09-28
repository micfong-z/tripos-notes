// Heading structure, shared by the layouts, the furniture and the numbering.
//
// A series nests each volume's headings one level down (`heading(offset: 1)`)
// under a hidden level-1 heading per volume, so the PDF outline groups every
// volume's chapters under its title. Anything that means "chapter" therefore
// keys on a heading's `depth` (its number of `=`), which the offset leaves
// alone, rather than on its `level`, which the PDF outline uses.

/// Labels a volume's hidden heading, which exists only for the PDF outline.
#let volume-heading-label = <micfong-volume-heading>

#let is-volume-heading(hd) = hd.at("label", default: none) == volume-heading-label

/// The current chapter's number, whatever the heading offset. Needs context.
#let chapter-number() = counter(heading).get().at(heading.offset, default: 0)

/// Numbering for a volume's headings: the counter carries an unused slot for
/// the (unnumbered) volume heading, which is dropped.
#let volume-numbering(..n) = numbering("1.1", ..n.pos().slice(1))
