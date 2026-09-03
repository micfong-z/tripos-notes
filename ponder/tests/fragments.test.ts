import assert from "node:assert/strict";
import test from "node:test";
import { mkdtemp, mkdir, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import { environmentKey, splitFragmentDocument, wrapperDocument } from "../scripts/fragments.js";

const options = (root: string) => ({
  root,
  stagingRoot: root,
  typstVersion: "0.14.2",
  theme: "dark",
  cacheDirectory: path.join(root, "cache"),
  useCache: true,
});

async function createRoot() {
  const root = await mkdtemp(path.join(tmpdir(), "ponder-fragments-test-"));
  await mkdir(path.join(root, "template"), { recursive: true });
  await mkdir(path.join(root, "ponder"), { recursive: true });
  await writeFile(path.join(root, "template/lib.typ"), '#import "ponder.typ": *\n#let project(body) = body\n');
  await writeFile(path.join(root, "template/ponder.typ"), "#let ponder(id, body) = body\n");
  await writeFile(path.join(root, "ponder/fragment-preamble.typ"), "#let ii = math.upright(\"i\")\n");
  return root;
}

test("each fragment sits at top level between markers", () => {
  const document = wrapperDocument([{ text: "first\n" }, { text: "  second  " }]);
  assert.match(document, /^#import "\/template\/lib\.typ": \*\n/);
  assert.match(document, /#import "\/ponder\/fragment-preamble\.typ": \*/);
  assert.match(document, /#show: project/);
  assert.match(document, /#html\.elem\("hr", attrs: \(id: "ponder-fragment-0"\)\)\n\nfirst\n/);
  assert.match(document, /#html\.elem\("hr", attrs: \(id: "ponder-fragment-1"\)\)\n\nsecond\n/);
  assert.match(document, /ponder-fragment-end/);
});

test("a compiled group splits back into its fragments", () => {
  const body = '<hr id="ponder-fragment-0"><p>alpha</p> <hr id="ponder-fragment-1"><p>beta</p><hr id="ponder-fragment-end">';
  assert.deepEqual(splitFragmentDocument(body, 2), ["<p>alpha</p>", "<p>beta</p>"]);
});

test("a group that does not split cleanly is an error, never a silent mismatch", () => {
  const body = '<hr id="ponder-fragment-0"><p>alpha</p><hr id="ponder-fragment-end">';
  assert.throws(() => splitFragmentDocument(body, 2), /produced 1 sections for 2 fragments/);
});

test("the cache key follows the template, its imports, the preamble, and the Typst version", async () => {
  const root = await createRoot();
  const baseline = await environmentKey(options(root));
  assert.equal(await environmentKey(options(root)), baseline);

  assert.notEqual(await environmentKey({ ...options(root), typstVersion: "0.14.3" }), baseline);

  await writeFile(path.join(root, "ponder/fragment-preamble.typ"), "#let ii = math.upright(\"j\")\n");
  const afterPreamble = await environmentKey(options(root));
  assert.notEqual(afterPreamble, baseline);

  // ponder.typ is reached only by following the template's own import.
  await writeFile(path.join(root, "template/ponder.typ"), "#let ponder(id, body) = [#body]\n");
  const afterPonder = await environmentKey(options(root));
  assert.notEqual(afterPonder, afterPreamble);

  // The shared template is imported root-absolutely ("/template/lib.typ"), so
  // the key must follow a leading slash instead of resolving it relative to the
  // importing file.
  await writeFile(path.join(root, "template/lib.typ"), '#import "ponder.typ": *\n#let project(body) = [#body]\n');
  assert.notEqual(await environmentKey(options(root)), afterPonder);

  // The colour scheme is baked into the compiled fragment.
  assert.notEqual(await environmentKey({ ...options(root), theme: "light" }), await environmentKey(options(root)));
});
