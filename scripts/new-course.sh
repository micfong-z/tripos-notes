#!/usr/bin/env bash
# Creates a course after a few questions: its MDS ID (allocated, or one you
# already hold), its folder, and its rows in courses.tsv and the README table.
# mds.toml needs no edit: its entries glob picks up part-*/*/main.typ.
set -euo pipefail
cd "$(dirname "$0")/.."

mds="${MDS:-mds}"
typst="${TYPST:-typst}"

if [[ -t 1 ]]; then b=$'\e[1m' d=$'\e[2m' red=$'\e[31m' grn=$'\e[32m' r=$'\e[0m'; else b='' d='' red='' grn='' r=''; fi
die() { echo "${red}new-course:${r} $*" >&2; exit 1; }
warn() { echo "  ${red}$*${r}" >&2; }
ask() { local answer; read -r -p "${b}$2${r}${3:+ ${d}[$3]${r}}: " answer || die "cancelled"; printf -v "$1" '%s' "${answer:-${3:-}}"; }
lower() { tr '[:upper:]' '[:lower:]' <<< "$1"; }
slugify() { lower "$1" | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'; }
typ_string() { local s="${1//\\/\\\\}"; printf '%s' "${s//\"/\\\"}"; }
typ_markup() { printf '%s' "$1" | sed -E 's/([\\*_#$<>@`=~])/\\\1/g'; }
in_tsv() { cut -f"$1" courses.tsv | grep -qxF "$2"; }

"$mds" whoami >/dev/null 2>&1 || die "not logged in to MDS; run mds login first"

latest="$(cut -f1 courses.tsv | cut -d/ -f1 | LC_ALL=C sort | tail -1)"
case "$(date +%m)" in 01|02|03) season_default=Lent ;; 04|05|06) season_default=Easter ;; *) season_default=Michaelmas ;; esac

echo "${b}New course${r} ${d}(Ctrl-C to stop; nothing is written until you confirm)${r}"
echo

while :; do
  ask part "Part (ia, ib, ii, iii)" "${latest#part-}"
  part="$(lower "$part")"
  [[ "$part" =~ ^(ia|ib|ii|iii)$ ]] && break
  warn "one of ia, ib, ii, iii"
done
part_name="Part $(tr '[:lower:]' '[:upper:]' <<< "$part")"

while :; do
  ask title "Title, e.g. Quantum Mechanics" ""
  [[ -n "${title// /}" && "$title" != *$'\t'* ]] && break
  warn "a title is needed (no tabs)"
done
name="$part_name – $title"

while :; do
  ask slug "Folder name" "$(slugify "$title")"
  course="part-$part/$slug"
  if [[ ! "$slug" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then warn "lower-case words joined by hyphens"
  elif [[ -e "$course" ]]; then warn "$course already exists"
  elif in_tsv 1 "$course"; then warn "$course is already in courses.tsv"
  else break; fi
done

while :; do
  ask site "Website slug" "$part-$slug"
  if [[ ! "$site" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then warn "lower-case words joined by hyphens"
  elif in_tsv 3 "$site"; then warn "$site is already used by $(awk -F'\t' -v s="$site" '$3 == s { print $1 }' courses.tsv)"
  else break; fi
done

while :; do
  ask lecturer "Lecturer, e.g. Prof Harvey Reall" ""
  [[ -n "${lecturer// /}" && "$lecturer" != *$'\t'* ]] && break
  warn "a lecturer is needed (no tabs)"
done

while :; do
  ask season "Term (Michaelmas, Lent, Easter)" "$season_default"
  case "$(lower "$season")" in m*) season=Michaelmas ;; l*) season=Lent ;; e*) season=Easter ;; *) warn "Michaelmas, Lent or Easter"; continue ;; esac
  break
done

while :; do
  ask year "Year" "$(date +%Y)"
  [[ "$year" =~ ^20[0-9]{2}$ ]] && break
  warn "a year like $(date +%Y)"
done
term="$season $year"

