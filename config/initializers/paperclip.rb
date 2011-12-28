require_dependency File.expand_path('../services', __FILE__)

TasteBuddy::S3_CREDENTIALS = Hash[
  'access_key_id' => ENV['S3_ACCESS_KEY_ID'] || service_configuration['s3']['access_key_id'],
  'secret_access_key' => ENV['S3_SECRET_ACCESS_KEY'] || service_configuration['s3']['secret_access_key']
].freeze
