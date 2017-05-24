module Industrialization
  # Generator
  class Generator
    attr_reader :obj,
                :template,
                :serialization_method,
                :attributes_class,
                :template_path,
                :partials_path

    def initialize(obj:,
                   serialization_method: :serializable_hash,
                   template_path: 'templates/factory_girl.rb.erb',
                   partials_path: 'templates/partials/',
                   attributes_class: Attributes)
      @obj = obj
      @serialization_method = serialization_method
      @attributes_class = attributes_class
      @template_path = template_path
      @partials_path = partials_path
      @template = read_template path: template_path
    end

    def render(rendering_template = template)
      renderer = ERB.new(rendering_template, nil, '-')
      renderer.result(binding)
    end

    def render_partial(attr:, value:)
      case value
      when Hash
        Partial::Hash.new(attr: attr, value: value).render
      else
        Partial::Default.new(attr: attr, value: value).render
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

    def read_template(path:)
      ::File.read(
        Pathname.new(__FILE__).parent.expand_path.join(path)
      )
    end
  end
end
