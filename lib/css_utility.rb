# This module provide a set of function that can be usefull to manage css in helper

module CssUtility

private
  # This function return an array of class.
  #
  # Example :
  #   associate_css_class ['class1'], "class2", :class3
  #   associate_css_class 'class1', "class2", :class3
  #   associate_css_class :class1, "class2", :class3
  #
  # Arguments :
  # * +classes+ :  The +classes+ initial classes element (Array, String of symbol).
  # * +args+    :  List of arguments that will be add to the result array in string
  def associate_css_class(classes, *args)
    ((classes.is_a?(Array) ? (classes || []) : classes.to_s.split(/\s+/)) + args ).compact
  end

end