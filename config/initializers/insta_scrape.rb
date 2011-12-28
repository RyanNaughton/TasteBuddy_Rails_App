require_dependency File.expand_path('../services', __FILE__)

InstaScrape.configure do |config|
  config.client_id = ENV['INSTAGRAM_CLIENT_ID'] || service_configuration['instagram_client_id']
end
