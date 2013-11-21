# def name({required_arguments, ...}
#          {optional_arguments, ...}
#          {*rest || additional_required_arguments...} # Did you know?
#          {keyword_arguments: "with_defaults"...}
#          {**rest_of_keyword_arguments}
#          {&block_capture})

module TinyRafine

  def merge_obj_to_a(object, *args)
    ((object.is_a?(Array) ? object : object.to_s.split(/\s+/)) + args ).compact
  end

  refine Array do
    def manage_options!(deep: false, merge_with: {})
      opts = self.extract_options!
      must_merge = merge_with && merge_with.is_a(Hash)

      if deep
        opts.deep_symbolize_keys_and_compact!
        opts.deep_merge!(merge_with) if must_merge
      else
        opts.symbolize_keys_and_compact!
        opts.merge!(merge_with) if must_merge
      end
    end
  end

  refine Hash do
    def symbolize_keys_and_compact!
      self.select! do |key,value|
        self[(key.to_sym rescue key) || key] = delete(key) if value.present?
      end
    end

    def deep_symbolize_keys_and_compact!
      self.select! do |key,value|
        key.deep_symbolize_keys_and_compact! if value.is_a?(Hash)
        self[(key.to_sym rescue key) || key] = delete(key) if value.present?
      end
    end

    def compact!
      self.delete_if { |_, v| v.blank? }
    end

    def deep_compact!
      self.select! do |key, value|
        key.deep_compact! if value.is_a?(Hash)
        value.present?
      end
    end
  end
end