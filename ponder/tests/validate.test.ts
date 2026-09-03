import assert from "node:assert/strict";
import test from "node:test";
import { mkdtemp, mkdir, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import { validate } from "../scripts/validate.js";

const profile = (course: string, directory: string) => [
  `course: ${course}`,
  `title: Test ${course}`,
  `document: ${directory}/main.typ`,
  `sourceBase: /notes/${course}/content`,
  "typstVersion: 0.14.2",
  "",
].join("\n");

async function writeEntry(root: string, id: string, entry: Record<string, unknown>) {
  const directory = path.join(root, "ponder/entries", id);
  await mkdir(directory, { recursive: true });
  await writeFile(path.join(directory, "entry.yml"), JSON.stringify({ id, ...entry }));
  await writeFile(path.join(directory, "summary.typ"), "A summary.\n");
}

/// Two courses sharing one entry registry: Groups owns a good entry, Numbers
/// and Sets owns a broken one, and Groups annotates a concept it does not own.
async function createWorkspace() {
  const root = await mkdtemp(path.join(tmpdir(), "ponder-validate-test-"));
  await mkdir(path.join(root, "ponder/courses"), { recursive: true });
  await mkdir(path.join(root, "Groups/chapters"), { recursive: true });
  await mkdir(path.join(root, "Numbers and Sets/chapters"), { recursive: true });
  await writeFile(path.join(root, "ponder/config.yml"), "defaultCourse: groups\n");
  await writeFile(path.join(root, "ponder/courses/groups.yml"), profile("groups", "Groups"));
  await writeFile(path.join(root, "ponder/courses/numbers-and-sets.yml"), profile("numbers-and-sets", "Numbers and Sets"));
  await writeFile(path.join(root, "Groups/main.typ"), '#include "chapters/chapter-1.typ"\n');
  await writeFile(path.join(root, "Numbers and Sets/main.typ"), '#include "chapters/chapter-1.typ"\n');

  await writeFile(
    path.join(root, "Groups/chapters/chapter-1.typ"),
    '#definition[A #ponder("algebra.group")[group] acts on a #ponder("set-theory.set")[set].] <def-group>\n',
  );
  await writeFile(path.join(root, "Numbers and Sets/chapters/chapter-1.typ"), "#definition[A set.] <def-set>\n#definition[A prime.] <def-prime>\n");

  const section = (label: string, document: string) => ({ title: "Definition", kind: "definition", source: { document, label } });
  await writeEntry(root, "algebra.group", {
    kind: "definition", title: "Group", aliases: [], tags: [], summary: "summary.typ",
    primarySource: { document: "Groups/chapters/chapter-1.typ", label: "def-group" },
    sections: [section("def-group", "Groups/chapters/chapter-1.typ")],
    related: [],
  });
  await writeEntry(root, "set-theory.set", {
    kind: "definition", title: "Set", aliases: [], tags: [], summary: "summary.typ",
    primarySource: { document: "Numbers and Sets/chapters/chapter-1.typ", label: "def-set" },
    sections: [section("def-set", "Numbers and Sets/chapters/chapter-1.typ")],
    related: [],
  });
  return root;
}

test("a course validates on its own entries and the ones it annotates", async () => {
  const root = await createWorkspace();
  const result = await validate(root, "ponder/courses/groups.yml");
  assert.deepEqual([...result.ownedIds], ["algebra.group"]);
  assert.deepEqual([...result.annotatedIds].sort(), ["algebra.group", "set-theory.set"]);
  // A concept owned elsewhere but annotated here is in scope, because a broken
  // one would break this course's output.
  assert.equal(result.courseIds.has("set-theory.set"), true);
});

test("another course's broken entry does not fail this course", async () => {
  const root = await createWorkspace();
  await writeEntry(root, "number-theory.prime", {
    kind: "not-a-kind", title: "", aliases: [], tags: [], summary: "summary.typ",
    primarySource: { document: "Numbers and Sets/chapters/chapter-1.typ", label: "def-prime" },
    sections: [], related: [],
  });

  await validate(root, "ponder/courses/groups.yml");
  await assert.rejects(() => validate(root, "ponder/courses/groups.yml", { all: true }), /invalid kind not-a-kind/);
  await assert.rejects(() => validate(root, "ponder/courses/numbers-and-sets.yml"), /invalid kind not-a-kind/);
});

test("an unreadable entry elsewhere is a note here and an error under --all", async () => {
  const root = await createWorkspace();
  const directory = path.join(root, "ponder/entries/analysis.broken");
  await mkdir(directory, { recursive: true });
  await writeFile(path.join(directory, "entry.yml"), "id: [unclosed\n");

  const result = await validate(root, "ponder/courses/groups.yml");
  assert.equal(result.notes.some((note) => note.includes("analysis.broken")), true);
  await assert.rejects(() => validate(root, "ponder/courses/groups.yml", { all: true }), /analysis\.broken/);
});

test("an annotated id with no entry is reported where the Typst dictionary used to panic", async () => {
  const root = await createWorkspace();
  await writeFile(
    path.join(root, "Groups/chapters/chapter-1.typ"),
    '#definition[A #ponder("algebra.missing")[group].] <def-group>\n',
  );
  await assert.rejects(
    () => validate(root, "ponder/courses/groups.yml"),
    /#ponder\("algebra\.missing"\) has no entry in ponder\/entries/,
  );
});

test("one source label may not map to two entries", async () => {
  const root = await createWorkspace();
  await writeEntry(root, "algebra.duplicate", {
    kind: "definition", title: "Duplicate", aliases: [], tags: [], summary: "summary.typ",
    primarySource: { document: "Groups/chapters/chapter-1.typ", label: "def-group" },
    sections: [{ title: "Definition", kind: "definition", source: { document: "Groups/chapters/chapter-1.typ", label: "def-group" } }],
    related: [],
  });
  await assert.rejects(() => validate(root, "ponder/courses/groups.yml"), /maps to both/);
});
