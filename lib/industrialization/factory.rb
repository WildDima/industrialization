module Industrialization
  # CreateFactory
  class Factory
    class << self
      def call(obj:, path:)
        new(obj: obj, path: path).call
      end
    end

    attr_accessor :obj, :path, :file

    def initialize(obj:, path:)
      @obj = obj
      @path = path
    end

    def call
      @file = File.new(path: path).create

      return 'ERROR' unless file.created?
    end
  end
end
