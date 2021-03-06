class School < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user

  has_many :courses, dependent: :destroy
  has_one_attached :photo
  has_one_attached :logo

  validates :name, :address, presence: true
end
