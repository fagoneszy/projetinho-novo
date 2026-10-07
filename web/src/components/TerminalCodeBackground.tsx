"use client";

import { useEffect, useRef } from "react";

const glyphs = "01{}[]<>/\\=+-_#$:;abcdef";
const cellWidth = 14;
const cellHeight = 18;
const hoverRadius = 88;
const warmColors = ["255, 111, 0", "255, 174, 0", "255, 58, 36", "255, 83, 138"];

export default function TerminalCodeBackground() {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    const section = canvas?.parentElement;
    const context = canvas?.getContext("2d");
    if (!canvas || !section || !context) return;

    let width = 0;
    let height = 0;
    let frame = 0;
    let pointer: { x: number; y: number } | null = null;
    let columns = 0;
    let rows = 0;
    let strengths = new Float32Array(0);
    let activeCells = new Uint8Array(0);
    let highlightedGlyphs = new Uint8Array(0);
    let highlightedColors = new Uint8Array(0);

    const draw = () => {
      frame = 0;
      context.clearRect(0, 0, width, height);
      context.font = "11px ui-monospace, SFMono-Regular, Menlo, monospace";
      context.textAlign = "center";
      context.textBaseline = "middle";
      let hasTransition = false;

      for (let row = 0; row < rows; row += 1) {
        for (let column = 0; column < columns; column += 1) {
          const x = column * cellWidth + cellWidth / 2;
          const y = row * cellHeight + cellHeight / 2;
          const index = row * columns + column;
          const seed = (column * 17 + row * 31) % glyphs.length;
          const distance = pointer
            ? Math.hypot(pointer.x - x, pointer.y - y)
            : Number.POSITIVE_INFINITY;
          const targetStrength = distance < hoverRadius
            ? 1 - distance / hoverRadius
            : 0;
          const previousStrength = strengths[index];
          const nextStrength = previousStrength + (targetStrength - previousStrength) * 0.2;
          strengths[index] = nextStrength;

          if (targetStrength > 0 && activeCells[index] === 0) {
            activeCells[index] = 1;
            highlightedGlyphs[index] = Math.floor(Math.random() * glyphs.length);
            highlightedColors[index] = Math.floor(Math.random() * warmColors.length);
          } else if (targetStrength === 0 && nextStrength < 0.025) {
            activeCells[index] = 0;
          }

          context.fillStyle = "rgba(75, 110, 125, 0.28)";
          context.shadowColor = "transparent";
          context.shadowBlur = 0;
          context.fillText(glyphs[seed], x, y);

          if (nextStrength > 0.025) {
            const color = warmColors[highlightedColors[index]];
            context.fillStyle = `rgba(${color}, ${nextStrength * 0.92})`;
            context.shadowColor = `rgba(${color}, ${nextStrength * 0.48})`;
            context.shadowBlur = 8 * nextStrength;
            if (activeCells[index]) {
              context.fillText(glyphs[highlightedGlyphs[index]], x, y);
            }
            hasTransition ||= Math.abs(targetStrength - nextStrength) > 0.01;
          } else {
            activeCells[index] = 0;
          }
        }
      }

      if (hasTransition) scheduleDraw();
    };

    const scheduleDraw = () => {
      if (!frame) frame = window.requestAnimationFrame(draw);
    };

    const resize = () => {
      const bounds = section.getBoundingClientRect();
      const ratio = Math.min(window.devicePixelRatio || 1, 2);
      width = bounds.width;
      height = bounds.height;
      canvas.width = Math.round(width * ratio);
      canvas.height = Math.round(height * ratio);
      canvas.style.width = `${width}px`;
      canvas.style.height = `${height}px`;
      context.setTransform(ratio, 0, 0, ratio, 0, 0);
      columns = Math.ceil(width / cellWidth);
      rows = Math.ceil(height / cellHeight);
      const cellCount = columns * rows;
      strengths = new Float32Array(cellCount);
      activeCells = new Uint8Array(cellCount);
      highlightedGlyphs = new Uint8Array(cellCount);
      highlightedColors = new Uint8Array(cellCount);
      scheduleDraw();
    };

    const handlePointerMove = (event: PointerEvent) => {
      const bounds = section.getBoundingClientRect();
      if (
        event.clientX < bounds.left ||
        event.clientX > bounds.right ||
        event.clientY < bounds.top ||
        event.clientY > bounds.bottom
      ) {
        if (pointer) {
          pointer = null;
          scheduleDraw();
        }
        return;
      }

      pointer = {
        x: event.clientX - bounds.left,
        y: event.clientY - bounds.top,
      };
      scheduleDraw();
    };

    const handlePointerOut = (event: PointerEvent) => {
      if (event.relatedTarget instanceof Node && section.contains(event.relatedTarget)) {
        return;
      }
      pointer = null;
      scheduleDraw();
    };

    const resizeObserver = new ResizeObserver(resize);
    resizeObserver.observe(section);
    window.addEventListener("pointermove", handlePointerMove, { passive: true });
    section.addEventListener("pointerleave", handlePointerOut);
    resize();

    return () => {
      resizeObserver.disconnect();
      window.removeEventListener("pointermove", handlePointerMove);
      section.removeEventListener("pointerleave", handlePointerOut);
      if (frame) window.cancelAnimationFrame(frame);
    };
  }, []);

  return (
    <div
      aria-hidden="true"
      className="pointer-events-none absolute inset-0 z-0 overflow-hidden"
      style={{
        maskImage:
          "linear-gradient(to bottom, transparent, black 18%, black 82%, transparent)",
      }}
    >
      <canvas ref={canvasRef} className="absolute inset-0" />
    </div>
  );
}
