module Organizer
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    layout "organizer"

    def show
      @camps = current_user.organized_camps.order(created_at: :desc)
      @total_camps = @camps.count
      @published_camps = @camps.where(status: :published).count
      @total_registrations = Registration.joins(:camp).where(camps: { organizer_id: current_user.id }).active.count
      @total_revenue = Registration.joins(:camp)
        .where(camps: { organizer_id: current_user.id })
        .where(status: :confirmed)
        .sum("camps.price_cents")
    end
  end
end
