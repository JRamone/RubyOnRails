class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { minimum: 3,
                                 maximum: 30 }
  validates :password, length: { minimum: 4 }
  validates :password, format: { with: /[A-Z]/, message: "must contain atleast one capital letter." }
  validates :password, format: { with: /[0-9]/, message: "must contain atleast one number." }

  has_many :memberships, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
  has_many :breweries, through: :beers

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if beers.empty?

    beers.group(:style).order('avg(score) desc').first.style
  end

  def favorite_brewery
    return nil if breweries.empty?

    breweries.group(:name).order('avg(score) desc').first.name
  end
end
