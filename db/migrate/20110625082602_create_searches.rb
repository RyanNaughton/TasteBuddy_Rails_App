class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :find
      t.string :near
      t.integer :page
      t.string :coordinates
      t.decimal :latitude
      t.decimal :longitude
      t.integer :user_id

      t.integer :festival_id

      t.datetime :created_at
    end

    add_index :searches, :user_id
  end
end
