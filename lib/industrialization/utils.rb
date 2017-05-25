module Industrialization
  # Utils
  module Utils
    def underscore(class_name)
      class_name.split('::').map(&:downcase).join('_')
    end

    def hash_except_keys(hash, keys:)
      dup_hash = hash.dup
      keys.each { |k| dup_hash.delete(k) }
      dup_hash
    end
  end
end
