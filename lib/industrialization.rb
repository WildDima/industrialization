require 'industrialization/version'
# Industrialization
module Industrialization
  require 'erb'
  require 'industrialization/factory'
  require 'industrialization/file'
  require 'industrialization/generator'
  require 'industrialization/attributes'
  require 'industrialization/directory'

  require 'industrialization/partial/base'
  require 'industrialization/partial/hash'
  require 'industrialization/partial/default'

  require 'industrialization/railtie' if defined?(Rails)
  # TODO: Remove active support
  require 'active_support/inflector'
  require 'ostruct'

  def underscore(class_name)
    class_name.split('::').map(&:downcase).join('_')
  end

  module_function :underscore
end
