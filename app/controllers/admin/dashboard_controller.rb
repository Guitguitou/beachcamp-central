module Admin
  class DashboardController < BaseController
    def show
      @total_users      = User.count
      @players_count    = User.count
      @coaches_count    = User.coaches.count
      @organizers_count = User.organizers.count
      @total_camps      = Camp.count
      @published_camps  = Camp.where(status: :published).count
      @draft_camps      = Camp.where(status: :draft).count
      @cancelled_camps  = Camp.where(status: :cancelled).count
      @total_registrations   = Registration.count
      @pending_registrations = Registration.where(status: :pending).count
      @confirmed_registrations = Registration.where(status: :confirmed).count
      @recent_camps     = Camp.includes(:organizer).order(created_at: :desc).limit(5)
      @recent_users     = User.order(created_at: :desc).limit(5)
    end
  end
end
