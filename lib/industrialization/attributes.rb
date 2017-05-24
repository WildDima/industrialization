module Industrialization
  # Attributes
  class Attributes
    extend Forwardable

    delegate each: :modified_attributes

    attr_reader :attributes

    def initialize(attributes:)
      @attributes = attributes
    end

    # TODO: I don't like, need to refactor
    def modified_attributes(attrs = default_attributes)
      attrs.each_with_object({}) { |(key, val), acc| acc[key] = modify val }
    end

    private

    def default_attributes
      attributes.except('created_at', 'updated_at', 'id')
    end

    def modify(val)
      case val
      when Hash
        modified_attributes(val)
      when Array
        val
      when Numeric
        val
      when nil
        'nil'
      else
        "'#{val}'"
      end
    end
  end
end
