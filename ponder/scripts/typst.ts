import { execFile } from "node:child_process";
import { promisify } from "node:util";

const execFileAsync = promisify(execFile);

export interface CompileOptions {
  /// Absolute path to the vendored `fonts/` directory. System fonts are ignored
  /// so an export matches what CI and every other clone produces.
  fontPath: string;
  /// Colour scheme the website expects. The old html-template hard-coded dark.
  theme: string;
}

export async function compileTypst(input: string, output: string, cwd: string, options: CompileOptions) {
  await execFileAsync(
    "typst",
    [
      "compile",
      "--root", cwd,
      "--features", "html",
      "--font-path", options.fontPath,
      "--ignore-system-fonts",
      "--input", "target=html",
      "--input", `theme=${options.theme}`,
      input,
      output,
    ],
    { cwd, maxBuffer: 20 * 1024 * 1024 },
  );
}

export async function assertTypstVersion(expected: string) {
  const { stdout } = await execFileAsync("typst", ["--version"]);
  if (!stdout.includes(`typst ${expected}`)) throw new Error(`Expected Typst ${expected}, got ${stdout.trim()}`);
}
