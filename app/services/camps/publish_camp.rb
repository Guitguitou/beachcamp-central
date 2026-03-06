module Camps
  class PublishCamp
    Result = Struct.new(:success?, :camp, :error, keyword_init: true)

    def initialize(camp:)
      @camp = camp
    end

    def call
      return failure(I18n.t("services.camps.publish_camp.not_draft"))    unless @camp.draft?
      return failure(I18n.t("services.camps.publish_camp.needs_title"))  if @camp.title.blank?
      return failure(I18n.t("services.camps.publish_camp.needs_dates"))  if @camp.start_date.blank? || @camp.end_date.blank?

      @camp.published!
      Result.new("success?": true, camp: @camp, error: nil)
    rescue ActiveRecord::RecordInvalid => e
      failure(e.message)
    end

    private

    def failure(message)
      Result.new("success?": false, camp: @camp, error: message)
    end
  end
end
