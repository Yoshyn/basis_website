require 'tiny_rafine/array'
require 'tiny_rafine/hash'
require 'tiny_rafine/nil_class'

# TIny methos will be a set of methods that can be usefull
module TinyMethods

  raise "TinyMethods module is designed to be include in Rails context. It's seem that Rails is not defined." unless defined?(Rails)

  # The purpose of this function is to return an array. nil element are be reject
  #
  # Example :
  #   merge_to_a ['object1'], "object2", :object3       => ["object1", "object2", :object3]
  #   merge_to_a 'object1', "object2", :object3         => ["object1", "object2", :object3]
  #   merge_to_a :object1, nil, :object3                => ["object1", :object3]
  #   merge_to_a nil, "object2", :object3               => ["object2", :object3]
  #
  # Arguments :
  # * +object+  :  An ruby +object+ (Array, String of symbol...).
  #                If the object is not an Array. The object will be transform into string (to_s) and will be split on space.
  # * +args+    :  List of arguments that will be add to the result array in string
  def merge_to_a(object, *args)
    ((object.is_a?(::Array) ? object : object.to_s.split(/\s+/)) + args ).compact
  end
end