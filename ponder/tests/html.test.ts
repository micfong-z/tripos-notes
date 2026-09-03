import assert from "node:assert/strict";
import test from "node:test";
import { attr, isElement, makeTocNavigationOnly, parseDocument, serialize, setAttr, textContent, walk } from "../scripts/html.js";

test("structural enrichment preserves reference href and text", () => {
  const document = parseDocument('<html><body><a href="#mapped">Theorem 4.1</a><a href="#other">Other</a><a href="https://example.com">External</a></body></html>');
  const before = serialize(document);
  let mapped;
  walk(document, (node) => {
    if (isElement(node) && node.tagName === "a" && attr(node, "href") === "#mapped") mapped = node;
  });
  assert.ok(mapped);
  const href = attr(mapped, "href");
  const text = textContent(mapped);
  setAttr(mapped, "data-ponder-id", "algebra.example");
  assert.equal(attr(mapped, "href"), href);
  assert.equal(textContent(mapped), text);
  const after = serialize(document);
  assert.match(after, /href="#other">Other<\/a>/);
  assert.match(after, /href="https:\/\/example.com">External<\/a>/);
  assert.notEqual(after, before);
});

test("TOC ponder copies become fragment links without retargeting nested entries", () => {
  const document = parseDocument(`
    <html><body><nav role="doc-toc"><ol>
      <li>
        <a href="#parent">1 Parent </a>
        <a class="ponder-anchor extra" href="/notes/ponder/algebra.parent" data-ponder-id="algebra.parent" data-ponder-kind="definition">Concept</a>
        and plain text <span>with formatting</span>
        <ol><li>
          <a href="#child">1.1 </a>
          <a class="ponder-anchor" href="/notes/ponder/algebra.child" data-ponder-id="algebra.child" data-ponder-kind="theorem" data-ponder-variant="course">Child</a>
          then <a class="ponder-anchor" href="/notes/ponder/algebra.second" data-ponder-id="algebra.second" data-ponder-kind="definition">another concept</a>, finally
        </li></ol>
      </li>
    </ol></nav></body></html>
  `);

  makeTocNavigationOnly(document);

  const tocAnchors: Array<{ href?: string; id?: string; className?: string; text: string }> = [];
  walk(document, (node) => {
    if (!isElement(node) || node.tagName !== "a") return;
    tocAnchors.push({
      href: attr(node, "href"),
      id: attr(node, "data-ponder-id"),
      className: attr(node, "class"),
      text: textContent(node).trim(),
    });
  });

  assert.deepEqual(tocAnchors, [
    { href: "#parent", id: undefined, className: undefined, text: "1 Parent" },
    { href: "#parent", id: undefined, className: "extra", text: "Concept" },
    { href: "#parent", id: undefined, className: undefined, text: "and plain text" },
    { href: "#parent", id: undefined, className: undefined, text: "with formatting" },
    { href: "#child", id: undefined, className: undefined, text: "1.1" },
    { href: "#child", id: undefined, className: undefined, text: "Child" },
    { href: "#child", id: undefined, className: undefined, text: "then" },
    { href: "#child", id: undefined, className: undefined, text: "another concept" },
    { href: "#child", id: undefined, className: undefined, text: ", finally" },
  ]);
});
