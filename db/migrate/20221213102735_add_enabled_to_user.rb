class AddEnabledToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :enabled, :boolean
  end
end
