require 'helpers/bootstrap/abstract_component'


# def name({required_arguments, ...}
#          {optional_arguments, ...}
#          {*rest || additional_required_arguments...} # Did you know?
#          {keyword_arguments: "with_defaults"...}
#          {**rest_of_keyword_arguments}
#          {&block_capture})
#   def merge_to_array(obj, *args)
#   end

#   def merge_data(hash, hash2)
#   end


#   refine Array do
#     def manage_options!(deep: false, merge_with: {})
#       self.extract_options!


#     # options = {
#     #   id: { simple_form: 'search_form' },
#     #   classes: { simple_form: ['search'] },
#     #   url: nil, method: :get, remote: false, text_field: true
#     #   }.deep_merge!(hash_options)

# class Hash
#   def symbolize_keys_and_compact!
#     self.select! do |key,value|
#       self[(key.to_sym rescue key) || key] = delete(key) if value.present?
#     end
#   end

#   def deep_symbolize_keys_and_compact!
#     self.select! do |key,value|
#       key.deep_symbolize_keys_and_compact! if value.is_a?(Hash)
#       self[(key.to_sym rescue key) || key] = delete(key) if value.present?
#     end
#   end

#   def compact!
#     self.delete_if { |_, v| v.blank? }
#   end

#   def deep_compact!
#     self.select! do |key, value|
#       key.deep_compact! if value.is_a?(Hash)
#       value.present?
#     end
#   end
# end


module BootstrapHelper

  class Dropdown < AbstractComponent

    def manage_args(*args)
      @anchor = ActiveSupport::SafeBuffer.new
      @body = ActiveSupport::SafeBuffer.new
      options = args.extract_options!
      text = args.first

      anchor(text, *[options]) if text
    end

    def anchor(*args, &block)
      opts = args.extract_options!.symbolize_keys.delete_if { |_, v| v.blank? }
      text = args.first

      id = opts.delete(:id)
      classes = associate_css_class(opts.delete(:classes), :btn, 'dropdown-toggle')

      buffer = block_given? ? view.capture(&block) : text

      @anchor += content_tag(:button, buffer, class: classes, id: id, data: { toggle: :dropdown }) #FIXME : Manage data (merge)
      nil
    end

    # Extend array. Dans une lib call utility_rails_refine
    # def manage_options!(deep: true, merge: {})
    #   args.extract_options!.symbolize_keys!.delete_if { |_, v| v.blank? }
    # end
    # associate_css_class -> arrayfy
    def item(*args, &block)
      opts = args.extract_options!.symbolize_keys.delete_if { |_, v| v.blank? }

      id = opts.delete(:id)
      header  = !!opts.delete(:header)
      divider = !!opts.delete(:divider)

      classes = associate_css_class(opts.delete(:classes),
        ('dropdown-header' if header                ),
        (:disabled         if opts.delete(:disable) ),
        (:divider          if divider               )
        )

      buffer = if block_given?
        view.capture(&block)
      elsif header
        args.first # Default text
      elsif divider
        nil
      else
        link_to(*(args+[opts]))
      end

      @body += content_tag(:li, buffer, class: classes, id: id)
      nil
    end

    def header(text)
      item(text, header: true)
    end

    def divider
      item(divider: true)
    end

    def render
      content = ActiveSupport::SafeBuffer.new
      content << @anchor
      content << content_tag(:ul, @body, class: 'dropdown-menu')
      content_tag(:div, content, class: 'dropdown')
    end
  end

end