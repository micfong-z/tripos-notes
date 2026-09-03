#import "prelude.typ": *

#show: project.with(
  title: "Part IB\nOptimisation",
  lecturer: "Prof Varun Jog",
  lectured-in: "Easter 2026",
  updated: "Work in Progress",
  doc-id: "D/ACD/UND/NTE/8",
  authors: ("Micfong",),
  cover-design: [
    #block(height: 100% - 6em, width: 100%, stroke: colors.border-light + 0.75pt)[
      #dynamic-svg2("/part-ib/optimisation/media/cover.svg", width: 100%, height: 100%)
    ]
  ],
)

These are Zixuan's notes for *Part IB – Optimisation* at the University of Cambridge in 2026. The notes are not endorsed by the lecturers or the University, and all errors are my own.

The latest version of this document is available at #link("https://academic.micfong.space")[academic.micfong.space]. Please direct any comments to my CRSid email or use the contact details listed on the site.

This document is typeset using #link("https://typst.app/")[Typst]. All figures are created using #link("https://inkscape.org/")[Inkscape].

#fade[The cover art of the PDF version of this document reads /ɒp-tɪ-maɪ-zɛɪ-ʃən/ in #link("https://www.omniglot.com/conscripts/patternscript.htm")[Pattern Script].]

#outline()

#pagebreak()

#include "chapters/syllabus.typ"

#counter(heading).update(0)

#pagebreak()

#include "chapters/chapter-1.typ"

#pagebreak()

#include "chapters/chapter-2.typ"

#pagebreak()

#include "chapters/chapter-3.typ"

#pagebreak()

#include "chapters/chapter-4.typ"

#end-of-document()
