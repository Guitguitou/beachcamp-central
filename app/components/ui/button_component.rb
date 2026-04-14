module Ui
  class ButtonComponent < ViewComponent::Base
    VARIANTS = %w[primary outline ghost danger].freeze
    SIZES = %w[sm md lg].freeze

    def initialize(
      variant: "primary",
      size: "md",
      disabled: false,
      tag: :button,
      href: nil,
      method: nil,
      extra_class: "",
      **html_attrs
    )
      @variant = VARIANTS.include?(variant) ? variant : "primary"
      @size = SIZES.include?(size) ? size : "md"
      @disabled = disabled
      @tag_name = href.present? ? :a : tag
      @href = href
      @method = method
      @extra_class = extra_class
      @html_attrs = html_attrs
    end

    def call
      attrs = @html_attrs.merge(class: css_classes)
      attrs[:disabled] = true if @disabled && @tag_name == :button
      attrs[:href] = @href if @href
      attrs[:data] = (@html_attrs[:data] || {}).merge(turbo_method: @method) if @method

      tag.public_send(@tag_name, content, **attrs)
    end

    private

    def css_classes
      classes = ["ds-btn", "ds-btn--#{@variant}", "ds-btn--#{@size}"]
      classes << "ds-btn--disabled" if @disabled
      classes << @extra_class if @extra_class.present?
      classes.join(" ")
    end
  end
end
