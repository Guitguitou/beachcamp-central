import { ArrowRight, Palette, FileText, Layout, Users, Calendar, LogIn, Briefcase, Award, Sparkles } from "lucide-react";
import { useNavigate } from "react-router";
import { Card } from "../components/ui/card";
import { Badge } from "../components/ui/badge";

export function DesignSystemIndex() {
  const navigate = useNavigate();

  return (
    <div>
      {/* Hero */}
      <section className="py-20 bg-gradient-to-br from-[#1C1917] via-[#292524] to-[#44403C] text-white relative overflow-hidden">
        <div className="absolute top-10 right-10 w-96 h-96 bg-[#F97316]/15 rounded-full blur-3xl" />
        <div className="absolute bottom-10 left-10 w-72 h-72 bg-[#06B6D4]/10 rounded-full blur-3xl" />
        <div className="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <div className="inline-flex items-center gap-2 bg-white/10 backdrop-blur-sm border border-white/10 rounded-full px-4 py-2 mb-6">
            <Sparkles className="h-4 w-4 text-[#FACC15]" />
            <span className="text-sm text-white/80 font-medium">Design System v1.0</span>
          </div>
          <h1 className="text-5xl md:text-6xl font-extrabold mb-4 tracking-tight">
            BeachCamp
            <br />
            <span className="bg-gradient-to-r from-[#F97316] via-[#FB923C] to-[#FACC15] bg-clip-text text-transparent">Design System</span>
          </h1>
          <p className="text-lg text-white/50 max-w-2xl mx-auto">
            Tokens, components, pages & guidelines for the coolest beach volleyball platform on the planet.
          </p>
          
          <div className="flex gap-6 justify-center mt-10">
            {[{ n: "3", l: "Color Palettes" }, { n: "12+", l: "Components" }, { n: "8", l: "Pages" }].map((s, i) => (
              <div key={i} className="bg-white/10 backdrop-blur-sm rounded-2xl px-6 py-4 border border-white/10">
                <div className="text-2xl font-extrabold text-white">{s.n}</div>
                <div className="text-xs text-white/50">{s.l}</div>
              </div>
            ))}
          </div>
        </div>
      </section>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        {/* Foundation */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6 tracking-tight">Foundation</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <PageCard icon={<Palette className="h-6 w-6" />} title="Design Tokens" description="Colors, typography, spacing, shadows" badge="Core" badgeColor="bg-[#06B6D4]" onClick={() => navigate('/design-tokens')} />
            <PageCard icon={<FileText className="h-6 w-6" />} title="Style Guide" description="Brand guidelines, do's and don'ts" badge="Guidelines" badgeColor="bg-[#F97316]" onClick={() => navigate('/style-guide')} />
          </div>
        </section>

        {/* Public */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6 tracking-tight">Public Pages</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <PageCard icon={<Layout className="h-6 w-6" />} title="Homepage" description="Hero, search, featured & all camps" badge="Public" badgeColor="bg-[#10B981]" onClick={() => navigate('/')} />
            <PageCard icon={<Calendar className="h-6 w-6" />} title="Camp Details" description="Full camp page with booking" badge="Public" badgeColor="bg-[#10B981]" onClick={() => navigate('/camp/1')} />
            <PageCard icon={<Briefcase className="h-6 w-6" />} title="Organizer Landing" description="Marketing page for organizers" badge="Public" badgeColor="bg-[#10B981]" onClick={() => navigate('/organizer-landing')} />
            <PageCard icon={<LogIn className="h-6 w-6" />} title="Login" description="Auth with social login" badge="Auth" badgeColor="bg-[#7C3AED]" onClick={() => navigate('/login')} />
            <PageCard icon={<Users className="h-6 w-6" />} title="Sign Up" description="Registration flow" badge="Auth" badgeColor="bg-[#7C3AED]" onClick={() => navigate('/signup')} />
          </div>
        </section>

        {/* Organizer */}
        <section className="mb-16">
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6 tracking-tight">Organizer</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <PageCard icon={<Award className="h-6 w-6" />} title="Dashboard" description="Stats, camp list, revenue" badge="Organizer" badgeColor="bg-[#EAB308]" onClick={() => navigate('/dashboard')} />
            <PageCard icon={<Calendar className="h-6 w-6" />} title="Create Camp" description="Multi-step wizard" badge="Organizer" badgeColor="bg-[#EAB308]" onClick={() => navigate('/create-camp')} />
          </div>
        </section>

        {/* Components */}
        <section>
          <h2 className="text-2xl font-extrabold text-[#1C1917] mb-6 tracking-tight">Components</h2>
          <Card className="p-6 rounded-2xl border-[#E8E5E0]">
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-3">
              {["LevelBadge", "CampCard", "SpotsIndicator", "OrganizerCard", "SearchHeader", "FilterBar", "Navbar", "Footer"].map((name) => (
                <div key={name} className="flex items-center gap-2 p-3 rounded-xl hover:bg-[#F5F3F0] transition-colors">
                  <div className="w-2 h-2 bg-gradient-to-r from-[#F97316] to-[#06B6D4] rounded-full" />
                  <span className="font-medium text-[#1C1917] text-sm">{name}</span>
                </div>
              ))}
            </div>
          </Card>
        </section>
      </div>
    </div>
  );
}

function PageCard({ icon, title, description, badge, badgeColor, onClick }: { icon: React.ReactNode; title: string; description: string; badge: string; badgeColor: string; onClick?: () => void }) {
  return (
    <Card className="p-5 rounded-2xl border-[#E8E5E0] hover:shadow-lg hover:border-[#D4D0C8] transition-all cursor-pointer group" onClick={onClick}>
      <div className="flex items-start justify-between mb-4">
        <div className="w-11 h-11 bg-[#F5F3F0] rounded-xl flex items-center justify-center text-[#F97316] group-hover:bg-gradient-to-br group-hover:from-[#F97316] group-hover:to-[#FB923C] group-hover:text-white transition-all">
          {icon}
        </div>
        <Badge className={`${badgeColor} text-white text-[10px] font-bold rounded-lg`}>{badge}</Badge>
      </div>
      <h3 className="font-bold text-[#1C1917] mb-1 group-hover:text-[#F97316] transition-colors">{title}</h3>
      <p className="text-sm text-[#78716C] mb-3">{description}</p>
      <div className="flex items-center gap-1.5 text-[#F97316] font-medium text-sm group-hover:gap-2.5 transition-all">
        View <ArrowRight className="h-3.5 w-3.5" />
      </div>
    </Card>
  );
}
