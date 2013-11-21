# REMINDER :
# def name({required_arguments, ...}
#          {optional_arguments, ...}
#          {*rest || additional_required_arguments...} # Did you know?
#          {keyword_arguments: "with_defaults"...}
#          {**rest_of_keyword_arguments}
#          {&block_capture})

# module TinyRafineTest
#   using TinyRafine
#   puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.compact!.to_json)
#   puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.deep_compact!.to_json)
#   puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.symbolize_keys_and_compact!.to_json)
#   puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.deep_symbolize_keys_and_compact!.to_json)

#   puts(['a',2,:b, [:c,:d], { k1: :v1, k2: :v2 }, { k1: [:va1, :va2], k2: { :v2 => [:va, :va2] , v2: :vv2, v3: nil} }].manage_options!.to_json)
#   puts(['a',2,:b, [:c,:d], { k1: :v1, k2: :v2 }, { k1: [:va1, :va2], k2: { :v2 => [:va, :va2] , v2: :vv2, v3: nil} }].deep_manage_options!.to_json)
# end

require 'tiny_rafine/array'
require 'tiny_rafine/hash'
require 'tiny_rafine/nil_class'

module TinyMethods

  raise "TinyRafine module is designed to be include in Rails context. It's seem that Rails is not defined." unless defined?(Rails)

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