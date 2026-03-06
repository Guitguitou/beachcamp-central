class Camp < ApplicationRecord
  belongs_to :organizer, class_name: "User", inverse_of: :organized_camps

  has_many :registrations, dependent: :destroy
  has_many :registered_users, through: :registrations, source: :user
  has_many :conversations, dependent: :destroy
  has_one_attached :poster

  enum :level, { beginner: 0, intermediate: 1, advanced: 2, pro: 3, international: 4 }
  enum :status, { draft: 0, published: 1, full: 2, cancelled: 3 }

  validates :title, :location, :country, :start_date, :end_date, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
  validates :min_participants, numericality: { greater_than: 0 }
  validates :max_participants, numericality: { greater_than: 0 }
  validate :end_date_after_start_date
  validate :max_gte_min

  scope :visible, -> { where(status: [:published, :full]) }
  scope :available, -> { where(status: :published) }
  scope :featured_first, -> { order(featured: :desc, start_date: :asc) }
  scope :upcoming, -> { where("start_date >= ?", Date.current) }
  scope :by_level, ->(lvl) { where(level: lvl) }
  scope :by_country, ->(c) { where(country: c) }
  scope :by_location, ->(loc) { where("location ILIKE ?", "%#{loc}%") }

  def spots_remaining
    max_participants - registrations.confirmed.count
  end

  def full?
    spots_remaining <= 0
  end

  def price_display
    "#{price_cents / 100}€"
  end

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, :after_start) if end_date <= start_date
  end

  def max_gte_min
    return if max_participants.blank? || min_participants.blank?
    errors.add(:max_participants, :gte_min) if max_participants < min_participants
  end
end
