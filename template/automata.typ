// State diagrams, for finite automata and Markov chains, drawn by the finite
// package in the notes' colours with nothing placed by hand.
//
// Not re-exported from lib.typ: a course that draws state diagrams imports this
// module from its symbols.typ, so the other courses never load cetz or the
// Graphviz plugin that finite depends on.
//
//     #import "/template/automata.typ": automaton, markov-chain
//
// States go on a line, a circle or wherever Graphviz puts them. Each transition
// then takes the straightest path that clears the other states and labels, a
// pair of opposite transitions bowing just enough to part; loops and the
// initial arrow point where the transitions leave the most room; and labels
// stay upright, set just clear of their arrow on its outer side.

#import "@preview/finite:0.5.1" as finite
#import "@preview/diagraph-layout:0.0.1" as dia
#import "config.typ": colors, is-html
#import "micfong/src/elements.typ": rule

#let _bez = finite.draw.util

// Distances are in centimetres, the canvas unit.
#let _gap = 0.08 // between a label and its arrow
#let _clear = 0.12 // between a transition and a state it passes
#let _bend-step = 0.2 // how far each step bows a transition at its middle
#let _loop = 0.4 // how far a loop reaches beyond its state
#let _initial = 0.5 // length of the initial arrow

// Directions a loop or the initial arrow may take, as unit vectors. The ones
// off the 45° grid cost a little, so they are taken only when they help.
#let _directions = range(16).map(i => (
  u: (calc.cos(i * 22.5deg), calc.sin(i * 22.5deg), 0.0),
  taste: if calc.odd(i) { 0.5 } else { 0 },
))

// ------------------------------------------------------------------- vectors
// Points are (x, y, 0) with y up, as cetz and finite use them.

#let _v(x, y) = (float(x), float(y), 0.0)
#let _add(a, b) = _v(a.at(0) + b.at(0), a.at(1) + b.at(1))
#let _sub(a, b) = _v(a.at(0) - b.at(0), a.at(1) - b.at(1))
#let _mul(a, k) = _v(a.at(0) * k, a.at(1) * k)
#let _dot(a, b) = a.at(0) * b.at(0) + a.at(1) * b.at(1)
#let _cross(a, b) = a.at(0) * b.at(1) - a.at(1) * b.at(0)
#let _len(a) = calc.sqrt(_dot(a, a))
#let _unit(a) = if _len(a) == 0 { _v(0, 0) } else { _mul(a, 1 / _len(a)) }

#let _seg-dist(p, a, b) = {
  let ab = _sub(b, a)
  let t = if _dot(ab, ab) == 0 { 0.0 } else { calc.clamp(_dot(_sub(p, a), ab) / _dot(ab, ab), 0.0, 1.0) }
  _len(_sub(p, _add(a, _mul(ab, t))))
}

// A stroke is its sampled points `pts` and their bounding box `bb`, which
// settles most clash tests without looking at the points.

#let _stroke(pts) = {
  let (xs, ys) = (pts.map(p => p.at(0)), pts.map(p => p.at(1)))
  (pts: pts, bb: (calc.min(..xs), calc.min(..ys), calc.max(..xs), calc.max(..ys)))
}

#let _bb-apart(a, b, pad) = (
  a.at(2) + pad < b.at(0) or b.at(2) + pad < a.at(0) or a.at(3) + pad < b.at(1) or b.at(3) + pad < a.at(1)
)

/// Whether the stroke comes within `d` of the point `p`.
#let _near(p, stroke, d) = {
  if _bb-apart(stroke.bb, (p.at(0), p.at(1), p.at(0), p.at(1)), d) { return false }
  let pts = stroke.pts
  range(pts.len() - 1).any(i => _seg-dist(p, pts.at(i), pts.at(i + 1)) < d)
}

/// Whether the open segments pq and st cross.
#let _segs-cross(p, q, s, t) = {
  let (d, e) = (_sub(q, p), _sub(t, s))
  let den = _cross(d, e)
  if den == 0 { return false }
  let w = _sub(s, p)
  let (i, j) = (_cross(w, e) / den, _cross(w, d) / den)
  i >= 0 and i < 1 and j >= 0 and j < 1
}

