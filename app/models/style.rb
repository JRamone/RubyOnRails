class Style < ApplicationRecord
  has_many :beers
  has_many :ratings, through: :beers

  validates :name, presence: true

  def self.best_rated(num)
    Style.all.sort_by(&:average).reverse.first num
  end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    name.to_s
  end
end
