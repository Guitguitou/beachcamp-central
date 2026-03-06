class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true

  scope :ordered, -> { order(created_at: :asc) }
end
