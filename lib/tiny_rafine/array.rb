require 'tiny_rafine/hash'

module TinyRafine
  module Array

    refine ::Array do

      using TinyRafine::Hash

      def manage_options!(merge_with: {})
        opts = self.extract_options!.symbolize_keys_and_compact!
        opts.merge!(merge_with) if merge_with && merge_with.is_a?(::Hash)
      end

      def deep_manage_options!(merge_with: {})
        opts = self.extract_options!.deep_symbolize_keys_and_compact!
        opts.deep_merge!(merge_with) if merge_with && merge_with.is_a?(::Hash)
      end
    end

  end
end