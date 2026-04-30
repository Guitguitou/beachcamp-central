module Admin
  class CampRegistrationsController < BaseController
    before_action :set_camp
    before_action :set_registration, only: [:update]

    def index
      @registrations = @camp.registrations.includes(:user).order(created_at: :desc)
    end

    def update
      new_status = params[:registration][:status]
      if Registration.statuses.key?(new_status)
        @registration.update!(status: new_status)
        redirect_to admin_camp_registrations_path(@camp), notice: "Inscription mise à jour."
      else
        redirect_to admin_camp_registrations_path(@camp), alert: "Statut invalide."
      end
    end

    private

    def set_camp
      @camp = Camp.find(params[:camp_id])
    end

    def set_registration
      @registration = @camp.registrations.find(params[:id])
    end
  end
end
