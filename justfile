# Build recipes for the Tripos notes.
#
#   just build part-ia/groups dark serif   one course, one variant
#   just build-all                         every course, all four variants
#   just watch part-ia/groups              live preview while writing
#   just series                            every Part IA course in one document
#   just series-all                        the series, all four variants
#   just publish                           build, then push the PDFs to R2
#   just push part-ia/groups               register one course with MDS
#   just push-all                          register every course, then the series
#   just sync-template                     re-vendor the design system
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
# The slug the Part IA series is published under, as courses.tsv gives courses.
series-site := "ia-series"
# The Micfong design system, vendored into template/micfong by `sync-template`.
design := env("MICFONG_TYPST", env("HOME") / "Hub/Documents/Design and Art/Design System/typst")
# The MDS CLI; mds.toml lists what it registers.
mds := env("MDS", "mds")

_default:
    @just --list

# Compile one course in one theme and font suite.
build course theme="light" font="sans":
    @mkdir -p build
    @{{typst}} compile --root . {{fontargs}} \
        --input theme={{theme}} --input font={{font}} \
        "{{course}}/main.typ" "build/$(tr / - <<< '{{course}}').{{theme}}.{{font}}.pdf"
    @echo "build/$(tr / - <<< '{{course}}').{{theme}}.{{font}}.pdf"

# A drafting cover indexing every course, then each course as a volume with
# its own cover, doc id and page numbers.
#
# Compile every Part IA course into one series document.
series theme="light" font="sans":
    @mkdir -p build
    @{{typst}} compile --root . {{fontargs}} \
        --input theme={{theme}} --input font={{font}} \
        part-ia/series.typ "build/part-ia-series.{{theme}}.{{font}}.pdf"
    @echo "build/part-ia-series.{{theme}}.{{font}}.pdf"

# Compile the Part IA series in all four variants.
series-all:
    @for t in {{themes}}; do for f in {{suites}}; do just series "$t" "$f"; done; done

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
# The Part IA series follows the same scheme under the `series-site` slug.
#
# Push every built PDF, courses and series, to the R2 bucket the website links to.
publish-r2: build-all series-all
    @while IFS=$'\t' read -r slug name site; do \
        for t in {{themes}}; do for f in {{suites}}; do \
            src="build/$(tr / - <<< "$slug").$t.$f.pdf"; \
            just _put "$src" "notes/$site.$t.$f.pdf"; \
        done; done; \
        just _put "build/$(tr / - <<< "$slug").light.sans.pdf" "notes/$site.pdf"; \
        echo "uploaded $name"; \
    done < courses.tsv
    @for t in {{themes}}; do for f in {{suites}}; do \
        just _put "build/part-ia-series.$t.$f.pdf" "notes/{{series-site}}.$t.$f.pdf"; \
    done; done
    @just _put build/part-ia-series.light.sans.pdf "notes/{{series-site}}.pdf"
    @echo "uploaded the Part IA series"

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
    @found=$({{typst}} fonts {{fontargs}} | grep -cxE 'IBM Plex Sans|IBM Plex Serif|IBM Plex Math|Lete Sans Math|JetBrains Mono'); \
    if [ "$found" -ne 5 ]; then \
        echo "expected 5 vendored families, found $found:"; {{typst}} fonts {{fontargs}}; exit 1; \
    fi
    @echo "fonts OK: IBM Plex Sans, IBM Plex Serif, IBM Plex Math, Lete Sans Math, JetBrains Mono"

# Copies its package files; its fonts are vendored in fonts/ instead. Set
# MICFONG_TYPST if the design system lives elsewhere.
#
# Re-vendor the design system into template/micfong.
sync-template:
    @test -f "{{design}}/lib.typ" || { echo "no design system at {{design}}"; exit 1; }
    @rm -rf template/micfong && mkdir -p template/micfong
    @cp -R "{{design}}/lib.typ" "{{design}}/typst.toml" "{{design}}/README.md" "{{design}}/src" "{{design}}/assets" template/micfong/
    @echo "template/micfong <- {{design}}"

# Every variant is compiled with its own build token; light/sans is stored.
#
# Register one course with MDS.
push course:
    @{{mds}} push "{{course}}/main.typ" --out build

# Register every course, then the Part IA series pinned to them.
push-all:
    @{{mds}} push --all --out build

# Validate the Ponder registry and run its tests.
ponder-check:
    @cd ponder && pnpm ponder:check

# Regenerate the website export for every course.
ponder-export:
    @cd ponder && pnpm ponder:export -- --course all

clean:
    rm -rf build
