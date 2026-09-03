import assert from "node:assert/strict";
import test from "node:test";
import type { DefaultTreeAdapterMap } from "parse5";
import { indexDocument, referencesTo } from "../scripts/document-index.js";
import { attr, isElement, makeTocNavigationOnly, parseDocument, serialize, setAttr, textContent, walk } from "../scripts/html.js";

type Element = DefaultTreeAdapterMap["element"];
type Document = DefaultTreeAdapterMap["document"];

// The implementations the index replaced, kept here so the parity tests below
// compare against the exact behaviour the exporter used to have.
function findById(document: Document, id: string) {
  let result: Element | undefined;
  walk(document, (node) => { if (isElement(node) && attr(node, "id") === id) result = node; });
  return result;
}

function headingBefore(document: Document, target: Element) {
  const headings: Element[] = [];
  let reached = false;
  walk(document, (node) => {
    if (node === target) reached = true;
    if (!reached && isElement(node) && /^h[2-4]$/.test(node.tagName)) headings.push(node);
  });
  const heading = headings.at(-1);
  return heading ? textContent(heading).replace(/\s+/g, " ").trim() : "";
}

function oldReferencesTo(document: Document, label: string) {
  const references: Array<{ href: string; text: string }> = [];
  walk(document, (node) => {
    if (!isElement(node) || node.tagName !== "a") return;
    if (attr(node, "href") === `#${label}`) {
      references.push({ href: `#${label}`, text: textContent(node).replace(/\s+/g, " ").trim() });
    }
  });
  return references;
}

const fixture = `<html><body>
  <h2 id="chapter-one">1 First   chapter</h2>
  <p>Intro with <a href="#thm-a">Theorem 1.1</a> and <a href="#thm-a">again</a>.</p>
  <div class="typst-showybox" id="def-a"><div class="typst-red-title">Definition 1</div>
    <div class="typst-showybox"><span id="nested">nested block</span></div>
  </div>
  <h3 id="section-two">1.2 Second
     section</h3>
  <div class="typst-showybox"><div class="typst-orange-title">Theorem 1.1</div></div>
  <div class="typst-simple-callout" id="proof-a">proof</div>
  <h2 id="chapter-two">2 Later</h2>
  <a href="https://example.com">external</a>
  <a href="#def-a">Definition 1</a>
</body></html>`;

test("the index resolves ids exactly like the walk it replaced", () => {
  const document = parseDocument(fixture);
  const index = indexDocument(document);
  for (const id of ["chapter-one", "def-a", "nested", "section-two", "proof-a", "chapter-two"]) {
    assert.equal(index.byId.get(id), findById(document, id), id);
  }
  assert.equal(index.byId.get("absent"), undefined);
});

test("the index reports the same preceding heading as the walk it replaced", () => {
  const document = parseDocument(fixture);
  const index = indexDocument(document);
  for (const [element, heading] of index.headingFor) {
    assert.equal(heading, headingBefore(document, element), attr(element, "id") ?? element.tagName);
  }
  assert.equal(index.headingFor.get(index.byId.get("def-a")!), "1 First chapter");
  assert.equal(index.headingFor.get(index.byId.get("proof-a")!), "1.2 Second section");
  // A labelled heading keeps reporting the heading before it, not itself.
  assert.equal(index.headingFor.get(index.byId.get("chapter-two")!), "1.2 Second section");
});

test("the index groups fragment references exactly like the walk it replaced", () => {
  const document = parseDocument(fixture);
  const index = indexDocument(document);
  for (const label of ["thm-a", "def-a", "absent"]) {
    assert.deepEqual(
      referencesTo(index, label).map(({ href, text }) => ({ href, text })),
      oldReferencesTo(document, label),
      label,
    );
  }
  // External links never enter the map.
  assert.equal([...index.anchorsByHref.keys()].some((href) => !href.startsWith("#")), false);
});

test("only outermost source blocks are collected, in document order", () => {
  const index = indexDocument(parseDocument(fixture));
  assert.equal(index.sourceBlocks.length, 2);
  assert.equal(attr(index.sourceBlocks[0], "id"), "def-a");
  assert.equal(attr(index.sourceBlocks[1], "id"), undefined);
});

test("reference text is captured before enrichment so mutation is detectable", () => {
  const document = parseDocument(fixture);
  const index = indexDocument(document);
  const [reference] = referencesTo(index, "thm-a");
  setAttr(reference.element, "data-ponder-id", "algebra.example");
  assert.equal(attr(reference.element, "href"), reference.href);
  assert.equal(textContent(reference.element), reference.rawText);
});

test("kind stamping targets only real document anchors, never TOC copies", () => {
  const document = parseDocument(`
    <html><body><nav role="doc-toc"><ol><li>
      <a href="#thm-a">1.1 </a>
      <a class="ponder-anchor" href="/en-US/notes/ponder/algebra.group" data-ponder-id="algebra.group">Group</a>
    </li></ol></nav>
    <h2 id="thm-a">1.1 Groups</h2>
    <p>A <a class="ponder-anchor" href="/en-US/notes/ponder/algebra.group" data-ponder-id="algebra.group">group</a>.</p>
    </body></html>`);

  // The exporter indexes after TOC repair, which is what keeps the stamped
  // metadata out of the navigation copies.
  makeTocNavigationOnly(document);
  const index = indexDocument(document);

  assert.equal(index.ponderAnchors.length, 1);
  for (const anchor of index.ponderAnchors) setAttr(anchor, "data-ponder-kind", "definition");

  const html = serialize(document);
  assert.equal(html.slice(0, html.indexOf("</nav>")).includes("data-ponder-kind"), false);
  assert.match(html, /<a class="ponder-anchor" href="\/en-US\/notes\/ponder\/algebra\.group" data-ponder-id="algebra\.group" data-ponder-kind="definition">group<\/a>/);
});
