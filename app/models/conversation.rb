class Conversation < ApplicationRecord
  belongs_to :camp

  has_many :messages, dependent: :destroy

  def participants
    User.where(id: camp.organizer_id)
        .or(User.where(id: camp.registrations.active.select(:user_id)))
  end
end
