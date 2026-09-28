// The single import for every notes document:
//
//     #import "/template/lib.typ": *
//
// Root-absolute, so it reads the same from a course, a chapter or the Ponder
// exporter's staging tree. Compiling therefore requires `--root .`; the
// justfile and the exporter both pass it.
//
// The PDF design is the Micfong design system, vendored in `micfong/` (see its
// README.md). The files beside this one keep the notes' own API on top of it,
// and the HTML export the Ponder exporter depends on.

#import "config.typ": apply-fonts, colors, font, fonts, is-dark, is-html, mono, target, theme
#import "math.typ": *
#import "elements.typ": *
#import "theorems.typ": *
#import "ponder.typ": ponder
#import "project.typ": project, series, volume

// Design-system elements the notes use as they are.
#import "micfong/lib.typ": badge, caution, divider, figure-required, icon, kbd, note, palette, panel, tip, warning
