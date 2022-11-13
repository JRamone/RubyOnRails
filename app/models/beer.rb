class Beer < ApplicationRecord
  has_many  :ratings
  belongs_to :brewery

def average_rating
  self.ratings.map{|rating|rating.score}.inject(:+)
end
end
