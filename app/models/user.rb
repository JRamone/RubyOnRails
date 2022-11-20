class User < ApplicationRecord
  include RatingAverage

  validates :username, uniqueness: true
  validates :username, length: {minimum: 3,
                                maximum: 30
                               }


  has_many :ratings
end
