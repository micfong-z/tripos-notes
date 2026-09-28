// Maths shorthands shared by every course: the design system's `maths` module,
// re-exported so chapters reach them without a second import. Course-specific
// operators live in each course's `symbols.typ`, which may also shadow a name
// defined here (Groups redefines `im` as the image operator, for instance).
//
// Vector, gradient and transpose notation is physica's, imported by the
// symbols.typ of each course that needs it: `vb`, `vu`, `grad`, `TT`,
// `vecrow`, `iprod`. Only what physica has no equivalent for lives here.

#import "micfong/src/maths.typ": argmax, argmin, ee, eval, ii, im, img, matbold, mathsec, ppi, re
