class CreateTags < ActiveRecord::Migration
  def change
    create_table :authorized_tags do |t|
      t.string :name

      t.datetime :created_at
    end

    create_table :restaurant_tags do |t|
      t.integer :authorized_tag_id
      t.integer :user_id
      t.integer :restaurant_id

      t.datetime :created_at
    end

    add_index :restaurant_tags, :authorized_tag_id
    add_index :restaurant_tags, :user_id
    add_index :restaurant_tags, :restaurant_id

    create_table :restaurant_menu_item_tags do |t|
      t.integer :authorized_tag_id
      t.integer :user_id
      t.integer :restaurant_menu_item_id

      t.datetime :created_at
    end

    add_index :restaurant_menu_item_tags, :authorized_tag_id
    add_index :restaurant_menu_item_tags, :user_id
    add_index :restaurant_menu_item_tags, :restaurant_menu_item_id
  end
end
