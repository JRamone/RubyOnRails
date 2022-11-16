class Rating < ApplicationRecord
  belongs_to :beer

  def tuloste
    puts "#{beer.name} #{score}"
  end
end
