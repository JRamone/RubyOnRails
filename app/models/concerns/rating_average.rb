module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    average = ratings.average(:score)
    0 unless average
    average
  end
end
