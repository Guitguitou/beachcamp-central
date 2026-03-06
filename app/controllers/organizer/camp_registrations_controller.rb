module Organizer
  class CampRegistrationsController < ApplicationController
    before_action :authenticate_user!
    layout "organizer"

    def index
      @camp = current_user.organized_camps.find(params[:camp_id])
      authorize @camp, :manage_registrations?
      @registrations = @camp.registrations.includes(:user).order(created_at: :desc)
    end

    def update
      @camp = current_user.organized_camps.find(params[:camp_id])
      authorize @camp, :manage_registrations?
      @registration = @camp.registrations.find(params[:id])

      if @registration.update(status: params[:registration][:status])
        redirect_to organizer_camp_registrations_path(@camp), notice: t("organizer.camp_registrations.update.success")
      else
        redirect_to organizer_camp_registrations_path(@camp), alert: t("organizer.camp_registrations.update.failure")
      end
    end
  end
end
