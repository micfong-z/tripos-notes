import { autoUpdate, computePosition, flip, offset, shift } from "@floating-ui/dom";

export interface PonderTooltipData { title: string; summaryHtml: string; statedIn: string; accent: string; href: string }

export function positionPonderTooltip(anchor: HTMLElement, tooltip: HTMLElement) {
  return autoUpdate(anchor, tooltip, async () => {
    const { x, y } = await computePosition(anchor, tooltip, {
      placement: "top-start",
      strategy: "fixed",
      middleware: [offset(10), flip(), shift({ padding: 12 })],
    });
    Object.assign(tooltip.style, { left: `${x}px`, top: `${y}px` });
  });
}

export function isPonderAnchor(target: EventTarget | null): target is HTMLAnchorElement {
  return target instanceof Element && target.closest<HTMLAnchorElement>("a[data-ponder-id]") !== null;
}
