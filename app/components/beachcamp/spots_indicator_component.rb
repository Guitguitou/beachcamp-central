module Beachcamp
  class SpotsIndicatorComponent < ViewComponent::Base
    def initialize(camp:)
      @camp = camp
    end

    def call
      remaining = @camp.max_participants - @camp.registrations.confirmed.count
      status = if remaining <= 0
                 "full"
               elsif remaining <= 3
                 "limited"
               else
                 "available"
               end
      label = if status == "full"
                I18n.t("components.spots.full")
              else
                I18n.t("components.spots.spots_left", count: remaining)
              end

      tag.div(class: "ds-spots ds-spots--#{status}") do
        tag.span("", class: "ds-spots__dot") + tag.span(label)
      end
    end
  end
end
