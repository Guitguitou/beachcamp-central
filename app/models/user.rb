class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :level, { beginner: 0, intermediate: 1, advanced: 2, pro: 3, international: 4 }

  has_one_attached :avatar
  has_many :organized_camps, class_name: "Camp", foreign_key: :organizer_id, dependent: :destroy, inverse_of: :organizer
  has_many :coached_camps, class_name: "Camp", foreign_key: :coach_id, dependent: :nullify, inverse_of: :coach
  has_many :registrations, dependent: :destroy
  has_many :registered_camps, through: :registrations, source: :camp
  has_many :messages, dependent: :destroy

  # Everyone is always a player — no column needed
  def player? = true

  scope :coaches,     -> { where(coach: true) }
  scope :organizers,  -> { where(organizer: true) }
  scope :admins,      -> { where(admin: true) }

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