while :; do
  ask id "MDS ID ${d}(blank: allocate the next D/ACD/UND/NTE)${r}" ""
  id="$(tr '[:lower:]' '[:upper:]' <<< "$id")"
  [[ -z "$id" ]] && break
  if ! shown="$("$mds" id show "$id" 2>/dev/null | head -1)" || [[ -z "$shown" ]]; then warn "MDS does not know $id"; continue; fi
  read -r canonical status _ <<< "$shown"
  used="$(grep -lF "doc-id: \"$id\"" part-*/*/meta.typ || true)"
  if [[ "$canonical" != "$id" ]]; then warn "$id belongs to $canonical; give its canonical ID"
  elif [[ "$status" == void ]]; then warn "$id is void"
  elif [[ -n "$used" ]]; then warn "$id is already the doc-id of ${used%/meta.typ}"
  else break; fi
done

echo
echo "  ${b}$name${r}"
printf '  %-9s %s\n' folder "$course" website "$site" lecturer "$lecturer" term "$term"
if [[ -n "$id" ]]; then printf '  %-9s %s\n' "MDS ID" "$id"
else printf '  %-9s %s\n' "MDS ID" "the next D/ACD/UND/NTE, allocated now ${d}(an ID is never reused; a mistake can only be voided)${r}"; fi
echo
ask ok "Create it? (y/n)" "n"
[[ "$(lower "$ok")" == y* ]] || { echo "nothing created"; exit 0; }

if [[ -z "$id" ]]; then
  out="$("$mds" id new D ACD/UND/NTE --title "$title")"
  id="${out%% *}"
  [[ "$id" =~ ^D/ACD/UND/NTE/[1-9][0-9]*$ ]] || die "unexpected answer from mds id new: $out"
  echo "${grn}allocated${r} $id"
  trap 'echo "${red}new-course:${r} stopped after allocating $id; fix the cause, run again and give $id as the MDS ID" >&2' ERR
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
dir="$tmp/course"
mkdir -p "$dir/chapters"

cat > "$dir/meta.typ" <<EOF
// The course's identity, shared by its standalone build (main.typ) and any
// series that collects it.

#let meta = (
  part: "$(typ_string "$part_name")",
  title: "$(typ_string "$title")",
  lecturer: "$(typ_string "$lecturer")",
  lectured-in: "$(typ_string "$term")",
  updated: "Version $(date +%Y%m%d)",
  doc-id: "$id",
)
EOF

cat > "$dir/main.typ" <<'EOF'
#import "prelude.typ": *
#import "meta.typ": meta

#show: project.with(..meta)

#include "content.typ"
EOF

cat > "$dir/prelude.typ" <<EOF
// $title: the single import for this course.
// Chapters and content.typ import this file and nothing else.

#import "/template/lib.typ": *
#import "symbols.typ": *
EOF

cat > "$dir/symbols.typ" <<EOF
// $title: course-specific notation.
//
// Kept separate from prelude.typ so the symbols a course introduces are one
// greppable list. The prelude re-exports everything here, so chapters still
// import only the prelude.

#import "/template/lib.typ": *
#import "@preview/physica:0.9.8": *
EOF

cat > "$dir/content.typ" <<EOF
// The course's body. It has no layout of its own, so the standalone book
// (main.typ) and a series volume can both include it.

#import "prelude.typ": *

These are Zixuan's notes for *$(typ_markup "$name")* at the University of Cambridge in $year. The notes are not endorsed by the lecturers or the University, and all errors are my own.

The latest version of this document is available at #link("https://academic.micfong.space")[academic.micfong.space]. Please direct any comments to my CRSid email or use the contact details listed on the site.

This document is typeset using #link("https://typst.app/")[Typst]. All figures are created using #link("https://inkscape.org/")[Inkscape].

#contents()

#pagebreak()

#include "chapters/syllabus.typ"

#counter(heading).update(0)

#pagebreak()

#include "chapters/chapter-1.typ"

#end-of-document()
EOF

cat > "$dir/chapters/syllabus.typ" <<EOF
#import "../prelude.typ": *

#set heading(numbering: none)

= Syllabus and Overview

#fade[$season Term, $year]
EOF

cat > "$dir/chapters/chapter-1.typ" <<'EOF'
#import "../prelude.typ": *

= Introduction
EOF

mkdir -p "$(dirname "$course")"
mv "$dir" "$course"

printf '%s\t%s\t%s\n' "$course" "$name" "$site" >> courses.tsv
LC_ALL=C sort -o courses.tsv courses.tsv

row="| $name | $lecturer | $term | Work in Progress |"
awk -v row="$row" '
  /^\| Part / { rows[++n] = $0; next }
  n && !done { rows[++n] = row; cmd = "LC_ALL=C sort"; for (i = 1; i <= n; i++) print rows[i] | cmd; close(cmd); done = 1 }
  { print }
' README.md > "$tmp/README.md"
grep -qF "$row" "$tmp/README.md" || die "could not find the course table in README.md; add '$row' by hand"
cp "$tmp/README.md" README.md

if ! log="$("$typst" compile --root . --font-path fonts --ignore-system-fonts "$course/main.typ" "$tmp/check.pdf" 2>&1)"; then
  echo "$log" >&2
  die "$course was created but does not compile yet"
fi

echo "${grn}created${r} $course ${d}($id; courses.tsv and README updated; it compiles)${r}"
if [[ "$part" == ia ]]; then
  echo "  Part IA: add it to part-ia/series.typ and to [[series]] volumes in mds.toml by hand"
fi
echo "next: write it, commit, then ${b}just push $course${r}"
