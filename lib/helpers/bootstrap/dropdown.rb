require 'helpers/bootstrap/abstract_component'

module BootstrapHelper

  # Dropdown classe is a parser for bootstrap dropdown.
  # It make possible the bsh_dropdown helper function.
  # It manage the function (anchor, item...) and the rendering of the html
  class Dropdown < AbstractComponent
    using TinyRafine::Array

    # Initialize the Dropdown. Will call anchor method.
    # Except ul_classes and container, arguments are redirected to the anchor method.
    #
    # Arguments :
    # * +ul_classes+  :  Classes that can be added to the ul element
    # * +container+   :  Set +container+ flags to false if you don't want generate the .dropdown container.
    #                    Notice that in this case you have to manage a relative container yourself.
    def manage_args(*args)
      @anchor     = ActiveSupport::SafeBuffer.new
      @items      = ActiveSupport::SafeBuffer.new
      opts        = args.extract_options!
      @ul_classes = merge_to_a(opts.delete(:ul_classes), 'dropdown-menu')
      @container  = !opts.has_key?(:container) || !!opts.delete(:container)
      text        = args.first

      anchor(text, *[opts]) if text
    end

    # Set an anchor to the dropdown object.
    #
    # Examples :
    #  > anchor("Dropdown", tag: :a)
    #  > anchor("Dropdown") do
    #      %span.caret
    #  > anchor do
    #      Dropdown
    #      %span.caret
    #
    # Arguments :
    # * +text+    :  The +text+ of the dropdown anchor.
    # * +id+      :  The +id=+ for the anchor tag.
    # * +classes+ :  The +classes=+ for the anchor tag.
    # * +tag+     :  The +tag=+ of the anchor. Default is 'button'
    # * +data+    :  Pass some html5 data to the anchor tag.
    #
    # If you call this block, it will erase all other anchor call.
    def anchor(*args, &block)
      opts    = args.manage_options!
      tag     = opts.delete(:tag) || :button
      id      = opts.delete(:id)
      classes = merge_to_a(opts.delete(:classes), 'dropdown-toggle')
      classes << :btn if tag == :button
      data    = (opts.delete(:data) || {} ).merge!({ toggle: :dropdown })
      # Create a SafeBuffer and store the text (first args) if exist
      text    = ActiveSupport::SafeBuffer.new(args.first || '')

      buffer = text
      buffer += view.capture(&block) if block_given?

      @anchor = content_tag(tag, buffer, class: classes, id: id, data: data)
      nil
    end

    # Add an item to the dropdown object.
    # If you want custom html, give a block.
    # If you want create a dropdown header, the title will be the first args.
    # else, a link_to will be call with the unused functions params.
    #
    # Examples :
    #  > item("Link", "#", data: { test: true} )
    #  > item("Link (disable)", "#", disable: true)
    #  > item(id: "block_item") do
    #      %div.text-primary
    #        Item render by a block
    #
    # Arguments :
    # * +text+    :  The +text+ of the link item.
    # * +id+      :  The +id=+ for the link tag.
    # * +classes+ :  The +classes=+ for the link tag.
    # * +data+    :  Pass some html5 data to the link tag.
    # * +header+  :  Set +header=+ flags to mark the item as header.
    # * +disable+ :  Set +disable=+ flags to mark the item as disable.
    # * +divider+ :  Set +divider=+ flags to mark the item as divider.
    #
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

    # Set an header to the dropdown object.
    #
    # Examples :
    #  > header("Header")
    #
    # Arguments :
    # * +text+    :  The +text+ of the dropdown anchor.
    # * +id+      :  The +id=+ for the anchor tag.
    # * +classes+ :  The +classes=+ for the anchor tag.
    # * +data+    :  Pass some html5 data to the anchor tag.
    def header(text, id: nil, classes: [], data: nil)
      item(text, header: true, id: id, classes: classes, data: data)
    end

    # Set an header to the dropdown object
    #
    # Examples :
    #  > divider
    #
    # Arguments :
    # * +id+      :  The +id=+ for the anchor tag.
    # * +classes+ :  The +classes=+ for the anchor tag.
    # * +data+    :  Pass some html5 data to the anchor tag.
    def divider(id: nil, classes: [], data: nil)
      item(divider: true, id: id, classes: classes, data: data)
    end

  private

    # Render the dropdown html.
    def render
      content = ActiveSupport::SafeBuffer.new
      content << @anchor
      content << content_tag(:ul, @items, class: @ul_classes)
      if @container
        content_tag(:div, content, class: :dropdown)
      else
        content
      end
    end
  end
end