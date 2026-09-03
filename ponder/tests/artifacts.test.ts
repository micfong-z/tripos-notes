import assert from "node:assert/strict";
import test from "node:test";
import { mkdtemp, mkdir, readFile, readdir, writeFile } from "node:fs/promises";
import { tmpdir } from "node:os";
import path from "node:path";
import { mergeTooltipShards, pruneArtifacts } from "../scripts/export.js";

async function createShards(shards: Record<string, Record<string, unknown>>) {
  const root = await mkdtemp(path.join(tmpdir(), "ponder-artifacts-test-"));
  const directory = path.join(root, "tooltip");
  await mkdir(directory, { recursive: true });
  for (const [course, records] of Object.entries(shards)) {
    await writeFile(path.join(directory, `${course}.json`), JSON.stringify(records));
  }
  return { root, directory, merged: path.join(root, "tooltip-index.json") };
}

test("the merged index is the union of the shards, with sorted keys", async () => {
  const { directory, merged } = await createShards({
    groups: { "algebra.b": { id: "algebra.b" }, "algebra.a": { id: "algebra.a" } },
    "vectors-and-matrices": { "linear-algebra.c": { id: "linear-algebra.c" } },
  });
  await mergeTooltipShards(directory, merged, ["groups", "vectors-and-matrices"], true);
  const contents = JSON.parse(await readFile(merged, "utf8"));
  assert.deepEqual(Object.keys(contents), ["algebra.a", "algebra.b", "linear-algebra.c"]);
});

test("merging is deterministic regardless of which course wrote last", async () => {
  const records = {
    groups: { "algebra.a": { id: "algebra.a" } },
    "numbers-and-sets": { "set-theory.z": { id: "set-theory.z" } },
  };
  const first = await createShards(records);
  await mergeTooltipShards(first.directory, first.merged, Object.keys(records), true);
  const second = await createShards({ ...records });
  await mergeTooltipShards(second.directory, second.merged, Object.keys(records), true);
  assert.equal(await readFile(first.merged, "utf8"), await readFile(second.merged, "utf8"));
});

test("an entry removed from a course disappears instead of lingering", async () => {
  const { directory, merged } = await createShards({
    groups: { "algebra.a": { id: "algebra.a" }, "algebra.gone": { id: "algebra.gone" } },
  });
  await mergeTooltipShards(directory, merged, ["groups"], true);
  assert.ok("algebra.gone" in JSON.parse(await readFile(merged, "utf8")));

  await writeFile(path.join(directory, "groups.json"), JSON.stringify({ "algebra.a": { id: "algebra.a" } }));
  await mergeTooltipShards(directory, merged, ["groups"], true);
  assert.deepEqual(Object.keys(JSON.parse(await readFile(merged, "utf8"))), ["algebra.a"]);
});

test("a merge missing another course's shard is reported, not silently partial", async (t) => {
  const warnings: string[] = [];
  t.mock.method(console, "warn", (message: string) => { warnings.push(message); });
  const { directory, merged } = await createShards({ groups: { "algebra.a": { id: "algebra.a" } } });

  await mergeTooltipShards(directory, merged, ["groups", "numbers-and-sets"], true);
  assert.equal(warnings.length, 1);
  assert.match(warnings[0], /missing numbers-and-sets/);

  // Suppressed mid-way through a `--course all` run, where shards are still
  // being written.
  await mergeTooltipShards(directory, merged, ["groups", "numbers-and-sets"], false);
  assert.equal(warnings.length, 1);
});

test("pruning removes only artifacts no entry claims", async () => {
  const root = await mkdtemp(path.join(tmpdir(), "ponder-prune-test-"));
  const entries = path.join(root, "entries");
  await mkdir(entries, { recursive: true });
  for (const id of ["algebra.a", "algebra.renamed", "set-theory.z"]) {
    await writeFile(path.join(entries, `${id}.json`), "{}");
  }
  await writeFile(path.join(entries, "keep.txt"), "not an artifact");

  const removed = await pruneArtifacts(entries, new Set(["algebra.a", "set-theory.z"]));
  assert.deepEqual(removed, ["algebra.renamed"]);
  assert.deepEqual((await readdir(entries)).sort(), ["algebra.a.json", "keep.txt", "set-theory.z.json"]);
});
