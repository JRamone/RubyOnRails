class Beer < ApplicationRecord
  has_many  :ratings
  belongs_to :brewery
end
