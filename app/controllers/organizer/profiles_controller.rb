module Organizer
  class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_organizer
    layout "organizer"

    def edit
    end

    def update
      if current_user.update(profile_params)
        redirect_to edit_organizer_profile_path, notice: t("organizer.profile.update.success")
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def ensure_organizer
      redirect_to root_path, alert: t("organizer.profile.forbidden") unless current_user.organizer?
    end

    def profile_params
      params.require(:user).permit(:slug, :coach_headline, :coach_bio, :coach_track_record, :avatar)
    end
  end
end
