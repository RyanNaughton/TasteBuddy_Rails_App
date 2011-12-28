class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :restaurant_group_id
      t.integer :boss_restaurant_id
      t.string :name, null: false
      t.string :cuisine_type
      t.integer :foursquare_v1
      t.string :foursquare_v2, limit: 24
      t.string :instagram_v1, limit: 24
      t.string :yelp_url
      t.string :yelp_id
      t.string :menupages_url
      t.string :grubhub_url
      t.string :neighborhood
      t.string :address_description
      t.string :address_1
      t.string :address_2
      t.string :city_town
      t.string :state_province
      t.string :postal_code
      t.string :country
      t.string :phone
      t.string :fax
      t.string :website_url
      t.string :dress_code
      t.boolean :credit_cards
      t.boolean :reservations
      t.boolean :takeout
      t.boolean :delivery
      t.decimal :delivery_minimum
      t.decimal :delivery_fee
      t.string :delivery_details
      t.string :delivery_radius
      t.boolean :wheelchair_access
      t.boolean :group_friendly
      t.boolean :kid_friendly
      t.boolean :outdoor_seating
      t.boolean :byob
      t.string :alcohol_type
      t.boolean :live_music
      t.string :live_music_details
      t.boolean :jukebox
      t.string :parking
      t.string :parking_details
      t.boolean :smoking
      t.boolean :wifi
      t.string :nearest_transit
      t.string :additional_details
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :average_meal_price
      t.integer :booth_number
      t.decimal :average_rating, default: 0
      t.integer :ratings_count

      t.timestamps
    end

    add_index :restaurants, :name
    add_index :restaurants, :foursquare_v1
    add_index :restaurants, :foursquare_v2
    add_index :restaurants, :instagram_v1
    add_index :restaurants, :yelp_id
    add_index :restaurants, :restaurant_group_id
    add_index :restaurants, :boss_restaurant_id
  end
end
