module Camps
  class CancelCamp
    Result = Struct.new(:success?, :camp, :error, keyword_init: true)

    def initialize(camp:)
      @camp = camp
    end

    def call
      return failure(I18n.t("services.camps.cancel_camp.already_cancelled")) if @camp.cancelled?

      @camp.cancelled!
      @camp.registrations.active.find_each { |r| r.cancelled! }
      Result.new("success?": true, camp: @camp, error: nil)
    end

    private

    def failure(message)
      Result.new("success?": false, camp: @camp, error: message)
    end
  end
end
