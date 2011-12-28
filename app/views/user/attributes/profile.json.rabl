object current_user
attributes :username, :ratings_count

code :user_gallery do
  @pictures_gallery.map do |gallery_grouping|
    Hash[
      :date => gallery_grouping[:date],
      :pictures_by_restaurant => gallery_grouping[:pictures_by_restaurant].map do |restaurant_grouping|
        Hash[
          :restaurant_id => restaurant_grouping[:restaurant_id],
          :restaurant_name => restaurant_grouping[:restaurant_name],
          :pictures => partial('pictures/index', object: restaurant_grouping[:pictures])
        ]
      end
    ]
  end
end
