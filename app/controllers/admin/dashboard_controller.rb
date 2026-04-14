module Admin
  class DashboardController < BaseController
    def show
      @total_users = User.count
      @players_count = User.count
      @coaches_count = User.coaches.count
      @organizers_count = User.organizers.count
      @total_camps = Camp.count
      @published_camps = Camp.where(status: :published).count
    end
  end
end
