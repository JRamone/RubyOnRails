class Beer < ApplicationRecord
  include RatingAverage

  has_many :ratings, dependent: :destroy
  belongs_to :brewery

  def average
    return 0 if ratings.empty?

    ratings.map(&:score).sum / ratings.count.to_f
  end

  def to_s
    "#{name} by #{brewery.name}"
  end
end
