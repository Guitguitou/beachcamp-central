module Coach
  class DashboardController < BaseController
    def show
      @camps = current_user.coached_camps.order(start_date: :asc)
      @pending_count = Registration.joins(:camp).where(camps: { coach_id: current_user.id }, status: :pending).count
      @confirmed_count = Registration.joins(:camp).where(camps: { coach_id: current_user.id }, status: :confirmed).count
    end
  end
end
