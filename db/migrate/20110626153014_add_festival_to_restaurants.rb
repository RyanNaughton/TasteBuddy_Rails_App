class AddFestivalToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :festival_id, :integer
    add_index :restaurants, :festival_id
  end
end
