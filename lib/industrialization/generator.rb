module Industrialization
  # Generator
  class Generator
    attr_reader :obj, :template, :serialization_method, :attributes_class

    def initialize(obj:,
                   serialization_method: :serializable_hash,
                   template_path: 'templates/factory_girl.rb.erb',
                   attributes_class: Attributes)
      @obj = obj
      @serialization_method = serialization_method
      @attributes_class = attributes_class
      # TODO: refactor
      @template = ::File.open(::File.join(::File.dirname(::File.expand_path(__FILE__)), template_path), 'r').read
    end

    def render
      renderer = ERB.new(template, nil, '-')
      renderer.result(binding)
    end

    def object_name
      Industrialization.underscore(obj.class.name)
    end

    def class_name
      obj.class.name.include?('::') ? ", class: '#{obj.class.name}'" : ' '
    end

    def object_attributes
      Attributes.new(attributes: obj.public_send(serialization_method))
    end
  end
end
