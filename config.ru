# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::Deflater
use Rack::Cache,
  verbose: true,
  metastore: "memcached://#{ENV['MEMCACHE_SERVERS'] or 'localhost'}",
  entitystore: "memcached://#{ENV['MEMCACHE_SERVERS'] or 'localhost'}"

run TasteBuddy::Application
