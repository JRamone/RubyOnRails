class RemoveStyleFromBeer < ActiveRecord::Migration[7.0]
  def change
    change_table :beers do |b|
      b.remove :style, :string
    end
  end
end
