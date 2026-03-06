module Player
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def show
      @upcoming = current_user.registrations
        .active
        .includes(camp: [poster_attachment: :blob])
        .joins(:camp)
        .where("camps.start_date >= ?", Date.current)
        .order("camps.start_date ASC")

      @suggested = Camp.published
        .upcoming
        .where(level: current_user.level)
        .where.not(id: current_user.registered_camps.select(:id))
        .limit(6)
        .includes(:registrations, poster_attachment: :blob)
    end
  end
end
