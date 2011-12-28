class CreateRestaurantGroups < ActiveRecord::Migration
  def change
    create_table :restaurant_groups do |t|
      t.string :name
      t.integer :boss_restaurant_id

      t.timestamps
    end
  end
end
