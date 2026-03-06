import { Check, X } from "lucide-react";
import { Card } from "../components/ui/card";
import { Button } from "../components/ui/button";

export function StyleGuide() {
  return (
    <div className="py-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="mb-12">
          <h1 className="text-4xl font-extrabold text-[#1C1917] mb-2 tracking-tight">Style Guide</h1>
          <p className="text-lg text-[#78716C]">Rules to keep BeachCamp looking cool, consistent, and trustworthy</p>
        </div>

        {/* Brand */}
        <GuideSection title="Brand Colors">
          <DoCard>
            <p className="text-[#57534E] mb-4">Use warm sunset oranges as primary CTA color, ocean teal as secondary. The combo says "beach + trust".</p>
            <div className="flex gap-2">
              <div className="w-14 h-14 bg-gradient-to-br from-[#F97316] to-[#FB923C] rounded-xl" />
              <div className="w-14 h-14 bg-gradient-to-br from-[#06B6D4] to-[#22D3EE] rounded-xl" />
              <div className="w-14 h-14 bg-[#FAFAF8] rounded-xl border border-[#E8E5E0]" />
            </div>
          </DoCard>
          <DontCard>
            <p className="text-[#57534E] mb-4">No neon, no rainbow gradients, no party aesthetics. We're premium accessible, not a rave.</p>
            <div className="flex gap-2">
              <div className="w-14 h-14 bg-[#FF00FF] rounded-xl" />
              <div className="w-14 h-14 bg-[#00FF00] rounded-xl" />
              <div className="w-14 h-14 bg-gradient-to-r from-red-500 via-yellow-500 to-green-500 rounded-xl" />
            </div>
          </DontCard>
        </GuideSection>

        {/* Typography */}
        <GuideSection title="Typography">
          <DoCard>
            <p className="text-[#57534E] mb-4">Bold headings, clear hierarchy, generous spacing. Extrabold for impact, medium for body.</p>
            <div className="space-y-2 mt-4">
              <h2 className="text-2xl font-extrabold text-[#1C1917]">Camp Title Here</h2>
              <p className="text-[#78716C]">Clean body text with great contrast</p>
              <Button className="bg-gradient-to-r from-[#F97316] to-[#FB923C] text-white rounded-xl">Join Camp</Button>
            </div>
          </DoCard>
          <DontCard>
            <p className="text-[#57534E] mb-4">No all-caps paragraphs, no tiny CTA buttons, no low-contrast text.</p>
            <div className="space-y-1 mt-4">
              <h2 className="text-xs uppercase tracking-widest">CAMP TITLE IN ALL CAPS</h2>
              <p className="text-[#D4D0C8] text-xs">Barely visible text</p>
              <Button size="sm" variant="ghost" className="text-[10px]">tiny cta</Button>
            </div>
          </DontCard>
        </GuideSection>

        {/* Imagery */}
        <GuideSection title="Photography">
          <DoCard>
            <p className="text-[#57534E] mb-4">Authentic beach volleyball: action shots, golden hour, real training moments. Natural and energetic.</p>
            <ul className="space-y-2 text-sm text-[#57534E]">
              {["High-quality action shots", "Natural beach settings", "Authentic training", "Golden hour vibes"].map((item, i) => (
                <li key={i} className="flex items-center gap-2"><Check className="h-4 w-4 text-[#10B981]" />{item}</li>
              ))}
            </ul>
          </DoCard>
          <DontCard>
            <p className="text-[#57534E] mb-4">No staged corporate stock, no party/drinking, no over-edited filters.</p>
            <ul className="space-y-2 text-sm text-[#57534E]">
              {["Generic stock photos", "Party scenes", "Over-filtered images", "Unrelated content"].map((item, i) => (
                <li key={i} className="flex items-center gap-2"><X className="h-4 w-4 text-[#EF4444]" />{item}</li>
              ))}
            </ul>
          </DontCard>
        </GuideSection>

        {/* Voice */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Voice & Tone</h2>
          <Card className="p-8 rounded-2xl border-[#E8E5E0]">
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
              {[
                { title: "Cool", desc: "We're the friend who's both chill and knows their stuff." },
                { title: "Confident", desc: "Direct, clear language. No fluff, no corporate speak." },
                { title: "Inspiring", desc: "Make people want to book a camp RIGHT NOW." }
              ].map((v, i) => (
                <div key={i}>
                  <div className="text-[#F97316] font-bold mb-1">{v.title}</div>
                  <p className="text-sm text-[#78716C]">{v.desc}</p>
                </div>
              ))}
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="border-l-4 border-[#10B981] pl-4 py-2">
                <div className="text-xs font-bold text-[#10B981] mb-1">GOOD</div>
                <p className="text-[#57534E] italic">"Train on sand, level up fast. Find your next beach volleyball camp."</p>
              </div>
              <div className="border-l-4 border-[#EF4444] pl-4 py-2">
                <div className="text-xs font-bold text-[#EF4444] mb-1">BAD</div>
                <p className="text-[#57534E] italic line-through">"Yo come party at the beach and maybe play some volleyball lol"</p>
              </div>
            </div>
          </Card>
        </section>

        {/* Accessibility */}
        <section>
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">Accessibility</h2>
          <Card className="p-8 rounded-2xl border-[#E8E5E0]">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {[
                "Color contrast: min 4.5:1 for text",
                "Visible focus states on all interactives",
                "Alt text on all images",
                "Responsive: mobile-first always",
                "Semantic HTML (headings, nav, main)",
                "Touch targets: min 44x44px",
                "Clear form validation & errors",
                "Keyboard navigation support"
              ].map((item, i) => (
                <div key={i} className="flex items-start gap-2">
                  <Check className="h-5 w-5 text-[#10B981] flex-shrink-0 mt-0.5" />
                  <span className="text-[#57534E] text-sm">{item}</span>
                </div>
              ))}
            </div>
          </Card>
        </section>
      </div>
    </div>
  );
}

function GuideSection({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="mb-16">
      <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6">{title}</h2>
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">{children}</div>
    </section>
  );
}

function DoCard({ children }: { children: React.ReactNode }) {
  return (
    <Card className="p-6 rounded-2xl border-2 border-[#10B981]/30">
      <div className="flex items-center gap-2 mb-4">
        <div className="w-7 h-7 bg-[#10B981] rounded-full flex items-center justify-center"><Check className="h-4 w-4 text-white" /></div>
        <span className="font-bold text-[#10B981]">DO</span>
      </div>
      {children}
    </Card>
  );
}

function DontCard({ children }: { children: React.ReactNode }) {
  return (
    <Card className="p-6 rounded-2xl border-2 border-[#EF4444]/30">
      <div className="flex items-center gap-2 mb-4">
        <div className="w-7 h-7 bg-[#EF4444] rounded-full flex items-center justify-center"><X className="h-4 w-4 text-white" /></div>
        <span className="font-bold text-[#EF4444]">DON'T</span>
      </div>
      {children}
    </Card>
  );
}
