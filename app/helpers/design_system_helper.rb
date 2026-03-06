module DesignSystemHelper
  def ds_page_card(title:, description:, badge:, badge_color:, path:, icon:)
    render Ui::CardComponent.new(hoverable: true, padding: "p-5", extra_class: "ds-page-card") do
      link_to path, style: "text-decoration:none; color:inherit; display:block;" do
        safe_join([
          tag.div(style: "display:flex; align-items:flex-start; justify-content:space-between; margin-bottom:var(--space-4);") {
            safe_join([
              tag.div(icon, class: "ds-page-card__icon"),
              render(Ui::BadgeComponent.new(color: badge_color)) { badge }
            ])
          },
          tag.h3(title, class: "ds-page-card__title", style: "margin-bottom:var(--space-1);"),
          tag.p(description, style: "font-size:var(--fs-sm); color:var(--neutral-500); margin-bottom:var(--space-3);"),
          tag.div(class: "ds-page-card__arrow") {
            safe_join([content_tag(:span, "View"), content_tag(:span, " →")])
          }
        ])
      end
    end
  end

  def ds_palette_section(name:, desc:, colors:)
    tag.div(class: "mb-8") do
      safe_join([
        tag.h3(name, style: "font-weight:var(--fw-extrabold); color:var(--neutral-900); margin-bottom:var(--space-1);"),
        tag.p(desc, style: "font-size:var(--fs-sm); color:var(--neutral-500); margin-bottom:var(--space-4);"),
        tag.div(class: "grid gap-2", style: "grid-template-columns: repeat(auto-fill, minmax(60px, 1fr));") {
          safe_join(colors.map { |c|
            tag.div do
              safe_join([
                tag.div("", style: "aspect-ratio:1; border-radius:var(--radius-md); border:1px solid rgba(232,229,224,0.5); background-color:#{c[:c]}; box-shadow:var(--shadow-sm); margin-bottom:var(--space-1);"),
                tag.div(c[:n], style: "font-size:10px; font-family:var(--font-mono); color:var(--neutral-400); text-align:center;")
              ])
            end
          })
        }
      ])
    end
  end
end
