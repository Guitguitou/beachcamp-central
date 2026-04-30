class TrainersController < ApplicationController
  def show
    @coach = User.organizer.find_by!(slug: params[:slug].to_s.downcase)
    ids = @coach.coach_camp_ids
    @upcoming_camps = Camp.visible.upcoming.where(id: ids).distinct.order(:start_date)
    @past_camps = Camp.visible.where(id: ids).where("end_date < ?", Date.current).distinct.order(end_date: :desc).limit(8)
  end
end
