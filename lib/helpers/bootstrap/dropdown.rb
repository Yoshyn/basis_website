require 'helpers/bootstrap/abstract_component'

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