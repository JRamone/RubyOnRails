class Beer < ApplicationRecord
  include RatingAverage

  has_many  :ratings, dependent: :destroy
  belongs_to :brewery

def to_s
  "#{self.name} by #{self.brewery.name}"
end
end
