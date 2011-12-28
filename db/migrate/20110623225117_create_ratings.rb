class CreateRatings < ActiveRecord::Migration
  def change
    create_table :restaurant_ratings do |t|
      t.integer :value
      t.integer :user_id
      t.integer :restaurant_id

      t.timestamps
    end

    add_index :restaurant_ratings, [:user_id, :restaurant_id], unique: true

    create_table :restaurant_menu_item_ratings do |t|
      t.integer :value
      t.integer :user_id
      t.integer :restaurant_menu_item_id

      t.timestamps
    end

    add_index :restaurant_menu_item_ratings, [:user_id, :restaurant_menu_item_id], unique: true, name: 'index_restaurant_menu_item_ratings_on_user_id_and_menu_item_id'
  end
end
