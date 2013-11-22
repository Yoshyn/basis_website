require 'tiny_rafine/tiny_rafine'

# This module provide a set of helper designed for FontAwsome 4

module FontawsomeHelper
  include TinyMethods

  ICON_PREFIX = :fa

  # Renders an icon
  #
  # Example :
  # = fah_icon :linux, border: true, rotate: 90
  #
  # Arguments :
  # * +name+    :  The +name+ of the icon. In bootstrap or font-awsome for exemple.
  # * +id+      :  The +id=+ for the container tag.
  # * +classes+ :  The +classes=+ for the container tag. For exemple, some custom classes serve by FontAwsome (fontawesome.io/examples):
  #                -> Size       : From 1.33 to 5 => fa-1g (fa-2x.. fa-5x)
  #                -> FixedWidth : fa-fw
  #                -> List       : fa-ul fa-li
  #                -> position   : pull-right, pull-left
  # * +border+  :  Set +border=+ flags to true to have a border
  # * +spin+    :  Set +spin=+ flags to true to make spin the icon
  # * +rotate+  :  Set +rotate=+ to rotate the icon. Possible values are 90, 180 and 270
  # * +flip+    :  Set +flip=+ to flip the icon. Possible values are horizontal or vertical.
  # * +inverse+ :  +inverse=+ flags can be used as an alternative icon color.
  # * +data+    :  Pass some html5 data to the container tag.
  #
  # You can also pass a block and code will be inserted into the container tag:
  def fah_icon(name, id: nil, classes: [], tag: :i, border: nil, spin: nil, rotate: nil, flip: nil, inverse: nil, data: nil )

    classes = merge_to_a(classes, ICON_PREFIX, "#{ICON_PREFIX}-#{name}",
       ("#{ICON_PREFIX}-border"            if border ),
       ("#{ICON_PREFIX}-spin"              if spin   ),
       ("#{ICON_PREFIX}-rotate-#{rotate}"  if rotate ),
       ("#{ICON_PREFIX}-flip-#{flip}"      if flip),
       ("#{ICON_PREFIX}-inverse"           if inverse) )

    content_tag(tag, id: id, class: classes, data: data) do
      yield if block_given?
    end
  end

  # Renders a stacked icon.
  #
  # Example :
  # = fah_stacked_icon(:camera, :ban, classes: { container: 'fa-lg', stacked: 'text-danger'} )
  #
  # Arguments :
  # * +under_name+    :  The +under_name+ of the under icon.
  # * +stacked_name+  :  The +stacked_name+ of the under icon.
  # * +id+            :  The +id=+ for the container tag.
  # * +classes+       :  The +classes=+ for the stacked item. It have to be an hash. Key of the hash can be :
  #                      -> container : Can contain the container classes
  #                      -> under     : Can contain the classes for the under icon image tag.
  #                      -> stacked   : Can contain the classes for the stacked icon image tag.
  #                      Sample :
  #                      -> { container: 'fa-lg', stacked: 'text-danger' }
  #                      -> { stacked: 'class1', under: ['class2', 'class3'] }
  # * +data+          :  Pass some html5 data to the container tag.
  def fah_stacked_icon(under_name, stacked_name, id: nil, classes: {}, data: nil)
    stack_class = "#{ICON_PREFIX}-stack"

    cnt_classes = merge_to_a(classes.delete(:container), stack_class)
    content_tag(:span, id: id, class: cnt_classes, data: data) do
      concat( fah_icon( under_name,   classes: merge_to_a(classes.delete(:under),   "#{stack_class}-1x") ) )
      concat( fah_icon( stacked_name, classes: merge_to_a(classes.delete(:stacked), "#{stack_class}-2x") ) )
    end
  end
end