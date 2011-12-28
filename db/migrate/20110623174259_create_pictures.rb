class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :caption
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :menu_item_id

      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at

      t.timestamps
    end

    add_index :pictures, :user_id
    add_index :pictures, :restaurant_id
    add_index :pictures, :menu_item_id
  end
end
