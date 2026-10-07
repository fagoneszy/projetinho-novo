"use client";

import { useEffect, useRef } from "react";

const glyphs = "01{}[]<>/\\=+-_#$:;abcdef";
const cellWidth = 14;
const cellHeight = 18;
const hoverRadius = 150;

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

    const draw = () => {
      frame = 0;
      context.clearRect(0, 0, width, height);
      context.font = "11px ui-monospace, SFMono-Regular, Menlo, monospace";
      context.textAlign = "center";
      context.textBaseline = "middle";

      for (let row = 0; row < rows; row += 1) {
        for (let column = 0; column < columns; column += 1) {
          const x = column * cellWidth + cellWidth / 2;
          const y = row * cellHeight + cellHeight / 2;
          const seed = (column * 17 + row * 31) % glyphs.length;
          const glyph = glyphs[seed];
          const distance = pointer
            ? Math.hypot(pointer.x - x, pointer.y - y)
            : hoverRadius;

          if (pointer && distance < hoverRadius) {
            const strength = 1 - distance / hoverRadius;
            const hue = (column * 13 + row * 7) % 3;
            const color = ["0, 255, 255", "0, 255, 115", "196, 0, 255"][hue];
            context.fillStyle = `rgba(${color}, ${0.3 + strength * 0.7})`;
            context.shadowColor = `rgba(${color}, ${0.9 * strength})`;
            context.shadowBlur = 16 * strength;
          } else {
            context.fillStyle = "rgba(75, 110, 125, 0.28)";
            context.shadowColor = "transparent";
            context.shadowBlur = 0;
          }

          context.fillText(glyph, x, y);
        }
      }
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
