module Beachcamp
  class LevelBadgeComponent < ViewComponent::Base
    LEVELS = %w[beginner intermediate advanced pro international].freeze

    def initialize(level:)
      @level = level.to_s.downcase
    end

    def call
      tag.span(label, class: css_classes)
    end

    private

    def label
      key = LEVELS.include?(@level) ? @level : "beginner"
      I18n.t("components.level_badge.#{key}")
    end

    def css_classes
      base = "ds-level-badge"
      modifier = LEVELS.include?(@level) ? @level : "beginner"
      "#{base} ds-level-badge--#{modifier}"
    end
  end
end
