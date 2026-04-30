class CampStaffMembership < ApplicationRecord
  belongs_to :camp
  belongs_to :user

  validates :user_id, uniqueness: { scope: :camp_id }

  validate :user_must_not_be_organizer
  validate :user_must_be_organizer_role

  private

  def user_must_not_be_organizer
    return if camp.blank? || user_id.blank?

    errors.add(:user_id, :same_as_organizer) if user_id == camp.organizer_id
  end

  def user_must_be_organizer_role
    return if user.blank?

    errors.add(:user, :must_be_coach) unless user.organizer?
  end
end
