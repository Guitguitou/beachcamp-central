module Player
  class RegistrationsController < ApplicationController
    before_action :authenticate_user!

    def index
      @registrations = current_user.registrations
        .includes(camp: [poster_attachment: :blob])
        .order(created_at: :desc)
    end

    def destroy
      @registration = current_user.registrations.find(params[:id])
      authorize @registration
      @registration.cancelled!
      redirect_to player_registrations_path, notice: t("player.registrations.destroy.success")
    end
  end
end
