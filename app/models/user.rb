class User < ApplicationRecord
  
  include RatingAverage

  has_secure_password
  
  has_one_attached :avatar

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

  def self.most_active(num)
    User.all.sort_by{ |u| u.ratings.count }.reverse.first num
  end

  def favorite(groupped_by)
    return nil if ratings.empty?

    grouped_ratings = ratings.group_by{ |r| r.beer.send(groupped_by) }
    averages = grouped_ratings.map do |group, ratings|
      { group:, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:group]
  end

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    favorite(:style)
  end

  def favorite_brewery
    favorite(:brewery)
  end

  def average_of(ratings)
    ratings.sum(&:score).to_f / ratings.count
  end
end
