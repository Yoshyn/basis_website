require 'helpers/bootstrap/abstract_component'

module BootstrapHelper

  class Dropdown < AbstractComponent
    using TinyRafine::Array
    using TinyRafine::NilClass

    def manage_args(*args)
      @anchor     = ActiveSupport::SafeBuffer.new
      @items      = ActiveSupport::SafeBuffer.new
      opts        = args.extract_options!
      @ul_classes = merge_to_a(opts.delete(:ul_classes), 'dropdown-menu')
      text        = args.first

      anchor(text, *[opts]) if text
    end

    # This call overload anotheir anchor.
    def anchor(*args, &block)
      opts    = args.manage_options!
      text    = ActiveSupport::SafeBuffer.new(args.first || '') # Create a SafeBuffer and store the first args if exist
      id      = opts.delete(:id)
      classes = merge_to_a(opts.delete(:classes), :btn, 'dropdown-toggle') #FIXMEBUTTON
      data    = (opts.delete(:data) || {} ).merge!({ toggle: :dropdown })

      buffer = text
      buffer += view.capture(&block) if block_given?

      @anchor = content_tag(:button, buffer, class: classes, id: id, data: data)
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
        link_to(*args.push(opts))
      end

      @items += content_tag(:li, buffer, class: classes, id: id)
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
      content << content_tag(:ul, @items, class: @ul_classes)
      content_tag(:div, content, class: 'dropdown')
    end
  end
end