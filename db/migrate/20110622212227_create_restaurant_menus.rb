class CreateRestaurantMenus < ActiveRecord::Migration
  def change
    create_table :restaurant_menus do |t|
      t.integer :restaurant_id, null: false
      t.text :description

      t.timestamps
    end

    add_index :restaurant_menus, :restaurant_id

    create_table :restaurant_menu_items do |t|
      t.integer :restaurant_menu_id, null: false
      t.integer :boss_restaurant_menu_item_id
      t.integer :restaurant_id
      t.string :section
      t.string :subsection
      t.string :number
      t.string :name, null: false
      t.string :foreign_name
      t.string :alternative_name
      t.string :description
      t.string :tags
      t.string :category_values
      t.boolean :price_selector
      t.boolean :cpg
      t.decimal :price
      t.string :prices
      t.integer :ticket_price
      t.decimal :average_rating
      t.integer :ratings_count, default: 0

      t.timestamps
    end

    add_index :restaurant_menu_items, :restaurant_id
    add_index :restaurant_menu_items, :restaurant_menu_id
    add_index :restaurant_menu_items, :boss_restaurant_menu_item_id
    add_index :restaurant_menu_items, :name
    add_index :restaurant_menu_items, :alternative_name
    add_index :restaurant_menu_items, :price
    add_index :restaurant_menu_items, :price_selector
  end
end
