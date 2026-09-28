import assert from "node:assert/strict";
import test from "node:test";
import { mkdtemp, mkdir, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import { includedSourceBlocks } from "../scripts/export.js";

/// A course laid out as the notes are: main.typ applies the layout and includes
/// content.typ, which includes the chapters.
async function createCourse(files: Record<string, string>) {
  const root = await mkdtemp(path.join(tmpdir(), "ponder-source-blocks-test-"));
  for (const [file, text] of Object.entries(files)) {
    await mkdir(path.dirname(path.join(root, file)), { recursive: true });
    await writeFile(path.join(root, file), text);
  }
  return root;
}

test("source blocks are collected through nested includes, in typeset order", async () => {
  const root = await createCourse({
    "course/main.typ": '#show: project.with(..meta)\n#include "content.typ"\n',
    "course/content.typ": '#contents()\n#include "chapters/chapter-1.typ"\n#pagebreak()\n#include "/course/chapters/chapter-2.typ"\n',
    "course/chapters/chapter-1.typ": "#definition[A group.] <def-group>\n#proof[Not a source block.]\n#theorem[Lagrange.]\n",
    "course/chapters/chapter-2.typ": '#example("Cyclic")[$ZZ_n$.] <ex-cyclic>\n',
  });
  assert.deepEqual(await includedSourceBlocks(root, "course/main.typ"), [
    { document: "course/chapters/chapter-1.typ", label: "def-group" },
    { document: "course/chapters/chapter-1.typ", label: undefined },
    { document: "course/chapters/chapter-2.typ", label: "ex-cyclic" },
  ]);
});

test("a file's own blocks keep their place around its includes", async () => {
  const root = await createCourse({
    "main.typ": '#definition[Before.] <before>\n#include "chapter.typ"\n#definition[After.] <after>\n',
    "chapter.typ": "#lemma[Inside.] <inside>\n",
  });
  const labels = (await includedSourceBlocks(root, "main.typ")).map((block) => block.label);
  assert.deepEqual(labels, ["before", "inside", "after"]);
});

test("an include cycle is reported instead of recursing forever", async () => {
  const root = await createCourse({
    "a.typ": '#include "b.typ"\n',
    "b.typ": '#include "a.typ"\n',
  });
  await assert.rejects(includedSourceBlocks(root, "a.typ"), /a\.typ includes itself/);
});
