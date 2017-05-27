module Industrialization
  # Attributes
  class Attributes
    include Utils
    extend Forwardable

    delegate each: :default_attributes

    attr_reader :attributes

    def initialize(attributes:)
      @attributes = attributes
    end

    private

    def default_attributes
      hash_except_keys attributes, keys: %w[created_at updated_at id]
    end
  end
end
