object @picture

attributes :id, :user_id, :restaurant_id, :menu_item_id

Picture::EXPORT_STYLES.dup.each do |style|
  code(style) {|pic| pic.attachment.url(style) }
end

code(:username) {|pic| pic.user.username }
code(:restaurant_name) {|pic| pic.restaurant.try(:name) }
code(:menu_item_name, :if => lambda {|pic| pic.menu_item.present? }) {|pic| pic.menu_item.name }
code(:caption, :if => lambda {|pic| pic.user_id == current_user.try(:id) }) {|pic| pic.caption }
