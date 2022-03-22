class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :school
  has_many :bookings, dependent: :destroy
  has_many :courses, through: :bookings

  validates :email, :username, presence: true
  validates :email, uniqueness: true
  validates :username,
            uniqueness: {
        # object = person object being validated
        # data = { model: "Person", attribute: "Username", value: <username> }
        message: ->(object, data) do
          "#{data[:value]} is already taken."
        end
    }
end
