class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: {minimum: 3,
                                maximum: 30
                               }
  validates :password, length: {minimum: 4} 
  validates :password, format: {with: /[A-Z]/, message: "must contain atleast one capital letter."}
  validates :password, format: {with: /[0-9]/, message: "must contain atleast one number."}

  has_many :memberships
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
end
