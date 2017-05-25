module Industrialization
  module Partial
    # Abstract class for partials
    class Base
      attr_reader :attr, :value, :partials_path

      def initialize(attr:, value:, partials_path: 'templates/partials/')
        @attr = attr
        @value = value
        @partials_path = partials_path
      end

      def partial
        raise NotImplementedYet
      end

      def render
        renderer = ERB.new(read_partial, nil, '-')
        renderer.result(binding)
      end

      protected

      def read_partial
        ::File.read(
          Pathname.new(__dir__).parent.expand_path.join("#{partials_path}#{partial}.rb.erb")
        )
      end
    end
  end
end
