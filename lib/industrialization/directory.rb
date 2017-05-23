module Industrialization
  # Directory
  class Directory
    attr_reader :path, :errors

    def initialize(path:)
      @path = path
      @errors = []
    end

    def create
      return true if Dir.exist? path
      dir = FileUtils.mkdir_p path
      @created = true if dir.any?
      self
    rescue => e
      @errors << e
      self
    end

    def error_messages
      errors.join(' ')
    end

    def created?
      @created ||= false
    end
  end
end
