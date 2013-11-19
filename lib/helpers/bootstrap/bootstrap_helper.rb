require 'css_utility'
require 'helpers/bootstrap/dropdown'
# This module provide a set of helper designed for bootstrap 3

module BootstrapHelper
  include CssUtility

  ICON_PREFIX = :glyphicon

  # Renders an icon
  #
  # Example :
  # = bsh_icon 'exclamation-sign'
  #
  # Arguments :
  # * +name+    :  The +name+ of the icon. In bootstrap or font-awsome for exemple.
  # * +id+      :  The +id=+ for the container tag.
  # * +classes+ :  The +classes=+ for the container tag.
  # * +tag+     :  The +tag=+ of the container. Default is 'i'
  # * +data+    :  Pass some html5 data to the container tag.
  #
  # You can also pass a block and code will be inserted into the container tag:
  def bsh_icon(name, id: nil, classes: [], tag: :span, data: nil)
    classes = associate_css_class(classes, ICON_PREFIX,"#{ICON_PREFIX}-#{name}")
    content_tag(tag, id: id, class: classes, data: data) do
      yield if block_given?
    end
  end

  def bsh_dropdown(*args, &block)
    Dropdown.new(self, *args, &block).render
  end

end