require 'industrialization/version'
# Industrialization
module Industrialization
  require 'industrialization/create_factory'
  require 'industrialization/create_file'
  require 'industrialization/railtie' if defined?(Rails)
end
