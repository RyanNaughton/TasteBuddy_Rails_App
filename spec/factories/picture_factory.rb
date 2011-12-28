Factory.define :picture do |f|
  f.attachment File.new(Rails.root.join(*%w{spec fixtures gaddafi.jpg})).to_s
  f.association :user
end
