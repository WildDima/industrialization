module Industrialization
  # Generator
  class Generator
    attr_reader :obj,
                :template,
                :serialization_method,
                :attributes_class,
                :template_path,
                :partial_path

    def initialize(obj:,
                   serialization_method: :serializable_hash,
                   template_path: 'templates/factory_girl.rb.erb',
                   partial_path: 'templates/partials/',
                   attributes_class: Attributes)
      @obj = obj
      @serialization_method = serialization_method
      @attributes_class = attributes_class
      @template_path = template_path
      @partial_path = partial_path
      @template = read_template path: template_path
    end

    def render(rendering_template = template)
      renderer = ERB.new(rendering_template, nil, '-')
      renderer.result(binding)
    end

    def render_partial(attr:, value:)
      case value
      when Hash
        hash_partial(attr: attr, value: value)
      else
        base_partial(attr: attr, value: value)
      end
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

    private

    def base_partial(attr:, value:)
      renderer = ERB.new(read_partial_for(:base), nil, '-')
      namespace = OpenStruct.new(attr: attr, value: value)
      renderer.result(namespace.instance_eval { binding })
    end

    def hash_partial(attr:, value:)
      renderer = ERB.new(read_partial_for(:hash), nil, '-')
      namespace = OpenStruct.new(attr: attr, value: value)
      renderer.result(namespace.instance_eval { binding })
    end

    def read_template(path:)
      # TODO: refactor
      ::File.open(
        ::File.join(
          ::File.dirname(::File.expand_path(__FILE__)), path
        ), 'r'
      ).read
    end

    def read_partial_for(partial)
      read_template path: "#{partial_path}#{partial}.rb.erb"
    end
  end
end
