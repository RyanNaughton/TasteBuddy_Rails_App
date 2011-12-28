object @comment
attributes :text, :user_id

code(:username) do |comment|
  user.username
end
