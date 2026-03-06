module Ui
  class CardComponent < ViewComponent::Base
    def initialize(hoverable: false, padding: "p-6", extra_class: "")
      @hoverable = hoverable
      @padding = padding
      @extra_class = extra_class
    end

    def call
      tag.div(content, class: css_classes)
    end

    private

    def css_classes
      classes = ["ds-card", @padding]
      classes << "ds-card--hoverable" if @hoverable
      classes << @extra_class if @extra_class.present?
      classes.join(" ")
    end
  end
end
