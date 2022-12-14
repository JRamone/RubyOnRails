class Brewery < ApplicationRecord
  include RatingAverage

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true
  validate :year_cannot_be_in_the_future
  validates :year, numericality: { greater_than_or_equal_to: 1040, only_integer: true }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def self.best_rated(num)
    Brewery.all.sort_by(&:average).reverse.first num
  end

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def year_cannot_be_in_the_future
    return unless year > Date.today.year

    errors.add(:year, "can't be in the future")
    false
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def to_s
    name
  end

  def restart
    self.year = 2022
    puts "changed year to #{year}"
  end
end
