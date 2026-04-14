module Coach
  class CampsController < BaseController
    before_action :set_camp, only: [:show]

    def index
      @camps = current_user.coached_camps.order(start_date: :asc)
    end

    def show
      @pending_registrations = @camp.registrations.pending.includes(:user).order(created_at: :asc)
      @confirmed_registrations = @camp.registrations.confirmed.includes(:user).order(created_at: :asc)
    end

    private

    def set_camp
      @camp = current_user.coached_camps.find(params[:id])
    end
  end
end
