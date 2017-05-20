module Industrialization
  # CreateFile
  class File
    attr_accessor :path, :created

    def initialize(path:)
      @path = path
    end

    def create
      self
    end

    def created?
      @created ||= false
    end
  end
end
