import assert from "node:assert/strict";
import test from "node:test";
import { mkdtemp, mkdir, readFile, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import { createHash } from "node:crypto";
import { applyBatchResult } from "../scripts/batch.js";

/// A temporary repository with the minimum a course profile needs. The loader
/// no longer falls back to a hardcoded Groups configuration.
async function createRoot(prefix: string) {
  const root = await mkdtemp(path.join(tmpdir(), prefix));
  await mkdir(path.join(root, "Groups/chapters"), { recursive: true });
  await mkdir(path.join(root, "ponder/entries"), { recursive: true });
  await mkdir(path.join(root, "ponder/courses"), { recursive: true });
  await writeFile(path.join(root, "ponder/config.yml"), "defaultCourse: groups\n");
  await writeFile(path.join(root, "ponder/courses/groups.yml"), [
    "course: groups",
    "title: Test Groups",
    "document: Groups/main.typ",
    "sourceBase: /notes/ia-groups/content",
    "typstVersion: 0.14.2",
    "",
  ].join("\n"));
  return root;
}

test("reviewed source operations reject references", async () => {
  const root = await createRoot("ponder-batch-test-");
  const source = "See @known[the theorem].\n";
  await writeFile(path.join(root, "Groups/chapters/chapter-1.typ"), source);
  const result = {
    model: "gpt-5.6-luna", promptVersion: "v1",
    inputHash: createHash("sha256").update(source).digest("hex"),
    document: "Groups/chapters/chapter-1.typ",
    concepts: [],
    labelEdits: [],
    edits: [{ document: "Groups/chapters/chapter-1.typ", start: 4, end: 23, expected: "@known[the theorem]", replacement: '#ponder("algebra.known")[@known[the theorem]]', entryId: "algebra.known" }],
  };
  await writeFile(path.join(root, "result.json"), JSON.stringify(result));
  await assert.rejects(() => applyBatchResult(root, "result.json"), /references may not be edited/);
  assert.equal(await readFile(path.join(root, "Groups/chapters/chapter-1.typ"), "utf8"), source);
});

test("reviewed results can create a labeled concept and annotate it", async () => {
  const root = await createRoot("ponder-batch-concept-test-");
  const document = "Groups/chapters/chapter-1.typ";
  const source = "#definition[An orbit is the set of points reached by an action.]\nEvery orbit is nonempty.\n";
  await writeFile(path.join(root, document), source);
  const labelStart = source.indexOf("]");
  const occurrenceStart = source.lastIndexOf("orbit");
  const result = {
    model: "gpt-5.6-luna",
    promptVersion: "v2",
    inputHash: createHash("sha256").update(source).digest("hex"),
    document,
    concepts: [{
      id: "algebra.orbit",
      kind: "definition",
      title: "Orbit",
      wikidataQID: null,
      aliases: ["orbit", "orbits"],
      tags: ["actions"],
      summaryTyp: "The orbit of $x$ is the set of points $g x$ reached as $g$ varies over $G$.",
      primarySource: { document, label: "def-orbit", kind: "definition" },
      related: [],
    }],
    labelEdits: [{
      document,
      start: labelStart,
      end: labelStart + 1,
      expected: "]",
      replacement: "] <def-orbit>",
      label: "def-orbit",
    }],
    edits: [{
      document,
      start: occurrenceStart,
      end: occurrenceStart + "orbit".length,
      expected: "orbit",
      replacement: '#ponder("algebra.orbit")[orbit]',
      entryId: "algebra.orbit",
    }],
  };
  await writeFile(path.join(root, "result.json"), JSON.stringify(result));

  assert.deepEqual(await applyBatchResult(root, "result.json"), { edits: 1, labels: 1, concepts: 1 });
  const updated = await readFile(path.join(root, document), "utf8");
  assert.match(updated, /\] <def-orbit>/);
  assert.match(updated, /#ponder\("algebra\.orbit"\)\[orbit\]/);
  assert.match(await readFile(path.join(root, "ponder/entries/algebra.orbit/entry.yml"), "utf8"), /id: algebra\.orbit/);
  assert.match(await readFile(path.join(root, "ponder/entries/algebra.orbit/summary.typ"), "utf8"), /The orbit of/);
  // The kind is read from the entry registry at export time, so applying a
  // batch must not write a generated per-course registry any more.
  await assert.rejects(() => readFile(path.join(root, "Groups/ponder-kinds.typ"), "utf8"), /ENOENT/);
});

test("reviewed results reject labels that no new concept claims", async () => {
  const root = await createRoot("ponder-batch-orphan-label-test-");
  const document = "Groups/chapters/chapter-1.typ";
  const source = "#definition[An orbit is nonempty.]\n";
  await writeFile(path.join(root, document), source);
  const labelStart = source.indexOf("]");
  const result = {
    model: "gpt-5.6-luna",
    promptVersion: "v2",
    inputHash: createHash("sha256").update(source).digest("hex"),
    document,
    concepts: [],
    labelEdits: [{
      document,
      start: labelStart,
      end: labelStart + 1,
      expected: "]",
      replacement: "] <def-orbit>",
      label: "def-orbit",
    }],
    edits: [],
  };
  await writeFile(path.join(root, "result.json"), JSON.stringify(result));

  await assert.rejects(() => applyBatchResult(root, "result.json"), /not a new concept primary source/);
  assert.equal(await readFile(path.join(root, document), "utf8"), source);
});
