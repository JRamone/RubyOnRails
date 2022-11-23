class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: {minimum: 3,
                                maximum: 30
                               }

  has_many :memberships
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
end
