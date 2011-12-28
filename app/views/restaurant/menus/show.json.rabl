collection @data

code(:name) do |obj|
  obj[:name]
end

code(:subcategories) do |obj|
  obj[:subsections].map {|h| Hash[:name => h[:name], :items => partial('restaurant/menu/items/index', object: h[:menu_items])]}
end
