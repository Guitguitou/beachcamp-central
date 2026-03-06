class RegistrationPolicy < ApplicationPolicy
  def create?
    user&.player? && record.camp.published?
  end

  def destroy?
    record.user_id == user&.id && !record.cancelled?
  end

  def update?
    record.camp.organizer_id == user&.id || user&.admin?
  end
end
