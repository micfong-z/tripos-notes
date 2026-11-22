// Variational Principles: the single import for this course.
// Chapters and content.typ import this file and nothing else.

#import "/template/lib.typ": *
#import "symbols.typ": *
#import "meta.typ": meta

// Lets a chapter compile alone; see `chapter` in the shared template.
#let chapter = chapter.with(meta)
