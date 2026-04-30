module Organizer
  class StaffMembershipsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_camp
    before_action :set_membership, only: [:destroy]
    layout "organizer"

    def create
      authorize @camp, :update?
      email = params.require(:email).to_s.strip.downcase
      member = User.organizer.find_by("LOWER(email) = ?", email)

      unless member
        redirect_to organizer_camp_path(@camp), alert: t("organizer.staff.not_found")
        return
      end

      if member.id == @camp.organizer_id
        redirect_to organizer_camp_path(@camp), alert: t("organizer.staff.already_lead")
        return
      end

      membership = @camp.camp_staff_memberships.build(user: member, position: next_position)
      if membership.save
        redirect_to organizer_camp_path(@camp), notice: t("organizer.staff.added")
      else
        redirect_to organizer_camp_path(@camp), alert: membership.errors.full_messages.to_sentence.presence || t("organizer.staff.error")
      end
    end

    def destroy
      authorize @camp, :update?
      @membership.destroy
      redirect_to organizer_camp_path(@camp), notice: t("organizer.staff.removed")
    end

    private

    def set_camp
      @camp = Camp.managed_by(current_user).find(params[:camp_id])
    end

    def set_membership
      @membership = @camp.camp_staff_memberships.find(params[:id])
    end

    def next_position
      (@camp.camp_staff_memberships.maximum(:position) || 0) + 1
    end
  end
end
