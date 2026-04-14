module Coach
  class CampRegistrationsController < BaseController
    before_action :set_camp
    before_action :set_registration, only: [:update]

    def index
      @pending_registrations = @camp.registrations.pending.includes(:user).order(created_at: :asc)
      @confirmed_registrations = @camp.registrations.confirmed.includes(:user).order(created_at: :asc)
    end

    def update
      new_status = params[:registration][:status]
      unless %w[confirmed cancelled].include?(new_status)
        return redirect_to coach_camp_registrations_path(@camp), alert: t("coach.registrations.invalid_status", default: "Statut invalide.")
      end

      @registration.update!(status: new_status)

      # Si confirmation → vérifier si le camp est maintenant complet
      @camp.full! if new_status == "confirmed" && @camp.spots_remaining <= 0

      redirect_to coach_camp_registrations_path(@camp),
        notice: t("coach.registrations.update.success", default: "Inscription mise à jour.")
    rescue ActiveRecord::RecordInvalid => e
      redirect_to coach_camp_registrations_path(@camp), alert: e.message
    end

    private

    def set_camp
      @camp = current_user.coached_camps.find(params[:camp_id])
    end

    def set_registration
      @registration = @camp.registrations.find(params[:id])
    end
  end
end
