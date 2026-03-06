class ConversationPolicy < ApplicationPolicy
  def show?
    participant?
  end

  def create_message?
    participant?
  end

  private

  def participant?
    return false unless user
    record.camp.organizer_id == user.id ||
      record.camp.registrations.active.exists?(user_id: user.id)
  end
end
