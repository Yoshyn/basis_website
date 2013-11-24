require 'tiny_rafine/hash'

module TinyRafine

  raise "TinyRafine module is designed to be include in Rails context. It's seem that Rails is not defined." unless defined?(Rails)

  module Array

    # This module refine Array. The purpose is to manage argument parameter in a function
    refine ::Array do

      using TinyRafine::Hash

      # Extract options in a parameter array.
      # Symbolize the key and remove blank values
      # Process with an hash if merge_with option is given
      #
      # Arguments :
      # * +merge_with+  :  Hash of option. This hash will be merge with the array options if given
      def manage_options!(merge_with: {})
        opts = self.extract_options!.symbolize_keys_and_compact!
        opts.merge!(merge_with) if merge_with && merge_with.is_a?(::Hash)
      end

      # Extract options in a parameter array.
      # Symbolize the key and remove blank values
      # Process with an hash if merge_with option is given
      # Do it recursivly.
      #
      # Arguments :
      # * +merge_with+  :  Hash of option. This hash will be merge with the array options if given
      def deep_manage_options!(merge_with: {})
        opts = self.extract_options!.deep_symbolize_keys_and_compact!
        opts.deep_merge!(merge_with) if merge_with && merge_with.is_a?(::Hash)
      end
    end

  end
end