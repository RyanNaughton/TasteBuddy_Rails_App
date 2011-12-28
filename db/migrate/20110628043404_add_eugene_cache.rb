class AddEugeneCache < ActiveRecord::Migration
  def change
    create_table :cached_records do |t|
      t.integer :festival_id
      t.string :name
      t.text :json

      t.timestamps
    end

    add_index :cached_records, :festival_id
    add_index :cached_records, :updated_at
  end
end
