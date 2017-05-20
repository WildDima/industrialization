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
      @file = File.new(path: file_path).create

      return file.error_messages unless file.created?
    end

    def file_path
      "#{path}/#{ActiveSupport::Inflector.underscore(obj.class.name)}.rb"
    end
  end
end