#let _crossings(a, b) = {
  if _bb-apart(a.bb, b.bb, 0) { return 0 }
  let (a, b) = (a.pts, b.pts)
  let n = 0
  for i in range(a.len() - 1) {
    for j in range(b.len() - 1) {
      if _segs-cross(a.at(i), a.at(i + 1), b.at(j), b.at(j + 1)) { n += 1 }
    }
  }
  n
}

// --------------------------------------------------------------------- boxes
// A label's box: its centre `c` and half-extents `w` and `h`.

#let _box-gap(box, p) = {
  let dx = calc.max(calc.abs(p.at(0) - box.c.at(0)) - box.w, 0)
  let dy = calc.max(calc.abs(p.at(1) - box.c.at(1)) - box.h, 0)
  calc.sqrt(dx * dx + dy * dy)
}

#let _boxes-overlap(a, b) = (
  calc.abs(a.c.at(0) - b.c.at(0)) < a.w + b.w + _gap and calc.abs(a.c.at(1) - b.c.at(1)) < a.h + b.h + _gap
)

/// Whether the stroke passes through the box, grown by half the label gap.
#let _box-hit(box, stroke) = {
  let g = (c: box.c, w: box.w + _gap / 2, h: box.h + _gap / 2)
  if _bb-apart(stroke.bb, (g.c.at(0) - g.w, g.c.at(1) - g.h, g.c.at(0) + g.w, g.c.at(1) + g.h), 0) { return false }
  let path = stroke.pts
  let corners = ((-1, -1), (1, -1), (1, 1), (-1, 1)).map(((sx, sy)) => _v(g.c.at(0) + sx * g.w, g.c.at(1) + sy * g.h))
  let sides = range(4).map(i => (corners.at(i), corners.at(calc.rem(i + 1, 4))))
  for i in range(path.len() - 1) {
    let (p, q) = (path.at(i), path.at(i + 1))
    if _box-gap(g, p) == 0 or sides.any(((s, t)) => _segs-cross(p, q, s, t)) { return true }
  }
  false
}

// -------------------------------------------------------------------- curves

/// finite's Bézier for a transition, as (start, end, ctrl1, ctrl2), with its
/// middle bowed `bend` to the left of the direction of travel.
#let _curve(a, b, r, bend) = _bez.transition-pts(a, b, r, r, curve: bend)

/// A loop on the state at `c`, pointing along the unit vector `u`: it leaves
/// and re-enters 28° either side of `u` and reaches `_loop` beyond the state.
/// finite's own loops start 22.5° apart and come out as tall teardrops.
#let _loop-curve(c, r, u) = {
  let a = calc.atan2(u.at(0), u.at(1))
  let at(t) = _v(calc.cos(t), calc.sin(t))
  let (spread, splay) = (28deg, 34deg)
  let arm = (_loop + r * (1 - calc.cos(spread))) / (0.75 * calc.cos(splay))
  let (s, e) = (_add(c, _mul(at(a + spread), r)), _add(c, _mul(at(a - spread), r)))
  (s, e, _add(s, _mul(at(a + splay), arm)), _add(e, _mul(at(a - splay), arm)))
}

#let _point(curve, t) = { let p = _bez.cubic-point(..curve, t); _v(p.at(0), p.at(1)) }
#let _sample(curve) = _stroke(range(13).map(i => _point(curve, i / 12))) + (curve: curve)
#let _normal(curve, t: 0.5) = { let n = _bez.cubic-normal(..curve, t); _v(n.at(0), n.at(1)) }

/// The box finite centres a label in: `dist` along the curve's normal at `t`,
/// which points to the left of travel, and out of a loop.
#let _label-box(curve, dist, size, t: 0.5) = (
  c: _add(_point(curve, t), _mul(_normal(curve, t: t), dist)),
  w: size.w,
  h: size.h,
)

/// How far along `n` the box reaches from its centre.
#let _support(n, size) = calc.abs(n.at(0)) * size.w + calc.abs(n.at(1)) * size.h

