# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110628043404) do

  create_table "authorized_tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  create_table "cached_records", :force => true do |t|
    t.integer  "festival_id"
    t.string   "name"
    t.text     "json"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cached_records", ["festival_id"], :name => "index_cached_records_on_festival_id"
  add_index "cached_records", ["updated_at"], :name => "index_cached_records_on_updated_at"

  create_table "festival_header_colors", :force => true do |t|
    t.integer  "festival_id", :null => false
    t.integer  "red",         :null => false
    t.integer  "green",       :null => false
    t.integer  "blue",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festival_logos", :force => true do |t|
    t.integer  "festival_id",         :null => false
    t.string   "low_resolution",      :null => false
    t.string   "standard_resolution", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festivals", :force => true do |t|
    t.string   "name"
    t.string   "address_description"
    t.string   "address_1"
    t.string   "city_town"
    t.string   "state_province"
    t.string   "postal_code"
    t.string   "website_url"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "ticket_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "neighborhoods", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
  end

  create_table "pictures", :force => true do |t|
    t.string   "caption"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.integer  "menu_item_id"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pictures", ["menu_item_id"], :name => "index_pictures_on_menu_item_id"
  add_index "pictures", ["restaurant_id"], :name => "index_pictures_on_restaurant_id"
  add_index "pictures", ["user_id"], :name => "index_pictures_on_user_id"

  create_table "restaurant_bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
  end

  add_index "restaurant_bookmarks", ["user_id", "restaurant_id"], :name => "index_restaurant_bookmarks_on_user_id_and_restaurant_id", :unique => true

  create_table "restaurant_comments", :force => true do |t|
    t.string   "text",          :limit => 140
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
  end

  add_index "restaurant_comments", ["restaurant_id"], :name => "index_restaurant_comments_on_restaurant_id"
  add_index "restaurant_comments", ["user_id"], :name => "index_restaurant_comments_on_user_id"

  create_table "restaurant_groups", :force => true do |t|
    t.string   "name"
    t.integer  "boss_restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurant_menu_item_bookmarks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "restaurant_menu_item_id"
    t.datetime "created_at"
  end

  add_index "restaurant_menu_item_bookmarks", ["user_id", "restaurant_menu_item_id"], :name => "index_restaurant_menu_item_bookmarks_on_user_id_and_item_id", :unique => true

  create_table "restaurant_menu_item_comments", :force => true do |t|
    t.string   "text",                    :limit => 140
    t.integer  "user_id"
    t.integer  "restaurant_menu_item_id"
    t.datetime "created_at"
  end

  add_index "restaurant_menu_item_comments", ["restaurant_menu_item_id"], :name => "index_restaurant_menu_item_comments_on_restaurant_menu_item_id"
  add_index "restaurant_menu_item_comments", ["user_id"], :name => "index_restaurant_menu_item_comments_on_user_id"

  create_table "restaurant_menu_item_ratings", :force => true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "restaurant_menu_item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restaurant_menu_item_ratings", ["user_id", "restaurant_menu_item_id"], :name => "index_restaurant_menu_item_ratings_on_user_id_and_menu_item_id", :unique => true

  create_table "restaurant_menu_item_tags", :force => true do |t|
    t.integer  "authorized_tag_id"
    t.integer  "user_id"
    t.integer  "restaurant_menu_item_id"
    t.datetime "created_at"
  end

  add_index "restaurant_menu_item_tags", ["authorized_tag_id"], :name => "index_restaurant_menu_item_tags_on_authorized_tag_id"
  add_index "restaurant_menu_item_tags", ["restaurant_menu_item_id"], :name => "index_restaurant_menu_item_tags_on_restaurant_menu_item_id"
  add_index "restaurant_menu_item_tags", ["user_id"], :name => "index_restaurant_menu_item_tags_on_user_id"

  create_table "restaurant_menu_items", :force => true do |t|
    t.integer  "restaurant_menu_id",                          :null => false
    t.integer  "boss_restaurant_menu_item_id"
    t.integer  "restaurant_id"
    t.string   "section"
    t.string   "subsection"
    t.string   "number"
    t.string   "name",                                        :null => false
    t.string   "foreign_name"
    t.string   "alternative_name"
    t.string   "description"
    t.string   "tags"
    t.string   "category_values"
    t.boolean  "price_selector"
    t.boolean  "cpg"
    t.decimal  "price"
    t.string   "prices"
    t.integer  "ticket_price"
    t.decimal  "average_rating"
    t.integer  "ratings_count",                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restaurant_menu_items", ["alternative_name"], :name => "index_restaurant_menu_items_on_alternative_name"
  add_index "restaurant_menu_items", ["boss_restaurant_menu_item_id"], :name => "index_restaurant_menu_items_on_boss_restaurant_menu_item_id"
  add_index "restaurant_menu_items", ["name"], :name => "index_restaurant_menu_items_on_name"
  add_index "restaurant_menu_items", ["price"], :name => "index_restaurant_menu_items_on_price"
  add_index "restaurant_menu_items", ["price_selector"], :name => "index_restaurant_menu_items_on_price_selector"
  add_index "restaurant_menu_items", ["restaurant_id"], :name => "index_restaurant_menu_items_on_restaurant_id"
  add_index "restaurant_menu_items", ["restaurant_menu_id"], :name => "index_restaurant_menu_items_on_restaurant_menu_id"

  create_table "restaurant_menus", :force => true do |t|
    t.integer  "restaurant_id", :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restaurant_menus", ["restaurant_id"], :name => "index_restaurant_menus_on_restaurant_id"

  create_table "restaurant_ratings", :force => true do |t|
    t.integer  "value"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "restaurant_ratings", ["user_id", "restaurant_id"], :name => "index_restaurant_ratings_on_user_id_and_restaurant_id", :unique => true

  create_table "restaurant_tags", :force => true do |t|
    t.integer  "authorized_tag_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at"
  end

  add_index "restaurant_tags", ["authorized_tag_id"], :name => "index_restaurant_tags_on_authorized_tag_id"
  add_index "restaurant_tags", ["restaurant_id"], :name => "index_restaurant_tags_on_restaurant_id"
  add_index "restaurant_tags", ["user_id"], :name => "index_restaurant_tags_on_user_id"

  create_table "restaurants", :force => true do |t|
    t.integer  "restaurant_group_id"
    t.integer  "boss_restaurant_id"
    t.string   "name",                                               :null => false
    t.string   "cuisine_type"
    t.integer  "foursquare_v1"
    t.string   "foursquare_v2",       :limit => 24
    t.string   "instagram_v1",        :limit => 24
    t.string   "yelp_url"
    t.string   "yelp_id"
    t.string   "menupages_url"
    t.string   "grubhub_url"
    t.string   "neighborhood"
    t.string   "address_description"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city_town"
    t.string   "state_province"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone"
    t.string   "fax"
    t.string   "website_url"
    t.string   "dress_code"
    t.boolean  "credit_cards"
    t.boolean  "reservations"
    t.boolean  "takeout"
    t.boolean  "delivery"
    t.decimal  "delivery_minimum"
    t.decimal  "delivery_fee"
    t.string   "delivery_details"
    t.string   "delivery_radius"
    t.boolean  "wheelchair_access"
    t.boolean  "group_friendly"
    t.boolean  "kid_friendly"
    t.boolean  "outdoor_seating"
    t.boolean  "byob"
    t.string   "alcohol_type"
    t.boolean  "live_music"
    t.string   "live_music_details"
    t.boolean  "jukebox"
    t.string   "parking"
    t.string   "parking_details"
    t.boolean  "smoking"
    t.boolean  "wifi"
    t.string   "nearest_transit"
    t.string   "additional_details"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.decimal  "average_meal_price"
    t.integer  "booth_number"
    t.decimal  "average_rating",                    :default => 0.0
    t.integer  "ratings_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "festival_id"
  end

  add_index "restaurants", ["boss_restaurant_id"], :name => "index_restaurants_on_boss_restaurant_id"
  add_index "restaurants", ["festival_id"], :name => "index_restaurants_on_festival_id"
  add_index "restaurants", ["foursquare_v1"], :name => "index_restaurants_on_foursquare_v1"
  add_index "restaurants", ["foursquare_v2"], :name => "index_restaurants_on_foursquare_v2"
  add_index "restaurants", ["instagram_v1"], :name => "index_restaurants_on_instagram_v1"
  add_index "restaurants", ["name"], :name => "index_restaurants_on_name"
  add_index "restaurants", ["restaurant_group_id"], :name => "index_restaurants_on_restaurant_group_id"
  add_index "restaurants", ["yelp_id"], :name => "index_restaurants_on_yelp_id"

  create_table "searches", :force => true do |t|
    t.string   "find"
    t.string   "near"
    t.integer  "page"
    t.string   "coordinates"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.integer  "user_id"
    t.integer  "festival_id"
    t.datetime "created_at"
  end

  add_index "searches", ["user_id"], :name => "index_searches_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "username",                                              :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "postal_code",            :limit => 10
    t.string   "country"
    t.string   "gender",                 :limit => 1
    t.date     "birthday"
    t.string   "roles"
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
