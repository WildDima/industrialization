module Industrialization
  # CreateFactory
  class Factory
    class << self
      def call(obj:, path:)
        new(obj: obj, path: path).call
      end
    end

    attr_accessor :obj, :path, :file, :file_class, :generator_class

    def initialize(obj:,
                   path:,
                   file_class: File,
                   generator_class: Generator)
      @obj = obj
      @path = path
      @file_class = file_class
      @generator_class = generator_class
    end

    def call
      @file = file_class.new(path: path, name: file_name).create
      return file.error_messages unless file.created?
      @file.write factory_data
      "factory #{file_path} was created"
    end

    def file_path
      "#{path}/#{ActiveSupport::Inflector.underscore(obj.class.name)}.rb"
    end

    def file_name
      "#{ActiveSupport::Inflector.underscore(obj.class.name)}.rb"
    end

    def factory_data
      Generator.new(obj: obj).render
    end
  end
end
