
# This module provide a set of helper designed for bootstrap 3

require 'tiny_rafine/tiny_rafine'
require 'helpers/bootstrap/dropdown'

module BootstrapHelper
  include TinyMethods

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
  # You can also pass a block and code will be inserted into the container tag
  def bsh_icon(name, id: nil, classes: [], tag: :span, data: nil)
    classes = merge_to_a(classes, ICON_PREFIX,"#{ICON_PREFIX}-#{name}")
    content_tag(tag, id: id, class: classes, data: data) do
      yield if block_given?
    end
  end

  # Renders a dropdown menu icon. Use function of Dropdown classes
  # The block take the Dropdown object in parameter
  #
  # Examples :
  # = bsh_dropdown("My anchor", ul_classes: :foo) do |dj|
  #   = dj.header("Dropdown header")
  #   = dj.item("Disabled link", "#", data: { test: true} )
  #   = dj.item("Link 2 (disable)", "#", disable: true)
  #   = dj.item("Another action", "#", classes: :test)
  #   = dj.divider
  #   = dj.header("Dropdown header2")
  #   = dj.item(id: "block_item") do
  #     %div.text-primary
  #       Separated item (generate by a block)
  #
  # = bsh_dropdown do |dj|
  #   = dj.anchor("Dropdown", classes: 'btn-default') do
  #     %span.caret
  #   = dj.item("Dropdown link", "#")
  #   = dj.item("Dropdown link", "#")
  #
  # Arguments :
  # See Dropdown@manage_args
  #
  def bsh_dropdown(*args, &block)
    Dropdown.new(self, *args, &block).send(:render)
  end

end