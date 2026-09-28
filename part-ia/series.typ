// Every Part IA course in one document: a series cover indexing the courses,
// then each course as a volume with its own cover, doc id and page numbers.
// The volumes reuse each course's meta.typ and content.typ unchanged.
//
//     just series                          light, sans
//     just series dark serif               any theme and font
//     just series-all                      all four variants

#import "/template/lib.typ": *

#import "groups/meta.typ": meta as groups
#import "vectors-and-matrices/meta.typ": meta as vectors-and-matrices
#import "numbers-and-sets/meta.typ": meta as numbers-and-sets
#import "differential-equations/meta.typ": meta as differential-equations
#import "analysis-i/meta.typ": meta as analysis-i
#import "probability/meta.typ": meta as probability
#import "dynamics-and-relativity/meta.typ": meta as dynamics-and-relativity

#show: series.with(
  title: "Tripos Notes",
  subtitle: "Part IA",
  authors: "Zixuan Zhang",
  info: ("Michaelmas 2025 – Lent 2026",),
  doc-id: "S/ACD/UND/NTE/1",
  cover-style: "drafting",
)

// In the order of the Part IA schedules: Michaelmas, then Lent.
#volume(..groups)[#include "groups/content.typ"]
#volume(..vectors-and-matrices)[#include "vectors-and-matrices/content.typ"]
#volume(..numbers-and-sets)[#include "numbers-and-sets/content.typ"]
#volume(..differential-equations)[#include "differential-equations/content.typ"]
#volume(..analysis-i)[#include "analysis-i/content.typ"]
#volume(..probability)[#include "probability/content.typ"]
#volume(..dynamics-and-relativity)[#include "dynamics-and-relativity/content.typ"]
