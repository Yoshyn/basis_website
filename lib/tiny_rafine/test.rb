# REMINDER :
# def name({required_arguments, ...}
#          {optional_arguments, ...}
#          {*rest || additional_required_arguments...} # Did you know?
#          {keyword_arguments: "with_defaults"...}
#          {**rest_of_keyword_arguments}
#          {&block_capture})

module TinyRafineTest
  using TinyRafine
  puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.compact!.to_json)
  puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.deep_compact!.to_json)
  puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.symbolize_keys_and_compact!.to_json)
  puts({ 'k1' => :v, 'k2' => nil, 'k3' => [], 'k4' => { 'k41' => [:va41, :va2], 'k42' => { 'k421' => nil , 'k422' => :v422 } }}.deep_symbolize_keys_and_compact!.to_json)

  puts(['a',2,:b, [:c,:d], { k1: :v1, k2: :v2 }, { k1: [:va1, :va2], k2: { :v2 => [:va, :va2] , v2: :vv2, v3: nil} }].manage_options!.to_json)
  puts(['a',2,:b, [:c,:d], { k1: :v1, k2: :v2 }, { k1: [:va1, :va2], k2: { :v2 => [:va, :va2] , v2: :vv2, v3: nil} }].deep_manage_options!.to_json)
end
