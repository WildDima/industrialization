require 'industrialization/version'
# Industrialization
module Industrialization
  require 'erb'
  require 'industrialization/utils'
  require 'industrialization/factory'
  require 'industrialization/file'
  require 'industrialization/generator'
  require 'industrialization/attributes'
  require 'industrialization/directory'

  require 'industrialization/partial/base'
  require 'industrialization/partial/hash'
  require 'industrialization/partial/default'
  require 'industrialization/partial/array'
  require 'industrialization/partial/nil_class'

  require 'industrialization/railtie' if defined?(Rails)
  require 'ostruct'
end
