class Course < ApplicationRecord
  belongs_to :school
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many_attached :photos

  SPORT_TYPES = %w[Kitesurf Surf Bodyboard Kitefoil Paddle]

  validates :sport, :description, presence: true
  validates :daily_price, numericality: { only_integer: true, greater_than: 0 }
  validates :sport, inclusion: { in: SPORT_TYPES, message: "Choissisez un sport parmi la liste" }
end
