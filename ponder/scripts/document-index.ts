import type { DefaultTreeAdapterMap } from "parse5";
import { attr, hasClass, isElement, textContent, walk } from "./html.js";

type Element = DefaultTreeAdapterMap["element"];
type Node = DefaultTreeAdapterMap["node"];
type Document = DefaultTreeAdapterMap["document"];

export interface ReferenceAnchor {
  element: Element;
  href: string;
  text: string;
  rawText: string;
}

export interface DocumentIndex {
  byId: Map<string, Element>;
  headingFor: Map<Element, string>;
  anchorsByHref: Map<string, ReferenceAnchor[]>;
  sourceBlocks: Element[];
  ponderAnchors: Element[];
}

const headingPattern = /^h[2-4]$/;
const collapse = (value: string) => value.replace(/\s+/g, " ").trim();

function hasShowyboxAncestor(element: Element) {
  let parent: Node | null | undefined = element.parentNode;
  while (parent && isElement(parent)) {
    if (hasClass(parent, "typst-showybox")) return true;
    parent = parent.parentNode;
  }
  return false;
}

/// Collects in one pass everything the exporter used to rediscover with a full
/// document walk per lookup. The compiled course HTML is 10-15 MB, so this
/// replaces roughly a thousand traversals of a very large tree.
///
/// Build the index after `makeTocNavigationOnly`, which rewrites existing
/// anchors and creates new ones.
export function indexDocument(document: Document): DocumentIndex {
  const index: DocumentIndex = {
    byId: new Map(),
    headingFor: new Map(),
    anchorsByHref: new Map(),
    sourceBlocks: [],
    ponderAnchors: [],
  };
  let heading = "";

  walk(document, (node) => {
    if (!isElement(node)) return;
    const id = attr(node, "id");
    const showybox = hasClass(node, "typst-showybox");
    const sourceBlock = showybox || hasClass(node, "typst-simple-callout");

    // Recorded before the heading below updates, so a labeled heading keeps
    // reporting the heading that precedes it.
    if (id !== undefined || sourceBlock) index.headingFor.set(node, heading);
    // The previous findById kept the last match in document order.
    if (id !== undefined) index.byId.set(id, node);
    if (showybox && !hasShowyboxAncestor(node)) index.sourceBlocks.push(node);
    if (attr(node, "data-ponder-id") !== undefined) index.ponderAnchors.push(node);

    if (node.tagName === "a") {
      const href = attr(node, "href");
      if (href?.startsWith("#")) {
        const raw = textContent(node);
        const anchors = index.anchorsByHref.get(href);
        const anchor: ReferenceAnchor = { element: node, href, text: collapse(raw), rawText: raw };
        if (anchors) anchors.push(anchor);
        else index.anchorsByHref.set(href, [anchor]);
      }
    }

    if (headingPattern.test(node.tagName)) heading = collapse(textContent(node));
  });

  return index;
}

export function referencesTo(index: DocumentIndex, label: string) {
  return index.anchorsByHref.get(`#${label}`) ?? [];
}

/// Registers an id assigned after indexing, keeping lookups consistent.
export function registerId(index: DocumentIndex, element: Element, id: string) {
  index.byId.set(id, element);
}
