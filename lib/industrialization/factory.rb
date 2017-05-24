module Industrialization
  # CreateFactory
  class Factory
    class << self
      def call(obj:, factories_path:, serialization_method: :serializable_hash)
        new(obj: obj,
            factories_path: factories_path,
            serialization_method: serialization_method).call
      end
    end

    attr_accessor :obj,
                  :path,
                  :file,
                  :serialization_method,
                  :factories_path,
                  :file_class,
                  :generator_class,
                  :path_class

    def initialize(obj:,
                   factories_path:,
                   serialization_method: :serializable_hash,
                   file_class: File,
                   generator_class: Generator,
                   path_class: Directory)
      @obj = obj
      @factories_path = factories_path
      @serialization_method = serialization_method
      @file_class = file_class
      @generator_class = generator_class
      @path_class = path_class
    end

    def call
      @file = create_path && create_file
      return file.error_messages unless file.created?
      @file.write factory_data
      "factory #{factory_path} was created"
    end

    def factory_path
      "#{factories_path}/#{underscore(obj.class.name)}.rb"
    end

    def factory_name
      "#{underscore(obj.class.name)}.rb"
    end

    def factory_data
      generator_class.new(obj: obj, serialization_method: serialization_method).render
    end

    private

    def create_path
      path_class.new(path: factories_path).create
    end

    def create_file
      file_class.new(path: factories_path, name: factory_name).create
    end

    def underscore(class_name)
      class_name.split('::').map(&:downcase).join('_')
    end
  end
end
