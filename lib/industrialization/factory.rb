module Industrialization
  # CreateFactory
  class Factory
    class << self
      def call(obj:, path:)
        new(obj: obj, path: path).call
      end
    end

    attr_accessor :obj, :path, :file, :file_class

    def initialize(obj:, path:, file_class: File)
      @obj = obj
      @path = path
      @file_class = file_class
    end

    def call
      @file = file_class.new(path: file_path).create

      return file.error_messages unless file.created?

      # file.write(data)
    end

    def file_path
      "#{path}/#{ActiveSupport::Inflector.underscore(obj.class.name)}.rb"
    end
  end
end
