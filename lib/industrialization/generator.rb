module Industrialization
  # Generator
  class Generator
    attr_reader :obj, :template

    def initialize(obj:, template_path: 'templates/factory_girl.rb.erb')
      @obj = obj
      @template_path = template_path
      # TODO: refactor
      @template = ::File.open(::File.join(::File.dirname(::File.expand_path(__FILE__)), template_path), 'r').read
    end

    def render
      renderer = ERB.new(template)
      renderer.result(binding)
    end

    def object_name
      ActiveSupport::Inflector.underscore(obj.class.name)
    end

    def object_attributes
      Attributes.new(attributes: obj.serializable_hash
        .except('created_at', 'updated_at'))
    end
  end
end
