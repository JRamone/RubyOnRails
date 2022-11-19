class Rating < ApplicationRecord
  belongs_to :beer
  belongs_to :user

  def tuloste
    "#{beer.name} #{score}"
  end
end
