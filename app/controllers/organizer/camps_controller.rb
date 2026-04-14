module Organizer
  class CampsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_camp, only: [:show, :edit, :update, :destroy, :publish, :cancel]
    layout "organizer"

    def index
      @camps = current_user.organized_camps.order(created_at: :desc)
    end

    def show; end

    def new
      @camp = current_user.organized_camps.build
      @step = (params[:step] || 1).to_i
    end

    def create
      @camp = current_user.organized_camps.build(camp_params)
      @camp.status = :draft

      if @camp.save
        redirect_to organizer_camp_path(@camp), notice: t("organizer.camps.create.success")
      else
        @step = 1
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @step = (params[:step] || 1).to_i
    end

    def update
      authorize @camp
      if @camp.update(camp_params)
        redirect_to organizer_camp_path(@camp), notice: t("organizer.camps.update.success")
      else
        @step = (params[:step] || 1).to_i
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @camp
      @camp.destroy
      redirect_to organizer_camps_path, notice: t("organizer.camps.destroy.success")
    end

    def publish
      authorize @camp
      result = Camps::PublishCamp.new(camp: @camp).call
      if result.success?
        redirect_to organizer_camp_path(@camp), notice: t("organizer.camps.publish.success")
      else
        redirect_to organizer_camp_path(@camp), alert: result.error
      end
    end

    def cancel
      authorize @camp
      result = Camps::CancelCamp.new(camp: @camp).call
      if result.success?
        redirect_to organizer_camp_path(@camp), notice: t("organizer.camps.cancel.success")
      else
        redirect_to organizer_camp_path(@camp), alert: result.error
      end
    end

    private

    def set_camp
      @camp = current_user.organized_camps.find(params[:id])
    end

    def camp_params
      params.require(:camp).permit(
        :title, :description, :location, :country,
        :start_date, :end_date, :level,
        :price_cents, :currency,
        :min_participants, :max_participants,
        :featured, :poster, :coach_id
      )
    end
  end
end
