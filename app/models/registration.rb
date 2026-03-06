class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :camp

  enum :status, { pending: 0, confirmed: 1, cancelled: 2 }

  validates :user_id, uniqueness: { scope: :camp_id }
  validate :camp_must_be_published, on: :create
  validate :camp_not_full, on: :create

  after_create :check_camp_full

  scope :active, -> { where(status: [:pending, :confirmed]) }

  private

  def camp_must_be_published
    return if camp&.published?
    errors.add(:camp, :must_be_published)
  end

  def camp_not_full
    return unless camp
    return if camp.spots_remaining > 0
    errors.add(:camp, :is_full)
  end

  def check_camp_full
    camp.full! if camp.spots_remaining <= 0
  end
end
