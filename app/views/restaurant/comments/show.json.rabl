object @restaurant_comment

attribute :text
code(:username) {|comment| comment.user.username }
