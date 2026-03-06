import { Card } from "../components/ui/card";
import { LevelBadge } from "../components/beachcamp/level-badge";
import { Button } from "../components/ui/button";

export function DesignTokens() {
  return (
    <div className="py-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="mb-12">
          <h1 className="text-4xl font-extrabold text-[#1C1917] mb-2 tracking-tight">Design Tokens</h1>
          <p className="text-lg text-[#78716C]">The building blocks of BeachCamp's visual language</p>
        </div>

        {/* Colors */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Color Palette</h2>
          
          <PaletteSection name="Ocean" desc="Primary — trust, depth, water vibes" colors={[
            { n: "50", c: "#ECFEFF" }, { n: "100", c: "#CFFAFE" }, { n: "200", c: "#A5F3FC" }, { n: "300", c: "#67E8F9" }, { n: "400", c: "#22D3EE" },
            { n: "500", c: "#06B6D4" }, { n: "600", c: "#0891B2" }, { n: "700", c: "#0E7490" }, { n: "800", c: "#155E75" }, { n: "900", c: "#164E63" }
          ]} />
          
          <PaletteSection name="Sunset" desc="Secondary — energy, passion, action" colors={[
            { n: "50", c: "#FFF7ED" }, { n: "100", c: "#FFEDD5" }, { n: "200", c: "#FED7AA" }, { n: "300", c: "#FDBA74" }, { n: "400", c: "#FB923C" },
            { n: "500", c: "#F97316" }, { n: "600", c: "#EA580C" }, { n: "700", c: "#C2410C" }, { n: "800", c: "#9A3412" }, { n: "900", c: "#7C2D12" }
          ]} />

          <PaletteSection name="Sand" desc="Accent — warmth, highlights, golden hour" colors={[
            { n: "50", c: "#FEFCE8" }, { n: "100", c: "#FEF9C3" }, { n: "200", c: "#FEF08A" }, { n: "300", c: "#FDE047" }, { n: "400", c: "#FACC15" },
            { n: "500", c: "#EAB308" }, { n: "600", c: "#CA8A04" }, { n: "700", c: "#A16207" }, { n: "800", c: "#854D0E" }, { n: "900", c: "#713F12" }
          ]} />

          <PaletteSection name="Neutrals" desc="Warm-tinted grays for text & backgrounds" colors={[
            { n: "0", c: "#FFFFFF" }, { n: "50", c: "#FAFAF8" }, { n: "100", c: "#F5F3F0" }, { n: "200", c: "#E8E5E0" }, { n: "300", c: "#D4D0C8" },
            { n: "400", c: "#A8A29E" }, { n: "500", c: "#78716C" }, { n: "600", c: "#57534E" }, { n: "700", c: "#44403C" }, { n: "800", c: "#292524" }, { n: "900", c: "#1C1917" }
          ]} />

          <div className="mt-8">
            <h3 className="font-bold text-[#1C1917] mb-4">States</h3>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
              {[
                { name: "Success", color: "#10B981" }, { name: "Warning", color: "#F59E0B" },
                { name: "Danger", color: "#EF4444" }, { name: "Info", color: "#06B6D4" }
              ].map((s) => (
                <Card key={s.name} className="p-4 rounded-2xl border-[#E8E5E0]">
                  <div className="h-14 rounded-xl mb-3" style={{ backgroundColor: s.color }} />
                  <div className="font-bold text-[#1C1917]">{s.name}</div>
                  <div className="text-xs text-[#A8A29E] font-mono">{s.color}</div>
                </Card>
              ))}
            </div>
          </div>
        </section>

        {/* Typography */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Typography</h2>
          <Card className="p-8 rounded-2xl border-[#E8E5E0]">
            <div className="space-y-8">
              <div><div className="text-xs text-[#A8A29E] mb-2 font-mono">H1 — 40px Extrabold</div><h1>The quick brown fox</h1></div>
              <div><div className="text-xs text-[#A8A29E] mb-2 font-mono">H2 — 32px Bold</div><h2>The quick brown fox</h2></div>
              <div><div className="text-xs text-[#A8A29E] mb-2 font-mono">H3 — 24px Semibold</div><h3>The quick brown fox</h3></div>
              <div><div className="text-xs text-[#A8A29E] mb-2 font-mono">Body — 16px Regular</div><p>The quick brown fox jumps over the lazy dog. Regular body text for content.</p></div>
            </div>
          </Card>
        </section>

        {/* Level Badges */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Level Badges</h2>
          <Card className="p-8 rounded-2xl border-[#E8E5E0]">
            <div className="flex flex-wrap gap-3">
              <LevelBadge level="Beginner" />
              <LevelBadge level="Intermediate" />
              <LevelBadge level="Advanced" />
              <LevelBadge level="Pro" />
              <LevelBadge level="International" />
            </div>
          </Card>
        </section>

        {/* Buttons */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Buttons</h2>
          <Card className="p-8 rounded-2xl border-[#E8E5E0] space-y-6">
            <div>
              <div className="text-xs text-[#A8A29E] mb-3 font-mono">Primary</div>
              <div className="flex flex-wrap gap-3">
                <Button size="sm">Small</Button>
                <Button>Default</Button>
                <Button size="lg">Large</Button>
                <Button disabled>Disabled</Button>
              </div>
            </div>
            <div>
              <div className="text-xs text-[#A8A29E] mb-3 font-mono">Outline</div>
              <div className="flex flex-wrap gap-3">
                <Button variant="outline" size="sm">Small</Button>
                <Button variant="outline">Default</Button>
                <Button variant="outline" size="lg">Large</Button>
              </div>
            </div>
            <div>
              <div className="text-xs text-[#A8A29E] mb-3 font-mono">Ghost</div>
              <div className="flex flex-wrap gap-3">
                <Button variant="ghost" size="sm">Small</Button>
                <Button variant="ghost">Default</Button>
                <Button variant="ghost" size="lg">Large</Button>
              </div>
            </div>
          </Card>
        </section>

        {/* Radius & Spacing */}
        <section className="mb-16">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Border Radius</h2>
              <Card className="p-8 rounded-2xl border-[#E8E5E0]">
                <div className="grid grid-cols-2 gap-4">
                  {[{ n: "sm", v: "8px" }, { n: "md", v: "12px" }, { n: "lg", v: "16px" }, { n: "xl", v: "24px" }].map((r) => (
                    <div key={r.n}>
                      <div className="h-20 bg-gradient-to-br from-[#F97316] to-[#FB923C] mb-2" style={{ borderRadius: r.v }} />
                      <div className="font-bold text-[#1C1917] text-sm">radius-{r.n}</div>
                      <div className="text-xs text-[#A8A29E] font-mono">{r.v}</div>
                    </div>
                  ))}
                </div>
              </Card>
            </div>
            <div>
              <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Shadows</h2>
              <Card className="p-8 rounded-2xl border-[#E8E5E0] space-y-4">
                {["xs", "sm", "md", "lg", "xl"].map((s) => (
                  <div key={s} className={`p-4 bg-white rounded-xl shadow-${s} border border-[#E8E5E0]/50`}>
                    <span className="font-bold text-[#1C1917] text-sm">shadow-{s}</span>
                  </div>
                ))}
              </Card>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}

function PaletteSection({ name, desc, colors }: { name: string; desc: string; colors: { n: string; c: string }[] }) {
  return (
    <div className="mb-10">
      <h3 className="font-extrabold text-[#1C1917] mb-1">{name}</h3>
      <p className="text-sm text-[#78716C] mb-4">{desc}</p>
      <div className="grid grid-cols-5 md:grid-cols-10 lg:grid-cols-11 gap-2">
        {colors.map((color) => (
          <div key={color.n} className="group">
            <div className="aspect-square rounded-xl border border-[#E8E5E0]/50 mb-1 group-hover:scale-110 transition-transform cursor-pointer shadow-sm" style={{ backgroundColor: color.c }} />
            <div className="text-[10px] font-mono text-[#A8A29E] text-center">{color.n}</div>
          </div>
        ))}
      </div>
    </div>
  );
}
