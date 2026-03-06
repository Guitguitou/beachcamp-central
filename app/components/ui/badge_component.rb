module Ui
  class BadgeComponent < ViewComponent::Base
    def initialize(color: "sunset", extra_class: "")
      @color = color
      @extra_class = extra_class
    end

    def call
      tag.span(content, class: css_classes, style: inline_style)
    end

    private

    def css_classes
      classes = ["ds-badge"]
      classes << @extra_class if @extra_class.present?
      classes.join(" ")
    end

    def inline_style
      bg, fg = case @color
               when "ocean"   then ["var(--ocean-500)",   "var(--neutral-0)"]
               when "sunset"  then ["var(--sunset-500)",  "var(--neutral-0)"]
               when "sand"    then ["var(--sand-500)",    "var(--neutral-0)"]
               when "success" then ["var(--success)",     "var(--neutral-0)"]
               when "warning" then ["var(--warning)",     "var(--neutral-0)"]
               when "danger"  then ["var(--danger)",      "var(--neutral-0)"]
               when "info"    then ["var(--info)",        "var(--neutral-0)"]
               when "neutral" then ["var(--neutral-200)", "var(--neutral-700)"]
               when "purple"  then ["#7C3AED",           "var(--neutral-0)"]
               else                ["var(--sunset-500)",  "var(--neutral-0)"]
               end
      "background-color: #{bg}; color: #{fg};"
    end
  end
end
