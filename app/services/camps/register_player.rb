module Camps
  class RegisterPlayer
    Result = Struct.new(:success?, :registration, :error, keyword_init: true)

    def initialize(camp:, user:)
      @camp = camp
      @user = user
    end

    def call
      return failure(I18n.t("services.camps.register_player.full"))              if @camp.full?
      return failure(I18n.t("services.camps.register_player.not_open"))           unless @camp.published?
      return failure(I18n.t("services.camps.register_player.already_registered")) if already_registered?

      registration = @camp.registrations.build(user: @user, status: :pending)

      if registration.save
        Result.new("success?": true, registration: registration, error: nil)
      else
        failure(registration.errors.full_messages.join(", "))
      end
    end

    private

    def already_registered?
      @camp.registrations.active.exists?(user: @user)
    end

    def failure(message)
      Result.new("success?": false, registration: nil, error: message)
    end
  end
end
