class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :course

  before_save :set_total_price

  validates :begin_date, :end_date, presence: true

  def set_total_price
    self.total_price = ((end_date - begin_date).to_i + 1) * course.daily_price
  end
end