// -------------------------------------------------------------------- layout

#let _is-path(states, pairs) = pairs.all(((a, b)) => calc.abs(states.position(s => s == a) - states.position(s => s == b)) == 1)

#let _perms(xs) = if xs.len() <= 1 { (xs,) } else {
  let out = ()
  for (i, x) in xs.enumerate() {
    for p in _perms(xs.slice(0, i) + xs.slice(i + 1)) { out.push((x,) + p) }
  }
  out
}

/// Crossing chords when the states sit on a circle in this order.
#let _chord-crossings(order, pairs) = {
  let at = order.enumerate().map(((i, s)) => (s, i)).to-dict()
  let chords = pairs.map(((a, b)) => (calc.min(at.at(a), at.at(b)), calc.max(at.at(a), at.at(b)))).dedup()
  let n = 0
  for (k, (a, b)) in chords.enumerate() {
    for (c, d) in chords.slice(k + 1) {
      if c in (a, b) or d in (a, b) { continue }
      if (a < c and c < b) != (a < d and d < b) { n += 1 }
    }
  }
  n
}

#let _line(states, spacing) = states.enumerate().map(((i, s)) => (s, _v(i * spacing, 0))).to-dict()

/// States clockwise on a circle, adjacent ones `spacing` apart, turned so the
/// figure is wider than it is tall. The order is the given one unless another
/// crosses fewer transitions.
#let _circle(states, pairs, spacing) = {
  let n = states.len()
  if n == 1 { return ((states.first()): _v(0, 0)) }
  let order = states
  if n >= 4 and n <= 7 {
    let best = _chord-crossings(states, pairs)
    for p in _perms(states.slice(1)) {
      let c = _chord-crossings((states.first(),) + p, pairs)
      if c < best { (best, order) = (c, (states.first(),) + p) }
    }
  }
  let radius = spacing / (2 * calc.sin(180deg / n))
  let start = 90deg + 180deg / n
  order
    .enumerate()
    .map(((i, s)) => {
      let a = start - i * 360deg / n
      (s, _v(radius * calc.cos(a), radius * calc.sin(a)))
    })
    .to-dict()
}

/// Graphviz's placement: neato's spring model, or dot's layers left to right.
/// The spring layout is turned so its long axis lies across the page.
#let _graphviz(states, pairs, r, spacing, layered) = {
  let inch = spacing / 2.54
  let graph = dia.layout-graph(
    engine: if layered { "dot" } else { "neato" },
    directed: true,
    rankdir: "LR",
    nodesep: str(inch / 2),
    ranksep: str(inch / 2),
    ..states.map(s => dia.node(s, width: 2 * r * 1cm, height: 2 * r * 1cm)),
    ..pairs.map(((a, b)) => dia.edge(b, a, len: str(inch))),
  )
  let pos = graph.nodes.map(n => (n.name, _v(n.x / 1cm, n.y / 1cm))).to-dict()
  if layered { return pos }
  let mean = _mul(pos.values().fold(_v(0, 0), _add), 1 / states.len())
  let (sxx, syy, sxy) = (0.0, 0.0, 0.0)
  for p in pos.values() {
    let d = _sub(p, mean)
    sxx += d.at(0) * d.at(0)
    syy += d.at(1) * d.at(1)
    sxy += d.at(0) * d.at(1)
  }
  let a = -calc.atan2(sxx - syy, 2 * sxy) / 2
  pos
    .pairs()
    .map(((s, p)) => {
      let d = _sub(p, mean)
      (s, _v(d.at(0) * calc.cos(a) - d.at(1) * calc.sin(a), d.at(0) * calc.sin(a) + d.at(1) * calc.cos(a)))
    })
    .to-dict()
}

