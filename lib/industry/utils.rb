module Industry
  # Utils
  module Utils
    extend self

    def underscore(class_name)
      class_name.split(/(?=[A-Z])|::/).map(&:downcase).join('_')
    end

    def hash_except_keys(hash, keys:)
      dup_hash = hash.dup
      keys.each { |k| dup_hash.delete(k) }
      dup_hash
    end

    # just copied from activesupport
    # rubocop:disable all
    def constantize(camel_cased_word)
      names = camel_cased_word.split("::".freeze)

      Object.const_get(camel_cased_word) if names.empty?

      names.shift if names.size > 1 && names.first.empty?

      names.inject(Object) do |constant, name|
        if constant == Object
          constant.const_get(name)
        else
          candidate = constant.const_get(name)
          next candidate if constant.const_defined?(name, false)
          next candidate unless Object.const_defined?(name)

          constant = constant.ancestors.inject(constant) do |const, ancestor|
            break const    if ancestor == Object
            break ancestor if ancestor.const_defined?(name, false)
            const
          end

          constant.const_get(name, false)
        end
      end
    end
    # rubocop:enable all
  end
end
