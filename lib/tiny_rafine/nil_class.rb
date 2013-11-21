module TinyRafine
  module NilClass

    refine ::NilClass do
      def method_missing(method_name, *args)
        nil
      end

      # Define a redirection from implicit to explicit conversion for Integer, String, Array and Hash
      ['int', 'str', 'hash'].each do |method| #FIXMEFAIL 'ary'
        define_method "to_#{method}" do
          send "to_#{method[0]}"
        end
      end
    end

  end
end

