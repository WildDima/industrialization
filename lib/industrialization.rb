require 'industrialization/version'
# Industrialization
module Industrialization
  require 'industrialization/factory'
  require 'industrialization/file'
  require 'industrialization/railtie' if defined?(Rails)
end
