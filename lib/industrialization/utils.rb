module Industrialization
  # Utils
  module Utils
    def underscore(class_name)
      class_name.split('::').map(&:downcase).join('_')
    end
  end
end
