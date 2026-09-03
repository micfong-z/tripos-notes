// Optimisation: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/physica:0.9.8": *
#import "@preview/mannot:0.4.0": annot, mark, markul

#let hess = matbold(laplacian)
#let lagr = math.cal("L")
#let annot = annot.with(leader-connect: "elbow")

#let labelmat(..args, dx: 2em, dy: 1em) = {
  let mat = args.pos().at(0)
  let labels = args.pos().slice(1)

  let data = ()
  let augment = (:)
  if mat.has("augment") {
    augment = mat.augment
    if augment.at("stroke") == auto {
      let _ = augment.remove("stroke")
    }
  }

  let nrows = mat.rows.len()
  let ncols = mat.rows.at(1).len()

  if labels.len() != nrows + ncols {
    panic("Number of labels must be equal to number of rows plus number of columns")
  }

  for i in range(nrows) {
    let row = ()
    for j in range(ncols) {
      let elem = mat.rows.at(i).at(j)
      if i == 0 {
        elem = mark(elem, tag: label("c" + str(j)))
      }
      if j == 0 {
        elem = mark(elem, tag: label("r" + str(i)))
      }
      row.push(elem)
    }
    data.push(row)
  }

  std.math.mat(augment: augment, ..data)

  for i in range(nrows) {
    annot(label("r" + str(i)), pos: center, dx: -dx, leader: false, labels.at(i))
  }
  for j in range(ncols) {
    annot(label("c" + str(j)), pos: center, dy: -dy, leader: false, labels.at(nrows + j))
  }
}

