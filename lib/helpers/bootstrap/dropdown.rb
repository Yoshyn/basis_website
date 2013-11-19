module BootstrapHelper

  class Dropdown < Struct.new(:view, :callback)
    include CssUtility

    delegate :content_tag, to: :view
    delegate :capture, to: :view
    delegate :link_to, to: :view
    delegate :capture, to: :view

    def initialize(view, *args, &block)
      super(*[view, block])
      manage_args(*args)
      @header = ActiveSupport::SafeBuffer.new
      @body = ActiveSupport::SafeBuffer.new
      instance_exec(self, &callback)
    end

    def manage_args(id: nil, classes: [], text: nil, tag: :button, data: nil)
      # menu_anchor() if text
    end

    def menu_anchor(id: nil, classes: [], text: nil, tag: :button, data: nil)
      classes = associate_css_class(classes, 'btn', 'dropdown-toggle')

      buffer = (block_given?) ? capture(&block) : text
      @header = content_tag(tag, buffer, class: classes, id: id, data: {toggle: :dropdown} )
    end

    def menu_item(id: nil, classes: [], header: false, disable: false)
      buffer = (block_given?) ? capture(&block) : ""
      @body += content_tag(:li, buffer, class: classes, id: id)
    end

    def menu_item(name, url, id: nil, classes: [])
      @body += content_tag(:li, link_to(name, url, tabindex: "-1"), class: classes, id: id)
    end

    def render
      content = ActiveSupport::SafeBuffer.new
      content << @header
      content << content_tag(:ul, @body, class: 'dropdown-menu')
      content_tag(:div, content, class: 'dropdown')
    end
  end

end