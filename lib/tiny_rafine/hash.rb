module TinyRafine
  module Hash

    refine ::Hash do
      def symbolize_keys_and_compact!
        keys.each do |key|
          value = delete(key)                                             # The key does not exist anymore in the hash
          self[(key.to_sym rescue key) || key] = value if value.present?  # We reinsert the value with the symbolized key
        end
        self
      end

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

      def compact!
        self.delete_if { |_, v| v.blank? }
      end

      def deep_compact!
        self.select! do |key, value| #FIXME : run benchmark to know if iterate with each and delete if faster or not
          value.deep_compact! if value.is_a?(::Hash)
          value.present?
        end
      end
    end

  end
end