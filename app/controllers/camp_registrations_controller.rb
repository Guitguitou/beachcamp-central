class CampRegistrationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @camp = Camp.find(params[:camp_id])
    result = Camps::RegisterPlayer.new(camp: @camp, user: current_user).call

    if result.success?
      redirect_to camp_path(@camp), notice: t("camp_registrations.create.success")
    else
      redirect_to camp_path(@camp), alert: result.error
    end
  end

  def destroy
    @camp = Camp.find(params[:camp_id])
    @registration = current_user.registrations.find(params[:id])
    authorize @registration
    @registration.cancelled!
    redirect_to @camp, notice: t("camp_registrations.destroy.success")
  end
end
