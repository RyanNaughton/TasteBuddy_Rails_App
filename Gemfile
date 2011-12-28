source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'thin'
gem 'pg'
gem 'rack-cache'
gem 'dalli', '1.0.5'

gem 'devise', '1.4.2'
gem 'attribute_normalizer'
gem 'will_paginate', git: 'https://github.com/xspond/will_paginate.git', ref: '7dfc31d'
gem 'cancan', '1.6.5'
gem 'paperclip', git: 'https://github.com/thoughtbot/paperclip.git', ref: 'e703662'
gem 'aws-s3', '0.6.2'
gem 'rabl', git: 'https://github.com/nesquena/rabl.git', ref: 'b552e71'
gem 'sunspot_rails', '1.2.1'
gem 'haversine', '0.2.0'
gem 'geokit', '1.5.0'

gem 'insta_scrape', git: 'https://github.com/wtn/insta_scrape.git', ref: '9043e13'
gem 'grub_scrape', git: 'https://github.com/ArgoNavisDev/grub_scrape.git', ref: '26fce3a'
gem 'menu_scrape', git: 'https://github.com/ArgoNavisDev/menu_scrape.git', ref: '3aecd8b'
gem 'yelp_scrape', git: 'git://github.com/ArgoNavisDev/yelp_scrape.git', ref: '93bc9ac'

# Asset template engines
gem 'haml', git: 'https://github.com/nex3/haml.git', ref: 'ffb7306'
gem 'sass-rails', '~> 3.1.0.rc2'
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

group :development, :test do
  gem 'haml-rails'
  gem 'rspec'
  gem 'rspec-rails', '2.6.1'
  gem 'factory_girl_generator', '0.0.2'
  gem 'factory_girl_rails', '1.0.1'
  gem 'remarkable_activerecord', '4.0.0.alpha4'
  gem 'foreman' # memcached
end

group :production do
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

# heroku gem dependency fail
gem 'addressable', git: 'https://github.com/sporkmonger/addressable.git', ref: 'cfd786b'
gem 'faraday', git: 'https://github.com/technoweenie/faraday.git', ref: '6411855'
gem 'faraday_middleware', git: 'https://github.com/pengwynn/faraday_middleware.git', ref: '5466bad'
gem 'cocaine', git: 'https://github.com/thoughtbot/cocaine.git', ref: '091cc7c'
