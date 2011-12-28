class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :restaurant_bookmarks do |t|
      t.integer :user_id
      t.integer :restaurant_id

      t.datetime :created_at
    end

    add_index :restaurant_bookmarks, [:user_id, :restaurant_id], unique: true

    create_table :restaurant_menu_item_bookmarks do |t|
      t.integer :user_id
      t.integer :restaurant_menu_item_id

      t.datetime :created_at
    end

    add_index :restaurant_menu_item_bookmarks, [:user_id, :restaurant_menu_item_id], unique: true, name: 'index_restaurant_menu_item_bookmarks_on_user_id_and_item_id'
  end
end
