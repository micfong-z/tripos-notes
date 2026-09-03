export const kinds = [
  "term", "noun", "definition", "theorem", "proposition", "lemma", "claim",
  "corollary", "warning", "important", "example", "remark", "notation", "proof",
  "exercise", "solution",
] as const;

export type PonderKind = typeof kinds[number];

export interface SourceRef {
  document: string;
  label: string;
  kind?: PonderKind;
  referenceTarget?: boolean;
}

export interface PonderSection {
  title: string;
  kind: PonderKind;
  source?: SourceRef;
  supplemental?: string;
}

export interface PonderVariant {
  title: string;
  description: string;
  primarySource?: SourceRef;
}

export interface PonderEntry {
  id: string;
  kind: PonderKind;
  title: string;
  wikidataQID?: string;
  aliases: string[];
  tags: string[];
  summary: string;
  primarySource: SourceRef;
  sections: PonderSection[];
  related: string[];
  variants?: Record<string, PonderVariant>;
  directory: string;
}

export interface PonderConfig {
  course: string;
  title: string;
  document: string;
  /// The course's `prelude.typ`, which imports the shared `/template/lib.typ`.
  /// Defaults to `<course dir>/prelude.typ`.
  prelude: string;
  /// Colour scheme for the HTML export.
  htmlTheme: string;
  locale: string;
  canonicalBase: string;
  sourceBase: string;
  typstVersion: string;
  outputName: string;
  siteDirectory?: string;
  batchDocuments: string[];
  budgets: {
    tooltipIndexGzip: number;
    clientJavaScriptGzip: number;
    baseDocumentGrowthPercent: number;
    /// Soft budget: the merged, cross-course index the website actually ships.
    /// Exceeding it warns rather than failing a single course's export.
    tooltipIndexMergedGzip?: number;
  };
}

export interface SourceArtifact {
  document: string;
  label: string;
  role: "primary" | "supporting" | "variant";
  variant?: string;
  href: string;
  display: string;
  heading: string;
}

export interface TooltipEntry {
  id: string;
  kind: PonderKind;
  accent: string;
  title: string;
  aliases: string[];
  summaryHtml: string;
  href: string;
  sources: SourceArtifact[];
}

export interface EntryArtifact extends TooltipEntry {
  wikidataQID?: string;
  tags: string[];
  related: Array<{ id: string; title: string }>;
  variants: Record<string, PonderVariant>;
  sections: Array<{
    title: string;
    kind: PonderKind;
    accent: string;
    html: string;
    isPrimarySource: boolean;
  }>;
  referredTo: Array<{ href: string; text: string }>;
}

export const accentByKind: Record<PonderKind, string> = {
  term: "#E43748", noun: "#E43748", definition: "#E43748",
  theorem: "#EC6F27", proposition: "#EC6F27", lemma: "#EC6F27", claim: "#EC6F27",
  corollary: "#FFC107", warning: "#FFC107", important: "#FFC107",
  example: "#007AF5", remark: "#007AF5", notation: "#007AF5",
  proof: "#808080",
  exercise: "#9154FF", solution: "#9154FF",
};
