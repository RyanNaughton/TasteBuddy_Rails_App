class CreateFestivals < ActiveRecord::Migration
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :address_description
      t.string :address_1
      t.string :city_town
      t.string :state_province
      t.string :postal_code
      t.string :website_url
      t.decimal :latitude
      t.decimal :longitude
      t.date :start_date
      t.date :end_date
      t.decimal :ticket_cost

      t.timestamps
    end

    create_table :festival_logos do |t|
      t.integer :festival_id, null: false
      t.string :low_resolution, null: false
      t.string :standard_resolution, null: false

      t.timestamps
    end

    create_table :festival_header_colors do |t|
      t.integer :festival_id, null: false
      t.integer :red, null: false
      t.integer :green, null: false
      t.integer :blue, null: false

      t.timestamps
    end
  end
end
