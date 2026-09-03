// The single import for every notes document:
//
//     #import "/template/lib.typ": *
//
// Root-absolute, so it reads the same from a course, a chapter or the Ponder
// exporter's staging tree. Compiling therefore requires `--root .`; the
// justfile and the exporter both pass it.

#import "config.typ": apply-fonts, colors, font, fonts, is-html, target, theme
#import "palette.typ": color-palette
#import "fonts.typ": font-suites, mono
#import "math.typ": *
#import "elements.typ": *
#import "theorems.typ": *
#import "ponder.typ": ponder
#import "project.typ": project