#let _layout(layout, states, pairs, r, spacing) = {
  if type(layout) == dictionary {
    return states.map(s => { let (x, y) = layout.at(s); (s, _v(x * spacing, y * spacing)) }).to-dict()
  }
  let n = states.len()
  let mode = if layout != auto { layout } else if n <= 2 or _is-path(states, pairs) { "line" } else if n <= 6 {
    "circle"
  } else { "graphviz" }
  if mode == "line" { _line(states, spacing) } else if mode == "circle" { _circle(states, pairs, spacing) } else if (
    mode in ("graphviz", "layered")
  ) { _graphviz(states, pairs, r, spacing, mode == "layered") } else {
    panic(
      "layout must be auto, \"line\", \"circle\", \"graphviz\", \"layered\" or a dictionary of positions, got "
        + repr(layout),
    )
  }
}

// ------------------------------------------------------------------- routing

/// Bends, label places and loop directions for every transition, and the
/// initial arrow's direction.
///
/// Each element takes the cheapest of its options against everything else:
/// running through a state is ruled out, crossings and labels on strokes or on
/// each other are dear, and bowing, a label off centre or on an arrow's right
/// cost a little. Pairs of opposite transitions go first, then the rest from
/// shortest to longest, then the initial arrow and the loops, which face away
/// from the strokes already at their state. A second pass routes everything
/// again with the whole picture known, so an early label can step aside for a
/// later arc. `strain` totals the clashes left and any bowing past the least
/// a transition needs, so a layout too tight to draw cleanly can be spread out.
#let _route(states, pos, r, edges, initial) = {
  let centroid = _mul(pos.values().fold(_v(0, 0), _add), 1 / states.len())

  let path-clash(path, ends, others) = {
    let c = 0
    for s in states {
      if s not in ends and _near(pos.at(s), path, r + _clear) { c += 1000 }
    }
    for p in others.paths { c += 10 * _crossings(path, p) }
    for b in others.boxes { if _box-hit(b, path) { c += 60 } }
    c
  }
  let box-clash(box, own, others) = {
    let c = 0
    for s in states { if _box-gap(box, pos.at(s)) < r + _gap { c += 300 } }
    if _box-hit(box, own) { c += 300 }
    for p in others.paths { if _box-hit(box, p) { c += 60 } }
    for b in others.boxes { if _boxes-overlap(box, b) { c += 100 } }
    c
  }
  let outward(s) = {
    let o = _sub(pos.at(s), centroid)
    if _len(o) < 1e-6 { _v(0, 1) } else { _unit(o) }
  }
  let crowding(s, u, leaving) = leaving
    .filter(((t, _)) => t == s)
    .map(((_, d)) => 20 * calc.max(_dot(u, d) - 0.3, 0))
    .sum(default: 0)

  let route-unit(unit, others) = {
    let (a, b) = (pos.at(unit.first().from), pos.at(unit.first().to))
    let (steps, step) = if unit.len() == 2 { ((1, 2, 3, 4), _bend-step) } else {
      ((0, 1, -1, 2, -2, 3, -3, 4, -4), calc.max(_bend-step, 0.06 * _len(_sub(b, a))))
    }
    let best = none
    for k in steps {
      if best != none and best.cost <= 4 * calc.abs(k) { break }
      // finite special-cases an exact 0, and its label then flips side.
      let bend = if k == 0 { 1e-3 } else { k * step }
      let (cost, clash, placed) = (4 * calc.abs(k), 0, ())
      for e in unit {
        let (a, b) = (pos.at(e.from), pos.at(e.to))
        let curve = _curve(a, b, r, bend)
        let path = _sample(curve)
        let left = _v(a.at(1) - b.at(1), b.at(0) - a.at(0))
        let outer = _sub(_mul(_add(a, b), 0.5), centroid)
        let mine = (paths: others.paths + placed.map(p => p.path), boxes: others.boxes + placed.map(p => p.box))
        let through = path-clash(path, (e.from, e.to), mine)
        let options = ()
        for t in (0.5, 0.38, 0.62) {
          let n = _normal(curve, t: t)
          for side in (1, -1) {
            // A bowed transition keeps its label on the outside of the bow.
            if k != 0 and _dot(_mul(n, side), left) * k < 0 { continue }
            let dist = side * (_gap + _support(n, e.size))
            let box = _label-box(curve, dist, e.size, t: t)
            let c = box-clash(box, path, mine)
            let taste = (
              (if t != 0.5 { 1.5 } else { 0 })
                + (if _dot(_mul(n, side), left) < 0 { 1 } else { 0 })
                + (if _dot(_mul(n, side), outer) < -0.01 { 2 } else { 0 })
            )
            options.push((t: t, dist: dist, box: box, clash: c, cost: c + taste))
          }
        }
        let option = options.sorted(key: o => o.cost).first()
        cost += through + option.cost
        clash += through + option.clash
        placed.push((edge: e, bend: bend, curve: curve, path: path, box: option.box, dist: option.dist, t: option.t))
      }
      if best == none or cost < best.cost { best = (cost: cost, clash: clash, placed: placed, k: k) }
    }
    (
      clash: best.clash,
      strain: best.clash + 4 * (calc.abs(best.k) - if unit.len() == 2 { 1 } else { 0 }),
      paths: best.placed.map(p => p.path),
      boxes: best.placed.map(p => p.box),
      leaves: best
        .placed
        .map(p => (
          (p.edge.from, _unit(_sub(_point(p.curve, 0.15), pos.at(p.edge.from)))),
          (p.edge.to, _unit(_sub(_point(p.curve, 0.85), pos.at(p.edge.to)))),
        ))
        .join(),
      routes: best.placed.map(p => (p.edge.from + "-" + p.edge.to, (bend: p.bend, dist: p.dist, pos: p.t))),
    )
  }

  let route-initial(leaving, others) = {
    let c = pos.at(initial)
    let best = _directions
      .map(((u, taste)) => {
        let path = _stroke((_add(c, _mul(u, r)), _add(c, _mul(u, r + _initial))))
        let clash = path-clash(path, (initial,), others)
        // Conventionally from the left.
        let taste = taste + crowding(initial, u, leaving) + (1 - _dot(u, outward(initial))) + (1 + u.at(0))
        (path: path, u: u, clash: clash, cost: clash + taste)
      })
      .sorted(key: o => o.cost)
      .first()
    (
      clash: best.clash,
      strain: best.clash,
      paths: (best.path,),
      boxes: (),
      leaves: ((initial, best.u),),
      routes: (("initial", best.path.pts),),
    )
  }

  let route-loop(e, leaving, others) = {
    let s = e.from
    let best = _directions
      .map(((u, taste)) => {
        let curve = _loop-curve(pos.at(s), r, u)
        let path = _sample(curve)
        let dist = _gap + _support(u, e.size)
        let box = (c: _add(_point(curve, 0.5), _mul(u, dist)), w: e.size.w, h: e.size.h)
        let clash = path-clash(path, (s,), others) + box-clash(box, path, others)
        let taste = taste + crowding(s, u, leaving) + 2 * (1 - _dot(u, outward(s)))
        (u: u, path: path, box: box, clash: clash, cost: clash + taste)
      })
      .sorted(key: o => o.cost)
      .first()
    (
      clash: best.clash,
      strain: best.clash,
      paths: (best.path,),
      boxes: (best.box,),
      leaves: ((s, best.u),),
      routes: ((s + "-" + s, (curve: best.path.curve, label: best.box.c)),),
    )
  }

  // Opposite transitions are routed together, as mirror images.
  let units = ()
  for e in edges.filter(e => e.from != e.to) {
    let i = units.position(u => u.first().from == e.to and u.first().to == e.from)
    if i == none { units.push((e,)) } else { units.at(i).push(e) }
  }
  units = units.sorted(key: u => (2 - u.len()) * 1000 + _len(_sub(pos.at(u.first().to), pos.at(u.first().from))))

  let jobs = units.enumerate().map(((i, u)) => ("unit-" + str(i), u))
  if initial != none and initial in pos { jobs.push(("initial", none)) }
  jobs += edges.filter(e => e.from == e.to).map(e => ("loop-" + e.from, e))

  let chosen = (:)
  for pass in range(2) {
    if pass == 1 and chosen.values().all(v => v.clash == 0) { break }
    for (key, job) in jobs {
      let rest = chosen.pairs().filter(((k, _)) => k != key).map(((_, v)) => v)
      let others = (paths: rest.map(v => v.paths).join(default: ()), boxes: rest.map(v => v.boxes).join(default: ()))
      let leaving = rest.map(v => v.leaves).join(default: ())
      chosen.insert(key, if key == "initial" { route-initial(leaving, others) } else if key.starts-with("loop-") {
        route-loop(job, leaving, others)
      } else { route-unit(job, others) })
    }
  }

  let done = chosen.values()
  (routes: done.map(v => v.routes).join(default: ()).to-dict(), strain: done.map(v => v.strain).sum(default: 0))
}

