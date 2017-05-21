module Industrialization
  # CreateFile
  class File
    attr_accessor :path, :created, :errors, :name, :file

    def initialize(path:, name:)
      @path = path
      @name = name
      @errors = []
    end

    def create
      if ::File.exist?(full_path)
        @errors << 'File already exists'
        return self
      end

      @file = ::File.open(full_path, 'w+')
      @created = true if @file
      self
    end

    def write(data)
      @file.write(data)
      self
    end

    def created?
      @created ||= false
    end

    def error_messages
      @errors.join(' ')
    end

    def full_path
      "#{path}/#{name}"
    end
  end
end
