class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { player: 0, organizer: 1, admin: 2 }
  enum :level, { beginner: 0, intermediate: 1, advanced: 2, pro: 3, international: 4 }

  has_many :organized_camps, class_name: "Camp", foreign_key: :organizer_id, dependent: :destroy, inverse_of: :organizer
  has_many :registrations, dependent: :destroy
  has_many :registered_camps, through: :registrations, source: :camp
  has_many :messages, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :role, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