// ------------------------------------------------------------------- drawing

#let _is-zero(x) = if type(x) in (int, float) { x == 0 } else if type(x) == str { x.trim() == "0" } else if (
  type(x) == content
) {
  if x.func() == math.equation { _is-zero(x.body) } else if x.func() == text { x.text.trim() == "0" } else { false }
} else { false }

/// `q0` as $q_0$, a number in the maths font, anything else as it is.
#let _state-format(name) = {
  let m = name.match(regex("^([A-Za-z])_?(\d+)$"))
  if m != none { $#math.italic(m.captures.at(0))_#m.captures.at(1)$ } else if (
    name.match(regex("^-?\d+$")) != none
  ) { $#name$ } else { name }
}

/// Set on its ink, so cetz centres it on what shows and `measure` gives the
/// fraction its full height.
#let _tight(body) = text(top-edge: "bounds", bottom-edge: "bounds", body)

#let _half-size(body) = { let m = measure(body); (w: m.width / 2cm, h: m.height / 2cm) }

/// Draw a state diagram from a transition table, in finite's format:
///
///     #automaton((
///       q0: (q1: 0, q0: (0, 1)),
///       q1: (q0: (0, 1), q2: 0),
///       q2: none,
///     ))
///
/// `initial` and `final` default to the first and last states, as in finite;
/// `none` drops the markings. `labels` overrides a state's label (`q0: [Start]`)
/// or a transition's (`q0-q1: $delta$`), and `style` passes finite's styles
/// through, per state (`q0: (fill: colors.blue.soft)`), per transition
/// (`q0-q1: (stroke: colors.red.base)`), or to all of them (`state: ...`,
/// `transition: ...`).
///
/// `layout` is `auto`, `"line"`, `"circle"`, `"graphviz"` (spring), `"layered"`
/// (Graphviz's dot, left to right), or a dictionary of positions in units of
/// `spacing`, y up: `(q0: (0, 0), q1: (1, 0), q2: (0.5, -1))`. `auto` lines up
/// two states or a chain, puts up to six on a circle, and gives Graphviz the
/// rest. `spacing` is the distance between neighbouring states in cm; `auto`
/// starts at 2.2 and spreads the states out while that eases a clash or a bow.
#let automaton(
  spec,
  initial: auto,
  final: auto,
  layout: auto,
  spacing: auto,
  labels: (:),
  input-labels: (:),
  style: (:),
  state-format: _state-format,
  input-format: inputs => inputs.join([, ]),
  hide-zero: false,
) = context {
  // A full finite spec carries its own states and markings; a bare table
  // takes finite's defaults.
  let given(key, default) = if "transitions" in spec { spec.at(key, default: default) } else { default }
  let table = given("transitions", spec)
  let states = given(
    "states",
    table.pairs().map(((from, ts)) => (from,) + if ts == none { () } else { ts.keys() }).flatten().dedup(),
  )
  let initial = if initial == auto { given("initial", table.keys().first()) } else { initial }
  let final = if final == auto { given("final", table.keys().last()) } else if final == none { () } else { final }
  if type(final) == str { final = (final,) }

  let edges = ()
  for (from, ts) in table {
    for (to, inputs) in if ts == none { (:) } else { ts } {
      if inputs == none or (hide-zero and _is-zero(inputs)) { continue }
      let label = _tight(labels.at(from + "-" + to, default: {
        let items = if type(inputs) == array { inputs } else { (inputs,) }
        input-format(items.map(i => if type(i) == content { i } else { input-labels.at(str(i), default: [#i]) }))
      }))
      edges.push((from: from, to: to, label: label, size: _half-size(label)))
    }
  }

  let state-labels = states.map(s => (s, labels.at(s, default: state-format(s)))).to-dict()
  let widest = calc.max(..state-labels.values().map(l => { let h = _half-size(l); calc.max(h.w, h.h) }))
  let r = calc.max(0.3, widest + 0.1) / if final.len() > 0 { 0.88 } else { 1 }

  let pairs = edges.filter(e => e.from != e.to).map(e => (e.from, e.to))
  let place(spacing) = {
    let pos = _layout(layout, states, pairs, r, spacing)
    (pos: pos) + _route(states, pos, r, edges, initial)
  }
  let plan = place(if spacing == auto { 2.2 } else { spacing })
  if spacing == auto {
    for grow in (1.25, 1.5625) {
      if plan.strain == 0 { break }
      let wider = place(2.2 * grow)
      if wider.strain < plan.strain { plan = wider }
    }
  }
  let (pos, routes) = (plan.pos, plan.routes)

  let ink = rule + colors.text
  let canvas = finite.cetz.canvas(length: 1cm, {
    import finite.cetz.draw: bezier, content, line, set-style
    let mark = (end: "stealth", fill: colors.text, stroke: ink, scale: 0.55)
    set-style(
      state: (radius: r, fill: colors.page, stroke: ink, label: (fill: colors.text)),
      transition: (stroke: ink, mark: mark, label: (fill: colors.text, angle: 0deg)),
    )
    for key in ("state", "transition") {
      if key in style { set-style(..((key): style.at(key))) }
    }
    for s in states {
      finite.draw.state(pos.at(s), s, label: state-labels.at(s), final: s in final, ..style.at(s, default: (:)))
    }
    if "initial" in routes {
      let (at, from) = routes.initial
      line(from, at, stroke: ink, mark: mark)
    }
    for e in edges {
      let key = e.from + "-" + e.to
      let route = routes.at(key)
      let own = style.at(key, default: (:))
      if e.from == e.to {
        let stroke = own.at("stroke", default: ink)
        bezier(..route.curve, stroke: stroke, mark: mark + own.at("mark", default: (:)))
        content(route.label, text(fill: colors.text, e.label))
        continue
      }
      finite.draw.transition(
        e.from,
        e.to,
        label: (text: e.label, dist: route.dist, pos: route.pos) + own.at("label", default: (:)),
        curve: route.bend / 0.75, // finite scales its curve by 0.75
        ..own.pairs().filter(((k, _)) => k != "label").to-dict(),
      )
    }
  })
  if is-html { html.frame(canvas) } else { align(center, canvas) }
}

#let _matrix-rows(x) = if type(x) == array { x } else if type(x) == content {
  if x.func() == math.mat { x.rows } else if x.func() == math.equation { _matrix-rows(x.body) } else if (
    x.has("children")
  ) { x.children.map(_matrix-rows).find(r => r != none) } else { none }
} else { none }

/// A Markov chain's transition diagram. `chain` is a transition table, as for
/// `automaton`, or the transition matrix: rows of entries, or the very `mat`
/// the notes typeset, `$mat(1 - alpha, alpha; beta, 1 - beta)$`. Matrix states
/// are named by `states`, 1 to n by default. Zero entries draw no arrow, and
/// there are no initial or final markings.
#let markov-chain(chain, states: auto, ..args) = {
  let rows = _matrix-rows(chain)
  let table = if rows == none { chain } else {
    let names = (if states == auto { range(1, rows.len() + 1) } else { states }).map(str)
    names
      .zip(rows)
      .map(((from, row)) => {
        let entries = names
          .zip(row)
          .map(((to, p)) => {
            (to, if type(p) == content and p.func() != math.equation { math.equation(block: false, p) } else { p })
          })
        (from, entries.to-dict())
      })
      .to-dict()
  }
  automaton(table, initial: none, final: none, hide-zero: true, ..args)
}
