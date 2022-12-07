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

    res = ActiveRecord::Base.connection.exec_query('SELECT beers.style, AVG(score) as avg_rating FROM ratings INNER JOIN beers ON beers.id = beer_id GROUP BY beers.style ORDER BY avg_rating DESC LIMIT 1')
    res.to_a.first['style']
  end

  def favorite_brewery
    return nil if breweries.empty?

    res = ActiveRecord::Base.connection.exec_query('SELECT breweries.name, AVG(score) as avg_rating FROM ratings INNER JOIN beers ON beers.id = beer_id INNER JOIN breweries ON breweries.id = beers.brewery_id GROUP BY breweries.name ORDER BY avg_rating DESC LIMIT 1')
    res.to_a.first['name']
  end
end
