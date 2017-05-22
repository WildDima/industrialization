module Industrialization
  # Attributes
  class Attributes
    extend Forwardable

    delegate :each => :modified_attributes

    attr_reader :attributes

    def initialize(attributes:)
      @attributes = attributes
    end

    # TODO: I don't like, need to refactor
    def modified_attributes(attrs = attributes)
      attrs.each_with_object({}) do |(key, val), acc|
        acc[key] = case val
                   when Hash
                     modified_attributes(val)
                   when String
                     "'#{val}'"
                   when nil
                     'nil'
                   else
                     val
                   end
      end
    end
  end
end
