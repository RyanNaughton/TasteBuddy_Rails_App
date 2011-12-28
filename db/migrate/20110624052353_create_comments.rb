class CreateComments < ActiveRecord::Migration
  def change
    create_table :restaurant_comments do |t|
      t.string :text, :limit => 140
      t.integer :user_id
      t.integer :restaurant_id

      t.datetime :created_at
    end

    add_index :restaurant_comments, :user_id
    add_index :restaurant_comments, :restaurant_id

    create_table :restaurant_menu_item_comments do |t|
      t.string :text, :limit => 140
      t.integer :user_id
      t.integer :restaurant_menu_item_id

      t.datetime :created_at
    end

    add_index :restaurant_menu_item_comments, :user_id
    add_index :restaurant_menu_item_comments, :restaurant_menu_item_id
  end
end
