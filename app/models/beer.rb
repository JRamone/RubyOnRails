class Beer < ApplicationRecord
  has_many  :ratings, dependent: :destroy
  belongs_to :brewery

def average_rating
  self.ratings.map{|rating|rating.score}.inject(:+)
end

def to_s
  "#{self.name} by #{self.brewery.name}"
end
end
