def service_configuration
  path = Rails.root.join(*%w{config services.yml})
  file = File.new(path, 'r')
  YAML.load(file)
end
