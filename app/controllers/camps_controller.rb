class CampsController < ApplicationController
  def index
    @camps = Camp.visible.upcoming.featured_first.includes(:registrations, poster_attachment: :blob)
    @camps = @camps.by_level(params[:level])           if params[:level].present?
    @camps = @camps.by_country(params[:country])       if params[:country].present?
    @camps = @camps.by_location(params[:location])     if params[:location].present?
    @camps = @camps.available                          if params[:available] == "1"
    @camps = @camps.where(featured: true)              if params[:featured] == "1"

    if params[:date_from].present?
      @camps = @camps.where("start_date >= ?", Date.parse(params[:date_from]))
    end
    if params[:date_to].present?
      @camps = @camps.where("end_date <= ?", Date.parse(params[:date_to]))
    end

    @countries = Camp.visible.distinct.pluck(:country).sort
  end

  def show
    @camp = Camp.find(params[:id])
    @registration = Registration.new
  end
end
