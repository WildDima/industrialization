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
      modify_hash obj.serializable_hash
        .except('created_at', 'updated_at')
    end

    # TODO: I don't like, need to refactor
    def modify_hash(hash)
      hash.each_with_object({}) do |(key, val), acc|
        acc[key] = case val
                   when Hash
                     modify_hash(val)
                   when String
                     "'#{val}'"
                   when nil
                    "nil"
                   else
                     val
                   end
      end
    end
  end
end
