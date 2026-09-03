# Build recipes for the Tripos notes.
#
#   just build part-ia/groups dark serif   one course, one variant
#   just build-all                         every course, all four variants
#   just watch part-ia/groups              live preview while writing
#   just publish                           build, then push the PDFs to R2
#
# courses.tsv is the single source of truth: build slug, display name, and the
# slug the website and the R2 object keys use.
#
# Every compile pins the vendored fonts and ignores system fonts, so a build
# here, in CI and on any other clone produce the same PDF.

set shell := ["bash", "-euo", "pipefail", "-c"]

typst := "typst"
fontargs := "--font-path fonts --ignore-system-fonts"
themes := "light dark"
bucket := "micfong-space"
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
    @while IFS=$'\t' read -r slug name site; do \
        for t in {{themes}}; do for f in {{suites}}; do \
            just build "$slug" "$t" "$f" >/dev/null; \
        done; done; \
        echo "built $name"; \
    done < courses.tsv
    @echo "$(ls build/*.pdf | wc -l | tr -d ' ') PDFs in build/"

# Copy the build output to human-readable names, e.g. "Part IA – Groups (Dark, Serif).pdf".
pretty: build-all
    @mkdir -p build/pretty
    @while IFS=$'\t' read -r slug name site; do \
        for t in {{themes}}; do for f in {{suites}}; do \
            tc="$(tr '[:lower:]' '[:upper:]' <<< "${t:0:1}")${t:1}"; \
            fc="$(tr '[:lower:]' '[:upper:]' <<< "${f:0:1}")${f:1}"; \
            cp "build/$(tr / - <<< "$slug").$t.$f.pdf" "build/pretty/$name ($tc, $fc).pdf"; \
        done; done; \
    done < courses.tsv
    @ls build/pretty | head

# Object keys are notes/<site-slug>.<theme>.<font>.pdf, plus notes/<site-slug>.pdf
# kept as an alias for the light/sans build so older links keep working.
# Locally this uses your `wrangler login` session; in CI the release workflow
# sets CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID instead.
#
# Push every built PDF to the R2 bucket the website links to.
publish-r2: build-all
    @while IFS=$'\t' read -r slug name site; do \
        for t in {{themes}}; do for f in {{suites}}; do \
            src="build/$(tr / - <<< "$slug").$t.$f.pdf"; \
            just _put "$src" "notes/$site.$t.$f.pdf"; \
        done; done; \
        just _put "build/$(tr / - <<< "$slug").light.sans.pdf" "notes/$site.pdf"; \
        echo "uploaded $name"; \
    done < courses.tsv

_put src key:
    @npx --yes wrangler@4 r2 object put "{{bucket}}/{{key}}" \
        --file "{{src}}" --content-type application/pdf --remote >/dev/null
    @echo "  {{key}}"

# Everything a release needs: fonts verified, all variants built, PDFs on R2.
publish: fonts-check publish-r2

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
