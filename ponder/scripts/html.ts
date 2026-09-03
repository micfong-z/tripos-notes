import { parse, parseFragment, serialize, serializeOuter, type DefaultTreeAdapterMap } from "parse5";

type Node = DefaultTreeAdapterMap["node"];
type Element = DefaultTreeAdapterMap["element"];
type Document = DefaultTreeAdapterMap["document"];
type DocumentFragment = DefaultTreeAdapterMap["documentFragment"];

export function parseDocument(html: string): Document {
  return parse(html) as Document;
}

export function walk(node: Node, visit: (node: Node) => void) {
  visit(node);
  if ("childNodes" in node) for (const child of node.childNodes) walk(child, visit);
  if ("content" in node && node.content) walk(node.content, visit);
}

export function isElement(node: Node): node is Element {
  return "tagName" in node;
}

export function attr(element: Element, name: string): string | undefined {
  return element.attrs.find((item) => item.name === name)?.value;
}

export function setAttr(element: Element, name: string, value: string) {
  const existing = element.attrs.find((item) => item.name === name);
  if (existing) existing.value = value;
  else element.attrs.push({ name, value });
}

export function removeAttr(element: Element, name: string) {
  element.attrs = element.attrs.filter((item) => item.name !== name);
}

export function hasClass(element: Element, name: string) {
  return (attr(element, "class") ?? "").split(/\s+/).includes(name);
}

export function removeClass(element: Element, name: string) {
  const classes = (attr(element, "class") ?? "").split(/\s+/).filter((className) => className && className !== name);
  if (classes.length) setAttr(element, "class", classes.join(" "));
  else removeAttr(element, "class");
}

function nearestListItem(node: Node) {
  let current: Node | undefined = node;
  while (current && "parentNode" in current && current.parentNode) {
    current = current.parentNode;
    if (isElement(current) && current.tagName === "li") return current;
  }
  return undefined;
}

function containsRowAnchor(node: Node, item: Element): boolean {
  if (isElement(node) && node.tagName === "a" && nearestListItem(node) === item) return true;
  if (!isElement(node) || node.tagName === "ol" || node.tagName === "ul") return false;
  return node.childNodes.some((child) => containsRowAnchor(child, item));
}

function wrapWithFragmentLink(parent: Element, child: Node, href: string) {
  const fragment = parseFragment("<a></a>") as DocumentFragment;
  const anchor = fragment.childNodes[0] as Element;
  setAttr(anchor, "href", href);
  anchor.childNodes = [child as DefaultTreeAdapterMap["childNode"]];
  anchor.parentNode = parent;
  if ("parentNode" in child) child.parentNode = anchor;
  return anchor;
}

function linkUnwrappedRowContent(parent: Element, item: Element, href: string) {
  parent.childNodes = parent.childNodes.map((child) => {
    if (isElement(child) && (child.tagName === "ol" || child.tagName === "ul")) return child;
    if (isElement(child) && child.tagName === "a") return child;
    if (containsRowAnchor(child, item)) {
      linkUnwrappedRowContent(child as Element, item, href);
      return child;
    }
    if (child.nodeName === "#text" && !textContent(child).trim()) return child;
    return wrapWithFragmentLink(parent, child, href);
  });
}

export function makeTocNavigationOnly(document: Document) {
  let toc: Element | undefined;
  walk(document, (node) => {
    if (toc || !isElement(node) || node.tagName !== "nav" || attr(node, "role") !== "doc-toc") return;
    toc = node;
  });
  if (!toc) return;

  const ponderAnchors: Element[] = [];
  const affectedItems = new Map<Element, string>();
  walk(toc, (node) => {
    if (isElement(node) && node.tagName === "a" && attr(node, "data-ponder-id")) ponderAnchors.push(node);
  });

  for (const anchor of ponderAnchors) {
    const item = nearestListItem(anchor);
    if (!item) throw new Error("Ponder TOC anchor is not inside a list item");
    let fragmentHref: string | undefined;
    walk(item, (node) => {
      if (fragmentHref || !isElement(node) || node.tagName !== "a" || nearestListItem(node) !== item) return;
      const href = attr(node, "href");
      if (href?.startsWith("#")) fragmentHref = href;
    });
    if (!fragmentHref) throw new Error(`Ponder TOC anchor has no fragment target: ${textContent(anchor).trim()}`);
    affectedItems.set(item, fragmentHref);

    setAttr(anchor, "href", fragmentHref);
    for (const name of ["data-ponder-id", "data-ponder-kind", "data-ponder-variant", "data-ponder-reference"]) {
      removeAttr(anchor, name);
    }
    removeClass(anchor, "ponder-anchor");
    removeClass(anchor, "ponder-anchor-block");
  }

  for (const [item, fragmentHref] of affectedItems) linkUnwrappedRowContent(item, item, fragmentHref);

  walk(toc, (node) => {
    if (isElement(node) && node.tagName === "a" && attr(node, "data-ponder-id")) {
      throw new Error("Ponder metadata remains in the generated table of contents");
    }
  });
}

export function textContent(node: Node): string {
  if (node.nodeName === "#text") return "value" in node ? node.value : "";
  if ("childNodes" in node) return node.childNodes.map(textContent).join("");
  return "content" in node && node.content ? textContent(node.content as Node) : "";
}

export function bodyHtml(document: Document) {
  let body: Element | undefined;
  walk(document, (node) => { if (isElement(node) && node.tagName === "body") body = node; });
  return body ? serialize(body) : "";
}

export { serialize, serializeOuter };
