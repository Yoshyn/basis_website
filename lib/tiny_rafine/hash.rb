module TinyRafine

  raise "TinyRafine module is designed to be include in Rails context. It's seem that Rails is not defined." unless defined?(Rails)

  # This module refine Hash. The purpose of this refine is add some function that miss me on the amazing rails override.
  module Hash

    refine ::Hash do

      # Symbolize key of the hash an remove entry with blank value
      def symbolize_keys_and_compact!
        keys.each do |key|
          value = delete(key)                                             # The key does not exist anymore in the hash
          self[(key.to_sym rescue key) || key] = value if value.present?  # We reinsert the value with the symbolized key
        end
        self
      end

      # Symbolize key of the hash an remove entry with blank value.
      # Do it recursivly.
      def deep_symbolize_keys_and_compact!
        # See @symbolize_keys_and_compact! method. Same code with recursivity on Hash
        keys.each do |key|
          value = delete(key)
          if value.present?
            self[(key.to_sym rescue key) || key] = value.is_a?(::Hash) ? value.deep_symbolize_keys_and_compact! : value
          end
        end
        self
      end

      # Remove blank entry with blank value of the hash
      def compact!
        self.delete_if { |_, v| v.blank? }
      end

      # Remove blank entry with blank value of the hash
      # Do it recursivly.
      def deep_compact!
        self.select! do |key, value| #FIXME : run benchmark to know if iterate with each and delete if faster or not
          value.deep_compact! if value.is_a?(::Hash)
          value.present?
        end
      end
    end

  end
end