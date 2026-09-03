# Build recipes for the Tripos notes.
#
#   just build part-ia/groups dark serif   one course, one variant
#   just build-all                         every course, all four variants
#   just watch part-ia/groups              live preview while writing
#
# Every compile pins the vendored fonts and ignores system fonts, so a build
# here, in CI and on any other clone produce the same PDF.

set shell := ["bash", "-euo", "pipefail", "-c"]

typst := "typst"
fontargs := "--font-path fonts --ignore-system-fonts"
themes := "light dark"
suites := "sans serif"

_default:
    @just --list

# Compile one course in one theme and font suite.
build course theme="light" font="sans":
    @mkdir -p build
    @{{typst}} compile --root . {{fontargs}} \
        --input theme={{theme}} --input font={{font}} \
        "{{course}}/main.typ" "build/$(tr / - <<< '{{course}}').{{theme}}.{{font}}.pdf"
    @echo "build/$(tr / - <<< '{{course}}').{{theme}}.{{font}}.pdf"

# Compile every course in all four variants.
build-all:
    @mkdir -p build
    @while IFS=$'\t' read -r slug name; do \
        for t in {{themes}}; do for f in {{suites}}; do \
            just build "$slug" "$t" "$f" >/dev/null; \
        done; done; \
        echo "built $name"; \
    done < courses.tsv
    @echo "$(ls build/*.pdf | wc -l | tr -d ' ') PDFs in build/"

# Copy the build output to human-readable names, e.g. "Part IA – Groups (Dark, Serif).pdf".
pretty: build-all
    @mkdir -p build/pretty
    @while IFS=$'\t' read -r slug name; do \
        for t in {{themes}}; do for f in {{suites}}; do \
            tc="$(tr '[:lower:]' '[:upper:]' <<< "${t:0:1}")${t:1}"; \
            fc="$(tr '[:lower:]' '[:upper:]' <<< "${f:0:1}")${f:1}"; \
            cp "build/$(tr / - <<< "$slug").$t.$f.pdf" "build/pretty/$name ($tc, $fc).pdf"; \
        done; done; \
    done < courses.tsv
    @ls build/pretty | head

# Recompile a course on every save.
watch course theme="light" font="sans":
    @mkdir -p build
    {{typst}} watch --root . {{fontargs}} \
        --input theme={{theme}} --input font={{font}} \
        "{{course}}/main.typ" "build/$(tr / - <<< '{{course}}').{{theme}}.{{font}}.pdf"

# Fail unless all five vendored families are the ones we expect.
fonts-check:
    @found=$({{typst}} fonts {{fontargs}} | grep -cxE 'Inter|Lete Sans Math|IBM Plex Serif|IBM Plex Math|JetBrains Mono'); \
    if [ "$found" -ne 5 ]; then \
        echo "expected 5 vendored families, found $found:"; {{typst}} fonts {{fontargs}}; exit 1; \
    fi
    @echo "fonts OK: Inter, Lete Sans Math, IBM Plex Serif, IBM Plex Math, JetBrains Mono"

# Validate the Ponder registry and run its tests.
ponder-check:
    @cd ponder && pnpm ponder:check

# Regenerate the website export for every course.
ponder-export:
    @cd ponder && pnpm ponder:export -- --course all

clean:
    rm -rf build
