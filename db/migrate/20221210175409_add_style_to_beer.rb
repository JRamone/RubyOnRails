class AddStyleToBeer < ActiveRecord::Migration[7.0]
  def change
    add_column :beers, :style_id, :integer
  end
end
