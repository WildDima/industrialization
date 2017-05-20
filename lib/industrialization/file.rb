module Industrialization
  # CreateFile
  class File
    attr_accessor :path, :created, :errors

    def initialize(path:)
      @path = path
      @errors = []
    end

    def create
      if ::File.exist?(path)
        @errors << 'File already exists'
        return self
      end

      @file = ::File.open(path, 'w+')
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
  end
end
