require 'industry/version'
# Industry
module Industry
  require 'erb'
  require 'industry/utils'
  require 'industry/factory'
  require 'industry/file'
  require 'industry/generator'
  require 'industry/attributes'
  require 'industry/directory'

  require 'industry/partial/base'
  require 'industry/partial/hash'
  require 'industry/partial/default'
  require 'industry/partial/array'
  require 'industry/partial/nil_class'
  require 'industry/partial/float'
  require 'industry/partial/integer'
  require 'industry/partial/true_class'
  require 'industry/partial/false_class'

  require 'industry/railtie' if defined?(Rails)
  require 'ostruct'
end
