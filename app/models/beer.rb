class Beer < ApplicationRecord
  has_many  :ratings
  belongs_to :brewery

def average_rating
  self.ratings.average(:score).to_f
end
end
