class Rating < ApplicationRecord
  belongs_to :beer

  def tuloste
    puts "#{self.beer.name} #{self.score}"
  end
end
