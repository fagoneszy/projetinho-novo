export default function VideoBackground({ src, overlay = "from-[#030303]/80 via-[#030303]/60 to-[#030303]" }: { src: string; overlay?: string }) {
  return (
    <div className="absolute inset-0 -z-10 overflow-hidden">
      <video
        autoPlay
        muted
        loop
        playsInline
        preload="metadata"
        className="h-full w-full object-cover"
        poster=""
      >
        <source src={src} type="video/mp4" />
      </video>
      <div className={`pointer-events-none absolute inset-0 bg-gradient-to-t ${overlay} backdrop-blur-[1px]`} />
      <div className="pointer-events-none absolute inset-0 bg-[radial-gradient(circle_at_center,rgba(255,255,255,0.06)_0,transparent_70%)]" />
    </div>
  );
}
