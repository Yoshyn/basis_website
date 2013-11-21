require 'helpers/bootstrap/abstract_component'

module BootstrapHelper

  class Dropdown < AbstractComponent
    using TinyRafine::Array
    using TinyRafine::NilClass

    def manage_args(*args)
      @anchor = ActiveSupport::SafeBuffer.new
      @body = ActiveSupport::SafeBuffer.new
      options = args.extract_options!
      text = args.first

      anchor(text, *[options]) if text
    end

    def anchor(*args, &block)
      opts    = args.manage_options!
      text    = args.first
      id      = opts.delete(:id)
      classes = merge_to_a(opts.delete(:classes), :btn, 'dropdown-toggle')
      data    = { toggle: :dropdown }.reverse_merge!(opts.delete(:data) || {}) #FIXME See nil class

      buffer = block_given? ? view.capture(&block) : text

      @anchor += content_tag(:button, buffer, class: classes, id: id, data: data)
      nil
    end

    def item(*args, &block)
      opts      = args.manage_options!
      id        = opts.delete(:id)
      header    = 'dropdown-header' if !!opts.delete(:header)
      disabled  = :disabled         if !!opts.delete(:disable)
      divider   = :divider          if !!opts.delete(:divider)
      classes = merge_to_a(opts.delete(:classes), header, disabled, divider)

      buffer = if block_given?
        view.capture(&block)
      elsif header
        args.first # Default text
      elsif divider
        nil
      else
        link_to(*(args+[opts])) #FIXME : is there a better way to manage this?
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