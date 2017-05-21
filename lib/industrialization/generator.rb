module Industrialization
  # Generator
  class Generator
    attr_reader :obj, :template

    def initialize(obj:, template_path: './lib/industrialization/templates/factory_girl.rb.erb')
      @obj = obj
      @template_path = template_path
      @template = ::File
                  .open(template_path, 'r')
                  .read
    end

    def render
      renderer = ERB.new(template)
      renderer.result(binding)
    end

    def object_name
      ActiveSupport::Inflector.underscore(obj.class.name)
    end

    def object_attributes
      obj.serializable_hash
    end
  end
end
