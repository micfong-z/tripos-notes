// Methods: the single import for this course.
// Chapters and content.typ import this file and nothing else.

#import "/template/lib.typ": *
#import "symbols.typ": *
#import "meta.typ": meta

// Lets a chapter compile alone; see `chapter` in the shared template. It also
// applies the notation rules from symbols.typ, in every build.
#let chapter = {
  let template-chapter = chapter.with(meta)
  (number, body) => template-chapter(number, notation-rules(body))
}
