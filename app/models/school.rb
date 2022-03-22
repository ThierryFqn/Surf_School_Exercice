class School < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy

  validates :name, :address, presence: true
end
