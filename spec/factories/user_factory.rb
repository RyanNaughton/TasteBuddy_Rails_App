Factory.define :user do |f|
  f.username 'user'
  f.email 'user@example.com'
  f.password 'nN<$Y!#hwx'
end

Factory.define :admin, :parent => :user do |f|
  f.roles [:admin]
end
