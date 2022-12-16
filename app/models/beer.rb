class Beer < ApplicationRecord
  include RatingAverage

  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user
  belongs_to :style
  belongs_to :brewery, touch: true

  validates :name, presence: true

  def self.best_rated(num)
    Beer.all.sort_by(&:average).reverse.first num
  end

  def average
    rating_count = ratings.size
    return 0 if rating_count == 0

    ratings.map(&:score).sum / rating_count
  end

  def to_s
    "#{name} by #{brewery.name}"
  end
end
