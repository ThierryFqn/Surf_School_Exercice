class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :begin_date, :end_date, :total_price, presence: true
end
