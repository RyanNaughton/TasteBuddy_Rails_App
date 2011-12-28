object @restaurant_menu_item_comment

attribute :text
code(:username) {|comment| comment.user.username }
